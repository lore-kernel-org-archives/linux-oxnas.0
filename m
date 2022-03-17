Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web08.94.1647536130944713444
 for <linux-oxnas@groups.io>;
 Thu, 17 Mar 2022 09:55:31 -0700
Received: by mail-wr1-f48.google.com with SMTP id p9so8159764wra.12
        for <linux-oxnas@groups.io>; Thu, 17 Mar 2022 09:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:organization:in-reply-to:content-transfer-encoding;
        bh=i/Fk6gDMt/Grt4NJkS0bE/RE15fansbwCg4R3aEXH2U=;
        b=ozNezHAQFm92bl3PCurfC7T22hhihc8I0s6w6D+NJXW8UBmlb9DBHUe3VmtcPvU95J
         lPa7l6QL2qa7i7CyKyRW4CtaGJnJr8rZ54Ptk7RwizCnoehZakTY7XlK2Lu51SEzg+YB
         vgCEI2W8MwBol81BtpywAtivFLGxRLRAj7/8scHDG7WGnMeNvYfkAp5yFTMzvqkOkHfI
         ZdpqCYINy33Y6PnSVOmzkPCduhiESww8VzMJsrDRCh8DkkCm5MWTSkVRQnQY5EX+kwn+
         MgIr7V+c5el1XET1TCWAMv8rc6nmnMmLad5KunbZC/WZT/EYkqOylQCQVhxngtxl+qZS
         qVxA==
Return-Path: <narmstrong@baylibre.com>
Message-ID: <d53764bd-8b49-37eb-c393-1317180979d1@baylibre.com>
Date: Thu, 17 Mar 2022 17:55:27 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 02/18] ARM: dts: ox820: align interrupt controller node name with dtschema
References: <20220317115542.450032-1-krzysztof.kozlowski@canonical.com>
 <20220317115705.450427-1-krzysztof.kozlowski@canonical.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
In-Reply-To: <20220317115705.450427-1-krzysztof.kozlowski@canonical.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io
List-ID: <linux-oxnas@groups.io>

On 17/03/2022 12:56, Krzysztof Kozlowski wrote:
> Fixes dtbs_check warnings like:
> 
>    gic@1000: $nodename:0: 'gic@1000' does not match '^interrupt-controller(@[0-9a-f,]+)*$'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>   arch/arm/boot/dts/ox820.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/ox820.dtsi b/arch/arm/boot/dts/ox820.dtsi
> index 90846a7655b4..dde4364892bf 100644
> --- a/arch/arm/boot/dts/ox820.dtsi
> +++ b/arch/arm/boot/dts/ox820.dtsi
> @@ -287,7 +287,7 @@ local-timer@600 {
>   				clocks = <&armclk>;
>   			};
>   
> -			gic: gic@1000 {
> +			gic: interrupt-controller@1000 {
>   				compatible = "arm,arm11mp-gic";
>   				interrupt-controller;
>   				#interrupt-cells = <3>;

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
