Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
 by mx.groups.io with SMTP id smtpd.web09.17166.1641950451155687416
 for <linux-oxnas@groups.io>;
 Tue, 11 Jan 2022 17:20:51 -0800
Received: by mail-ot1-f48.google.com with SMTP id a12-20020a0568301dcc00b005919e149b4cso836312otj.8
        for <linux-oxnas@groups.io>; Tue, 11 Jan 2022 17:20:51 -0800 (PST)
Return-Path: <robherring2@gmail.com>
Date: Tue, 11 Jan 2022 19:20:48 -0600
From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: dma: Add bindings for ox810se dma engine
Message-ID: <Yd4s8OYf7QSryXzr@robh.at.kernel.org>
References: <20220104145206.135524-1-narmstrong@baylibre.com>
 <20220104145206.135524-2-narmstrong@baylibre.com>
MIME-Version: 1.0
In-Reply-To: <20220104145206.135524-2-narmstrong@baylibre.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: vkoul@kernel.org, devicetree@vger.kernel.org, linux-oxnas@groups.io, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-ID: <linux-oxnas@groups.io>

On Tue, Jan 04, 2022 at 03:52:03PM +0100, Neil Armstrong wrote:
> This adds the YAML dt-bindings for the DMA engine found in the
> Oxford Semiconductor OX810SE SoC.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../bindings/dma/oxsemi,ox810se-dma.yaml      | 97 +++++++++++++++++++
>  1 file changed, 97 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/oxsemi,ox810se-dma.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dma/oxsemi,ox810se-dma.yaml b/Documentation/devicetree/bindings/dma/oxsemi,ox810se-dma.yaml
> new file mode 100644
> index 000000000000..6efa28e8b124
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/oxsemi,ox810se-dma.yaml
> @@ -0,0 +1,97 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/oxsemi,ox810se-dma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Oxford Semiconductor DMA Controller Device Tree Bindings
> +
> +maintainers:
> +  - Neil Armstrong <narmstrong@baylibre.com>
> +
> +allOf:
> +  - $ref: "dma-controller.yaml#"
> +
> +properties:
> +  "#dma-cells":
> +    const: 1
> +
> +  compatible:
> +    const: oxsemi,ox810se-dma
> +
> +  reg:
> +    maxItems: 2
> +
> +  reg-names:
> +    items:
> +      - const: dma
> +      - const: sgdma
> +
> +  interrupts:
> +    maxItems: 5

Need to define what each one is.

> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 2
> +
> +  reset-names:
> +    items:
> +      - const: dma
> +      - const: sgdma
> +
> +  dma-channels: true

Constraints on number of channels?

> +
> +  oxsemi,targets-types:
> +    description:
> +      Table with allowed memory ranges and memory type associated.
> +    $ref: "/schemas/types.yaml#/definitions/uint32-matrix"
> +    minItems: 4
> +    items:
> +      items:
> +        - description:
> +            The first cell defines the memory range start address
> +        - description:
> +            The first cell defines the memory range end address
> +        - description:
> +            The third cell represents memory type, 0 for SATA,
> +            1 for DPE RX, 2 for DPE TX, 5 for AUDIO TX, 6 for AUDIO RX,
> +            15 for DRAM MEMORY.
> +          enum: [ 0, 1, 2, 5, 6, 15 ]
> +
> +required:
> +  - "#dma-cells"
> +  - dma-channels
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - resets
> +  - reset-names
> +  - oxsemi,targets-types
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    dma: dma-controller@600000 {

Drop unused labels.

> +        compatible = "oxsemi,ox810se-dma";
> +        reg = <0x600000 0x100000>, <0xc00000 0x100000>;
> +        reg-names = "dma", "sgdma";
> +        interrupts = <13>, <14>, <15>, <16>, <20>;
> +        clocks = <&stdclk 1>;
> +        resets = <&reset 8>, <&reset 24>;
> +        reset-names = "dma", "sgdma";
> +
> +        /* Encodes the authorized memory types */
> +        oxsemi,targets-types =
> +            <0x45900000 0x45a00000 0>,  /* SATA */
> +            <0x42000000 0x43000000 0>,  /* SATA DATA */
> +            <0x48000000 0x58000000 15>, /* DDR */
> +            <0x58000000 0x58020000 15>; /* SRAM */
> +
> +        #dma-cells = <1>;
> +        dma-channels = <5>;
> +    };
> +...
> -- 
> 2.25.1
> 
> 
