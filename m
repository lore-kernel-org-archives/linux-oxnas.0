Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web09.32127.1641232603154937342
 for <linux-oxnas@groups.io>;
 Mon, 03 Jan 2022 09:56:43 -0800
Received: by mail-wr1-f45.google.com with SMTP id o3so13131195wrh.10
        for <linux-oxnas@groups.io>; Mon, 03 Jan 2022 09:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=neH7i+26OYLpeC5cMlHViFNMwrfPO3xPJ5Z7DAt5pN8=;
        b=XvTHDJevsy0ZSrMi+se2sklxBwlITB/hybQLSG/lMV6WXD0xQn+yILwcirk/NVHH8N
         y5cSTYrKo/Z515VeTJsDn3ON6gufP4KRJNeoc3luWerqUVvGFkKB06JcyTcrTCIl9l/M
         ygPKlJgUlChyH36b8GV0ox/Isxi8z+lV1ckPQPQwDphX+q42mcFH3qe18mDTe+OGrF2+
         QyVmUvkcCSigenymoDPRF6E8uDgEnoyqfXlM77ZRQn26WSGFn9RyGSrbmDd1zy/Dm7LT
         0Y5Wfi/pkxGViP79Io2eyNB5PH2dc04N5zhpKGpYuXUmB0YGFnVUWaNDI0AXO5xtoZjW
         vcVA==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH net-next 1/3] dt-bindings: net: oxnas-dwmac: Add bindings for OX810SE
Date: Mon,  3 Jan 2022 18:56:36 +0100
Message-Id: <20220103175638.89625-2-narmstrong@baylibre.com>
In-Reply-To: <20220103175638.89625-1-narmstrong@baylibre.com>
References: <20220103175638.89625-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: davem@davemloft.net, devicetree@vger.kernel.org
Cc: Neil Armstrong <narmstrong@baylibre.com>, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io, linux-kernel@vger.kernel.org
List-ID: <linux-oxnas@groups.io>

Add SoC specific bindings for OX810SE support.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/net/oxnas-dwmac.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/oxnas-dwmac.txt b/Documentation/devicetree/bindings/net/oxnas-dwmac.txt
index d7117a22fd87..27db496f1ce8 100644
--- a/Documentation/devicetree/bindings/net/oxnas-dwmac.txt
+++ b/Documentation/devicetree/bindings/net/oxnas-dwmac.txt
@@ -9,6 +9,9 @@ Required properties on all platforms:
 - compatible:	For the OX820 SoC, it should be :
 		- "oxsemi,ox820-dwmac" to select glue
 		- "snps,dwmac-3.512" to select IP version.
+		For the OX810SE SoC, it should be :
+		- "oxsemi,ox810se-dwmac" to select glue
+		- "snps,dwmac-3.512" to select IP version.
 
 - clocks: Should contain phandles to the following clocks
 - clock-names:	Should contain the following:
-- 
2.25.1

