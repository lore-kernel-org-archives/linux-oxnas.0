Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [91.198.250.253])
 by mx.groups.io with SMTP id smtpd.web10.1080.1584555629038016155
 for <linux-oxnas@groups.io>;
 Wed, 18 Mar 2020 11:20:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gorani.run; s=MBO0001;
	t=1584555625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O7m4lvrIqRs2bqX0fJ398lumr7Ad9ngJFhRhZgfuKUA=;
	b=h5ay3Dk8OATxLJQjj+ENRkkXBjclmZmucQCN6amcMPzC/kCrPcz++Ro4l6OKO+wETezw8E
	wm/LEL5Jq8uf24RZWv5i3rWLZyq4CIND+trc+fWbteI/jzEhhZhZW55HlhuiAmYIrunFUl
	2eVB4rraD9m2oK6edmXFCq4UrrUASgI9X84v68i+pwIfJADMJI8IpxLCVieUUzCTQU9Fdb
	wZJiNSdC9Dp4kUUWWcPRb0fmjgzaGpN1JdQ1C/Sz8xZGO3z5vTBZ76IqqwDN8vNq3Dbji6
	mBKvJC1lR8O1LI9YPjkV8Ut2kBtDEHjbhfC28j7rSwrQTYVI+sU3DGi/mmZIvQ==
Subject: Re: [PATCH] irqchip/versatile-fpga: Handle chained IRQs properly
References: <20200318170904.1461278-1-mans0n@gorani.run>
 <112cdab389aa9cc30189c7aec0baded2@kernel.org>
From: Sungbo Eo <mans0n@gorani.run>
Message-ID: <bdb90bd8-ede1-63d5-816c-57f6bf0417a4@gorani.run>
Date: Thu, 19 Mar 2020 03:20:13 +0900
MIME-Version: 1.0
In-Reply-To: <112cdab389aa9cc30189c7aec0baded2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: Marc Zyngier <maz@kernel.org>
Cc: linux-oxnas@groups.io, Linus Walleij <linus.walleij@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <linux-oxnas@groups.io>

Hi Marc,

On 2020-03-19 02:48, Marc Zyngier wrote:
> Hi Sungbo,
>=20
> On 2020-03-18 17:09, Sungbo Eo wrote:
>> Enclose the chained handler with chained_irq_{enter,exit}(), so that t=
he
>> muxed interrupts get properly acked.
>>
>> This patch also fixes a reboot bug on OX820 SoC, where the jiffies tim=
er
>> interrupt is never acked. The kernel waits a clock tick forever in
>> calibrate_delay_converge(), which leads to a boot hang.
>=20
> Nice catch.
>=20
>>
>> Signed-off-by: Sungbo Eo <mans0n@gorani.run>
>> Cc: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>> =C2=A0drivers/irqchip/irq-versatile-fpga.c | 9 ++++++++-
>> =C2=A01 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/irqchip/irq-versatile-fpga.c
>> b/drivers/irqchip/irq-versatile-fpga.c
>> index 928858dada75..08faab2fec3e 100644
>> --- a/drivers/irqchip/irq-versatile-fpga.c
>> +++ b/drivers/irqchip/irq-versatile-fpga.c
>> @@ -6,6 +6,7 @@
>> =C2=A0#include <linux/irq.h>
>> =C2=A0#include <linux/io.h>
>> =C2=A0#include <linux/irqchip.h>
>> +#include <linux/irqchip/chained_irq.h>
>> =C2=A0#include <linux/irqchip/versatile-fpga.h>
>> =C2=A0#include <linux/irqdomain.h>
>> =C2=A0#include <linux/module.h>
>> @@ -68,12 +69,15 @@ static void fpga_irq_unmask(struct irq_data *d)
>>
>> =C2=A0static void fpga_irq_handle(struct irq_desc *desc)
>> =C2=A0{
>> +=C2=A0=C2=A0=C2=A0 struct irq_chip *chip =3D irq_desc_get_chip(desc);
>> =C2=A0=C2=A0=C2=A0=C2=A0 struct fpga_irq_data *f =3D irq_desc_get_hand=
ler_data(desc);
>> =C2=A0=C2=A0=C2=A0=C2=A0 u32 status =3D readl(f->base + IRQ_STATUS);
>>
>> +=C2=A0=C2=A0=C2=A0 chained_irq_enter(chip, desc);
>> +
>=20
> It's probably not a big deal, but I'm not fond of starting talking to
> the muxing irqchip before having done the chained_irq_enter() call.
>=20
> Moving that read here would probably be safer.

Oops, I missed it. Thanks for pointing it out.

>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0 if (status =3D=3D 0) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do_bad_IRQ(desc);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>> =C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 do {
>> @@ -82,6 +86,9 @@ static void fpga_irq_handle(struct irq_desc *desc)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status &=3D ~(1 << ir=
q);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 generic_handle_irq(ir=
q_find_mapping(f->domain, irq));
>> =C2=A0=C2=A0=C2=A0=C2=A0 } while (status);
>> +
>> +out:
>> +=C2=A0=C2=A0=C2=A0 chained_irq_exit(chip, desc);
>> =C2=A0}
>>
>> =C2=A0/*
>=20
> Otherwise looks good. If you send it again with the above fixed
> and a Fixes: tag, I'll queue it.

It seems the handler had been broken from the very beginning. Could you=20
give me a hint on how the tag should be like?

Thanks.

>=20
> Thanks,
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 M.
