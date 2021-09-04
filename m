Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
 by mx.groups.io with SMTP id smtpd.web11.5665.1630713950304554432
 for <linux-oxnas@groups.io>;
 Fri, 03 Sep 2021 17:05:50 -0700
Received: by mail-yb1-f202.google.com with SMTP id r15-20020a056902154f00b00598b87f197cso939027ybu.13
        for <linux-oxnas@groups.io>; Fri, 03 Sep 2021 17:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CmiOovZTt1y4cIWEfI47PRt3/MlHznjnR9cha/mAR4c=;
        b=YwL/ZRmVL05ExLE8Uye2bq5sdTwSfXVFJvEJM3RSL7OVnlT4viA1ZPsdqJbNE+RcMg
         UgbROXkOc+awabmhS8Dhd/IfE5Ni+56xWlHUf4Eqgphst0spjSiEsxqxlBXxV6m2Ah+P
         LaZabo3SchFKsQZrmYELQEAmKQVR0XJQMx1Y7YMcU2RCpessU4+lEZPRoEI+GypG8SfW
         PwCI/fte/EJW9+wuc09PN7EbczrDfoIoDp+TcylGNLZ3K+R7g3WutymywjInJTwNdUKp
         tOKHhoauY9ddyjAT4cxP8s+rsbMV7xjnf5qPR1oJUosL0E12HM383vRUS7Me6ht+ZctT
         ydbg==
Date: Fri,  3 Sep 2021 17:05:41 -0700
In-Reply-To: <20210904000543.2019010-1-saravanak@google.com>
Message-Id: <20210904000543.2019010-2-saravanak@google.com>
Mime-Version: 1.0
References: <20210904000543.2019010-1-saravanak@google.com>
Subject: [PATCH v3 1/2] drivers: bus: simple-pm-bus: Add support for probing simple bus only devices
From: Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
To: Russell King <linux@armlinux.org.uk>, Neil Armstrong <narmstrong@baylibre.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Damien Le Moal <damien.lemoal@wdc.com>
Cc: Saravana Kannan <saravanak@google.com>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, kernel-team@android.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-oxnas@groups.io, linux-renesas-soc@vger.kernel.org, linux-omap@vger.kernel.org, linux-riscv@lists.infradead.org
List-ID: <linux-oxnas@groups.io>

fw_devlink could end up creating device links for bus only devices.
However, bus only devices don't get probed and can block probe() or
sync_state() [1] call backs of other devices. To avoid this, probe these
devices using the simple-pm-bus driver.

However, there are instances of devices that are not simple buses (they
get probed by their specific drivers) that also list the "simple-bus"
(or other bus only compatible strings) in their compatible property to
automatically populate their child devices. We still want these devices
to get probed by their specific drivers. So, we make sure this driver
only probes devices that are only buses.

[1] - https://lore.kernel.org/lkml/CAPDyKFo9Bxremkb1dDrr4OcXSpE0keVze94Cm=zrkOVxHHxBmQ@mail.gmail.com/
Signed-off-by: Saravana Kannan <saravanak@google.com>
Tested-by: Saravana Kannan <saravanak@google.com>
---
 drivers/bus/simple-pm-bus.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/simple-pm-bus.c b/drivers/bus/simple-pm-bus.c
index 01a3d0cd08ed..3e086a9f34cb 100644
--- a/drivers/bus/simple-pm-bus.c
+++ b/drivers/bus/simple-pm-bus.c
@@ -13,11 +13,26 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 
-
 static int simple_pm_bus_probe(struct platform_device *pdev)
 {
-	const struct of_dev_auxdata *lookup = dev_get_platdata(&pdev->dev);
-	struct device_node *np = pdev->dev.of_node;
+	const struct device *dev = &pdev->dev;
+	const struct of_dev_auxdata *lookup = dev_get_platdata(dev);
+	struct device_node *np = dev->of_node;
+	const struct of_device_id *match;
+
+	match = of_match_device(dev->driver->of_match_table, dev);
+
+	/*
+	 * These are transparent bus devices (not simple-pm-bus matches) that
+	 * have their child nodes populated automatically.  So, don't need to
+	 * do anything more.
+	 */
+	if (match && match->data) {
+		if (of_property_match_string(np, "compatible", match->compatible) == 0)
+			return 0;
+		else
+			return -ENODEV;
+	}
 
 	dev_dbg(&pdev->dev, "%s\n", __func__);
 
@@ -31,14 +46,25 @@ static int simple_pm_bus_probe(struct platform_device *pdev)
 
 static int simple_pm_bus_remove(struct platform_device *pdev)
 {
+	const void *data = of_device_get_match_data(&pdev->dev);
+
+	if (data)
+		return 0;
+
 	dev_dbg(&pdev->dev, "%s\n", __func__);
 
 	pm_runtime_disable(&pdev->dev);
 	return 0;
 }
 
+#define ONLY_BUS	((void *) 1) /* Match if the device is only a bus. */
+
 static const struct of_device_id simple_pm_bus_of_match[] = {
 	{ .compatible = "simple-pm-bus", },
+	{ .compatible = "simple-bus",	.data = ONLY_BUS },
+	{ .compatible = "simple-mfd",	.data = ONLY_BUS },
+	{ .compatible = "isa",		.data = ONLY_BUS },
+	{ .compatible = "arm,amba-bus",	.data = ONLY_BUS },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, simple_pm_bus_of_match);
-- 
2.33.0.153.gba50c8fa24-goog

