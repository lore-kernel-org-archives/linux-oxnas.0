DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	 bh=D2YPQJSssFXG6XJhGCQI9LtrGRYEbm9Vq4RoLp19BNU=; b=rHu2BycLd+YYaFD2GZaq7O3Et
	jHoKHhun6/D56t5jU2t8Omk80fN8N1YT451NzhorKaNVhIVSUxc+oswCEnESSIxvKvfipUg4/CmC9
	4ul/BXAb+qPSQrXBvaxhiYElXkXup2Ti43+8SXJFU2OVk8eyiw2JHLabnsnqDAAB+tO5Y=;
Date: Tue, 30 Jul 2019 13:34:25 +0100
From: Mark Brown <broonie@kernel.org>
Subject: Re: next/master boot: 265 boots: 17 failed, 184 passed with 64 offline (next-20190730)
Message-ID: <20190730123425.GB4264@sirena.org.uk>
References: <5d403574.1c69fb81.14163.65d3@mx.google.com>
MIME-Version: 1.0
In-Reply-To: <5d403574.1c69fb81.14163.65d3@mx.google.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yEPQxsgoJgBvi8ip"
Content-Disposition: inline
To: khilman@baylibre.com, Neil Armstrong <narmstrong@baylibre.com>
Cc: kernel-build-reports@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-next@vger.kernel.org, linux-oxnas@groups.io
List-ID: <linux-oxnas@groups.io>

--yEPQxsgoJgBvi8ip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2019 at 05:17:56AM -0700, kernelci.org bot wrote:

> Boot Failures Detected:
>=20
> arm:
>     oxnas_v6_defconfig:
>         gcc-8:
>             ox820-cloudengines-pogoplug-series-3: 1 failed lab

For some time now -next and mainline have been failing to boot on
Pogoplug 3 with the oxnas_v6_defconfig, the kernel seems to start fine
but fails to parse the ramdisk it's passed:

08:50:02.086589  <6>[    7.719854] IP-Config: Complete:
08:50:02.087213  <6>[    7.723330]      device=3Deth0, hwaddr=3D0a:a2:89:27=
:10:1b, ipaddr=3D10.201.4.144, mask=3D255.255.0.0, gw=3D10.201.0.1
08:50:02.087413  <6>[    7.733409]      host=3D10.201.4.144, domain=3D, nis=
-domain=3D(none)
08:50:02.088056  <6>[    7.739499]      bootserver=3D10.201.1.1, rootserver=
=3D10.201.1.1, rootpath=3D
08:50:02.088248  <6>[    7.739504]      nameserver0=3D10.201.1.1
08:50:02.129966  <5>[    7.752025] RAMDISK: Couldn't find valid RAM disk im=
age starting at 0.
08:50:02.130381  <4>[    7.759616] List of all partitions:
08:50:02.131333  <4>[    7.763363] 0100           65536 ram0=20

Possibly an issue with the ramdisk getting overwritten or something?

Full details for today's -next can be seen here:

	https://kernelci.org/boot/id/5d4004bb59b51489d631b28d/

--yEPQxsgoJgBvi8ip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1AOVAACgkQJNaLcl1U
h9ALMgf/UsXvdF4Sayi9hNUwwm0wCOJ9dB1n8L76v9DjPI1cN8MvrF+3M3HS7M7S
6jNyB7dFoxrMILacFV4Co45NcBMF+ZgeJjPcWDHpF/vwj0XsV8d2C9aIvdLpqdVy
Jh65+wIkFnTPWhrjTzFUxAlWclv/6i7ZBBe42oC79SInfsieyNH5V1OMoO01XI7i
CyTqDXmbQL72Nmp2r5jCi/SwrC5Sh1xYWVFynDoyGVZieOr8oQOIsRyaDzqAj+nc
Zqw0nmzkVJzkBYqqSs+P4IaD5BKrWUwiofTMspxnAPXt8X5K57GfXvgswGxBNvhE
4ut4elXlKKD4+AwZAiwwAe05rE3iCA==
=+oW9
-----END PGP SIGNATURE-----

--yEPQxsgoJgBvi8ip--
