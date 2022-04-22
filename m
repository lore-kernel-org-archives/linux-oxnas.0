Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web10.10613.1650644542179852645
 for <linux-oxnas@groups.io>;
 Fri, 22 Apr 2022 09:22:23 -0700
Received: by mail-wm1-f48.google.com with SMTP id r187-20020a1c44c4000000b0038ccb70e239so8289378wma.3
        for <linux-oxnas@groups.io>; Fri, 22 Apr 2022 09:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=IDDAXsK5zsHVMrFdm0XL9HyiRmqAUPBzCsjbYUV61Cs=;
        b=H2KvJ4NL/quQt3z0skXvvhlGPWn8Z5u74THDmxmB2gR3ivtQ6ORTtN6AOGDJm1AGru
         4l+n1YRH4eVX6QNSlHjLKtpR5XtLodKvrDik0AltRLLarcf5jTerrqnty2I54iWg0oRu
         WKnVcmAYtMzrUnLLKK6JApUU9Nfn97UtyRnprA9tEqDoiVADbgVK1uU4Lbyjf6hkT2f2
         xR9YIWarWkavifPfHgJbvPLjTCkSEEB9JLH7WkrmYzc1JgCYc0D3dglFbxOd2WBXbwQE
         aQjCmXGwXQgiifKWmZWpcJ3MiJMMT8a5BR4u43QsqTbG/iQcUIYkL56Ll2uo43F0Ak1E
         tjUA==
Return-Path: <narmstrong@baylibre.com>
Message-ID: <f6905ca8-301b-0f95-1cc2-78503bec1496@baylibre.com>
Date: Fri, 22 Apr 2022 18:22:18 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] clocksource/drivers/oxnas: fix error check return value of irq_of_parse_and_map()
References: <20220422084816.2775898-1-lv.ruyi@zte.com.cn>
From: "Neil Armstrong" <narmstrong@baylibre.com>
In-Reply-To: <20220422084816.2775898-1-lv.ruyi@zte.com.cn>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: cgel.zte@gmail.com, daniel.lezcano@linaro.org, tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io, Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
List-ID: <linux-oxnas@groups.io>

On 22/04/2022 10:48, cgel.zte@gmail.com wrote:
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
> 
> The irq_of_parse_and_map() function returns 0 on failure, and does not
> return an negative value.
> 
> Fixes: 	89355274e1f7 ("clocksource/drivers/oxnas-rps: Add Oxford Semiconductor RPS Dual Timer")
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
> ---
>   drivers/clocksource/timer-oxnas-rps.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/timer-oxnas-rps.c b/drivers/clocksource/timer-oxnas-rps.c
> index 56c0cc32d0ac..d514b44e67dd 100644
> --- a/drivers/clocksource/timer-oxnas-rps.c
> +++ b/drivers/clocksource/timer-oxnas-rps.c
> @@ -236,7 +236,7 @@ static int __init oxnas_rps_timer_init(struct device_node *np)
>   	}
>   
>   	rps->irq = irq_of_parse_and_map(np, 0);
> -	if (rps->irq < 0) {
> +	if (!rps->irq) {
>   		ret = -EINVAL;
>   		goto err_iomap;
>   	}

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
