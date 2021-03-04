Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [85.220.165.71])
 by mx.groups.io with SMTP id smtpd.web10.757.1614873843387181126
 for <linux-oxnas@groups.io>;
 Thu, 04 Mar 2021 08:04:04 -0800
From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH] reset: oxnas: replace file name with short description
Date: Thu,  4 Mar 2021 17:03:58 +0100
Message-Id: <20210304160358.21030-1-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: linux-kernel@vger.kernel.org
Cc: Neil Armstrong <narmstrong@baylibre.com>, linux-oxnas@groups.io
List-ID: <linux-oxnas@groups.io>

Fixes a checkpatch warning:

  WARNING: It's generally not useful to have the filename in the file
  #3: FILE: drivers/reset/reset-oxnas.c:3:
  + * drivers/reset/reset-oxnas.c

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/reset/reset-oxnas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/reset-oxnas.c b/drivers/reset/reset-oxnas.c
index c4013165bdda..8209f922dc16 100644
--- a/drivers/reset/reset-oxnas.c
+++ b/drivers/reset/reset-oxnas.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * drivers/reset/reset-oxnas.c
+ * Oxford Semiconductor Reset Controller driver
  *
  * Copyright (C) 2016 Neil Armstrong <narmstrong@baylibre.com>
  * Copyright (C) 2014 Ma Haijun <mahaijuns@gmail.com>
-- 
2.29.2

