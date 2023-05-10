Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mx.groups.io with SMTP id smtpd.web10.7885.1683687626417945301
 for <linux-oxnas@groups.io>;
 Tue, 09 May 2023 20:00:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683687624;
	bh=7LO/nm+SvO2zUJm9O7tKkRrwmKO+jJgciV/tuTaQgEI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RTOVU+VB5lVL3KuGZFTpoKDpYjJRZaFEG2sQHTVRB003U8JjjD5mssizr5+LQvmxS
	 FiRe09LS1LVd1YWnDEJh5qAL8JXede7MYdp/xXZvK/GdzrksCN2HWYx2Yl6T6VU0FJ
	 9JyyJlSaOGUYos/Lyy9six7qob5Gkj21W/akStnMjymLUTb5PyAM8M1Wbf3N951mzV
	 Eg6NfnYrqIYGWQtpMzg4W3Sk8GzvYYx+hlaSlCIHcLFyllWUB3ydom5VLPkfJdMfc6
	 YNs6Y4Xid5qDf/PpW1q5ZniGiemNLv2Btm+78JH6TJxiVI7ORNqyekAAsAcCAtY5+p
	 +unEdK3RS/REg==
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 00/11] net: stmmac: Convert to platform remove callback returning void
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168368762456.27124.17176817660933091864.git-patchwork-notify@kernel.org>
Date: Wed, 10 May 2023 03:00:24 +0000
References: <20230508142637.1449363-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230508142637.1449363-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=3Cu=2Ekleine-koenig=40pengutronix=2Ede=3E?=@ci.codeaurora.org
Cc: peppe.cavallaro@st.com, alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com, shawnguo@kernel.org, s.hauer@pengutronix.de, vz@mleia.com, neil.armstrong@linaro.org, khilman@baylibre.com, vkoul@kernel.org, kernel@esmil.dk, samin.guo@starfivetech.com, wens@csie.org, jernej.skrabec@gmail.com, samuel@sholland.org, nobuhiro1.iwamatsu@toshiba.co.jp, matthias.bgg@gmail.com, thierry.reding@gmail.com, jonathanh@nvidia.com, festevam@gmail.com, linux-imx@nxp.com, jbrunet@baylibre.com, martin.blumenstingl@googlemail.com, bhupesh.sharma@linaro.org, angelogioacchino.delregno@collabora.com, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-amlogic@lists.infradead.org, linux-oxnas@groups.io, linux-sunxi@lists.linux.dev, linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org
List-ID: <linux-oxnas@groups.io>

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  8 May 2023 16:26:26 +0200 you wrote:
> Hello,
>=20
> (implicit) v1 of this series is available at
> https://lore.kernel.org/netdev/20230402143025.2524443-1-u.kleine-koenig@p=
engutronix.de
> .
>=20
> Changes since then:
>=20
> [...]

Here is the summary with links:
  - [net-next,v2,01/11] net: stmmac: Make stmmac_pltfr_remove() return void
    https://git.kernel.org/netdev/net-next/c/3246627f11c5
  - [net-next,v2,02/11] net: stmmac: dwmac-visconti: Make visconti_eth_cloc=
k_remove() return void
    https://git.kernel.org/netdev/net-next/c/b9bc44fe068d
  - [net-next,v2,03/11] net: stmmac: dwmac-qcom-ethqos: Drop an if with an =
always false condition
    https://git.kernel.org/netdev/net-next/c/c5f3ffe35cc9
  - [net-next,v2,04/11] net: stmmac: dwmac-visconti: Convert to platform re=
move callback returning void
    https://git.kernel.org/netdev/net-next/c/f4d05c419761
  - [net-next,v2,05/11] net: stmmac: dwmac-dwc-qos-eth: Convert to platform=
 remove callback returning void
    https://git.kernel.org/netdev/net-next/c/360cd89064b6
  - [net-next,v2,06/11] net: stmmac: dwmac-qcom-ethqos: Convert to platform=
 remove callback returning void
    https://git.kernel.org/netdev/net-next/c/5580b559a80a
  - [net-next,v2,07/11] net: stmmac: dwmac-rk: Convert to platform remove c=
allback returning void
    https://git.kernel.org/netdev/net-next/c/903cc461c901
  - [net-next,v2,08/11] net: stmmac: dwmac-sti: Convert to platform remove =
callback returning void
    https://git.kernel.org/netdev/net-next/c/b394982a10d9
  - [net-next,v2,09/11] net: stmmac: dwmac-stm32: Convert to platform remov=
e callback returning void
    https://git.kernel.org/netdev/net-next/c/fec3f552140e
  - [net-next,v2,10/11] net: stmmac: dwmac-sun8i: Convert to platform remov=
e callback returning void
    https://git.kernel.org/netdev/net-next/c/cc708d4ed7b3
  - [net-next,v2,11/11] net: stmmac: dwmac-tegra: Convert to platform remov=
e callback returning void
    https://git.kernel.org/netdev/net-next/c/a86f8601c8f0

You are awesome, thank you!
--=20
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


