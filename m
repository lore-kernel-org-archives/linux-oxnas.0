Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web10.9196.1690814488503076032
 for <linux-oxnas@groups.io>;
 Mon, 31 Jul 2023 07:41:28 -0700
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-31771a876b5so3842528f8f.3
        for <linux-oxnas@groups.io>; Mon, 31 Jul 2023 07:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690814487; x=1691419287;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JAubY8Z1P2UokdHiqhtu3vCSehB8nCL6u2kffHNDAxs=;
        b=AUF4ov8Iixud6J9zS0ULeeMO0eGWm7mW0mi4AXM3WL+a9wZt/bx8vnCP17yRww0ckd
         B2MzuDfhDPGNbMghHBjjXeOStooe53yEvB15BF95vrGnsWUu+pmi+4rlhnQgxSWaE2J6
         PYSajlMOlZY5+Dzouc9h+zzISVwDajpYQ4uOc5kaY/E4cefPoxPJ3FPj4aFQte9kkFvk
         u+QVytIhgwo7FBgYvNzFN5/SadKO61r18SVjhIGUJmqG2lL1BaXjrYEd40dqttVXBFA0
         iblUpwBRf4G7xZz5qAMOT1i7/la3O+wYwQV2pT70lTWGxfrAsXZIixXkne8VQRWfQzYg
         gk8Q==
Return-Path: <neil.armstrong@linaro.org>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Date: Mon, 31 Jul 2023 16:41:11 +0200
Subject: [PATCH net-next v3 2/2] dt-bindings: net: oxnas-dwmac: remove obsolete bindings
MIME-Version: 1.0
Message-Id: <20230731-topic-oxnas-upstream-remove-v3-2-a1bddb085629@linaro.org>
References: <20230731-topic-oxnas-upstream-remove-v3-0-a1bddb085629@linaro.org>
In-Reply-To: <20230731-topic-oxnas-upstream-remove-v3-0-a1bddb085629@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2203;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=WWAewszZaAHurbGkUxcBGJ6GDkRuE9cM+WDXKbpY0xY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkx8gS1TRmFKi1+xt8uDPsnx1sL0IzKB9M5omlr9Sy
 rUuNrEWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZMfIEgAKCRB33NvayMhJ0btUEA
 DEk4H3MLBfZh8zYgTUsqf0fYd7vq08z2cXu+hFnxsas87nXiUF1kr1y5uLkwlON1K8YZ0D8oX0jjWi
 Sqb3xSYL9bDBdQ8pgF3oYzliqGCcETsaGCmfvLIHM+iNxZgYmaDdGkbvyhotY97V68vDwQqwmXoFiL
 WxiwEGiRCZj/mlL2ZO0U0So8wC3Ml/x1JrWkVcFuqNeF4Nv1d1NoijKajk5ZxkOkBT8ldgZngxW678
 RBfaTexnBMPQl+U7VZbiDOrYrrE65JBtup4q8V7+UxlzGACwEpBfgu7HkmxfGVZT4mv3yIVu3w4bX7
 EBEs5x8NjbX2tXMu8IyY3ebxUbeWakn1LWqjeshqVrEjM1rtIVXFpLUEWpm1hYLAPSFFCs5q2s0WUb
 K+bc/EmtQ+tOsbfkaKLqXCdpmWbDLfZ+vNzLG5/Ou0BF1YjZxKxqWUEUGSVa1yKjhCTFMIp+QbRaah
 eyhmQGS3VHoaCi0OhDsV+FSe0Dt4clq8eXzZeLkV8yrlqj5ZeIV7NRzj32Uqwt908h6/ojkyO8E3cg
 rD1YpIwcj0D10xwVZe7q4lsbc18NVFPLHbArTVsY21qTA3f/eugNYmxPUSiz+AjWh6jtX+XGGL+9z4
 4f+lk3fEOJua2zq2tbv/NAB8r6PD3WdB9YCIrORWgDddyzed4ps5dUnEBZbQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io, devicetree@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Daniel Golle <daniel@makrotopia.org>, Conor Dooley <conor.dooley@microchip.com>
List-ID: <linux-oxnas@groups.io>

Due to lack of maintenance and stall of development for a few years now,
and since no new features will ever be added upstream, remove the
OX810 and OX820 dwmac glue.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Daniel Golle <daniel@makrotopia.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
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

