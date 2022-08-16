Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
 by mx.groups.io with SMTP id smtpd.web11.12539.1660632406491245622
 for <linux-oxnas@groups.io>;
 Mon, 15 Aug 2022 23:46:46 -0700
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-10edfa2d57dso10729354fac.0
        for <linux-oxnas@groups.io>; Mon, 15 Aug 2022 23:46:46 -0700 (PDT)
Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com. [209.85.210.47])
        by smtp.gmail.com with ESMTPSA id 184-20020aca06c1000000b00342fedaf7d9sm2177188oig.43.2022.08.15.23.46.41
        for <linux-oxnas@groups.io>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Aug 2022 23:46:43 -0700 (PDT)
Received: by mail-ot1-f47.google.com with SMTP id q39-20020a056830442700b0063889adc0ddso5980360otv.1
        for <linux-oxnas@groups.io>; Mon, 15 Aug 2022 23:46:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220815143959.1511278-1-zi.yan@sent.com>
In-Reply-To: <20220815143959.1511278-1-zi.yan@sent.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 16 Aug 2022 08:46:19 +0200
Message-ID: <CAMuHMdWohdUZxi3A=H1wqY4rYrLD-ME6mmhWb6Z-udovd=1BhQ@mail.gmail.com>
Subject: Re: [PATCH] arch: mm: rename FORCE_MAX_ZONEORDER to ARCH_FORCE_MAX_ORDER
Content-Type: text/plain; charset="UTF-8"
To: Zi Yan <ziy@nvidia.com>
Cc: Linux MM <linux-mm@kvack.org>, David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Mike Kravetz <mike.kravetz@oracle.com>, John Hubbard <jhubbard@nvidia.com>, Yang Shi <shy828301@gmail.com>, David Rientjes <rientjes@google.com>, James Houghton <jthoughton@google.com>, Mike Rapoport <rppt@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mike Rapoport <rppt@linux.ibm.com>, Vineet Gupta <vgupta@synopsys.com>, Shawn Guo <shawnguo@kernel.org>, Taichi Sugaya <sugaya.taichi@socionext.com>, Neil Armstrong <narmstrong@baylibre.com>, Qin Jian <qinjian@cqplus1.com>, Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, Yoshinori Sato <ysato@users.sourceforge.jp>, "David S. Miller" <davem@davemloft.net>, Chris Zankel <chris@zankel.net>, Arnd Bergmann <arnd@arndb.de>, Ley Foon Tan <ley.foon.tan@intel.com>, Andrew Morton <akpm@linux-foundation.org>, NXP Linux Team <linux-imx@nxp.com>, arcml <linux-snps-arc@lists.infradead.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-oxnas@groups.io, linux-csky@vger.kernel.org, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, loongarch@lists.linux.dev, linux-m68k <linux-m68k@lists.linux-m68k.org>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux-sh list <linux-sh@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, "open list:TENSILICA XTENSA PORT (xtensa)" <linux-xtensa@linux-xtensa.org>
List-ID: <linux-oxnas@groups.io>

On Mon, Aug 15, 2022 at 4:40 PM Zi Yan <zi.yan@sent.com> wrote:
> From: Zi Yan <ziy@nvidia.com>
>
> This Kconfig option is used by individual arch to set its desired
> MAX_ORDER. Rename it to reflect its actual use.
>
> Acked-by: Mike Rapoport <rppt@linux.ibm.com>
> Signed-off-by: Zi Yan <ziy@nvidia.com>

>  arch/m68k/Kconfig.cpu                        | 2 +-

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
