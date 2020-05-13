Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.web10.2764.1589363710256426224
 for <linux-oxnas@groups.io>;
 Wed, 13 May 2020 02:55:10 -0700
Received: by mail-wr1-f67.google.com with SMTP id l17so6522585wrr.4
        for <linux-oxnas@groups.io>; Wed, 13 May 2020 02:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:autocrypt:organization:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=0/6+M/G1GVlfy5yA6uPVUor1jsLYSluIQPHWs78Q8oI=;
        b=oO4OijU4LnNNtOiRlbtEy5sdCHQ/XAV/yt36DPE8SUBkHRruUpYmRJfY49iXGVyRlz
         lURvzBTetf0lGLGpD13uspKDsscLETzhXJ6edUw5D12Q+F/9VgalcaghiXIXjlfE3NYU
         KSD1eNZoGLKzch8HRtcolSM4l35tAS/4YAhzQIYRU0eexzILRpCwuaiNr90AOAqKWeih
         dCGLlCA/yYbtSbceHIoL6jeFZLeDEBzwopIk6KgIXWWq9Ywm1k/oThPI0PYACr+j0Btd
         6I5Y/xJ/GhxXsiwtysGHUKZBaxGJ8wyo1yabZ7lG8aP5bl4s36izpwJppiQ8kVOOT1o6
         yBag==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [GIT PULL] oxnas fixes for 5.7
Message-ID: <95bf4813-93a1-735d-1d27-2cbe59986845@baylibre.com>
Date: Wed, 13 May 2020 11:55:06 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: soc@kernel.org, arm@kernel.org
Cc: linux-oxnas@groups.io, linux-arm-kernel@lists.infradead.org
List-ID: <linux-oxnas@groups.io>

Hi,

Simple fix for mach-oxnas SMP code fixing a sparse warning.

Neil

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/narmstrong/linux-oxnas.git tags/arm-soc-fixes-for-5.7

for you to fetch changes up to bd84dff0217414d9f9b829a3b75b2487aff857b7:

  ARM: oxnas: make ox820_boot_secondary static (2020-05-12 10:29:33 +0200)

----------------------------------------------------------------
- mach-oxnas: make ox820_boot_secondary static to fix sparse warning

----------------------------------------------------------------
Ma Feng (1):
      ARM: oxnas: make ox820_boot_secondary static

 arch/arm/mach-oxnas/platsmp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
