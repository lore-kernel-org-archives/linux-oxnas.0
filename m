Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mx.groups.io with SMTP id smtpd.web11.8034.1654091997661085062
 for <linux-oxnas@groups.io>;
 Wed, 01 Jun 2022 06:59:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1654091994;
	bh=cJFlLz+jFyLB/OFW6ZZBIAU34k0Q+vivDjWMB3mrnGI=;
	h=From:To:Cc:Subject:Date:From;
	b=BaQr74OVHhEguiDVV9MNq8c1hE9+qJc13C/u0jW01BTQCimWvCkTLkDfHHlRaOwLn
	 mXJ0Q3cuwK6LTm1q0I0C9+yu9w1o2v2uk4DdHUgIATK1A0RiKz27fFuxzanhCdmhTV
	 807cOwQOaPqwrU10AcbsD1Zitl+Rf2D67AmZ7RLbq7Y1RGHevjAIn+DmQFg/guHdld
	 oxXf0P4bBeFZOVmJyaHf+qPV+k3ugUB+MCQNg/K8+Khk5MBk4hF2w8z6287AarUh5V
	 OQ1IqnYsljnYLd494YgMjcXHpIcZe1qiXm6+ZafD840+Ubau7Ej3YyfCsaYTlcuLR5
	 wV6xSiGChTbPA==
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 01/15] ARM: dts: ox820: align interrupt controller node name with dtschema
Date: Wed,  1 Jun 2022 09:59:36 -0400
Message-Id: <20220601135951.2005085-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Neil Armstrong <narmstrong@baylibre.com>, Sasha Levin <sashal@kernel.org>, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io, devicetree@vger.kernel.org
List-ID: <linux-oxnas@groups.io>

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit fbcd5ad7a419ad40644a0bb8b4152bc660172d8a ]

Fixes dtbs_check warnings like:

  gic@1000: $nodename:0: 'gic@1000' does not match '^interrupt-controller=
(@[0-9a-f,]+)*$'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
Link: https://lore.kernel.org/r/20220317115705.450427-1-krzysztof.kozlows=
ki@canonical.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/ox820.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ox820.dtsi b/arch/arm/boot/dts/ox820.dtsi
index f7dddfb01f81..d629caf8b98f 100644
--- a/arch/arm/boot/dts/ox820.dtsi
+++ b/arch/arm/boot/dts/ox820.dtsi
@@ -286,7 +286,7 @@ local-timer@600 {
 				clocks =3D <&armclk>;
 			};
=20
-			gic: gic@1000 {
+			gic: interrupt-controller@1000 {
 				compatible =3D "arm,arm11mp-gic";
 				interrupt-controller;
 				#interrupt-cells =3D <3>;
--=20
2.35.1

