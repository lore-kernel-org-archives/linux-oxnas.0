Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mx.groups.io with SMTP id smtpd.web11.2919.1683054077427652681
 for <linux-oxnas@groups.io>;
 Tue, 02 May 2023 12:01:17 -0700
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 941FA6280E
	for <linux-oxnas@groups.io>; Tue,  2 May 2023 19:01:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0335CC4339E
	for <linux-oxnas@groups.io>; Tue,  2 May 2023 19:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683054076;
	bh=prkycoKFrtYOB9sqzJph1/Wh7+dUYl73V0ySsrK86tE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rf/Ymu/EiSQOPePfJMJv1847ZBWRjnjneowURtOqNMODuCRTfcl2GQ0h/jO2AdmCs
	 leEyX7R6GR2dka6/IsiyySID/QcvyxsSv7fNtmEEy0Cm9A6hC1sqxMJ+9jfUBya5xj
	 ODLup2MnZzYCOUMdIZzoCrk5OSl4AOnL/7/DJbtkd5lptoW7/0YbgOkcgOH14mk6Au
	 qACeCdnoaBW8B9rF8o7n7shq7gT7w0jQTaVjP3mXHg69IyA+TLldeHm4Y1C5mj86Z3
	 uRYRPp4016gJq/2Xf9LklNYOIaWs99spKYSrk9MtOv6rk+8yKfvzOFwqXzWomFJ/+X
	 cezzz3yUhjKtA==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-4f00d3f98deso30189730e87.0
        for <linux-oxnas@groups.io>; Tue, 02 May 2023 12:01:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220328000915.15041-1-ansuelsmth@gmail.com> <CAFr9PXkgrRe-=E=GhNnZ4w1x_FMb97-_RmX6ND1vEd74_TbZSw@mail.gmail.com>
 <4ff4f171-c5f8-87af-aad1-5e7686292288@microchip.com> <45bc13a8-1442-2dd3-b9ea-1ed2f5962bac@arm.com>
In-Reply-To: <45bc13a8-1442-2dd3-b9ea-1ed2f5962bac@arm.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 2 May 2023 14:01:01 -0500
Message-ID: <CAL_JsqL7t47x-5U6STynwW-+4wJUhs_R9wuaQ0YOgX59aJ=vew@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] Categorize ARM dts directory
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Robin Murphy <robin.murphy@arm.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Daniel Palmer <daniel@0x0f.com>, Ansuel Smith <ansuelsmth@gmail.com>, Claudiu Beznea <Claudiu.Beznea@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Santiago Esteban <Santiago.Esteban@microchip.com>, Cristian Birsan <Cristian.Birsan@microchip.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, DTML <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-actions@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-omap@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com, linux-aspeed@lists.ozlabs.org, linux-rpi-kernel@lists.infradead.org, chrome-platform@lists.linux.dev, linux-renesas-soc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, kernel@dh-electronics.com, linux-mediatek@lists.infradead.org, openbmc@lists.ozlabs.org, linux-tegra@vger.kernel.org, linux-oxnas@groups.io, linux-arm-msm@vger.kernel.org, linux-unisoc@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-realtek-soc@lists.infradead.org
List-ID: <linux-oxnas@groups.io>

On Tue, Apr 25, 2023 at 11:21=E2=80=AFAM Robin Murphy <robin.murphy@arm.com=
> wrote:
>
> On 29/03/2022 9:50 am, Nicolas Ferre wrote:
> > Ansuel, All,
> >
> > On 28/03/2022 at 10:55, Daniel Palmer wrote:
> >> Hi Ansuel
> >>
> >> On Mon, 28 Mar 2022 at 09:09, Ansuel Smith <ansuelsmth@gmail.com> wrot=
e:
> >>>
> >>> Hi,
> >>> as the title say, the intention of this ""series"" is to finally
> >>> categorize
> >>> the ARM dts directory in subdirectory for each oem.
> >>
> >> While I agree with this change and think it's for the good (browsing
> >> the ARM dts directory at the moment is frustrating..) I think
> >> buildroot and others need to be told about this as it'll potentially
> >> break their kernel build scripting for ARM and probably messes up the
> >> configs they have for existing boards.
> >
> > This aspect mustn't be underestimated and I anticipate lots of issues
> > during a long time on this particular topic of "build systems".
> >
> > Another aspect is CI and public or private testing farms we all have
> > running.
>
> Yet another is if this affects what `make dtbs_install` does (I don't
> know for sure, but I'd be inclined to suspect it might). Some distros
> use that to deliver the DTBs as part of their kernel package, so if
> paths suddenly change it could break end users' bootloader setups too.

Indeed, this came up last time. Turns out I had already implemented
support to maintain the flat install. I just re-wrote it since
Makefile.dtbinst changed completely since then.

Rob
