Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 9B2D021841
	for <linux-oxnas@groups.io>; Wed, 22 May 2019 13:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558533365;
	bh=CpWRPFDFDeEz2FasTJpU7xC9m9MJZ5sBPRt83HEYgfo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=duF47EnJ1olpUVNwqtjHV8UOkB/JftPjhDIWWr5H4ZMBt7IDtYQ1C/3BKouXzaL0v
	 f3jygMikKv5/BWPNiA3P92IWbjeorOYEupad+Hlhua/d6y7btM+ZP6HzFBgM/1PR/F
	 gF+k03o4CdD3kYEN6+YfFHKpbwJPIm2lkyOB1Qxs=
Received: by mail-qk1-f171.google.com with SMTP id f126so1495394qkc.9
        for <linux-oxnas@groups.io>; Wed, 22 May 2019 06:56:05 -0700 (PDT)
MIME-Version: 1.0
References: <1558466890-45471-1-git-send-email-kdasu.kdev@gmail.com> <CAL_JsqKd53W1E33YdtJwagi4=7DrVQ5+N3rSY=Rxo5J0RiW46g@mail.gmail.com>
In-Reply-To: <CAL_JsqKd53W1E33YdtJwagi4=7DrVQ5+N3rSY=Rxo5J0RiW46g@mail.gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 22 May 2019 08:55:53 -0500
Message-ID: <CAL_JsqJ+zNQ3CeBh8K=oBiZZsiBQ8w1w=6vs8zOQeqUf_qhqcg@mail.gmail.com>
Subject: Re: [PATCH] dt: bindings: mtd: replace references to nand.txt with nand-controller.yaml
Content-Type: text/plain; charset="UTF-8"
To: Kamal Dasu <kdasu.kdev@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: MTD Maling List <linux-mtd@lists.infradead.org>, "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" <bcm-kernel-feedback-list@broadcom.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Liang Yang <liang.yang@amlogic.com>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@baylibre.com>, Stefan Agner <stefan@agner.ch>, Lucas Stach <dev@lynxeye.de>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Neil Armstrong <narmstrong@baylibre.com>, Andy Gross <agross@kernel.org>, David Brown <david.brown@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Marc Gonzalez <marc.w.gonzalez@free.fr>, Mans Rullgard <mans@mansr.com>, devicetree@vger.kernel.org, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, linux-amlogic@lists.infradead.org, linux-tegra@vger.kernel.org, linux-oxnas@groups.io, linux-arm-msm <linux-arm-msm@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
List-ID: <linux-oxnas@groups.io>

On Wed, May 22, 2019 at 8:19 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Tue, May 21, 2019 at 2:28 PM Kamal Dasu <kdasu.kdev@gmail.com> wrote:
> >
> > nand-controller.yaml replaced nand.txt however the references to it were
> > not updated. This change updates these references wherever it appears in
> > bindings documentation.
> >
> > Fixes: 212e49693592 ("dt-bindings: mtd: Add YAML schemas for the generic NAND options")
> >
> > Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
>
> Mauro already sent a similar patch.

Actually, Mauro's patch missed a bunch of cases that aren't full
paths, so I'll take this one.

Rob
