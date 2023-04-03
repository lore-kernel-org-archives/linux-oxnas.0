Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web10.64449.1680507748418883923
 for <linux-oxnas@groups.io>;
 Mon, 03 Apr 2023 00:42:28 -0700
Received: by mail-wr1-f44.google.com with SMTP id l12so28240432wrm.10
        for <linux-oxnas@groups.io>; Mon, 03 Apr 2023 00:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680507747;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nAqvm5zsozuKX98Wuo0u9Kq1oEhbjhsKVQ5yonQAyjM=;
        b=FP9x/tmhDk46p4CDKJ0YJ/jBwiTSwINc+JTp1WfWI4qFoQVV67S55Zrk2ZA70+5kCw
         qafzZoitSidQX3Ltjamyj5jCPNxJZCTvrmO2UvKiD2DuDj4kf8JARnCwZFrlLUM9eg71
         jmV0mVxcgLy7gv5tXH1IpsA8NhIYuY8a4xUk1ugnHwCv/vRVJfMkG57r+73Xwc48hbGd
         ovs713IvgGeOsjV2xGPm1+txak5cfvuHRtDZ/4yz3k+QnMoAnro7jVceOuzyYJKQbfte
         cTzg2lS4oc4V0SoAyTmd8JjVbC68Q9MWvMIFNDIlTsROMeM9nZd4c0YIvXT472IME14y
         ZM3A==
Return-Path: <neil.armstrong@linaro.org>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Date: Mon, 03 Apr 2023 09:42:21 +0200
Subject: [PATCH RFC v2 4/4] dt-bindings: arm: oxnas: remove obsolete bindings
MIME-Version: 1.0
Message-Id: <20230331-topic-oxnas-upstream-remove-v2-4-e51078376f08@linaro.org>
References: <20230331-topic-oxnas-upstream-remove-v2-0-e51078376f08@linaro.org>
In-Reply-To: <20230331-topic-oxnas-upstream-remove-v2-0-e51078376f08@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, soc@kernel.org, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-oxnas@groups.io, Neil Armstrong <neil.armstrong@linaro.org>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Daniel Golle <daniel@makrotopia.org>
List-ID: <linux-oxnas@groups.io>

Due to lack of maintainance and stall of development for a few years now,
and since no new features will ever be added upstream, remove the
OX810 and OX820 SoC and boards bindings.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/arm/oxnas.txt | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/oxnas.txt b/Documentation/devicetree/bindings/arm/oxnas.txt
deleted file mode 100644
index ac64e60f99f1..000000000000
--- a/Documentation/devicetree/bindings/arm/oxnas.txt
+++ /dev/null
@@ -1,14 +0,0 @@
-Oxford Semiconductor OXNAS SoCs Family device tree bindings
--------------------------------------------
-
-Boards with the OX810SE SoC shall have the following properties:
-  Required root node property:
-    compatible: "oxsemi,ox810se"
-
-Boards with the OX820 SoC shall have the following properties:
-  Required root node property:
-    compatible: "oxsemi,ox820"
-
-Board compatible values:
-  - "wd,mbwe" (OX810SE)
-  - "cloudengines,pogoplugv3" (OX820)

-- 
2.34.1

