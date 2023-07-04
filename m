Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web10.57770.1688475025045415097
 for <linux-oxnas@groups.io>;
 Tue, 04 Jul 2023 05:50:25 -0700
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3142970df44so3908243f8f.3
        for <linux-oxnas@groups.io>; Tue, 04 Jul 2023 05:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688475023; x=1691067023;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=khN7qL20jiNV+2YUoL2VVrDQ7HuxSVd+7myuCssgPgE=;
        b=lhpZ5J9XdadmPSr1QR/AG8UcCx6nsBh7S96ptZWO01NVbdAD32ga6ND/rHGK/0nLeG
         OcILfAAZH2QGjuXC0E1sxnz8ySI0riahZV4a/8Vh0qOFuPLDeYuLhNivNpQ42YBQZpR1
         n52OFNS0gHnHJ4ORnADm7dkH4XGhkKGL6bdV3HcGb/JLkgwlITETOv6im3jy+/aeghKo
         SoRqplSJRCRJRm91vnJY56FDVLzwhoIazir8wpfpbMjF7lfBWguiZ9/WFTsJGIwwwgsO
         /SRYchDhQsYGOB5Pi+dm1/EQ35yHwT5u3gaFUFxuzSwiOobh/h9Vc1OIagL99AHBAmRV
         s8SA==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <12266deb-4602-c557-fd80-689765fbf302@linaro.org>
Date: Tue, 4 Jul 2023 14:50:20 +0200
MIME-Version: 1.0
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 06/15] dt-bindings: mtd: oxnas-nand: remove obsolete bindings
References: <20230630-topic-oxnas-upstream-remove-v2-0-fb6ab3dea87c@linaro.org>
 <20230630-topic-oxnas-upstream-remove-v2-6-fb6ab3dea87c@linaro.org>
 <20230704103026.6db56915@xps-13>
In-Reply-To: <20230704103026.6db56915@xps-13>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>, Sebastian Reichel <sre@kernel.org>, Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-mtd@lists.infradead.org, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-oxnas@groups.io, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Daniel Golle <daniel@makrotopia.org>
List-ID: <linux-oxnas@groups.io>

Hi Miquel,

On 04/07/2023 10:30, Miquel Raynal wrote:
> Hi Neil,
> 
> neil.armstrong@linaro.org wrote on Fri, 30 Jun 2023 18:58:31 +0200:
> 
>> Due to lack of maintenance and stall of development for a few years now,
>> and since no new features will ever be added upstream, remove the
>> for OX810 and OX820 nand bindings.
>>
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>> Acked-by: Daniel Golle <daniel@makrotopia.org>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> 
> Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
> 
> I assume these two mtd related patches will be picked-up through the
> soc tree as well, if that's not the case just ping me and I'll take
> them.

As of today, there's no strong plan, so maintainers can pick their patches
and I'll probably funnel the remaining ones via a final SoC PR.

Thanks,
Neil

> 
> Thanks,
> Miquèl

