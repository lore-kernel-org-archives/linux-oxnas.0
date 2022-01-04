Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web12.7539.1641308212616924633
 for <linux-oxnas@groups.io>;
 Tue, 04 Jan 2022 06:56:52 -0800
Received: by mail-wr1-f51.google.com with SMTP id s1so76828078wrg.1
        for <linux-oxnas@groups.io>; Tue, 04 Jan 2022 06:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f8y3fxQ7Ixt8X6KzlM4QoJHjlMDWhk5dk98sHG3phE8=;
        b=LnBgmJrGWXQSJznhBJE7nxnjt6hdhnRrlVkEdW/QZH+gDm/GnpetPv7QTsZX8pf/8b
         cHfgr6n/Wm3EK3AJEjCNoYm6HmQbgcMMsVwHWjur2NzP5TnDVKc2nnp1oInjOu2+q6hd
         1gnY07zR7Wb+Ufe59UmTXEEynlolGPNxTLcRerhKv0W4vtk6RVv1OuIE42MQltOi/1BF
         Tshs6HHsmUsS+m5MDHlegZhacwkdZ+NYq+AC1j4gY8MdxfREkQHPUaSReq1LBuo010Ws
         GICNQ97F95sXfLa4gRtAnbevuAblhYx3UcEeHdABqenh4BRMujIZl+5kNTbbwnwzThn3
         WD2w==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH v2 0/3] ARM: ox810se: Add Ethernet support
Date: Tue,  4 Jan 2022 15:56:43 +0100
Message-Id: <20220104145646.135877-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: davem@davemloft.net, kuba@kernel.org
Cc: netdev@vger.kernel.org, linux-oxnas@groups.io, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <linux-oxnas@groups.io>

This adds support for the Synopsys DWMAC controller found in the
OX820SE SoC, by using almost the same glue code as the OX820.

Patch 1 & 2 are for net branch, patch 3 will be queued to arm-soc.

Changes since v1:
- correctly update value read from register
- add proper tag on patch 3 for arm-soc tree

Neil Armstrong (3):
  dt-bindings: net: oxnas-dwmac: Add bindings for OX810SE
  net: stmmac: dwmac-oxnas: Add support for OX810SE
  ARM: dts: ox810se: Add Ethernet support

 .../devicetree/bindings/net/oxnas-dwmac.txt   |   3 +
 arch/arm/boot/dts/ox810se-wd-mbwe.dts         |   4 +
 arch/arm/boot/dts/ox810se.dtsi                |  18 +++
 .../net/ethernet/stmicro/stmmac/dwmac-oxnas.c | 115 +++++++++++++-----
 4 files changed, 111 insertions(+), 29 deletions(-)

-- 
2.25.1

