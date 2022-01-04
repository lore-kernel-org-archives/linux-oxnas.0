Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web10.7604.1641307938323636512
 for <linux-oxnas@groups.io>;
 Tue, 04 Jan 2022 06:52:18 -0800
Received: by mail-wr1-f47.google.com with SMTP id d9so76775913wrb.0
        for <linux-oxnas@groups.io>; Tue, 04 Jan 2022 06:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IhyRDcAYAg3Q0/LJrN5ssj0ohBsXnQFjSjpKgIyyw9g=;
        b=qgCriQxq0ntL+4GWVQmaiQbCYwfNvSE+ijumFfWDf94KcM354xt7AQnCwuPBt8LkPk
         Bp2PTyQnjNUTsQXx/UqkErPk7lMw17PugWe2DNPie5bhUhBDbsHZYbjPAuYZcyjq9B3D
         NVACFsYSb6wodjHq2ZDu1iqRrCASt+UkhHctBDMxhXoxEVHMRz9WsO37F0pCfhSC/mJv
         +OckIbta4YJCfwLq3xVZsoyVhvVcBRBk18z/w7xVeCZHAuJfEQaZQ/s70TYzd4O4s7ri
         knk8KuM0cffgzY/Arv58IeIZuhE/Sf8Z6fqERNSR+3lV0o/XrX8Je1lqYqQfOYd1wjoh
         jn5Q==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 3/4] MAINTAINERS: add OX810SE DMA driver files under Oxnas entry
Date: Tue,  4 Jan 2022 15:52:05 +0100
Message-Id: <20220104145206.135524-4-narmstrong@baylibre.com>
In-Reply-To: <20220104145206.135524-1-narmstrong@baylibre.com>
References: <20220104145206.135524-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: vkoul@kernel.org
Cc: linux-oxnas@groups.io, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <linux-oxnas@groups.io>

Add the DMA driver file and bindings in the Oxnas maintainers entry.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7a2345ce8521..782332ab0d9b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2371,8 +2371,10 @@ M:	Neil Armstrong <narmstrong@baylibre.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-oxnas@groups.io (moderated for non-subscribers)
 S:	Maintained
+F:	Documentation/devicetree/bindings/dma/oxsemi,ox810se-dma.yaml
 F:	arch/arm/boot/dts/ox8*.dts*
 F:	arch/arm/mach-oxnas/
+F:	drivers/dma/oxnas_adma.c
 F:	drivers/power/reset/oxnas-restart.c
 N:	oxnas
 
-- 
2.25.1

