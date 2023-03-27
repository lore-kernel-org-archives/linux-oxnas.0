Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mx.groups.io with SMTP id smtpd.web10.35043.1679924277585445931
 for <linux-oxnas@groups.io>;
 Mon, 27 Mar 2023 06:37:57 -0700
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 0D5FB61291
	for <linux-oxnas@groups.io>; Mon, 27 Mar 2023 13:37:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7760BC4339B
	for <linux-oxnas@groups.io>; Mon, 27 Mar 2023 13:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679924276;
	bh=sKw5GnPYWTx1tEo+IYG63yzmzH5uUSkHi5W70RXeiXE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Or5bYP6asvBi3DIpTvEDxCFWIn2Cdch8Z5XdxQI6zEoEgJRZqrecdpv7paLYKT9CC
	 ykTFqWwusdSTCL1jiwj6kNclHXsXGO9Z8Pgkx7W7viSa5CpCaPtlyRvpzazCaoEuAl
	 ON63aoYpCrVIWtjBx0qMwiWtOPd+kCdAaYbmijioiOFv8Xk/z7uUP1W0Z3J67+Uczj
	 eiWgDOj8fZ+i/pe8lRkJZPQBpygL51cztm9uvH3QS8WYX5TkpZllEvJLjYFEuEB3rP
	 MooCMJzwn6fbb9SnJ9RBXy+iRWjhvjn2PfTrafIOUz6E5Yp51QeINLA4MxBUmdB567
	 RtP9F30M7zWeA==
Received: by mail-lf1-f54.google.com with SMTP id i13so11484769lfe.9
        for <linux-oxnas@groups.io>; Mon, 27 Mar 2023 06:37:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230327121317.4081816-1-arnd@kernel.org> <20230327121317.4081816-11-arnd@kernel.org>
In-Reply-To: <20230327121317.4081816-11-arnd@kernel.org>
From: Guo Ren <guoren@kernel.org>
Date: Mon, 27 Mar 2023 21:37:22 +0800
Message-ID: <CAJF2gTT73KBZ01N2fr8z6=9XWFKo4D7cGKOtZLZeXN9NrscCXg@mail.gmail.com>
Subject: Re: [PATCH 10/21] csky: dma-mapping: skip invalidating before DMA from device
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Neil Armstrong <neil.armstrong@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S. Miller" <davem@davemloft.net>, Max Filippov <jcmvbkbc@gmail.com>, Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Conor Dooley <conor.dooley@microchip.com>, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org
List-ID: <linux-oxnas@groups.io>

On Mon, Mar 27, 2023 at 8:15=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> csky is the only architecture that does a full flush for the
> dma_sync_*_for_device(..., DMA_FROM_DEVICE) operation. The requirement
> is only make sure there are no dirty cache lines for the buffer,
> which can be either done through an invalidate operation (as on most
> architectures including arm32, mips and arc), or a writeback (as on
> arm64 and riscv). The cache also has to be invalidated eventually but
> csky already does that after the transfer.
>
> Use a 'clean' operation here for consistency with arm64 and riscv.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/csky/mm/dma-mapping.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/arch/csky/mm/dma-mapping.c b/arch/csky/mm/dma-mapping.c
> index 82447029feb4..c90f912e2822 100644
> --- a/arch/csky/mm/dma-mapping.c
> +++ b/arch/csky/mm/dma-mapping.c
> @@ -60,11 +60,9 @@ void arch_sync_dma_for_device(phys_addr_t paddr, size_=
t size,
>  {
>         switch (dir) {
>         case DMA_TO_DEVICE:
> -               cache_op(paddr, size, dma_wb_range);
> -               break;
>         case DMA_FROM_DEVICE:
>         case DMA_BIDIRECTIONAL:
> -               cache_op(paddr, size, dma_wbinv_range);
> +               cache_op(paddr, size, dma_wb_range);
Reviewed-by: Guo Ren <guoren@kernel.org>


>                 break;
>         default:
>                 BUG();
> --
> 2.39.2
>


--=20
Best Regards
 Guo Ren
