Received: by mail-ot1-f65.google.com with SMTP id s5so20183099oth.7
        for <linux-oxnas@groups.io>; Wed, 05 Dec 2018 14:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CTASaRgjxa3Vst5bpuF6+cd2n2tSchKcjLVtiHO069g=;
        b=sYp2FxACt0DLFadFk2vfA9fJ422ZekmQi9vEKs8lIgNJN1s7oL9wK0m7BanMZA3yy7
         c8cvEvJ5etUWyeS48yVBQJJmmKUIlKodpS7y+QgT8gNod9AB58p+S4xnWPL6xiq5jh/H
         Qo6XknuWFcjOPZ1TbexXG++cWgrfSwAAXwWJSWVHEK4h2nds/+0g+ilVTBmi/K7Q+Gv4
         N3zCkf7WVHnR0YeO/7tSy/eGqLx1KMxsxT3ovENMQN+rAVSHBGildV4sJKn3K8MbDpd4
         C0Q/AR+GZn+WJATu65WiEsnYu/vQiYF6JdqTZVuUNdAjgJ1Fzve0Ve+8TpbBvse7qBvA
         mCCw==
MIME-Version: 1.0
References: <20181130170634.9467-1-robh@kernel.org>
In-Reply-To: <20181130170634.9467-1-robh@kernel.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Wed, 5 Dec 2018 23:21:06 +0100
Message-ID: <CAFBinCCyiOurskMNYeJaC3YHZF0CCVJg7q61Gs=wdZYAH83NCw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: Kill off skeleton{64}.dtsi
Content-Type: text/plain; charset="UTF-8"
To: robh@kernel.org
Cc: arm@kernel.org, andrew@lunn.ch, alexandre.belloni@bootlin.com, Neil Armstrong <narmstrong@baylibre.com>, maxime.ripard@bootlin.com, linus.walleij@linaro.org, baruch@tkos.co.il, david.brown@linaro.org, jamie@jamieiles.com, robert.jarzmik@free.fr, linux-stm32@st-md-mailman.stormreply.com, alexandre.torgue@st.com, jesper.nilsson@axis.com, f.fainelli@gmail.com, khilman@baylibre.com, gregory.clement@bootlin.com, zajec5@gmail.com, wens@csie.org, linux-arm-kernel@axis.com, jonmason@broadcom.com, ludovic.desroches@microchip.com, bcm-kernel-feedback-list@broadcom.com, Hauke Mehrtens <hauke@hauke-m.de>, andy.gross@linaro.org, sebastian.hesselbarth@gmail.com, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, jason@lakedaemon.net, antoine.tenart@bootlin.com, rjui@broadcom.com, slemieux.tyco@gmail.com, haojian.zhuang@gmail.com, vz@mleia.com, linux-mediatek@lists.infradead.org, lars.persson@axis.com, gregory.0xf0@gmail.com, matthias.bgg@gmail.com, linux-amlogic@lists.infradead.org, linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, baohua@kernel.org, linux-oxnas@groups.io, eric.y.miao@gmail.com, sbranden@broadcom.com, shiraz.linux.kernel@gmail.com, nicolas.ferre@microchip.com, leoyang.li@nxp.com, mcoquelin.stm32@gmail.com, vireshk@kernel.org, carlo@caione.org, jun.nie@linaro.org, computersforpeace@gmail.com, shawnguo@kernel.org, tsahee@annapurnalabs.com, daniel@zonque.org
List-ID: <linux-oxnas@groups.io>

Hi Rob,

On Fri, Nov 30, 2018 at 6:07 PM Rob Herring <robh@kernel.org> wrote:
>
> Remove the usage of skeleton.dtsi in the remaining dts files. It was
> deprecated since commit 9c0da3cc61f1 ("ARM: dts: explicitly mark
> skeleton.dtsi as deprecated"). This will make adding a unit-address to
> memory nodes easier.
thank you for cleaning this up!

> The main tricky part to removing skeleton.dtsi is we could end up with
> no /memory node at all when a bootloader depends on one being present. I
> hacked up dtc to check for this condition.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
on Meson8b Odroid-C1:
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

>  arch/arm/boot/dts/meson.dtsi                   |  3 ++-
>  arch/arm/boot/dts/meson6-atv1200.dts           |  1 +
>  arch/arm/boot/dts/meson8-minix-neo-x8.dts      |  1 +
>  arch/arm/boot/dts/meson8b-ec100.dts            |  1 +
>  arch/arm/boot/dts/meson8b-mxq.dts              |  1 +
>  arch/arm/boot/dts/meson8b-odroidc1.dts         |  1 +
>  arch/arm/boot/dts/meson8m2-mxiii-plus.dts      |  1 +
for the Meson changes:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


Regards
Martin
