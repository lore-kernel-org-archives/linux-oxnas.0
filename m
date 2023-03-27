Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mx.groups.io with SMTP id smtpd.web11.33316.1679919334926780756
 for <linux-oxnas@groups.io>;
 Mon, 27 Mar 2023 05:15:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679919333;
	bh=1A9PPhpjfn5VxBSmEZUVZ96wOnXUnzHwhEr/+6UxMII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZTcyGdTSTyjUcBoLSVeACST/PtG6gZO3O0XJKQPppvSvNB4NDcy90mHMF4gJPiNS6
	 dNtpCw1Tg4EZtsG9wUbybuw0872LTI9FUQllw/7Q76rCvz6Crnc81KUI9Kj4chNtUZ
	 csalhGjvFzfmW3DiLJ6yzIpVXX+f5lcRxoFKXzIm876A40pKei6+o+8NXVAEYBZqzo
	 s4oPjpuA8RpmeGU6lv0FlQ6gA3tl8++a/WzT9oNtEmsVj2YTsrbo7DHFpEIVM4/NkV
	 v133TD824709IDedq8WaO7uGv2weYLR4T+0csPE1290Z1QSEI0fkOubzH+lLl8W9RM
	 VLW1WwaNQGF9g==
From: Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH 11/21] mips: dma-mapping: skip invalidating before bidirectional DMA
Date: Mon, 27 Mar 2023 14:13:07 +0200
Message-Id: <20230327121317.4081816-12-arnd@kernel.org>
In-Reply-To: <20230327121317.4081816-1-arnd@kernel.org>
References: <20230327121317.4081816-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Neil Armstrong <neil.armstrong@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S. Miller" <davem@davemloft.net>, Max Filippov <jcmvbkbc@gmail.com>, Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Conor Dooley <conor.dooley@microchip.com>, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org
List-ID: <linux-oxnas@groups.io>

From: Arnd Bergmann <arnd@arndb.de>

Some architectures that need to invalidate buffers after bidirectional
DMA because of speculative prefetching only do a simpler writeback
before that DMA, while architectures that don't need to do the second
invalidate tend to have a combined writeback+invalidate before the
DMA.

The behavior on mips is slightly inconsistent, as it always
does the invalidation before bidirectional DMA and conditionally
does it a second time.

In order to make the behavior the same as the rest, change it
so that there is exactly one invalidation here, either before
or after the DMA.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/mm/dma-noncoherent.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/mips/mm/dma-noncoherent.c b/arch/mips/mm/dma-noncoheren=
t.c
index 3c4fc97b9f39..b4350faf4f1e 100644
--- a/arch/mips/mm/dma-noncoherent.c
+++ b/arch/mips/mm/dma-noncoherent.c
@@ -65,7 +65,11 @@ static inline void dma_sync_virt_for_device(void *addr=
, size_t size,
 		dma_cache_inv((unsigned long)addr, size);
 		break;
 	case DMA_BIDIRECTIONAL:
-		dma_cache_wback_inv((unsigned long)addr, size);
+		if (IS_ENABLED(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) &&
+		    cpu_needs_post_dma_flush())
+			dma_cache_wback((unsigned long)addr, size);
+		else
+			dma_cache_wback_inv((unsigned long)addr, size);
 		break;
 	default:
 		BUG();
--=20
2.39.2

