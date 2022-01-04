Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web09.7783.1641307939355712082
 for <linux-oxnas@groups.io>;
 Tue, 04 Jan 2022 06:52:19 -0800
Received: by mail-wr1-f44.google.com with SMTP id r17so76674177wrc.3
        for <linux-oxnas@groups.io>; Tue, 04 Jan 2022 06:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CE9wC1I8Y3S4XjOVWKsIkWX1PPAYp2L1AtPQgtpQePQ=;
        b=Glp0dKp29nU4yXeghEDQr2iDSZMAXFTnQ7bOgIkaML2Vu/d/mB7XCDQ8EH3AUcW7m+
         rozyVDSuCz5Cyi5gj1cjC0iWsRsviHskHscxURkh0dx30nDv2D9m0hdI/o6EeODcuD7C
         okbaoGoqznvIobpoboDqgMgilMW/V+rb3Dwlumy/68SMTjtiLFWEAVs+tfHLqvHr5h4k
         1A6uqnXZ80wywuKduleS4/ORhbgE9nrepvolcMv7jsMPSV3SsX6EMO1mA3y3dcINKjTN
         98liTF6YFZQdvqJShmRYS78VuywWMYHI41Kg2syoTamNpn+CpqrIsvVh3oinMATHGwaV
         qwuA==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 4/4] ARM: dts: ox810se: Add DMA Support
Date: Tue,  4 Jan 2022 15:52:06 +0100
Message-Id: <20220104145206.135524-5-narmstrong@baylibre.com>
In-Reply-To: <20220104145206.135524-1-narmstrong@baylibre.com>
References: <20220104145206.135524-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: vkoul@kernel.org
Cc: linux-oxnas@groups.io, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <linux-oxnas@groups.io>

This adds the DMA engine node.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/boot/dts/ox810se-wd-mbwe.dts |  4 ++++
 arch/arm/boot/dts/ox810se.dtsi        | 21 +++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/ox810se-wd-mbwe.dts b/arch/arm/boot/dts/ox810se-wd-mbwe.dts
index 7e2fcb220aea..19e5d510e425 100644
--- a/arch/arm/boot/dts/ox810se-wd-mbwe.dts
+++ b/arch/arm/boot/dts/ox810se-wd-mbwe.dts
@@ -103,6 +103,10 @@ rtc0: rtc@48 {
 	};
 };
 
+&dma {
+	status = "okay";
+};
+
 &uart1 {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/ox810se.dtsi b/arch/arm/boot/dts/ox810se.dtsi
index 0755e5864c4a..79b2b49dcfbb 100644
--- a/arch/arm/boot/dts/ox810se.dtsi
+++ b/arch/arm/boot/dts/ox810se.dtsi
@@ -334,6 +334,27 @@ timer0: timer@200 {
 					interrupts = <4 5>;
 				};
 			};
+
+			dma: dma-controller@600000 {
+				compatible = "oxsemi,ox810se-dma";
+				reg = <0x600000 0x100000>,
+				      <0xc00000 0x100000>;
+				reg-names = "dma", "sgdma";
+				interrupts = <13>, <14>, <15>, <16>, <20>;
+				clocks = <&stdclk 1>;
+				resets = <&reset 8>, <&reset 24>;
+				reset-names = "dma", "sgdma";
+
+				/* Encodes the authorized memory types */
+				oxsemi,targets-types =
+					<0x45900000 0x45a00000 0>,  /* SATA */
+					<0x42000000 0x43000000 0>,  /* SATA DATA */
+					<0x48000000 0x58000000 15>, /* DDR */
+					<0x58000000 0x58020000 15>; /* SRAM */
+
+				#dma-cells = <1>;
+				dma-channels = <5>;
+			};
 		};
 	};
 };
-- 
2.25.1

