Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mx.groups.io with SMTP id smtpd.web11.20482.1683265658697981980
 for <linux-oxnas@groups.io>;
 Thu, 04 May 2023 22:47:38 -0700
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 2EBF163B2D
	for <linux-oxnas@groups.io>; Fri,  5 May 2023 05:47:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E9CC4339E
	for <linux-oxnas@groups.io>; Fri,  5 May 2023 05:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683265657;
	bh=TmEJ43a9wRyU79Q4Z9WHv4VZR6aLeCdSzDRMZZtHgkE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Z26bR3GD7NZekm8D2fY3Likq3Z+WzMYLxGNnfeJCb+QwNkNe2TrCsNu2VFfZjShat
	 waIgr8ZT+ardQLvN1NlwZYzH5cZxJYxowJsqGOWno8Rl9LGCyRjXrN4kUrT0wSjKA3
	 va31vYv4BfxRUWA0U1ACB0SZxiczkJ6ChjLmeQmgK6um5tf4OdsSdlBmir+dXjr7Ib
	 eodQwnLUWN7khfewboLikhJjzXtjqnFi+oOdZSrfft8Feutqpt4nrnNIFe7eshzIjL
	 2R7E0+HCH9g3/5K1V+VPwNnTCBGdmrwdimg1OJKzf3tZSMKqnn1Z4uKwCieN6lGWZq
	 wQHAZd8sjvaLg==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2a8ad872ea5so15630631fa.2
        for <linux-oxnas@groups.io>; Thu, 04 May 2023 22:47:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230327121317.4081816-1-arnd@kernel.org> <20230327121317.4081816-10-arnd@kernel.org>
In-Reply-To: <20230327121317.4081816-10-arnd@kernel.org>
From: Guo Ren <guoren@kernel.org>
Date: Fri, 5 May 2023 13:47:03 +0800
Message-ID: <CAJF2gTT2VCVMJs1NvgK66uD+BhObjM2WNxf2RY7wTZsho4sjVA@mail.gmail.com>
Subject: Re: [PATCH 09/21] riscv: dma-mapping: skip invalidation before bidirectional DMA
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>, Russell King <linux@armlinux.org.uk>, Neil Armstrong <neil.armstrong@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S. Miller" <davem@davemloft.net>, Max Filippov <jcmvbkbc@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Conor Dooley <conor.dooley@microchip.com>, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org
List-ID: <linux-oxnas@groups.io>

On Mon, Mar 27, 2023 at 8:15=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> For a DMA_BIDIRECTIONAL transfer, the caches have to be cleaned
> first to let the device see data written by the CPU, and invalidated
> after the transfer to let the CPU see data written by the device.
>
> riscv also invalidates the caches before the transfer, which does
> not appear to serve any purpose.
Yes, we can't guarantee the CPU pre-load cache lines randomly during
dma working.

But I've two purposes to keep invalidates before dma transfer:
 - We clearly tell the CPU these cache lines are invalid. The caching
algorithm would use these invalid slots first instead of replacing
valid ones.
 - Invalidating is very cheap. Actually, flush and clean have the same
performance in our machine.

So, how about:

diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoheren=
t.c
index d919efab6eba..2c52fbc15064 100644
--- a/arch/riscv/mm/dma-noncoherent.c
+++ b/arch/riscv/mm/dma-noncoherent.c
@@ -22,8 +22,6 @@ void arch_sync_dma_for_device(phys_addr_t paddr, size_t s=
ize,
                ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
                break;
        case DMA_FROM_DEVICE:
-               ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
-               break;
        case DMA_BIDIRECTIONAL:
                ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
                break;
@@ -42,7 +40,7 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size=
,
                break;
        case DMA_FROM_DEVICE:
        case DMA_BIDIRECTIONAL:
                /* I'm not sure all drivers have guaranteed cacheline
alignment. If not, this inval would cause problems */
-               ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
+               ALT_CMO_OP(inval, vaddr, size, riscv_cbom_block_size);
                break;
        default:
                break;

>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/riscv/mm/dma-noncoherent.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoher=
ent.c
> index 640f4c496d26..69c80b2155a1 100644
> --- a/arch/riscv/mm/dma-noncoherent.c
> +++ b/arch/riscv/mm/dma-noncoherent.c
> @@ -25,7 +25,7 @@ void arch_sync_dma_for_device(phys_addr_t paddr, size_t=
 size,
>                 ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
>                 break;
>         case DMA_BIDIRECTIONAL:
> -               ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
> +               ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
>                 break;
>         default:
>                 break;
> --
> 2.39.2
>


--=20
Best Regards
 Guo Ren
