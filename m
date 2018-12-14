Received: by mail-pl1-f194.google.com with SMTP id 101so2125803pld.6
        for <linux-oxnas@groups.io>; Thu, 13 Dec 2018 20:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wm46+gCBb/GrPQsEFMjcLSy/VE1v0jQaxtkPmPGh0ao=;
        b=i7tU/14NTwLoVMEICkqyYZr9CmC5J8bLcHG/RJd4XQPPN/sB0Zy221BXo9IgJafXyR
         +I2u9aJT3SFiVM7ZZnWrLH2ooDA5sox+R48TckRT0oda4E37bCd697nYg02GYgiPGmCF
         8JOVcHm4BURRhqlolAsedj1/Op4Lkh3iJKrvw=
Return-Path: <viresh.kumar@linaro.org>
Date: Fri, 14 Dec 2018 10:09:23 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 9/9] ARM: smp: remove arch-provided "pen_release"
Message-ID: <20181214043923.2gusomvei424vw7m@vireshk-i7>
References: <20181213175952.GC26090@n2100.armlinux.org.uk>
 <E1gXVIY-0008DI-MU@rmk-PC.armlinux.org.uk>
MIME-Version: 1.0
In-Reply-To: <E1gXVIY-0008DI-MU@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org, linux-oxnas@groups.io, linux-samsung-soc@vger.kernel.org, linux-soc@vger.kernel.org, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Barry Song <baohua@kernel.org>, Viresh Kumar <vireshk@kernel.org>, Shiraz Hashim <shiraz.linux.kernel@gmail.com>
List-ID: <linux-oxnas@groups.io>

On 13-12-18, 18:01, Russell King wrote:
> diff --git a/arch/arm/mach-spear/generic.h b/arch/arm/mach-spear/generic.h
> index 909b97c0b237..815333fc320c 100644
> --- a/arch/arm/mach-spear/generic.h
> +++ b/arch/arm/mach-spear/generic.h
> @@ -20,6 +20,8 @@
>  
>  #include <asm/mach/time.h>
>  
> +extern volatile int prima2_pen_release;

                       prima2 ?

I haven't tried but this may cause build regressions as well, I am
surprised on how this passed for you.

>  extern void spear13xx_timer_init(void);
>  extern void spear3xx_timer_init(void);
>  extern struct pl022_ssp_controller pl022_plat_data;
> diff --git a/arch/arm/mach-spear/headsmp.S b/arch/arm/mach-spear/headsmp.S
> index c52192dc3d9f..6e250b6c0aa2 100644
> --- a/arch/arm/mach-spear/headsmp.S
> +++ b/arch/arm/mach-spear/headsmp.S
> @@ -43,5 +43,5 @@ pen:	ldr	r7, [r6]
>  
>  	.align
>  1:	.long	.
> -	.long	pen_release
> +	.long	spear_pen_release
>  ENDPROC(spear13xx_secondary_startup)
> diff --git a/arch/arm/mach-spear/hotplug.c b/arch/arm/mach-spear/hotplug.c
> index 12edd1cf8a12..0dd84f609627 100644
> --- a/arch/arm/mach-spear/hotplug.c
> +++ b/arch/arm/mach-spear/hotplug.c
> @@ -16,6 +16,8 @@
>  #include <asm/cp15.h>
>  #include <asm/smp_plat.h>
>  
> +#include "generic.h"
> +
>  static inline void cpu_enter_lowpower(void)
>  {
>  	unsigned int v;
> @@ -57,7 +59,7 @@ static inline void spear13xx_do_lowpower(unsigned int cpu, int *spurious)
>  	for (;;) {
>  		wfi();
>  
> -		if (pen_release == cpu) {
> +		if (spear_pen_release == cpu) {
>  			/*
>  			 * OK, proper wakeup, we're done
>  			 */
> diff --git a/arch/arm/mach-spear/platsmp.c b/arch/arm/mach-spear/platsmp.c
> index 39038a03836a..b1ff4bb86f6d 100644
> --- a/arch/arm/mach-spear/platsmp.c
> +++ b/arch/arm/mach-spear/platsmp.c
> @@ -20,16 +20,21 @@
>  #include <mach/spear.h>
>  #include "generic.h"
>  
> +/* XXX spear_pen_release is cargo culted code - DO NOT COPY XXX */
> +volatile int spear_pen_release = -1;
> +
>  /*
> - * Write pen_release in a way that is guaranteed to be visible to all
> - * observers, irrespective of whether they're taking part in coherency
> + * XXX CARGO CULTED CODE - DO NOT COPY XXX
> + *
> + * Write spear_pen_release in a way that is guaranteed to be visible to
> + * all observers, irrespective of whether they're taking part in coherency
>   * or not.  This is necessary for the hotplug code to work reliably.
>   */
> -static void write_pen_release(int val)
> +static void spear_write_pen_release(int val)
>  {
> -	pen_release = val;
> +	spear_pen_release = val;
>  	smp_wmb();
> -	sync_cache_w(&pen_release);
> +	sync_cache_w(&spear_pen_release);
>  }
>  
>  static DEFINE_SPINLOCK(boot_lock);
> @@ -42,7 +47,7 @@ static void spear13xx_secondary_init(unsigned int cpu)
>  	 * let the primary processor know we're out of the
>  	 * pen, then head off into the C entry point
>  	 */
> -	write_pen_release(-1);
> +	spear_write_pen_release(-1);
>  
>  	/*
>  	 * Synchronise with the boot thread.
> @@ -64,17 +69,17 @@ static int spear13xx_boot_secondary(unsigned int cpu, struct task_struct *idle)
>  	/*
>  	 * The secondary processor is waiting to be released from
>  	 * the holding pen - release it, then wait for it to flag
> -	 * that it has been released by resetting pen_release.
> +	 * that it has been released by resetting spear_pen_release.
>  	 *
> -	 * Note that "pen_release" is the hardware CPU ID, whereas
> +	 * Note that "spear_pen_release" is the hardware CPU ID, whereas
>  	 * "cpu" is Linux's internal ID.
>  	 */
> -	write_pen_release(cpu);
> +	spear_write_pen_release(cpu);
>  
>  	timeout = jiffies + (1 * HZ);
>  	while (time_before(jiffies, timeout)) {
>  		smp_rmb();
> -		if (pen_release == -1)
> +		if (spear_pen_release == -1)
>  			break;
>  
>  		udelay(10);
> @@ -86,7 +91,7 @@ static int spear13xx_boot_secondary(unsigned int cpu, struct task_struct *idle)
>  	 */
>  	spin_unlock(&boot_lock);
>  
> -	return pen_release != -1 ? -ENOSYS : 0;
> +	return spear_pen_release != -1 ? -ENOSYS : 0;
>  }
>  
>  /*
> -- 
> 2.7.4

-- 
viresh
