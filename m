Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com [209.85.208.196])
 by mx.groups.io with SMTP id smtpd.web10.27344.1584877541921086988
 for <linux-oxnas@groups.io>;
 Sun, 22 Mar 2020 04:45:42 -0700
Received: by mail-lj1-f196.google.com with SMTP id w4so11340580lji.11
        for <linux-oxnas@groups.io>; Sun, 22 Mar 2020 04:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wvkwniGOgLV8mB9CWYJP/ZbTdJL82BLIEY1BcTY1Qto=;
        b=YEBV9C++ndScMxatDthA+7c/f8KKuvfqHltiGzT/Jc2ZHPU1tE227G0/kAb2z60WP+
         tCkZtG0LYyh89fSCUGOCOuSHrushC6Kuo1nBUPKiHVbwgog5bDAnMkK1DDXTzqLbbkao
         uC2xZTER+EwG7GN0qOrBq9pX2sFNst9ayS+K9GtKWWY4BSlZ8srH1+HnmajSF0ikQDG8
         xJKMCr/0rDN486nzu53ft/63SkVj4DkAKkblD88kmaUoP/BofYCVVgREFD13eXHBH9jf
         iILEc0VBhXKw8zus2J2RFO+uZi8GDlj2bZHAHqbeDCEuJKQi0Qu1qkIHkQZqZRFoN9UK
         TRoQ==
MIME-Version: 1.0
References: <20200321133842.2408823-1-mans0n@gorani.run>
In-Reply-To: <20200321133842.2408823-1-mans0n@gorani.run>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 22 Mar 2020 12:45:29 +0100
Message-ID: <CACRpkdYvoVF_q1Re_v_sJCYVDOhte0NpdU91UtYB2SpHH60-jg@mail.gmail.com>
Subject: Re: [PATCH] irqchip/versatile-fpga: Apply clear-mask earlier
Content-Type: text/plain; charset="UTF-8"
To: Sungbo Eo <mans0n@gorani.run>
Cc: linux-oxnas@groups.io, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <maz@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Neil Armstrong <narmstrong@baylibre.com>, Daniel Golle <daniel@makrotopia.org>
List-ID: <linux-oxnas@groups.io>

On Sat, Mar 21, 2020 at 2:40 PM Sungbo Eo <mans0n@gorani.run> wrote:

> Clear its own IRQs before the parent IRQ get enabled, so that the
> remaining IRQs do not accidentally interrupt the parent IRQ controller.
>
> This patch also fixes a reboot bug on OX820 SoC, where the remaining
> rps-timer IRQ raises a GIC interrupt that is left pending. After that,
> the rps-timer IRQ is cleared during driver initialization, and there's
> no IRQ left in rps-irq when local_irq_enable() is called, which evokes
> an error message "unexpected IRQ trap".
>
> Fixes: bdd272cbb97a ("irqchip: versatile FPGA: support cascaded interrupts from DT")
> Signed-off-by: Sungbo Eo <mans0n@gorani.run>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Daniel Golle <daniel@makrotopia.org>

Good catch!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Marc: Cc stable?

Yours,
Linus Walleij
