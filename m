Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [91.198.250.252])
 by mx.groups.io with SMTP id smtpd.web11.4607.1584585421113363934
 for <linux-oxnas@groups.io>;
 Wed, 18 Mar 2020 19:37:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gorani.run; s=MBO0001;
	t=1584585417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ERpvMrK/UaDTvkIoSj6AknzdzJX6Ereus6KjymOIMWM=;
	b=pNO+MQySdvo4EMik8yKPyOgZHetMjJNsxtHde2yGeduT9VXjz3KNh93+mPFISbax4He/fL
	ZyJNhfGD+77JFfTfGUQWtXAuUFj7taiIpA4lkGtmjSxWabkKeG+ykH4ofktMsmIbLi4Hre
	/weoS3vN1K1u/n68+F/Dedma7U42fE7CjWLO89sPcn3U0YoWfgy98LlhcJ1MLDnFzkGSdw
	XW02TIknUddGC1O1q5QgIAl3DzOtyIiggGR7U6nQBF59SpjPK9J4phcXuKYnnq855MWq2n
	7tevK0bCqdk2b1wA9kVPVpSLc2S7LRx1Gni9+SR7Va9rzFDH8BCvqWZYZgQP/Q==
From: Sungbo Eo <mans0n@gorani.run>
Subject: [PATCH v2] irqchip/versatile-fpga: Handle chained IRQs properly
Date: Thu, 19 Mar 2020 11:34:48 +0900
Message-Id: <20200319023448.1479701-1-mans0n@gorani.run>
In-Reply-To: <002b72cab9896fa5ac76a52e0cb503ff@kernel.org>
References: <002b72cab9896fa5ac76a52e0cb503ff@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Linus Walleij <linus.walleij@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-oxnas@groups.io
Cc: Sungbo Eo <mans0n@gorani.run>, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <linux-oxnas@groups.io>

Enclose the chained handler with chained_irq_{enter,exit}(), so that the
muxed interrupts get properly acked.

This patch also fixes a reboot bug on OX820 SoC, where the jiffies timer
interrupt is never acked. The kernel waits a clock tick forever in
calibrate_delay_converge(), which leads to a boot hang.

Fixes: c41b16f8c9d9 ("ARM: integrator/versatile: consolidate FPGA IRQ han=
dling code")
Signed-off-by: Sungbo Eo <mans0n@gorani.run>
Cc: Neil Armstrong <narmstrong@baylibre.com>
---
v2: moved readl below chained_irq_enter()
    added Fixes tag

 drivers/irqchip/irq-versatile-fpga.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-versatile-fpga.c b/drivers/irqchip/irq-v=
ersatile-fpga.c
index 928858dada75..70e2cfff8175 100644
--- a/drivers/irqchip/irq-versatile-fpga.c
+++ b/drivers/irqchip/irq-versatile-fpga.c
@@ -6,6 +6,7 @@
 #include <linux/irq.h>
 #include <linux/io.h>
 #include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
 #include <linux/irqchip/versatile-fpga.h>
 #include <linux/irqdomain.h>
 #include <linux/module.h>
@@ -68,12 +69,16 @@ static void fpga_irq_unmask(struct irq_data *d)
=20
 static void fpga_irq_handle(struct irq_desc *desc)
 {
+	struct irq_chip *chip =3D irq_desc_get_chip(desc);
 	struct fpga_irq_data *f =3D irq_desc_get_handler_data(desc);
-	u32 status =3D readl(f->base + IRQ_STATUS);
+	u32 status;
+
+	chained_irq_enter(chip, desc);
=20
+	status =3D readl(f->base + IRQ_STATUS);
 	if (status =3D=3D 0) {
 		do_bad_IRQ(desc);
-		return;
+		goto out;
 	}
=20
 	do {
@@ -82,6 +87,9 @@ static void fpga_irq_handle(struct irq_desc *desc)
 		status &=3D ~(1 << irq);
 		generic_handle_irq(irq_find_mapping(f->domain, irq));
 	} while (status);
+
+out:
+	chained_irq_exit(chip, desc);
 }
=20
 /*
--=20
2.25.1

