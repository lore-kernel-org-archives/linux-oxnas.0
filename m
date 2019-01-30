Received: by mail-qt1-f196.google.com with SMTP id l12so133685qtf.8
        for <linux-oxnas@groups.io>; Wed, 30 Jan 2019 08:31:48 -0800 (PST)
MIME-Version: 1.0
References: <20190109162614.30855-1-robh@kernel.org> <87h8ehpwm2.fsf@FE-laptop>
In-Reply-To: <87h8ehpwm2.fsf@FE-laptop>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 30 Jan 2019 17:31:31 +0100
Message-ID: <CAK8P3a04uO2Nz-M4NVgMsGy2BPRx9pM1cCuUeS54Jf8N18-9NQ@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: Kill off skeleton{64}.dtsi
Content-Type: text/plain; charset="UTF-8"
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, DTML <devicetree@vger.kernel.org>, Tsahee Zidenberg <tsahee@annapurnalabs.com>, Antoine Tenart <antoine.tenart@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Lars Persson <lars.persson@axis.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, Florian Fainelli <f.fainelli@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Baruch Siach <baruch@tkos.co.il>, Vladimir Zapolskiy <vz@mleia.com>, Sylvain Lemieux <slemieux.tyco@gmail.com>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, Neil Armstrong <narmstrong@baylibre.com>, Jamie Iles <jamie@jamieiles.com>, Barry Song <baohua@kernel.org>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Viresh Kumar <vireshk@kernel.org>, Shiraz Hashim <shiraz.linux.kernel@gmail.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Jun Nie <jun.nie@linaro.org>, linux-arm-kernel@axis.com, "open list:ARM/Amlogic Meson SoC support" <linux-amlogic@lists.infradead.org>, "moderated list:ARM/Mediatek SoC..." <linux-mediatek@lists.infradead.org>, linux-oxnas@groups.io, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, Viresh Kumar <viresh.kumar@linaro.org>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>
List-ID: <linux-oxnas@groups.io>

On Wed, Jan 9, 2019 at 6:30 PM Gregory CLEMENT
<gregory.clement@bootlin.com> wrote:
>
> Hi Rob,
>
>  On mer., janv. 09 2019, Rob Herring <robh@kernel.org> wrote:
>
> > Remove the usage of skeleton.dtsi in the remaining dts files. It was
> > deprecated since commit 9c0da3cc61f1 ("ARM: dts: explicitly mark
> > skeleton.dtsi as deprecated"). This will make adding a unit-address to
> > memory nodes easier.
> >
> > The main tricky part to removing skeleton.dtsi is we could end up with
> > no /memory node at all when a bootloader depends on one being present. I
> > hacked up dtc to check for this condition.
>
>
> Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> and for Armada 38x:
> Tested-by: Gregory CLEMENT <gregory.clement@bootlin.com>
>

Applied to arm/dt now, thanks!

     Arnd
