Received: by mail-oi1-f194.google.com with SMTP id t204so5307004oie.7
        for <linux-oxnas@groups.io>; Fri, 30 Nov 2018 09:06:40 -0800 (PST)
Return-Path: <robherring2@gmail.com>
From: Rob Herring <robh@kernel.org>
Subject: [PATCH] ARM: dts: Kill off skeleton{64}.dtsi
Date: Fri, 30 Nov 2018 11:06:34 -0600
Message-Id: <20181130170634.9467-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Tsahee Zidenberg <tsahee@annapurnalabs.com>, Antoine Tenart <antoine.tenart@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Lars Persson <lars.persson@axis.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Florian Fainelli <f.fainelli@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Baruch Siach <baruch@tkos.co.il>, Vladimir Zapolskiy <vz@mleia.com>, Sylvain Lemieux <slemieux.tyco@gmail.com>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, Neil Armstrong <narmstrong@baylibre.com>, Jamie Iles <jamie@jamieiles.com>, Barry Song <baohua@kernel.org>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Viresh Kumar <vireshk@kernel.org>, Shiraz Hashim <shiraz.linux.kernel@gmail.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, Jun Nie <jun.nie@linaro.org>, linux-arm-kernel@axis.com, linux-amlogic@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-oxnas@groups.io, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
List-ID: <linux-oxnas@groups.io>

Remove the usage of skeleton.dtsi in the remaining dts files. It was
deprecated since commit 9c0da3cc61f1 ("ARM: dts: explicitly mark
skeleton.dtsi as deprecated"). This will make adding a unit-address to
memory nodes easier.

The main tricky part to removing skeleton.dtsi is we could end up with
no /memory node at all when a bootloader depends on one being present. I
hacked up dtc to check for this condition.

Signed-off-by: Rob Herring <robh@kernel.org>
---
Yes, I'm being lazy and not splitting this up into dozens of sub-arch 
patches. I don't think this should conflict nor should we be getting new 
dependencies on skeleton.dtsi. So please apply directly to arm-soc.

Rob

 arch/arm/boot/dts/alphascale-asm9260.dtsi      |  3 ++-
 arch/arm/boot/dts/alpine.dtsi                  |  8 +++++++-
 arch/arm/boot/dts/arm-realview-eb.dtsi         |  4 +++-
 arch/arm/boot/dts/arm-realview-pb1176.dts      |  4 +++-
 arch/arm/boot/dts/arm-realview-pb11mp.dts      |  4 +++-
 arch/arm/boot/dts/arm-realview-pbx.dtsi        |  4 +++-
 arch/arm/boot/dts/armada-38x.dtsi              |  4 +++-
 arch/arm/boot/dts/armada-39x.dtsi              |  3 ++-
 arch/arm/boot/dts/artpec6.dtsi                 |  3 ++-
 arch/arm/boot/dts/at91rm9200.dtsi              |  4 +++-
 arch/arm/boot/dts/at91sam9260.dtsi             |  4 +++-
 arch/arm/boot/dts/at91sam9261.dtsi             |  4 +++-
 arch/arm/boot/dts/at91sam9263.dtsi             |  4 +++-
 arch/arm/boot/dts/at91sam9g45.dtsi             |  4 +++-
 arch/arm/boot/dts/at91sam9n12.dtsi             |  4 +++-
 arch/arm/boot/dts/at91sam9rl.dtsi              |  4 +++-
 arch/arm/boot/dts/at91sam9x5.dtsi              |  4 +++-
 arch/arm/boot/dts/atlas6-evb.dts               |  1 +
 arch/arm/boot/dts/atlas6.dtsi                  |  1 -
 arch/arm/boot/dts/atlas7.dtsi                  |  1 -
 arch/arm/boot/dts/axm55xx.dtsi                 |  4 ++--
 arch/arm/boot/dts/bcm-cygnus.dtsi              |  9 +++++++--
 arch/arm/boot/dts/bcm-nsp.dtsi                 |  4 ++--
 arch/arm/boot/dts/bcm11351.dtsi                |  4 ++--
 arch/arm/boot/dts/bcm21664-garnet.dts          |  1 +
 arch/arm/boot/dts/bcm21664.dtsi                |  4 ++--
 arch/arm/boot/dts/bcm23550-sparrow.dts         |  1 +
 arch/arm/boot/dts/bcm23550.dtsi                |  4 ++--
 arch/arm/boot/dts/bcm28155-ap.dts              |  1 +
 arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts    |  1 +
 .../boot/dts/bcm47081-buffalo-wzr-600dhp2.dts  |  1 +
 .../boot/dts/bcm47081-buffalo-wzr-900dhp.dts   |  1 +
 arch/arm/boot/dts/bcm47081-luxul-xap-1410.dts  |  1 +
 arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dts  |  1 +
 .../boot/dts/bcm47081-tplink-archer-c5-v2.dts  |  1 +
 arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts  |  1 +
 .../arm/boot/dts/bcm47094-linksys-panamera.dts |  1 +
 arch/arm/boot/dts/bcm47094-luxul-abr-4500.dts  |  1 +
 arch/arm/boot/dts/bcm47094-luxul-xap-1610.dts  |  1 +
 arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dts  |  1 +
 arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts  |  1 +
 .../boot/dts/bcm47094-luxul-xwr-3150-v1.dts    |  1 +
 arch/arm/boot/dts/bcm47094-netgear-r8500.dts   |  1 +
 arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts  |  1 +
 arch/arm/boot/dts/bcm47189-luxul-xap-810.dts   |  1 +
 arch/arm/boot/dts/bcm47189-tenda-ac9.dts       |  1 +
 arch/arm/boot/dts/bcm5301x.dtsi                |  3 ++-
 .../boot/dts/bcm53340-ubnt-unifi-switch8.dts   |  1 +
 arch/arm/boot/dts/bcm53573.dtsi                |  3 ++-
 arch/arm/boot/dts/bcm63138.dtsi                |  4 ++--
 arch/arm/boot/dts/bcm7445.dtsi                 |  2 --
 arch/arm/boot/dts/bcm947189acdbmr.dts          |  1 +
 arch/arm/boot/dts/bcm953012er.dts              |  1 +
 arch/arm/boot/dts/bcm953012hr.dts              |  1 +
 arch/arm/boot/dts/bcm953012k.dts               |  1 +
 arch/arm/boot/dts/cx92755.dtsi                 |  4 ++--
 arch/arm/boot/dts/dove.dtsi                    |  4 ++--
 arch/arm/boot/dts/ep7209.dtsi                  |  4 ++--
 arch/arm/boot/dts/ep7211-edb7211.dts           |  1 +
 arch/arm/boot/dts/integrator.dtsi              | 10 ++++++++--
 arch/arm/boot/dts/kirkwood.dtsi                |  3 ++-
 arch/arm/boot/dts/lpc32xx.dtsi                 |  4 ++--
 arch/arm/boot/dts/ls1021a.dtsi                 |  8 +++++++-
 arch/arm/boot/dts/meson.dtsi                   |  3 ++-
 arch/arm/boot/dts/meson6-atv1200.dts           |  1 +
 arch/arm/boot/dts/meson8-minix-neo-x8.dts      |  1 +
 arch/arm/boot/dts/meson8b-ec100.dts            |  1 +
 arch/arm/boot/dts/meson8b-mxq.dts              |  1 +
 arch/arm/boot/dts/meson8b-odroidc1.dts         |  1 +
 arch/arm/boot/dts/meson8m2-mxiii-plus.dts      |  1 +
 arch/arm/boot/dts/mmp2-brownstone.dts          |  1 +
 arch/arm/boot/dts/mmp2.dtsi                    |  4 +++-
 arch/arm/boot/dts/moxart.dtsi                  |  3 ++-
 arch/arm/boot/dts/mt2701-evb.dts               |  1 +
 arch/arm/boot/dts/mt2701.dtsi                  |  3 ++-
 arch/arm/boot/dts/mt6580-evbp1.dts             |  1 +
 arch/arm/boot/dts/mt6580.dtsi                  |  1 -
 arch/arm/boot/dts/mt6589-aquaris5.dts          |  1 +
 arch/arm/boot/dts/mt6589.dtsi                  |  3 ++-
 arch/arm/boot/dts/mt6592-evb.dts               |  2 +-
 arch/arm/boot/dts/mt6592.dtsi                  |  3 ++-
 arch/arm/boot/dts/mt8127-moose.dts             |  1 +
 arch/arm/boot/dts/mt8127.dtsi                  |  3 ++-
 arch/arm/boot/dts/mt8135-evbp1.dts             |  1 +
 arch/arm/boot/dts/mt8135.dtsi                  |  3 ++-
 arch/arm/boot/dts/nspire.dtsi                  |  4 ++--
 arch/arm/boot/dts/orion5x-lacie-d2-network.dts |  1 +
 .../orion5x-lacie-ethernet-disk-mini-v2.dts    |  1 +
 arch/arm/boot/dts/orion5x-lswsgl.dts           |  1 +
 .../dts/orion5x-maxtor-shared-storage-2.dts    |  1 +
 arch/arm/boot/dts/orion5x-netgear-wnr854t.dts  |  1 +
 arch/arm/boot/dts/orion5x-rd88f5182-nas.dts    |  1 +
 arch/arm/boot/dts/orion5x.dtsi                 |  4 ++--
 arch/arm/boot/dts/ox810se.dtsi                 |  4 +++-
 arch/arm/boot/dts/ox820.dtsi                   |  4 +++-
 arch/arm/boot/dts/picoxcell-pc3x2.dtsi         |  1 -
 arch/arm/boot/dts/picoxcell-pc3x3.dtsi         |  1 -
 arch/arm/boot/dts/prima2-evb.dts               |  1 +
 arch/arm/boot/dts/prima2.dtsi                  |  1 -
 arch/arm/boot/dts/pxa168.dtsi                  |  4 +++-
 arch/arm/boot/dts/pxa2xx.dtsi                  |  3 ++-
 arch/arm/boot/dts/pxa910.dtsi                  |  4 +++-
 arch/arm/boot/dts/qcom-apq8064.dtsi            |  8 +++++++-
 arch/arm/boot/dts/qcom-apq8084.dtsi            |  9 +++++++--
 arch/arm/boot/dts/qcom-ipq4019.dtsi            |  8 +++++++-
 arch/arm/boot/dts/qcom-ipq8064.dtsi            |  8 +++++++-
 arch/arm/boot/dts/qcom-mdm9615-wp8548.dtsi     |  1 +
 arch/arm/boot/dts/qcom-mdm9615.dtsi            |  4 ++--
 arch/arm/boot/dts/qcom-msm8660.dtsi            |  9 +++++++--
 arch/arm/boot/dts/qcom-msm8960.dtsi            |  9 +++++++--
 arch/arm/boot/dts/qcom-msm8974.dtsi            |  8 +++++++-
 arch/arm/boot/dts/sama5d2.dtsi                 |  4 +++-
 arch/arm/boot/dts/sama5d3.dtsi                 |  4 +++-
 arch/arm/boot/dts/sama5d4.dtsi                 |  4 +++-
 arch/arm/boot/dts/skeleton.dtsi                | 18 ------------------
 arch/arm/boot/dts/skeleton64.dtsi              | 14 --------------
 arch/arm/boot/dts/spear13xx.dtsi               |  4 ++--
 arch/arm/boot/dts/spear3xx.dtsi                |  4 ++--
 arch/arm/boot/dts/spear600.dtsi                |  4 ++--
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi     |  2 +-
 arch/arm/boot/dts/ste-u300.dts                 |  2 +-
 arch/arm/boot/dts/stm32429i-eval.dts           |  1 +
 arch/arm/boot/dts/stm32746g-eval.dts           |  1 +
 arch/arm/boot/dts/stm32f429-disco.dts          |  1 +
 arch/arm/boot/dts/stm32f429.dtsi               |  4 +++-
 arch/arm/boot/dts/stm32f469-disco.dts          |  1 +
 arch/arm/boot/dts/stm32f746-disco.dts          |  1 +
 arch/arm/boot/dts/stm32f746.dtsi               |  4 +++-
 arch/arm/boot/dts/stm32f769-disco.dts          |  1 +
 arch/arm/boot/dts/stm32h743.dtsi               |  4 +++-
 arch/arm/boot/dts/stm32h743i-disco.dts         |  1 +
 arch/arm/boot/dts/stm32h743i-eval.dts          |  1 +
 arch/arm/boot/dts/stm32mp157c-ed1.dts          |  1 +
 arch/arm/boot/dts/sun5i-a10s.dtsi              |  4 ++--
 arch/arm/boot/dts/sun5i-a13.dtsi               |  4 ++--
 arch/arm/boot/dts/sun5i.dtsi                   |  9 +++++++--
 arch/arm/boot/dts/sun6i-a31.dtsi               |  5 +++--
 arch/arm/boot/dts/sun7i-a20.dtsi               |  5 +++--
 arch/arm/boot/dts/sun8i-a23-a33.dtsi           |  4 ++--
 arch/arm/boot/dts/sun8i-a23.dtsi               |  1 +
 arch/arm/boot/dts/sun8i-a33.dtsi               |  1 +
 arch/arm/boot/dts/versatile-ab.dts             |  2 +-
 arch/arm/boot/dts/vt8500.dtsi                  |  9 +++++++--
 arch/arm/boot/dts/wm8505.dtsi                  |  9 +++++++--
 arch/arm/boot/dts/wm8650.dtsi                  |  9 +++++++--
 arch/arm/boot/dts/wm8750.dtsi                  |  9 +++++++--
 arch/arm/boot/dts/wm8850.dtsi                  |  9 +++++++--
 arch/arm/boot/dts/zx296702-ad1.dts             |  1 +
 arch/arm/boot/dts/zx296702.dtsi                |  4 +++-
 149 files changed, 330 insertions(+), 153 deletions(-)
 delete mode 100644 arch/arm/boot/dts/skeleton.dtsi
 delete mode 100644 arch/arm/boot/dts/skeleton64.dtsi

diff --git a/arch/arm/boot/dts/alphascale-asm9260.dtsi b/arch/arm/boot/dts/alphascale-asm9260.dtsi
index 907fc7bfc418..2ce6038536fd 100644
--- a/arch/arm/boot/dts/alphascale-asm9260.dtsi
+++ b/arch/arm/boot/dts/alphascale-asm9260.dtsi
@@ -4,10 +4,11 @@
  * Licensed under the X11 license or the GPL v2 (or later)
  */
 
-#include "skeleton.dtsi"
 #include <dt-bindings/clock/alphascale,asm9260.h>
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	interrupt-parent = <&icoll>;
 
 	memory {
diff --git a/arch/arm/boot/dts/alpine.dtsi b/arch/arm/boot/dts/alpine.dtsi
index 731df7a8c4e6..d3036ea823d1 100644
--- a/arch/arm/boot/dts/alpine.dtsi
+++ b/arch/arm/boot/dts/alpine.dtsi
@@ -25,12 +25,18 @@
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
-#include "skeleton64.dtsi"
 
 / {
+	#address-cells = <2>;
+	#size-cells = <2>;
 	/* SOC compatibility */
 	compatible = "al,alpine";
 
+	memory {
+		device_type = "memory";
+		reg = <0 0 0 0>;
+	};
+
 	/* CPU Configuration */
 	cpus {
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/arm-realview-eb.dtsi b/arch/arm/boot/dts/arm-realview-eb.dtsi
index 0e4c7c4c8c09..610506723ea5 100644
--- a/arch/arm/boot/dts/arm-realview-eb.dtsi
+++ b/arch/arm/boot/dts/arm-realview-eb.dtsi
@@ -22,9 +22,10 @@
 
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/gpio/gpio.h>
-#include "skeleton.dtsi"
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	compatible = "arm,realview-eb";
 
 	chosen { };
@@ -38,6 +39,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		/* 128 MiB memory @ 0x0 */
 		reg = <0x00000000 0x08000000>;
 	};
diff --git a/arch/arm/boot/dts/arm-realview-pb1176.dts b/arch/arm/boot/dts/arm-realview-pb1176.dts
index f2a1d25eb6cf..cee2d7aab203 100644
--- a/arch/arm/boot/dts/arm-realview-pb1176.dts
+++ b/arch/arm/boot/dts/arm-realview-pb1176.dts
@@ -23,9 +23,10 @@
 /dts-v1/;
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/gpio/gpio.h>
-#include "skeleton.dtsi"
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	model = "ARM RealView PB1176";
 	compatible = "arm,realview-pb1176";
 
@@ -40,6 +41,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		/* 128 MiB memory @ 0x0 */
 		reg = <0x00000000 0x08000000>;
 	};
diff --git a/arch/arm/boot/dts/arm-realview-pb11mp.dts b/arch/arm/boot/dts/arm-realview-pb11mp.dts
index 7f9cbdf33a51..63d71a1d8282 100644
--- a/arch/arm/boot/dts/arm-realview-pb11mp.dts
+++ b/arch/arm/boot/dts/arm-realview-pb11mp.dts
@@ -23,9 +23,10 @@
 /dts-v1/;
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/gpio/gpio.h>
-#include "skeleton.dtsi"
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	model = "ARM RealView PB11MPcore";
 	compatible = "arm,realview-pb11mp";
 
@@ -39,6 +40,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		/*
 		 * The PB11MPCore has 512 MiB memory @ 0x70000000
 		 * and the first 256 are also remapped @ 0x00000000
diff --git a/arch/arm/boot/dts/arm-realview-pbx.dtsi b/arch/arm/boot/dts/arm-realview-pbx.dtsi
index 916a97734f84..a81e9c282432 100644
--- a/arch/arm/boot/dts/arm-realview-pbx.dtsi
+++ b/arch/arm/boot/dts/arm-realview-pbx.dtsi
@@ -22,9 +22,10 @@
 
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/gpio/gpio.h>
-#include "skeleton.dtsi"
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	compatible = "arm,realview-pbx";
 
 	chosen { };
@@ -39,6 +40,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		/* 128 MiB memory @ 0x0 */
 		reg = <0x00000000 0x08000000>;
 	};
diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index 929459c42760..746887f7be5a 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -9,13 +9,15 @@
  * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
  */
 
-#include "skeleton.dtsi"
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 
 #define MBUS_ID(target,attributes) (((target) << 24) | ((attributes) << 16))
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
 	model = "Marvell Armada 38x family SoC";
 	compatible = "marvell,armada380";
 
diff --git a/arch/arm/boot/dts/armada-39x.dtsi b/arch/arm/boot/dts/armada-39x.dtsi
index f0c949831efb..b1b86934c688 100644
--- a/arch/arm/boot/dts/armada-39x.dtsi
+++ b/arch/arm/boot/dts/armada-39x.dtsi
@@ -7,13 +7,14 @@
  * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
  */
 
-#include "skeleton.dtsi"
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 
 #define MBUS_ID(target,attributes) (((target) << 24) | ((attributes) << 16))
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	model = "Marvell Armada 39x family SoC";
 	compatible = "marvell,armada390";
 
diff --git a/arch/arm/boot/dts/artpec6.dtsi b/arch/arm/boot/dts/artpec6.dtsi
index 3e4115c2cd75..037157e6c5ee 100644
--- a/arch/arm/boot/dts/artpec6.dtsi
+++ b/arch/arm/boot/dts/artpec6.dtsi
@@ -43,9 +43,10 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/dma/nbpfaxi.h>
 #include <dt-bindings/clock/axis,artpec6-clkctrl.h>
-#include "skeleton.dtsi"
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	compatible = "axis,artpec6";
 	interrupt-parent = <&intc>;
 
diff --git a/arch/arm/boot/dts/at91rm9200.dtsi b/arch/arm/boot/dts/at91rm9200.dtsi
index 2ad69a7fbc00..5a882a053816 100644
--- a/arch/arm/boot/dts/at91rm9200.dtsi
+++ b/arch/arm/boot/dts/at91rm9200.dtsi
@@ -10,13 +10,14 @@
  * Licensed under GPLv2 or later.
  */
 
-#include "skeleton.dtsi"
 #include <dt-bindings/pinctrl/at91.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/clock/at91.h>
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	model = "Atmel AT91RM9200 family SoC";
 	compatible = "atmel,at91rm9200";
 	interrupt-parent = <&aic>;
@@ -49,6 +50,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0x20000000 0x04000000>;
 	};
 
diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index 9118e29b6d6a..ebb6a98a6f60 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -8,13 +8,14 @@
  * Licensed under GPLv2 or later.
  */
 
-#include "skeleton.dtsi"
 #include <dt-bindings/pinctrl/at91.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/clock/at91.h>
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	model = "Atmel AT91SAM9260 family SoC";
 	compatible = "atmel,at91sam9260";
 	interrupt-parent = <&aic>;
@@ -46,6 +47,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0x20000000 0x04000000>;
 	};
 
diff --git a/arch/arm/boot/dts/at91sam9261.dtsi b/arch/arm/boot/dts/at91sam9261.dtsi
index 33f09d5ea020..bcc9d51f6c5f 100644
--- a/arch/arm/boot/dts/at91sam9261.dtsi
+++ b/arch/arm/boot/dts/at91sam9261.dtsi
@@ -6,13 +6,14 @@
  * Licensed under GPLv2 only.
  */
 
-#include "skeleton.dtsi"
 #include <dt-bindings/pinctrl/at91.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/clock/at91.h>
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	model = "Atmel AT91SAM9261 family SoC";
 	compatible = "atmel,at91sam9261";
 	interrupt-parent = <&aic>;
@@ -43,6 +44,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0x20000000 0x08000000>;
 	};
 
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index af68a86c9973..0a7cb5655ed8 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -6,13 +6,14 @@
  * Licensed under GPLv2 only.
  */
 
-#include "skeleton.dtsi"
 #include <dt-bindings/pinctrl/at91.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/clock/at91.h>
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	model = "Atmel AT91SAM9263 family SoC";
 	compatible = "atmel,at91sam9263";
 	interrupt-parent = <&aic>;
@@ -45,6 +46,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0x20000000 0x08000000>;
 	};
 
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index d16db1fa7e15..f36819607131 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -9,7 +9,6 @@
  * Licensed under GPLv2 or later.
  */
 
-#include "skeleton.dtsi"
 #include <dt-bindings/dma/at91.h>
 #include <dt-bindings/pinctrl/at91.h>
 #include <dt-bindings/interrupt-controller/irq.h>
@@ -17,6 +16,8 @@
 #include <dt-bindings/clock/at91.h>
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	model = "Atmel AT91SAM9G45 family SoC";
 	compatible = "atmel,at91sam9g45";
 	interrupt-parent = <&aic>;
@@ -51,6 +52,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0x70000000 0x10000000>;
 	};
 
diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index 37cb81f457b5..f71d65e6e510 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -7,7 +7,6 @@
  * Licensed under GPLv2 or later.
  */
 
-#include "skeleton.dtsi"
 #include <dt-bindings/dma/at91.h>
 #include <dt-bindings/pinctrl/at91.h>
 #include <dt-bindings/interrupt-controller/irq.h>
@@ -15,6 +14,8 @@
 #include <dt-bindings/clock/at91.h>
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	model = "Atmel AT91SAM9N12 SoC";
 	compatible = "atmel,at91sam9n12";
 	interrupt-parent = <&aic>;
@@ -47,6 +48,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0x20000000 0x10000000>;
 	};
 
diff --git a/arch/arm/boot/dts/at91sam9rl.dtsi b/arch/arm/boot/dts/at91sam9rl.dtsi
index 8fb22030f00b..c799cb61f809 100644
--- a/arch/arm/boot/dts/at91sam9rl.dtsi
+++ b/arch/arm/boot/dts/at91sam9rl.dtsi
@@ -7,7 +7,6 @@
  * Licensed under GPLv2 or later.
  */
 
-#include "skeleton.dtsi"
 #include <dt-bindings/pinctrl/at91.h>
 #include <dt-bindings/clock/at91.h>
 #include <dt-bindings/interrupt-controller/irq.h>
@@ -15,6 +14,8 @@
 #include <dt-bindings/pwm/pwm.h>
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	model = "Atmel AT91SAM9RL family SoC";
 	compatible = "atmel,at91sam9rl", "atmel,at91sam9";
 	interrupt-parent = <&aic>;
@@ -48,6 +49,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0x20000000 0x04000000>;
 	};
 
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 11c0ef102ab1..66ee148224dd 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -9,7 +9,6 @@
  * Licensed under GPLv2 or later.
  */
 
-#include "skeleton.dtsi"
 #include <dt-bindings/dma/at91.h>
 #include <dt-bindings/pinctrl/at91.h>
 #include <dt-bindings/interrupt-controller/irq.h>
@@ -17,6 +16,8 @@
 #include <dt-bindings/clock/at91.h>
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	model = "Atmel AT91SAM9x5 family SoC";
 	compatible = "atmel,at91sam9x5";
 	interrupt-parent = <&aic>;
@@ -49,6 +50,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0x20000000 0x10000000>;
 	};
 
diff --git a/arch/arm/boot/dts/atlas6-evb.dts b/arch/arm/boot/dts/atlas6-evb.dts
index ab042ca8dea1..40882419309d 100644
--- a/arch/arm/boot/dts/atlas6-evb.dts
+++ b/arch/arm/boot/dts/atlas6-evb.dts
@@ -15,6 +15,7 @@
 	compatible = "sirf,atlas6-cb", "sirf,atlas6";
 
 	memory {
+		device_type = "memory";
 		reg = <0x00000000 0x20000000>;
 	};
 
diff --git a/arch/arm/boot/dts/atlas6.dtsi b/arch/arm/boot/dts/atlas6.dtsi
index 29598667420b..5587b98032a3 100644
--- a/arch/arm/boot/dts/atlas6.dtsi
+++ b/arch/arm/boot/dts/atlas6.dtsi
@@ -6,7 +6,6 @@
  * Licensed under GPLv2 or later.
  */
 
-/include/ "skeleton.dtsi"
 / {
 	compatible = "sirf,atlas6";
 	#address-cells = <1>;
diff --git a/arch/arm/boot/dts/atlas7.dtsi b/arch/arm/boot/dts/atlas7.dtsi
index 83449b33de6b..f3de9af35b4d 100644
--- a/arch/arm/boot/dts/atlas7.dtsi
+++ b/arch/arm/boot/dts/atlas7.dtsi
@@ -6,7 +6,6 @@
  * Licensed under GPLv2 or later.
  */
 
-/include/ "skeleton.dtsi"
 / {
 	compatible = "sirf,atlas7";
 	#address-cells = <1>;
diff --git a/arch/arm/boot/dts/axm55xx.dtsi b/arch/arm/boot/dts/axm55xx.dtsi
index 47799f59faa5..2a93d3ee3b66 100644
--- a/arch/arm/boot/dts/axm55xx.dtsi
+++ b/arch/arm/boot/dts/axm55xx.dtsi
@@ -12,9 +12,9 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/lsi,axm5516-clks.h>
 
-#include "skeleton64.dtsi"
-
 / {
+	#address-cells = <2>;
+	#size-cells = <2>;
 	interrupt-parent = <&gic>;
 
 	aliases {
diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index 253df7170a4e..5f7b46503a51 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -34,9 +34,9 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/clock/bcm-cygnus.h>
 
-#include "skeleton.dtsi"
-
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	compatible = "brcm,cygnus";
 	model = "Broadcom Cygnus SoC";
 	interrupt-parent = <&gic>;
@@ -45,6 +45,11 @@
 		ethernet0 = &eth0;
 	};
 
+	memory {
+		device_type = "memory";
+		reg = <0 0>;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index 2fd111d9d59c..e0b9539c3cab 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -34,9 +34,9 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/clock/bcm-nsp.h>
 
-#include "skeleton.dtsi"
-
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	compatible = "brcm,nsp";
 	model = "Broadcom Northstar Plus SoC";
 	interrupt-parent = <&gic>;
diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
index db7cded1b7ad..b99c2e579622 100644
--- a/arch/arm/boot/dts/bcm11351.dtsi
+++ b/arch/arm/boot/dts/bcm11351.dtsi
@@ -16,9 +16,9 @@
 
 #include "dt-bindings/clock/bcm281xx.h"
 
-#include "skeleton.dtsi"
-
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	model = "BCM11351 SoC";
 	compatible = "brcm,bcm11351";
 	interrupt-parent = <&gic>;
diff --git a/arch/arm/boot/dts/bcm21664-garnet.dts b/arch/arm/boot/dts/bcm21664-garnet.dts
index e87cb26ddf84..8b045cfab64b 100644
--- a/arch/arm/boot/dts/bcm21664-garnet.dts
+++ b/arch/arm/boot/dts/bcm21664-garnet.dts
@@ -22,6 +22,7 @@
 	compatible = "brcm,bcm21664-garnet", "brcm,bcm21664";
 
 	memory {
+		device_type = "memory";
 		reg = <0x80000000 0x40000000>; /* 1 GB */
 	};
 
diff --git a/arch/arm/boot/dts/bcm21664.dtsi b/arch/arm/boot/dts/bcm21664.dtsi
index 266f2611dc22..758daa334148 100644
--- a/arch/arm/boot/dts/bcm21664.dtsi
+++ b/arch/arm/boot/dts/bcm21664.dtsi
@@ -16,9 +16,9 @@
 
 #include "dt-bindings/clock/bcm21664.h"
 
-#include "skeleton.dtsi"
-
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	model = "BCM21664 SoC";
 	compatible = "brcm,bcm21664";
 	interrupt-parent = <&gic>;
diff --git a/arch/arm/boot/dts/bcm23550-sparrow.dts b/arch/arm/boot/dts/bcm23550-sparrow.dts
index 4d525ccb48c8..1c66b15f3013 100644
--- a/arch/arm/boot/dts/bcm23550-sparrow.dts
+++ b/arch/arm/boot/dts/bcm23550-sparrow.dts
@@ -46,6 +46,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0x80000000 0x20000000>; /* 512 MB */
 	};
 };
diff --git a/arch/arm/boot/dts/bcm23550.dtsi b/arch/arm/boot/dts/bcm23550.dtsi
index a7a643f38385..701198f5f498 100644
--- a/arch/arm/boot/dts/bcm23550.dtsi
+++ b/arch/arm/boot/dts/bcm23550.dtsi
@@ -36,9 +36,9 @@
 /* BCM23550 and BCM21664 have almost identical clocks */
 #include "dt-bindings/clock/bcm21664.h"
 
-#include "skeleton.dtsi"
-
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	model = "BCM23550 SoC";
 	compatible = "brcm,bcm23550";
 	interrupt-parent = <&gic>;
diff --git a/arch/arm/boot/dts/bcm28155-ap.dts b/arch/arm/boot/dts/bcm28155-ap.dts
index 9ce91dd60cb6..fbfca83bd28f 100644
--- a/arch/arm/boot/dts/bcm28155-ap.dts
+++ b/arch/arm/boot/dts/bcm28155-ap.dts
@@ -22,6 +22,7 @@
 	compatible = "brcm,bcm28155-ap", "brcm,bcm11351";
 
 	memory {
+		device_type = "memory";
 		reg = <0x80000000 0x40000000>; /* 1 GB */
 	};
 
diff --git a/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts b/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts
index 76a2bab3bc6f..fe842f2f1ca7 100644
--- a/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts
+++ b/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts
@@ -20,6 +20,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0x00000000 0x08000000
 		       0x88000000 0x08000000>;
 	};
diff --git a/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts b/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts
index 69e3570e03dd..6fcbb0509ba0 100644
--- a/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts
+++ b/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts
@@ -20,6 +20,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0x00000000 0x08000000
 		       0x88000000 0x08000000>;
 	};
diff --git a/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts b/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts
index 0f6f0fe13bfb..b3e8cc90b13f 100644
--- a/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts
+++ b/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts
@@ -20,6 +20,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0x00000000 0x08000000
 		       0x88000000 0x08000000>;
 	};
diff --git a/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dts b/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dts
index f77089744996..fdeaa895512f 100644
--- a/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dts
+++ b/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dts
@@ -16,6 +16,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0x00000000 0x08000000>;
 	};
 
diff --git a/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dts b/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dts
index 4d427863756f..0d510cb15ec3 100644
--- a/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dts
+++ b/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dts
@@ -17,6 +17,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0x00000000 0x08000000>;
 	};
 
diff --git a/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dts b/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dts
index 189cc3dcd6ef..962e89edba11 100644
--- a/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dts
+++ b/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dts
@@ -16,6 +16,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0x00000000 0x08000000>;
 	};
 
diff --git a/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts b/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
index 03c1ab188576..658a56ff8a5c 100644
--- a/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
+++ b/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
@@ -20,6 +20,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0x00000000 0x08000000
 		       0x88000000 0x08000000>;
 	};
diff --git a/arch/arm/boot/dts/bcm47094-linksys-panamera.dts b/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
index 36efe410dcd7..5fd47eec4407 100644
--- a/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
+++ b/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
@@ -17,6 +17,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0x00000000 0x08000000
 		       0x88000000 0x08000000>;
 	};
diff --git a/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dts b/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dts
index 3e5e9972cd97..6604be6ff0a0 100644
--- a/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dts
+++ b/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dts
@@ -17,6 +17,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0x00000000 0x08000000
 		       0x88000000 0x18000000>;
 	};
diff --git a/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dts b/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dts
index 7fd85475893d..567ebbd5a0e9 100644
--- a/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dts
+++ b/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dts
@@ -16,6 +16,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0x00000000 0x08000000>;
 	};
 
diff --git a/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dts b/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dts
index 7acbecd42950..ac2d136ed334 100644
--- a/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dts
+++ b/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dts
@@ -17,6 +17,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0x00000000 0x08000000
 		       0x88000000 0x18000000>;
 	};
diff --git a/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts b/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts
index f4558d9d2769..74371e821b1a 100644
--- a/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts
+++ b/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts
@@ -17,6 +17,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0x00000000 0x08000000
 		       0x88000000 0x08000000>;
 	};
diff --git a/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dts b/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dts
index bdad7267255a..b44af63ee310 100644
--- a/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dts
+++ b/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dts
@@ -17,6 +17,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0x00000000 0x08000000
 		       0x88000000 0x18000000>;
 	};
diff --git a/arch/arm/boot/dts/bcm47094-netgear-r8500.dts b/arch/arm/boot/dts/bcm47094-netgear-r8500.dts
index 30719380b6c0..eebc0d43e220 100644
--- a/arch/arm/boot/dts/bcm47094-netgear-r8500.dts
+++ b/arch/arm/boot/dts/bcm47094-netgear-r8500.dts
@@ -17,6 +17,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0x00000000 0x08000000
 		       0x88000000 0x18000000>;
 	};
diff --git a/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts b/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts
index 74c83b0ca54e..1a5ec22a172c 100644
--- a/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts
+++ b/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts
@@ -17,6 +17,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0x00000000 0x08000000>;
 	};
 
diff --git a/arch/arm/boot/dts/bcm47189-luxul-xap-810.dts b/arch/arm/boot/dts/bcm47189-luxul-xap-810.dts
index 214df18f3a75..42c1e1f3a4d5 100644
--- a/arch/arm/boot/dts/bcm47189-luxul-xap-810.dts
+++ b/arch/arm/boot/dts/bcm47189-luxul-xap-810.dts
@@ -17,6 +17,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0x00000000 0x08000000>;
 	};
 
diff --git a/arch/arm/boot/dts/bcm47189-tenda-ac9.dts b/arch/arm/boot/dts/bcm47189-tenda-ac9.dts
index 19e61b5b066c..4c891c571315 100644
--- a/arch/arm/boot/dts/bcm47189-tenda-ac9.dts
+++ b/arch/arm/boot/dts/bcm47189-tenda-ac9.dts
@@ -17,6 +17,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0x00000000 0x08000000>;
 	};
 
diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
index 7a5c188c2676..4dd63076e1ca 100644
--- a/arch/arm/boot/dts/bcm5301x.dtsi
+++ b/arch/arm/boot/dts/bcm5301x.dtsi
@@ -13,9 +13,10 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
-#include "skeleton.dtsi"
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	interrupt-parent = <&gic>;
 
 	chipcommonA {
diff --git a/arch/arm/boot/dts/bcm53340-ubnt-unifi-switch8.dts b/arch/arm/boot/dts/bcm53340-ubnt-unifi-switch8.dts
index 431cda514230..2e7fda9b998c 100644
--- a/arch/arm/boot/dts/bcm53340-ubnt-unifi-switch8.dts
+++ b/arch/arm/boot/dts/bcm53340-ubnt-unifi-switch8.dts
@@ -20,6 +20,7 @@
 	};
 
 	memory@0 {
+		device_type = "memory";
 		reg = <0x00000000 0x08000000>,
 		      <0x68000000 0x08000000>;
 	};
diff --git a/arch/arm/boot/dts/bcm53573.dtsi b/arch/arm/boot/dts/bcm53573.dtsi
index 453a2a37dabd..266ab529bfcc 100644
--- a/arch/arm/boot/dts/bcm53573.dtsi
+++ b/arch/arm/boot/dts/bcm53573.dtsi
@@ -8,9 +8,10 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
-#include "skeleton.dtsi"
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	interrupt-parent = <&gic>;
 
 	aliases {
diff --git a/arch/arm/boot/dts/bcm63138.dtsi b/arch/arm/boot/dts/bcm63138.dtsi
index 6df61518776f..a5afba410099 100644
--- a/arch/arm/boot/dts/bcm63138.dtsi
+++ b/arch/arm/boot/dts/bcm63138.dtsi
@@ -6,9 +6,9 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 
-#include "skeleton.dtsi"
-
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	compatible = "brcm,bcm63138";
 	model = "Broadcom BCM63138 DSL SoC";
 	interrupt-parent = <&gic>;
diff --git a/arch/arm/boot/dts/bcm7445.dtsi b/arch/arm/boot/dts/bcm7445.dtsi
index c859aa6f358c..504a63236a5e 100644
--- a/arch/arm/boot/dts/bcm7445.dtsi
+++ b/arch/arm/boot/dts/bcm7445.dtsi
@@ -1,8 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
-#include "skeleton.dtsi"
-
 / {
 	#address-cells = <2>;
 	#size-cells = <2>;
diff --git a/arch/arm/boot/dts/bcm947189acdbmr.dts b/arch/arm/boot/dts/bcm947189acdbmr.dts
index ef263412fea5..4991700ae6b0 100644
--- a/arch/arm/boot/dts/bcm947189acdbmr.dts
+++ b/arch/arm/boot/dts/bcm947189acdbmr.dts
@@ -18,6 +18,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0x00000000 0x08000000>;
 	};
 
diff --git a/arch/arm/boot/dts/bcm953012er.dts b/arch/arm/boot/dts/bcm953012er.dts
index 17f63c7a0437..250a1d6f2d05 100644
--- a/arch/arm/boot/dts/bcm953012er.dts
+++ b/arch/arm/boot/dts/bcm953012er.dts
@@ -40,6 +40,7 @@
 	compatible = "brcm,bcm953012er", "brcm,brcm53012", "brcm,bcm4708";
 
 	memory {
+		device_type = "memory";
 		reg = <0x00000000 0x8000000>;
 	};
 
diff --git a/arch/arm/boot/dts/bcm953012hr.dts b/arch/arm/boot/dts/bcm953012hr.dts
index 11b0f5ed99e6..9140be7ec053 100644
--- a/arch/arm/boot/dts/bcm953012hr.dts
+++ b/arch/arm/boot/dts/bcm953012hr.dts
@@ -46,6 +46,7 @@
 	};
 
 	memory@80000000 {
+		device_type = "memory";
 		reg = <0x80000000 0x10000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/bcm953012k.dts b/arch/arm/boot/dts/bcm953012k.dts
index e798055d6989..52c4c6c9d3f1 100644
--- a/arch/arm/boot/dts/bcm953012k.dts
+++ b/arch/arm/boot/dts/bcm953012k.dts
@@ -44,6 +44,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0x80000000 0x10000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/cx92755.dtsi b/arch/arm/boot/dts/cx92755.dtsi
index a5a23c376418..d2e8f36f8c60 100644
--- a/arch/arm/boot/dts/cx92755.dtsi
+++ b/arch/arm/boot/dts/cx92755.dtsi
@@ -44,9 +44,9 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include "skeleton.dtsi"
-
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	compatible = "cnxt,cx92755";
 
 	interrupt-parent = <&intc>;
diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 250ad0535e8c..2e8a3977219f 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -1,12 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
-/include/ "skeleton.dtsi"
-
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 
 #define MBUS_ID(target,attributes) (((target) << 24) | ((attributes) << 16))
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	compatible = "marvell,dove";
 	model = "Marvell Armada 88AP510 SoC";
 	interrupt-parent = <&intc>;
diff --git a/arch/arm/boot/dts/ep7209.dtsi b/arch/arm/boot/dts/ep7209.dtsi
index aaf1261d2ee4..0e74222a5eae 100644
--- a/arch/arm/boot/dts/ep7209.dtsi
+++ b/arch/arm/boot/dts/ep7209.dtsi
@@ -6,11 +6,11 @@
 
 /dts-v1/;
 
-#include "skeleton.dtsi"
-
 #include <dt-bindings/clock/clps711x-clock.h>
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	model = "Cirrus Logic EP7209";
 	compatible = "cirrus,ep7209";
 
diff --git a/arch/arm/boot/dts/ep7211-edb7211.dts b/arch/arm/boot/dts/ep7211-edb7211.dts
index bc9d5b697452..3475c7777cbc 100644
--- a/arch/arm/boot/dts/ep7211-edb7211.dts
+++ b/arch/arm/boot/dts/ep7211-edb7211.dts
@@ -12,6 +12,7 @@
 	compatible = "cirrus,edb7211", "cirrus,ep7211", "cirrus,ep7209";
 
 	memory {
+		device_type = "memory";
 		reg = <0xc0000000 0x02000000>;
 	};
 
diff --git a/arch/arm/boot/dts/integrator.dtsi b/arch/arm/boot/dts/integrator.dtsi
index 4d58638d104b..1612a869a4f7 100644
--- a/arch/arm/boot/dts/integrator.dtsi
+++ b/arch/arm/boot/dts/integrator.dtsi
@@ -3,9 +3,15 @@
  * SoC core Device Tree for the ARM Integrator platforms
  */
 
-/include/ "skeleton.dtsi"
-
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x0>;
+	};
+
 	core-module@10000000 {
 		compatible = "arm,core-module-integrator", "syscon", "simple-mfd";
 		reg = <0x10000000 0x200>;
diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index 81c7eda2c442..2161e23bd98e 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -1,11 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
-/include/ "skeleton.dtsi"
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/gpio.h>
 
 #define MBUS_ID(target,attributes) (((target) << 24) | ((attributes) << 16))
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	compatible = "marvell,kirkwood";
 	interrupt-parent = <&intc>;
 
diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
index b7303a4e4236..44b468e4c37a 100644
--- a/arch/arm/boot/dts/lpc32xx.dtsi
+++ b/arch/arm/boot/dts/lpc32xx.dtsi
@@ -11,12 +11,12 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
-#include "skeleton.dtsi"
-
 #include <dt-bindings/clock/lpc32xx-clock.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	compatible = "nxp,lpc3220";
 	interrupt-parent = <&mic>;
 
diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index bdd6e66a79ad..41b5b68280fb 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -45,11 +45,12 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include "skeleton64.dtsi"
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/thermal/thermal.h>
 
 / {
+	#address-cells = <2>;
+	#size-cells = <2>;
 	compatible = "fsl,ls1021a";
 	interrupt-parent = <&gic>;
 
@@ -88,6 +89,11 @@
 		};
 	};
 
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x0>;
+	};
+
 	sysclk: sysclk {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
index 0d9faf1a51ea..9f07a6f2ac59 100644
--- a/arch/arm/boot/dts/meson.dtsi
+++ b/arch/arm/boot/dts/meson.dtsi
@@ -47,9 +47,10 @@
 
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
-/include/ "skeleton.dtsi"
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	interrupt-parent = <&gic>;
 
 	L2: l2-cache-controller@c4200000 {
diff --git a/arch/arm/boot/dts/meson6-atv1200.dts b/arch/arm/boot/dts/meson6-atv1200.dts
index 9444b0d9628f..b4f456fb79c1 100644
--- a/arch/arm/boot/dts/meson6-atv1200.dts
+++ b/arch/arm/boot/dts/meson6-atv1200.dts
@@ -57,6 +57,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0x40000000 0x80000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/meson8-minix-neo-x8.dts b/arch/arm/boot/dts/meson8-minix-neo-x8.dts
index 8bceb8d343f6..00f249b68737 100644
--- a/arch/arm/boot/dts/meson8-minix-neo-x8.dts
+++ b/arch/arm/boot/dts/meson8-minix-neo-x8.dts
@@ -53,6 +53,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0x40000000 0x80000000>;
 	};
 
diff --git a/arch/arm/boot/dts/meson8b-ec100.dts b/arch/arm/boot/dts/meson8b-ec100.dts
index 0872f6e3abf5..7b6bfb9e805d 100644
--- a/arch/arm/boot/dts/meson8b-ec100.dts
+++ b/arch/arm/boot/dts/meson8b-ec100.dts
@@ -23,6 +23,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0x40000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/meson8b-mxq.dts b/arch/arm/boot/dts/meson8b-mxq.dts
index c7fdaeabbe7b..d3a7c4e19a2c 100644
--- a/arch/arm/boot/dts/meson8b-mxq.dts
+++ b/arch/arm/boot/dts/meson8b-mxq.dts
@@ -56,6 +56,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0x40000000 0x40000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
index 58669abda259..4de2b973513d 100644
--- a/arch/arm/boot/dts/meson8b-odroidc1.dts
+++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
@@ -62,6 +62,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0x40000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/meson8m2-mxiii-plus.dts b/arch/arm/boot/dts/meson8m2-mxiii-plus.dts
index f5853610b20b..32c7a460f21b 100644
--- a/arch/arm/boot/dts/meson8m2-mxiii-plus.dts
+++ b/arch/arm/boot/dts/meson8m2-mxiii-plus.dts
@@ -28,6 +28,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0x40000000 0x80000000>;
 	};
 
diff --git a/arch/arm/boot/dts/mmp2-brownstone.dts b/arch/arm/boot/dts/mmp2-brownstone.dts
index 350208c5e1ed..3da038ba5733 100644
--- a/arch/arm/boot/dts/mmp2-brownstone.dts
+++ b/arch/arm/boot/dts/mmp2-brownstone.dts
@@ -19,6 +19,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0x00000000 0x08000000>;
 	};
 
diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index 766bbb8495b6..f16903f9f459 100644
--- a/arch/arm/boot/dts/mmp2.dtsi
+++ b/arch/arm/boot/dts/mmp2.dtsi
@@ -7,10 +7,12 @@
  *  publishhed by the Free Software Foundation.
  */
 
-#include "skeleton.dtsi"
 #include <dt-bindings/clock/marvell,mmp2.h>
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
 	aliases {
 		serial0 = &uart1;
 		serial1 = &uart2;
diff --git a/arch/arm/boot/dts/moxart.dtsi b/arch/arm/boot/dts/moxart.dtsi
index da7b3237bfe9..cbf17656bcc7 100644
--- a/arch/arm/boot/dts/moxart.dtsi
+++ b/arch/arm/boot/dts/moxart.dtsi
@@ -5,10 +5,11 @@
  * Licensed under GPLv2 or later.
  */
 
-/include/ "skeleton.dtsi"
 #include <dt-bindings/interrupt-controller/irq.h>
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	compatible = "moxa,moxart";
 	model = "MOXART";
 	interrupt-parent = <&intc>;
diff --git a/arch/arm/boot/dts/mt2701-evb.dts b/arch/arm/boot/dts/mt2701-evb.dts
index be0edb3dae6c..88f8fd22302a 100644
--- a/arch/arm/boot/dts/mt2701-evb.dts
+++ b/arch/arm/boot/dts/mt2701-evb.dts
@@ -13,6 +13,7 @@
 	compatible = "mediatek,mt2701-evb", "mediatek,mt2701";
 
 	memory {
+		device_type = "memory";
 		reg = <0 0x80000000 0 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
index 180377e56ef4..51e1305c6471 100644
--- a/arch/arm/boot/dts/mt2701.dtsi
+++ b/arch/arm/boot/dts/mt2701.dtsi
@@ -12,10 +12,11 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/memory/mt2701-larb-port.h>
 #include <dt-bindings/reset/mt2701-resets.h>
-#include "skeleton64.dtsi"
 #include "mt2701-pinfunc.h"
 
 / {
+	#address-cells = <2>;
+	#size-cells = <2>;
 	compatible = "mediatek,mt2701";
 	interrupt-parent = <&cirq>;
 
diff --git a/arch/arm/boot/dts/mt6580-evbp1.dts b/arch/arm/boot/dts/mt6580-evbp1.dts
index ca137897ed60..755a0774a8ee 100644
--- a/arch/arm/boot/dts/mt6580-evbp1.dts
+++ b/arch/arm/boot/dts/mt6580-evbp1.dts
@@ -22,6 +22,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0x80000000 0x20000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/mt6580.dtsi b/arch/arm/boot/dts/mt6580.dtsi
index 2bdc5ed12fca..9e17698c0609 100644
--- a/arch/arm/boot/dts/mt6580.dtsi
+++ b/arch/arm/boot/dts/mt6580.dtsi
@@ -7,7 +7,6 @@
 
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
-#include "skeleton.dtsi"
 
 / {
 	compatible = "mediatek,mt6580";
diff --git a/arch/arm/boot/dts/mt6589-aquaris5.dts b/arch/arm/boot/dts/mt6589-aquaris5.dts
index 7bbaa1279a26..1e7079a3b449 100644
--- a/arch/arm/boot/dts/mt6589-aquaris5.dts
+++ b/arch/arm/boot/dts/mt6589-aquaris5.dts
@@ -18,6 +18,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0x80000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/mt6589.dtsi b/arch/arm/boot/dts/mt6589.dtsi
index 28df8495686a..f3ccb70c0779 100644
--- a/arch/arm/boot/dts/mt6589.dtsi
+++ b/arch/arm/boot/dts/mt6589.dtsi
@@ -7,9 +7,10 @@
 
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
-#include "skeleton.dtsi"
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	compatible = "mediatek,mt6589";
 	interrupt-parent = <&sysirq>;
 
diff --git a/arch/arm/boot/dts/mt6592-evb.dts b/arch/arm/boot/dts/mt6592-evb.dts
index 02849f6548e3..5e00c1cca2d1 100644
--- a/arch/arm/boot/dts/mt6592-evb.dts
+++ b/arch/arm/boot/dts/mt6592-evb.dts
@@ -13,7 +13,7 @@
 	compatible = "mediatek,mt6592-evb", "mediatek,mt6592";
 
 	memory {
+		device_type = "memory";
 		reg = <0x80000000 0x40000000>;
 	};
 };
-
diff --git a/arch/arm/boot/dts/mt6592.dtsi b/arch/arm/boot/dts/mt6592.dtsi
index 8696ac891d60..3716f8db951c 100644
--- a/arch/arm/boot/dts/mt6592.dtsi
+++ b/arch/arm/boot/dts/mt6592.dtsi
@@ -7,9 +7,10 @@
 
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
-#include "skeleton.dtsi"
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	compatible = "mediatek,mt6592";
 	interrupt-parent = <&sysirq>;
 
diff --git a/arch/arm/boot/dts/mt8127-moose.dts b/arch/arm/boot/dts/mt8127-moose.dts
index 308829b2da86..560687af87dc 100644
--- a/arch/arm/boot/dts/mt8127-moose.dts
+++ b/arch/arm/boot/dts/mt8127-moose.dts
@@ -13,6 +13,7 @@
 	compatible = "mediatek,mt8127-moose", "mediatek,mt8127";
 
 	memory {
+		device_type = "memory";
 		reg = <0 0x80000000 0 0x40000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/mt8127.dtsi b/arch/arm/boot/dts/mt8127.dtsi
index 3adfc6f7859c..aced173c2a52 100644
--- a/arch/arm/boot/dts/mt8127.dtsi
+++ b/arch/arm/boot/dts/mt8127.dtsi
@@ -7,9 +7,10 @@
 
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
-#include "skeleton64.dtsi"
 
 / {
+	#address-cells = <2>;
+	#size-cells = <2>;
 	compatible = "mediatek,mt8127";
 	interrupt-parent = <&sysirq>;
 
diff --git a/arch/arm/boot/dts/mt8135-evbp1.dts b/arch/arm/boot/dts/mt8135-evbp1.dts
index 0ace7a40a60d..f6147fe62f41 100644
--- a/arch/arm/boot/dts/mt8135-evbp1.dts
+++ b/arch/arm/boot/dts/mt8135-evbp1.dts
@@ -13,6 +13,7 @@
 	compatible = "mediatek,mt8135-evbp1", "mediatek,mt8135";
 
 	memory {
+		device_type = "memory";
 		reg = <0 0x80000000 0 0x40000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/mt8135.dtsi b/arch/arm/boot/dts/mt8135.dtsi
index 688069dc1533..0e4e835026db 100644
--- a/arch/arm/boot/dts/mt8135.dtsi
+++ b/arch/arm/boot/dts/mt8135.dtsi
@@ -9,10 +9,11 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/reset/mt8135-resets.h>
-#include "skeleton64.dtsi"
 #include "mt8135-pinfunc.h"
 
 / {
+	#address-cells = <2>;
+	#size-cells = <2>;
 	compatible = "mediatek,mt8135";
 	interrupt-parent = <&sysirq>;
 
diff --git a/arch/arm/boot/dts/nspire.dtsi b/arch/arm/boot/dts/nspire.dtsi
index 1a5ae4cd107f..5a3c1f9d1832 100644
--- a/arch/arm/boot/dts/nspire.dtsi
+++ b/arch/arm/boot/dts/nspire.dtsi
@@ -9,9 +9,9 @@
  *
  */
 
-/include/ "skeleton.dtsi"
-
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	interrupt-parent = <&intc>;
 
 	cpus {
diff --git a/arch/arm/boot/dts/orion5x-lacie-d2-network.dts b/arch/arm/boot/dts/orion5x-lacie-d2-network.dts
index 8c2449da6f00..422958d13d42 100644
--- a/arch/arm/boot/dts/orion5x-lacie-d2-network.dts
+++ b/arch/arm/boot/dts/orion5x-lacie-d2-network.dts
@@ -19,6 +19,7 @@
 	compatible = "lacie,d2-network", "marvell,orion5x-88f5182", "marvell,orion5x";
 
 	memory {
+		device_type = "memory";
 		reg = <0x00000000 0x4000000>; /* 64 MB */
 	};
 
diff --git a/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts b/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
index b545d0f228a5..0043e0040153 100644
--- a/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
+++ b/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
@@ -25,6 +25,7 @@
 	compatible = "lacie,ethernet-disk-mini-v2", "marvell,orion5x-88f5182", "marvell,orion5x";
 
 	memory {
+		device_type = "memory";
 		reg = <0x00000000 0x4000000>; /* 64 MB */
 	};
 
diff --git a/arch/arm/boot/dts/orion5x-lswsgl.dts b/arch/arm/boot/dts/orion5x-lswsgl.dts
index 0d97ded66257..2fbc17d6dfa4 100644
--- a/arch/arm/boot/dts/orion5x-lswsgl.dts
+++ b/arch/arm/boot/dts/orion5x-lswsgl.dts
@@ -55,6 +55,7 @@
 	compatible = "buffalo,lswsgl", "marvell,orion5x-88f5182", "marvell,orion5x";
 
 	memory {
+		device_type = "memory";
 		reg = <0x00000000 0x8000000>; /* 128 MB */
 	};
 
diff --git a/arch/arm/boot/dts/orion5x-maxtor-shared-storage-2.dts b/arch/arm/boot/dts/orion5x-maxtor-shared-storage-2.dts
index 0324cb54939d..0ca6208a267d 100644
--- a/arch/arm/boot/dts/orion5x-maxtor-shared-storage-2.dts
+++ b/arch/arm/boot/dts/orion5x-maxtor-shared-storage-2.dts
@@ -19,6 +19,7 @@
 	compatible = "maxtor,shared-storage-2", "marvell,orion5x-88f5182", "marvell,orion5x";
 
 	memory {
+		device_type = "memory";
 		reg = <0x00000000 0x4000000>; /* 64 MB */
 	};
 
diff --git a/arch/arm/boot/dts/orion5x-netgear-wnr854t.dts b/arch/arm/boot/dts/orion5x-netgear-wnr854t.dts
index 9f6ae4e1de06..ea081afa469d 100644
--- a/arch/arm/boot/dts/orion5x-netgear-wnr854t.dts
+++ b/arch/arm/boot/dts/orion5x-netgear-wnr854t.dts
@@ -21,6 +21,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0x00000000 0x2000000>; /* 32 MB */
 	};
 
diff --git a/arch/arm/boot/dts/orion5x-rd88f5182-nas.dts b/arch/arm/boot/dts/orion5x-rd88f5182-nas.dts
index d1817af53e0b..487324f7c54e 100644
--- a/arch/arm/boot/dts/orion5x-rd88f5182-nas.dts
+++ b/arch/arm/boot/dts/orion5x-rd88f5182-nas.dts
@@ -16,6 +16,7 @@
 	compatible = "marvell,rd-88f5182-nas", "marvell,orion5x-88f5182", "marvell,orion5x";
 
 	memory {
+		device_type = "memory";
 		reg = <0x00000000 0x4000000>; /* 64 MB */
 	};
 
diff --git a/arch/arm/boot/dts/orion5x.dtsi b/arch/arm/boot/dts/orion5x.dtsi
index fbccfbbab223..61e631b3fd8b 100644
--- a/arch/arm/boot/dts/orion5x.dtsi
+++ b/arch/arm/boot/dts/orion5x.dtsi
@@ -6,11 +6,11 @@
  * warranty of any kind, whether express or implied.
  */
 
-#include "skeleton.dtsi"
-
 #define MBUS_ID(target,attributes) (((target) << 24) | ((attributes) << 16))
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	model = "Marvell Orion5x SoC";
 	compatible = "marvell,orion5x";
 	interrupt-parent = <&intc>;
diff --git a/arch/arm/boot/dts/ox810se.dtsi b/arch/arm/boot/dts/ox810se.dtsi
index c2b48a1838eb..3a26650de4eb 100644
--- a/arch/arm/boot/dts/ox810se.dtsi
+++ b/arch/arm/boot/dts/ox810se.dtsi
@@ -6,11 +6,12 @@
  * Licensed under GPLv2 or later
  */
 
-/include/ "skeleton.dtsi"
 #include <dt-bindings/clock/oxsemi,ox810se.h>
 #include <dt-bindings/reset/oxsemi,ox810se.h>
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	compatible = "oxsemi,ox810se";
 
 	cpus {
@@ -25,6 +26,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		/* Max 256MB @ 0x48000000 */
 		reg = <0x48000000 0x10000000>;
 	};
diff --git a/arch/arm/boot/dts/ox820.dtsi b/arch/arm/boot/dts/ox820.dtsi
index 085bbd33eadc..f3239586f38d 100644
--- a/arch/arm/boot/dts/ox820.dtsi
+++ b/arch/arm/boot/dts/ox820.dtsi
@@ -6,12 +6,13 @@
  * Licensed under GPLv2 or later
  */
 
-/include/ "skeleton.dtsi"
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/oxsemi,ox820.h>
 #include <dt-bindings/reset/oxsemi,ox820.h>
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	compatible = "oxsemi,ox820";
 
 	cpus {
@@ -35,6 +36,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		/* Max 512MB @ 0x60000000 */
 		reg = <0x60000000 0x20000000>;
 	};
diff --git a/arch/arm/boot/dts/picoxcell-pc3x2.dtsi b/arch/arm/boot/dts/picoxcell-pc3x2.dtsi
index a1266cf8776c..291a28f34762 100644
--- a/arch/arm/boot/dts/picoxcell-pc3x2.dtsi
+++ b/arch/arm/boot/dts/picoxcell-pc3x2.dtsi
@@ -10,7 +10,6 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  */
-/include/ "skeleton.dtsi"
 / {
 	model = "Picochip picoXcell PC3X2";
 	compatible = "picochip,pc3x2";
diff --git a/arch/arm/boot/dts/picoxcell-pc3x3.dtsi b/arch/arm/boot/dts/picoxcell-pc3x3.dtsi
index d78cd207eca1..bf9a39ea76b0 100644
--- a/arch/arm/boot/dts/picoxcell-pc3x3.dtsi
+++ b/arch/arm/boot/dts/picoxcell-pc3x3.dtsi
@@ -10,7 +10,6 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  */
-/include/ "skeleton.dtsi"
 / {
 	model = "Picochip picoXcell PC3X3";
 	compatible = "picochip,pc3x3";
diff --git a/arch/arm/boot/dts/prima2-evb.dts b/arch/arm/boot/dts/prima2-evb.dts
index 57286b4e7b87..55594b3bbc99 100644
--- a/arch/arm/boot/dts/prima2-evb.dts
+++ b/arch/arm/boot/dts/prima2-evb.dts
@@ -15,6 +15,7 @@
 	compatible = "sirf,prima2", "sirf,prima2-cb";
 
 	memory {
+		device_type = "memory";
 		reg = <0x00000000 0x20000000>;
 	};
 
diff --git a/arch/arm/boot/dts/prima2.dtsi b/arch/arm/boot/dts/prima2.dtsi
index 1ca1a9aa953f..54d4f8850e22 100644
--- a/arch/arm/boot/dts/prima2.dtsi
+++ b/arch/arm/boot/dts/prima2.dtsi
@@ -6,7 +6,6 @@
  * Licensed under GPLv2 or later.
  */
 
-/include/ "skeleton.dtsi"
 / {
 	compatible = "sirf,prima2";
 	#address-cells = <1>;
diff --git a/arch/arm/boot/dts/pxa168.dtsi b/arch/arm/boot/dts/pxa168.dtsi
index b899e25cbb1b..7137f3550183 100644
--- a/arch/arm/boot/dts/pxa168.dtsi
+++ b/arch/arm/boot/dts/pxa168.dtsi
@@ -7,10 +7,12 @@
  *  publishhed by the Free Software Foundation.
  */
 
-#include "skeleton.dtsi"
 #include <dt-bindings/clock/marvell,pxa168.h>
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
 	aliases {
 		serial0 = &uart1;
 		serial1 = &uart2;
diff --git a/arch/arm/boot/dts/pxa2xx.dtsi b/arch/arm/boot/dts/pxa2xx.dtsi
index 080d5c5169b5..96e3f33d6bb2 100644
--- a/arch/arm/boot/dts/pxa2xx.dtsi
+++ b/arch/arm/boot/dts/pxa2xx.dtsi
@@ -6,7 +6,6 @@
  * Licensed under GPLv2 or later.
  */
 
-#include "skeleton.dtsi"
 #include "dt-bindings/clock/pxa-clock.h"
 
 #define PMGROUP(pin) #pin
@@ -29,6 +28,8 @@
 	}
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	model = "Marvell PXA2xx family SoC";
 	compatible = "marvell,pxa2xx";
 	interrupt-parent = <&pxairq>;
diff --git a/arch/arm/boot/dts/pxa910.dtsi b/arch/arm/boot/dts/pxa910.dtsi
index 0868f6729be1..c88553a8ee29 100644
--- a/arch/arm/boot/dts/pxa910.dtsi
+++ b/arch/arm/boot/dts/pxa910.dtsi
@@ -7,10 +7,12 @@
  *  publishhed by the Free Software Foundation.
  */
 
-#include "skeleton.dtsi"
 #include <dt-bindings/clock/marvell,pxa910.h>
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
 	aliases {
 		serial0 = &uart1;
 		serial1 = &uart2;
diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 48c3cf427610..1374c2e52c20 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /dts-v1/;
 
-#include "skeleton.dtsi"
 #include <dt-bindings/clock/qcom,gcc-msm8960.h>
 #include <dt-bindings/reset/qcom,gcc-msm8960.h>
 #include <dt-bindings/clock/qcom,mmcc-msm8960.h>
@@ -10,6 +9,8 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	model = "Qualcomm APQ8064";
 	compatible = "qcom,apq8064";
 	interrupt-parent = <&intc>;
@@ -94,6 +95,11 @@
 		};
 	};
 
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x0>;
+	};
+
 	thermal-zones {
 		cpu-thermal0 {
 			polling-delay-passive = <250>;
diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
index 0e1e98707e3f..1958e5347491 100644
--- a/arch/arm/boot/dts/qcom-apq8084.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
@@ -1,12 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 /dts-v1/;
 
-#include "skeleton.dtsi"
-
 #include <dt-bindings/clock/qcom,gcc-apq8084.h>
 #include <dt-bindings/gpio/gpio.h>
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	model = "Qualcomm APQ 8084";
 	compatible = "qcom,apq8084";
 	interrupt-parent = <&intc>;
@@ -87,6 +87,11 @@
 		};
 	};
 
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x0>;
+	};
+
 	firmware {
 		scm {
 			compatible = "qcom,scm";
diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index 2d56008d8d6b..707017412be2 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -13,12 +13,13 @@
 
 /dts-v1/;
 
-#include "skeleton.dtsi"
 #include <dt-bindings/clock/qcom,gcc-ipq4019.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	model = "Qualcomm Technologies, Inc. IPQ4019";
 	compatible = "qcom,ipq4019";
 	interrupt-parent = <&intc>;
@@ -133,6 +134,11 @@
  		};
 	};
 
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x0>;
+	};
+
 	pmu {
 		compatible = "arm,cortex-a7-pmu";
 		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(4) |
diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index f793cd1ad6d0..16c0da97932c 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /dts-v1/;
 
-#include "skeleton.dtsi"
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,gcc-ipq806x.h>
 #include <dt-bindings/clock/qcom,lcc-ipq806x.h>
@@ -11,6 +10,8 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	model = "Qualcomm IPQ8064";
 	compatible = "qcom,ipq8064";
 	interrupt-parent = <&intc>;
@@ -45,6 +46,11 @@
 		};
 	};
 
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x0>;
+	};
+
 	cpu-pmu {
 		compatible = "qcom,krait-pmu";
 		interrupts = <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) |
diff --git a/arch/arm/boot/dts/qcom-mdm9615-wp8548.dtsi b/arch/arm/boot/dts/qcom-mdm9615-wp8548.dtsi
index 7869898e392d..26b034bd19d2 100644
--- a/arch/arm/boot/dts/qcom-mdm9615-wp8548.dtsi
+++ b/arch/arm/boot/dts/qcom-mdm9615-wp8548.dtsi
@@ -50,6 +50,7 @@
 	compatible = "swir,wp8548", "qcom,mdm9615";
 
 	memory {
+		device_type = "memory";
 		reg = <0x48000000 0x7F00000>;
 	};
 };
diff --git a/arch/arm/boot/dts/qcom-mdm9615.dtsi b/arch/arm/boot/dts/qcom-mdm9615.dtsi
index c852b69229c9..e49f67ad5dbc 100644
--- a/arch/arm/boot/dts/qcom-mdm9615.dtsi
+++ b/arch/arm/boot/dts/qcom-mdm9615.dtsi
@@ -45,8 +45,6 @@
 
 /dts-v1/;
 
-/include/ "skeleton.dtsi"
-
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,gcc-mdm9615.h>
 #include <dt-bindings/reset/qcom,gcc-mdm9615.h>
@@ -54,6 +52,8 @@
 #include <dt-bindings/soc/qcom,gsbi.h>
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	model = "Qualcomm MDM9615";
 	compatible = "qcom,mdm9615";
 	interrupt-parent = <&intc>;
diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
index 70698941f64c..1c1a863fa0c2 100644
--- a/arch/arm/boot/dts/qcom-msm8660.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8660.dtsi
@@ -1,14 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0
 /dts-v1/;
 
-/include/ "skeleton.dtsi"
-
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,gcc-msm8660.h>
 #include <dt-bindings/soc/qcom,gsbi.h>
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	model = "Qualcomm MSM8660";
 	compatible = "qcom,msm8660";
 	interrupt-parent = <&intc>;
@@ -39,6 +39,11 @@
 		};
 	};
 
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x0>;
+	};
+
 	cpu-pmu {
 		compatible = "qcom,scorpion-mp-pmu";
 		interrupts = <1 9 0x304>;
diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
index 1733d8f40ab1..f2aeaccdc1ad 100644
--- a/arch/arm/boot/dts/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
@@ -1,14 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0
 /dts-v1/;
 
-/include/ "skeleton.dtsi"
-
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,gcc-msm8960.h>
 #include <dt-bindings/mfd/qcom-rpm.h>
 #include <dt-bindings/soc/qcom,gsbi.h>
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	model = "Qualcomm MSM8960";
 	compatible = "qcom,msm8960";
 	interrupt-parent = <&intc>;
@@ -44,6 +44,11 @@
 		};
 	};
 
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x0>;
+	};
+
 	cpu-pmu {
 		compatible = "qcom,krait-pmu";
 		interrupts = <1 10 0x304>;
diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index aba159d5a95a..c9fed1f54317 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -6,9 +6,10 @@
 #include <dt-bindings/clock/qcom,rpmcc.h>
 #include <dt-bindings/reset/qcom,gcc-msm8974.h>
 #include <dt-bindings/gpio/gpio.h>
-#include "skeleton.dtsi"
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	model = "Qualcomm MSM8974";
 	compatible = "qcom,msm8974";
 	interrupt-parent = <&intc>;
@@ -130,6 +131,11 @@
 		};
 	};
 
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x0>;
+	};
+
 	thermal-zones {
 		cpu-thermal0 {
 			polling-delay-passive = <250>;
diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 843052f14f1c..c65e96f9d7d1 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -43,13 +43,14 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include "skeleton.dtsi"
 #include <dt-bindings/dma/at91.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/clock/at91.h>
 #include <dt-bindings/iio/adc/at91-sama5d2_adc.h>
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	model = "Atmel SAMA5D2 family SoC";
 	compatible = "atmel,sama5d2";
 	interrupt-parent = <&aic>;
@@ -113,6 +114,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0x20000000 0x20000000>;
 	};
 
diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index 1408fa4a62e4..02198772eb81 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -8,7 +8,6 @@
  * Licensed under GPLv2 or later.
  */
 
-#include "skeleton.dtsi"
 #include <dt-bindings/dma/at91.h>
 #include <dt-bindings/pinctrl/at91.h>
 #include <dt-bindings/interrupt-controller/irq.h>
@@ -16,6 +15,8 @@
 #include <dt-bindings/clock/at91.h>
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	model = "Atmel SAMA5D3 family SoC";
 	compatible = "atmel,sama5d3", "atmel,sama5";
 	interrupt-parent = <&aic>;
@@ -56,6 +57,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0x20000000 0x8000000>;
 	};
 
diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index 7371f2a0460f..d96a2312b0a5 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -43,7 +43,6 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include "skeleton.dtsi"
 #include <dt-bindings/clock/at91.h>
 #include <dt-bindings/dma/at91.h>
 #include <dt-bindings/pinctrl/at91.h>
@@ -51,6 +50,8 @@
 #include <dt-bindings/gpio/gpio.h>
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	model = "Atmel SAMA5D4 family SoC";
 	compatible = "atmel,sama5d4";
 	interrupt-parent = <&aic>;
@@ -90,6 +91,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0x20000000 0x20000000>;
 	};
 
diff --git a/arch/arm/boot/dts/skeleton.dtsi b/arch/arm/boot/dts/skeleton.dtsi
deleted file mode 100644
index 34eda68d9ea2..000000000000
--- a/arch/arm/boot/dts/skeleton.dtsi
+++ /dev/null
@@ -1,18 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * This file is deprecated, and will be removed once existing users have been
- * updated. New dts{,i} files should *not* include skeleton.dtsi, and should
- * instead explicitly provide the below nodes only as required.
- *
- * Skeleton device tree; the bare minimum needed to boot; just include and
- * add a compatible value.  The bootloader will typically populate the memory
- * node.
- */
-
-/ {
-	#address-cells = <1>;
-	#size-cells = <1>;
-	chosen { };
-	aliases { };
-	memory { device_type = "memory"; reg = <0 0>; };
-};
diff --git a/arch/arm/boot/dts/skeleton64.dtsi b/arch/arm/boot/dts/skeleton64.dtsi
deleted file mode 100644
index 54e637752b9d..000000000000
--- a/arch/arm/boot/dts/skeleton64.dtsi
+++ /dev/null
@@ -1,14 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Skeleton device tree in the 64 bits version; the bare minimum
- * needed to boot; just include and add a compatible value.  The
- * bootloader will typically populate the memory node.
- */
-
-/ {
-	#address-cells = <2>;
-	#size-cells = <2>;
-	chosen { };
-	aliases { };
-	memory { device_type = "memory"; reg = <0 0 0 0>; };
-};
diff --git a/arch/arm/boot/dts/spear13xx.dtsi b/arch/arm/boot/dts/spear13xx.dtsi
index 086b4b333249..390df643a174 100644
--- a/arch/arm/boot/dts/spear13xx.dtsi
+++ b/arch/arm/boot/dts/spear13xx.dtsi
@@ -11,9 +11,9 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
-/include/ "skeleton.dtsi"
-
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	interrupt-parent = <&gic>;
 
 	cpus {
diff --git a/arch/arm/boot/dts/spear3xx.dtsi b/arch/arm/boot/dts/spear3xx.dtsi
index 118135d75899..c47380763cae 100644
--- a/arch/arm/boot/dts/spear3xx.dtsi
+++ b/arch/arm/boot/dts/spear3xx.dtsi
@@ -11,9 +11,9 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
-/include/ "skeleton.dtsi"
-
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	interrupt-parent = <&vic>;
 
 	cpus {
diff --git a/arch/arm/boot/dts/spear600.dtsi b/arch/arm/boot/dts/spear600.dtsi
index 00166eb9be86..0a634fb07452 100644
--- a/arch/arm/boot/dts/spear600.dtsi
+++ b/arch/arm/boot/dts/spear600.dtsi
@@ -9,9 +9,9 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
-/include/ "skeleton.dtsi"
-
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	compatible = "st,spear600";
 
 	cpus {
diff --git a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
index fca76a696d9d..f78b4eabd68c 100644
--- a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
+++ b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
@@ -4,13 +4,13 @@
  */
 
 #include <dt-bindings/gpio/gpio.h>
-#include "skeleton.dtsi"
 
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
 
 	memory {
+		device_type = "memory";
 		reg = <0x00000000 0x04000000>,
 		    <0x08000000 0x04000000>;
 	};
diff --git a/arch/arm/boot/dts/ste-u300.dts b/arch/arm/boot/dts/ste-u300.dts
index 1bd1aba3322f..f4e7660fead7 100644
--- a/arch/arm/boot/dts/ste-u300.dts
+++ b/arch/arm/boot/dts/ste-u300.dts
@@ -4,7 +4,6 @@
  */
 
 /dts-v1/;
-/include/ "skeleton.dtsi"
 
 / {
 	model = "ST-Ericsson U300";
@@ -22,6 +21,7 @@
         };
 
 	memory {
+		device_type = "memory";
 		reg = <0x48000000 0x03c00000>;
 	};
 
diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/stm32429i-eval.dts
index ed7d7f46465e..73ea84df7bf4 100644
--- a/arch/arm/boot/dts/stm32429i-eval.dts
+++ b/arch/arm/boot/dts/stm32429i-eval.dts
@@ -61,6 +61,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0x00000000 0x2000000>;
 	};
 
diff --git a/arch/arm/boot/dts/stm32746g-eval.dts b/arch/arm/boot/dts/stm32746g-eval.dts
index 8c081eaf20fe..d90b0d1e18c7 100644
--- a/arch/arm/boot/dts/stm32746g-eval.dts
+++ b/arch/arm/boot/dts/stm32746g-eval.dts
@@ -55,6 +55,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0xc0000000 0x2000000>;
 	};
 
diff --git a/arch/arm/boot/dts/stm32f429-disco.dts b/arch/arm/boot/dts/stm32f429-disco.dts
index 5ceb2cf3777f..e19d0fe7dbda 100644
--- a/arch/arm/boot/dts/stm32f429-disco.dts
+++ b/arch/arm/boot/dts/stm32f429-disco.dts
@@ -60,6 +60,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0x90000000 0x800000>;
 	};
 
diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index 8d6f028ae285..c29aa9d2f6d3 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -45,12 +45,14 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include "skeleton.dtsi"
 #include "armv7-m.dtsi"
 #include <dt-bindings/clock/stm32fx-clock.h>
 #include <dt-bindings/mfd/stm32f4-rcc.h>
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
 	clocks {
 		clk_hse: clk-hse {
 			#clock-cells = <0>;
diff --git a/arch/arm/boot/dts/stm32f469-disco.dts b/arch/arm/boot/dts/stm32f469-disco.dts
index 7937b43d7788..a3ff04940aec 100644
--- a/arch/arm/boot/dts/stm32f469-disco.dts
+++ b/arch/arm/boot/dts/stm32f469-disco.dts
@@ -61,6 +61,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0x00000000 0x1000000>;
 	};
 
diff --git a/arch/arm/boot/dts/stm32f746-disco.dts b/arch/arm/boot/dts/stm32f746-disco.dts
index e3a7bd338d61..0ba9c5b08ab9 100644
--- a/arch/arm/boot/dts/stm32f746-disco.dts
+++ b/arch/arm/boot/dts/stm32f746-disco.dts
@@ -56,6 +56,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0xC0000000 0x800000>;
 	};
 
diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f746.dtsi
index f48d06a80d1d..a25b7000a3a1 100644
--- a/arch/arm/boot/dts/stm32f746.dtsi
+++ b/arch/arm/boot/dts/stm32f746.dtsi
@@ -40,12 +40,14 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include "skeleton.dtsi"
 #include "armv7-m.dtsi"
 #include <dt-bindings/clock/stm32fx-clock.h>
 #include <dt-bindings/mfd/stm32f7-rcc.h>
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
 	clocks {
 		clk_hse: clk-hse {
 			#clock-cells = <0>;
diff --git a/arch/arm/boot/dts/stm32f769-disco.dts b/arch/arm/boot/dts/stm32f769-disco.dts
index 483d896e2bc1..3c7216844a9b 100644
--- a/arch/arm/boot/dts/stm32f769-disco.dts
+++ b/arch/arm/boot/dts/stm32f769-disco.dts
@@ -56,6 +56,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0xC0000000 0x1000000>;
 	};
 
diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
index cbdd69ca9e7a..299af0723790 100644
--- a/arch/arm/boot/dts/stm32h743.dtsi
+++ b/arch/arm/boot/dts/stm32h743.dtsi
@@ -40,13 +40,15 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include "skeleton.dtsi"
 #include "armv7-m.dtsi"
 #include <dt-bindings/clock/stm32h7-clks.h>
 #include <dt-bindings/mfd/stm32h7-rcc.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
 	clocks {
 		clk_hse: clk-hse {
 			#clock-cells = <0>;
diff --git a/arch/arm/boot/dts/stm32h743i-disco.dts b/arch/arm/boot/dts/stm32h743i-disco.dts
index 45e088c55741..f8040356fe2d 100644
--- a/arch/arm/boot/dts/stm32h743i-disco.dts
+++ b/arch/arm/boot/dts/stm32h743i-disco.dts
@@ -54,6 +54,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0xd0000000 0x2000000>;
 	};
 
diff --git a/arch/arm/boot/dts/stm32h743i-eval.dts b/arch/arm/boot/dts/stm32h743i-eval.dts
index 3f8e0c4a998d..ef34fa2f79ea 100644
--- a/arch/arm/boot/dts/stm32h743i-eval.dts
+++ b/arch/arm/boot/dts/stm32h743i-eval.dts
@@ -54,6 +54,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0xd0000000 0x2000000>;
 	};
 
diff --git a/arch/arm/boot/dts/stm32mp157c-ed1.dts b/arch/arm/boot/dts/stm32mp157c-ed1.dts
index f77bea49c079..0d3c05a8fe8a 100644
--- a/arch/arm/boot/dts/stm32mp157c-ed1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ed1.dts
@@ -17,6 +17,7 @@
 	};
 
 	memory@c0000000 {
+		device_type = "memory";
 		reg = <0xC0000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 316cb8b2945b..6a98f7bad9c3 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -42,13 +42,13 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include "skeleton.dtsi"
-
 #include "sun5i.dtsi"
 
 #include <dt-bindings/dma/sun4i-a10.h>
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	interrupt-parent = <&intc>;
 
 	aliases {
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index b1d827765530..f188d9598864 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -42,13 +42,13 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include "skeleton.dtsi"
-
 #include "sun5i.dtsi"
 
 #include <dt-bindings/thermal/thermal.h>
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	interrupt-parent = <&intc>;
 
 	thermal-zones {
diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index 9cd65c46720b..ce80fd319d39 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -42,13 +42,13 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include "skeleton.dtsi"
-
 #include <dt-bindings/clock/sun5i-ccu.h>
 #include <dt-bindings/dma/sun4i-a10.h>
 #include <dt-bindings/reset/sun5i-ccu.h>
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	interrupt-parent = <&intc>;
 
 	cpus {
@@ -88,6 +88,11 @@
 		};
 	};
 
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x0>;
+	};
+
 	clocks {
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index debc0bf22ea3..a960b8ef7822 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -42,8 +42,6 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include "skeleton.dtsi"
-
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/thermal/thermal.h>
 
@@ -51,6 +49,8 @@
 #include <dt-bindings/reset/sun6i-a31-ccu.h>
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	interrupt-parent = <&gic>;
 
 	aliases {
@@ -197,6 +197,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0x40000000 0x80000000>;
 	};
 
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 02e40da9f028..3c571dc599c3 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -42,8 +42,6 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include "skeleton.dtsi"
-
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/thermal/thermal.h>
 #include <dt-bindings/dma/sun4i-a10.h>
@@ -51,6 +49,8 @@
 #include <dt-bindings/reset/sun4i-a10-ccu.h>
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	interrupt-parent = <&gic>;
 
 	aliases {
@@ -171,6 +171,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0x40000000 0x80000000>;
 	};
 
diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index c16ffcc4db7d..c7bf9ef25b1d 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -42,14 +42,14 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include "skeleton.dtsi"
-
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
 #include <dt-bindings/clock/sun8i-a23-a33-ccu.h>
 #include <dt-bindings/reset/sun8i-a23-a33-ccu.h>
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	interrupt-parent = <&gic>;
 
 	chosen {
diff --git a/arch/arm/boot/dts/sun8i-a23.dtsi b/arch/arm/boot/dts/sun8i-a23.dtsi
index 58e6585b504b..63fb862164f9 100644
--- a/arch/arm/boot/dts/sun8i-a23.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23.dtsi
@@ -46,6 +46,7 @@
 
 / {
 	memory {
+		device_type = "memory";
 		reg = <0x40000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index c1cc8f09dd9a..c81dc6186304 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -187,6 +187,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0x40000000 0x80000000>;
 	};
 
diff --git a/arch/arm/boot/dts/versatile-ab.dts b/arch/arm/boot/dts/versatile-ab.dts
index 6f4f60ba5429..269e6bf99ccb 100644
--- a/arch/arm/boot/dts/versatile-ab.dts
+++ b/arch/arm/boot/dts/versatile-ab.dts
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /dts-v1/;
-/include/ "skeleton.dtsi"
 
 / {
 	model = "ARM Versatile AB";
@@ -21,6 +20,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0x0 0x08000000>;
 	};
 
diff --git a/arch/arm/boot/dts/vt8500.dtsi b/arch/arm/boot/dts/vt8500.dtsi
index 1929ad390d88..8b5af039b072 100644
--- a/arch/arm/boot/dts/vt8500.dtsi
+++ b/arch/arm/boot/dts/vt8500.dtsi
@@ -6,9 +6,9 @@
  * Licensed under GPLv2 or later
  */
 
-/include/ "skeleton.dtsi"
-
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	compatible = "via,vt8500";
 
 	cpus {
@@ -21,6 +21,11 @@
 		};
 	};
 
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x0>;
+	};
+
 	aliases {
 		serial0 = &uart0;
 		serial1 = &uart1;
diff --git a/arch/arm/boot/dts/wm8505.dtsi b/arch/arm/boot/dts/wm8505.dtsi
index e9ef539e13d3..cca6747304c4 100644
--- a/arch/arm/boot/dts/wm8505.dtsi
+++ b/arch/arm/boot/dts/wm8505.dtsi
@@ -6,9 +6,9 @@
  * Licensed under GPLv2 or later
  */
 
-/include/ "skeleton.dtsi"
-
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	compatible = "wm,wm8505";
 
 	cpus {
@@ -21,6 +21,11 @@
 		};
 	};
 
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x0>;
+	};
+
  	aliases {
 		serial0 = &uart0;
 		serial1 = &uart1;
diff --git a/arch/arm/boot/dts/wm8650.dtsi b/arch/arm/boot/dts/wm8650.dtsi
index e12213d16693..00d01769a68f 100644
--- a/arch/arm/boot/dts/wm8650.dtsi
+++ b/arch/arm/boot/dts/wm8650.dtsi
@@ -6,9 +6,9 @@
  * Licensed under GPLv2 or later
  */
 
-/include/ "skeleton.dtsi"
-
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	compatible = "wm,wm8650";
 
 	cpus {
@@ -21,6 +21,11 @@
 		};
 	};
 
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x0>;
+	};
+
  	aliases {
 		serial0 = &uart0;
 		serial1 = &uart1;
diff --git a/arch/arm/boot/dts/wm8750.dtsi b/arch/arm/boot/dts/wm8750.dtsi
index 46d076d7302b..54d8f7d9bb33 100644
--- a/arch/arm/boot/dts/wm8750.dtsi
+++ b/arch/arm/boot/dts/wm8750.dtsi
@@ -6,9 +6,9 @@
  * Licensed under GPLv2 or later
  */
 
-/include/ "skeleton.dtsi"
-
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	compatible = "wm,wm8750";
 
 	cpus {
@@ -21,6 +21,11 @@
 		};
 	};
 
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x0>;
+	};
+
 	aliases {
 		serial0 = &uart0;
 		serial1 = &uart1;
diff --git a/arch/arm/boot/dts/wm8850.dtsi b/arch/arm/boot/dts/wm8850.dtsi
index 8fbccfbe75f3..c572d777077f 100644
--- a/arch/arm/boot/dts/wm8850.dtsi
+++ b/arch/arm/boot/dts/wm8850.dtsi
@@ -6,9 +6,9 @@
  * Licensed under GPLv2 or later
  */
 
-/include/ "skeleton.dtsi"
-
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	compatible = "wm,wm8850";
 
 	cpus {
@@ -22,6 +22,11 @@
 		};
 	};
 
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x0>;
+	};
+
 	aliases {
 		serial0 = &uart0;
 		serial1 = &uart1;
diff --git a/arch/arm/boot/dts/zx296702-ad1.dts b/arch/arm/boot/dts/zx296702-ad1.dts
index eedd3fcbc002..bd9400840023 100644
--- a/arch/arm/boot/dts/zx296702-ad1.dts
+++ b/arch/arm/boot/dts/zx296702-ad1.dts
@@ -14,6 +14,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0x50000000 0x20000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/zx296702.dtsi b/arch/arm/boot/dts/zx296702.dtsi
index 240e7a23d81f..afd98de029be 100644
--- a/arch/arm/boot/dts/zx296702.dtsi
+++ b/arch/arm/boot/dts/zx296702.dtsi
@@ -1,10 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include "skeleton.dtsi"
 #include <dt-bindings/clock/zx296702-clock.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.19.1

