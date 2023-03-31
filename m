Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
 by mx.groups.io with SMTP id smtpd.web10.50174.1680253323305274689
 for <linux-oxnas@groups.io>;
 Fri, 31 Mar 2023 02:02:03 -0700
Received: by mail-yb1-f182.google.com with SMTP id p203so26585022ybb.13
        for <linux-oxnas@groups.io>; Fri, 31 Mar 2023 02:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680253322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWm2jI2yHpPi79Yy1CI28Qxt6CEyohh41n1LA0fGLDM=;
        b=ma9CGEidowfFcQ/RWwH9jcS3JpkuGTgIsGbkrjxNbpyIzTV0VWElAtIXD1pJ7GvLWW
         o7VY5XN4Af8jnZZ9O6VFKig0/95cqzaeDCJiUPwYZQl8VR+1dmIghX/+s6g86bp9ODnN
         MAzwUVCiMu/TmuzqPKTEsI7qk7BcH62AgPt5/bQM0gksa4J2iBNXg4d+1aT8ueqsMtsu
         j/o9cEOqf4x14P3d54vkcr4sulvwLKD3DWlzGUaFgwLRmbPD3v1X3PVwEGdEFSAXSvdX
         cX0K9wRov1LZHYLnnywTrm7QrejvefZ111ofD9/89zCLVipeznKpthRrdFZIrBFoD4rz
         Cj1A==
MIME-Version: 1.0
References: <20230327121317.4081816-1-arnd@kernel.org> <20230327121317.4081816-16-arnd@kernel.org>
In-Reply-To: <20230327121317.4081816-16-arnd@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 31 Mar 2023 11:01:51 +0200
Message-ID: <CACRpkdbMry_UUYN1MuXTUpRXV+Tj9RSDvN-iBdvR8hDfkTaX4w@mail.gmail.com>
Subject: Re: [PATCH 15/21] ARM: dma-mapping: always invalidate WT caches before DMA
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Neil Armstrong <neil.armstrong@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S. Miller" <davem@davemloft.net>, Max Filippov <jcmvbkbc@gmail.com>, Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Conor Dooley <conor.dooley@microchip.com>, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org
List-ID: <linux-oxnas@groups.io>

On Mon, Mar 27, 2023 at 2:16=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:

> From: Arnd Bergmann <arnd@arndb.de>
>
> Most ARM CPUs can have write-back caches and that require
> cache management to be done in the dma_sync_*_for_device()
> operation. This is typically done in both writeback and
> writethrough mode.
>
> The cache-v4.S (arm720/740/7tdmi/9tdmi) and cache-v4wt.S
> (arm920t, arm940t) implementations are the exception here,
> and only do the cache management after the DMA is complete,
> in the dma_sync_*_for_cpu() operation.
>
> Change this for consistency with the other platforms. This
> should have no user visible effect.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Looks good to me.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
