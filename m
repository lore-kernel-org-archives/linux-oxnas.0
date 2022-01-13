Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web10.6448.1642065158569506457
 for <linux-oxnas@groups.io>;
 Thu, 13 Jan 2022 01:12:39 -0800
Received: by mail-wm1-f49.google.com with SMTP id d18-20020a05600c251200b0034974323cfaso4989887wma.4
        for <linux-oxnas@groups.io>; Thu, 13 Jan 2022 01:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9eVWPKFszyFBjxfc9/yhuv9HXCB5L9Mjwe4xyLGsHZQ=;
        b=TcpcHSYPtKCWa70bXBcRrJpkvUOGrBQCFeS9bSeicupmuRi/Wc/vjagaeNvO869dqu
         rOH2Jf9rD72ajvLdW9gQV+XsJ10ca1nQ+XwriEZ2Z5UxiUmc6drXwb7Avu0gmM2wHhsi
         FmdxqkuykXE7g4jSc4DEbrYEfR1wY5jAegI6azi/uodGqD0KImFNo2s0Cw0q7eLLfzjg
         4i1/U2TyoYIwaLFwAdRBilEml8u7OnOR9Xj6qB85WW/BbyVonlnPzhrG3oXlcvGHI76s
         FS1RpxrwHcgpSqSEwcfyhv8Sf7cGW+ltLU12nZykZj7ELt3pCDyIreFZdQuIEti60pnI
         0c9g==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: Re: [PATCH v2 0/3] ARM: ox810se: Add Ethernet support
Date: Thu, 13 Jan 2022 10:12:34 +0100
Message-Id: <164206502761.1011244.11952182860924885505.b4-ty@baylibre.com>
In-Reply-To: <20220104145646.135877-1-narmstrong@baylibre.com>
References: <20220104145646.135877-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>, kuba@kernel.org, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-oxnas@groups.io, linux-arm-kernel@lists.infradead.org
List-ID: <linux-oxnas@groups.io>

Hi,

On Tue, 4 Jan 2022 15:56:43 +0100, Neil Armstrong wrote:
> This adds support for the Synopsys DWMAC controller found in the
> OX820SE SoC, by using almost the same glue code as the OX820.
> 
> Patch 1 & 2 are for net branch, patch 3 will be queued to arm-soc.
> 
> Changes since v1:
> - correctly update value read from register
> - add proper tag on patch 3 for arm-soc tree
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/narmstrong/linux-oxnas.git (v5.18/dt)

[3/3] ARM: dts: ox810se: Add Ethernet support
      https://git.kernel.org/narmstrong/linux-oxnas/c/ae552c33f6edad1097dec7a5543314d35d413b3e

-- 
Neil
