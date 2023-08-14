Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web10.103236.1692001006978250769
 for <linux-oxnas@groups.io>;
 Mon, 14 Aug 2023 01:16:47 -0700
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-31963263938so1995623f8f.2
        for <linux-oxnas@groups.io>; Mon, 14 Aug 2023 01:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692001005; x=1692605805;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1P+7jhSSNcltObBqcyP3huFreuMp7RiZ1kKqWA9BdTU=;
        b=QNHpiT7CaXxRuYW7wplRo1hM0BIwfS/5U3VNJMClXwpDK49QfOCqp11ER/vTMWkJqP
         tVGRpr+vxyYS0/3BfhIE43SYUv2gyH/LYjRu+FsuLccS7otPdjMNrZj+EsKIif8a3MWE
         3c1hRee5MeSgQ/gOpGq7YwUXOGBfG4PETsB0ER9zOifFMX6XUEF/a+FZB+GK3A8T11lI
         l8Npq5fgiX700a9rtgke8nbGM8DpSQd6ffAgWRAum0JD6rJdUgMHmwj8fnA0QAh4HlSl
         SiQnr8rsCg+vQ4jwwbq5CHIEJpcBSIOWI3HJNnW1e6t3Kn1gdWsUIhZK441Pj8ZSyloQ
         D67Q==
Return-Path: <neil.armstrong@linaro.org>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Subject: [PATCH v3 0/3] pinctrl: oxnas support removal
Date: Mon, 14 Aug 2023 10:16:36 +0200
Message-Id: <20230814-topic-oxnas-upstream-remove-v3-0-04a0c5cdda52@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2278;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=svL6aI+Ivh8BepAtDKpiDrwHSHdF9+dU0wkSJh9amZ0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBk2eLqbnzULI5saow0fVSkLtRpOAARsRIwaipWDhVx
 lsLLaj6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZNni6gAKCRB33NvayMhJ0cmvEA
 CvB0XkWPo2+wZVpZSUMFe6ciE43WkhMmHVwX30myPEwI4x0DUu81GxN1KDeMCIIf6gvbSNQhf4jhux
 Pa5rErjAnLfNSMU2x8B/RJ/ENNjzU8RALcgV5Pl915uoCHTOwxw3JqDhQ6SYtA2rGcQpCCoyHVrghj
 JRvWtnJbE5gSRtA2nnFyiUyTVQZnLl2BdBkxXVTW8cvgi/oXnVxbKvVdJSelWpMfSbwkwBde+3PBvm
 DadHl6Z35P/rZzQhPwMQmQg4u8mxvRpQKfvpdkdOq7L40qJZq8zQXp3S93+POeFcSgkRy/E6kZecU5
 plgKiyRUXDl/PgGSzECnCAAVqXJfPD4elh9ukb0YgdKRdLo0KVWUZoBXh5/mmBmQp7x3upVF9RJeg+
 NobaW8Z5h1OLSi2NpYMatz/qAtm551wWVTWn0YEncwE7dC2v6F3MzL19mbxxoj6vFdwYwmnbNXDDaW
 4VbxNV2r6utPtXxaB7FWngH5ugU1hn3ufZbojuKukVVepzsFmcIJmJqWc2Xsw2IrYEIvi8YRSF2Dwd
 Hedc0ksfNGBKzoOt5SOr+H2ckOYss+L8j09/iZmtLBQICJcsLH5bwrswVKmRno59Pq/vaR/6wxWb5g
 5yhQWrzswT9b4eb3zaomgEryjl0Tbrme0H4Mgmim+a5NKx+OKQRbCgL63iwg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io, devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Daniel Golle <daniel@makrotopia.org>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
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

It has been a fun time adding support for this architecture, but it's time
to get over!

This patchset only removes pinctrl/gpio code, and is derived from:
https://lore.kernel.org/r/20230630-topic-oxnas-upstream-remove-v2-0-fb6ab3dea87c@linaro.org

---
Changes in v3:
- Removed applied patches
- Added Andy's tags
- Reduced for pinctrl, rebased on pinctrl devel branch
- Link to v2: https://lore.kernel.org/r/20230630-topic-oxnas-upstream-remove-v2-0-fb6ab3dea87c@linaro.org

Changes in v2:
- s/maintainance/maintenance/
- added acked/review tags
- dropped already applied patches
- drop RFC
- Link to v1: https://lore.kernel.org/r/20230331-topic-oxnas-upstream-remove-v1-0-5bd58fd1dd1f@linaro.org

---
Neil Armstrong (3):
      pinctrl: pinctrl-oxnas: remove obsolete pinctrl driver
      dt-bindings: pinctrl: oxnas,pinctrl: remove obsolete bindings
      dt-bindings: gpio: gpio_oxnas: remove obsolete bindings

 .../devicetree/bindings/gpio/gpio_oxnas.txt        |   47 -
 .../devicetree/bindings/pinctrl/oxnas,pinctrl.txt  |   56 -
 drivers/pinctrl/Kconfig                            |   11 -
 drivers/pinctrl/Makefile                           |    1 -
 drivers/pinctrl/pinctrl-oxnas.c                    | 1291 --------------------
 5 files changed, 1406 deletions(-)
---
base-commit: c9b2572f488c3ed3974a0ff6885bb059b1751c86
change-id: 20230331-topic-oxnas-upstream-remove-a62e9d96feee

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

