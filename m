Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web08.32108.1641232602271203450
 for <linux-oxnas@groups.io>;
 Mon, 03 Jan 2022 09:56:42 -0800
Received: by mail-wm1-f50.google.com with SMTP id k66-20020a1ca145000000b00345fa984108so260730wme.2
        for <linux-oxnas@groups.io>; Mon, 03 Jan 2022 09:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6WMK9r9U40TC3q1VP7bdOOZDIr/rVvLVzPk/2iDskuQ=;
        b=vOJu7+LvPnji/6CMcHF1ZEi/tNY0JzDumoerl3uWTrZlBM31/cVL0gPqHe0QWNrqEu
         OukXRNTrYFCXcJJCXcccdIUv/wAP5Edbi4Mhd5Cu/C5Xd4RdfanHnNmpFP8qlkhx9+Ge
         hmO8fe57tgdsyVDZOsROxdE5MJd4z40FGK/KNHF2ZkXarBuoivACBbbRMk/s30nKEM8w
         RaXGuo21q3nC1wxfppyiosK1sDcAZqC5PfeUtmbn8/lDoCLPxSKYC1WnrEgPVz5gDnXs
         NkCQ1AwCjGSdVxrHNUlrLsj2Pm88RjtfkHI6JYyDEsiTggNKoN+1Yka3y+ZGtr+QBnzZ
         RNLQ==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 0/3] ARM: ox810se: Add Ethernet support
Date: Mon,  3 Jan 2022 18:56:35 +0100
Message-Id: <20220103175638.89625-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: davem@davemloft.net
Cc: Neil Armstrong <narmstrong@baylibre.com>, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io, linux-kernel@vger.kernel.org
List-ID: <linux-oxnas@groups.io>

This adds support for the Synopsys DWMAC controller found in the
OX820SE SoC, by using almost the same glue code as the OX820.

Neil Armstrong (3):
  dt-bindings: net: oxnas-dwmac: Add bindings for OX810SE
  net: stmmac: dwmac-oxnas: Add support for OX810SE
  ARM: dts: ox810se: Add Ethernet support

 .../devicetree/bindings/net/oxnas-dwmac.txt   |  3 +
 arch/arm/boot/dts/ox810se-wd-mbwe.dts         |  4 +
 arch/arm/boot/dts/ox810se.dtsi                | 18 ++++
 .../net/ethernet/stmicro/stmmac/dwmac-oxnas.c | 92 ++++++++++++++-----
 4 files changed, 95 insertions(+), 22 deletions(-)

-- 
2.25.1

