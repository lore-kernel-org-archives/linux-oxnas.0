Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web10.19032.1688144335979994785
 for <linux-oxnas@groups.io>;
 Fri, 30 Jun 2023 09:58:56 -0700
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-3fbc244d386so16639275e9.2
        for <linux-oxnas@groups.io>; Fri, 30 Jun 2023 09:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688144334; x=1690736334;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RLUKsP4vp/raKLTHtwvUFRJTqG/hdN77zosI8Yw2myw=;
        b=sVa5c1v/DkueUOCsS+MIb0EGouW76eY2gyfiQAQ4dSKuCyWJeA3bmBrQGzimmySJuV
         ZVoIoSrizM9pksB1Dl100COoWxOSVIdEUmsw3NH5eCfLyGUKi0XFhVF5U4lNd2oNuoGI
         E1NNYCk5HgtBo5I1sDgcdZ+iHACj6rVf1u6Hb18pHJv1QWD4WP1P8yFeUJ1xExTJugXL
         AUMNLcvs7hbekeaX5QrGQliSFPKvjFwhdHL0bQcwuSTxv2A7xsgHuDl2sBn8YtxqtlJv
         sySMd6ET4xfwk3ENv5SaF2DyQm0jF+J4vjCXZC9c5IxmIZQG1kr28S74KPLOlSrPp8M0
         uFVw==
Return-Path: <neil.armstrong@linaro.org>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Date: Fri, 30 Jun 2023 18:58:36 +0200
Subject: [PATCH v2 11/15] dt-bindings: gpio: gpio_oxnas: remove obsolete bindings
MIME-Version: 1.0
Message-Id: <20230630-topic-oxnas-upstream-remove-v2-11-fb6ab3dea87c@linaro.org>
References: <20230630-topic-oxnas-upstream-remove-v2-0-fb6ab3dea87c@linaro.org>
In-Reply-To: <20230630-topic-oxnas-upstream-remove-v2-0-fb6ab3dea87c@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2380;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Dz983lZEvCc6SwFVyqblurV6ZIa65HUG1Xc2A0bqn7M=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBknwm4wJTRSSerqNYfifwQ1Pt541qqx0tcBG6P43WV
 xd4i9FuJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJ8JuAAKCRB33NvayMhJ0XPgEA
 DCjZvFC0V3ejPt1N0/o80mIHNA0zrhPM/j3UrO6bINU5AQsXNX1xP2zjlRpgKhTOC9Kry0IhDZCdD5
 WL0T2vk+BI+Va3NzwJv213/b8bECOoXLNNE6WIquR51sKxTq3iexFaN7SAKORBYZWNzJpqTfu/41Nt
 DliCF/6SErEstzu8aItxlKrfbuLYcgjaDIkLnrP9zxkcxTu21ZPLY1vD57YMLHZSxik4e/3FGMbWpp
 2Pg+BIVRh/IH00JwzMSdBgAzumU8ANPQGXe3ATTr+xDKPk+WJpNXQXOYpUhyYjLs1QNGZ3MPP7YZde
 iUEmJ9HxUiOQaiyDcISadusL+ObaqjGz3rTFmir3Jexj5wGgO2FKcNgDcCAJCoxMMGrw1WKLpTUgH2
 8HVN1jqaV/0baqMaKlTovePXtHWdHYjASjVeY/bTjirRqJT4RPeGlIvE2FsUcTduyhLiw6IxTOWLhK
 lva9N1TCBRTx3PwzlP1zZ7ufAI1cvHH9mCe9VRBdYBzijNZwC5jid2xpGyQ7npRA8Yycw1QIhlmgvM
 JsNmLwe8dqD3EaBFMKqL/dcMmG6IQDXcKoGIqtYV43O9odb5ReKfMRJM81olt8ArfGto80z6Vsp8a7
 27w7UeMv8YbkcGD1lOGEjg0PMpq1jqZEhb47IOLUWfNsGXYGW1BOJamnxHXw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>, Sebastian Reichel <sre@kernel.org>, Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-mtd@lists.infradead.org, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-oxnas@groups.io, Neil Armstrong <neil.armstrong@linaro.org>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Daniel Golle <daniel@makrotopia.org>
List-ID: <linux-oxnas@groups.io>

Due to lack of maintenance and stall of development for a few years now,
and since no new features will ever be added upstream, remove the
OX810 and OX820 gpio bindings.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../devicetree/bindings/gpio/gpio_oxnas.txt        | 47 ----------------------
 1 file changed, 47 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio_oxnas.txt b/Documentation/devicetree/bindings/gpio/gpio_oxnas.txt
deleted file mode 100644
index 966514744df4..000000000000
--- a/Documentation/devicetree/bindings/gpio/gpio_oxnas.txt
+++ /dev/null
@@ -1,47 +0,0 @@
-* Oxford Semiconductor OXNAS SoC GPIO Controller
-
-Please refer to gpio.txt for generic information regarding GPIO bindings.
-
-Required properties:
- - compatible: "oxsemi,ox810se-gpio" or "oxsemi,ox820-gpio"
- - reg: Base address and length for the device.
- - interrupts: The port interrupt shared by all pins.
- - gpio-controller: Marks the port as GPIO controller.
- - #gpio-cells: Two. The first cell is the pin number and
-   the second cell is used to specify the gpio polarity as defined in
-   defined in <dt-bindings/gpio/gpio.h>:
-      0 = GPIO_ACTIVE_HIGH
-      1 = GPIO_ACTIVE_LOW
- - interrupt-controller: Marks the device node as an interrupt controller.
- - #interrupt-cells: Two. The first cell is the GPIO number and second cell
-   is used to specify the trigger type as defined in
-   <dt-bindings/interrupt-controller/irq.h>:
-      IRQ_TYPE_EDGE_RISING
-      IRQ_TYPE_EDGE_FALLING
-      IRQ_TYPE_EDGE_BOTH
- - gpio-ranges: Interaction with the PINCTRL subsystem, it also specifies the
-   gpio base and count, should be in the format of numeric-gpio-range as
-   specified in the gpio.txt file.
-
-Example:
-
-gpio0: gpio@0 {
-	compatible = "oxsemi,ox810se-gpio";
-	reg = <0x000000 0x100000>;
-	interrupts = <21>;
-	#gpio-cells = <2>;
-	gpio-controller;
-	interrupt-controller;
-	#interrupt-cells = <2>;
-	gpio-ranges = <&pinctrl 0 0 32>;
-};
-
-keys {
-	...
-
-	button-esc {
-		label = "ESC";
-		linux,code = <1>;
-		gpios = <&gpio0 12 0>;
-	};
-};

-- 
2.34.1

