Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mx.groups.io with SMTP id smtpd.web11.33323.1679919370649494076
 for <linux-oxnas@groups.io>;
 Mon, 27 Mar 2023 05:16:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679919367;
	bh=YBtSO0RmdwE2AW1zN7HUJxa9NfwhIOXNCN8O+lzIRNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UN64uPXQtdeLkLg4dn09AzIarAchhb4d1x34/SjwyiZWrDrJBuSzm2pjxivirdXOH
	 jDWvdVBlPURZiAbbZkwr+j/acZdOxZqq6cGIPFvZdjZpd4mtJpLB9c6+CCJIpq7WlT
	 yKwLGhptYzLT9fUIHqk5I/wF2qbPA7Jz2AgpBslZNOD+sEJ3MsZmMDIhBSPTN1n5u3
	 xeD/9JePzosgXXiQzUg8ldJpqSjwUr9LKOTYJUPw5exVgHkbXy8JjWNj5CwfmVQvWQ
	 Tf5G78NWWF9z4lJFW3lBVqt8Ks2rBF4G8TjU0+Ep1wg2uWq1/XkSNqoo9R0+XEHkMt
	 ETlJDU59jGtbg==
From: Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH 15/21] ARM: dma-mapping: always invalidate WT caches before DMA
Date: Mon, 27 Mar 2023 14:13:11 +0200
Message-Id: <20230327121317.4081816-16-arnd@kernel.org>
In-Reply-To: <20230327121317.4081816-1-arnd@kernel.org>
References: <20230327121317.4081816-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Neil Armstrong <neil.armstrong@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S. Miller" <davem@davemloft.net>, Max Filippov <jcmvbkbc@gmail.com>, Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Conor Dooley <conor.dooley@microchip.com>, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org
List-ID: <linux-oxnas@groups.io>

From: Arnd Bergmann <arnd@arndb.de>

Most ARM CPUs can have write-back caches and that require
cache management to be done in the dma_sync_*_for_device()
operation. This is typically done in both writeback and
writethrough mode.

The cache-v4.S (arm720/740/7tdmi/9tdmi) and cache-v4wt.S
(arm920t, arm940t) implementations are the exception here,
and only do the cache management after the DMA is complete,
in the dma_sync_*_for_cpu() operation.

Change this for consistency with the other platforms. This
should have no user visible effect.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mm/cache-v4.S   | 8 ++++----
 arch/arm/mm/cache-v4wt.S | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mm/cache-v4.S b/arch/arm/mm/cache-v4.S
index 7787057e4990..e2b104876340 100644
--- a/arch/arm/mm/cache-v4.S
+++ b/arch/arm/mm/cache-v4.S
@@ -117,23 +117,23 @@ ENTRY(v4_dma_flush_range)
 	ret	lr
=20
 /*
- *	dma_unmap_area(start, size, dir)
+ *	dma_map_area(start, size, dir)
  *	- start	- kernel virtual start address
  *	- size	- size of region
  *	- dir	- DMA direction
  */
-ENTRY(v4_dma_unmap_area)
+ENTRY(v4_dma_map_area)
 	teq	r2, #DMA_TO_DEVICE
 	bne	v4_dma_flush_range
 	/* FALLTHROUGH */
=20
 /*
- *	dma_map_area(start, size, dir)
+ *	dma_unmap_area(start, size, dir)
  *	- start	- kernel virtual start address
  *	- size	- size of region
  *	- dir	- DMA direction
  */
-ENTRY(v4_dma_map_area)
+ENTRY(v4_dma_unmap_area)
 	ret	lr
 ENDPROC(v4_dma_unmap_area)
 ENDPROC(v4_dma_map_area)
diff --git a/arch/arm/mm/cache-v4wt.S b/arch/arm/mm/cache-v4wt.S
index 0b290c25a99d..652218752f88 100644
--- a/arch/arm/mm/cache-v4wt.S
+++ b/arch/arm/mm/cache-v4wt.S
@@ -172,24 +172,24 @@ v4wt_dma_inv_range:
 	.equ	v4wt_dma_flush_range, v4wt_dma_inv_range
=20
 /*
- *	dma_unmap_area(start, size, dir)
+ *	dma_map_area(start, size, dir)
  *	- start	- kernel virtual start address
  *	- size	- size of region
  *	- dir	- DMA direction
  */
-ENTRY(v4wt_dma_unmap_area)
+ENTRY(v4wt_dma_map_area)
 	add	r1, r1, r0
 	teq	r2, #DMA_TO_DEVICE
 	bne	v4wt_dma_inv_range
 	/* FALLTHROUGH */
=20
 /*
- *	dma_map_area(start, size, dir)
+ *	dma_unmap_area(start, size, dir)
  *	- start	- kernel virtual start address
  *	- size	- size of region
  *	- dir	- DMA direction
  */
-ENTRY(v4wt_dma_map_area)
+ENTRY(v4wt_dma_unmap_area)
 	ret	lr
 ENDPROC(v4wt_dma_unmap_area)
 ENDPROC(v4wt_dma_map_area)
--=20
2.39.2

