Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
 by mx.groups.io with SMTP id smtpd.web10.9.1653058361166376940
 for <linux-oxnas@groups.io>;
 Fri, 20 May 2022 07:52:41 -0700
Received: by mail-lj1-f182.google.com with SMTP id g16so9958058lja.3
        for <linux-oxnas@groups.io>; Fri, 20 May 2022 07:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=t4cBrKeJtdPwBWEs6cNQFiz2k88jVwV/q/Fcx7GSQ1I=;
        b=wNWXSDQBptmUZC0tIJV9zQckCzxtUc6HjyEQju3BoeKlXd/WmARYVMMzI0AVfbpGQ3
         1GzA2Pd6mpq8QL1Lu8IeyRxBNVzxaYr1ERcueH12TJnojGwUzz5dY8tzhp2w37rSA6Dx
         A1rk2KGqd5QlheBPeI8aHLK0/GbjdqdvqaKOv6OnwDOwNUyRrrgmHEbYw1qac4RIc7N5
         gASPxjb7MnPys81/KJ1dFXS7ZgOuNz9CCtectXs+FQetduvKiFYygoqUXPbvX771ZQvw
         b4tm1UEFAIcEnoVLJCKedJbmq7VtFErvA2tD2c8veVK06Lge8F9jrqbo0nG/9a40GOmq
         gvAQ==
Return-Path: <krzysztof.kozlowski@linaro.org>
Message-ID: <c173a336-1f57-0712-fce4-d6885e343d2f@linaro.org>
Date: Fri, 20 May 2022 16:52:37 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] clocksource/drivers/oxnas-rps: Fix irq_of_parse_and_map() return value
References: <20220422104101.55754-1-krzysztof.kozlowski@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220422104101.55754-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Neil Armstrong <narmstrong@baylibre.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io
List-ID: <linux-oxnas@groups.io>

On 22/04/2022 12:41, Krzysztof Kozlowski wrote:
> The irq_of_parse_and_map() returns 0 on failure, not a negative ERRNO.
> 
> Fixes: 89355274e1f7 ("clocksource/drivers/oxnas-rps: Add Oxford Semiconductor RPS Dual Timer")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

This was sent a month ago and it is a fix. It also received a review.
Any comments from maintainers? Is it going to be picked up?

Best regards,
Krzysztof
