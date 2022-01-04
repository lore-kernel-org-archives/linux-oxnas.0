Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web12.7490.1641307936946812838
 for <linux-oxnas@groups.io>;
 Tue, 04 Jan 2022 06:52:17 -0800
Received: by mail-wr1-f46.google.com with SMTP id s1so76802404wrg.1
        for <linux-oxnas@groups.io>; Tue, 04 Jan 2022 06:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wXAzPQsg5I+E5DYLSQcCCKK+wJqUGxBemvQZ1bfwYvI=;
        b=Gqm+Uw7yxObjsdSzNZq+yLTAN7IuNuYwyVR/F6tcS3TV3LlIqnkNt7uLCf21E+L1M3
         wwmKzENS3zN2TCQjLD1SGcwCku2j2lCG3w1p3Cp5ACT2KHe015rZiTdNDjrpGGG4xiOk
         C/cXuFFK0F4gxQxQ0qv2BR0MJuxzjOcH2X6gtf5J/35Rbx3WiA5MnMKj/EZeDjhHbxMS
         Ej8ss1HxyCEyvILIJ4fYz/N55qrgaSjW9FRIi+3kaMVnKXEWvzddhCUaIQzL2vG3E+pa
         0XvhfbSdjsIOmGS7cxEQRM4O6BbSyiNYvqTp4I1KRUQasTwRj2ZhbGYI10Qh00Yi+NSa
         qDCA==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 1/4] dt-bindings: dma: Add bindings for ox810se dma engine
Date: Tue,  4 Jan 2022 15:52:03 +0100
Message-Id: <20220104145206.135524-2-narmstrong@baylibre.com>
In-Reply-To: <20220104145206.135524-1-narmstrong@baylibre.com>
References: <20220104145206.135524-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: vkoul@kernel.org, devicetree@vger.kernel.org
Cc: linux-oxnas@groups.io, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <linux-oxnas@groups.io>

This adds the YAML dt-bindings for the DMA engine found in the
Oxford Semiconductor OX810SE SoC.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../bindings/dma/oxsemi,ox810se-dma.yaml      | 97 +++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/oxsemi,ox810se-dma.yaml

diff --git a/Documentation/devicetree/bindings/dma/oxsemi,ox810se-dma.yaml b/Documentation/devicetree/bindings/dma/oxsemi,ox810se-dma.yaml
new file mode 100644
index 000000000000..6efa28e8b124
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/oxsemi,ox810se-dma.yaml
@@ -0,0 +1,97 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/oxsemi,ox810se-dma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Oxford Semiconductor DMA Controller Device Tree Bindings
+
+maintainers:
+  - Neil Armstrong <narmstrong@baylibre.com>
+
+allOf:
+  - $ref: "dma-controller.yaml#"
+
+properties:
+  "#dma-cells":
+    const: 1
+
+  compatible:
+    const: oxsemi,ox810se-dma
+
+  reg:
+    maxItems: 2
+
+  reg-names:
+    items:
+      - const: dma
+      - const: sgdma
+
+  interrupts:
+    maxItems: 5
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 2
+
+  reset-names:
+    items:
+      - const: dma
+      - const: sgdma
+
+  dma-channels: true
+
+  oxsemi,targets-types:
+    description:
+      Table with allowed memory ranges and memory type associated.
+    $ref: "/schemas/types.yaml#/definitions/uint32-matrix"
+    minItems: 4
+    items:
+      items:
+        - description:
+            The first cell defines the memory range start address
+        - description:
+            The first cell defines the memory range end address
+        - description:
+            The third cell represents memory type, 0 for SATA,
+            1 for DPE RX, 2 for DPE TX, 5 for AUDIO TX, 6 for AUDIO RX,
+            15 for DRAM MEMORY.
+          enum: [ 0, 1, 2, 5, 6, 15 ]
+
+required:
+  - "#dma-cells"
+  - dma-channels
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - resets
+  - reset-names
+  - oxsemi,targets-types
+
+additionalProperties: false
+
+examples:
+  - |
+    dma: dma-controller@600000 {
+        compatible = "oxsemi,ox810se-dma";
+        reg = <0x600000 0x100000>, <0xc00000 0x100000>;
+        reg-names = "dma", "sgdma";
+        interrupts = <13>, <14>, <15>, <16>, <20>;
+        clocks = <&stdclk 1>;
+        resets = <&reset 8>, <&reset 24>;
+        reset-names = "dma", "sgdma";
+
+        /* Encodes the authorized memory types */
+        oxsemi,targets-types =
+            <0x45900000 0x45a00000 0>,  /* SATA */
+            <0x42000000 0x43000000 0>,  /* SATA DATA */
+            <0x48000000 0x58000000 15>, /* DDR */
+            <0x58000000 0x58020000 15>; /* SRAM */
+
+        #dma-cells = <1>;
+        dma-channels = <5>;
+    };
+...
-- 
2.25.1

