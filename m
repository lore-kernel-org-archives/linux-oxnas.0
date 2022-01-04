Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web09.4169.1641283925048197553
 for <linux-oxnas@groups.io>;
 Tue, 04 Jan 2022 00:12:05 -0800
Received: by mail-wr1-f52.google.com with SMTP id d9so74559457wrb.0
        for <linux-oxnas@groups.io>; Tue, 04 Jan 2022 00:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EjC9RoatGf4NuVo6mZRinaRaNOZbl6EwcNrtjHiT4O4=;
        b=6ScPUR6RRUF4Hkoa6MmmfZ0Jm19OyRs5f/VHCuLH3o3qfhAhnqHb565uq5tXaACcdI
         x8D0QB84cRQaHye70QlbPApmyxr9DFZiz6uIb4D1VA9HvBZxFlt1dtA+MSyRqjPYkckI
         Xr8lRHaagCRg2zY92rQSigDefATaIiyPTEgfz+uaBFquyZoP5rpys+9oLaUDk/VDGL/Q
         JZOEje4yn+C96isl5CfXCDFWoXShitrc38EsrTFF1EVyLxq0q3eHY1vbA7ufrdzPv/0i
         2wzQXSxVvczstzmy5UmtBMY24rEhGB5yFC5ud1HU+y6iLboyDkv+QdTYLLV4NDvWvlZd
         bWPg==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 3/3] ARM: dts: ox810se: Add Ethernet support
Date: Tue,  4 Jan 2022 09:11:55 +0100
Message-Id: <20220104081155.91120-1-narmstrong@baylibre.com>
In-Reply-To: <20220103175638.89625-1-narmstrong@baylibre.com>
References: <20220103175638.89625-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: linux-oxnas@groups.io
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <linux-oxnas@groups.io>

Add nodes for the embedded Synopsys DWMAC Ethernet controller.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/boot/dts/ox810se-wd-mbwe.dts |  4 ++++
 arch/arm/boot/dts/ox810se.dtsi        | 18 ++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/ox810se-wd-mbwe.dts b/arch/arm/boot/dts/ox810se-wd-mbwe.dts
index 7e2fcb220aea..c59e06ff2423 100644
--- a/arch/arm/boot/dts/ox810se-wd-mbwe.dts
+++ b/arch/arm/boot/dts/ox810se-wd-mbwe.dts
@@ -103,6 +103,10 @@ rtc0: rtc@48 {
 	};
 };
 
+&etha {
+	status = "okay";
+};
+
 &uart1 {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/ox810se.dtsi b/arch/arm/boot/dts/ox810se.dtsi
index 0755e5864c4a..96c0745f7b70 100644
--- a/arch/arm/boot/dts/ox810se.dtsi
+++ b/arch/arm/boot/dts/ox810se.dtsi
@@ -81,6 +81,24 @@ soc {
 		ranges;
 		interrupt-parent = <&intc>;
 
+		etha: ethernet@40400000 {
+			compatible = "oxsemi,ox810se-dwmac", "snps,dwmac";
+			reg = <0x40400000 0x2000>;
+			interrupts = <8>;
+			interrupt-names = "macirq";
+			mac-address = [000000000000]; /* Filled in by U-Boot */
+			phy-mode = "rgmii";
+
+			clocks = <&stdclk 6>, <&gmacclk>;
+			clock-names = "gmac", "stmmaceth";
+			resets = <&reset 6>;
+
+			/* Regmap for sys registers */
+			oxsemi,sys-ctrl = <&sys>;
+
+			status = "disabled";
+		};
+
 		apb-bridge@44000000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
2.25.1

