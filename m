Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
 by mx.groups.io with SMTP id smtpd.web11.103506.1680619090885788043
 for <linux-oxnas@groups.io>;
 Tue, 04 Apr 2023 07:38:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1680619090; x=1680705490; bh=uc
	91/CUruYStRNWVXvGcBM2haHyPK49E7hmhbx44+wQ=; b=cr0ak/ax73X0U2TZ/N
	9Ci5ykJxDy0hlOzJtXExxSCWO3PuxVfKOKGuLKslCwfwlQE7o6vaxxGI35y7vnKk
	0HmoutwA2iPF/yO0dxZY3CtVvVsIy0nOKlx7UlfM0hffCG0gtsfAC9QXfh6mqu0o
	7YDlxxT2sWQYJuOeWHuD/SVp9QjOIyS51TmvsSfE1Jzc7kHN/ScfUrEiwZOovasf
	2oh/SbrtPy9L7YKSQl73shqwI/F+TchUx1IBcm1MrgIqGpvgBLkYo6fIHUJ20xU1
	TU72CLnBo8hu+AJgxlmkSKBIe40myzVvTKSDTFUf5LbeOak05alma1QYO1gv8V/3
	R7jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1680619090; x=1680705490; bh=uc91/CUruYStR
	NWVXvGcBM2haHyPK49E7hmhbx44+wQ=; b=nK2a2FeGhuOK4K6LGxGOQdxc4kSkY
	lTOTdIJ2iIL6CFwURxfqYxflM3xnv8BCXbRytBxjWb7Pp1O8W1PqGzo7/GGLptbG
	TtexyI4qf6D2miSvYcsEn5rmnP+tl8bAG5cGNE6mDiNqOIgLQOVutoXpPejYaYHl
	4kApjuilw6zYHJQNhlfF/UfZ64JPeFfHG2DN2uXSFd98nPb+ILoE8eiskeN6AnX8
	Rti0VBgdthoB1B35T36suxClYvM6evdCgsgTSuflMvcmrAjWlVcovNg70EI9Abvh
	5+ADlMerGqSEi8g92Ew31UyLfRm/BOTY1u0AhApKN0/nXy0aKX2cyvsTQ==
Mime-Version: 1.0
Message-Id: <86d63038-e3f5-4c03-b904-a26761b0578d@app.fastmail.com>
In-Reply-To: 
 <20230331-topic-oxnas-upstream-remove-v2-0-e51078376f08@linaro.org>
References: 
 <20230331-topic-oxnas-upstream-remove-v2-0-e51078376f08@linaro.org>
Date: Tue, 04 Apr 2023 16:37:39 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH RFC v2 0/4] ARM: oxnas support removal
Content-Type: text/plain
To: Neil Armstrong <neil.armstrong@linaro.org>, Olof Johansson <olof@lixom.net>, soc@kernel.org, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, "linux-oxnas@groups.io" <linux-oxnas@groups.io>, Linus Walleij <linus.walleij@linaro.org>, Daniel Golle <daniel@makrotopia.org>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
List-ID: <linux-oxnas@groups.io>

On Mon, Apr 3, 2023, at 09:42, Neil Armstrong wrote:
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

I merged all four into the soc tree now, thanks!

     Arnd
