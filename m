Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web11.64564.1680507747541161000
 for <linux-oxnas@groups.io>;
 Mon, 03 Apr 2023 00:42:27 -0700
Received: by mail-wr1-f51.google.com with SMTP id l27so28264679wrb.2
        for <linux-oxnas@groups.io>; Mon, 03 Apr 2023 00:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680507746;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XsljtCJiazE5NkGm88Tojg7L6Z8lihqck8h8eoHTGEg=;
        b=ERYeu1hbMOABzJJIf6abhps9hFWp8DcXj2oDxzp/+9rTEOPxfhbQIkNedDGIqLvYVV
         X9EhMi9RWzcaYrOj38qxaTk2u2uhRdfiIT1V6NKXbvRc6UPvDQEsRqkazeNpb2Hs6UYX
         Gk5vYKoCUPqzs8DHgM4nV0HhtQ2FkIoIG2qQfEVNPmA8llVQPymDbMMFHPFhZGmf8enp
         wRNDpAy7bBi1jjtKp5ZGlGkBpN+T0tv0qZPuCKxXSt4MhiYYGNtOTBqfqtcBB4C5iJYG
         jSetrrI681iFXZiJhAwXAmR3wo2jD7HqpJ32bALf0z0k3OsW90iNMkBXqrKROktYBaMw
         PGVw==
Return-Path: <neil.armstrong@linaro.org>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Date: Mon, 03 Apr 2023 09:42:20 +0200
Subject: [PATCH RFC v2 3/4] ARM: configs: remove oxnas_v6_defconfig
MIME-Version: 1.0
Message-Id: <20230331-topic-oxnas-upstream-remove-v2-3-e51078376f08@linaro.org>
References: <20230331-topic-oxnas-upstream-remove-v2-0-e51078376f08@linaro.org>
In-Reply-To: <20230331-topic-oxnas-upstream-remove-v2-0-e51078376f08@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, soc@kernel.org, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-oxnas@groups.io, Neil Armstrong <neil.armstrong@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Daniel Golle <daniel@makrotopia.org>
List-ID: <linux-oxnas@groups.io>

Due to lack of maintainance and stall of development for a few years now,
and since no new features will ever be added upstream, remove support
for OX820 specific defconfig.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm/configs/oxnas_v6_defconfig | 92 -------------------------------------
 1 file changed, 92 deletions(-)

diff --git a/arch/arm/configs/oxnas_v6_defconfig b/arch/arm/configs/oxnas_v6_defconfig
deleted file mode 100644
index 70a67b3fc91b..000000000000
--- a/arch/arm/configs/oxnas_v6_defconfig
+++ /dev/null
@@ -1,92 +0,0 @@
-CONFIG_SYSVIPC=y
-CONFIG_NO_HZ_IDLE=y
-CONFIG_HIGH_RES_TIMERS=y
-CONFIG_CGROUPS=y
-CONFIG_BLK_DEV_INITRD=y
-CONFIG_EMBEDDED=y
-CONFIG_PERF_EVENTS=y
-CONFIG_STRICT_KERNEL_RWX=y
-CONFIG_STRICT_MODULE_RWX=y
-CONFIG_ARCH_MULTI_V6=y
-CONFIG_ARCH_OXNAS=y
-CONFIG_MACH_OX820=y
-CONFIG_SMP=y
-CONFIG_NR_CPUS=16
-CONFIG_ARCH_FORCE_MAX_ORDER=12
-CONFIG_SECCOMP=y
-CONFIG_ARM_APPENDED_DTB=y
-CONFIG_ARM_ATAG_DTB_COMPAT=y
-CONFIG_KEXEC=y
-CONFIG_EFI=y
-CONFIG_CPU_IDLE=y
-CONFIG_ARM_CPUIDLE=y
-CONFIG_VFP=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_PARTITION_ADVANCED=y
-CONFIG_CMDLINE_PARTITION=y
-CONFIG_CMA=y
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_INET=y
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_DHCP=y
-CONFIG_IP_PNP_BOOTP=y
-CONFIG_IP_PNP_RARP=y
-CONFIG_IPV6_ROUTER_PREF=y
-CONFIG_IPV6_OPTIMISTIC_DAD=y
-CONFIG_INET6_AH=m
-CONFIG_INET6_ESP=m
-CONFIG_INET6_IPCOMP=m
-CONFIG_IPV6_MIP6=m
-CONFIG_IPV6_TUNNEL=m
-CONFIG_IPV6_MULTIPLE_TABLES=y
-CONFIG_DEVTMPFS=y
-CONFIG_DEVTMPFS_MOUNT=y
-CONFIG_MTD=y
-CONFIG_MTD_CMDLINE_PARTS=y
-CONFIG_MTD_BLOCK=y
-CONFIG_MTD_RAW_NAND=y
-CONFIG_MTD_NAND_OXNAS=y
-CONFIG_MTD_UBI=y
-CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_RAM=y
-CONFIG_BLK_DEV_RAM_SIZE=65536
-CONFIG_NETDEVICES=y
-CONFIG_STMMAC_ETH=y
-CONFIG_REALTEK_PHY=y
-CONFIG_INPUT_EVDEV=y
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_OF_PLATFORM=y
-CONFIG_GPIO_GENERIC_PLATFORM=y
-CONFIG_NEW_LEDS=y
-CONFIG_LEDS_CLASS=y
-CONFIG_LEDS_CLASS_FLASH=m
-CONFIG_LEDS_GPIO=y
-CONFIG_LEDS_TRIGGERS=y
-CONFIG_LEDS_TRIGGER_TIMER=y
-CONFIG_LEDS_TRIGGER_ONESHOT=y
-CONFIG_LEDS_TRIGGER_HEARTBEAT=y
-CONFIG_LEDS_TRIGGER_CPU=y
-CONFIG_LEDS_TRIGGER_GPIO=y
-CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
-CONFIG_ARM_TIMER_SP804=y
-CONFIG_EXT4_FS=y
-CONFIG_MSDOS_FS=y
-CONFIG_VFAT_FS=y
-CONFIG_TMPFS=y
-CONFIG_TMPFS_POSIX_ACL=y
-CONFIG_UBIFS_FS=y
-CONFIG_PSTORE=y
-CONFIG_PSTORE_CONSOLE=y
-CONFIG_PSTORE_PMSG=y
-CONFIG_PSTORE_RAM=y
-CONFIG_NLS_CODEPAGE_437=y
-CONFIG_NLS_ISO8859_1=y
-CONFIG_NLS_UTF8=y
-CONFIG_DMA_CMA=y
-CONFIG_CMA_SIZE_MBYTES=64
-CONFIG_PRINTK_TIME=y
-CONFIG_MAGIC_SYSRQ=y

-- 
2.34.1

