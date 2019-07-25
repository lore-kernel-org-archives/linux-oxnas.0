From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] pinctrl: oxnas: remove set but not used variable 'arg'
Date: Thu, 25 Jul 2019 22:24:19 +0800
Message-ID: <20190725142419.29892-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
To: linus.walleij@linaro.org, narmstrong@baylibre.com
Cc: linux-kernel@vger.kernel.org, linux-oxnas@groups.io, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
List-ID: <linux-oxnas@groups.io>

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/pinctrl/pinctrl-oxnas.c: In function oxnas_ox810se_pinconf_set:
drivers/pinctrl/pinctrl-oxnas.c:905:6: warning: variable arg set but not used [-Wunused-but-set-variable]
drivers/pinctrl/pinctrl-oxnas.c: In function oxnas_ox820_pinconf_set:
drivers/pinctrl/pinctrl-oxnas.c:944:6: warning: variable arg set but not used [-Wunused-but-set-variable]

It is never used since commit 4b0c0c25fa79 ("pinctrl:
oxnas: Add support for OX820"), so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/pinctrl/pinctrl-oxnas.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-oxnas.c b/drivers/pinctrl/pinctrl-oxnas.c
index b4edbe0..fa81a09 100644
--- a/drivers/pinctrl/pinctrl-oxnas.c
+++ b/drivers/pinctrl/pinctrl-oxnas.c
@@ -902,7 +902,6 @@ static int oxnas_ox810se_pinconf_set(struct pinctrl_dev *pctldev,
 	struct oxnas_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
 	struct oxnas_gpio_bank *bank = pctl_to_bank(pctl, pin);
 	unsigned int param;
-	u32 arg;
 	unsigned int i;
 	u32 offset = pin - bank->gpio_chip.base;
 	u32 mask = BIT(offset);
@@ -912,7 +911,6 @@ static int oxnas_ox810se_pinconf_set(struct pinctrl_dev *pctldev,
 
 	for (i = 0; i < num_configs; i++) {
 		param = pinconf_to_config_param(configs[i]);
-		arg = pinconf_to_config_argument(configs[i]);
 
 		switch (param) {
 		case PIN_CONFIG_BIAS_PULL_UP:
@@ -941,7 +939,6 @@ static int oxnas_ox820_pinconf_set(struct pinctrl_dev *pctldev,
 	struct oxnas_gpio_bank *bank = pctl_to_bank(pctl, pin);
 	unsigned int bank_offset = (bank->id ? PINMUX_820_BANK_OFFSET : 0);
 	unsigned int param;
-	u32 arg;
 	unsigned int i;
 	u32 offset = pin - bank->gpio_chip.base;
 	u32 mask = BIT(offset);
@@ -951,7 +948,6 @@ static int oxnas_ox820_pinconf_set(struct pinctrl_dev *pctldev,
 
 	for (i = 0; i < num_configs; i++) {
 		param = pinconf_to_config_param(configs[i]);
-		arg = pinconf_to_config_argument(configs[i]);
 
 		switch (param) {
 		case PIN_CONFIG_BIAS_PULL_UP:
-- 
2.7.4


