Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 9B1A421473
	for <linux-oxnas@groups.io>; Wed, 22 May 2019 13:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558531162;
	bh=xZL000OlxXJ3Olb6ufE2AzjLi7N4hMQu+kQzQcbFNCE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=0mYeaIOisZLB0e2XA+n2+3BIXH94kWanrOCk0grtqaLO+lZvxY3UI7XggEwxwuQqh
	 vq/62sb27M9TkomToLDrAOJEMM7ci1rjoij0f3S6+ILn1ARCEMG0aZLvAXz4U57nd3
	 Bsy2TjvX8AeZkQy1Oa+uXn9+h2LRBrcSTjcCeEdI=
Received: by mail-qt1-f181.google.com with SMTP id z19so2205185qtz.13
        for <linux-oxnas@groups.io>; Wed, 22 May 2019 06:19:22 -0700 (PDT)
MIME-Version: 1.0
References: <1558466890-45471-1-git-send-email-kdasu.kdev@gmail.com>
In-Reply-To: <1558466890-45471-1-git-send-email-kdasu.kdev@gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 22 May 2019 08:19:09 -0500
Message-ID: <CAL_JsqKd53W1E33YdtJwagi4=7DrVQ5+N3rSY=Rxo5J0RiW46g@mail.gmail.com>
Subject: Re: [PATCH] dt: bindings: mtd: replace references to nand.txt with nand-controller.yaml
Content-Type: text/plain; charset="UTF-8"
To: Kamal Dasu <kdasu.kdev@gmail.com>
Cc: MTD Maling List <linux-mtd@lists.infradead.org>, "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" <bcm-kernel-feedback-list@broadcom.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Liang Yang <liang.yang@amlogic.com>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@baylibre.com>, Stefan Agner <stefan@agner.ch>, Lucas Stach <dev@lynxeye.de>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Neil Armstrong <narmstrong@baylibre.com>, Andy Gross <agross@kernel.org>, David Brown <david.brown@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Marc Gonzalez <marc.w.gonzalez@free.fr>, Mans Rullgard <mans@mansr.com>, devicetree@vger.kernel.org, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, linux-amlogic@lists.infradead.org, linux-tegra@vger.kernel.org, linux-oxnas@groups.io, linux-arm-msm <linux-arm-msm@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
List-ID: <linux-oxnas@groups.io>

On Tue, May 21, 2019 at 2:28 PM Kamal Dasu <kdasu.kdev@gmail.com> wrote:
>
> nand-controller.yaml replaced nand.txt however the references to it were
> not updated. This change updates these references wherever it appears in
> bindings documentation.
>
> Fixes: 212e49693592 ("dt-bindings: mtd: Add YAML schemas for the generic NAND options")
>
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>

Mauro already sent a similar patch.

Rob
