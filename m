Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web10.64447.1680507746708927048
 for <linux-oxnas@groups.io>;
 Mon, 03 Apr 2023 00:42:27 -0700
Received: by mail-wr1-f47.google.com with SMTP id t4so23026761wra.7
        for <linux-oxnas@groups.io>; Mon, 03 Apr 2023 00:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680507745;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pI/9yh94djA+1m9+33QTcqLMC72RdA1UX5CeiZQgLZ8=;
        b=ShyOJVvAHbR/ULnZEDJTDWjjeZsqyanjv5iLgF8WvqgYAERgo2CxDCi40pGVcfsy2Z
         vItyDQVEedyMepEtz6XN/7VB1G/EUJAUEkwZPEg/mQM2MRKtV9zx8YxsxlqJ6P9o2NdZ
         3jdTx9DoCclRzPsCe/FppL6/0LMgtVeA5cbsaDcW1jwGzsS1M0yLZM77PF7NF4esfDiO
         lTLtcBde1FzTO3sB41nU94P5cqb1iUdiiU/ttg0d8OiXptkTYUCfD00Nf81zjMig8P90
         HaAiH3zwqNy8txJ6tPhAFHrDPI+ThPAaTdX8RHDEzPkpJEdlMph9b/hc2TADnTnUK+vE
         b/sQ==
Return-Path: <neil.armstrong@linaro.org>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Date: Mon, 03 Apr 2023 09:42:19 +0200
Subject: [PATCH RFC v2 2/4] ARM: oxnas: remove OXNAS support
MIME-Version: 1.0
Message-Id: <20230331-topic-oxnas-upstream-remove-v2-2-e51078376f08@linaro.org>
References: <20230331-topic-oxnas-upstream-remove-v2-0-e51078376f08@linaro.org>
In-Reply-To: <20230331-topic-oxnas-upstream-remove-v2-0-e51078376f08@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, soc@kernel.org, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-oxnas@groups.io, Neil Armstrong <neil.armstrong@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Daniel Golle <daniel@makrotopia.org>
List-ID: <linux-oxnas@groups.io>

Due to lack of maintainance and stall of development for a few years now,
and since no new features will ever be added upstream, remove support
for OX810 and OX820 ARM support.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm/Kconfig              |  2 -
 arch/arm/Makefile             |  1 -
 arch/arm/mach-oxnas/Kconfig   | 38 -----------------
 arch/arm/mach-oxnas/Makefile  |  2 -
 arch/arm/mach-oxnas/headsmp.S | 23 -----------
 arch/arm/mach-oxnas/platsmp.c | 96 -------------------------------------------
 6 files changed, 162 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e24a9820e12f..017329401b3d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -497,8 +497,6 @@ source "arch/arm/mach-omap2/Kconfig"
 
 source "arch/arm/mach-orion5x/Kconfig"
 
-source "arch/arm/mach-oxnas/Kconfig"
-
 source "arch/arm/mach-pxa/Kconfig"
 
 source "arch/arm/mach-qcom/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 485a439e22ca..547e5856eaa0 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -203,7 +203,6 @@ machine-$(CONFIG_ARCH_MSTARV7)		+= mstar
 machine-$(CONFIG_ARCH_NOMADIK)		+= nomadik
 machine-$(CONFIG_ARCH_NPCM)		+= npcm
 machine-$(CONFIG_ARCH_NSPIRE)		+= nspire
-machine-$(CONFIG_ARCH_OXNAS)		+= oxnas
 machine-$(CONFIG_ARCH_OMAP1)		+= omap1
 machine-$(CONFIG_ARCH_OMAP2PLUS)	+= omap2
 machine-$(CONFIG_ARCH_ORION5X)		+= orion5x
diff --git a/arch/arm/mach-oxnas/Kconfig b/arch/arm/mach-oxnas/Kconfig
deleted file mode 100644
index a9ded7079268..000000000000
--- a/arch/arm/mach-oxnas/Kconfig
+++ /dev/null
@@ -1,38 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-menuconfig ARCH_OXNAS
-	bool "Oxford Semiconductor OXNAS Family SoCs"
-	depends on (ARCH_MULTI_V5 && CPU_LITTLE_ENDIAN) || ARCH_MULTI_V6
-	select ARCH_HAS_RESET_CONTROLLER
-	select COMMON_CLK_OXNAS
-	select GPIOLIB
-	select MFD_SYSCON
-	select OXNAS_RPS_TIMER
-	select PINCTRL_OXNAS
-	select RESET_CONTROLLER
-	select RESET_OXNAS
-	select VERSATILE_FPGA_IRQ
-	select PINCTRL
-	help
-	  Support for OxNas SoC family developed by Oxford Semiconductor.
-
-if ARCH_OXNAS
-
-config MACH_OX810SE
-	bool "Support OX810SE Based Products"
-	depends on ARCH_MULTI_V5
-	select CPU_ARM926T
-	help
-	  Include Support for the Oxford Semiconductor OX810SE SoC Based Products.
-
-config MACH_OX820
-	bool "Support OX820 Based Products"
-	depends on ARCH_MULTI_V6
-	select ARM_GIC
-	select DMA_CACHE_RWFO if SMP
-	select HAVE_SMP
-	select HAVE_ARM_SCU if SMP
-	select HAVE_ARM_TWD if SMP
-	help
-	  Include Support for the Oxford Semiconductor OX820 SoC Based Products.
-
-endif
diff --git a/arch/arm/mach-oxnas/Makefile b/arch/arm/mach-oxnas/Makefile
deleted file mode 100644
index 0e78ecfe6c49..000000000000
--- a/arch/arm/mach-oxnas/Makefile
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
diff --git a/arch/arm/mach-oxnas/headsmp.S b/arch/arm/mach-oxnas/headsmp.S
deleted file mode 100644
index 9c0f1479f33a..000000000000
--- a/arch/arm/mach-oxnas/headsmp.S
+++ /dev/null
@@ -1,23 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2013 Ma Haijun <mahaijuns@gmail.com>
- * Copyright (c) 2003 ARM Limited
- * All Rights Reserved
- */
-#include <linux/linkage.h>
-#include <linux/init.h>
-
-	__INIT
-
-/*
- * OX820 specific entry point for secondary CPUs.
- */
-ENTRY(ox820_secondary_startup)
-	mov r4, #0
-	/* invalidate both caches and branch target cache */
-	mcr p15, 0, r4, c7, c7, 0
-	/*
-	 * we've been released from the holding pen: secondary_stack
-	 * should now contain the SVC stack for this core
-	 */
-	b	secondary_startup
diff --git a/arch/arm/mach-oxnas/platsmp.c b/arch/arm/mach-oxnas/platsmp.c
deleted file mode 100644
index f0a50b9e61df..000000000000
--- a/arch/arm/mach-oxnas/platsmp.c
+++ /dev/null
@@ -1,96 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2016 Neil Armstrong <narmstrong@baylibre.com>
- * Copyright (C) 2013 Ma Haijun <mahaijuns@gmail.com>
- * Copyright (C) 2002 ARM Ltd.
- * All Rights Reserved
- */
-#include <linux/io.h>
-#include <linux/delay.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-
-#include <asm/cacheflush.h>
-#include <asm/cp15.h>
-#include <asm/smp_plat.h>
-#include <asm/smp_scu.h>
-
-extern void ox820_secondary_startup(void);
-
-static void __iomem *cpu_ctrl;
-static void __iomem *gic_cpu_ctrl;
-
-#define HOLDINGPEN_CPU_OFFSET		0xc8
-#define HOLDINGPEN_LOCATION_OFFSET	0xc4
-
-#define GIC_NCPU_OFFSET(cpu)		(0x100 + (cpu)*0x100)
-#define GIC_CPU_CTRL			0x00
-#define GIC_CPU_CTRL_ENABLE		1
-
-static int __init ox820_boot_secondary(unsigned int cpu,
-		struct task_struct *idle)
-{
-	/*
-	 * Write the address of secondary startup into the
-	 * system-wide flags register. The BootMonitor waits
-	 * until it receives a soft interrupt, and then the
-	 * secondary CPU branches to this address.
-	 */
-	writel(virt_to_phys(ox820_secondary_startup),
-			cpu_ctrl + HOLDINGPEN_LOCATION_OFFSET);
-
-	writel(cpu, cpu_ctrl + HOLDINGPEN_CPU_OFFSET);
-
-	/*
-	 * Enable GIC cpu interface in CPU Interface Control Register
-	 */
-	writel(GIC_CPU_CTRL_ENABLE,
-		gic_cpu_ctrl + GIC_NCPU_OFFSET(cpu) + GIC_CPU_CTRL);
-
-	/*
-	 * Send the secondary CPU a soft interrupt, thereby causing
-	 * the boot monitor to read the system wide flags register,
-	 * and branch to the address found there.
-	 */
-	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
-
-	return 0;
-}
-
-static void __init ox820_smp_prepare_cpus(unsigned int max_cpus)
-{
-	struct device_node *np;
-	void __iomem *scu_base;
-
-	np = of_find_compatible_node(NULL, NULL, "arm,arm11mp-scu");
-	scu_base = of_iomap(np, 0);
-	of_node_put(np);
-	if (!scu_base)
-		return;
-
-	/* Remap CPU Interrupt Interface Registers */
-	np = of_find_compatible_node(NULL, NULL, "arm,arm11mp-gic");
-	gic_cpu_ctrl = of_iomap(np, 1);
-	of_node_put(np);
-	if (!gic_cpu_ctrl)
-		goto unmap_scu;
-
-	np = of_find_compatible_node(NULL, NULL, "oxsemi,ox820-sys-ctrl");
-	cpu_ctrl = of_iomap(np, 0);
-	of_node_put(np);
-	if (!cpu_ctrl)
-		goto unmap_scu;
-
-	scu_enable(scu_base);
-	flush_cache_all();
-
-unmap_scu:
-	iounmap(scu_base);
-}
-
-static const struct smp_operations ox820_smp_ops __initconst = {
-	.smp_prepare_cpus	= ox820_smp_prepare_cpus,
-	.smp_boot_secondary	= ox820_boot_secondary,
-};
-
-CPU_METHOD_OF_DECLARE(ox820_smp, "oxsemi,ox820-smp", &ox820_smp_ops);

-- 
2.34.1

