Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
 by mx.groups.io with SMTP id smtpd.web10.81.1683574734029045206
 for <linux-oxnas@groups.io>;
 Mon, 08 May 2023 12:38:54 -0700
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-965ddb2093bso626173566b.2
        for <linux-oxnas@groups.io>; Mon, 08 May 2023 12:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683574732; x=1686166732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+JxqPdloLojC2MiANkEpzLfG41+hupeelG9KGREc2mw=;
        b=LdKR+DvwekVyUqgb/OT5xTqhw/MViMQ2grjMX3F9EokLXqNtqQu+Yaq832aoIGmDUD
         lhFJulZucMOiVKprfDsGQg9GFm2RX72N6K4RFjcwnLALtfKYtElM4ySRQMBQ1AvOcDqt
         8P4dmntcKQTi5iP7QRCEAwIgDsBHatpoJLQksY2CBr0/CbuVNwuxoIne1er9XhoRQI+C
         Ifcf1ZXUagIN/A33dX2c5xKrqXa+QMwky6t/Mba+jSXTPJHMtanSbaWx9Uo87ctCq6Np
         FIonibR0S5vhRSKVOKruXgY14G/yJg8NCal6Ar8m/NHKoxaj1g7jRcJvWV+49tuOAONI
         5UkA==
MIME-Version: 1.0
References: <20230508142637.1449363-1-u.kleine-koenig@pengutronix.de> <20230508142637.1449363-2-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230508142637.1449363-2-u.kleine-koenig@pengutronix.de>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Mon, 8 May 2023 21:38:41 +0200
Message-ID: <CAFBinCAXQywWReBbqRCgB36gKGjhX9Tx6g-8OTewt_xipdhp3w@mail.gmail.com>
Subject: Re: [PATCH net-next v2 01/11] net: stmmac: Make stmmac_pltfr_remove() return void
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Vladimir Zapolskiy <vz@mleia.com>, Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Vinod Koul <vkoul@kernel.org>, Emil Renner Berthing <kernel@esmil.dk>, Samin Guo <samin.guo@starfivetech.com>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Matthias Brugger <matthias.bgg@gmail.com>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Jerome Brunet <jbrunet@baylibre.com>, Bhupesh Sharma <bhupesh.sharma@linaro.org>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-amlogic@lists.infradead.org, linux-oxnas@groups.io, linux-sunxi@lists.linux.dev, linux-mediatek@lists.infradead.org, Simon Horman <simon.horman@corigine.com>
List-ID: <linux-oxnas@groups.io>

On Mon, May 8, 2023 at 4:27=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> The function returns zero unconditionally. Change it to return void inste=
ad
> which simplifies some callers as error handing becomes unnecessary.
>
> The function is also used for some drivers as remove callback. Switch the=
se
> to the .remove_new() callback. For some others no error can happen in the
> remove callback now, convert them to .remove_new(), too.
>
> Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c     | 2 +-
>  drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c     | 2 +-
>  drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c         | 2 +-
>  drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c     | 2 +-
>  drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c  | 9 +++------
>  drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c     | 2 +-
>  drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c     | 2 +-
>  drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c    | 9 +++------
>  drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c       | 2 +-
>  drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c     | 2 +-
For these two Amlogic Meson drivers:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
