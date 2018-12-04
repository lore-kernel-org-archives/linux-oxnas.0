Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 6950020879
	for <linux-oxnas@groups.io>; Tue,  4 Dec 2018 14:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1543932306;
	bh=yTr+UbBFW+eS6HM3fzcLbxczAbrxW4SyfnuUXDeA/9o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GV0vsPguRlbVwUdqPqdotp9D2RX4uJcvLoeZB4aoigLRi8c7ofsrLfJ3hTvEy12nT
	 3oDb2slvH5a27cyVmVC2m6BQspIoq8Cfy2ZmpH2LSslhjD9ORiJJdd8STMH9ZsBG+O
	 U9Uh+jBysPhtu0bVYSATY+Qpb2tiZwvhrxeihfeg=
Received: by mail-qt1-f181.google.com with SMTP id z16so18104777qtq.4
        for <linux-oxnas@groups.io>; Tue, 04 Dec 2018 06:05:06 -0800 (PST)
MIME-Version: 1.0
References: <20181203213223.16986-1-robh@kernel.org> <20181203213223.16986-22-robh@kernel.org>
 <be37bd18-a573-307e-3a9e-e879010cfc89@baylibre.com>
In-Reply-To: <be37bd18-a573-307e-3a9e-e879010cfc89@baylibre.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 4 Dec 2018 08:04:54 -0600
Message-ID: <CAL_JsqJ3oL4FWSQKVLRtmg5Bma5q6-QgicfATcOEo3nQY-TdPw@mail.gmail.com>
Subject: Re: [PATCH v2 21/34] dt-bindings: arm: Convert Oxford Semi board/soc bindings to json-schema
Content-Type: text/plain; charset="UTF-8"
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sean Hudson <darknighte@darknighte.com>, Frank Rowand <frowand.list@gmail.com>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Grant Likely <grant.likely@arm.com>, Kumar Gala <kumar.gala@linaro.org>, ARM-SoC Maintainers <arm@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-oxnas@groups.io
List-ID: <linux-oxnas@groups.io>

On Tue, Dec 4, 2018 at 2:43 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On 03/12/2018 22:32, Rob Herring wrote:
> > Convert Oxford Semi SoC bindings to DT schema format using json-schema.
> >
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Neil Armstrong <narmstrong@baylibre.com>
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-oxnas@groups.io
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../devicetree/bindings/arm/oxnas.txt         | 14 -----------
> >  .../devicetree/bindings/arm/oxnas.yaml        | 25 +++++++++++++++++++
> >  2 files changed, 25 insertions(+), 14 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/arm/oxnas.txt
> >  create mode 100644 Documentation/devicetree/bindings/arm/oxnas.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/arm/oxnas.txt b/Documentation/devicetree/bindings/arm/oxnas.txt
> > deleted file mode 100644
> > index ac64e60f99f1..000000000000
> > --- a/Documentation/devicetree/bindings/arm/oxnas.txt
> > +++ /dev/null
> > @@ -1,14 +0,0 @@
> > -Oxford Semiconductor OXNAS SoCs Family device tree bindings
> > --------------------------------------------
> > -
> > -Boards with the OX810SE SoC shall have the following properties:
> > -  Required root node property:
> > -    compatible: "oxsemi,ox810se"
> > -
> > -Boards with the OX820 SoC shall have the following properties:
> > -  Required root node property:
> > -    compatible: "oxsemi,ox820"
> > -
> > -Board compatible values:
> > -  - "wd,mbwe" (OX810SE)
> > -  - "cloudengines,pogoplugv3" (OX820)
> > diff --git a/Documentation/devicetree/bindings/arm/oxnas.yaml b/Documentation/devicetree/bindings/arm/oxnas.yaml
> > new file mode 100644
> > index 000000000000..6ae51ef513be
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/oxnas.yaml
> > @@ -0,0 +1,25 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/arm/oxnas.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Oxford Semiconductor OXNAS SoCs Family device tree bindings
> > +
> > +maintainers:
> > +  - Neil Armstrong <narmstrong@baylibre.com>
> > +
> > +properties:
> > +  $nodename:
> > +    const: '/'
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +        - enum:
> > +            - wd,mbwe
> > +        - const: oxsemi,ox810se
> > +
> > +      - items:
> > +        - enum:
> > +            - cloudengines,pogoplugv3
> > +        - const: oxsemi,ox820
> >
>
> We also loose all the "human friendly" description of board/SoC relationship here,
> and I think it's a shame.

You can have whatever comments or description properties you like, so
how would you like it to look?

Rob
