Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web11.22041.1628511744619837572
 for <linux-oxnas@groups.io>;
 Mon, 09 Aug 2021 05:22:25 -0700
Received: by mail-wm1-f51.google.com with SMTP id k38-20020a05600c1ca6b029025af5e0f38bso14455728wms.5
        for <linux-oxnas@groups.io>; Mon, 09 Aug 2021 05:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DLjWk41GfUptM8Oc51CA/RijDxdpBzh/hV0PWtvQFwE=;
        b=G6N9NWO9aZpUxaAEK9b+GIf+FoHBUz2ZMx53mJWiAcm6jDm0l/XTFSbrmI1DXPeUjb
         aTgfyZM6vbm/tjZoL+tBPKvzOSaeWL7V1JkZ+wnKy13I9udJFRRwKgrmi8FE/l4mqcOV
         CLDq9vilHDOTKUEqUpyjqq8aoaj8TqSroqqgqS1P6uM7e/rDuDdVdPO//d/gUphyIO/4
         G/GU0m+p8U98wU66AtJ8rSBanqWkfH9K54mpkvSq5h7IKNAQQbTQMHyMS+cFSh9H4xlS
         ZwZDJsd3okMp8G1SW6LALupQ2NPwAxVbl2rxhmoL3ZH+2PHo0bRm0hOPnj72BbdYDvWT
         0thA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] ARM: oxnas: Add basic support for Zyxel NSA210
References: <20210809104351.2050187-1-uwe@kleine-koenig.org>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <a082058f-365a-8990-7bb1-cf34fa58b166@baylibre.com>
Date: Mon, 9 Aug 2021 14:22:21 +0200
MIME-Version: 1.0
In-Reply-To: <20210809104351.2050187-1-uwe@kleine-koenig.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>, Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io
List-ID: <linux-oxnas@groups.io>

Hi,

On 09/08/2021 12:43, Uwe Kleine-König wrote:
> This is a one bay NAS originally shipping Linux 2.6.24.4. It features
> 
>  - 128 MiB RAM
>  - 2x eSATA (1x internal, 1x external)
>  - 2x USB 2.0
>  - 4 MiB NOR
>  - battery powered RTC on i2c (PCF8563)
>  - 1x GBit ethernet
> 
> For now only the low-hanging fruits are added to the device tree, eSATA,
> USB, i2c and networking needs more work as there are no drivers
> available.
> 
> Such a machine was offered to me by Richard Fröhning. Thanks!

Thanks for posting this !

> 
> Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
> ---
>  .../devicetree/bindings/arm/oxnas.txt         |   1 +
>  arch/arm/boot/dts/Makefile                    |   1 +
>  arch/arm/boot/dts/ox810se-zyxel-nsa210.dts    | 156 ++++++++++++++++++
>  3 files changed, 158 insertions(+)
>  create mode 100644 arch/arm/boot/dts/ox810se-zyxel-nsa210.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/oxnas.txt b/Documentation/devicetree/bindings/arm/oxnas.txt
> index ac64e60f99f1..c1529d6c9666 100644
> --- a/Documentation/devicetree/bindings/arm/oxnas.txt
> +++ b/Documentation/devicetree/bindings/arm/oxnas.txt
> @@ -11,4 +11,5 @@ Boards with the OX820 SoC shall have the following properties:
>  
>  Board compatible values:
>    - "wd,mbwe" (OX810SE)
> +  - "zyxel,nsa210" (OX810SE)
>    - "cloudengines,pogoplugv3" (OX820)
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 863347b6b65e..720b7d7e342a 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -913,6 +913,7 @@ dtb-$(CONFIG_ARCH_PXA) += \
>  	pxa300-raumfeld-speaker-s.dtb
>  dtb-$(CONFIG_ARCH_OXNAS) += \
>  	ox810se-wd-mbwe.dtb \
> +	ox810se-zyxel-nsa210.dtb \
>  	ox820-cloudengines-pogoplug-series-3.dtb
>  dtb-$(CONFIG_ARCH_QCOM) += \
>  	qcom-apq8060-dragonboard.dtb \
> diff --git a/arch/arm/boot/dts/ox810se-zyxel-nsa210.dts b/arch/arm/boot/dts/ox810se-zyxel-nsa210.dts
> new file mode 100644
> index 000000000000..88d0e065cf99
> --- /dev/null
> +++ b/arch/arm/boot/dts/ox810se-zyxel-nsa210.dts
> @@ -0,0 +1,156 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Device tree file for Zyxel NSA-210
> + */
> +
> +/dts-v1/;
> +#include "ox810se.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +	model = "Zyxel NSA-210";
> +
> +	compatible = "zyxel,nsa210", "oxsemi,ox810se";
> +
> +	chosen {
> +		bootargs = "console=ttyS2,115200n8";
> +	};
> +
> +	memory {
> +		reg = <0x48000000 0x8000000>;
> +	};
> +
> +	aliases {
> +		serial2 = &uart2;
> +	};
> +
> +	flash@41000000 {
> +		compatible = "cfi-flash";
> +		reg = <0x41000000 0x00400000>;
> +		bank-width = <1>;
> +
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			partitions@0 {
> +				label = "uboot";
> +				reg = <0x00000000 0x00020000>;
> +			};
> +
> +			partitions@1 {
> +				label = "kernel";
> +				reg = <0x00020000 0x001c0000>;
> +			};
> +
> +			partitions@2 {
> +				label = "initrd";
> +				reg = <0x001e0000 0x001a0000>;
> +			};
> +
> +			partitions@3 {
> +				label = "etc";
> +				reg = <0x00380000 0x00070000>;
> +			};
> +
> +			/* 448k gap */
> +
> +			partitions@4 {
> +				label = "env1";
> +				reg = <0x003fc000 0x00002000>;
> +			};
> +
> +			partitions@5 {
> +				label = "env2";
> +				reg = <0x003fe000 0x00002000>;
> +			};
> +		};
> +	};
> +
> +	keys {
> +		compatible = "gpio-keys";
> +
> +		reset {
> +			label = "Reset";
> +			gpios = <&gpio0 2 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		power {
> +			label = "Power";
> +			gpios = <&gpio0 4 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		sync {
> +			label = "Copy/Sync";
> +			gpio = <&gpio0 10 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		/*
> +		 * The vendor U-Boot enables a PWM to make this LED blink during boot.
> +		 * This must be disabled to be able to drive the LED using the
> +		 * GPIO as defined here by unsetting bit 9 in the
> +		 * SYS_CTRL_GPIO_PWMSEL_CTRL_0 register.
> +		 * E.g. do before starting Linux: mw 0x4500009c 0
> +		 */
> +		led1 {
> +			label = "nsa210:green:sys";
> +			gpios = <&gpio0 9 GPIO_ACTIVE_HIGH>;
> +		};

In order to support this usecase, the oxnas pinctrl driver could be augmented to handle this PWMSEL mux.

> +
> +		led2 {
> +			label = "nsa210:red:hdd";
> +			gpios = <&gpio0 27 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		led3 {
> +			label = "nsa210:green:hdd";
> +			gpios = <&gpio0 22 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		led4 {
> +			label = "nsa210:red:usb";
> +			gpios = <&gpio1 0 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		led5 {
> +			label = "nsa210:green:usb";
> +			gpios = <&gpio0 31 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		led6 {
> +			label = "nsa210:red:esata";
> +			gpios = <&gpio0 28 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		led7 {
> +			label = "nsa210:green:esata";
> +			gpios = <&gpio0 26 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		led8 {
> +			label = "nsa210:red:copy";
> +			gpios = <&gpio0 24 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		led9 {
> +			label = "nsa210:green:copy";
> +			gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +};
> +
> +&uart2 {
> +	/*
> +	 * To make this device work as expected bit 2 of register
> +	 * SYS_CTRL_UART_CTRL must be set. Otherwise the interrupt doesn't
> +	 * trigger, so console messages make it through, but userspace cannot
> +	 * make use of it.
> +	 * E.g. do before starting Linux: mw 0x45000094 4
> +	 */
> +	status = "okay";
> +};
> 

This one should be handled by adding an oxnas ns16550a variant with access to the &sys syscon to setup
the UART.

Neil
