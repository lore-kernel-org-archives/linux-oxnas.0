Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web10.17845.1646038827240656954
 for <linux-oxnas@groups.io>;
 Mon, 28 Feb 2022 01:00:28 -0800
Received: by mail-wr1-f50.google.com with SMTP id d17so14189978wrc.9
        for <linux-oxnas@groups.io>; Mon, 28 Feb 2022 01:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :content-language:organization:content-transfer-encoding;
        bh=H8bizYJqwkzoCHttqot6/S0biAEi5EvteUjQXBDh6Lg=;
        b=a1wRgWkit2Hgi/TlfA+U8FW05MLaahdsaAVn3imJj7U3TfbN9ZWpzAN6+/pbiyClHk
         vsodzq2rThRbmEy1dv7jM8B3WQ+/4xLRiBr5GdHmYrsMBjknFjw3q+K+w4HGWIaGNzbD
         1mqQSk6VWkyTVwwWYy4EPgytB92cWIlCTSGkk678OOON/Gq8npro52MZqqTcE1EAEeRC
         tq18sI6I/+WMDTxBg6hV4qymxaJO2aq8WH6IPQJFdBZLMfaWqgfWugbst8AQ8e+ZoPMH
         kwNonhQTeumxck42lKfP4Ha5eOJ9zKWrk/wFxxwaIHHDFVB+bcmb9XCcrFJRdfUpCaiX
         nDgg==
Return-Path: <narmstrong@baylibre.com>
Message-ID: <530fd72c-e28a-4d5e-cb8d-8b3fbc1df89a@baylibre.com>
Date: Mon, 28 Feb 2022 10:00:24 +0100
MIME-Version: 1.0
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PULL] oxnas DT for 5.18
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: soc@kernel.org, arm@kernel.org
Cc: linux-oxnas@groups.io, linux-arm-kernel@lists.infradead.org
List-ID: <linux-oxnas@groups.io>

Hi,

Please pull this single change enabling ethernet on the OX810SE based board.

Neil

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

   Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

   https://git.kernel.org/pub/scm/linux/kernel/git/narmstrong/linux-oxnas.git tags/oxnas-arm-soc-dt-for-5.18

for you to fetch changes up to b88ffa66d530ba01ec64b1f5eeb74f8b8ce61d7f:

   ARM: dts: ox810se: Add Ethernet support (2022-01-25 18:03:04 +0100)

----------------------------------------------------------------
- Add Ethernet node for OX810SE base board

----------------------------------------------------------------
Neil Armstrong (1):
       ARM: dts: ox810se: Add Ethernet support

  arch/arm/boot/dts/ox810se-wd-mbwe.dts |  4 ++++
  arch/arm/boot/dts/ox810se.dtsi        | 18 ++++++++++++++++++
  2 files changed, 22 insertions(+)
