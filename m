Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web10.10614.1650644547474222405
 for <linux-oxnas@groups.io>;
 Fri, 22 Apr 2022 09:22:28 -0700
Received: by mail-wm1-f49.google.com with SMTP id q20so5395640wmq.1
        for <linux-oxnas@groups.io>; Fri, 22 Apr 2022 09:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:organization:in-reply-to:content-transfer-encoding;
        bh=zY4C5B+QxiaTEzxxexC/40j3SP92tDxpSvstBBqkr8I=;
        b=2KC6S/IX6j6j/hdZgAG7Wy8zhssVYkMM2W/r28JdDOxrZe9kjqLKPvOKBbwEeBuGvZ
         94NicFy5IACmfK/dmOP3VJESQJCYQUkwW8sSzBVmJbUKOTfLpl0agepRGrJWK7bG0hGU
         zuVDM0shNBruv50LMO1GRNg534Rk+TCBYfXW9m/O4b+bxaeOsP9Xga+ZcnNNYEfRxZkA
         Vjvsae3frQrSGgwDuIeERO1opJtgk4I682nSte3jDJbtnySeKOCYaQY3XR5RC5UXSJzK
         8BsH9Fdhnb8k1/lx5cazSisFmCBYOo+HjnW8jTAH3hmics07gFpAGcQJF1qVdletwGcS
         esaw==
Return-Path: <narmstrong@baylibre.com>
Message-ID: <23ce10e4-bdb6-9b3a-465b-8ff86d679296@baylibre.com>
Date: Fri, 22 Apr 2022 18:22:24 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] clocksource/drivers/oxnas-rps: Fix irq_of_parse_and_map() return value
References: <20220422104101.55754-1-krzysztof.kozlowski@linaro.org>
From: "Neil Armstrong" <narmstrong@baylibre.com>
In-Reply-To: <20220422104101.55754-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io
List-ID: <linux-oxnas@groups.io>

On 22/04/2022 12:41, Krzysztof Kozlowski wrote:
> The irq_of_parse_and_map() returns 0 on failure, not a negative ERRNO.
> 
> Fixes: 89355274e1f7 ("clocksource/drivers/oxnas-rps: Add Oxford Semiconductor RPS Dual Timer")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
