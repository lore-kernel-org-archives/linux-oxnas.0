Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web12.7540.1641308215453818903
 for <linux-oxnas@groups.io>;
 Tue, 04 Jan 2022 06:56:55 -0800
Received: by mail-wm1-f41.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so1582989wme.4
        for <linux-oxnas@groups.io>; Tue, 04 Jan 2022 06:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EjC9RoatGf4NuVo6mZRinaRaNOZbl6EwcNrtjHiT4O4=;
        b=pVKyM/tpT8WV2u9dQSjWb2R2+yIp2RFRzYSVHtO1Z9f1E6ly/Q+A1sfyVjPJHK8nda
         1CJXRxRLD/OQW9iXB6ddlL2BwpjbSXUNER2HA30aAcMNpF2hWRWBjQ1MfdRgBaSszfaT
         7gC90tLlau/wWwAL8N8gqPmmRrrwOGD9o4epZ1DKNRWUDzPi0AEY0Z1hFazx9ec6m/eg
         0MjTRqsZiLYS/tQqN6amr22bO4z8G4xpIz9HXtXucEYIkivGLk84vl2f2pAZdOJ0EqfT
         44zO+/qQYMZQBqdw8zLkXXo/17FcLasTNYxAPFykx6ZMU5vw3N1D12Or/eZzMTe4QhEw
         AAug==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH arm-soc-next v2 3/3] ARM: dts: ox810se: Add Ethernet support
Date: Tue,  4 Jan 2022 15:56:46 +0100
Message-Id: <20220104145646.135877-4-narmstrong@baylibre.com>
In-Reply-To: <20220104145646.135877-1-narmstrong@baylibre.com>
References: <20220104145646.135877-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: davem@davemloft.net, kuba@kernel.org
Cc: netdev@vger.kernel.org, linux-oxnas@groups.io, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>
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

