Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web10.103238.1692001035800555144
 for <linux-oxnas@groups.io>;
 Mon, 14 Aug 2023 01:17:16 -0700
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-318015ade49so3679065f8f.0
        for <linux-oxnas@groups.io>; Mon, 14 Aug 2023 01:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692001034; x=1692605834;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e3CFhGYYBnmc/7BGz71n+APKSrpv4uhL75vkasqQJ4o=;
        b=iQkwPbQN3DsEDOtJk3CJaT+avcrhQmZRMrmuydv4HhzxFDJqxw9vGX/2VyMkUMA1wL
         jk+ff37u88MZw/dBof5+1vAQrQoUsZRVs3rlTi0p0x633eGOAj0RobNrihc/vuOa7pHG
         6eAH/89w+vFWZOFZKuerCFUtKJltGh7FmZ8pO7PYlqTZ0a/VC8XtnkggkA2JAFhJv0Bq
         XuPNI1tM13nTx7WnwNrHP7EJRu30NfUNL14KiE7pfsaKcQNbGHrbWnb6HNFNCHTwS0HG
         GcFhASxwqz+vqOX7V/nyAXR1aQ+K6hWKSIyZVhA20KJfGBBz8iVnsEyNGQ2cl706sOdd
         157Q==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <ff999018-8490-0f58-0a50-e82f1effce5c@linaro.org>
Date: Mon, 14 Aug 2023 10:17:12 +0200
MIME-Version: 1.0
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 09/15] pinctrl: pinctrl-oxnas: remove obsolete pinctrl driver
References: <20230630-topic-oxnas-upstream-remove-v2-0-fb6ab3dea87c@linaro.org>
 <20230630-topic-oxnas-upstream-remove-v2-9-fb6ab3dea87c@linaro.org>
 <a9074f2d-ffa2-477f-e3b5-2c7d213ec72c@linaro.org>
 <CACRpkdbMy=JWAgybtimQXJRQ7jsVZ1g-DfqjryjP31JT9f=Prg@mail.gmail.com>
In-Reply-To: <CACRpkdbMy=JWAgybtimQXJRQ7jsVZ1g-DfqjryjP31JT9f=Prg@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>, Sebastian Reichel <sre@kernel.org>, Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-mtd@lists.infradead.org, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-oxnas@groups.io, Arnd Bergmann <arnd@arndb.de>, Daniel Golle <daniel@makrotopia.org>
List-ID: <linux-oxnas@groups.io>

On 07/08/2023 15:44, Linus Walleij wrote:
> On Mon, Jul 31, 2023 at 4:44 PM Neil Armstrong
> <neil.armstrong@linaro.org> wrote:
>> On 30/06/2023 18:58, Neil Armstrong wrote:
>>> Due to lack of maintenance and stall of development for a few years now,
>>> and since no new features will ever be added upstream, remove support
>>> for OX810 and OX820 pinctrl & gpio.
>>
>> Do you plan to take patches 9, 10 & 11 or should I funnel them via a final SoC PR ?
> 
> I tried to apply them to the pinctrl tree but that fails ...
> Could you rebase patches 9,10,11 onto my "devel" branch
> and send separately? Then I will apply them right away.

Sure, sent them right now!

Thx,
Neil

> 
> Yours,
> Linus Walleij

