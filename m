Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web11.10706.1680126718142300477
 for <linux-oxnas@groups.io>;
 Wed, 29 Mar 2023 14:51:58 -0700
Received: by mail-wm1-f52.google.com with SMTP id i5-20020a05600c354500b003edd24054e0so12299109wmq.4
        for <linux-oxnas@groups.io>; Wed, 29 Mar 2023 14:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user; t=1680126716;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mR/Zj1PB00aaXey9QznQEyL9cgsnbEviFfaDBojU/PA=;
        b=X0RSiXgHE7YkzJiBvPfuECvjvZh/j9OCTlp5vS9G1kUZuHyE1mJThY46uxE8TkBE8F
         26YKvU03kRSEEbihp0nG/r6HBhciobPuGf3L9XG5lP7LIGmFx1xuZOCywjcKmPOmTu8N
         GYJA3eb2b0Q6VlUVpDCKV/9pvTj9LkixTX22pUdw50wCneJbfivXkkSI84dON9P5F9zR
         aPsg4Jeh3iGHabX4d9hb5dRKHYvbcqGCgHjWCSflhUWkYsO9R2cu9K7Yx5HZpgAK9C+P
         FR/T+Ct46EkosCoWvECTXbDfM4FfGO3jzQMNS58kzGepVwnhUrHOmPZqrc1qrzv6vlJT
         efvQ==
Return-Path: <jrtc27@jrtc27.com>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 08/21] riscv: dma-mapping: only invalidate after DMA, not flush
From: Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <20230327121317.4081816-9-arnd@kernel.org>
Date: Wed, 29 Mar 2023 22:51:54 +0100
Message-Id: <837F1B2F-7090-4F9F-A894-594ACF6A8DB2@jrtc27.com>
References: <20230327121317.4081816-1-arnd@kernel.org>
 <20230327121317.4081816-9-arnd@kernel.org>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
To: Arnd Bergmann <arnd@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Neil Armstrong <neil.armstrong@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S. Miller" <davem@davemloft.net>, Max Filippov <jcmvbkbc@gmail.com>, Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Conor Dooley <conor.dooley@microchip.com>, linux-snps-arc@lists.infradead.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-oxnas@groups.io, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org
List-ID: <linux-oxnas@groups.io>

On 27 Mar 2023, at 13:13, Arnd Bergmann <arnd@kernel.org> wrote:
>=20
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> No other architecture intentionally writes back dirty cache lines into
> a buffer that a device has just finished writing into. If the cache is
> clean, this has no effect at all, but if a cacheline in the buffer has
> actually been written by the CPU,  there is a drive bug that is likely
> made worse by overwriting that buffer.

FYI [1] proposed this same change a while ago but its justification was
flawed (which was my objection at the time, not the diff itself).

Jess

[1] https://lore.kernel.org/all/20220818165105.99746-1-s.miroshnichenko@yad=
ro.com

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> arch/riscv/mm/dma-noncoherent.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoher=
ent.c
> index d919efab6eba..640f4c496d26 100644
> --- a/arch/riscv/mm/dma-noncoherent.c
> +++ b/arch/riscv/mm/dma-noncoherent.c
> @@ -42,7 +42,7 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t si=
ze,
> 		break;
> 	case DMA_FROM_DEVICE:
> 	case DMA_BIDIRECTIONAL:
> -		ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
> +		ALT_CMO_OP(inval, vaddr, size, riscv_cbom_block_size);
> 		break;
> 	default:
> 		break;
> --=20
> 2.39.2
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

