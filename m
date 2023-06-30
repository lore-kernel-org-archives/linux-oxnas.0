Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web10.19036.1688144342931729171
 for <linux-oxnas@groups.io>;
 Fri, 30 Jun 2023 09:59:03 -0700
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-3fbc656873eso11328995e9.1
        for <linux-oxnas@groups.io>; Fri, 30 Jun 2023 09:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688144341; x=1690736341;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Eyaf/JArFBnOJmUxcF7DoGLYY7fHW+Lur/i45+1eYA=;
        b=cRsI+Jc0zlEoiUnzMwgGVMTkMYll1xolMO9sNUYMp0FooJsUY4ea3qKTvrBPV3W1xS
         PdZIteGitEx9EYSLfRJOYktkFaGNgrjM1fFkOgOEvg9QpZfmPTHRP0w9/N2IQbu4+vs0
         nb54cBQE/s37T2C5zG7nCIR1V1emFvCiO2dgZn0Pz5F2ONkZj2tZtARRUTJGEin0ve2S
         TMKzcm5hDnbkJdr2TIU0CbpiH29R/WxZLmENSPUSj9byP3++sCzxuhKXEZ1zIb6Wn2I2
         cYCa21dnclLHYM4KbKNbtJpA/o/MUiaWI16RbEycKNxYjhX7e3isSa7OfeVEqG9msFcB
         UCYQ==
Return-Path: <neil.armstrong@linaro.org>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Date: Fri, 30 Jun 2023 18:58:40 +0200
Subject: [PATCH v2 15/15] MAINTAINERS: remove OXNAS entry
MIME-Version: 1.0
Message-Id: <20230630-topic-oxnas-upstream-remove-v2-15-fb6ab3dea87c@linaro.org>
References: <20230630-topic-oxnas-upstream-remove-v2-0-fb6ab3dea87c@linaro.org>
In-Reply-To: <20230630-topic-oxnas-upstream-remove-v2-0-fb6ab3dea87c@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1154;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=/Lhm4rki32xogr5e1680FrjcVLCt+j7sMVgTOqF2+4g=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBknwm6aoHZMmN8vUbEzTBcIOV7ONJvx2yeNn0kZRnx
 LgLt0iSJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJ8JugAKCRB33NvayMhJ0aMOD/
 4o1u07bP99PyNkyrdoo5HuA/tEA4HRTOWRFwUBK2Fr4hLcuccLKZbqEoot/K06rPOpWlmBA0xJibYq
 9sx1cEJc+h2Z6AM6bLv21ZYqK5qXiv45NFZpA+avGwHQ3eQR49KMC8+J9Fb92MOTESddkVzr1uu4WE
 e9aJ1LI/ccd/i2cJ1q6JYWT4B5L5cIQbiI/ZtSRz8pqJ4w6w0RKypV0T7VJm80k0Jv8SmEp0Dlp+vG
 2WQAMcwB/wTd8fh2LKmHED0shMiW2MEQuAkLKiPoDPvybnsLhvaPHGkWmSMXRhTZl6DoGzOsvrTeGt
 aTFim1T/5SP8kSCH5IyYKe7HfsE8Yt9gBcyRyqu0NC2ehuN5DgDWJ25XQwf3CLLfN8xEj42a7f9Exr
 zWAe21b8vupE/IPlBZdtLAl4pizrS9O5UPCdYcEh7XVCBa8AMrQci3cdYVfnZjmMz9oQqhg9nYhA0V
 JGXiIp5zNtWsKoFqxPzpq30E48YAl7SC9jsUWLsXeqRm5FyrRsX8HmFPcHSNlOHUHID+XL5ltvxMy9
 5gbGOWZlwiRjX+X7+KZrzjzudA7BX8jOe+INgytdS3AgKSHSOiXc8Sx/ja2xf/Z/Hwp1CQeFZO2eQN
 2DfMAaMQrsOrzJs9Ps4BqxlAh6NcIKGU989Dmfjl521a7QN3/cdOvxA/sGbw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>, Sebastian Reichel <sre@kernel.org>, Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-mtd@lists.infradead.org, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-oxnas@groups.io, Neil Armstrong <neil.armstrong@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Daniel Golle <daniel@makrotopia.org>
List-ID: <linux-oxnas@groups.io>

Due to lack of maintenance and stall of development for a few years now,
and since no new features will ever be added upstream, remove MAINTAINERS
entry for OXNAS files.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 MAINTAINERS | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4545d4287305..cfe1bc884005 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2565,16 +2565,6 @@ S:	Maintained
 W:	http://www.digriz.org.uk/ts78xx/kernel
 F:	arch/arm/mach-orion5x/ts78xx-*
 
-ARM/OXNAS platform support
-M:	Neil Armstrong <neil.armstrong@linaro.org>
-L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-L:	linux-oxnas@groups.io (moderated for non-subscribers)
-S:	Maintained
-F:	arch/arm/boot/dts/ox8*.dts*
-F:	arch/arm/mach-oxnas/
-F:	drivers/power/reset/oxnas-restart.c
-N:	oxnas
-
 ARM/QUALCOMM CHROMEBOOK SUPPORT
 R:	cros-qcom-dts-watchers@chromium.org
 F:	arch/arm64/boot/dts/qcom/sc7180*

-- 
2.34.1

