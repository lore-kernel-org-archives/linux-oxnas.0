Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mx.groups.io with SMTP id smtpd.web10.8166.1584799504197914387
 for <linux-oxnas@groups.io>;
 Sat, 21 Mar 2020 07:05:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584799503;
	bh=2LYqxlJLALkKFlpvVEGc+tjKLuBtfj/ozo9eACQKvaw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Viee7yhYqu5DhM3KRxgC7BOYKsHKq2eVJ3mZWlwBmROgY//CXPk6aiRd+kdVMPlfl
	 bQWwtGOskyltOReYv3sK1c/ZZ+aZUm6WpLLUcOluQJk0uRVtwhvRmNZh9V71h0QrpB
	 8bzoBozpXhJ/VbzRA7/M2wjTBafP9GpHyylNWXUw=
MIME-Version: 1.0
Date: Sat, 21 Mar 2020 14:05:01 +0000
From: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] irqchip/versatile-fpga: Apply clear-mask earlier
In-Reply-To: <20200321133842.2408823-1-mans0n@gorani.run>
References: <20200321133842.2408823-1-mans0n@gorani.run>
Message-ID: <4c8b67a7912b2863db99ff4e765fdb8b@kernel.org>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
To: Sungbo Eo <mans0n@gorani.run>
Cc: linux-oxnas@groups.io, Linus Walleij <linus.walleij@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>, Daniel Golle <daniel@makrotopia.org>
List-ID: <linux-oxnas@groups.io>

On 2020-03-21 13:38, Sungbo Eo wrote:
> Clear its own IRQs before the parent IRQ get enabled, so that the
> remaining IRQs do not accidentally interrupt the parent IRQ controller.
> 
> This patch also fixes a reboot bug on OX820 SoC, where the remaining
> rps-timer IRQ raises a GIC interrupt that is left pending. After that,
> the rps-timer IRQ is cleared during driver initialization, and there's
> no IRQ left in rps-irq when local_irq_enable() is called, which evokes
> an error message "unexpected IRQ trap".
> 
> Fixes: bdd272cbb97a ("irqchip: versatile FPGA: support cascaded
> interrupts from DT")
> Signed-off-by: Sungbo Eo <mans0n@gorani.run>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/irqchip/irq-versatile-fpga.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-versatile-fpga.c
> b/drivers/irqchip/irq-versatile-fpga.c
> index 70e2cfff8175..f1386733d3bc 100644
> --- a/drivers/irqchip/irq-versatile-fpga.c
> +++ b/drivers/irqchip/irq-versatile-fpga.c
> @@ -212,6 +212,9 @@ int __init fpga_irq_of_init(struct device_node 
> *node,
>  	if (of_property_read_u32(node, "valid-mask", &valid_mask))
>  		valid_mask = 0;
> 
> +	writel(clear_mask, base + IRQ_ENABLE_CLEAR);
> +	writel(clear_mask, base + FIQ_ENABLE_CLEAR);
> +
>  	/* Some chips are cascaded from a parent IRQ */
>  	parent_irq = irq_of_parse_and_map(node, 0);
>  	if (!parent_irq) {
> @@ -221,9 +224,6 @@ int __init fpga_irq_of_init(struct device_node 
> *node,
> 
>  	fpga_irq_init(base, node->name, 0, parent_irq, valid_mask, node);
> 
> -	writel(clear_mask, base + IRQ_ENABLE_CLEAR);
> -	writel(clear_mask, base + FIQ_ENABLE_CLEAR);
> -
>  	/*
>  	 * On Versatile AB/PB, some secondary interrupts have a direct
>  	 * pass-thru to the primary controller for IRQs 20 and 22-31 which 
> need

You're on a roll! ;-) Queued for 5.7.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
