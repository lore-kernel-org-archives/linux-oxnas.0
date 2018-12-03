Received: by mail-wr1-f67.google.com with SMTP id q18so11216235wrx.9
        for <linux-oxnas@groups.io>; Mon, 03 Dec 2018 01:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=J8HAC4m9QJ7qId2wfVHJZTANnrFF67ITasl16JJDGXU=;
        b=bH7QAdHAuFdlYI6j+0/gD9IcAw8SWAyT28GM8KX6nbHC+Utr7rkEXKQyT5SHNOjZLd
         AenU+Yb5BXpNAdJW0HlPJ6MFM2kI99bzeEveiCnf6GjlmEVy0GiUvtu6HiRBsbh7bICh
         Cse0m7Z2Dn4HITWu88q+j2pdgJd89mwhH8K0Dm/2cXW5ZMTQ3asB38xon95h2TqmtZlk
         LZuf7AIUzRYfcB+M1P3xG2O/R8UmDMJclTHDWWwtx5TD2HjuabgL5GL4mWaKrlpclryN
         +YoVkpQGzrfYxKdg4Heu1N0+LrSd9retkbdtbzu4/F2/7Z34q4v1dLqBptWf8EN2Xf9U
         BCyw==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] ARM: dts: Kill off skeleton{64}.dtsi
References: <20181130170634.9467-1-robh@kernel.org>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <95299838-4954-4cb8-d026-82a33eb941a3@baylibre.com>
Date: Mon, 3 Dec 2018 10:01:17 +0100
MIME-Version: 1.0
In-Reply-To: <20181130170634.9467-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>, arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Tsahee Zidenberg <tsahee@annapurnalabs.com>, Antoine Tenart <antoine.tenart@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Lars Persson <lars.persson@axis.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Florian Fainelli <f.fainelli@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Baruch Siach <baruch@tkos.co.il>, Vladimir Zapolskiy <vz@mleia.com>, Sylvain Lemieux <slemieux.tyco@gmail.com>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, Jamie Iles <jamie@jamieiles.com>, Barry Song <baohua@kernel.org>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Viresh Kumar <vireshk@kernel.org>, Shiraz Hashim <shiraz.linux.kernel@gmail.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, Jun Nie <jun.nie@linaro.org>, linux-arm-kernel@axis.com, linux-amlogic@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-oxnas@groups.io, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
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
>  arch/arm/boot/dts/alpine.dtsi                  |  8 +++++++-
>  arch/arm/boot/dts/arm-realview-eb.dtsi         |  4 +++-
>  arch/arm/boot/dts/arm-realview-pb1176.dts      |  4 +++-
>  arch/arm/boot/dts/arm-realview-pb11mp.dts      |  4 +++-
>  arch/arm/boot/dts/arm-realview-pbx.dtsi        |  4 +++-
>  arch/arm/boot/dts/armada-38x.dtsi              |  4 +++-
>  arch/arm/boot/dts/armada-39x.dtsi              |  3 ++-
>  arch/arm/boot/dts/artpec6.dtsi                 |  3 ++-
>  arch/arm/boot/dts/at91rm9200.dtsi              |  4 +++-
>  arch/arm/boot/dts/at91sam9260.dtsi             |  4 +++-
>  arch/arm/boot/dts/at91sam9261.dtsi             |  4 +++-
>  arch/arm/boot/dts/at91sam9263.dtsi             |  4 +++-
>  arch/arm/boot/dts/at91sam9g45.dtsi             |  4 +++-
>  arch/arm/boot/dts/at91sam9n12.dtsi             |  4 +++-
>  arch/arm/boot/dts/at91sam9rl.dtsi              |  4 +++-
>  arch/arm/boot/dts/at91sam9x5.dtsi              |  4 +++-
>  arch/arm/boot/dts/atlas6-evb.dts               |  1 +
>  arch/arm/boot/dts/atlas6.dtsi                  |  1 -
>  arch/arm/boot/dts/atlas7.dtsi                  |  1 -
>  arch/arm/boot/dts/axm55xx.dtsi                 |  4 ++--
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
>  arch/arm/boot/dts/cx92755.dtsi                 |  4 ++--
>  arch/arm/boot/dts/dove.dtsi                    |  4 ++--
>  arch/arm/boot/dts/ep7209.dtsi                  |  4 ++--
>  arch/arm/boot/dts/ep7211-edb7211.dts           |  1 +
>  arch/arm/boot/dts/integrator.dtsi              | 10 ++++++++--
>  arch/arm/boot/dts/kirkwood.dtsi                |  3 ++-
>  arch/arm/boot/dts/lpc32xx.dtsi                 |  4 ++--
>  arch/arm/boot/dts/ls1021a.dtsi                 |  8 +++++++-
>  arch/arm/boot/dts/meson.dtsi                   |  3 ++-
>  arch/arm/boot/dts/meson6-atv1200.dts           |  1 +
>  arch/arm/boot/dts/meson8-minix-neo-x8.dts      |  1 +
>  arch/arm/boot/dts/meson8b-ec100.dts            |  1 +
>  arch/arm/boot/dts/meson8b-mxq.dts              |  1 +
>  arch/arm/boot/dts/meson8b-odroidc1.dts         |  1 +
>  arch/arm/boot/dts/meson8m2-mxiii-plus.dts      |  1 +
>  arch/arm/boot/dts/mmp2-brownstone.dts          |  1 +
>  arch/arm/boot/dts/mmp2.dtsi                    |  4 +++-
>  arch/arm/boot/dts/moxart.dtsi                  |  3 ++-
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
>  arch/arm/boot/dts/nspire.dtsi                  |  4 ++--
>  arch/arm/boot/dts/orion5x-lacie-d2-network.dts |  1 +
>  .../orion5x-lacie-ethernet-disk-mini-v2.dts    |  1 +
>  arch/arm/boot/dts/orion5x-lswsgl.dts           |  1 +
>  .../dts/orion5x-maxtor-shared-storage-2.dts    |  1 +
>  arch/arm/boot/dts/orion5x-netgear-wnr854t.dts  |  1 +
>  arch/arm/boot/dts/orion5x-rd88f5182-nas.dts    |  1 +
>  arch/arm/boot/dts/orion5x.dtsi                 |  4 ++--
>  arch/arm/boot/dts/ox810se.dtsi                 |  4 +++-
>  arch/arm/boot/dts/ox820.dtsi                   |  4 +++-
>  arch/arm/boot/dts/picoxcell-pc3x2.dtsi         |  1 -
>  arch/arm/boot/dts/picoxcell-pc3x3.dtsi         |  1 -
>  arch/arm/boot/dts/prima2-evb.dts               |  1 +
>  arch/arm/boot/dts/prima2.dtsi                  |  1 -
>  arch/arm/boot/dts/pxa168.dtsi                  |  4 +++-
>  arch/arm/boot/dts/pxa2xx.dtsi                  |  3 ++-
>  arch/arm/boot/dts/pxa910.dtsi                  |  4 +++-
>  arch/arm/boot/dts/qcom-apq8064.dtsi            |  8 +++++++-
>  arch/arm/boot/dts/qcom-apq8084.dtsi            |  9 +++++++--
>  arch/arm/boot/dts/qcom-ipq4019.dtsi            |  8 +++++++-
>  arch/arm/boot/dts/qcom-ipq8064.dtsi            |  8 +++++++-
>  arch/arm/boot/dts/qcom-mdm9615-wp8548.dtsi     |  1 +
>  arch/arm/boot/dts/qcom-mdm9615.dtsi            |  4 ++--
>  arch/arm/boot/dts/qcom-msm8660.dtsi            |  9 +++++++--
>  arch/arm/boot/dts/qcom-msm8960.dtsi            |  9 +++++++--
>  arch/arm/boot/dts/qcom-msm8974.dtsi            |  8 +++++++-
>  arch/arm/boot/dts/sama5d2.dtsi                 |  4 +++-
>  arch/arm/boot/dts/sama5d3.dtsi                 |  4 +++-
>  arch/arm/boot/dts/sama5d4.dtsi                 |  4 +++-
>  arch/arm/boot/dts/skeleton.dtsi                | 18 ------------------
>  arch/arm/boot/dts/skeleton64.dtsi              | 14 --------------
>  arch/arm/boot/dts/spear13xx.dtsi               |  4 ++--
>  arch/arm/boot/dts/spear3xx.dtsi                |  4 ++--
>  arch/arm/boot/dts/spear600.dtsi                |  4 ++--
>  arch/arm/boot/dts/ste-nomadik-stn8815.dtsi     |  2 +-
>  arch/arm/boot/dts/ste-u300.dts                 |  2 +-
>  arch/arm/boot/dts/stm32429i-eval.dts           |  1 +
>  arch/arm/boot/dts/stm32746g-eval.dts           |  1 +
>  arch/arm/boot/dts/stm32f429-disco.dts          |  1 +
>  arch/arm/boot/dts/stm32f429.dtsi               |  4 +++-
>  arch/arm/boot/dts/stm32f469-disco.dts          |  1 +
>  arch/arm/boot/dts/stm32f746-disco.dts          |  1 +
>  arch/arm/boot/dts/stm32f746.dtsi               |  4 +++-
>  arch/arm/boot/dts/stm32f769-disco.dts          |  1 +
>  arch/arm/boot/dts/stm32h743.dtsi               |  4 +++-
>  arch/arm/boot/dts/stm32h743i-disco.dts         |  1 +
>  arch/arm/boot/dts/stm32h743i-eval.dts          |  1 +
>  arch/arm/boot/dts/stm32mp157c-ed1.dts          |  1 +
>  arch/arm/boot/dts/sun5i-a10s.dtsi              |  4 ++--
>  arch/arm/boot/dts/sun5i-a13.dtsi               |  4 ++--
>  arch/arm/boot/dts/sun5i.dtsi                   |  9 +++++++--
>  arch/arm/boot/dts/sun6i-a31.dtsi               |  5 +++--
>  arch/arm/boot/dts/sun7i-a20.dtsi               |  5 +++--
>  arch/arm/boot/dts/sun8i-a23-a33.dtsi           |  4 ++--
>  arch/arm/boot/dts/sun8i-a23.dtsi               |  1 +
>  arch/arm/boot/dts/sun8i-a33.dtsi               |  1 +
>  arch/arm/boot/dts/versatile-ab.dts             |  2 +-
>  arch/arm/boot/dts/vt8500.dtsi                  |  9 +++++++--
>  arch/arm/boot/dts/wm8505.dtsi                  |  9 +++++++--
>  arch/arm/boot/dts/wm8650.dtsi                  |  9 +++++++--
>  arch/arm/boot/dts/wm8750.dtsi                  |  9 +++++++--
>  arch/arm/boot/dts/wm8850.dtsi                  |  9 +++++++--
>  arch/arm/boot/dts/zx296702-ad1.dts             |  1 +
>  arch/arm/boot/dts/zx296702.dtsi                |  4 +++-
>  149 files changed, 330 insertions(+), 153 deletions(-)
>  delete mode 100644 arch/arm/boot/dts/skeleton.dtsi
>  delete mode 100644 arch/arm/boot/dts/skeleton64.dtsi
> 

[...]

> diff --git a/arch/arm/boot/dts/ox810se.dtsi b/arch/arm/boot/dts/ox810se.dtsi
> index c2b48a1838eb..3a26650de4eb 100644
> --- a/arch/arm/boot/dts/ox810se.dtsi
> +++ b/arch/arm/boot/dts/ox810se.dtsi
> @@ -6,11 +6,12 @@
>   * Licensed under GPLv2 or later
>   */
>  
> -/include/ "skeleton.dtsi"
>  #include <dt-bindings/clock/oxsemi,ox810se.h>
>  #include <dt-bindings/reset/oxsemi,ox810se.h>
>  
>  / {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
>  	compatible = "oxsemi,ox810se";
>  
>  	cpus {
> @@ -25,6 +26,7 @@
>  	};
>  
>  	memory {
> +		device_type = "memory";
>  		/* Max 256MB @ 0x48000000 */
>  		reg = <0x48000000 0x10000000>;
>  	};
> diff --git a/arch/arm/boot/dts/ox820.dtsi b/arch/arm/boot/dts/ox820.dtsi
> index 085bbd33eadc..f3239586f38d 100644
> --- a/arch/arm/boot/dts/ox820.dtsi
> +++ b/arch/arm/boot/dts/ox820.dtsi
> @@ -6,12 +6,13 @@
>   * Licensed under GPLv2 or later
>   */
>  
> -/include/ "skeleton.dtsi"
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/clock/oxsemi,ox820.h>
>  #include <dt-bindings/reset/oxsemi,ox820.h>
>  
>  / {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
>  	compatible = "oxsemi,ox820";
>  
>  	cpus {
> @@ -35,6 +36,7 @@
>  	};
>  
>  	memory {
> +		device_type = "memory";
>  		/* Max 512MB @ 0x60000000 */
>  		reg = <0x60000000 0x20000000>;
>  	};

[...]

For Oxnas,

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Thanks,
Neil
