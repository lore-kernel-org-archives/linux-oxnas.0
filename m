Received: from NAM11-DM6-obe.outbound.protection.outlook.com (NAM11-DM6-obe.outbound.protection.outlook.com [40.107.223.127])
 by mx.groups.io with SMTP id smtpd.web10.74975.1680537332127688679
 for <linux-oxnas@groups.io>;
 Mon, 03 Apr 2023 08:55:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+YVYTGo2pr2JuszrU+NBVUV4x9UUygJDzD3MpMj8JE=;
 b=a8cKyMUJ+EzSt5q+3TrMVeTfcX5c8xmvpB4tpM4Bn02lqaRvqx51lk6FDuYvqL9xQ9UHV7mAZKr61H51Wt3pYnuPpPlYS70u+JQTy2a9GoPGc+Xs27cIAxGYg8VKPMuJHc2pB174e+1Qo4XbdZQO5BQ116loQRdjQ9p6xQ5m/ig=
Date: Mon, 3 Apr 2023 17:55:20 +0200
From: Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH net-next 01/11] net: stmmac: Make stmmac_pltfr_remove() return void
Message-ID: <ZCr26P9DGZFZy3Vq@corigine.com>
References: <20230402143025.2524443-1-u.kleine-koenig@pengutronix.de>
 <20230402143025.2524443-2-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230402143025.2524443-2-u.kleine-koenig@pengutronix.de>
Return-Path: simon.horman@corigine.com
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Vladimir Zapolskiy <vz@mleia.com>, Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Matthias Brugger <matthias.bgg@gmail.com>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Jerome Brunet <jbrunet@baylibre.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Bhupesh Sharma <bhupesh.sharma@linaro.org>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-amlogic@lists.infradead.org, linux-oxnas@groups.io, linux-sunxi@lists.linux.dev, linux-mediatek@lists.infradead.org
List-ID: <linux-oxnas@groups.io>

On Sun, Apr 02, 2023 at 04:30:15PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> The function returns zero unconditionally. Change it to return void inste=
ad
> which simplifies some callers as error handing becomes unnecessary.
>=20
> The function is also used for some drivers as remove callback. Switch the=
se
> to the .remove_new() callback. For some others no error can happen in the
> remove callback now, convert them to .remove_new(), too.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

