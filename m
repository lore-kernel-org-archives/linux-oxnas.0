Received: by mail-pl1-f194.google.com with SMTP id u18so3151344plq.7
        for <linux-oxnas@groups.io>; Fri, 30 Nov 2018 09:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZEHO3QjPndCJKK5bqMDKL2hOoKPKNuUCJXTWPwHdB6E=;
        b=mu8He1P4QndcZ6Xhmqwb503dCX6vAC9UiZcOtvDJMLhUEZReSBUFWGuhb8Jj9K+kwB
         UUPkBpPCY0m7y7+pjCg364ENOhYvuHV1LfGskUhYPVesnZiOW5EoHOsJWAVQh1vsooSp
         B1K5JjjHX767i0BC3sOpH8vq2u/5gIWO4KESa3gEM4BZqqCxn6yFXedN8MLjZOuw4RME
         w20Ou4ryjd0Bytn/tNSbspvF3OsAhgmd88xBsp6QCJ+eIXB/YWJHQfRz7IPirn/aVycz
         RabzoSFeOvCXCByc9IoSTJpUJd7T1CovzBnyKuvSMxXUIPeFnAjjunbikaUZCk0PcZTy
         /Amg==
Return-Path: <f.fainelli@gmail.com>
Subject: Re: [PATCH] ARM: dts: Kill off skeleton{64}.dtsi
References: <20181130170634.9467-1-robh@kernel.org>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <3d46df10-9b85-7ecf-9302-0cde08b9283a@gmail.com>
Date: Fri, 30 Nov 2018 09:52:15 -0800
MIME-Version: 1.0
In-Reply-To: <20181130170634.9467-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>, arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Tsahee Zidenberg <tsahee@annapurnalabs.com>, Antoine Tenart <antoine.tenart@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Lars Persson <lars.persson@axis.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Florian Fainelli <f.fainelli@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Baruch Siach <baruch@tkos.co.il>, Vladimir Zapolskiy <vz@mleia.com>, Sylvain Lemieux <slemieux.tyco@gmail.com>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, Neil Armstrong <narmstrong@baylibre.com>, Jamie Iles <jamie@jamieiles.com>, Barry Song <baohua@kernel.org>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Viresh Kumar <vireshk@kernel.org>, Shiraz Hashim <shiraz.linux.kernel@gmail.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, Jun Nie <jun.nie@linaro.org>, linux-arm-kernel@axis.com, linux-amlogic@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-oxnas@groups.io, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
List-ID: <linux-oxnas@groups.io>



On 11/30/2018 9:06 AM, Rob Herring wrote:
> Remove the usage of skeleton.dtsi in the remaining dts files. It was
> deprecated since commit 9c0da3cc61f1 ("ARM: dts: explicitly mark
> skeleton.dtsi as deprecated"). This will make adding a unit-address to
> memory nodes easier.
> 
> The main tricky part to removing skeleton.dtsi is we could end up with
> no /memory node at all when a bootloader depends on one being present. I
> hacked up dtc to check for this condition.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

>  arch/arm/boot/dts/bcm-cygnus.dtsi              |  9 +++++++--
>  arch/arm/boot/dts/bcm-nsp.dtsi                 |  4 ++--
>  arch/arm/boot/dts/bcm11351.dtsi                |  4 ++--
>  arch/arm/boot/dts/bcm21664-garnet.dts          |  1 +
>  arch/arm/boot/dts/bcm21664.dtsi                |  4 ++--
>  arch/arm/boot/dts/bcm23550-sparrow.dts         |  1 +
>  arch/arm/boot/dts/bcm23550.dtsi                |  4 ++--
>  arch/arm/boot/dts/bcm28155-ap.dts              |  1 +
>  arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts    |  1 +
>  .../boot/dts/bcm47081-buffalo-wzr-600dhp2.dts  |  1 +
>  .../boot/dts/bcm47081-buffalo-wzr-900dhp.dts   |  1 +
>  arch/arm/boot/dts/bcm47081-luxul-xap-1410.dts  |  1 +
>  arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dts  |  1 +
>  .../boot/dts/bcm47081-tplink-archer-c5-v2.dts  |  1 +
>  arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts  |  1 +
>  .../arm/boot/dts/bcm47094-linksys-panamera.dts |  1 +
>  arch/arm/boot/dts/bcm47094-luxul-abr-4500.dts  |  1 +
>  arch/arm/boot/dts/bcm47094-luxul-xap-1610.dts  |  1 +
>  arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dts  |  1 +
>  arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts  |  1 +
>  .../boot/dts/bcm47094-luxul-xwr-3150-v1.dts    |  1 +
>  arch/arm/boot/dts/bcm47094-netgear-r8500.dts   |  1 +
>  arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts  |  1 +
>  arch/arm/boot/dts/bcm47189-luxul-xap-810.dts   |  1 +
>  arch/arm/boot/dts/bcm47189-tenda-ac9.dts       |  1 +
>  arch/arm/boot/dts/bcm5301x.dtsi                |  3 ++-
>  .../boot/dts/bcm53340-ubnt-unifi-switch8.dts   |  1 +
>  arch/arm/boot/dts/bcm53573.dtsi                |  3 ++-
>  arch/arm/boot/dts/bcm63138.dtsi                |  4 ++--
>  arch/arm/boot/dts/bcm7445.dtsi                 |  2 --
>  arch/arm/boot/dts/bcm947189acdbmr.dts          |  1 +
>  arch/arm/boot/dts/bcm953012er.dts              |  1 +
>  arch/arm/boot/dts/bcm953012hr.dts              |  1 +
>  arch/arm/boot/dts/bcm953012k.dts               |  1 +

For these files above (Broadcom):

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks!
--
Florian
