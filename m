Received: by mail-wm1-f66.google.com with SMTP id g67so2325239wmd.2
        for <linux-oxnas@groups.io>; Thu, 20 Dec 2018 06:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=JIxIFoeGjsKtNVE23FzL8DydGYZeNS0ljgI025CltDY=;
        b=bCX/UpUcLdy/iwQmPAHFdH/PHL/hGZnQe8b5S2+Amle+PmlSWOetnxtdkcW3oJMVCC
         3EqGwhkZETq5oe5vzYoA/qti++NVPYNxXKnWXS8SnZENAg/bBy6P1gHFq5hZy/ynFeD0
         cqnbXP+RXX+gv5Yf12RECx/cwlcDrUwtYOqwwZpO5XJqsfZEvUeIgnwyYqVSD0AgfUy6
         03KeeWs9Q0VqMJbqh8Jy4q347t3bXXM4itxm8S2xVbsOXGIYlyAz/83gtXZu98g5smfK
         noFdpzhE42eT4CxWFdxDY7m9mNHvT7RLWSs/d9JRdza+E37YzmcAe1XCEujD6oLBFN64
         hBoA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 3/9] ARM: oxnas: remove CPU hotplug implementation
References: <20181213175952.GC26090@n2100.armlinux.org.uk>
 <E1gXVI3-00088u-N6@rmk-PC.armlinux.org.uk>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <b1e2ac26-52a2-0614-4e14-0cb46e839d3f@baylibre.com>
Date: Thu, 20 Dec 2018 15:03:44 +0100
MIME-Version: 1.0
In-Reply-To: <E1gXVI3-00088u-N6@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Russell King <rmk+kernel@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org, linux-oxnas@groups.io, linux-samsung-soc@vger.kernel.org, linux-soc@vger.kernel.org
List-ID: <linux-oxnas@groups.io>

On 13/12/2018 19:00, Russell King wrote:
> The CPU hotplug implementation on this platform is cargo-culted from
> the plat-versatile implementation, and is buggy.  Once a CPU hits the
> "low power" loop, it will wait for pen_release to be set to the CPU
> number to wake up again - but nothing in this implementation does that.
> 
> So, once a CPU has entered cpu_die() it will never, ever leave.
> 
> Remove this useless cargo-culted implementation.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  arch/arm/mach-oxnas/Makefile  |   1 -
>  arch/arm/mach-oxnas/hotplug.c | 109 ------------------------------------------
>  arch/arm/mach-oxnas/platsmp.c |   4 --
>  3 files changed, 114 deletions(-)
>  delete mode 100644 arch/arm/mach-oxnas/hotplug.c
> 
> diff --git a/arch/arm/mach-oxnas/Makefile b/arch/arm/mach-oxnas/Makefile
> index b625906a9970..61a34e1c0f22 100644
> --- a/arch/arm/mach-oxnas/Makefile
> +++ b/arch/arm/mach-oxnas/Makefile
> @@ -1,2 +1 @@
>  obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
> -obj-$(CONFIG_HOTPLUG_CPU) 	+= hotplug.o
> diff --git a/arch/arm/mach-oxnas/hotplug.c b/arch/arm/mach-oxnas/hotplug.c
> deleted file mode 100644
> index 854f29b8cba6..000000000000
> --- a/arch/arm/mach-oxnas/hotplug.c
> +++ /dev/null
> @@ -1,109 +0,0 @@
> -/*
> - *  Copyright (C) 2002 ARM Ltd.
> - *  All Rights Reserved
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> -#include <linux/kernel.h>
> -#include <linux/errno.h>
> -#include <linux/smp.h>
> -
> -#include <asm/cp15.h>
> -#include <asm/smp_plat.h>
> -
> -static inline void cpu_enter_lowpower(void)
> -{
> -	unsigned int v;
> -
> -	asm volatile(
> -	"	mcr	p15, 0, %1, c7, c5, 0\n"
> -	"	mcr	p15, 0, %1, c7, c10, 4\n"
> -	/*
> -	 * Turn off coherency
> -	 */
> -	"	mrc	p15, 0, %0, c1, c0, 1\n"
> -	"	bic	%0, %0, #0x20\n"
> -	"	mcr	p15, 0, %0, c1, c0, 1\n"
> -	"	mrc	p15, 0, %0, c1, c0, 0\n"
> -	"	bic	%0, %0, %2\n"
> -	"	mcr	p15, 0, %0, c1, c0, 0\n"
> -	  : "=&r" (v)
> -	  : "r" (0), "Ir" (CR_C)
> -	  : "cc");
> -}
> -
> -static inline void cpu_leave_lowpower(void)
> -{
> -	unsigned int v;
> -
> -	asm volatile(	"mrc	p15, 0, %0, c1, c0, 0\n"
> -	"	orr	%0, %0, %1\n"
> -	"	mcr	p15, 0, %0, c1, c0, 0\n"
> -	"	mrc	p15, 0, %0, c1, c0, 1\n"
> -	"	orr	%0, %0, #0x20\n"
> -	"	mcr	p15, 0, %0, c1, c0, 1\n"
> -	  : "=&r" (v)
> -	  : "Ir" (CR_C)
> -	  : "cc");
> -}
> -
> -static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
> -{
> -	/*
> -	 * there is no power-control hardware on this platform, so all
> -	 * we can do is put the core into WFI; this is safe as the calling
> -	 * code will have already disabled interrupts
> -	 */
> -	for (;;) {
> -		/*
> -		 * here's the WFI
> -		 */
> -		asm(".word	0xe320f003\n"
> -		    :
> -		    :
> -		    : "memory", "cc");
> -
> -		if (pen_release == cpu_logical_map(cpu)) {
> -			/*
> -			 * OK, proper wakeup, we're done
> -			 */
> -			break;
> -		}
> -
> -		/*
> -		 * Getting here, means that we have come out of WFI without
> -		 * having been woken up - this shouldn't happen
> -		 *
> -		 * Just note it happening - when we're woken, we can report
> -		 * its occurrence.
> -		 */
> -		(*spurious)++;
> -	}
> -}
> -
> -/*
> - * platform-specific code to shutdown a CPU
> - *
> - * Called with IRQs disabled
> - */
> -void ox820_cpu_die(unsigned int cpu)
> -{
> -	int spurious = 0;
> -
> -	/*
> -	 * we're ready for shutdown now, so do it
> -	 */
> -	cpu_enter_lowpower();
> -	platform_do_lowpower(cpu, &spurious);
> -
> -	/*
> -	 * bring this CPU back into the world of cache
> -	 * coherency, and then restore interrupts
> -	 */
> -	cpu_leave_lowpower();
> -
> -	if (spurious)
> -		pr_warn("CPU%u: %u spurious wakeup calls\n", cpu, spurious);
> -}
> diff --git a/arch/arm/mach-oxnas/platsmp.c b/arch/arm/mach-oxnas/platsmp.c
> index 442cc8a2f7dc..735141c0e3a3 100644
> --- a/arch/arm/mach-oxnas/platsmp.c
> +++ b/arch/arm/mach-oxnas/platsmp.c
> @@ -19,7 +19,6 @@
>  #include <asm/smp_scu.h>
>  
>  extern void ox820_secondary_startup(void);
> -extern void ox820_cpu_die(unsigned int cpu);
>  
>  static void __iomem *cpu_ctrl;
>  static void __iomem *gic_cpu_ctrl;
> @@ -94,9 +93,6 @@ static void __init ox820_smp_prepare_cpus(unsigned int max_cpus)
>  static const struct smp_operations ox820_smp_ops __initconst = {
>  	.smp_prepare_cpus	= ox820_smp_prepare_cpus,
>  	.smp_boot_secondary	= ox820_boot_secondary,
> -#ifdef CONFIG_HOTPLUG_CPU
> -	.cpu_die		= ox820_cpu_die,
> -#endif
>  };
>  
>  CPU_METHOD_OF_DECLARE(ox820_smp, "oxsemi,ox820-smp", &ox820_smp_ops);
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
