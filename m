Received: by mail-wr1-f66.google.com with SMTP id b14so1365248wru.12
        for <linux-oxnas@groups.io>; Tue, 04 Dec 2018 00:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=mvkdi3q+pCk19j+OSCfIIO4IR4c7G8O0A9eW6/HhP7s=;
        b=H3IU8tzbX+K1KZGAxgcl8y+TQFRwPk/o9HFRGDIA8A/MN17BRpJls1VASuivI/q4H8
         Sz7R0XqDNbYmkk/jGBKD/E/zaDuN1+5PSfFv1XKBFWoFCi1Q5ab0ootFd3mpq8VGw7pj
         kBo7P/zm0yvM8cyaBp/rh+lVcoLu4CeDxSfrUwSX/Dt/u5USczVIRBcLYjA61vs6Nq2F
         CEigs7nGwonnLgqZzaVGR6OURed7BAm6y5oYkOhxzZhCbwt7ebpgRusmRCsJWBnUksMb
         69mVuvJsxaEKoOcDzj4XTx1PudP6US5GJ+LyvPD/QlDimfDgxlTyzmwpo7okhoLa+qZk
         Hk/w==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH v2 21/34] dt-bindings: arm: Convert Oxford Semi board/soc bindings to json-schema
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-22-robh@kernel.org>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <be37bd18-a573-307e-3a9e-e879010cfc89@baylibre.com>
Date: Tue, 4 Dec 2018 09:43:08 +0100
MIME-Version: 1.0
In-Reply-To: <20181203213223.16986-22-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sean Hudson <darknighte@darknighte.com>, Frank Rowand <frowand.list@gmail.com>, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, Grant Likely <grant.likely@arm.com>, Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org, Mark Rutland <mark.rutland@arm.com>, linux-oxnas@groups.io
List-ID: <linux-oxnas@groups.io>

On 03/12/2018 22:32, Rob Herring wrote:
> Convert Oxford Semi SoC bindings to DT schema format using json-schema.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-oxnas@groups.io
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/arm/oxnas.txt         | 14 -----------
>  .../devicetree/bindings/arm/oxnas.yaml        | 25 +++++++++++++++++++
>  2 files changed, 25 insertions(+), 14 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/oxnas.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/oxnas.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/oxnas.txt b/Documentation/devicetree/bindings/arm/oxnas.txt
> deleted file mode 100644
> index ac64e60f99f1..000000000000
> --- a/Documentation/devicetree/bindings/arm/oxnas.txt
> +++ /dev/null
> @@ -1,14 +0,0 @@
> -Oxford Semiconductor OXNAS SoCs Family device tree bindings
> --------------------------------------------
> -
> -Boards with the OX810SE SoC shall have the following properties:
> -  Required root node property:
> -    compatible: "oxsemi,ox810se"
> -
> -Boards with the OX820 SoC shall have the following properties:
> -  Required root node property:
> -    compatible: "oxsemi,ox820"
> -
> -Board compatible values:
> -  - "wd,mbwe" (OX810SE)
> -  - "cloudengines,pogoplugv3" (OX820)
> diff --git a/Documentation/devicetree/bindings/arm/oxnas.yaml b/Documentation/devicetree/bindings/arm/oxnas.yaml
> new file mode 100644
> index 000000000000..6ae51ef513be
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/oxnas.yaml
> @@ -0,0 +1,25 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/oxnas.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Oxford Semiconductor OXNAS SoCs Family device tree bindings
> +
> +maintainers:
> +  - Neil Armstrong <narmstrong@baylibre.com>
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +      - items:
> +        - enum:
> +            - wd,mbwe
> +        - const: oxsemi,ox810se
> +
> +      - items:
> +        - enum:
> +            - cloudengines,pogoplugv3
> +        - const: oxsemi,ox820
> 

We also loose all the "human friendly" description of board/SoC relationship here,
and I think it's a shame.

Neil
