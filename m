Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
 by mx.groups.io with SMTP id smtpd.web10.76115.1680539405424961225
 for <linux-oxnas@groups.io>;
 Mon, 03 Apr 2023 09:30:05 -0700
Received: by mail-ed1-f46.google.com with SMTP id x3so119581463edb.10
        for <linux-oxnas@groups.io>; Mon, 03 Apr 2023 09:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680539404;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MeWz95RBmI6XpSLkAR+cuB3iAEeGC3iRvwSDE5+WIbY=;
        b=vHhtKJL5afd3fDZb5Xvy5G6y/LTvqitLGSe7Ap0XWRSd3UnHwlhXG/jlL1pEDbro5N
         dDLdwGPIJVRIvCgJf+ooSRVUmcxTfsxV8spRGbOdGMiu0Yjabnu9Hv/mjHGNPXQ8lvjN
         cHe5ugODQYhlOZWDVDxVyYBUABgPfEhUNhPdKeF3/9v5wJk7oZDOr605S7tVuPNd8wTF
         bx6a/0ODqm177Gf9vkkLZzZXwHE9nR4G62csYL1zJ90eb79s5EDQerAqVGy4fDYuhuFx
         gXu3jujaXU5RPMtaZlFQ+OKGBp5RSLJJ0rYp6O8X402TZk6l3E92wW+w0z23pJ8wZvpJ
         eSIg==
Return-Path: <tudor.ambarus@linaro.org>
Message-ID: <f881883e-23e1-66e0-78d2-da86533b038f@linaro.org>
Date: Mon, 3 Apr 2023 17:29:59 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 00/49] mtd: nand: Convert to platform remove callback returning void
References: <20230401161938.2503204-1-u.kleine-koenig@pengutronix.de>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230401161938.2503204-1-u.kleine-koenig@pengutronix.de>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Miquel Raynal <miquel.raynal@bootlin.com>, Vignesh Raghavendra <vigneshr@ti.com>, Kyungmin Park <kyungmin.park@samsung.com>, Naga Sureshkumar Relli <nagasure@xilinx.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@microchip.com>, Yang Yingliang <yangyingliang@huawei.com>, ye xingchen <ye.xingchen@zte.com.cn>, Valentin Korenblit <vkorenblit@sequans.com>, Wang Weiyang <wangweiyang2@huawei.com>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>, =?UTF-8?Q?Marek_Beh=c3=ban?= <kabel@kernel.org>, Han Xu <han.xu@nxp.com>, Harvey Hunt <harveyhuntnexus@gmail.com>, Paul Cercueil <paul@crapouillou.net>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Vladimir Zapolskiy <vz@mleia.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Liang Yang <liang.yang@amlogic.com>, Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Phil Edworthy <phil.edworthy@renesas.com>, Matthias Brugger <matthias.bgg@gmail.com>, Chuanhong Guo <gch981213@gmail.com>, Roger Quadros <rogerq@kernel.org>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Manivannan Sadhasivam <mani@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Miaoqian Lin <linmq006@gmail.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, Christophe Kerello <christophe.kerello@foss.st.com>, Jack Wang <jinpu.wang@ionos.com>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Stefan Agner <stefan@agner.ch>, Lucas Stach <dev@lynxeye.de>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>, linux-amlogic@lists.infradead.org, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-mediatek@lists.infradead.org, linux-oxnas@groups.io, linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org
List-ID: <linux-oxnas@groups.io>



On 4/1/23 17:18, Uwe Kleine-König wrote:
> Hello,
> 
> this series adapts the platform drivers below drivers/mtd/nand to use the
> .remove_new() callback. Compared to the traditional .remove() callback
> .remove_new() returns no value. This is a good thing because the driver core
> doesn't (and cannot) cope for errors during remove. The only effect of a
> non-zero return value in .remove() is that the driver core emits a warning. The
> device is removed anyhow and an early return from .remove() usually yields a
> resource leak.
> 
> By changing the remove callback to return void driver authors cannot
> reasonably assume any more that there is some kind of cleanup later.
> 
> As all drivers already return 0 in their .remove callback, they can be
> converted trivially.
> 

I'd make a single patch per subsystem for trivial changes, but I don't
mind having them split per driver either:

Acked-by: Tudor Ambarus <tudor.ambarus@linaro.org>
