Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mx.groups.io with SMTP id smtpd.web11.1559.1588292192970005008
 for <linux-oxnas@groups.io>;
 Thu, 30 Apr 2020 17:16:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588292192;
	bh=RkSAzAwihro8eKWGx/4Ix5nerZsbab3dtnKNanLh9VE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tIunyiRjf0IjxuZTGw6GYBfhGrZk3opqrY1sxNq8TnUxA4u25SOpitBdAhadS61vj
	 U/oUPkdG4fN0ejJa4TGiIqCyQ8xEdrhuqHJuDX//IyZY/YG7ct7flztN+KSq1W6eaN
	 BNfIwOn0EWG2MDZqrmDmQH8grE2x983XEE3tyHlk=
Date: Fri, 1 May 2020 02:16:30 +0200
From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2] power: reset: introduce oxnas-restart
Message-ID: <20200501001630.hor66uocheugjzdv@earth.universe>
References: <467de56a-5d82-ad4a-a681-88c0dedfa8eb@baylibre.com>
 <20200330220508.GA12698@makrotopia.org>
 <e1682107-9025-68ec-098e-36a42cae9ed5@baylibre.com>
MIME-Version: 1.0
In-Reply-To: <e1682107-9025-68ec-098e-36a42cae9ed5@baylibre.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="echngqmj3lz7w63t"
Content-Disposition: inline
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: Daniel Golle <daniel@makrotopia.org>, linux-oxnas@groups.io, linux-arm-kernel@lists.infradead.org, Sungbo Eo <mans0n@gorani.run>
List-ID: <linux-oxnas@groups.io>

--echngqmj3lz7w63t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks, queued. Sorry for the delay; I'm currently a bit behind with
reviewing power-supply patches. I hope to catch up this weekend.

-- Sebastian

On Tue, Mar 31, 2020 at 09:36:50AM +0200, Neil Armstrong wrote:
> Hi Daniel,
>=20
> I think Sebastian Reichel <sre@kernel.org> is missing in Cc.
>=20
> Added him.
>=20
> @Sebastian, I can take it in my arm-soc oxnas tree with your ack if it's =
simpler.
>=20
> Neil
>=20
> On 31/03/2020 00:09, Daniel Golle wrote:
> > Add reboot handler for Oxford OX820 chips as reboot currenly hangs on
> > those boards. Code is based on ox820_assert_system_reset() found in
> > https://github.com/kref/linux-oxnas.git in
> > arch/arm/mach-oxnas/mach-ox820.c line 181.
> >=20
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > Acked-by: Neil Armstrong <narmstrong@baylibre.com>
> > ---
> > v2: style fixes and MAINTAINERS entry added
> >  MAINTAINERS                         |   1 +
> >  drivers/power/reset/Kconfig         |   7 +
> >  drivers/power/reset/Makefile        |   1 +
> >  drivers/power/reset/oxnas-restart.c | 234 ++++++++++++++++++++++++++++
> >  4 files changed, 243 insertions(+)
> >  create mode 100644 drivers/power/reset/oxnas-restart.c
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 50e8b900c0ae..d70acf978c6e 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2154,6 +2154,7 @@ L:	linux-oxnas@groups.io (moderated for non-subsc=
ribers)
> >  S:	Maintained
> >  F:	arch/arm/mach-oxnas/
> >  F:	arch/arm/boot/dts/ox8*.dts*
> > +F:	drivers/power/reset/oxnas-restart.c
> >  N:	oxnas
> > =20
> >  ARM/PALM TREO SUPPORT
> > diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> > index 890380302080..4dfac618b942 100644
> > --- a/drivers/power/reset/Kconfig
> > +++ b/drivers/power/reset/Kconfig
> > @@ -123,6 +123,13 @@ config POWER_RESET_OCELOT_RESET
> >  	help
> >  	  This driver supports restart for Microsemi Ocelot SoC.
> > =20
> > +config POWER_RESET_OXNAS
> > +	bool "OXNAS SoC restart driver"
> > +	depends on ARCH_OXNAS
> > +	default MACH_OX820
> > +	help
> > +	  Restart support for OXNAS/PLXTECH OX820 SoC.
> > +
> >  config POWER_RESET_PIIX4_POWEROFF
> >  	tristate "Intel PIIX4 power-off driver"
> >  	depends on PCI
> > diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> > index da37f8b851dc..5710ca469517 100644
> > --- a/drivers/power/reset/Makefile
> > +++ b/drivers/power/reset/Makefile
> > @@ -12,6 +12,7 @@ obj-$(CONFIG_POWER_RESET_GPIO_RESTART) +=3D gpio-rest=
art.o
> >  obj-$(CONFIG_POWER_RESET_HISI) +=3D hisi-reboot.o
> >  obj-$(CONFIG_POWER_RESET_MSM) +=3D msm-poweroff.o
> >  obj-$(CONFIG_POWER_RESET_MT6323) +=3D mt6323-poweroff.o
> > +obj-$(CONFIG_POWER_RESET_OXNAS) +=3D oxnas-restart.o
> >  obj-$(CONFIG_POWER_RESET_QCOM_PON) +=3D qcom-pon.o
> >  obj-$(CONFIG_POWER_RESET_OCELOT_RESET) +=3D ocelot-reset.o
> >  obj-$(CONFIG_POWER_RESET_PIIX4_POWEROFF) +=3D piix4-poweroff.o
> > diff --git a/drivers/power/reset/oxnas-restart.c b/drivers/power/reset/=
oxnas-restart.c
> > new file mode 100644
> > index 000000000000..2c6ee20e3402
> > --- /dev/null
> > +++ b/drivers/power/reset/oxnas-restart.c
> > @@ -0,0 +1,233 @@
> > +// SPDX-License-Identifier: (GPL-2.0)
> > +/*
> > + * oxnas SoC reset driver
> > + * based on:
> > + * Microsemi MIPS SoC reset driver
> > + * and ox820_assert_system_reset() written by Ma Hajun <mahaijuns@gmai=
l.com>
> > + *
> > + * Copyright (c) 2013 Ma Hajun <mahaijuns@gmail.com>
> > + * Copyright (c) 2017 Microsemi Corporation
> > + * Copyright (c) 2020 Daniel Golle <daniel@makrotopia.org>
> > + */
> > +#include <linux/delay.h>
> > +#include <linux/io.h>
> > +#include <linux/notifier.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_device.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/reboot.h>
> > +#include <linux/regmap.h>
> > +
> > +/* bit numbers of reset control register */
> > +#define OX820_SYS_CTRL_RST_SCU                0
> > +#define OX820_SYS_CTRL_RST_COPRO              1
> > +#define OX820_SYS_CTRL_RST_ARM0               2
> > +#define OX820_SYS_CTRL_RST_ARM1               3
> > +#define OX820_SYS_CTRL_RST_USBHS              4
> > +#define OX820_SYS_CTRL_RST_USBHSPHYA          5
> > +#define OX820_SYS_CTRL_RST_MACA               6
> > +#define OX820_SYS_CTRL_RST_MAC                OX820_SYS_CTRL_RST_MACA
> > +#define OX820_SYS_CTRL_RST_PCIEA              7
> > +#define OX820_SYS_CTRL_RST_SGDMA              8
> > +#define OX820_SYS_CTRL_RST_CIPHER             9
> > +#define OX820_SYS_CTRL_RST_DDR                10
> > +#define OX820_SYS_CTRL_RST_SATA               11
> > +#define OX820_SYS_CTRL_RST_SATA_LINK          12
> > +#define OX820_SYS_CTRL_RST_SATA_PHY           13
> > +#define OX820_SYS_CTRL_RST_PCIEPHY            14
> > +#define OX820_SYS_CTRL_RST_STATIC             15
> > +#define OX820_SYS_CTRL_RST_GPIO               16
> > +#define OX820_SYS_CTRL_RST_UART1              17
> > +#define OX820_SYS_CTRL_RST_UART2              18
> > +#define OX820_SYS_CTRL_RST_MISC               19
> > +#define OX820_SYS_CTRL_RST_I2S                20
> > +#define OX820_SYS_CTRL_RST_SD                 21
> > +#define OX820_SYS_CTRL_RST_MACB               22
> > +#define OX820_SYS_CTRL_RST_PCIEB              23
> > +#define OX820_SYS_CTRL_RST_VIDEO              24
> > +#define OX820_SYS_CTRL_RST_DDR_PHY            25
> > +#define OX820_SYS_CTRL_RST_USBHSPHYB          26
> > +#define OX820_SYS_CTRL_RST_USBDEV             27
> > +#define OX820_SYS_CTRL_RST_ARMDBG             29
> > +#define OX820_SYS_CTRL_RST_PLLA               30
> > +#define OX820_SYS_CTRL_RST_PLLB               31
> > +
> > +/* bit numbers of clock control register */
> > +#define OX820_SYS_CTRL_CLK_COPRO              0
> > +#define OX820_SYS_CTRL_CLK_DMA                1
> > +#define OX820_SYS_CTRL_CLK_CIPHER             2
> > +#define OX820_SYS_CTRL_CLK_SD                 3
> > +#define OX820_SYS_CTRL_CLK_SATA               4
> > +#define OX820_SYS_CTRL_CLK_I2S                5
> > +#define OX820_SYS_CTRL_CLK_USBHS              6
> > +#define OX820_SYS_CTRL_CLK_MACA               7
> > +#define OX820_SYS_CTRL_CLK_MAC                OX820_SYS_CTRL_CLK_MACA
> > +#define OX820_SYS_CTRL_CLK_PCIEA              8
> > +#define OX820_SYS_CTRL_CLK_STATIC             9
> > +#define OX820_SYS_CTRL_CLK_MACB               10
> > +#define OX820_SYS_CTRL_CLK_PCIEB              11
> > +#define OX820_SYS_CTRL_CLK_REF600             12
> > +#define OX820_SYS_CTRL_CLK_USBDEV             13
> > +#define OX820_SYS_CTRL_CLK_DDR                14
> > +#define OX820_SYS_CTRL_CLK_DDRPHY             15
> > +#define OX820_SYS_CTRL_CLK_DDRCK              16
> > +
> > +/* Regmap offsets */
> > +#define OX820_CLK_SET_REGOFFSET               0x2c
> > +#define OX820_CLK_CLR_REGOFFSET               0x30
> > +#define OX820_RST_SET_REGOFFSET               0x34
> > +#define OX820_RST_CLR_REGOFFSET               0x38
> > +#define OX820_SECONDARY_SEL_REGOFFSET         0x14
> > +#define OX820_TERTIARY_SEL_REGOFFSET          0x8c
> > +#define OX820_QUATERNARY_SEL_REGOFFSET        0x94
> > +#define OX820_DEBUG_SEL_REGOFFSET             0x9c
> > +#define OX820_ALTERNATIVE_SEL_REGOFFSET       0xa4
> > +#define OX820_PULLUP_SEL_REGOFFSET            0xac
> > +#define OX820_SEC_SECONDARY_SEL_REGOFFSET     0x100014
> > +#define OX820_SEC_TERTIARY_SEL_REGOFFSET      0x10008c
> > +#define OX820_SEC_QUATERNARY_SEL_REGOFFSET    0x100094
> > +#define OX820_SEC_DEBUG_SEL_REGOFFSET         0x10009c
> > +#define OX820_SEC_ALTERNATIVE_SEL_REGOFFSET   0x1000a4
> > +#define OX820_SEC_PULLUP_SEL_REGOFFSET        0x1000ac
> > +
> > +struct oxnas_restart_context {
> > +	struct regmap *sys_ctrl;
> > +	struct notifier_block restart_handler;
> > +};
> > +
> > +static int ox820_restart_handle(struct notifier_block *this,
> > +				 unsigned long mode, void *cmd)
> > +{
> > +	struct oxnas_restart_context *ctx =3D container_of(this, struct
> > +							oxnas_restart_context,
> > +							restart_handler);
> > +	u32 value;
> > +
> > +	/*
> > +	 * Assert reset to cores as per power on defaults
> > +	 * Don't touch the DDR interface as things will come to an impromptu
> > +	 * stop NB Possibly should be asserting reset for PLLB, but there are
> > +	 * timing concerns here according to the docs
> > +	 */
> > +	value =3D BIT(OX820_SYS_CTRL_RST_COPRO)		|
> > +		BIT(OX820_SYS_CTRL_RST_USBHS)		|
> > +		BIT(OX820_SYS_CTRL_RST_USBHSPHYA)	|
> > +		BIT(OX820_SYS_CTRL_RST_MACA)		|
> > +		BIT(OX820_SYS_CTRL_RST_PCIEA)		|
> > +		BIT(OX820_SYS_CTRL_RST_SGDMA)		|
> > +		BIT(OX820_SYS_CTRL_RST_CIPHER)		|
> > +		BIT(OX820_SYS_CTRL_RST_SATA)		|
> > +		BIT(OX820_SYS_CTRL_RST_SATA_LINK)	|
> > +		BIT(OX820_SYS_CTRL_RST_SATA_PHY)	|
> > +		BIT(OX820_SYS_CTRL_RST_PCIEPHY)		|
> > +		BIT(OX820_SYS_CTRL_RST_STATIC)		|
> > +		BIT(OX820_SYS_CTRL_RST_UART1)		|
> > +		BIT(OX820_SYS_CTRL_RST_UART2)		|
> > +		BIT(OX820_SYS_CTRL_RST_MISC)		|
> > +		BIT(OX820_SYS_CTRL_RST_I2S)		|
> > +		BIT(OX820_SYS_CTRL_RST_SD)		|
> > +		BIT(OX820_SYS_CTRL_RST_MACB)		|
> > +		BIT(OX820_SYS_CTRL_RST_PCIEB)		|
> > +		BIT(OX820_SYS_CTRL_RST_VIDEO)		|
> > +		BIT(OX820_SYS_CTRL_RST_USBHSPHYB)	|
> > +		BIT(OX820_SYS_CTRL_RST_USBDEV);
> > +
> > +	regmap_write(ctx->sys_ctrl, OX820_RST_SET_REGOFFSET, value);
> > +
> > +	/* Release reset to cores as per power on defaults */
> > +	regmap_write(ctx->sys_ctrl, OX820_RST_CLR_REGOFFSET,
> > +			BIT(OX820_SYS_CTRL_RST_GPIO));
> > +
> > +	/*
> > +	 * Disable clocks to cores as per power-on defaults - must leave DDR
> > +	 * related clocks enabled otherwise we'll stop rather abruptly.
> > +	 */
> > +	value =3D BIT(OX820_SYS_CTRL_CLK_COPRO)		|
> > +		BIT(OX820_SYS_CTRL_CLK_DMA)		|
> > +		BIT(OX820_SYS_CTRL_CLK_CIPHER)		|
> > +		BIT(OX820_SYS_CTRL_CLK_SD)		|
> > +		BIT(OX820_SYS_CTRL_CLK_SATA)		|
> > +		BIT(OX820_SYS_CTRL_CLK_I2S)		|
> > +		BIT(OX820_SYS_CTRL_CLK_USBHS)		|
> > +		BIT(OX820_SYS_CTRL_CLK_MAC)		|
> > +		BIT(OX820_SYS_CTRL_CLK_PCIEA)		|
> > +		BIT(OX820_SYS_CTRL_CLK_STATIC)		|
> > +		BIT(OX820_SYS_CTRL_CLK_MACB)		|
> > +		BIT(OX820_SYS_CTRL_CLK_PCIEB)		|
> > +		BIT(OX820_SYS_CTRL_CLK_REF600)		|
> > +		BIT(OX820_SYS_CTRL_CLK_USBDEV);
> > +
> > +	regmap_write(ctx->sys_ctrl, OX820_CLK_CLR_REGOFFSET, value);
> > +
> > +	/* Enable clocks to cores as per power-on defaults */
> > +
> > +	/* Set sys-control pin mux'ing as per power-on defaults */
> > +	regmap_write(ctx->sys_ctrl, OX820_SECONDARY_SEL_REGOFFSET, 0);
> > +	regmap_write(ctx->sys_ctrl, OX820_TERTIARY_SEL_REGOFFSET, 0);
> > +	regmap_write(ctx->sys_ctrl, OX820_QUATERNARY_SEL_REGOFFSET, 0);
> > +	regmap_write(ctx->sys_ctrl, OX820_DEBUG_SEL_REGOFFSET, 0);
> > +	regmap_write(ctx->sys_ctrl, OX820_ALTERNATIVE_SEL_REGOFFSET, 0);
> > +	regmap_write(ctx->sys_ctrl, OX820_PULLUP_SEL_REGOFFSET, 0);
> > +
> > +	regmap_write(ctx->sys_ctrl, OX820_SEC_SECONDARY_SEL_REGOFFSET, 0);
> > +	regmap_write(ctx->sys_ctrl, OX820_SEC_TERTIARY_SEL_REGOFFSET, 0);
> > +	regmap_write(ctx->sys_ctrl, OX820_SEC_QUATERNARY_SEL_REGOFFSET, 0);
> > +	regmap_write(ctx->sys_ctrl, OX820_SEC_DEBUG_SEL_REGOFFSET, 0);
> > +	regmap_write(ctx->sys_ctrl, OX820_SEC_ALTERNATIVE_SEL_REGOFFSET, 0);
> > +	regmap_write(ctx->sys_ctrl, OX820_SEC_PULLUP_SEL_REGOFFSET, 0);
> > +
> > +	/*
> > +	 * No need to save any state, as the ROM loader can determine whether
> > +	 * reset is due to power cycling or programatic action, just hit the
> > +	 * (self-clearing) CPU reset bit of the block reset register
> > +	 */
> > +	value =3D
> > +		BIT(OX820_SYS_CTRL_RST_SCU) |
> > +		BIT(OX820_SYS_CTRL_RST_ARM0) |
> > +		BIT(OX820_SYS_CTRL_RST_ARM1);
> > +
> > +	regmap_write(ctx->sys_ctrl, OX820_RST_SET_REGOFFSET, value);
> > +
> > +	pr_emerg("Unable to restart system\n");
> > +	return NOTIFY_DONE;
> > +}
> > +
> > +static int ox820_restart_probe(struct platform_device *pdev)
> > +{
> > +	struct oxnas_restart_context *ctx;
> > +	struct regmap *sys_ctrl;
> > +	struct device *dev =3D &pdev->dev;
> > +	int err =3D 0;
> > +
> > +	sys_ctrl =3D syscon_node_to_regmap(pdev->dev.of_node);
> > +	if (IS_ERR(sys_ctrl))
> > +		return PTR_ERR(sys_ctrl);
> > +
> > +	ctx =3D devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
> > +	if (!ctx)
> > +		return -ENOMEM;
> > +
> > +	ctx->sys_ctrl =3D sys_ctrl;
> > +	ctx->restart_handler.notifier_call =3D ox820_restart_handle;
> > +	ctx->restart_handler.priority =3D 192;
> > +	err =3D register_restart_handler(&ctx->restart_handler);
> > +	if (err)
> > +		dev_err(dev, "can't register restart notifier (err=3D%d)\n", err);
> > +
> > +	return err;
> > +}
> > +
> > +static const struct of_device_id ox820_restart_of_match[] =3D {
> > +	{ .compatible =3D "oxsemi,ox820-sys-ctrl" },
> > +	{}
> > +};
> > +
> > +static struct platform_driver ox820_restart_driver =3D {
> > +	.probe =3D ox820_restart_probe,
> > +	.driver =3D {
> > +		.name =3D "ox820-chip-reset",
> > +		.of_match_table =3D ox820_restart_of_match,
> > +	},
> > +};
> > +builtin_platform_driver(ox820_restart_driver);
> >=20
>=20

--echngqmj3lz7w63t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6ralMACgkQ2O7X88g7
+ppyKA/8D2OtqfDgKySOUOJRjfgrxy22hcMB45VB2Vh1ZfpH9lF+jPBAaJJz1Wg/
HI/dQ0j4eNK3Z0vn2BXHOjBy0T7uLmL+mC7XAjS97wVj/MXqiaEfZ/84yI/ELB/j
ItAwfsNQdHnBO+AsPsPwgcXAW2vbLwwDQxd4OQVskYo64mWW769GF21ZmQXzeVSA
oMQyoGNCInWbYZNTQUWLX3tDgp34sG2+i4Ho3Sy45HAKD6zs0BcRgW9wPk/Mxn+S
X8JE6VFsI1LFMMzRrMOYQWy38frVrtL/2fGYQPXJ3umFkA/6E6dHAoc5A88pKiwA
wI+E+VrVTgfUYmO8n+e8irYN0VIieQdpWFdbH7I2fHwFotTI5Lzn7M48q2r0IN92
0+I/bCUUQ9P8qGHVv+9FSH/5jsnC2QyPCbpBL8bfxDDDmIiYBMgaSVdmrZ6kOVRO
I/4ZSx269GLXuJHqSkXzyZPabLVFlP2wzBhaHSLVlfQd9QRyKnRMIBUlo83F/AHb
y+pNocHPa2EwurUrAeHhKN6ipqKwrD3X8/l66BcYBH+2xgbKBdhajIbwJ2ZgrY34
BPdNzGSw6mSl0qvOv9m+yev44FxQoO1jl3+RqP5P+8I8YlrbXVGrtY6YYemKoWJe
JX3pYc8Ia1S96fFbrPzXuO7zSObg++ftCKFUi9e/xJXV6+tAOME=
=iMuZ
-----END PGP SIGNATURE-----

--echngqmj3lz7w63t--
