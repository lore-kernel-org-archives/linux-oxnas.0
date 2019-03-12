Received: by mail-wr1-f68.google.com with SMTP id g12so2081647wrm.5
        for <linux-oxnas@groups.io>; Tue, 12 Mar 2019 03:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wLXyLglHFa8WKhCE7UI5x+FxnCWWt9w4ptPRyC5dxNc=;
        b=qPKhsWQR7lHWo26jk2IHBy6RW1A9phLJfjgbuUVJNOrVCqmqzBWj34cb2oX5fKhLbz
         NpSChalSqLWnbRdbR7Y7g56ZcvDdokto9NJtKtfbLw7voyzrMJa9IP2viWSXxboulLOC
         T2d1sV10/mCFoSkGrJ2Qj9M6zJ7dZy0VDjDoupBFkmTmDbrb5UmcrGtzumI6UklPCsf4
         wGBUeL0ZJAUCa9EBTdtVzRp08QYLRVJoEyh9Vc9v3UmMv2LO8v95fl4xWe+Gx/LHn2yy
         TUrVjr89FAiZDKQ4T4I0gQaQ18U4eO081+dRX5B6CSR3+pQQ3aILMBNadLiAGJe/RdCN
         0brQ==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH] clocksource/drivers/oxnas: Fix OX820 compatible
Date: Tue, 12 Mar 2019 11:32:56 +0100
Message-Id: <20190312103256.13565-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: daniel.lezcano@linaro.org
Cc: Neil Armstrong <narmstrong@baylibre.com>, linux-oxnas@groups.io, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>
List-ID: <linux-oxnas@groups.io>

The OX820 compatible is wrong is the driver, fix it.

Fixes: 2ea3401e2a84 ("clocksource/drivers/oxnas: Add OX820 compatible")
Reported-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clocksource/timer-oxnas-rps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-oxnas-rps.c b/drivers/clocksource/timer-oxnas-rps.c
index eed6feff8b5f..30c6f4ce672b 100644
--- a/drivers/clocksource/timer-oxnas-rps.c
+++ b/drivers/clocksource/timer-oxnas-rps.c
@@ -296,4 +296,4 @@ static int __init oxnas_rps_timer_init(struct device_node *np)
 TIMER_OF_DECLARE(ox810se_rps,
 		       "oxsemi,ox810se-rps-timer", oxnas_rps_timer_init);
 TIMER_OF_DECLARE(ox820_rps,
-		       "oxsemi,ox820se-rps-timer", oxnas_rps_timer_init);
+		       "oxsemi,ox820-rps-timer", oxnas_rps_timer_init);
-- 
2.20.1

