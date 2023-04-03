Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web11.64563.1680507745011105589
 for <linux-oxnas@groups.io>;
 Mon, 03 Apr 2023 00:42:25 -0700
Received: by mail-wr1-f54.google.com with SMTP id q19so25189997wrc.5
        for <linux-oxnas@groups.io>; Mon, 03 Apr 2023 00:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680507743;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4FKs9G1qfziPxaUbbaWncDXvhRRlRA5Ou7da0j8TnEE=;
        b=dm7n+gszII6Swd6jfKciMWqz1hlk/6NfMd4h/9lY9t5jOPqkpAbF23Bz/dj6XuofS1
         /XzHvCHDFBLMluxVu9o0vRZHLJEyWGxXY20qOn7WPsp6R4EpS5p9Fjxb9AtDaLO2E8zx
         xLN9ZKrkJGq3/SHqdCOFUhdVyKT19PLJPtEgEudDUtgxwjmr3OTdiOz1480KzsKfqPm6
         aDVGv1/6V1u1jH53bHDsvjNLsDp8e99VUtrgjFBuCA5aLcMfZ7nxpJkUtlEMK6HTA1rS
         ESNn3ZwibSquQxwwaJyFD9mtAhM3qE/a35bkjIp7kDsoQtJYVUKg4J/uOnWh2EyP4U+M
         59dQ==
Return-Path: <neil.armstrong@linaro.org>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Subject: [PATCH RFC v2 0/4] ARM: oxnas support removal
Date: Mon, 03 Apr 2023 09:42:17 +0200
Message-Id: <20230331-topic-oxnas-upstream-remove-v2-0-e51078376f08@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, soc@kernel.org, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-oxnas@groups.io, Neil Armstrong <neil.armstrong@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Daniel Golle <daniel@makrotopia.org>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
List-ID: <linux-oxnas@groups.io>

With [1] removing MPCore SMP support, this makes the OX820 barely usable,
associated with a clear lack of maintainance, development and migration to
dt-schema it's clear that Linux support for OX810 and OX820 should be removed.

In addition, the OX810 hasn't been booted for years and isn't even present
in an ARM config file.

For the OX820, lack of USB and SATA support makes the platform not usable
in the current Linux support and relies on off-tree drivers hacked from the
vendor (defunct for years) sources.

The last users are in the OpenWRT distribution, and today's removal means
support will still be in stable 6.1 LTS kernel until end of 2026.

If someone wants to take over the development even with lack of SMP, I'll
be happy to hand off maintainance.

The plan is to apply the first 4 patches first, then the drivers
followed by bindings. Finally the MAINTAINANCE entry can be removed.

I'm not sure about the process of bindings removal, but perhaps the bindings
should be marked as deprecated first then removed later on ?

It has been a fun time adding support for this architecture, but it's time
to get over!

[1] https://lore.kernel.org/all/20230327121317.4081816-1-arnd@kernel.org/

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Only keep first 4 patches for v6.4, the rest will be done later split per subsystem
- Link to v1: https://lore.kernel.org/r/20230331-topic-oxnas-upstream-remove-v1-0-5bd58fd1dd1f@linaro.org

---
Neil Armstrong (4):
      ARM: dts: oxnas: remove obsolete device tree files
      ARM: oxnas: remove OXNAS support
      ARM: configs: remove oxnas_v6_defconfig
      dt-bindings: arm: oxnas: remove obsolete bindings

 Documentation/devicetree/bindings/arm/oxnas.txt    |  14 -
 arch/arm/Kconfig                                   |   2 -
 arch/arm/Makefile                                  |   1 -
 arch/arm/boot/dts/Makefile                         |   3 -
 arch/arm/boot/dts/ox810se-wd-mbwe.dts              | 115 -------
 arch/arm/boot/dts/ox810se.dtsi                     | 357 ---------------------
 .../dts/ox820-cloudengines-pogoplug-series-3.dts   |  93 ------
 arch/arm/boot/dts/ox820.dtsi                       | 299 -----------------
 arch/arm/configs/oxnas_v6_defconfig                |  92 ------
 arch/arm/mach-oxnas/Kconfig                        |  38 ---
 arch/arm/mach-oxnas/Makefile                       |   2 -
 arch/arm/mach-oxnas/headsmp.S                      |  23 --
 arch/arm/mach-oxnas/platsmp.c                      |  96 ------
 13 files changed, 1135 deletions(-)
---
base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
change-id: 20230331-topic-oxnas-upstream-remove-a62e9d96feee

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

