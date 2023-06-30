Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web10.19026.1688144331208255119
 for <linux-oxnas@groups.io>;
 Fri, 30 Jun 2023 09:58:51 -0700
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-313e23d0a28so2499745f8f.3
        for <linux-oxnas@groups.io>; Fri, 30 Jun 2023 09:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688144329; x=1690736329;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mzdCRnaBwBQAhFPX1zVzW3RmN9xDM93pF5tFymWV6X8=;
        b=KavE9YeYA5wyEkwsKN8Hnf0sIdOAps4fHdE44xnrjfDYsaNFZ8124fBGu1uB0AEopm
         wz/339nO+tcqpPZuEY46HvcJcu9KSCk2AC7b+7TViuyfqsSJ8ho+JDbcGFOm3oW7dKN3
         SECzM2vCmqFzXFXi8u0kONLRoqTjvKV3rsUiBRECzRpGsga4Q+tBZVu56PlKimo7jC8I
         EgtSDrq1lFKkbtG8Ef5pbgaptxEoIJRDbCeUykQWBpkW01JTwqIew5LPXvv0XdGrukO5
         bH04r9XzeIDtMaKiKiXwZ7hiuHFxkByADaKR8R801NZauvHoDjc8uEr4DyitjHQ4/uLs
         fH8g==
Return-Path: <neil.armstrong@linaro.org>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Date: Fri, 30 Jun 2023 18:58:33 +0200
Subject: [PATCH v2 08/15] dt-bindings: net: oxnas-dwmac: remove obsolete bindings
MIME-Version: 1.0
Message-Id: <20230630-topic-oxnas-upstream-remove-v2-8-fb6ab3dea87c@linaro.org>
References: <20230630-topic-oxnas-upstream-remove-v2-0-fb6ab3dea87c@linaro.org>
In-Reply-To: <20230630-topic-oxnas-upstream-remove-v2-0-fb6ab3dea87c@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2150;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=TLDrcb0mzwLI06ByewFdMOz8nc1IDfSB9k98JAwmgYI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBknwm3h8ExnMBya+L7ppxVXE2kolWWvQzXeql91gvK
 3+FRKWOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJ8JtwAKCRB33NvayMhJ0TcTD/
 49DmQNUye4umPLTMTCCVgbCtNVJnEqPD1yc38kQmygaiwUUL4p3pz0vbeCvj4ah6wu6WO+XRXqO0gQ
 3k854on6XQUHo9WrsI6NjE6HooFs84KtwrRG00j4Q1eOa0jGdK0HBjP0Py8hGuEHOQlmE3k+HF40+T
 b+T0qeWwVShG9ulHY3KNZdNF4NaQxia8Hc6gD2wxvqa9v/0OQ5zeGclkMBLecEFnQ9fJWqbyK0Smil
 f+UYvCvqSZnJ+kJjTx/C4uMU3yKJAAN2ZBioc/NYQTfd9Ao7We+j131ZZdxzbbiPZk10JdshwTWIVw
 hHEBPbng8MZ+L+DixJfbqX1+7EOZJbtrFZQZ/nhXrV11IGac36jlbj6qx66dR4pKpR7gk4vTTlnrU+
 5FYspLKqZwbP1JP4QcJzm4UI1moYpO/7HQTM7duxBYz05ojPgMch2OsmFWan4Vijea0dkux5MWOA3W
 k+D/2E1Rq7qy6FRLDZQpRs3mJyOv0xO3NUbrSxKol//M/yMsNBGEXZrZpWAUUfIrOee3adJp+CdL82
 P5q00RhvgockGnpC1hG5wKP0yRKgORY5nFDbWDIwuGhzUDBMhVT7MUujUqLyipH2e/Z8ZUMImThizb
 JOwoQ062na9BGzhuWa3S2u3m9KYCZD8xurvT7t19cdpUO0lWiIRLKh2RgE/w==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>, Sebastian Reichel <sre@kernel.org>, Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-mtd@lists.infradead.org, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-oxnas@groups.io, Neil Armstrong <neil.armstrong@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Daniel Golle <daniel@makrotopia.org>
List-ID: <linux-oxnas@groups.io>

Due to lack of maintenance and stall of development for a few years now,
and since no new features will ever be added upstream, remove the
OX810 and OX820 dwmac glue.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../devicetree/bindings/net/oxnas-dwmac.txt        | 41 ----------------------
 1 file changed, 41 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/oxnas-dwmac.txt b/Documentation/devicetree/bindings/net/oxnas-dwmac.txt
deleted file mode 100644
index 27db496f1ce8..000000000000
--- a/Documentation/devicetree/bindings/net/oxnas-dwmac.txt
+++ /dev/null
@@ -1,41 +0,0 @@
-* Oxford Semiconductor OXNAS DWMAC Ethernet controller
-
-The device inherits all the properties of the dwmac/stmmac devices
-described in the file stmmac.txt in the current directory with the
-following changes.
-
-Required properties on all platforms:
-
-- compatible:	For the OX820 SoC, it should be :
-		- "oxsemi,ox820-dwmac" to select glue
-		- "snps,dwmac-3.512" to select IP version.
-		For the OX810SE SoC, it should be :
-		- "oxsemi,ox810se-dwmac" to select glue
-		- "snps,dwmac-3.512" to select IP version.
-
-- clocks: Should contain phandles to the following clocks
-- clock-names:	Should contain the following:
-		- "stmmaceth" for the host clock - see stmmac.txt
-		- "gmac" for the peripheral gate clock
-
-- oxsemi,sys-ctrl: a phandle to the system controller syscon node
-
-Example :
-
-etha: ethernet@40400000 {
-	compatible = "oxsemi,ox820-dwmac", "snps,dwmac-3.512";
-	reg = <0x40400000 0x2000>;
-	interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
-	interrupt-names = "macirq", "eth_wake_irq";
-	mac-address = [000000000000]; /* Filled in by U-Boot */
-	phy-mode = "rgmii";
-
-	clocks = <&stdclk CLK_820_ETHA>, <&gmacclk>;
-	clock-names = "gmac", "stmmaceth";
-	resets = <&reset RESET_MAC>;
-
-	/* Regmap for sys registers */
-	oxsemi,sys-ctrl = <&sys>;
-
-};

-- 
2.34.1

