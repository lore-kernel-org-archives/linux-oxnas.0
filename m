Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web11.102965.1692001010607699613
 for <linux-oxnas@groups.io>;
 Mon, 14 Aug 2023 01:16:50 -0700
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-3fe167d4a18so37577815e9.0
        for <linux-oxnas@groups.io>; Mon, 14 Aug 2023 01:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692001009; x=1692605809;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Pe1G74CKDr0t/c1R/w4mEAZ9khtDQBENUlvIvkgD0Y=;
        b=AlsIJ3Hli4koRHVo52AcOzcNnCXIWjQM425mlvpdhezGEMAvL2WOVDVfnz0GbdwguD
         slNTc8BpKMYe9aETDR8Gsq+9hVOg16dvGjCdsOgJILRqSdwHxNBkTDGSEZYFHcrBYg4Q
         MMjJVZQjSm5cbYDgA10Tn//NrYfa8VtJA4kl5zfOunBe2UCryxwW0jqKTWfZUo1VibUj
         kD8kg+6pcxGH+kqoikv2bBl/DFLkMX8CCXROpGp5fugNmf+nTpzMs3RKz1Rv6bw3VUof
         a5Ln5S3ah8//ts7AUyLGHrcbl77zahiKqDGvgJwC/rR+C1l4+eyEteRmSSgEwrXwDBN2
         HWag==
Return-Path: <neil.armstrong@linaro.org>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Date: Mon, 14 Aug 2023 10:16:39 +0200
Subject: [PATCH v3 3/3] dt-bindings: gpio: gpio_oxnas: remove obsolete bindings
MIME-Version: 1.0
Message-Id: <20230814-topic-oxnas-upstream-remove-v3-3-04a0c5cdda52@linaro.org>
References: <20230814-topic-oxnas-upstream-remove-v3-0-04a0c5cdda52@linaro.org>
In-Reply-To: <20230814-topic-oxnas-upstream-remove-v3-0-04a0c5cdda52@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2444;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=jE6ByQZPyn94kajLMkmmnkKqcK01TK88XsXfpl+GUMQ=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBk2eLrjDbTfAEmzdlc5+OVy72+nkloYG/jlpD4hbXa
 p3OXVuyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZNni6wAKCRB33NvayMhJ0XR6EA
 CgJ78xhOK89ymzp6lmIQDll16C4q2KKUwZpYLi19PkP5CHYpod1KfImzp6DZMipWgeNV5BXID4vbFc
 QmdNIQkTjkK9dA8Hf5Qz5Eg4OEOBW5AtBRZqaYxTEZY7lAAx10WH6ykM9DJ1JsvrjqvefO1PunTVKo
 ebeaG0C7j/zmILuEyedPLzWe9pRbSJ0YAeitBmOl2m7NzBdEo9T5foRIK2tp7tWfOrsagovPAiE2cq
 LQeNLBsZuhVYSmoeexUC9oTAq8A0DJBD03OtYj7ypPFc0SKyxvsZ7VDXpj07abZAvv7X1tHKyPfBoD
 KL09HCmsLKWO8qqR0F3JjoVv8L9T7MpfdXbbxtWJWCjVYghU4gN4g9M9yoez6+cz9mB9YFmwlrhDJz
 0SY3yGvAWAi2GGQeJRPWzs4bm7a3LTsQpvi/w1F9/6vdoTdbdf4DbWNpnxa3/0R9j4X8Nn6ZBkh0b/
 TyDymJbacbClLxEvtE4KyVzDjEbbLXYZK9DhhQ3v/5jQetF6u1P0Cq00antay22GdXUDJu4tpo8kg6
 OAs+/3tH4J6VdE7bVpxEobtPrbVIvRn3Rf7CYOJsFlb53iKgcTQwe7sMQa9r94rRtZgWBnlHhdSzfA
 6qH0uQAbjStD4KwG92omB0aHYoteiIuTHrJOW/JCQcTtwvbIgmtNltRr1vGQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io, devicetree@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Daniel Golle <daniel@makrotopia.org>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
List-ID: <linux-oxnas@groups.io>

Due to lack of maintenance and stall of development for a few years now,
and since no new features will ever be added upstream, remove the
OX810 and OX820 gpio bindings.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Daniel Golle <daniel@makrotopia.org>
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
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

