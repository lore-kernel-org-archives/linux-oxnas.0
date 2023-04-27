Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
 by mx.groups.io with SMTP id smtpd.web10.15010.1682581617984518127
 for <linux-oxnas@groups.io>;
 Thu, 27 Apr 2023 00:46:58 -0700
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-54f6f0dae19so63611307b3.0
        for <linux-oxnas@groups.io>; Thu, 27 Apr 2023 00:46:57 -0700 (PDT)
Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id h206-20020a816cd7000000b00545a0818479sm4629013ywc.9.2023.04.27.00.46.56
        for <linux-oxnas@groups.io>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 00:46:56 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-54fb9b1a421so63640657b3.1
        for <linux-oxnas@groups.io>; Thu, 27 Apr 2023 00:46:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220328000915.15041-1-ansuelsmth@gmail.com> <85eb14ec-f465-7447-ad77-a3dabc666f47@kernel.org>
 <YkKRYnN84D9VZhGj@Ansuel-xps.localdomain> <CAL_Jsq+RQQ-ADMxLPUFwk6S6kGmb6oNDy4k52fnU0EtbUvqmSA@mail.gmail.com>
 <CAMuHMdWNTE48MFy6fqxAsfMWz9b6E7dVNXtXtESP95sxk2PGwA@mail.gmail.com>
 <CAL_JsqJthKTm8bhRF2B=ae1tvtPeYYXx_Tm76qQtSwLtH5C6VA@mail.gmail.com> <1cfc224b-f8b0-3143-42d2-188b56368c61@gmail.com>
In-Reply-To: <1cfc224b-f8b0-3143-42d2-188b56368c61@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 27 Apr 2023 09:46:40 +0200
Message-ID: <CAMuHMdU91NtZeFKe6mB3B48TNb64wfPu77xRbOEVX4tV65e38w@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] Categorize ARM dts directory
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Ansuel Smith <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-omap@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com, linux-aspeed@lists.ozlabs.org, linux-rpi-kernel@lists.infradead.org, chrome-platform@lists.linux.dev, linux-renesas-soc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, kernel@dh-electronics.com, linux-mediatek@lists.infradead.org, openbmc@lists.ozlabs.org, linux-tegra@vger.kernel.org, linux-oxnas@groups.io, linux-arm-msm@vger.kernel.org, linux-unisoc@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-realtek-soc@lists.infradead.org
List-ID: <linux-oxnas@groups.io>

On Thu, Apr 27, 2023 at 9:37=E2=80=AFAM Matthias Brugger <matthias.bgg@gmai=
l.com> wrote:
> On 25/04/2023 17:57, Rob Herring wrote:
> > On Tue, Apr 25, 2023 at 2:28=E2=80=AFAM Geert Uytterhoeven <geert@linux=
-m68k.org> wrote:
> >> On Tue, Apr 25, 2023 at 12:16=E2=80=AFAM Rob Herring <robh+dt@kernel.o=
rg> wrote:
> >>> I have a script[1] that does the conversion written the last time thi=
s
> >>> came up. Just have to agree on directory names. I think the easiest
> >>> would be for Arnd/Olof to run it at the end of a merge window before
> >>> rc1.
> >>
> >> "emev2" and "sh7" are missing for renesas.
> >
> > No doubt it's been bitrotting (or I may have missed some).
> >
> >> Does your script also cater for .dts files not matching any pattern,
> >> but including a .dtsi file that does match a pattern?
> >
> > I assume I built everything after moving, but maybe not...
> >
> > That's all just "details". First, we need agreement on a) moving
> > things to subdirs and b) doing it 1-by-1 or all at once. So far we've
> > been stuck on a) for being 'too much churn'.
> >
>
> I think it makes sense to move them and probably the best way to do so is=
, as
> you proposed: that Arnd or Olof run the script to move them just before -=
rc1

FTR, no objections from my side.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
