Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mx.groups.io with SMTP id smtpd.web11.7814.1584607501045614589
 for <linux-oxnas@groups.io>;
 Thu, 19 Mar 2020 01:45:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584607500;
	bh=nsLp4Rn/WbNgg5c0efrndSO2d36JwaT+wQJoqmu5/SA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rf6u2PFmQqWvwY1WKpZe255t6/NQBguN0WrcCWUMycs3Keq2eiQSpMPlRJ9m4wGPW
	 D9gF1iZzqBJ9KxJhaOg3VrMZxn58ybEA/Cq8b+OX/He/2rZLpAfZrQWm+Co8RbTj+6
	 QHy5OK5sHF9g1b0Fp66Nsw3p+Qi+iWNLXSMYaxO8=
MIME-Version: 1.0
Date: Thu, 19 Mar 2020 08:44:58 +0000
From: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2] irqchip/versatile-fpga: Handle chained IRQs properly
In-Reply-To: <20200319023448.1479701-1-mans0n@gorani.run>
References: <002b72cab9896fa5ac76a52e0cb503ff@kernel.org>
 <20200319023448.1479701-1-mans0n@gorani.run>
Message-ID: <f0a4acfaf5da72cbfc2670fcb5b71fc6@kernel.org>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
To: Sungbo Eo <mans0n@gorani.run>
Cc: Linus Walleij <linus.walleij@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-oxnas@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <linux-oxnas@groups.io>

On 2020-03-19 02:34, Sungbo Eo wrote:
> Enclose the chained handler with chained_irq_{enter,exit}(), so that 
> the
> muxed interrupts get properly acked.
> 
> This patch also fixes a reboot bug on OX820 SoC, where the jiffies 
> timer
> interrupt is never acked. The kernel waits a clock tick forever in
> calibrate_delay_converge(), which leads to a boot hang.
> 
> Fixes: c41b16f8c9d9 ("ARM: integrator/versatile: consolidate FPGA IRQ
> handling code")
> Signed-off-by: Sungbo Eo <mans0n@gorani.run>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> ---
> v2: moved readl below chained_irq_enter()
>     added Fixes tag
> 
>  drivers/irqchip/irq-versatile-fpga.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

Queued for 5.7.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
