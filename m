DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2014; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=h/5VpWD6jtHCErQoCjlHnGrhBEkBLuBL2tjysdL5d9A=; b=VDnNCLi3CE3fWeYqoPSwacr6Ow
	08pSUrlsnP28S28pzpmXpuzHt04RaFN1Ac7l+UAHOLH41oBWiY/owZ+ZiRJQzbsIGXXAiB4X0uOpW
	VKZ28/sIFYvwrVJO7c7Byq5+9+7OT9RsoIqRqdpZkAnu5E9qzzM3acnkwLaV2gVWUH+k=;
In-Reply-To: <20181213175952.GC26090@n2100.armlinux.org.uk>
References: <20181213175952.GC26090@n2100.armlinux.org.uk>
From: Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 8/9] ARM: versatile: rename and comment SMP implementation
MIME-Version: 1.0
Message-Id: <E1gXVIT-0008D2-IZ@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 13 Dec 2018 18:01:17 +0000
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
To: linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org, linux-oxnas@groups.io, linux-samsung-soc@vger.kernel.org, linux-soc@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>
List-ID: <linux-oxnas@groups.io>

Rename pen_release and boot_lock in the Versatile specific SMP
implementation, describe why these exist and state clearly that they
should not be used in production implementations.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/plat-versatile/headsmp.S              |  2 +-
 arch/arm/plat-versatile/hotplug.c              |  4 ++-
 arch/arm/plat-versatile/include/plat/platsmp.h |  1 +
 arch/arm/plat-versatile/platsmp.c              | 47 ++++++++++++++++++--------
 4 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/arch/arm/plat-versatile/headsmp.S b/arch/arm/plat-versatile/headsmp.S
index 40f27e52de75..e99396dfa6f3 100644
--- a/arch/arm/plat-versatile/headsmp.S
+++ b/arch/arm/plat-versatile/headsmp.S
@@ -37,5 +37,5 @@ pen:	ldr	r7, [r6]
 
 	.align
 1:	.long	.
-	.long	pen_release
+	.long	versatile_cpu_release
 ENDPROC(versatile_secondary_startup)
diff --git a/arch/arm/plat-versatile/hotplug.c b/arch/arm/plat-versatile/hotplug.c
index e2d3e9035d0f..c974958417fe 100644
--- a/arch/arm/plat-versatile/hotplug.c
+++ b/arch/arm/plat-versatile/hotplug.c
@@ -18,6 +18,8 @@
 #include <asm/smp_plat.h>
 #include <asm/cp15.h>
 
+#include <plat/platsmp.h>
+
 static inline void versatile_immitation_enter_lowpower(unsigned int actrl_mask)
 {
 	unsigned int v;
@@ -67,7 +69,7 @@ static inline void versatile_immitation_do_lowpower(unsigned int cpu, int *spuri
 	for (;;) {
 		wfi();
 
-		if (pen_release == cpu_logical_map(cpu)) {
+		if (versatile_cpu_release == cpu_logical_map(cpu)) {
 			/*
 			 * OK, proper wakeup, we're done
 			 */
diff --git a/arch/arm/plat-versatile/include/plat/platsmp.h b/arch/arm/plat-versatile/include/plat/platsmp.h
index 9fff1f241c9e..1b087fbbc700 100644
--- a/arch/arm/plat-versatile/include/plat/platsmp.h
+++ b/arch/arm/plat-versatile/include/plat/platsmp.h
@@ -8,6 +8,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+extern volatile int versatile_cpu_release;
 
 extern void versatile_secondary_startup(void);
 extern void versatile_secondary_init(unsigned int cpu);
diff --git a/arch/arm/plat-versatile/platsmp.c b/arch/arm/plat-versatile/platsmp.c
index 6b60f582b738..6e2836243187 100644
--- a/arch/arm/plat-versatile/platsmp.c
+++ b/arch/arm/plat-versatile/platsmp.c
@@ -7,6 +7,11 @@
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
+ *
+ * This code is specific to the hardware found on ARM Realview and
+ * Versatile Express platforms where the CPUs are unable to be individually
+ * woken, and where there is no way to hot-unplug CPUs.  Real platforms
+ * should not copy this code.
  */
 #include <linux/init.h>
 #include <linux/errno.h>
@@ -21,18 +26,32 @@
 #include <plat/platsmp.h>
 
 /*
- * Write pen_release in a way that is guaranteed to be visible to all
- * observers, irrespective of whether they're taking part in coherency
+ * versatile_cpu_release controls the release of CPUs from the holding
+ * pen in headsmp.S, which exists because we are not always able to
+ * control the release of individual CPUs from the board firmware.
+ * Production platforms do not need this.
+ */
+volatile int versatile_cpu_release = -1;
+
+/*
+ * Write versatile_cpu_release in a way that is guaranteed to be visible to
+ * all observers, irrespective of whether they're taking part in coherency
  * or not.  This is necessary for the hotplug code to work reliably.
  */
-static void write_pen_release(int val)
+static void versatile_write_cpu_release(int val)
 {
-	pen_release = val;
+	versatile_cpu_release = val;
 	smp_wmb();
-	sync_cache_w(&pen_release);
+	sync_cache_w(&versatile_cpu_release);
 }
 
-static DEFINE_RAW_SPINLOCK(boot_lock);
+/*
+ * versatile_lock exists to avoid running the loops_per_jiffy delay loop
+ * calibrations on the secondary CPU while the requesting CPU is using
+ * the limited-bandwidth bus - which affects the calibration value.
+ * Production platforms do not need this.
+ */
+static DEFINE_RAW_SPINLOCK(versatile_lock);
 
 void versatile_secondary_init(unsigned int cpu)
 {
@@ -40,13 +59,13 @@ void versatile_secondary_init(unsigned int cpu)
 	 * let the primary processor know we're out of the
 	 * pen, then head off into the C entry point
 	 */
-	write_pen_release(-1);
+	versatile_write_cpu_release(-1);
 
 	/*
 	 * Synchronise with the boot thread.
 	 */
-	raw_spin_lock(&boot_lock);
-	raw_spin_unlock(&boot_lock);
+	raw_spin_lock(&versatile_lock);
+	raw_spin_unlock(&versatile_lock);
 }
 
 int versatile_boot_secondary(unsigned int cpu, struct task_struct *idle)
@@ -57,7 +76,7 @@ int versatile_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * Set synchronisation state between this boot processor
 	 * and the secondary one
 	 */
-	raw_spin_lock(&boot_lock);
+	raw_spin_lock(&versatile_lock);
 
 	/*
 	 * This is really belt and braces; we hold unintended secondary
@@ -65,7 +84,7 @@ int versatile_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * since we haven't sent them a soft interrupt, they shouldn't
 	 * be there.
 	 */
-	write_pen_release(cpu_logical_map(cpu));
+	versatile_write_cpu_release(cpu_logical_map(cpu));
 
 	/*
 	 * Send the secondary CPU a soft interrupt, thereby causing
@@ -77,7 +96,7 @@ int versatile_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	timeout = jiffies + (1 * HZ);
 	while (time_before(jiffies, timeout)) {
 		smp_rmb();
-		if (pen_release == -1)
+		if (versatile_cpu_release == -1)
 			break;
 
 		udelay(10);
@@ -87,7 +106,7 @@ int versatile_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * now the secondary core is starting up let it run its
 	 * calibrations, then wait for it to finish
 	 */
-	raw_spin_unlock(&boot_lock);
+	raw_spin_unlock(&versatile_lock);
 
-	return pen_release != -1 ? -ENOSYS : 0;
+	return versatile_cpu_release != -1 ? -ENOSYS : 0;
 }
-- 
2.7.4

