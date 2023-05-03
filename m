Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
 by mx.groups.io with SMTP id smtpd.web11.32895.1683146259899766040
 for <linux-oxnas@groups.io>;
 Wed, 03 May 2023 13:37:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1683146259; x=1683153459; bh=de
	sv6xluCw6O+vvGUBE1D2AER9o0GCpP/5poLPXyM/I=; b=dPT1qww92IzHVup5HD
	dBW4pJtCc3mO7+suvORGzU/mum6k7BRdyBFP9vj/V9pcUMTlLsRq9Dfyf0TxPKx5
	YGLrHzHgERFVrr/5nu2PocVjYM1XBfwv/aA56y5g4hroK4QZ3jk4TPPcP6mrUoEb
	JMYYqfpFBP/Rxd6Gt6rgRn2NW9becs5c7yab13WTXd5j/To6bkYC0EOiRxnie1Jx
	bC5Zt0xB4/42BHh+ZwrEeMB/vd+Qtr/ZcDv9W6thTdAfYf5ORSaL/sDo/ovkzvBM
	GLy4HMODldsz9Q4mT0NlweDGFgHqLam/KNavBuQzHtXODRk2aokvO9HUK4cbH3o3
	5Xrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1683146259; x=1683153459; bh=desv6xluCw6O+
	vvGUBE1D2AER9o0GCpP/5poLPXyM/I=; b=d48yA3SILCVW3LXBTHIbLeHd3/55J
	lqCOnfsbA/LldPyygh9jh5J28/dsd8VUhXAFP/EkNp/lobLda1F5PT14Ev6GN+ew
	G6LOsplfleF40FEUspzQcMJugBF8TRJqAJ8qI9YYSeRqysA8B112xhztSrLb8Elq
	vr9P1xezH88OAe5nH5P6aD1C7C630mNeOvhLxIqL4Rd6LysBSZPPQuneer/bRja0
	vJqvuj0S+ddloNWFG95dqwNyXOUnF550OTdcmkQjKkD80XI9dKNFUou/FnylDupT
	7QT1q75XDl9Tkw/5rEEeDO+E2qgfKGHNkZcBi4wrIPv1kHUXuwfyNqmZA==
Mime-Version: 1.0
Message-Id: <4d9b4159-88b2-48cf-84d9-34169928c8e4@app.fastmail.com>
In-Reply-To: 
 <CAL_JsqJEdZBS231TvkmmipaXEqzvDjz+A32V6uJ4zfSMAJHn2w@mail.gmail.com>
References: <20220328000915.15041-1-ansuelsmth@gmail.com>
 <85eb14ec-f465-7447-ad77-a3dabc666f47@kernel.org>
 <YkKRYnN84D9VZhGj@Ansuel-xps.localdomain>
 <CAL_Jsq+RQQ-ADMxLPUFwk6S6kGmb6oNDy4k52fnU0EtbUvqmSA@mail.gmail.com>
 <CAMuHMdWNTE48MFy6fqxAsfMWz9b6E7dVNXtXtESP95sxk2PGwA@mail.gmail.com>
 <CAL_JsqJthKTm8bhRF2B=ae1tvtPeYYXx_Tm76qQtSwLtH5C6VA@mail.gmail.com>
 <720a2829-b6b5-411c-ac69-9a53e881f48d@app.fastmail.com>
 <CAL_JsqKCtmkwzKa01gyG65fH8ye6R3KhR41PJbJhOJ4X9j=znA@mail.gmail.com>
 <bce93654-fc36-3d12-282d-76fafb8f51ce@linaro.org>
 <CAL_JsqJXd_EpOQwwNEAn25mzFfkhEvqzur6ui5Ca+dbt2kA8-Q@mail.gmail.com>
 <5e318b02-8f33-4e2d-a956-5660e1c60619@app.fastmail.com>
 <CAA8EJpq8x5wQa3fMebaSP3hCdMiCsZRaF+B4Y3N3royW_CeXCA@mail.gmail.com>
 <4e1e70a9-9b28-410b-bd29-fb5f5805798f@app.fastmail.com>
 <CAL_JsqJEdZBS231TvkmmipaXEqzvDjz+A32V6uJ4zfSMAJHn2w@mail.gmail.com>
Date: Wed, 03 May 2023 22:37:17 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [RFC PATCH 0/1] Categorize ARM dts directory
Content-Type: text/plain
To: Rob Herring <robh+dt@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Olof Johansson <olof@lixom.net>, Christian Marangi <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org, linux-sunxi@lists.linux.dev, Linux-OMAP <linux-omap@vger.kernel.org>, linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com, linux-aspeed@lists.ozlabs.org, linux-rpi-kernel@lists.infradead.org, chrome-platform@lists.linux.dev, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, linux-samsung-soc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, kernel@dh-electronics.com, linux-mediatek@lists.infradead.org, openbmc@lists.ozlabs.org, linux-tegra@vger.kernel.org, "linux-oxnas@groups.io" <linux-oxnas@groups.io>, linux-arm-msm@vger.kernel.org, linux-unisoc@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-realtek-soc@lists.infradead.org
List-ID: <linux-oxnas@groups.io>

On Wed, May 3, 2023, at 15:16, Rob Herring wrote:

> We could do a second level of directories here:

Works for me, but at that point, I'd really also want to do it
for nxp with its five or more product lines (mxs, imx, lpc,
s32, layerscape, vybrid)

> intel/pxa/
> intel/ixp/
> intel/socfpga/

and intel/axxia I guess.

     Arnd
