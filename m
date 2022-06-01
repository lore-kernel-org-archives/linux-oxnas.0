Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mx.groups.io with SMTP id smtpd.web12.7895.1654091884165185290
 for <linux-oxnas@groups.io>;
 Wed, 01 Jun 2022 06:58:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1654091883;
	bh=meEEYYb4Q/Zwm6saccKdiTfafAQE+aqAUob7xdy2nqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PWbZWtP+dsiT//TTt4Vo4op/Zzs5vVRx620+kg3hCf3gRUtB3eE22WdS/ih3Wswzq
	 qcGBCWE5s2iW2gBjv83JFIm1XyS/gTY47784DK1FYuvy+yRVwLGzHRg4B/oo368hSN
	 NqKt4b4Ib1WECRtQRPS2g5HbBIrac88nANsBWZA7utTp6fHpbw93SiH2pWHkkVQqzZ
	 x8VW753NyiWO4by5dOswzi/Nwl9Pz75s5o/3KWU4UQefZbbxdf0weJS/EciYPKoZXo
	 cTH0xFD/8EzoX6lvMmYdIS1wfk0pvzKgNpxp/WXit5iO5U75D+CfPDPEcUBhfDoE1E
	 UA+DmGlTHnwAg==
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.10 02/26] ARM: dts: ox820: align interrupt controller node name with dtschema
Date: Wed,  1 Jun 2022 09:57:35 -0400
Message-Id: <20220601135759.2004435-2-sashal@kernel.org>
In-Reply-To: <20220601135759.2004435-1-sashal@kernel.org>
References: <20220601135759.2004435-1-sashal@kernel.org>
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
index 90846a7655b4..dde4364892bf 100644
--- a/arch/arm/boot/dts/ox820.dtsi
+++ b/arch/arm/boot/dts/ox820.dtsi
@@ -287,7 +287,7 @@ local-timer@600 {
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

