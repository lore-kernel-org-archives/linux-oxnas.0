Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
 by mx.groups.io with SMTP id smtpd.web11.83670.1680554356108147118
 for <linux-oxnas@groups.io>;
 Mon, 03 Apr 2023 13:39:16 -0700
Received: by mail-ed1-f43.google.com with SMTP id y4so122390876edo.2
        for <linux-oxnas@groups.io>; Mon, 03 Apr 2023 13:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1680554354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANuyucjG7+IOsm6+PTXTUkVZpuE117uxor/udrQsrHI=;
        b=QBtct7OF544g4KW8FmyicOGj93ZjWlg8zuQv1bJbp8jcg7kZlaoTEPE+ZjM8qK1FvF
         ySiNTF5dDqmcX7CK3V3nXjfCtZyZUPhXWS0tiyg1h2mmI68eIuECf75r+pVgglVEKCkU
         kHoMUTP0p53HT7ROKBpLFzTXIvLXbS7upHKKFV+6T4zuNMqbtyJ5qYvrMPN/aHFSnads
         mcQglHoBkCSFBXGMXHZCZrQSWHcr75YnbjUa66Tunz0FV33dyy00oLs71tZiNRBidtW4
         jtGUBV/KHY62/FaxcVx0/bdUCldUHFYapDx3Da/E+rJH3/2oHbH6x+g4Go250AzETWuH
         eyhQ==
MIME-Version: 1.0
References: <20230402143025.2524443-1-u.kleine-koenig@pengutronix.de> <20230402143025.2524443-2-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230402143025.2524443-2-u.kleine-koenig@pengutronix.de>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Mon, 3 Apr 2023 22:39:03 +0200
Message-ID: <CAFBinCBX8dQo9898KkXaMaanQ9-LcFA7HHFf+XBM2-f+g8WY7Q@mail.gmail.com>
Subject: Re: [PATCH net-next 01/11] net: stmmac: Make stmmac_pltfr_remove() return void
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Vladimir Zapolskiy <vz@mleia.com>, Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Matthias Brugger <matthias.bgg@gmail.com>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Jerome Brunet <jbrunet@baylibre.com>, Bhupesh Sharma <bhupesh.sharma@linaro.org>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-amlogic@lists.infradead.org, linux-oxnas@groups.io, linux-sunxi@lists.linux.dev, linux-mediatek@lists.infradead.org
List-ID: <linux-oxnas@groups.io>

On Sun, Apr 2, 2023 at 4:31=E2=80=AFPM Uwe Kleine-K=C3=B6nig
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
for dwmac-meson and dwmac-meson8b:
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
