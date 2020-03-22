Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
 by mx.groups.io with SMTP id smtpd.web10.28465.1584882327037236101
 for <linux-oxnas@groups.io>;
 Sun, 22 Mar 2020 06:05:27 -0700
Received: by mail-wm1-f68.google.com with SMTP id 26so6837320wmk.1
        for <linux-oxnas@groups.io>; Sun, 22 Mar 2020 06:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=y0obWhE6JeJc849b3MeKOon4JLevkMsZjwtU+Vr0Uc0=;
        b=ycH96OQAdISI3933+ye9qCoVatB4K42NRNk7emUGZaYrEic3edhPWkkbA8puFRRMUF
         A5k/ss5R9qp4pKEvBJiWhGgJ2JsvB7q+vEJye2y0j//K4imY1rdSOuaoN9DrK38LVivH
         FPS34GSzHRmbBsqxF1gnsKc9Fdgdy338Uw4vbUjTdz7QLl4vR9rj7C00RmO/Yspx9sls
         hOHQm9KOkPES7HF7Q5YXbRwP0Ap93CbjRjCYfz0oMty3pqcH2COYikxRcbEG6KOA15oD
         TTGgN1bNA2gxA30Gn5SteaFWOTdyTgVB4TDhSa4nkTGrumgB/0WIVcP/UwHb1wXeziAm
         Eovg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] ARM: dts: oxnas: Fix clear-mask property
References: <20200321143653.2412823-1-mans0n@gorani.run>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <ca1a1cdc-6c20-bd2c-d1ea-edd6610f68a4@baylibre.com>
Date: Sun, 22 Mar 2020 14:05:22 +0100
MIME-Version: 1.0
In-Reply-To: <20200321143653.2412823-1-mans0n@gorani.run>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Sungbo Eo <mans0n@gorani.run>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-oxnas@groups.io>

Hi,

Le 21/03/2020 =E0 15:36, Sungbo Eo a =E9crit :
> Disable all rps-irq interrupts during driver initialization to prevent
> an accidental interrupt on GIC.
>=20
> Fixes: 84316f4ef141 ("ARM: boot: dts: Add Oxford Semiconductor OX810SE dt=
si")
> Fixes: 38d4a53733f5 ("ARM: dts: Add support for OX820 and Pogoplug V3")
> Signed-off-by: Sungbo Eo <mans0n@gorani.run>
> ---
>  arch/arm/boot/dts/ox810se.dtsi | 4 ++--
>  arch/arm/boot/dts/ox820.dtsi   | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/ox810se.dtsi b/arch/arm/boot/dts/ox810se.d=
tsi
> index 9f6c2b660ed3..0755e5864c4a 100644
> --- a/arch/arm/boot/dts/ox810se.dtsi
> +++ b/arch/arm/boot/dts/ox810se.dtsi
> @@ -323,8 +323,8 @@ intc: interrupt-controller@0 {
>  					interrupt-controller;
>  					reg =3D <0 0x200>;
>  					#interrupt-cells =3D <1>;
> -					valid-mask =3D <0xFFFFFFFF>;
> -					clear-mask =3D <0>;
> +					valid-mask =3D <0xffffffff>;
> +					clear-mask =3D <0xffffffff>;
>  				};
> =20
>  				timer0: timer@200 {
> diff --git a/arch/arm/boot/dts/ox820.dtsi b/arch/arm/boot/dts/ox820.dtsi
> index c9b327732063..90846a7655b4 100644
> --- a/arch/arm/boot/dts/ox820.dtsi
> +++ b/arch/arm/boot/dts/ox820.dtsi
> @@ -240,8 +240,8 @@ intc: interrupt-controller@0 {
>  					reg =3D <0 0x200>;
>  					interrupts =3D <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
>  					#interrupt-cells =3D <1>;
> -					valid-mask =3D <0xFFFFFFFF>;
> -					clear-mask =3D <0>;
> +					valid-mask =3D <0xffffffff>;
> +					clear-mask =3D <0xffffffff>;
>  				};
> =20
>  				timer0: timer@200 {
>=20

Thanks a lot for the patch,
Acked-by: Neil Armstrong <narmstrong@baylibre.com>

I'll apply it asap and push it to arm-soc fixes.

Neil
