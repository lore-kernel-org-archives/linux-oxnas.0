Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mx.groups.io with SMTP id smtpd.web10.33171.1679919282277359763
 for <linux-oxnas@groups.io>;
 Mon, 27 Mar 2023 05:14:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679919281;
	bh=hpHzcJ3T0vShL1lzlkbvi7pqgHNybQdWukxJR0vOP3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mfm6R/WQZMh61DGU+9uuCWkv0/tyJ6gJGGUPX4zG+Mk/WG5WkNGo0dAhhcwKvkeNZ
	 Z7uItq3PdOnRh7TPukjXUvNYAGRmmdeX8JS3mT3qo9kJY6F3XOZKksXOchdcM4Ox8m
	 YIgytC8vdHgG83EpJ1D/64cYqPwsTsUhPZ6rhpeC62QxfG4lJkjHaP4sM0VmU9aHOb
	 tvmNcya7wRhmDLi1iqOu44WhuiEB0TW0zubz6bYucmFVCHU+7L/S2wlSb9kE6kLicK
	 5hCctagI4UhCeLS7HyFjmcfLaXiJY5HRdWEL6v0y+dDF92dndyAz6eMDrhb79Jejef
	 K08wGLvDTfBVg==
From: Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH 05/21] powerpc: dma-mapping: split out cache operation logic
Date: Mon, 27 Mar 2023 14:13:01 +0200
Message-Id: <20230327121317.4081816-6-arnd@kernel.org>
In-Reply-To: <20230327121317.4081816-1-arnd@kernel.org>
References: <20230327121317.4081816-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Neil Armstrong <neil.armstrong@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S. Miller" <davem@davemloft.net>, Max Filippov <jcmvbkbc@gmail.com>, Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Conor Dooley <conor.dooley@microchip.com>, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org
List-ID: <linux-oxnas@groups.io>

From: Arnd Bergmann <arnd@arndb.de>

The powerpc arch_sync_dma_for_device()/arch_sync_dma_for_cpu() functions
behave differently from all other architectures, at least for some of
the operations.

As a preparation for making the behavior more consistent, reorder the
logic in which they decide whether to flush, invalidate or clean the.
No change in behavior is intended.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/mm/dma-noncoherent.c | 91 +++++++++++++++++++++----------
 1 file changed, 63 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/mm/dma-noncoherent.c b/arch/powerpc/mm/dma-nonc=
oherent.c
index 30260b5d146d..f10869d27de5 100644
--- a/arch/powerpc/mm/dma-noncoherent.c
+++ b/arch/powerpc/mm/dma-noncoherent.c
@@ -16,31 +16,28 @@
 #include <asm/tlbflush.h>
 #include <asm/dma.h>
=20
+enum dma_cache_op {
+	DMA_CACHE_CLEAN,
+	DMA_CACHE_INVAL,
+	DMA_CACHE_FLUSH,
+};
+
 /*
  * make an area consistent.
  */
-static void __dma_sync(void *vaddr, size_t size, int direction)
+static void __dma_op(void *vaddr, size_t size, enum dma_cache_op op)
 {
 	unsigned long start =3D (unsigned long)vaddr;
 	unsigned long end   =3D start + size;
=20
-	switch (direction) {
-	case DMA_NONE:
-		BUG();
-	case DMA_FROM_DEVICE:
-		/*
-		 * invalidate only when cache-line aligned otherwise there is
-		 * the potential for discarding uncommitted data from the cache
-		 */
-		if ((start | end) & (L1_CACHE_BYTES - 1))
-			flush_dcache_range(start, end);
-		else
-			invalidate_dcache_range(start, end);
-		break;
-	case DMA_TO_DEVICE:		/* writeback only */
+	switch (op) {
+	case DMA_CACHE_CLEAN:
 		clean_dcache_range(start, end);
 		break;
-	case DMA_BIDIRECTIONAL:	/* writeback and invalidate */
+	case DMA_CACHE_INVAL:
+		invalidate_dcache_range(start, end);
+		break;
+	case DMA_CACHE_FLUSH:
 		flush_dcache_range(start, end);
 		break;
 	}
@@ -48,16 +45,16 @@ static void __dma_sync(void *vaddr, size_t size, int =
direction)
=20
 #ifdef CONFIG_HIGHMEM
 /*
- * __dma_sync_page() implementation for systems using highmem.
+ * __dma_highmem_op() implementation for systems using highmem.
  * In this case, each page of a buffer must be kmapped/kunmapped
- * in order to have a virtual address for __dma_sync(). This must
+ * in order to have a virtual address for __dma_op(). This must
  * not sleep so kmap_atomic()/kunmap_atomic() are used.
  *
  * Note: yes, it is possible and correct to have a buffer extend
  * beyond the first page.
  */
-static inline void __dma_sync_page_highmem(struct page *page,
-		unsigned long offset, size_t size, int direction)
+static inline void __dma_highmem_op(struct page *page,
+		unsigned long offset, size_t size, enum dma_cache_op op)
 {
 	size_t seg_size =3D min((size_t)(PAGE_SIZE - offset), size);
 	size_t cur_size =3D seg_size;
@@ -71,7 +68,7 @@ static inline void __dma_sync_page_highmem(struct page =
*page,
 		start =3D (unsigned long)kmap_atomic(page + seg_nr) + seg_offset;
=20
 		/* Sync this buffer segment */
-		__dma_sync((void *)start, seg_size, direction);
+		__dma_op((void *)start, seg_size, op);
 		kunmap_atomic((void *)start);
 		seg_nr++;
=20
@@ -88,32 +85,70 @@ static inline void __dma_sync_page_highmem(struct pag=
e *page,
 #endif /* CONFIG_HIGHMEM */
=20
 /*
- * __dma_sync_page makes memory consistent. identical to __dma_sync, but
- * takes a struct page instead of a virtual address
+ * __dma_phys_op makes memory consistent. identical to __dma_op, but
+ * takes a phys_addr_t instead of a virtual address
  */
-static void __dma_sync_page(phys_addr_t paddr, size_t size, int dir)
+static void __dma_phys_op(phys_addr_t paddr, size_t size, enum dma_cache=
_op op)
 {
 	struct page *page =3D pfn_to_page(paddr >> PAGE_SHIFT);
 	unsigned offset =3D paddr & ~PAGE_MASK;
=20
 #ifdef CONFIG_HIGHMEM
-	__dma_sync_page_highmem(page, offset, size, dir);
+	__dma_highmem_op(page, offset, size, op);
 #else
 	unsigned long start =3D (unsigned long)page_address(page) + offset;
-	__dma_sync((void *)start, size, dir);
+	__dma_op((void *)start, size, op);
 #endif
 }
=20
 void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
 		enum dma_data_direction dir)
 {
-	__dma_sync_page(paddr, size, dir);
+	switch (direction) {
+	case DMA_NONE:
+		BUG();
+	case DMA_FROM_DEVICE:
+		/*
+		 * invalidate only when cache-line aligned otherwise there is
+		 * the potential for discarding uncommitted data from the cache
+		 */
+		if ((start | end) & (L1_CACHE_BYTES - 1))
+			__dma_phys_op(start, end, DMA_CACHE_FLUSH);
+		else
+			__dma_phys_op(start, end, DMA_CACHE_INVAL);
+		break;
+	case DMA_TO_DEVICE:		/* writeback only */
+		__dma_phys_op(start, end, DMA_CACHE_CLEAN);
+		break;
+	case DMA_BIDIRECTIONAL:	/* writeback and invalidate */
+		__dma_phys_op(start, end, DMA_CACHE_FLUSH);
+		break;
+	}
 }
=20
 void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
 		enum dma_data_direction dir)
 {
-	__dma_sync_page(paddr, size, dir);
+	switch (direction) {
+	case DMA_NONE:
+		BUG();
+	case DMA_FROM_DEVICE:
+		/*
+		 * invalidate only when cache-line aligned otherwise there is
+		 * the potential for discarding uncommitted data from the cache
+		 */
+		if ((start | end) & (L1_CACHE_BYTES - 1))
+			__dma_phys_op(start, end, DMA_CACHE_FLUSH);
+		else
+			__dma_phys_op(start, end, DMA_CACHE_INVAL);
+		break;
+	case DMA_TO_DEVICE:		/* writeback only */
+		__dma_phys_op(start, end, DMA_CACHE_CLEAN);
+		break;
+	case DMA_BIDIRECTIONAL:	/* writeback and invalidate */
+		__dma_phys_op(start, end, DMA_CACHE_FLUSH);
+		break;
+	}
 }
=20
 void arch_dma_prep_coherent(struct page *page, size_t size)
--=20
2.39.2

