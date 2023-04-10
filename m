Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
 by mx.groups.io with SMTP id smtpd.web11.37656.1681105037796977737
 for <linux-oxnas@groups.io>;
 Sun, 09 Apr 2023 22:37:18 -0700
Received: by mail-ej1-f43.google.com with SMTP id sh8so10103518ejc.10
        for <linux-oxnas@groups.io>; Sun, 09 Apr 2023 22:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681105036;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2/k4nezMOkcM+h2CDII7+REb1p1LqwOaOkMYQqqQJrs=;
        b=whrLD5VxYI35os9KEqHHxKa9Pszo5bo/r3L1orZhvpTq+fxiO2jOFNxbUlcI0Vs3GI
         p3RauP4xFlUGVo8P+SU0FAjx22bxvxCcnObAMYYRyICpZgnhTXjhA5DCU6ygFH4gKuyO
         eXbdDoA7p3M07jbTtohEJ2v/Tz9VjHr6a0oJvdDrr7ejrHUVk++XAtzWb+z2In6SL2Gl
         t5tXQY/ajlwSp4Lah8lGP7hewVhzXVhK5MgiJIM1jDOC3z+GFlsAzATc7ylW+X+YH8So
         id2qKF0m1S0qz2zyvyjFzxEpK2HPsFYVayvCP8RJW7o40S1Tl79GVKw4kmsvRGVPv8gK
         DGNw==
Return-Path: <tudor.ambarus@linaro.org>
Message-ID: <5d091ef6-0f4c-dbf6-fb73-f9f9d13af3d8@linaro.org>
Date: Mon, 10 Apr 2023 06:37:11 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] mtd: nand: Convert to platform remove callback returning void
References: <20230401161938.2503204-1-u.kleine-koenig@pengutronix.de>
 <20230407101043.299f5e22@xps-13>
 <20230408185332.d2g2ao4tdp6ltm4i@pengutronix.de>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230408185332.d2g2ao4tdp6ltm4i@pengutronix.de>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lucas Stach <dev@lynxeye.de>, Vignesh Raghavendra <vigneshr@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Miaoqian Lin <linmq006@gmail.com>, Stefan Agner <stefan@agner.ch>, linux-mips@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>, linux-tegra@vger.kernel.org, Liang Yang <liang.yang@amlogic.com>, Naga Sureshkumar Relli <nagasure@xilinx.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, linux-amlogic@lists.infradead.org, Chuanhong Guo <gch981213@gmail.com>, linux-stm32@st-md-mailman.stormreply.com, Heiko Stuebner <heiko@sntech.de>, =?UTF-8?Q?Marek_Beh=c3=ban?= <kabel@kernel.org>, Samuel Holland <samuel@sholland.org>, Alexandre Torgue <alexandre.torgue@foss.st.com>, Kevin Hilman <khilman@baylibre.com>, linux-mediatek@lists.infradead.org, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, Jonathan Hunter <jonathanh@nvidia.com>, linux-rockchip@lists.infradead.org, Geert Uytterhoeven <geert@linux-m68k.org>, Yang Yingliang <yangyingliang@huawei.com>, Jack Wang <jinpu.wang@ionos.com>, Jerome Brunet <jbrunet@baylibre.com>, linux-sunxi@lists.linux.dev, linux-arm-msm@vger.kernel.org, kernel@pengutronix.de, Arnd Bergmann <arnd@arndb.de>, Manivannan Sadhasivam <mani@kernel.org>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, ye xingchen <ye.xingchen@zte.com.cn>, Vladimir Zapolskiy <vz@mleia.com>, Roger Quadros <rogerq@kernel.org>, Wang Weiyang <wangweiyang2@huawei.com>, Harvey Hunt <harveyhuntnexus@gmail.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Matthias Brugger <matthias.bgg@gmail.com>, Han Xu <han.xu@nxp.com>, Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Neil Armstrong <neil.armstrong@linaro.org>, Christophe Kerello <christophe.kerello@foss.st.com>, Stephen Boyd <sboyd@kernel.org>, Valentin Korenblit <vkorenblit@sequans.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, linux-renesas-soc@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org, linux-oxnas@groups.io, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>, Claudiu Beznea <claudiu.beznea@microchip.com>
List-ID: <linux-oxnas@groups.io>



On 4/8/23 19:53, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> Reviewed-by: Paul Cercueil <paul@crapouillou.net>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Acked-by: Roger Quadros <rogerq@kernel.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

b4 seems didn't take my tag on 00/49, here it is again:
Acked-by: Tudor Ambarus <tudor.ambarus@linaro.org>
