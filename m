Received: by mail-ed1-f66.google.com with SMTP id h15so9527734edb.4
        for <linux-oxnas@groups.io>; Sun, 02 Dec 2018 20:09:20 -0800 (PST)
Return-Path: <wens213@gmail.com>
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id u33sm3596645edm.88.2018.12.02.20.09.18
        for <linux-oxnas@groups.io>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Dec 2018 20:09:18 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id z18so4243983wmc.4
        for <linux-oxnas@groups.io>; Sun, 02 Dec 2018 20:09:18 -0800 (PST)
MIME-Version: 1.0
References: <20181130170634.9467-1-robh@kernel.org>
In-Reply-To: <20181130170634.9467-1-robh@kernel.org>
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 3 Dec 2018 12:02:29 +0800
Message-ID: <CAGb2v644LTpJ6XpCbhpBGYT3ZBr_Yt-4OVGQwNcOD15-+PqshA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: Kill off skeleton{64}.dtsi
Content-Type: text/plain; charset="UTF-8"
To: Rob Herring <robh@kernel.org>, Maxime Ripard <maxime.ripard@bootlin.com>
Cc: arm-soc <arm@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, tsahee@annapurnalabs.com, antoine.tenart@bootlin.com, Linus Walleij <linus.walleij@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, gregory.clement@bootlin.com, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, jesper.nilsson@axis.com, lars.persson@axis.com, Nicolas Ferre <nicolas.ferre@microchip.com>, alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, jonmason@broadcom.com, bcm-kernel-feedback-list@broadcom.com, Florian Fainelli <f.fainelli@gmail.com>, hauke@hauke-m.de, zajec5@gmail.com, Brian Norris <computersforpeace@gmail.com>, gregory.0xf0@gmail.com, Baruch Siach <baruch@tkos.co.il>, Vladimir Zapolskiy <vz@mleia.com>, Sylvain Lemieux <slemieux.tyco@gmail.com>, Shawn Guo <shawnguo@kernel.org>, leoyang.li@nxp.com, Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, eric.y.miao@gmail.com, Haojian Zhuang <haojian.zhuang@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, Neil Armstrong <narmstrong@baylibre.com>, Jamie Iles <jamie@jamieiles.com>, Barry Song <baohua@kernel.org>, daniel@zonque.org, robert.jarzmik@free.fr, Andy Gross <andy.gross@linaro.org>, david.brown@linaro.org, Viresh Kumar <vireshk@kernel.org>, Shiraz Hashim <shiraz.linux.kernel@gmail.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Jun Nie <jun.nie@linaro.org>, linux-arm-kernel@axis.com, "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>, "moderated list:ARM/Mediatek SoC..." <linux-mediatek@lists.infradead.org>, linux-oxnas@groups.io, linux-arm-msm <linux-arm-msm@vger.kernel.org>, linux-soc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
List-ID: <linux-oxnas@groups.io>

On Sat, Dec 1, 2018 at 1:06 AM Rob Herring <robh@kernel.org> wrote:
>
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
> Yes, I'm being lazy and not splitting this up into dozens of sub-arch
> patches. I don't think this should conflict nor should we be getting new
> dependencies on skeleton.dtsi. So please apply directly to arm-soc.
>
> Rob
>

[...]

>  arch/arm/boot/dts/sun5i-a10s.dtsi              |  4 ++--
>  arch/arm/boot/dts/sun5i-a13.dtsi               |  4 ++--
>  arch/arm/boot/dts/sun5i.dtsi                   |  9 +++++++--
>  arch/arm/boot/dts/sun6i-a31.dtsi               |  5 +++--
>  arch/arm/boot/dts/sun7i-a20.dtsi               |  5 +++--
>  arch/arm/boot/dts/sun8i-a23-a33.dtsi           |  4 ++--
>  arch/arm/boot/dts/sun8i-a23.dtsi               |  1 +
>  arch/arm/boot/dts/sun8i-a33.dtsi               |  1 +

Maxime recently took care of this for Allwinner/sunxi. It should already
be in linux-next now.

ChenYu
