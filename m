DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2014; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GwHXPmrKplCV5SoH+8i/717kAdq8R+O584srpN6C4fE=; b=NoOgp/JrNEhICetl5br4BgfdBj
	WJK1VqxEhqI+lFxSBs1c3WbUuN5aIzOvPbkyTtmI7LivJrtyKdUrOlZi2AHsmw6vhLBzrSpltD4/X
	6ezO8KS/tOvke2NBLN8gsk87d9zplB8HopbQQZrkiNaLuM756PnP+zIOOsK1F/kmjE0E=;
In-Reply-To: <20181213175952.GC26090@n2100.armlinux.org.uk>
References: <20181213175952.GC26090@n2100.armlinux.org.uk>
From: Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 1/9] ARM: omap2: remove unnecessary boot_lock
MIME-Version: 1.0
Message-Id: <E1gXVHt-00088Q-DP@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 13 Dec 2018 18:00:41 +0000
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
To: linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org, linux-oxnas@groups.io, linux-samsung-soc@vger.kernel.org, linux-soc@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>
List-ID: <linux-oxnas@groups.io>

The boot_lock is something that was required for ARM development
platforms to ensure that the delay calibration worked properly.  This
is not necessary for modern platforms that have better bus bandwidth
and do not need to calibrate the delay loop for secondary cores.
Remove the boot_lock entirely.

Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-omap2/omap-smp.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index 1c73694c871a..10e070368f64 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -69,8 +69,6 @@ static const struct omap_smp_config omap5_cfg __initconst = {
 	.startup_addr = omap5_secondary_startup,
 };
 
-static DEFINE_SPINLOCK(boot_lock);
-
 void __iomem *omap4_get_scu_base(void)
 {
 	return cfg.scu_base;
@@ -173,12 +171,6 @@ static void omap4_secondary_init(unsigned int cpu)
 		/* Enable ACR to allow for ICUALLU workaround */
 		omap5_secondary_harden_predictor();
 	}
-
-	/*
-	 * Synchronise with the boot thread.
-	 */
-	spin_lock(&boot_lock);
-	spin_unlock(&boot_lock);
 }
 
 static int omap4_boot_secondary(unsigned int cpu, struct task_struct *idle)
@@ -188,12 +180,6 @@ static int omap4_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	static struct powerdomain *cpu1_pwrdm;
 
 	/*
-	 * Set synchronisation state between this boot processor
-	 * and the secondary one
-	 */
-	spin_lock(&boot_lock);
-
-	/*
 	 * Update the AuxCoreBoot0 with boot state for secondary core.
 	 * omap4_secondary_startup() routine will hold the secondary core till
 	 * the AuxCoreBoot1 register is updated with cpu state
@@ -266,12 +252,6 @@ static int omap4_boot_secondary(unsigned int cpu, struct task_struct *idle)
 
 	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
 
-	/*
-	 * Now the secondary core is starting up let it run its
-	 * calibrations, then wait for it to finish
-	 */
-	spin_unlock(&boot_lock);
-
 	return 0;
 }
 
-- 
2.7.4

