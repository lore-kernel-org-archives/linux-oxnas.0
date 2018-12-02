Received: by mail-ed1-f66.google.com with SMTP id o10so8915945edt.13
        for <linux-oxnas@groups.io>; Sun, 02 Dec 2018 11:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LAvdWhXDPlQUrYQL9AENTo/vbCPGbNO/arEEJxmWFnI=;
        b=njY/FBXb8AF2vJrbUti/eTBfpteqES/2XPf89RrGqRxSGJxUQ7vc7DXKpAclKbHIa+
         Bn2Yo4LD0XC3RMyj6tJQLpchJF3dw9xz/21xSzMjzGJY/dqmaxRqk00kUnUgoCSQx84c
         I/cLRIuNTvEUFMrKiAoFMiukGsN9e5yglnVDwuH9rh46voGUbIxfpHKFRDo+J30K8XHD
         E3CrmsnfZysDmwWOdPQ0J+zikFQPLOeivf6RLxOOv7NARkcxenJuonv1jyy9AEr1nsfF
         uYC2c2lTzpwZCaJFcQBOxeeyxKhsu+HUkXDfbS6khsrOK54fq1X/vspM8F+lRnQ84uME
         v3RA==
Return-Path: <matthias.bgg@gmail.com>
Subject: Re: [PATCH] ARM: dts: Kill off skeleton{64}.dtsi
References: <20181130170634.9467-1-robh@kernel.org>
From: Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <e819a81d-e1b2-df99-6fc6-19a3eb4d47c4@gmail.com>
Date: Sun, 2 Dec 2018 20:44:17 +0100
MIME-Version: 1.0
In-Reply-To: <20181130170634.9467-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>, arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Tsahee Zidenberg <tsahee@annapurnalabs.com>, Antoine Tenart <antoine.tenart@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Lars Persson <lars.persson@axis.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Florian Fainelli <f.fainelli@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Baruch Siach <baruch@tkos.co.il>, Vladimir Zapolskiy <vz@mleia.com>, Sylvain Lemieux <slemieux.tyco@gmail.com>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Neil Armstrong <narmstrong@baylibre.com>, Jamie Iles <jamie@jamieiles.com>, Barry Song <baohua@kernel.org>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Viresh Kumar <vireshk@kernel.org>, Shiraz Hashim <shiraz.linux.kernel@gmail.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, Jun Nie <jun.nie@linaro.org>, linux-arm-kernel@axis.com, linux-amlogic@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-oxnas@groups.io, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
List-ID: <linux-oxnas@groups.io>



On 30/11/2018 18:06, Rob Herring wrote:
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
>  arch/arm/boot/dts/alphascale-asm9260.dtsi      |  3 ++-
[...]
>  arch/arm/boot/dts/mt2701-evb.dts               |  1 +
>  arch/arm/boot/dts/mt2701.dtsi                  |  3 ++-
>  arch/arm/boot/dts/mt6580-evbp1.dts             |  1 +
>  arch/arm/boot/dts/mt6580.dtsi                  |  1 -
>  arch/arm/boot/dts/mt6589-aquaris5.dts          |  1 +
>  arch/arm/boot/dts/mt6589.dtsi                  |  3 ++-
>  arch/arm/boot/dts/mt6592-evb.dts               |  2 +-
>  arch/arm/boot/dts/mt6592.dtsi                  |  3 ++-
>  arch/arm/boot/dts/mt8127-moose.dts             |  1 +
>  arch/arm/boot/dts/mt8127.dtsi                  |  3 ++-
>  arch/arm/boot/dts/mt8135-evbp1.dts             |  1 +
>  arch/arm/boot/dts/mt8135.dtsi                  |  3 ++-

For the MediaTek part:
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
