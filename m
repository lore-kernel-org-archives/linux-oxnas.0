Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mx.groups.io with SMTP id smtpd.web11.265.1584553689294099754
 for <linux-oxnas@groups.io>;
 Wed, 18 Mar 2020 10:48:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584553688;
	bh=nIRM+WY3P5vmQLvcggYZkzjwW+uq3nchuZAFnsr2gLY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=z2hysmjLTxToxZUAsYP5vyO0cdtXwbm0WB6Hl6cgzLv3k8l0WarkYNMKFynv6FLGk
	 JUru6IgeSJOZhqP5ir8e9kZrVXlgz3wG07V/yYMI9KmgtYxAS+ECM9O2a8WdhAMCC/
	 UKcnQM2rCMOf9pYvpZsAEEwZkxfPZ+vNxBtFaDOI=
MIME-Version: 1.0
Date: Wed, 18 Mar 2020 17:48:06 +0000
From: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] irqchip/versatile-fpga: Handle chained IRQs properly
In-Reply-To: <20200318170904.1461278-1-mans0n@gorani.run>
References: <20200318170904.1461278-1-mans0n@gorani.run>
Message-ID: <112cdab389aa9cc30189c7aec0baded2@kernel.org>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
To: Sungbo Eo <mans0n@gorani.run>
Cc: linux-oxnas@groups.io, Linus Walleij <linus.walleij@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <linux-oxnas@groups.io>

Hi Sungbo,

On 2020-03-18 17:09, Sungbo Eo wrote:
> Enclose the chained handler with chained_irq_{enter,exit}(), so that 
> the
> muxed interrupts get properly acked.
> 
> This patch also fixes a reboot bug on OX820 SoC, where the jiffies 
> timer
> interrupt is never acked. The kernel waits a clock tick forever in
> calibrate_delay_converge(), which leads to a boot hang.

Nice catch.

> 
> Signed-off-by: Sungbo Eo <mans0n@gorani.run>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/irqchip/irq-versatile-fpga.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-versatile-fpga.c
> b/drivers/irqchip/irq-versatile-fpga.c
> index 928858dada75..08faab2fec3e 100644
> --- a/drivers/irqchip/irq-versatile-fpga.c
> +++ b/drivers/irqchip/irq-versatile-fpga.c
> @@ -6,6 +6,7 @@
>  #include <linux/irq.h>
>  #include <linux/io.h>
>  #include <linux/irqchip.h>
> +#include <linux/irqchip/chained_irq.h>
>  #include <linux/irqchip/versatile-fpga.h>
>  #include <linux/irqdomain.h>
>  #include <linux/module.h>
> @@ -68,12 +69,15 @@ static void fpga_irq_unmask(struct irq_data *d)
> 
>  static void fpga_irq_handle(struct irq_desc *desc)
>  {
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
>  	struct fpga_irq_data *f = irq_desc_get_handler_data(desc);
>  	u32 status = readl(f->base + IRQ_STATUS);
> 
> +	chained_irq_enter(chip, desc);
> +

It's probably not a big deal, but I'm not fond of starting talking to
the muxing irqchip before having done the chained_irq_enter() call.

Moving that read here would probably be safer.

>  	if (status == 0) {
>  		do_bad_IRQ(desc);
> -		return;
> +		goto out;
>  	}
> 
>  	do {
> @@ -82,6 +86,9 @@ static void fpga_irq_handle(struct irq_desc *desc)
>  		status &= ~(1 << irq);
>  		generic_handle_irq(irq_find_mapping(f->domain, irq));
>  	} while (status);
> +
> +out:
> +	chained_irq_exit(chip, desc);
>  }
> 
>  /*

Otherwise looks good. If you send it again with the above fixed
and a Fixes: tag, I'll queue it.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
