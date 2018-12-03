Received: by mail-ot1-f66.google.com with SMTP id i20so13136102otl.0
        for <linux-oxnas@groups.io>; Mon, 03 Dec 2018 13:32:51 -0800 (PST)
Return-Path: <robherring2@gmail.com>
From: Rob Herring <robh@kernel.org>
Subject: [PATCH v2 21/34] dt-bindings: arm: Convert Oxford Semi board/soc bindings to json-schema
Date: Mon,  3 Dec 2018 15:32:10 -0600
Message-Id: <20181203213223.16986-22-robh@kernel.org>
In-Reply-To: <20181203213223.16986-1-robh@kernel.org>
References: <20181203213223.16986-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sean Hudson <darknighte@darknighte.com>, Frank Rowand <frowand.list@gmail.com>, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, Grant Likely <grant.likely@arm.com>, Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org, Mark Rutland <mark.rutland@arm.com>, Neil Armstrong <narmstrong@baylibre.com>, linux-oxnas@groups.io
List-ID: <linux-oxnas@groups.io>

Convert Oxford Semi SoC bindings to DT schema format using json-schema.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-oxnas@groups.io
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/oxnas.txt         | 14 -----------
 .../devicetree/bindings/arm/oxnas.yaml        | 25 +++++++++++++++++++
 2 files changed, 25 insertions(+), 14 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/oxnas.txt
 create mode 100644 Documentation/devicetree/bindings/arm/oxnas.yaml

diff --git a/Documentation/devicetree/bindings/arm/oxnas.txt b/Documentation/devicetree/bindings/arm/oxnas.txt
deleted file mode 100644
index ac64e60f99f1..000000000000
--- a/Documentation/devicetree/bindings/arm/oxnas.txt
+++ /dev/null
@@ -1,14 +0,0 @@
-Oxford Semiconductor OXNAS SoCs Family device tree bindings
--------------------------------------------
-
-Boards with the OX810SE SoC shall have the following properties:
-  Required root node property:
-    compatible: "oxsemi,ox810se"
-
-Boards with the OX820 SoC shall have the following properties:
-  Required root node property:
-    compatible: "oxsemi,ox820"
-
-Board compatible values:
-  - "wd,mbwe" (OX810SE)
-  - "cloudengines,pogoplugv3" (OX820)
diff --git a/Documentation/devicetree/bindings/arm/oxnas.yaml b/Documentation/devicetree/bindings/arm/oxnas.yaml
new file mode 100644
index 000000000000..6ae51ef513be
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/oxnas.yaml
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/oxnas.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Oxford Semiconductor OXNAS SoCs Family device tree bindings
+
+maintainers:
+  - Neil Armstrong <narmstrong@baylibre.com>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - items:
+        - enum:
+            - wd,mbwe
+        - const: oxsemi,ox810se
+
+      - items:
+        - enum:
+            - cloudengines,pogoplugv3
+        - const: oxsemi,ox820
-- 
2.19.1

