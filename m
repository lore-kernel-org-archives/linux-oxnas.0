Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [91.198.250.253])
 by mx.groups.io with SMTP id smtpd.web11.20549.1584551479300433691
 for <linux-oxnas@groups.io>;
 Wed, 18 Mar 2020 10:11:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gorani.run; s=MBO0001;
	t=1584551476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rjeQJtst2T6i2m2bmZKswd/k9BXvMflb7UrV/wjEqqA=;
	b=xESSd49PLCdfXlqlQWuJ+m4wfH0gYPY4nAy0F2G3ZYImoo0HugUoRXJVig5pRYeeeqrvhc
	PxKCJ6Z1g05HxUHMF6Vjh1rx9JtYgEQ6zAOqZwtqtyPhHhZ1QiNWpD2nt76YGR9HjZnc7D
	4XtPN0QmKyRe/gMmVy5m9F07e5iU/I0iqD6DaFyJJgNZf59AjByqNn+rLr5Rwneuubcp99
	Rw3S9SIaMhEAk68OmLaj5W4fHr69yhOLSVFKaTTNFJCyB0jJT9aAhUBOrkt35fFqXrvunZ
	5lPXEbqeIVegUx10nJlGqZwthV7sOP0Y1wfGnGzpX2VmT+xbiqseuVPWCOcaHQ==
From: Sungbo Eo <mans0n@gorani.run>
Subject: [PATCH] irqchip/versatile-fpga: Handle chained IRQs properly
Date: Thu, 19 Mar 2020 02:09:04 +0900
Message-Id: <20200318170904.1461278-1-mans0n@gorani.run>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: linux-oxnas@groups.io, Linus Walleij <linus.walleij@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Sungbo Eo <mans0n@gorani.run>, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <linux-oxnas@groups.io>

Enclose the chained handler with chained_irq_{enter,exit}(), so that the
muxed interrupts get properly acked.

This patch also fixes a reboot bug on OX820 SoC, where the jiffies timer
interrupt is never acked. The kernel waits a clock tick forever in
calibrate_delay_converge(), which leads to a boot hang.

Signed-off-by: Sungbo Eo <mans0n@gorani.run>
Cc: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/irqchip/irq-versatile-fpga.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-versatile-fpga.c b/drivers/irqchip/irq-v=
ersatile-fpga.c
index 928858dada75..08faab2fec3e 100644
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
@@ -68,12 +69,15 @@ static void fpga_irq_unmask(struct irq_data *d)
=20
 static void fpga_irq_handle(struct irq_desc *desc)
 {
+	struct irq_chip *chip =3D irq_desc_get_chip(desc);
 	struct fpga_irq_data *f =3D irq_desc_get_handler_data(desc);
 	u32 status =3D readl(f->base + IRQ_STATUS);
=20
+	chained_irq_enter(chip, desc);
+
 	if (status =3D=3D 0) {
 		do_bad_IRQ(desc);
-		return;
+		goto out;
 	}
=20
 	do {
@@ -82,6 +86,9 @@ static void fpga_irq_handle(struct irq_desc *desc)
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

