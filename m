From: Phil Edworthy <phil.edworthy@renesas.com>
Subject: [PATCH] ARM: dts: OX820: Correct the GIC DT node name
Date: Tue, 27 Nov 2018 14:54:42 +0000
Message-Id: <20181127145442.7169-1-phil.edworthy@renesas.com>
To: Neil Armstrong <narmstrong@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Phil Edworthy <phil.edworthy@renesas.com>
List-ID: <linux-oxnas@groups.io>

Harmless mistake, but it's incorrect. The DT spec provides recommendations
for the node names:
"The name of a node should be somewhat generic, reflecting the function
of the device and not its precise programming model. If appropriate, the
name should be one of the following choices:
...
interrupt-controller"

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 arch/arm/boot/dts/ox820.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ox820.dtsi b/arch/arm/boot/dts/ox820.dtsi
index 085bbd33eadc..3a17ab4e7c2f 100644
--- a/arch/arm/boot/dts/ox820.dtsi
+++ b/arch/arm/boot/dts/ox820.dtsi
@@ -286,7 +286,7 @@
 				clocks = <&armclk>;
 			};
 
-			gic: gic@1000 {
+			gic: interrupt-controller@1000 {
 				compatible = "arm,arm11mp-gic";
 				interrupt-controller;
 				#interrupt-cells = <3>;
-- 
2.17.1

