DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2014; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3Es9RBnn1L2qTSYe0DphuXplYjpi9l2zhl/9K/iit8o=; b=KflLq8Qr0ZdMPkxHKP+GQBCLRi
	DCQPFtcdIjJ7HK+GbUV2teYrRXvZ9AIQse/CfbWyU725bMDQ51OQ+yxzT7g+nxBVelyW8SC/DrWi1
	djTttIQC5owQix+3M3MTp/muZiPaZ/NgvyUTupqVyHhc7TywFJZXLWdG3LSbUlq4Hnhg=;
In-Reply-To: <20181213175952.GC26090@n2100.armlinux.org.uk>
References: <20181213175952.GC26090@n2100.armlinux.org.uk>
From: Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 5/9] ARM: actions: remove boot_lock and pen_release
MIME-Version: 1.0
Message-Id: <E1gXVIE-0008CK-5O@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 13 Dec 2018 18:01:02 +0000
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
To: linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org, linux-oxnas@groups.io, linux-samsung-soc@vger.kernel.org, linux-soc@vger.kernel.org
Cc: afaerber@suse.de, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
List-ID: <linux-oxnas@groups.io>

The actions SMP implementation has several issues:

1. pen_release is only ever read and compared to -1, and is defined in
   arch/arm/kernel/smp.c to be -1.  This test will always succeed.

2. we are already guaranteed to be single threaded while bringing up a
   CPU, so the spinlock makes no sense, remove it.

3. owl_secondary_startup() is not referenced nor defined, the prototype
   is redundant, remove it.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-actions/platsmp.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/arm/mach-actions/platsmp.c b/arch/arm/mach-actions/platsmp.c
index 3efaa10efc43..4fd479c948e6 100644
--- a/arch/arm/mach-actions/platsmp.c
+++ b/arch/arm/mach-actions/platsmp.c
@@ -39,10 +39,6 @@ static void __iomem *sps_base_addr;
 static void __iomem *timer_base_addr;
 static int ncores;
 
-static DEFINE_SPINLOCK(boot_lock);
-
-void owl_secondary_startup(void);
-
 static int s500_wakeup_secondary(unsigned int cpu)
 {
 	int ret;
@@ -84,7 +80,6 @@ static int s500_wakeup_secondary(unsigned int cpu)
 
 static int s500_smp_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
-	unsigned long timeout;
 	int ret;
 
 	ret = s500_wakeup_secondary(cpu);
@@ -93,21 +88,11 @@ static int s500_smp_boot_secondary(unsigned int cpu, struct task_struct *idle)
 
 	udelay(10);
 
-	spin_lock(&boot_lock);
-
 	smp_send_reschedule(cpu);
 
-	timeout = jiffies + (1 * HZ);
-	while (time_before(jiffies, timeout)) {
-		if (pen_release == -1)
-			break;
-	}
-
 	writel(0, timer_base_addr + OWL_CPU1_ADDR + (cpu - 1) * 4);
 	writel(0, timer_base_addr + OWL_CPU1_FLAG + (cpu - 1) * 4);
 
-	spin_unlock(&boot_lock);
-
 	return 0;
 }
 
-- 
2.7.4

