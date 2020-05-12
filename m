Received: from huawei.com (huawei.com [45.249.212.191])
 by mx.groups.io with SMTP id smtpd.web11.7012.1589247513133952832
 for <linux-oxnas@groups.io>;
 Mon, 11 May 2020 18:38:33 -0700
From: Ma Feng <mafeng.ma@huawei.com>
Subject: [PATCH] ARM: oxnas: make ox820_boot_secondary static
Date: Tue, 12 May 2020 09:46:13 +0800
Message-ID: <1589247973-29728-1-git-send-email-mafeng.ma@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
To: narmstrong@baylibre.com, linux@armlinux.org.uk
Cc: linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io, linux-kernel@vger.kernel.org
List-ID: <linux-oxnas@groups.io>

Fix sparse warning:

arch/arm/mach-oxnas/platsmp.c:30:12: warning: symbol 'ox820_boot_secondary' was
not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Ma Feng <mafeng.ma@huawei.com>
---
 arch/arm/mach-oxnas/platsmp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-oxnas/platsmp.c b/arch/arm/mach-oxnas/platsmp.c
index ab35275..f0a50b9 100644
--- a/arch/arm/mach-oxnas/platsmp.c
+++ b/arch/arm/mach-oxnas/platsmp.c
@@ -27,7 +27,8 @@ static void __iomem *gic_cpu_ctrl;
 #define GIC_CPU_CTRL			0x00
 #define GIC_CPU_CTRL_ENABLE		1

-int __init ox820_boot_secondary(unsigned int cpu, struct task_struct *idle)
+static int __init ox820_boot_secondary(unsigned int cpu,
+		struct task_struct *idle)
 {
 	/*
 	 * Write the address of secondary startup into the
--
2.7.4

