Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [91.198.250.252])
 by mx.groups.io with SMTP id smtpd.web12.7834.1584798038860762756
 for <linux-oxnas@groups.io>;
 Sat, 21 Mar 2020 06:40:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gorani.run; s=MBO0001;
	t=1584798035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6gUTnyBd+wF4DcNE7R2+NzsCS2Cnj7qei4GbwrUoBsU=;
	b=Wp7XIFjG6vsHM2RFsi/R75ByN0PxJkmTChTRZvcA+95nlBCKmnP4g7OSuMA+ZS2VpR+ISZ
	7Atuz113Kb5RaHrkzhR61DmpN+ggZqWjOdqQZdgV7ChSvSJCaao6aWwFLXWBSQLt5WL9yX
	gBV+5eHxP880JVPNiKZqrJ05hmDGThEySDr/3gRb9RQABUoqYt9FMZB5uneBp//M2o5SUg
	OGI+qnmtISB7gtviyrw37VajKO7QRZgjsf2e7TkOv0zsfphv4E/+4HGsW7rvenPcSqIbg8
	iEffaHuAVBQMe6o7j+iDeT5+PcvCKryZAAOEvSY1YxqFy9j+btbl7H1FzQjrNQ==
From: Sungbo Eo <mans0n@gorani.run>
Subject: [PATCH] irqchip/versatile-fpga: Apply clear-mask earlier
Date: Sat, 21 Mar 2020 22:38:42 +0900
Message-Id: <20200321133842.2408823-1-mans0n@gorani.run>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: linux-oxnas@groups.io, Linus Walleij <linus.walleij@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Sungbo Eo <mans0n@gorani.run>, Neil Armstrong <narmstrong@baylibre.com>, Daniel Golle <daniel@makrotopia.org>
List-ID: <linux-oxnas@groups.io>

Clear its own IRQs before the parent IRQ get enabled, so that the
remaining IRQs do not accidentally interrupt the parent IRQ controller.

This patch also fixes a reboot bug on OX820 SoC, where the remaining
rps-timer IRQ raises a GIC interrupt that is left pending. After that,
the rps-timer IRQ is cleared during driver initialization, and there's
no IRQ left in rps-irq when local_irq_enable() is called, which evokes
an error message "unexpected IRQ trap".

Fixes: bdd272cbb97a ("irqchip: versatile FPGA: support cascaded interrupt=
s from DT")
Signed-off-by: Sungbo Eo <mans0n@gorani.run>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Daniel Golle <daniel@makrotopia.org>
---
 drivers/irqchip/irq-versatile-fpga.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-versatile-fpga.c b/drivers/irqchip/irq-v=
ersatile-fpga.c
index 70e2cfff8175..f1386733d3bc 100644
--- a/drivers/irqchip/irq-versatile-fpga.c
+++ b/drivers/irqchip/irq-versatile-fpga.c
@@ -212,6 +212,9 @@ int __init fpga_irq_of_init(struct device_node *node,
 	if (of_property_read_u32(node, "valid-mask", &valid_mask))
 		valid_mask =3D 0;
=20
+	writel(clear_mask, base + IRQ_ENABLE_CLEAR);
+	writel(clear_mask, base + FIQ_ENABLE_CLEAR);
+
 	/* Some chips are cascaded from a parent IRQ */
 	parent_irq =3D irq_of_parse_and_map(node, 0);
 	if (!parent_irq) {
@@ -221,9 +224,6 @@ int __init fpga_irq_of_init(struct device_node *node,
=20
 	fpga_irq_init(base, node->name, 0, parent_irq, valid_mask, node);
=20
-	writel(clear_mask, base + IRQ_ENABLE_CLEAR);
-	writel(clear_mask, base + FIQ_ENABLE_CLEAR);
-
 	/*
 	 * On Versatile AB/PB, some secondary interrupts have a direct
 	 * pass-thru to the primary controller for IRQs 20 and 22-31 which need
--=20
2.25.2

