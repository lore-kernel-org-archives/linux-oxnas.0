Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web11.7683.1641308214536951397
 for <linux-oxnas@groups.io>;
 Tue, 04 Jan 2022 06:56:54 -0800
Received: by mail-wm1-f54.google.com with SMTP id bg19-20020a05600c3c9300b0034565e837b6so964830wmb.1
        for <linux-oxnas@groups.io>; Tue, 04 Jan 2022 06:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LdTwZGxCheARq/wJIuWjWJ8sp/mwhWyuDBxIP8mBS6U=;
        b=v34JDOGQMu4HacktV6iM+J7XQg8eVx9rVL1BZURGs/Bkd73fnh3VbcD9k/hOoJdBiZ
         LmFjvaSYnjzDphIZJHHV17WuCWl1meuqMYTQC+AOR40GZVIP8AlMsaGQue5C9/SGpDJ9
         cJkgtzmNRipbLedhK+T8cvdx2IeDnM/93fk/JAVZDb3A03/QuuzEn9RCrb6c8TjO0JF3
         aQcDXwXOI4D04RlLkvMIj45EnpaaHsjG+6SlhzAIbN33+dXhDrWAK/XMkuuI1SEoJRki
         P8d0E92BbJt1MGKgxPWCo722uXJvOQDcprwUhVs8HmDA8Ic3UrqcZ0FYak2D9FQRV9uc
         F0bQ==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH net-next v2 2/3] net: stmmac: dwmac-oxnas: Add support for OX810SE
Date: Tue,  4 Jan 2022 15:56:45 +0100
Message-Id: <20220104145646.135877-3-narmstrong@baylibre.com>
In-Reply-To: <20220104145646.135877-1-narmstrong@baylibre.com>
References: <20220104145646.135877-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: davem@davemloft.net, kuba@kernel.org
Cc: netdev@vger.kernel.org, linux-oxnas@groups.io, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <linux-oxnas@groups.io>

Add support for OX810SE dwmac glue setup, which is a simplified version
of the OX820 introduced later with more control on the PHY interface.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-oxnas.c | 115 +++++++++++++-----
 1 file changed, 86 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-oxnas.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-oxnas.c
index adfeb8d3293d..62a69a91ab22 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-oxnas.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-oxnas.c
@@ -12,6 +12,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/mfd/syscon.h>
@@ -48,16 +49,75 @@
 #define DWMAC_RX_VARDELAY(d)		((d) << DWMAC_RX_VARDELAY_SHIFT)
 #define DWMAC_RXN_VARDELAY(d)		((d) << DWMAC_RXN_VARDELAY_SHIFT)
 
+struct oxnas_dwmac;
+
+struct oxnas_dwmac_data {
+	int (*setup)(struct oxnas_dwmac *dwmac);
+};
+
 struct oxnas_dwmac {
 	struct device	*dev;
 	struct clk	*clk;
 	struct regmap	*regmap;
+	const struct oxnas_dwmac_data	*data;
 };
 
+static int oxnas_dwmac_setup_ox810se(struct oxnas_dwmac *dwmac)
+{
+	unsigned int value;
+	int ret;
+
+	ret = regmap_read(dwmac->regmap, OXNAS_DWMAC_CTRL_REGOFFSET, &value);
+	if (ret < 0)
+		return ret;
+
+	/* Enable GMII_GTXCLK to follow GMII_REFCLK, required for gigabit PHY */
+	value |= BIT(DWMAC_CKEN_GTX)		|
+		 /* Use simple mux for 25/125 Mhz clock switching */
+		 BIT(DWMAC_SIMPLE_MUX);
+
+	regmap_write(dwmac->regmap, OXNAS_DWMAC_CTRL_REGOFFSET, value);
+
+	return 0;
+}
+
+static int oxnas_dwmac_setup_ox820(struct oxnas_dwmac *dwmac)
+{
+	unsigned int value;
+	int ret;
+
+	ret = regmap_read(dwmac->regmap, OXNAS_DWMAC_CTRL_REGOFFSET, &value);
+	if (ret < 0)
+		return ret;
+
+	/* Enable GMII_GTXCLK to follow GMII_REFCLK, required for gigabit PHY */
+	value |= BIT(DWMAC_CKEN_GTX)		|
+		 /* Use simple mux for 25/125 Mhz clock switching */
+		BIT(DWMAC_SIMPLE_MUX)		|
+		/* set auto switch tx clock source */
+		BIT(DWMAC_AUTO_TX_SOURCE)	|
+		/* enable tx & rx vardelay */
+		BIT(DWMAC_CKEN_TX_OUT)		|
+		BIT(DWMAC_CKEN_TXN_OUT)	|
+		BIT(DWMAC_CKEN_TX_IN)		|
+		BIT(DWMAC_CKEN_RX_OUT)		|
+		BIT(DWMAC_CKEN_RXN_OUT)	|
+		BIT(DWMAC_CKEN_RX_IN);
+	regmap_write(dwmac->regmap, OXNAS_DWMAC_CTRL_REGOFFSET, value);
+
+	/* set tx & rx vardelay */
+	value = DWMAC_TX_VARDELAY(4)	|
+		DWMAC_TXN_VARDELAY(2)	|
+		DWMAC_RX_VARDELAY(10)	|
+		DWMAC_RXN_VARDELAY(8);
+	regmap_write(dwmac->regmap, OXNAS_DWMAC_DELAY_REGOFFSET, value);
+
+	return 0;
+}
+
 static int oxnas_dwmac_init(struct platform_device *pdev, void *priv)
 {
 	struct oxnas_dwmac *dwmac = priv;
-	unsigned int value;
 	int ret;
 
 	/* Reset HW here before changing the glue configuration */
@@ -69,35 +129,11 @@ static int oxnas_dwmac_init(struct platform_device *pdev, void *priv)
 	if (ret)
 		return ret;
 
-	ret = regmap_read(dwmac->regmap, OXNAS_DWMAC_CTRL_REGOFFSET, &value);
-	if (ret < 0) {
+	ret = dwmac->data->setup(dwmac);
+	if (ret)
 		clk_disable_unprepare(dwmac->clk);
-		return ret;
-	}
 
-	/* Enable GMII_GTXCLK to follow GMII_REFCLK, required for gigabit PHY */
-	value |= BIT(DWMAC_CKEN_GTX)		|
-		 /* Use simple mux for 25/125 Mhz clock switching */
-		 BIT(DWMAC_SIMPLE_MUX)		|
-		 /* set auto switch tx clock source */
-		 BIT(DWMAC_AUTO_TX_SOURCE)	|
-		 /* enable tx & rx vardelay */
-		 BIT(DWMAC_CKEN_TX_OUT)		|
-		 BIT(DWMAC_CKEN_TXN_OUT)	|
-		 BIT(DWMAC_CKEN_TX_IN)		|
-		 BIT(DWMAC_CKEN_RX_OUT)		|
-		 BIT(DWMAC_CKEN_RXN_OUT)	|
-		 BIT(DWMAC_CKEN_RX_IN);
-	regmap_write(dwmac->regmap, OXNAS_DWMAC_CTRL_REGOFFSET, value);
-
-	/* set tx & rx vardelay */
-	value = DWMAC_TX_VARDELAY(4)	|
-		DWMAC_TXN_VARDELAY(2)	|
-		DWMAC_RX_VARDELAY(10)	|
-		DWMAC_RXN_VARDELAY(8);
-	regmap_write(dwmac->regmap, OXNAS_DWMAC_DELAY_REGOFFSET, value);
-
-	return 0;
+	return ret;
 }
 
 static void oxnas_dwmac_exit(struct platform_device *pdev, void *priv)
@@ -128,6 +164,12 @@ static int oxnas_dwmac_probe(struct platform_device *pdev)
 		goto err_remove_config_dt;
 	}
 
+	dwmac->data = (const struct oxnas_dwmac_data *)of_device_get_match_data(&pdev->dev);
+	if (!dwmac->data) {
+		ret = -EINVAL;
+		goto err_remove_config_dt;
+	}
+
 	dwmac->dev = &pdev->dev;
 	plat_dat->bsp_priv = dwmac;
 	plat_dat->init = oxnas_dwmac_init;
@@ -166,8 +208,23 @@ static int oxnas_dwmac_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static const struct oxnas_dwmac_data ox810se_dwmac_data = {
+	.setup = oxnas_dwmac_setup_ox810se,
+};
+
+static const struct oxnas_dwmac_data ox820_dwmac_data = {
+	.setup = oxnas_dwmac_setup_ox820,
+};
+
 static const struct of_device_id oxnas_dwmac_match[] = {
-	{ .compatible = "oxsemi,ox820-dwmac" },
+	{
+		.compatible = "oxsemi,ox810se-dwmac",
+		.data = &ox810se_dwmac_data,
+	},
+	{
+		.compatible = "oxsemi,ox820-dwmac",
+		.data = &ox820_dwmac_data,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, oxnas_dwmac_match);
-- 
2.25.1

