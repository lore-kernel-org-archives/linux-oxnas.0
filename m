Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web08.7722.1641308213819755167
 for <linux-oxnas@groups.io>;
 Tue, 04 Jan 2022 06:56:54 -0800
Received: by mail-wr1-f44.google.com with SMTP id j18so76715221wrd.2
        for <linux-oxnas@groups.io>; Tue, 04 Jan 2022 06:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=neH7i+26OYLpeC5cMlHViFNMwrfPO3xPJ5Z7DAt5pN8=;
        b=6B4DUmzq2Lw2opUtv12zb3B4EY4CeYfQZzyD+DTHYfa5cAbiga8DiYxi6dYySc47UB
         JaLoqUDyIVYNusHpP3ruR2TxjjX3aQnJ1LXPFACQ57tSU3ADldPIC5LuZ9z333Mx1phi
         eRmL2R6KFJtsf+63IJbq5dkPUyk++tIHNKg0FOBvKa9keQkjxI31z2bd1g5jubfAT9eX
         X/+pYij9apXPDicOmXiq0AekeO3VW/xCSLTtNHwWE7tSSMs2v3G2+htCvJFX4N/L0ws6
         rgxVwzorsoycd8aBuRT+jL/frWNcu6YAHRNrwyIpNN0TVHXsW8WVROF6y4qxA53J4/G0
         xOwQ==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH net-next v2 1/3] dt-bindings: net: oxnas-dwmac: Add bindings for OX810SE
Date: Tue,  4 Jan 2022 15:56:44 +0100
Message-Id: <20220104145646.135877-2-narmstrong@baylibre.com>
In-Reply-To: <20220104145646.135877-1-narmstrong@baylibre.com>
References: <20220104145646.135877-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: davem@davemloft.net, kuba@kernel.org, devicetree@vger.kernel.org
Cc: netdev@vger.kernel.org, linux-oxnas@groups.io, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>
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

