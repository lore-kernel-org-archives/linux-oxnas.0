Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web11.45974.1680446480037592213
 for <linux-oxnas@groups.io>;
 Sun, 02 Apr 2023 07:41:20 -0700
Received: by mail-wr1-f47.google.com with SMTP id j24so26874464wrd.0
        for <linux-oxnas@groups.io>; Sun, 02 Apr 2023 07:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680446478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZrZkQDilPn1vacJZvzA6Nj9qCFTdPg8cOLsQDyidsM=;
        b=AWiAEpgmtq1ABmkIlHJMb3ekqLp/o5PBApXYHaUJd6fMBgINSst8BmJ/pgShbKKOeS
         k8wBFhY8/TOYGeGJnneNHpDQP3X0kyBdLdEufd36IBRxu5BjW+r4ms5yZy3oQpbROla+
         HuK0LSYtls5NDlBQiaKRY6pjE12QvLR0gdxZvzJPCpW0i1hfsep+nLFMs1KEs4LJMcoz
         MsllhAHbGZPXJN1p8RKV2TlnjCVbftkHvtY88q6n5HKQ0gQVYOf2Bwz+KuEPeA/ZRo7n
         AEdvOz6fpYyC8XMB9IgZpTx0TkjyMuthpPmYX+kcLN7IfSIMZNA86JgEs0+mJQRN69Nx
         1AzQ==
Return-Path: <jernej.skrabec@gmail.com>
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
Subject: Re: [PATCH net-next 01/11] net: stmmac: Make stmmac_pltfr_remove() return void
Date: Sun, 02 Apr 2023 16:41:14 +0200
Message-ID: <2674462.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <20230402143025.2524443-2-u.kleine-koenig@pengutronix.de>
References: 
 <20230402143025.2524443-1-u.kleine-koenig@pengutronix.de>
 <20230402143025.2524443-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
To: Giuseppe Cavallaro <peppe.cavallaro@st.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Vladimir Zapolskiy <vz@mleia.com>, Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Matthias Brugger <matthias.bgg@gmail.com>, Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Jerome Brunet <jbrunet@baylibre.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Bhupesh Sharma <bhupesh.sharma@linaro.org>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-amlogic@lists.infradead.org, linux-oxnas@groups.io, linux-sunxi@lists.linux.dev, linux-mediatek@lists.infradead.org
List-ID: <linux-oxnas@groups.io>

Dne nedelja, 02. april 2023 ob 16:30:15 CEST je Uwe Kleine-K=F6nig napisal(=
a):
> The function returns zero unconditionally. Change it to return void inste=
ad
> which simplifies some callers as error handing becomes unnecessary.
>=20
> The function is also used for some drivers as remove callback. Switch the=
se
> to the .remove_new() callback. For some others no error can happen in the
> remove callback now, convert them to .remove_new(), too.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
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
>  drivers/net/ethernet/stmicro/stmmac/dwmac-oxnas.c       | 2 +-
>  drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 5 ++---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c     | 2 +-
>  drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c       | 2 +-

For sunxi:
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

>  drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c    | 4 +---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c   | 4 +---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h   | 2 +-
>  17 files changed, 22 insertions(+), 33 deletions(-)



