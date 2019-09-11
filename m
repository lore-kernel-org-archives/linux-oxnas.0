Received: by mail-wm1-f67.google.com with SMTP id n10so2201281wmj.0
        for <linux-oxnas@groups.io>; Wed, 11 Sep 2019 00:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ntQnlZ165aoTq9A7WDI2toA4HdgPISzpICPAyGRYlc4=;
        b=DMMbzJxxUXHFi6Z63lgJ1y7Sb/XAkiZLWF0D1+uoabJCHSepnQp4es4L6JW2eVagzh
         72rCnxWkdINIZffgA6FJDDv1cZsc+xCJ96gjFDGsnFT/hoLUjJPTrbgYaJd7PokhtWnH
         OTfaJl12/d5r/1ERItxyTyhsgX31+DwTKVVyoNiRpdAo1kVz31c2aiTgxAUBVDnpjMAV
         DjtgPgaTKqzDjK8Ac7atghJQxxGqy9uZA+Mg+e9bu/zTWhUlugNecrmiCFU/k80GDkh6
         fuT2Iwj60ftMrfIVjjBd2usNbSjEkk428eJwTjzYtZ3c+FGD6oRv2oFmwmg93VzpK1Sh
         ca5g==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 4/7] dt-bindings: chosen: Add clocksource and clockevent selection
References: <1568123236-767-1-git-send-email-claudiu.beznea@microchip.com>
 <1568123236-767-5-git-send-email-claudiu.beznea@microchip.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <81da473f-54d7-2a00-61ec-9351cdfcaaf3@baylibre.com>
Date: Wed, 11 Sep 2019 09:34:27 +0200
MIME-Version: 1.0
In-Reply-To: <1568123236-767-5-git-send-email-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Claudiu Beznea <claudiu.beznea@microchip.com>, daniel.lezcano@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, nsekhar@ti.com, bgolaszewski@baylibre.com, monstr@monstr.eu, john@phrozen.org, ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org, lftan@altera.com, tglx@linutronix.de, vgupta@synopsys.com, marc.zyngier@arm.com, patrice.chotard@st.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, eric@anholt.net, wahrenst@gmx.net, f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, linus.walleij@linaro.org, shc_work@mail.ru, kgene@kernel.org, krzk@kernel.org, ysato@users.sourceforge.jp, liviu.dudau@arm.com, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, baohua@kernel.org, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com, baruch@tkos.co.il, u.kleine-koenig@pengutronix.de, guoren@kernel.org, kaloz@openwrt.org, khalasa@piap.pl, ssantosh@kernel.org, vz@mleia.com, slemieux.tyco@gmail.com, khilman@baylibre.com, avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com, venture@google.com, yuenn@google.com, benjaminfair@google.com, afaerber@suse.de, manivannan.sadhasivam@linaro.org, agross@kernel.org, palmer@sifive.com, aou@eecs.berkeley.edu, heiko@sntech.de, orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com, maxime.ripard@bootlin.com, wens@csie.org, thierry.reding@gmail.com, jonathanh@nvidia.com, linux@prisktech.co.nz, john.stultz@linaro.org, sboyd@kernel.org, matthias.bgg@gmail.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, nios2-dev@lists.rocketboards.org, linux-snps-arc@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, linux-rpi-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, linux-amlogic@lists.infradead.org, openbmc@lists.ozlabs.org, linux-oxnas@groups.io, linux-arm-msm@vger.kernel.org, linux-unisoc@lists.infradead.org, linux-riscv@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org, linux-mediatek@lists.infradead.org
List-ID: <linux-oxnas@groups.io>

Hi,

On 10/09/2019 15:47, Claudiu Beznea wrote:
> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
> Some timer drivers may behave either as clocksource or clockevent
> or both. Until now, in case of platforms with multiple hardware
> resources of the same type, the drivers were chosing the first
> registered hardware resource as clocksource/clockevent and the
> next one as clockevent/clocksource. Other were using different
> compatibles (one for each functionality, although its about the
> same hardware). Add DT bindings to be able to choose the
> functionality of a timer.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/chosen.txt | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/chosen.txt b/Documentation/devicetree/bindings/chosen.txt
> index 45e79172a646..aad3034cdbdf 100644
> --- a/Documentation/devicetree/bindings/chosen.txt
> +++ b/Documentation/devicetree/bindings/chosen.txt
> @@ -135,3 +135,23 @@ e.g.
>  		linux,initrd-end = <0x82800000>;
>  	};
>  };
> +
> +linux,clocksource and linux,clockevent
> +--------------------------------------
> +
> +Those nodes have a timer property. This property is a phandle to the timer to be
> +chosen as the clocksource or clockevent. This is only useful when the platform
> +has multiple identical timers and it is not possible to let linux make the
> +correct choice.
> +
> +/ {
> +	chosen {
> +		linux,clocksource {
> +			timer = <&timer0>;
> +		};
> +
> +		linux,clockevent {
> +			timer = <&timer1>;
> +		};
> +	};
> +};
> 

Why not in aliases ?

aliases {
    clocksource0 = &timer0;
    clockevent0 = &timer1;
};

since we can have multiple of each, we should not limit ourselves to 1 clkevent
and 1 clksource.

In the aliases case, each driver would expose both capabilities, and the core would select
what to enable.

Neil
