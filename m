Received: by mail-pg1-f195.google.com with SMTP id t13so8010485pgr.11
        for <linux-oxnas@groups.io>; Tue, 04 Dec 2018 14:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=Vsg786idVHVwxGNQjEZIy5vnbRZd1Pj4iJlij1oGBAY=;
        b=rHNG0HbA2hZ6DbxYBpJ802GrOfohI2KUjrB1oz+2FvksO8gHumiWy2o5hlcMHeUAQw
         CBHrGNDznpcRGMQlNk0+RwoNIdQP+FJ7JVUkhymM5rCyMdtNbZZ9pfvuafYLmUehXgbh
         Mc66saEbOhmUalAjXnVqPno6y/cIeZkOe+2CLaMPM9elSGP12R+eac9KFpEdVXzIpT7S
         0xqTW4xEw/aOmtf3Z7/PlsC7zDFpPxZVF0ktcGvWrdYcsUNxzm0G7ihnFX99hBGhg4tA
         M3TYUOAQVBJ0Xx+kisOoXPf8De3QXwOeDZsFDv02aMeM7a/IUYjtrKyboxC+a+DzDYaq
         eGkg==
Return-Path: <khilman@baylibre.com>
From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH] ARM: dts: Kill off skeleton{64}.dtsi
In-Reply-To: <20181130170634.9467-1-robh@kernel.org>
References: <20181130170634.9467-1-robh@kernel.org>
Date: Tue, 04 Dec 2018 14:36:10 -0800
Message-ID: <7h7egoor6t.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
To: Rob Herring <robh@kernel.org>, arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Tsahee Zidenberg <tsahee@annapurnalabs.com>, Antoine Tenart <antoine.tenart@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Lars Persson <lars.persson@axis.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Florian Fainelli <f.fainelli@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, =?utf-8?Q?Rafa?= =?utf-8?Q?=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Baruch Siach <baruch@tkos.co.il>, Vladimir Zapolskiy <vz@mleia.com>, Sylvain Lemieux <slemieux.tyco@gmail.com>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Carlo Caione <carlo@caione.org>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, Neil Armstrong <narmstrong@baylibre.com>, Jamie Iles <jamie@jamieiles.com>, Barry Song <baohua@kernel.org>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Viresh Kumar <vireshk@kernel.org>, Shiraz Hashim <shiraz.linux.kernel@gmail.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, Jun Nie <jun.nie@linaro.org>, linux-arm-kernel@axis.com, linux-amlogic@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-oxnas@groups.io, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
List-ID: <linux-oxnas@groups.io>

Rob Herring <robh@kernel.org> writes:

> Remove the usage of skeleton.dtsi in the remaining dts files. It was
> deprecated since commit 9c0da3cc61f1 ("ARM: dts: explicitly mark
> skeleton.dtsi as deprecated"). This will make adding a unit-address to
> memory nodes easier.
>
> The main tricky part to removing skeleton.dtsi is we could end up with
> no /memory node at all when a bootloader depends on one being present. I
> hacked up dtc to check for this condition.

[...]

I gave this a spin through the kernelCI on multiple SoCs, and builds and
no new regressions for build or boot that I spotted.

Tested-by: Kevin Hilman <khilman@baylibre.com>

>  arch/arm/boot/dts/meson.dtsi                   |  3 ++-
>  arch/arm/boot/dts/meson6-atv1200.dts           |  1 +
>  arch/arm/boot/dts/meson8-minix-neo-x8.dts      |  1 +
>  arch/arm/boot/dts/meson8b-ec100.dts            |  1 +
>  arch/arm/boot/dts/meson8b-mxq.dts              |  1 +
>  arch/arm/boot/dts/meson8b-odroidc1.dts         |  1 +
>  arch/arm/boot/dts/meson8m2-mxiii-plus.dts      |  1 +

also for the amlogic/meson platforms,

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Acked-by: Kevin Hilman <khilman@baylibre.com>

Kevin
