DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=0T7qpDlC972uTBw1TWUL26ZvfVJSqh2b3uUOQRgdbIw=;
 b=X7BrXQCdAXqmxWWxsnpn/JR0Hq6NkukX8llPY3gzN3Kkp4efHqN5P4bUzeZdL2BWTevxarBoDew51GZmlpzZg2JZNgemrqSBSuSlcJl4EHSR2qswOg3g56A4ArM0yOh+WpglomXUwyFeys9SurUuXSC+/qURTRqUKYAP5aStenw=
Date: Mon, 7 May 2018 15:42:15 +0800
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Subject: [PATCH] arm: oxnas: remove non-necessary flush_cache_all()
Message-ID: <20180507154215.45a9348f@xhacker.debian>
MIME-Version: 1.0
Return-Path: Jisheng.Zhang@synaptics.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io, linux-kernel@vger.kernel.org
List-ID: <linux-oxnas@groups.io>

I believe the flush_cache_all() after scu_enable() is to "Ensure that
the data accessed by CPU0 before the SCU was initialised is visible
to the other CPUs." as commented in scu_enable(). So flush_cache_all()
here is a duplication of the one in scu_enable(), remove it.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 arch/arm/mach-oxnas/platsmp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-oxnas/platsmp.c b/arch/arm/mach-oxnas/platsmp.c
index 442cc8a2f7dc..1a8e1e9fc222 100644
--- a/arch/arm/mach-oxnas/platsmp.c
+++ b/arch/arm/mach-oxnas/platsmp.c
@@ -85,7 +85,6 @@ static void __init ox820_smp_prepare_cpus(unsigned int max_cpus)
 		goto unmap_scu;
 
 	scu_enable(scu_base);
-	flush_cache_all();
 
 unmap_scu:
 	iounmap(scu_base);
-- 
2.17.0

