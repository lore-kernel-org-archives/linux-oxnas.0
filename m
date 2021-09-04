Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
 by mx.groups.io with SMTP id smtpd.web08.5658.1630713947824271185
 for <linux-oxnas@groups.io>;
 Fri, 03 Sep 2021 17:05:48 -0700
Received: by mail-qk1-f202.google.com with SMTP id q13-20020a05620a038d00b003d38f784161so2301253qkm.8
        for <linux-oxnas@groups.io>; Fri, 03 Sep 2021 17:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=mjzKqamzQmvzyqlVvUVvv6P1c+/kEZztjTn7I8qHctk=;
        b=VZ4p+EFnl9EXauvJ8dhmEDRVt8YHYnMZhZvV6h6nXYpS8v+LDxHvFjqrQR9eLsDsYy
         RHTaYj0wnWluvQm7nCyFHpVTY4X8aSkLuiIkTyUOtezLSN/w1eSH1tjAyXzk6Y6V+daF
         nD4NShWbq6Z7Q6wGJuPFkSLi3XRYi3l8fI7h5O9yxld6cQp6X5zUN7AIWAQFMwtKXCyM
         HXp04mNEFZ5P1u4dqby0/DAT3CrpF/59RTQZHoVwcvbSNnALUImixWgqC+Qcatbmm+Bl
         8cGxwkxOX9xAhBKt/slNqZhBiHfmq1ksDBxjPaOWBySvhq6EsQwZdcMREHamx96DGzud
         O5xg==
Date: Fri,  3 Sep 2021 17:05:40 -0700
Message-Id: <20210904000543.2019010-1-saravanak@google.com>
Mime-Version: 1.0
Subject: [PATCH v3 0/2] Fix simple-bus issues with fw_devlink
From: Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
To: Russell King <linux@armlinux.org.uk>, Neil Armstrong <narmstrong@baylibre.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Damien Le Moal <damien.lemoal@wdc.com>
Cc: Saravana Kannan <saravanak@google.com>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, kernel-team@android.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-oxnas@groups.io, linux-renesas-soc@vger.kernel.org, linux-omap@vger.kernel.org, linux-riscv@lists.infradead.org
List-ID: <linux-oxnas@groups.io>

Ulf reported an issue[1] with fw_devlink. This series tries to fix that
issue.

I replicated a similar set up on my end and I confirmed:
- A simple-bus only device is probed.
- Another device listing simple-bus as a 2nd compatible string isn't
  probed.

Ulf, mind testing this?

v1->v2:
- Switched to probing the simple-bus device instead of marking it as
  NEVER_PROBES.

v2->v3:
- Moved all the code into the simple-pm-bus driver
- Addressed Ulf's comment about the remove() code missing a check.

Thanks,
Saravana
[1] - https://lore.kernel.org/lkml/CAPDyKFo9Bxremkb1dDrr4OcXSpE0keVze94Cm=zrkOVxHHxBmQ@mail.gmail.com/

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Rob Herring <robh+dt@kernel.org>

Saravana Kannan (2):
  drivers: bus: simple-pm-bus: Add support for probing simple bus only
    devices
  drivers: bus: Delete CONFIG_SIMPLE_PM_BUS

 arch/arm/configs/multi_v7_defconfig |  1 -
 arch/arm/configs/oxnas_v6_defconfig |  1 -
 arch/arm/configs/shmobile_defconfig |  1 -
 arch/arm/mach-omap2/Kconfig         |  1 -
 arch/arm64/configs/defconfig        |  1 -
 drivers/bus/Kconfig                 | 12 -----------
 drivers/bus/Makefile                |  2 +-
 drivers/bus/simple-pm-bus.c         | 32 ++++++++++++++++++++++++++---
 drivers/soc/canaan/Kconfig          |  1 -
 9 files changed, 30 insertions(+), 22 deletions(-)

-- 
2.33.0.153.gba50c8fa24-goog

