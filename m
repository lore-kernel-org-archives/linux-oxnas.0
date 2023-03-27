Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mx.groups.io with SMTP id smtpd.web10.33166.1679919265009855664
 for <linux-oxnas@groups.io>;
 Mon, 27 Mar 2023 05:14:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679919264;
	bh=/zMPyAlfGd5fpJsITtg1RxPyUHI2dqVyx+YefpHkWXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d1KUM73yCUytmr56IfxXPD1HZ5UAmAKM+0CBBY3u49w6bNCyrB2sEPtREvafbUkjb
	 CFGZfI0FCfmknT0h+L+eXyaIpkkJwi4v3Z4EgaKViz+/z9QPPlnu3v9F3flYQ26Q7U
	 q3EOb110zv0M3qi2mMyrlqEWXlVpt/VQQyKgll7QY7/XsuTxEM/ZKlPsmMjjXqmTMk
	 uGUPoZTe4WHm4gicfHvkF72XI2puokOkW3TeQ/sk06+15hCStezZtavWZrwr2jQs/G
	 iy1gH+XnYUCVyfsVu1+ZP4/ApT59WEmDcash0EKA5e1KL8ASTdihabMg2li4cEac/w
	 6iZEB7B78CFDw==
From: Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH 03/21] sparc32: flush caches in dma_sync_*for_device
Date: Mon, 27 Mar 2023 14:12:59 +0200
Message-Id: <20230327121317.4081816-4-arnd@kernel.org>
In-Reply-To: <20230327121317.4081816-1-arnd@kernel.org>
References: <20230327121317.4081816-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Neil Armstrong <neil.armstrong@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S. Miller" <davem@davemloft.net>, Max Filippov <jcmvbkbc@gmail.com>, Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Conor Dooley <conor.dooley@microchip.com>, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org
List-ID: <linux-oxnas@groups.io>

From: Arnd Bergmann <arnd@arndb.de>

Leon has a very minimalistic cache that has no range operations
and requires being flushed entirely to deal with noncoherent
DMA. Most in-order architectures do their cache management in
the dma_sync_*for_device() operations rather than dma_sync_*for_cpu.

Since the cache is write-through only, both should have the same
effect, so change it for consistency with the other architectures.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/sparc/Kconfig         | 2 +-
 arch/sparc/kernel/ioport.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 84437a4c6545..637da50e236c 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -51,7 +51,7 @@ config SPARC
 config SPARC32
 	def_bool !64BIT
 	select ARCH_32BIT_OFF_T
-	select ARCH_HAS_SYNC_DMA_FOR_CPU
+	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select CLZ_TAB
 	select DMA_DIRECT_REMAP
 	select GENERIC_ATOMIC64
diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index 4e4f3d3263e4..4f3d26066ec2 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -306,7 +306,7 @@ arch_initcall(sparc_register_ioport);
  * On LEON systems without cache snooping, the entire D-CACHE must be fl=
ushed to
  * make DMA to cacheable memory coherent.
  */
-void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
+void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
 		enum dma_data_direction dir)
 {
 	if (dir !=3D DMA_TO_DEVICE &&
--=20
2.39.2

