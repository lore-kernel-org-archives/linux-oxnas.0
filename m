Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web10.208.1653060256372288756
 for <linux-oxnas@groups.io>;
 Fri, 20 May 2022 08:24:16 -0700
Received: by mail-wm1-f43.google.com with SMTP id v191-20020a1cacc8000000b00397001398c0so6963969wme.5
        for <linux-oxnas@groups.io>; Fri, 20 May 2022 08:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=/x7HzvCombkVqeP8X1mXMfu7spv9X8WdOUuS9zwdEmE=;
        b=fc6CBWl9RqSOk1lu2dMMw50J6y8k7XvpawmGylhgXjTpnG47Gv75Lh3gKC15ykE0mS
         unh3K0F5hUOTdJ9jJaVl734rVZpTH1UncPq2x/btp30t2iXdH9E5aRmB1r153a10idKZ
         OUXME3NiLT9QR6ZZGcIhJTO9qbWFbYB5ACOaN2xItVGSuQnBjdMZj8yWjOeAkHegJJtM
         ArwpZUEZN9yuM4X8V6UZFRxq7z5Tvov3mRsR6W4d4ZAgGp1ZgAv0kf/HP4uJgWtCnHQW
         RNPx3+jVxftEY0gsvCKBtiv5RXdsUO495hOedp2de39gOjue1NuIPGiwHOOwq4zSkN88
         uhxw==
Return-Path: <daniel.lezcano@linaro.org>
Message-ID: <bda6fded-e925-6969-b6cb-f5f840460a90@linaro.org>
Date: Fri, 20 May 2022 17:24:01 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] clocksource/drivers/oxnas-rps: Fix irq_of_parse_and_map() return value
References: <20220422104101.55754-1-krzysztof.kozlowski@linaro.org>
 <c173a336-1f57-0712-fce4-d6885e343d2f@linaro.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <c173a336-1f57-0712-fce4-d6885e343d2f@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Neil Armstrong <narmstrong@baylibre.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io
List-ID: <linux-oxnas@groups.io>

On 20/05/2022 16:52, Krzysztof Kozlowski wrote:
> On 22/04/2022 12:41, Krzysztof Kozlowski wrote:
>> The irq_of_parse_and_map() returns 0 on failure, not a negative ERRNO.
>>
>> Fixes: 89355274e1f7 ("clocksource/drivers/oxnas-rps: Add Oxford Semiconductor RPS Dual Timer")
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> This was sent a month ago and it is a fix. It also received a review.
> Any comments from maintainers? Is it going to be picked up?


Applied


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
