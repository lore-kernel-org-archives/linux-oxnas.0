Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mx.groups.io with SMTP id smtpd.web11.33311.1679919325106513247
 for <linux-oxnas@groups.io>;
 Mon, 27 Mar 2023 05:15:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679919324;
	bh=X7ixDT/eME8zr2M/ikt5bC5rQoS3uASy2IlC1ftIdSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y2ffntjZwCcvJ7ZjcddqfIzivLJJTiZqbCBMhicCNOoftlZSKr8SZk1bt+v6QBdJ3
	 AqWhwmcTeaS96y4RUjpqI9FGKTqNfAOz/7RBt+ymuWQLCwljPJr+H8JgdNwFdqMXwE
	 J72tIuLXAnxcA7lDtjwg32UTtKQ0DkssHKQnBWYb3L+gXkApRayP0Mte6XTqD4QU75
	 zUBFdzaO9TiPGVooVFe2U07En2yoiRB9h1tj51608yH2BmWke6vfUVRIXO9jhZyAf0
	 Nifety/7HWh8t+jBWCaVsZT7PH2v1d96plBTbAk5HzBMivkiokDHTCIu3jr6mGkPTw
	 a3+V9R9fKm3ag==
From: Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH 10/21] csky: dma-mapping: skip invalidating before DMA from device
Date: Mon, 27 Mar 2023 14:13:06 +0200
Message-Id: <20230327121317.4081816-11-arnd@kernel.org>
In-Reply-To: <20230327121317.4081816-1-arnd@kernel.org>
References: <20230327121317.4081816-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Neil Armstrong <neil.armstrong@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S. Miller" <davem@davemloft.net>, Max Filippov <jcmvbkbc@gmail.com>, Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Conor Dooley <conor.dooley@microchip.com>, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org
List-ID: <linux-oxnas@groups.io>

From: Arnd Bergmann <arnd@arndb.de>

csky is the only architecture that does a full flush for the
dma_sync_*_for_device(..., DMA_FROM_DEVICE) operation. The requirement
is only make sure there are no dirty cache lines for the buffer,
which can be either done through an invalidate operation (as on most
architectures including arm32, mips and arc), or a writeback (as on
arm64 and riscv). The cache also has to be invalidated eventually but
csky already does that after the transfer.

Use a 'clean' operation here for consistency with arm64 and riscv.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/mm/dma-mapping.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/csky/mm/dma-mapping.c b/arch/csky/mm/dma-mapping.c
index 82447029feb4..c90f912e2822 100644
--- a/arch/csky/mm/dma-mapping.c
+++ b/arch/csky/mm/dma-mapping.c
@@ -60,11 +60,9 @@ void arch_sync_dma_for_device(phys_addr_t paddr, size_=
t size,
 {
 	switch (dir) {
 	case DMA_TO_DEVICE:
-		cache_op(paddr, size, dma_wb_range);
-		break;
 	case DMA_FROM_DEVICE:
 	case DMA_BIDIRECTIONAL:
-		cache_op(paddr, size, dma_wbinv_range);
+		cache_op(paddr, size, dma_wb_range);
 		break;
 	default:
 		BUG();
--=20
2.39.2

