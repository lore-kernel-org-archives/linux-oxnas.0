Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mx.groups.io with SMTP id smtpd.web11.33309.1679919318852339645
 for <linux-oxnas@groups.io>;
 Mon, 27 Mar 2023 05:15:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679919315;
	bh=gK+eQNvNHVtgIlRiu3kF6HYH3yBsX0klGJL13i4k/aU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sMy3k5gM2XS604J4ArMuSWvMXzgs2AlKyYx4fCZS7J/lWvOZ2Yw/Z/jrtMa5gIHU9
	 FjlooO1xQTngsA6hbEvqN4tEnshVSie7B+AEJaU1Cy1oTWuJpEfFFlaRXS3tq+GwRJ
	 er3cljYGerTP/ivX+B9p913oVNSRI6mJdCnknZw/+Go9C3u3Axj27xDUpsuC4nBj8r
	 bgnEtVHNKaiAki6GHJ1OFvO5x00a1gCx3DhHWTCMKP7Wv9fwGxJu8GpPhhiTKRkk1x
	 zZRoP0hNRHHFBO8EoUedx3N9IqVzTMyc60Fp/OWdtgr6CAuRCyXfSdikQcmkzRIL2M
	 hyE6lbMlfVtJQ==
From: Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH 09/21] riscv: dma-mapping: skip invalidation before bidirectional DMA
Date: Mon, 27 Mar 2023 14:13:05 +0200
Message-Id: <20230327121317.4081816-10-arnd@kernel.org>
In-Reply-To: <20230327121317.4081816-1-arnd@kernel.org>
References: <20230327121317.4081816-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Neil Armstrong <neil.armstrong@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S. Miller" <davem@davemloft.net>, Max Filippov <jcmvbkbc@gmail.com>, Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Conor Dooley <conor.dooley@microchip.com>, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org
List-ID: <linux-oxnas@groups.io>

From: Arnd Bergmann <arnd@arndb.de>

For a DMA_BIDIRECTIONAL transfer, the caches have to be cleaned
first to let the device see data written by the CPU, and invalidated
after the transfer to let the CPU see data written by the device.

riscv also invalidates the caches before the transfer, which does
not appear to serve any purpose.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/riscv/mm/dma-noncoherent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoher=
ent.c
index 640f4c496d26..69c80b2155a1 100644
--- a/arch/riscv/mm/dma-noncoherent.c
+++ b/arch/riscv/mm/dma-noncoherent.c
@@ -25,7 +25,7 @@ void arch_sync_dma_for_device(phys_addr_t paddr, size_t=
 size,
 		ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
 		break;
 	case DMA_BIDIRECTIONAL:
-		ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
+		ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
 		break;
 	default:
 		break;
--=20
2.39.2

