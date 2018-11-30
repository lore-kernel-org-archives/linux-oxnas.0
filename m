Received: by mail-lj1-f195.google.com with SMTP id c19-v6so5656507lja.5
        for <linux-oxnas@groups.io>; Fri, 30 Nov 2018 09:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nbfoPr1xMHd1fgb88kiJpnlNQqC8pSkddVzUkjNcoIc=;
        b=boL04lyzJuoCNledpeW8v+Q4jPKuWhZUqnt3ZsMrWZcoget8Cf2ZmzpVdo9cgwaDlG
         qaWv2ii83T3o1rBgaHv725foEzfTbjNgqpeB6A8ueaGmgmFaSWsF745U5n4Pu2V87Aj6
         eOmMAnhkVIOg7R+hfxBhmjT2sb+4dmI9I01aY=
MIME-Version: 1.0
References: <20181130170634.9467-1-robh@kernel.org>
In-Reply-To: <20181130170634.9467-1-robh@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 30 Nov 2018 18:21:35 +0100
Message-ID: <CACRpkdaxAX72a6vpOqGwhhPEKeCz3YJz3wjxF5nsRmei-cRY8w@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: Kill off skeleton{64}.dtsi
Content-Type: text/plain; charset="UTF-8"
To: Rob Herring <robh@kernel.org>
Cc: arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Tsahee Zidenberg <tsahee@annapurnalabs.com>, Antoine Tenart <antoine.tenart@bootlin.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Lars Persson <lars.persson@axis.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Florian Fainelli <f.fainelli@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Baruch Siach <baruch@tkos.co.il>, Vladimir Zapolskiy <vz@mleia.com>, Sylvain Lemieux <slemieux.tyco@gmail.com>, Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>, Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, Neil Armstrong <narmstrong@baylibre.com>, Jamie Iles <jamie@jamieiles.com>, Barry Song <baohua@kernel.org>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Viresh Kumar <vireshk@kernel.org>, shiraz hashim <shiraz.linux.kernel@gmail.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre TORGUE <alexandre.torgue@st.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, Jun Nie <jun.nie@linaro.org>, linux-arm-kernel@axis.com, "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, linux-oxnas@groups.io, linux-arm-msm@vger.kernel.org, "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
List-ID: <linux-oxnas@groups.io>

On Fri, Nov 30, 2018 at 6:06 PM Rob Herring <robh@kernel.org> wrote:

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

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Good riddance.

> Yes, I'm being lazy and not splitting this up into dozens of sub-arch
> patches. I don't think this should conflict nor should we be getting new
> dependencies on skeleton.dtsi. So please apply directly to arm-soc.

A patch should be "one technical step" and this is one technical step.

I don't think the compulsive requests to split patches up gives
us anything in cases like this, it just cost us valuable development
time.

So this is the right approach.

Linus Walleij
