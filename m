Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web10.19016.1688144317860359217
 for <linux-oxnas@groups.io>;
 Fri, 30 Jun 2023 09:58:38 -0700
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-313e12db357so2525832f8f.0
        for <linux-oxnas@groups.io>; Fri, 30 Jun 2023 09:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688144316; x=1690736316;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bcJVpZgsLmrXO6R6gbSb0Esg3xW+s2OxZQwgSrlzOI4=;
        b=bmpj1QwFDiJjXYDFX+GcnbAhwD9vj3tix/zCMIrizJ9MPf5UNAxQ9v/cRw6OUxt2KW
         KE3zf+2Pw7jthWTNZbprNCFqfFA+JS0W8jtQ65vZmpabGpdxDsw21KGdysW5Rgu8kg0B
         PyGJRoYvj0LevhwgFxldljpw5mn5iYALAxticdMiFKM6XyW/5qXe/04qRO6TW0fLgXzr
         aOfLaexfdvAPQ8s412PTcruvT5l9WfXM0yu7CPdJlryQ5/9gdmNvJJYUEPeAf8gw/fpM
         QPW3nEPTqE0MbjRP8zn5uMkqrqVueY9X0mScX1gQmEmP8ReqesJYgPzBGkVVqLUu7t2U
         LhTQ==
Return-Path: <neil.armstrong@linaro.org>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Subject: [PATCH v2 00/15] ARM: oxnas support removal
Date: Fri, 30 Jun 2023 18:58:25 +0200
Message-Id: <20230630-topic-oxnas-upstream-remove-v2-0-fb6ab3dea87c@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4190;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=C4rej9R1KAWJBjlpvKevYXZln3FvwK8ckfIdYSWc8hc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBknwmzV/0VBUuZ5VLF3VM024I/LCO+HhW4mBonGzT7
 p0UWKQeJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJ8JswAKCRB33NvayMhJ0bEoD/
 92fTad2/jmG1/xFHGsOAAbus0mtr1yygYjXJIbrhRPE9uUwLGWjQRwdCZK+9uTzPlNOnFf8VfsSAWK
 SsXzf6TJekC8afg4EWtpdlBUi5qaFI0ytw+1Rj94MZRLVKfQ8JXnxjZv8SkSvkLyueoV7rmfCHYFdK
 cnD7CB/+wSgnvcnUp/fF6Fbf1O9oGZfdLiWaglf1yqZQOptaAYEl3EawwxrGx+a7PVtbr5Q3DY7YkJ
 0hvdHTEFmFGN8YmWLTDPN5NsnwjyS4XME/j+X1VZDa9DoXkYV/55BSUROfYSjLj8gpDDaUyJlCDU3J
 RUnNef36xCarwAsdmyvK8NEU1X+I1SuFr8mz0patK77hcSogi3n9OKKg/+abu7mNekCipcgyevIxai
 L+nkDsZd1QiGImw/Q9p5qRe1agynKMLlyZwvKpFLPiWW8aNfnLrTJZuSJshOCDe90CpalL/RF4zcZ1
 X6Ol4UHFHd20V16aPz2SD8pkCdqwQfDl28ZzZFp8WC0j3BSgKHLGgzcIB1b4n9tuBzppZn35Xo3Amc
 bEFUCVh90Fm/F3vcOFjRcWdWXsZ1trY99dp1K3wekKlmXaS3QGiLdWMI3qkpl9M2bl62QT8ESQp0Hk
 jBmn6aCNV42zkSGc8Jm7jyROXzkjRH/Yz95icnWmMYEVF8Z5VLRJ9+hEOWow==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>, Sebastian Reichel <sre@kernel.org>, Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-mtd@lists.infradead.org, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-oxnas@groups.io, Neil Armstrong <neil.armstrong@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Daniel Golle <daniel@makrotopia.org>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Sebastian Reichel <sebastian.reichel@collabora.com>
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

Now arch/arm parts are removed, now it's time to remove the remaining stuff.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- s/maintainance/maintenance/
- added acked/review tags
- dropped already applied patches
- drop RFC
- Link to v1: https://lore.kernel.org/r/20230331-topic-oxnas-upstream-remove-v1-0-5bd58fd1dd1f@linaro.org

---
Neil Armstrong (15):
      clk: oxnas: remove obsolete clock driver
      dt-bindings: clk: oxnas: remove obsolete bindings
      clksource: timer-oxnas-rps: remove obsolete timer driver
      dt-bindings: timer: oxsemi,rps-timer: remove obsolete bindings
      nand: oxnas_nand: remove obsolete raw nand driver
      dt-bindings: mtd: oxnas-nand: remove obsolete bindings
      net: stmmac: dwmac-oxnas: remove obsolete dwmac glue driver
      dt-bindings: net: oxnas-dwmac: remove obsolete bindings
      pinctrl: pinctrl-oxnas: remove obsolete pinctrl driver
      dt-bindings: pinctrl: oxnas,pinctrl: remove obsolete bindings
      dt-bindings: gpio: gpio_oxnas: remove obsolete bindings
      power: reset: oxnas-restart: remove obsolete restart driver
      irqchip: irq-versatile-fpga: remove obsolete oxnas compatible
      dt-bindings: interrupt-controller: arm,versatile-fpga-irq: mark oxnas compatible as deprecated
      MAINTAINERS: remove OXNAS entry

 .../devicetree/bindings/clock/oxnas,stdclk.txt     |   28 -
 .../devicetree/bindings/gpio/gpio_oxnas.txt        |   47 -
 .../arm,versatile-fpga-irq.txt                     |    4 +-
 .../devicetree/bindings/mtd/oxnas-nand.txt         |   41 -
 .../devicetree/bindings/net/oxnas-dwmac.txt        |   41 -
 .../devicetree/bindings/pinctrl/oxnas,pinctrl.txt  |   56 -
 .../devicetree/bindings/timer/oxsemi,rps-timer.txt |   17 -
 MAINTAINERS                                        |   10 -
 drivers/clk/Kconfig                                |    7 -
 drivers/clk/Makefile                               |    1 -
 drivers/clk/clk-oxnas.c                            |  251 ----
 drivers/clocksource/Kconfig                        |    7 -
 drivers/clocksource/Makefile                       |    1 -
 drivers/clocksource/timer-oxnas-rps.c              |  288 -----
 drivers/irqchip/irq-versatile-fpga.c               |    1 -
 drivers/mtd/nand/raw/Kconfig                       |    7 -
 drivers/mtd/nand/raw/Makefile                      |    1 -
 drivers/mtd/nand/raw/oxnas_nand.c                  |  209 ----
 drivers/net/ethernet/stmicro/stmmac/Kconfig        |   11 -
 drivers/net/ethernet/stmicro/stmmac/Makefile       |    1 -
 drivers/net/ethernet/stmicro/stmmac/dwmac-oxnas.c  |  245 ----
 drivers/pinctrl/Kconfig                            |   11 -
 drivers/pinctrl/Makefile                           |    1 -
 drivers/pinctrl/pinctrl-oxnas.c                    | 1292 --------------------
 drivers/power/reset/Kconfig                        |    7 -
 drivers/power/reset/Makefile                       |    1 -
 drivers/power/reset/oxnas-restart.c                |  233 ----
 27 files changed, 3 insertions(+), 2816 deletions(-)
---
base-commit: 5c875096d59010cee4e00da1f9c7bdb07a025dc2
change-id: 20230331-topic-oxnas-upstream-remove-a62e9d96feee

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

