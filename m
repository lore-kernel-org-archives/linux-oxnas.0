Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web11.103641.1680619377122126518
 for <linux-oxnas@groups.io>;
 Tue, 04 Apr 2023 07:43:09 -0700
Received: by mail-wr1-f48.google.com with SMTP id d17so33066504wrb.11
        for <linux-oxnas@groups.io>; Tue, 04 Apr 2023 07:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680619388;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ad6h00Bx8GcKvck9bd01LkivTMFfzeKAoZr2DuRzZuA=;
        b=YeDuuIfA00m/SVTJZt2sK031PCR9Cqj0FtcGK4nbxlIe3o3QA9GFmxs/v/H0Ac988T
         2F2mIHDrEEy4B+S+TJ46ZVZIDMOUfekOcTI+vhfhF9hM3r54E0WUhyghB0Ji7VR0W1LJ
         wU0t6+WVfS+2kzdcdCxytjoUNKCA+ijsWzkRVExLs9Vv6+YCHH9LpaZt1BxOvcBZWdgZ
         N9BkFzq1CAGRBE101KY9uf0jywL5fYp4LHcMo7Op+yhLlkkyldgQSw6v46szCeKyJx3F
         +jUua4LZ728+8/bW+ZIKBvip3PcN8/Uq4lvAWvWwToQYMD13rwGfK+uoZUBWQ/KZZNM6
         xu9w==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <f221954d-66f2-8dac-8e2b-5769c18d9aca@linaro.org>
Date: Tue, 4 Apr 2023 16:43:07 +0200
MIME-Version: 1.0
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH RFC v2 0/4] ARM: oxnas support removal
References: <20230331-topic-oxnas-upstream-remove-v2-0-e51078376f08@linaro.org>
 <86d63038-e3f5-4c03-b904-a26761b0578d@app.fastmail.com>
In-Reply-To: <86d63038-e3f5-4c03-b904-a26761b0578d@app.fastmail.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, soc@kernel.org, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, "linux-oxnas@groups.io" <linux-oxnas@groups.io>, Linus Walleij <linus.walleij@linaro.org>, Daniel Golle <daniel@makrotopia.org>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
List-ID: <linux-oxnas@groups.io>

On 04/04/2023 16:37, Arnd Bergmann wrote:
> On Mon, Apr 3, 2023, at 09:42, Neil Armstrong wrote:
>> With [1] removing MPCore SMP support, this makes the OX820 barely usable,
>> associated with a clear lack of maintainance, development and migration to
>> dt-schema it's clear that Linux support for OX810 and OX820 should be removed.
>>
>> In addition, the OX810 hasn't been booted for years and isn't even present
>> in an ARM config file.
>>
>> For the OX820, lack of USB and SATA support makes the platform not usable
>> in the current Linux support and relies on off-tree drivers hacked from the
>> vendor (defunct for years) sources.
>>
>> The last users are in the OpenWRT distribution, and today's removal means
>> support will still be in stable 6.1 LTS kernel until end of 2026.
>>
>> If someone wants to take over the development even with lack of SMP, I'll
>> be happy to hand off maintainance.
>>
>> The plan is to apply the first 4 patches first, then the drivers
>> followed by bindings. Finally the MAINTAINANCE entry can be removed.
>>
> 
> I merged all four into the soc tree now, thanks!

Thanks for handling this !

Neil

> 
>       Arnd

