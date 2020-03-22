Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mx.groups.io with SMTP id smtpd.web12.27488.1584877871880952753
 for <linux-oxnas@groups.io>;
 Sun, 22 Mar 2020 04:51:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584877871;
	bh=4L+US9oyt6r1I7CpRdSaSOrHJKplo8D3RFAXhA3hdMo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R0BqIzrd/qCI/exH8dYpR45RGV/pyISkZIgqN7y2yAXCqvYqhd8Vf/qEKtoxxD0VO
	 HcJciWvxoDtlyvS9WwhU6zu6Q1GxV5/58aTbT8GWbIn+CXbBQ5hP7iqrjWWgQhR7Zt
	 bLXMWyxFZcJRkFdeVFgNmDJxl8quAtU6aW2ZalJY=
MIME-Version: 1.0
Date: Sun, 22 Mar 2020 11:51:09 +0000
From: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] irqchip/versatile-fpga: Apply clear-mask earlier
In-Reply-To: <CACRpkdYvoVF_q1Re_v_sJCYVDOhte0NpdU91UtYB2SpHH60-jg@mail.gmail.com>
References: <20200321133842.2408823-1-mans0n@gorani.run>
 <CACRpkdYvoVF_q1Re_v_sJCYVDOhte0NpdU91UtYB2SpHH60-jg@mail.gmail.com>
Message-ID: <b333772bbc3037c47060cf1af1fff3e8@kernel.org>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Sungbo Eo <mans0n@gorani.run>, linux-oxnas@groups.io, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-kernel@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>, Daniel Golle <daniel@makrotopia.org>
List-ID: <linux-oxnas@groups.io>

On 2020-03-22 11:45, Linus Walleij wrote:
> On Sat, Mar 21, 2020 at 2:40 PM Sungbo Eo <mans0n@gorani.run> wrote:
> 
>> Clear its own IRQs before the parent IRQ get enabled, so that the
>> remaining IRQs do not accidentally interrupt the parent IRQ 
>> controller.
>> 
>> This patch also fixes a reboot bug on OX820 SoC, where the remaining
>> rps-timer IRQ raises a GIC interrupt that is left pending. After that,
>> the rps-timer IRQ is cleared during driver initialization, and there's
>> no IRQ left in rps-irq when local_irq_enable() is called, which evokes
>> an error message "unexpected IRQ trap".
>> 
>> Fixes: bdd272cbb97a ("irqchip: versatile FPGA: support cascaded 
>> interrupts from DT")
>> Signed-off-by: Sungbo Eo <mans0n@gorani.run>
>> Cc: Neil Armstrong <narmstrong@baylibre.com>
>> Cc: Daniel Golle <daniel@makrotopia.org>
> 
> Good catch!
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Marc: Cc stable?

Sure, I'll add that.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
