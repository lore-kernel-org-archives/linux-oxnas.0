Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by mx.groups.io with SMTP id smtpd.web10.1190.1683577831527277198
 for <linux-oxnas@groups.io>;
 Mon, 08 May 2023 13:30:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683577831; x=1715113831;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=YOZ5LYTgLg60jaWbABGzS8hnGyvhDqhb6myZIWYRa80=;
  b=hIwicRQVy6YyDOf9MJVnZDN98zBd+b+L9O1nRlDJokdw75/Jme2FnLKx
   4Qk2C8h51oJlUyMtFyflyTI5AQiu8FrlLnvr2+8Xb9RJN8HyIvOdUrr2/
   YFGSWWd2WNPU/XDi0LkrY6z/xLIHGWtpK49bNdTvwoPwFKSiyROE/JlnB
   avovuCTVvOoKwaSf/H3hyijH2M43m71/HYzmmOOeGldajNSsJI4mXHbx6
   7XP/JglJ6ca3kkOtUP7hxVqjiEAaK+UQeBCfzqfrErSE+F4a5gIZrwiv7
   7GauI57nnmemQ05dkjdYhOD4lm27WUm1eYatm0FC/JpjCla2XmRmiFSwt
   A==;
Date: Mon, 8 May 2023 22:30:12 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
Subject: Re: [PATCH net-next v2 00/11] net: stmmac: Convert to platform remove callback returning void
Message-ID: <ZFlb1PtnmvAEfwc5@localhost.localdomain>
References: <20230508142637.1449363-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230508142637.1449363-1-u.kleine-koenig@pengutronix.de>
Return-Path: michal.kubiak@intel.com
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "David S. Miller  <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,  Jakub Kicinski  <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin" <mcoquelin.stm32@gmail.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Vladimir Zapolskiy <vz@mleia.com>, Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Vinod Koul <vkoul@kernel.org>, Emil Renner Berthing <kernel@esmil.dk>, Samin Guo <samin.guo@starfivetech.com>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, "Nobuhiro Iwamatsu  <nobuhiro1.iwamatsu@toshiba.co.jp>, Matthias Brugger" <matthias.bgg@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Jerome Brunet <jbrunet@baylibre.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Bhupesh Sharma <bhupesh.sharma@linaro.org>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-amlogic@lists.infradead.org, linux-oxnas@groups.io, linux-sunxi@lists.linux.dev, linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org
List-ID: <linux-oxnas@groups.io>

On Mon, May 08, 2023 at 04:26:26PM +0200, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> (implicit) v1 of this series is available at
> https://lore.kernel.org/netdev/20230402143025.2524443-1-u.kleine-koenig@p=
engutronix.de
> .
>=20
> Changes since then:
>=20
>  - Added various Reviewed-by: and Acked-by: tags received for v1
>  - Removed a variable in an earlier patch to make all intermediate steps
>    compilable, spotted by Simon Horman
>  - Rebased to v6.4-rc1 (which needed a slight adaption to cope for
>    4bd3bb7b4526 ("net: stmmac: Add glue layer for StarFive JH7110 SoC"))
>=20
> Best regards
> Uwe
>=20

For the series:
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>

(Just a very minor nitpick in the commit message of patch 3).

> --=20
> 2.39.2
>=20
>=20
