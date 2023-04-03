Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
 by mx.groups.io with SMTP id smtpd.web11.79895.1680547005269089239
 for <linux-oxnas@groups.io>;
 Mon, 03 Apr 2023 11:36:45 -0700
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-17aeb49429eso31835838fac.6
        for <linux-oxnas@groups.io>; Mon, 03 Apr 2023 11:36:45 -0700 (PDT)
Return-Path: <robherring2@gmail.com>
Date: Mon, 3 Apr 2023 13:36:43 -0500
From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH RFC v2 0/4] ARM: oxnas support removal
Message-ID: <20230403183643.GA1335487-robh@kernel.org>
References: <20230331-topic-oxnas-upstream-remove-v2-0-e51078376f08@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20230331-topic-oxnas-upstream-remove-v2-0-e51078376f08@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, soc@kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-oxnas@groups.io, Linus Walleij <linus.walleij@linaro.org>, Daniel Golle <daniel@makrotopia.org>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
List-ID: <linux-oxnas@groups.io>

On Mon, Apr 03, 2023 at 09:42:17AM +0200, Neil Armstrong wrote:
> With [1] removing MPCore SMP support, this makes the OX820 barely usable,
> associated with a clear lack of maintainance, development and migration to
> dt-schema it's clear that Linux support for OX810 and OX820 should be removed.
> 
> In addition, the OX810 hasn't been booted for years and isn't even present
> in an ARM config file.
> 
> For the OX820, lack of USB and SATA support makes the platform not usable
> in the current Linux support and relies on off-tree drivers hacked from the
> vendor (defunct for years) sources.
> 
> The last users are in the OpenWRT distribution, and today's removal means
> support will still be in stable 6.1 LTS kernel until end of 2026.
> 
> If someone wants to take over the development even with lack of SMP, I'll
> be happy to hand off maintainance.
> 
> The plan is to apply the first 4 patches first, then the drivers
> followed by bindings. Finally the MAINTAINANCE entry can be removed.
> 
> I'm not sure about the process of bindings removal, but perhaps the bindings
> should be marked as deprecated first then removed later on ?

Nah, just remove them. Like the code, we can always bring them back if 
needed.

Rob
