Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
 by mx.groups.io with SMTP id smtpd.web11.25203.1680182806390353700
 for <linux-oxnas@groups.io>;
 Thu, 30 Mar 2023 06:26:46 -0700
Received: by mail-il1-f176.google.com with SMTP id j2so2768170ila.8
        for <linux-oxnas@groups.io>; Thu, 30 Mar 2023 06:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680182805; x=1682774805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2pZnebNGLahNe2yjgjrKsFqnYvTRYd7uF1JoUeedu4=;
        b=ipMmc4f2rhe9ZxmiesNtaMCdByaDBx7tN+zc7KMJSrXwy2WiELheDph1YzfOyUJK5G
         2D9w1lws05LiLD96ktr9W079igf4FZMXTfy1rli6Syf8wtA/xOvdvesIM/xHoHpQ4mp2
         kGaQPBqZIeQg75WZRmLC1J0vvz0N+J/wHgPfeNx6CWqljr2xVRlnhMmqStDFXeH9OteD
         UdDKlBrcDx+IHVgGRnNql6fNqhC8UJ/0zLJcMACiQdKHQjGURJds5lWBs1vyz5ebkPWw
         0o6fGsGo2wE6PVztfykuJW8aKjmi0krcntJGszy/82gq0ndxxs4fJ8aJQW98nZewfAkA
         hgxg==
MIME-Version: 1.0
References: <20230327121317.4081816-1-arnd@kernel.org> <20230327121317.4081816-10-arnd@kernel.org>
In-Reply-To: <20230327121317.4081816-10-arnd@kernel.org>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 30 Mar 2023 14:26:18 +0100
Message-ID: <CA+V-a8twDb_P3TOpOqhz3Umump_NZg2Bw-8tgMCAmAdadUxfkw@mail.gmail.com>
Subject: Re: [PATCH 09/21] riscv: dma-mapping: skip invalidation before bidirectional DMA
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Neil Armstrong <neil.armstrong@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S. Miller" <davem@davemloft.net>, Max Filippov <jcmvbkbc@gmail.com>, Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Conor Dooley <conor.dooley@microchip.com>, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org
List-ID: <linux-oxnas@groups.io>

On Mon, Mar 27, 2023 at 1:16=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
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
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/riscv/mm/dma-noncoherent.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

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
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
