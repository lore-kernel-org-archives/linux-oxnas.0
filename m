Received: by mail-wm0-f68.google.com with SMTP id t67so24514905wmt.0
        for <linux-oxnas@groups.io>; Tue, 10 Apr 2018 01:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=6loQoEPYcePuLTim1op/q4XwM0gOyPWHcXSRl9pFJBU=;
        b=afrFrmsXIR8CYeuptWKOFSZjHk9SPZQb1GF5pJKaiOvfiSGI/ylEeXluB8xrUtugrc
         JLAZwAcOIgeUEODzs23SQpGGwsXsJyWNqmd30u/2AUXKVS8TIunbrfgE/hwdwD45UFk5
         9kFhxCws0o/vwl46UYCpOs85DxrYuM0P3cirsdZ2PX7jDX09LX1OtZqGE/PmFbUtm07X
         GSXnePNPcwafq9P2yq1lsYddhBB5APt74e1DM9jZmpGiboyxbhAX4XKF+HauIK+VuSeh
         0IoI/yj76x1Da2p4qkRZzNxFrIoArncCW7QqEvuvNKqXH+Qqxfl4E1GQ76KpIlW8BaNW
         07IQ==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH] MAINTAINERS: Migrate oxnas list to groups.io
Date: Tue, 10 Apr 2018 10:43:45 +0200
Message-ID: <1524069BAA73DD87.11485@groups.io>
To: arm@kernel.org
Cc: Neil Armstrong <narmstrong@baylibre.com>, linux-oxnas@lists.tuxfamily.org, linux-oxnas@groups.io, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-ID: <linux-oxnas@groups.io>

The linux-oxnas migrates from tuxfamily to groups.io for a simpler
administration and maintainance.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6d296bd..f846da2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1743,7 +1743,7 @@ F:	arch/arm/mach-orion5x/ts78xx-*
 ARM/OXNAS platform support
 M:	Neil Armstrong <narmstrong@baylibre.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-L:	linux-oxnas@lists.tuxfamily.org (moderated for non-subscribers)
+L:	linux-oxnas@groups.io (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-oxnas/
 F:	arch/arm/boot/dts/ox8*.dts*
-- 
2.7.4

