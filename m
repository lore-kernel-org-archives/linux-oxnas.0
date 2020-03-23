Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.web10.49585.1584958815635738916
 for <linux-oxnas@groups.io>;
 Mon, 23 Mar 2020 03:20:16 -0700
Received: by mail-wr1-f67.google.com with SMTP id 31so10253043wrs.3
        for <linux-oxnas@groups.io>; Mon, 23 Mar 2020 03:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:autocrypt:organization:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=pqTwcVJcx5MXKaIXGk1znnjJLU58wAuX4OU0qM4Zs48=;
        b=RF/e1HrHPkkC8/FNbhFIA8Kr/GXaa6pLBehUNB2tRl+01Z6aDNppeMB0Sz/pPzRURE
         SKdKXhjO7xB1VT6jyU2Uf4PnBagsgsVUIIciW5MA3GAK1byNCRardwH5rh4zJzPpKQts
         YIIFUOoLwU/bWvOR0ZwTUP/osj3hGXSHs9k+PXbd1MIj5MEPgBdgJ6RG9GRMl66tk5x/
         +fH4+eUj6mX0DN0famwNC6BakQDozPuAso1hG6n+j4BgpBjoMXuEkOKLTYxfl3yiEkmU
         N2H82YFmPSjCd+hCrv7uPerOm9LlddhGYhwGJkULuXPlecSyAhGrpq9RKvWpCEL2v7eh
         shkg==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [GIT PULL] oxnas fixes for 5.6
Message-ID: <1cc83d6b-78de-9160-59bf-77cfe726a365@baylibre.com>
Date: Mon, 23 Mar 2020 11:20:12 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: soc@kernel.org, arm@kernel.org
Cc: linux-oxnas@groups.io, linux-arm-kernel@lists.infradead.org
List-ID: <linux-oxnas@groups.io>

Hi,

Long time no see, but upstream is still a base for Oxnas OpenWRT support, and
hopefully we got a couple of fixes last week, so it's not dead yet !

Neil

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/narmstrong/linux-oxnas.git tags/oxnas-arm-soc-dt-fixes-for-5.6

for you to fetch changes up to deeabb4c1341a12bf8b599e6a2f4cfa4fd74738c:

  ARM: dts: oxnas: Fix clear-mask property (2020-03-23 09:34:09 +0100)

----------------------------------------------------------------
- interrupt controller mask init fix to avoid spurious irq after soft reset

----------------------------------------------------------------
Sungbo Eo (1):
      ARM: dts: oxnas: Fix clear-mask property

 arch/arm/boot/dts/ox810se.dtsi | 4 ++--
 arch/arm/boot/dts/ox820.dtsi   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)
