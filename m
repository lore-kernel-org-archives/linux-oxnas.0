Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.web12.1486.1571316616343465293
 for <linux-oxnas@groups.io>;
 Thu, 17 Oct 2019 05:50:16 -0700
Received: by mail-wr1-f67.google.com with SMTP id p14so2219525wro.4
        for <linux-oxnas@groups.io>; Thu, 17 Oct 2019 05:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ygJUrHeizd9soeqee037mfyqgWGQb7tTFo0uEUNXPNo=;
        b=GdzCP+qrRx7X03MCzNbH+t4tSOqxx98Bbl77dESsq1pFC2ct6lL0JN8cKoKsxVZguG
         ZwV2uIlL6I47BjTGEOY5kwsL/1dWBT/IaiKg/ddhW1/5x/bG2GjokGA7FRPyB+oXi0OC
         H/8Rjpe0J5sX7Bj25vas8rjkO2A7b4GxHeOoW4sTd4x04IaQdGfRM5rW6s10bGDvcnSz
         o2fmcqY+iV7zUwqVV70QjG5rZe9KbS5z9ln/BwJW/zmwNBVJ52ktgPlLbenoFHR0YG7K
         K8DzTU5xXgQEs92f3p8V6jGfeO4oSyNogcSJFRayzrbdCWy95pPCuTJtY31Qw2P7k4vE
         O7Gw==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH -next 15/30] pinctrl: oxnas: use devm_platform_ioremap_resource() to simplify code
References: <20191017122640.22976-1-yuehaibing@huawei.com>
 <20191017122640.22976-16-yuehaibing@huawei.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <2b343ef8-45ac-e7a0-91cc-879980593b27@baylibre.com>
Date: Thu, 17 Oct 2019 14:50:11 +0200
MIME-Version: 1.0
In-Reply-To: <20191017122640.22976-16-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: YueHaibing <yuehaibing@huawei.com>, linus.walleij@linaro.org, manivannan.sadhasivam@linaro.org, afaerber@suse.de, f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, jesper.nilsson@axis.com, lars.persson@axis.com, ludovic.desroches@microchip.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, baruch@tkos.co.il
Cc: linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com, linux-oxnas@groups.io, linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org, vz@mleia.com, geert+renesas@glider.be, daniel@zonque.org, haojian.zhuang@gmail.com, wens@csie.org, thierry.reding@gmail.com, jonathanh@nvidia.com, agross@kernel.org
List-ID: <linux-oxnas@groups.io>

On 17/10/2019 14:26, YueHaibing wrote:
> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/pinctrl/pinctrl-oxnas.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-oxnas.c b/drivers/pinctrl/pinctrl-oxnas.c
> index 40dc125..674b7b5 100644
> --- a/drivers/pinctrl/pinctrl-oxnas.c
> +++ b/drivers/pinctrl/pinctrl-oxnas.c
> @@ -1196,7 +1196,6 @@ static int oxnas_gpio_probe(struct platform_device *pdev)
>  	struct oxnas_gpio_bank *bank;
>  	unsigned int id, ngpios;
>  	int irq, ret;
> -	struct resource *res;
>  	struct gpio_irq_chip *girq;
>  
>  	if (of_parse_phandle_with_fixed_args(np, "gpio-ranges",
> @@ -1220,8 +1219,7 @@ static int oxnas_gpio_probe(struct platform_device *pdev)
>  
>  	bank = &oxnas_gpio_banks[id];
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	bank->reg_base = devm_ioremap_resource(&pdev->dev, res);
> +	bank->reg_base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(bank->reg_base))
>  		return PTR_ERR(bank->reg_base);
>  
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
