Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web12.7489.1641307936237059529
 for <linux-oxnas@groups.io>;
 Tue, 04 Jan 2022 06:52:17 -0800
Received: by mail-wr1-f48.google.com with SMTP id e5so76680609wrc.5
        for <linux-oxnas@groups.io>; Tue, 04 Jan 2022 06:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C5F5o/W7ZL/b1Y2B+J1/KTZflK9h/hPBJOs37w3Di6g=;
        b=zPD5vIuKCKdKaLTTKckD9IWWMkuUeYnbMgNmmRBvn1IJgu29N/ZD5Pi9vm1KIa4qNz
         yxC9ZDMJ9cby6FO/633RPnTCCBrC7+G092PSd3RyRGMo5rrFvoVbds/g6ma1mmFopyS4
         WKabuz5+MM6olk/wbAQ3Sxl7gVcGHmuS9Ui1P1JhZq9M1EL8LHga5N7kDt/60Z2SfRni
         vErkJol/taJzJ6GzzmITY5fT0jNMr5T22GT8/3oaXm7h97A3q609HqTwp/gUDyjGFlDh
         DqYO+7xUA8L6XnW6s5HFm6LqEX/J+TDGyI/xMUPVwLnxTUbdAH4dyRPA4N8sWB5xGoEL
         qd1Q==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 0/4] dmaengine: Add support Oxford Semiconductor OXNAS DMA Engine
Date: Tue,  4 Jan 2022 15:52:02 +0100
Message-Id: <20220104145206.135524-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: vkoul@kernel.org
Cc: linux-oxnas@groups.io, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <linux-oxnas@groups.io>

This serie adds support for the DMA engine found in Oxford Semiconductor SoCs,
notably in the OX810SE where it's heavily used for SATA transfers.

The driver was on my pipe since 2016 and a courageous person managed to get
the SATA driver work up mainline kernel with this driver, so I cleaned it up
in order to be upstreamed.

I plan to push the last patch through arm-soc when bindings is applied.

Neil Armstrong (4):
  dt-bindings: dma: Add bindings for ox810se dma engine
  dmaengine: Add Oxford Semiconductor OXNAS DMA Controller
  MAINTAINERS: add OX810SE DMA driver files under Oxnas entry
  ARM: dts: ox810se: Add DMA Support

 .../bindings/dma/oxsemi,ox810se-dma.yaml      |   97 ++
 MAINTAINERS                                   |    2 +
 arch/arm/boot/dts/ox810se-wd-mbwe.dts         |    4 +
 arch/arm/boot/dts/ox810se.dtsi                |   21 +
 drivers/dma/Kconfig                           |    8 +
 drivers/dma/Makefile                          |    1 +
 drivers/dma/oxnas_adma.c                      | 1045 +++++++++++++++++
 7 files changed, 1178 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/oxsemi,ox810se-dma.yaml
 create mode 100644 drivers/dma/oxnas_adma.c


base-commit: fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf
-- 
2.25.1

