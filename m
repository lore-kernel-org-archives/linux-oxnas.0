Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mx.groups.io with SMTP id smtpd.web11.8040.1654092031503942273
 for <linux-oxnas@groups.io>;
 Wed, 01 Jun 2022 07:00:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1654092030;
	bh=z42OExAeZKAzjkFiuxCksJlnicHhYdUI6Nt4NvmD5S4=;
	h=From:To:Cc:Subject:Date:From;
	b=f+mP6Wna7gS/E44PrVT5Y/QeV2WXd2aSm8Y2LiWkvhPg0Dljpt3rAN64E2Ai2Cgq/
	 zNUboc3lgtNRohSybVUoZNQFowQLs1cqQxe4JDETclVwGbqrZcc+5hjNJU26ANf1o1
	 hL1KJDis/lqiV55RFlztXU5Kqhc1Tt15yomWsj3WUqGITlZd/vFpS3XR69hGnu60xT
	 mKMuMaywUh9RXt9Kkeu7Oz95dMxPEez2KtuibKMjrBSsAnsRmpTXXuaeiWUb1j/E4r
	 rV1gw999y8S5pxT4jkrOYmOSb3N6LdMvntqAgpp4eF5+CQGgSVY3MluC0IZ9nAEqBh
	 7ZJsOm7xcJ3rw==
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 01/14] ARM: dts: ox820: align interrupt controller node name with dtschema
Date: Wed,  1 Jun 2022 10:00:14 -0400
Message-Id: <20220601140027.2005280-1-sashal@kernel.org>
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
index 8355cb034525..3382b1a9cac9 100644
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

