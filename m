Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web12.5080.1630484070956336651
 for <linux-oxnas@groups.io>;
 Wed, 01 Sep 2021 01:14:31 -0700
Received: by mail-wm1-f54.google.com with SMTP id 79-20020a1c0452000000b002e6cf79e572so4107083wme.1
        for <linux-oxnas@groups.io>; Wed, 01 Sep 2021 01:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YrKVWBO1f/vW38Nzw0ET7Dtvvx+9TDWUyIhOz8vqs7c=;
        b=i/B3G1QjYGIKPhWb4mR83VZKwR3jlpFDSE4OlAn/5FfTm2eOXa+r91g/pQQzhUDijQ
         cFIcs6CRQwVvdhJ+3kE4FRr6MYWfoJ0qA4NMIBLLgAdM5ckRXIbGikB/WLdyfHQrVfgf
         +WvquCPK7qoc9BfzkWKoIp7tZfdWNBd0CcK3LmXLn0PHXY3cnQ1sTo8E86GHzGxnnZB5
         Q7cThkviMKoosz4L3WVsAtLBWyh9iXnTAQGMjfXhgkLj9KCcbA4YjXuT2+tJNh9kNhPv
         H1zmPrjpA+MX2iIEcz7YiGtJ2gBfykfoUTBvPJjyGoJWFaRsQaHmdv4AxH/sPP0nvSCb
         YVXA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] mtd: rawnand: oxnas: Make use of the helper function devm_platform_ioremap_resource()
References: <20210901074207.9333-1-caihuoqing@baidu.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <61ab65d3-bf52-5701-95d2-476b8c2d719c@baylibre.com>
Date: Wed, 1 Sep 2021 10:14:28 +0200
MIME-Version: 1.0
In-Reply-To: <20210901074207.9333-1-caihuoqing@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Cai Huoqing <caihuoqing@baidu.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io, linux-kernel@vger.kernel.org
List-ID: <linux-oxnas@groups.io>

On 01/09/2021 09:42, Cai Huoqing wrote:
> Use the devm_platform_ioremap_resource() helper instead of
> calling platform_get_resource() and devm_ioremap_resource()
> separately
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  drivers/mtd/nand/raw/oxnas_nand.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/oxnas_nand.c b/drivers/mtd/nand/raw/oxnas_nand.c
> index f44947043e5a..cd112d45e0b5 100644
> --- a/drivers/mtd/nand/raw/oxnas_nand.c
> +++ b/drivers/mtd/nand/raw/oxnas_nand.c
> @@ -79,7 +79,6 @@ static int oxnas_nand_probe(struct platform_device *pdev)
>  	struct oxnas_nand_ctrl *oxnas;
>  	struct nand_chip *chip;
>  	struct mtd_info *mtd;
> -	struct resource *res;
>  	int count = 0;
>  	int err = 0;
>  	int i;
> @@ -92,8 +91,7 @@ static int oxnas_nand_probe(struct platform_device *pdev)
>  
>  	nand_controller_init(&oxnas->base);
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	oxnas->io_base = devm_ioremap_resource(&pdev->dev, res);
> +	oxnas->io_base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(oxnas->io_base))
>  		return PTR_ERR(oxnas->io_base);
>  
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
