Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by mx.groups.io with SMTP id smtpd.web11.3424.1683672890015604373
 for <linux-oxnas@groups.io>;
 Tue, 09 May 2023 15:54:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
	t=1683672871; i=j.neuschaefer@gmx.net;
	bh=IjOsP3Hl5WOUcxHtKpSlXVU2zmb5sAncILY7B0EhNVs=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ndYA2tf/LPtkgltTOvt7X2+Zi6uiTPSZbAqw/mXBwe2s3qEMYWIHbVw2U7syYOtiu
	 0ByeTgk6m0fQkzncsA2uFg7rs+4GDkYCaq3zleDHMNFIszwJSYZevaNUwCstSv1xs2
	 q2XsYVKyF7xXnp4qsykgKdmrMBdtxCsRttws9I9ls8dUQV5PBqFxC2CHyOsYGjarJ/
	 Rr2m1bZj51r337gAlDvnDkQfA5v+OxXvevYZAHhLDsYKtlfaLNIq481n2v1Dl3mPUG
	 +ciwlK0+ezWRctjT6rrS4cmxjRJOY33gMIuTSxMpaalo6ZUK907KGn7D4ZZQnJjuQD
	 xm3g+5vkab4wA==
Date: Wed, 10 May 2023 00:54:29 +0200
From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: Re: [RFC PATCH 0/1] Categorize ARM dts directory
Message-ID: <ZFrPJQdwoxqFpzUO@probook>
References: <20220328000915.15041-1-ansuelsmth@gmail.com>
 <85eb14ec-f465-7447-ad77-a3dabc666f47@kernel.org>
 <YkKRYnN84D9VZhGj@Ansuel-xps.localdomain>
 <CAL_Jsq+RQQ-ADMxLPUFwk6S6kGmb6oNDy4k52fnU0EtbUvqmSA@mail.gmail.com>
 <CAMuHMdWNTE48MFy6fqxAsfMWz9b6E7dVNXtXtESP95sxk2PGwA@mail.gmail.com>
 <CAL_JsqJthKTm8bhRF2B=ae1tvtPeYYXx_Tm76qQtSwLtH5C6VA@mail.gmail.com>
 <720a2829-b6b5-411c-ac69-9a53e881f48d@app.fastmail.com>
 <CAL_JsqKCtmkwzKa01gyG65fH8ye6R3KhR41PJbJhOJ4X9j=znA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKCtmkwzKa01gyG65fH8ye6R3KhR41PJbJhOJ4X9j=znA@mail.gmail.com>
Content-Type: multipart/mixed; boundary="Groupsio=hQYSUSMWES4U9JNyHoMf"
To: Rob Herring <robh+dt@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-aspeed@lists.ozlabs.org, linux-realtek-soc@lists.infradead.org, linux-arm-kernel@axis.com, linux-stm32@st-md-mailman.stormreply.com, chrome-platform@lists.linux.dev, linux-samsung-soc@vger.kernel.org, openbmc@lists.ozlabs.org, Krzysztof Kozlowski <krzk@kernel.org>, linux-rockchip@lists.infradead.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-actions@lists.infradead.org, linux-unisoc@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, linux-tegra@vger.kernel.org, linux-amlogic@lists.infradead.org, Linux-OMAP <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Christian Marangi <ansuelsmth@gmail.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, kernel@dh-electronics.com, Olof Johansson <olof@lixom.net>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "linux-oxnas@groups.io" <linux-oxnas@groups.io>
List-ID: <linux-oxnas@groups.io>

--Groupsio=hQYSUSMWES4U9JNyHoMf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 02, 2023 at 02:40:19PM -0500, Rob Herring wrote:
[...]
> I've dusted off my script and made a branch[1] with the result.
> There's just a couple of fixes needed after the script is run (see the
> top commit). The cross arch includes are all fixed up by the script.
> dtbs_install maintains a flat install. I compared the number of .dtbs
> before and after to check the script.
>=20
> I think the only issue remaining is finalizing the mapping of
> platforms to subdirs. What I have currently is a mixture of SoC
> families and vendors. The most notable are all the Freescale/NXP
> platforms, pxa, socfpga, and stm32. It's not consistent with arm64
> either. Once that's finalized, I still need to go update MAINTAINERS.
>=20
> Here's the current mapping:
>=20
> vendor_map =3D {
[...]
>     'aspeed' : 'aspeed',
>     'ast2' : 'aspeed',
>     'facebook' : 'aspeed',
>     'ibm' : 'aspeed',

>     'openbmc' : 'aspeed',

The openbmc flash layouts are currently only used by aspeed devicetrees,
but they don't really depend on any aspeed details. It would be possible
to reuse them in Nuvoton BMC devicetrees in the future, for example.

In that sense, I think putting them in a separate "openbmc" directory
would be slightly better.


Jonathan



[...]
>     'nuvo' : 'nuvoton',
[...]
> }
>=20
> Rob
>=20
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git arm-dts-=
move-v2

--Groupsio=hQYSUSMWES4U9JNyHoMf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmRazv0ACgkQCDBEmo7z
X9tB/A//Y5MU9b+r/mxCUuxjsa0CB4Ewu8xmc+YTd1pdMEIrJYfgdpXFskBmzFsg
QFYR1gBnq7P4mhusW4RaYWxpzD3M45B2vIuhgL6t8lqIWae0UuNbPEO4rbCIbvGZ
PCx1dTAGZ2vg+mxRK0OYouuCE9EvgrC9PGmOcgDkqCLngGsr11gXz0GMNebggmie
TX8iauQHnzfGaSQWtwIdQRu1gj2d/VO5NSn4CrgvMIuLCSwhTwY+e9H9/+CcrqHK
wNiMG0W8yY5CMO7ZSYf7EkEidunJ0htwqJmUoLfpqN4NZ/21yno69v+L36ZRu/lq
+KrZJeaXC3Ar39R2x75Pns5em46uwJJdI5aXumj9xPU3A3rgWCQcrECZJ7i/HEoK
hzhnsQhJNP4jAPVxdiaWJTYUXHRwafI6/GVvj1BvfgqZ9VHE28iGdDcgVvOfmkDx
eRZQxcJzFaWZeWTOeM05/dHUDUJXFrYvDsj0+FgneBU/oqEc+H4bR9AP2ttU24hU
4jBq2I2FlDyKlC0ARS22oRQlZG6KS50d1Nvx6cLr7lxeOHmcW09dPCqHijQVtX3V
f/Z7MYrDEXgTK8r1wJk6PuvVN+jFX/l/Ali5L/OJqUsZB4bgteXKEWXWMmgik1/I
d3nr3gTYEaykVkjCJORFKu4G2FHrzWgWpFYsl8Mu+safGLa+rdA=
=Jzyt
-----END PGP SIGNATURE-----

--Groupsio=hQYSUSMWES4U9JNyHoMf--
