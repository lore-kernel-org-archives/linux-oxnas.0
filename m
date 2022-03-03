Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web09.8719.1646294834252998922
 for <linux-oxnas@groups.io>;
 Thu, 03 Mar 2022 00:07:15 -0800
Received: by mail-wm1-f46.google.com with SMTP id r187-20020a1c2bc4000000b003810e6b192aso2734468wmr.1
        for <linux-oxnas@groups.io>; Thu, 03 Mar 2022 00:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=T4kbvdEkJq7G6CWV0LAt8KL4gr8THBwbvBRsRaY/1QQ=;
        b=M/tb1iQDePqb2cmCw0hU63ea8SHPbgBraIobX1tCakB233EkdlNYqSdYUoLFfOEPTs
         t5ECrCvd788ldBGHa1nJbxRykpHBaD/HEQGExMpiH5o+y6fJHq3HbMDVIDD2xNJEsSzi
         O5hoF7fTiPL9/GC6fZ1CNfQLtjhiMrnIapRJosNBhe8s7P794FZnVdV/Wpl9z2+feW3f
         MgpzrD7p9NfGYUVXfzr5FQDt/Y4OGOwx2Hi50nfkD3tkx0uuzQxuu6NqevUrwDJpMtLW
         E0+pygTamKjNW+kD/MrM+puuyLqXpryxCWyFRdG8bj6+/jHGIPgu5+ITm8onuR1OtlQw
         AwbQ==
Return-Path: <narmstrong@baylibre.com>
Message-ID: <7d585748-7a41-13ca-60da-20eb4fe78374@baylibre.com>
Date: Thu, 3 Mar 2022 09:07:11 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] clk: Use of_device_get_match_data()
References: <20220303014856.2059307-1-chi.minghao@zte.com.cn>
From: "Neil Armstrong" <narmstrong@baylibre.com>
In-Reply-To: <20220303014856.2059307-1-chi.minghao@zte.com.cn>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: cgel.zte@gmail.com, mturquette@baylibre.com
Cc: sboyd@kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io, linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
List-ID: <linux-oxnas@groups.io>

On 03/03/2022 02:48, cgel.zte@gmail.com wrote:
> From: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
> 
> Use of_device_get_match_data() to simplify the code.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
> ---
>   drivers/clk/clk-oxnas.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/clk/clk-oxnas.c b/drivers/clk/clk-oxnas.c
> index 78d5ea669fea..cda5e258355b 100644
> --- a/drivers/clk/clk-oxnas.c
> +++ b/drivers/clk/clk-oxnas.c
> @@ -209,15 +209,11 @@ static int oxnas_stdclk_probe(struct platform_device *pdev)
>   {
>   	struct device_node *np = pdev->dev.of_node;
>   	const struct oxnas_stdclk_data *data;
> -	const struct of_device_id *id;
>   	struct regmap *regmap;
>   	int ret;
>   	int i;
>   
> -	id = of_match_device(oxnas_stdclk_dt_ids, &pdev->dev);
> -	if (!id)
> -		return -ENODEV;
> -	data = id->data;
> +	data = of_device_get_match_data(&pdev->dev);
>   
>   	regmap = syscon_node_to_regmap(of_get_parent(np));
>   	if (IS_ERR(regmap)) {


Acked-by: Neil Armstrong <narmstrong@baylibre.com>
