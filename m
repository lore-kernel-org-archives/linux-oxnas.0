Subject: Re: [PATCH] ARM: dts: Kill off skeleton{64}.dtsi
References: <20181130170634.9467-1-robh@kernel.org>
From: Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <a10f92c0-50f9-1e10-4b17-c694353e4580@mleia.com>
Date: Tue, 4 Dec 2018 00:27:36 +0200
MIME-Version: 1.0
In-Reply-To: <20181130170634.9467-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>, arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Tsahee Zidenberg <tsahee@annapurnalabs.com>, Antoine Tenart <antoine.tenart@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Lars Persson <lars.persson@axis.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Florian Fainelli <f.fainelli@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Baruch Siach <baruch@tkos.co.il>, Sylvain Lemieux <slemieux.tyco@gmail.com>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, Neil Armstrong <narmstrong@baylibre.com>, Jamie Iles <jamie@jamieiles.com>, Barry Song <baohua@kernel.org>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Viresh Kumar <vireshk@kernel.org>, Shiraz Hashim <shiraz.linux.kernel@gmail.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, Jun Nie <jun.nie@linaro.org>, linux-arm-kernel@axis.com, linux-amlogic@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-oxnas@groups.io, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
List-ID: <linux-oxnas@groups.io>

On 11/30/2018 07:06 PM, Rob Herring wrote:
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

[snip]

> diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
> index b7303a4e4236..44b468e4c37a 100644
> --- a/arch/arm/boot/dts/lpc32xx.dtsi
> +++ b/arch/arm/boot/dts/lpc32xx.dtsi
> @@ -11,12 +11,12 @@
>   * http://www.gnu.org/copyleft/gpl.html
>   */
>  
> -#include "skeleton.dtsi"
> -
>  #include <dt-bindings/clock/lpc32xx-clock.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  
>  / {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
>  	compatible = "nxp,lpc3220";
>  	interrupt-parent = <&mic>;
>  

For lpc32xx:

Acked-by: Vladimir Zapolskiy <vz@mleia.com>

--
Best wishes,
Vladimir
