Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mx.groups.io with SMTP id smtpd.web08.14384.1660648073771120865
 for <linux-oxnas@groups.io>;
 Tue, 16 Aug 2022 04:07:54 -0700
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 4474BB81675
	for <linux-oxnas@groups.io>; Tue, 16 Aug 2022 11:07:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2881C43140
	for <linux-oxnas@groups.io>; Tue, 16 Aug 2022 11:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1660648069;
	bh=4MGnUkOgJK43wRliQHo1gFwCDv8iRH3dd6NYX9GNPIw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NSg1bKhyRbmEl4xQCkeeQMXefbzYn7Fu6+yGnneTCy/Nzz6KwdPE/LppcquhYPsEC
	 /bnFkzijA2uGVC2L1WLNFVfeTiaG47nTM2mBwhDa5dkHxDhNEf/e+5AD+Pt32bExac
	 bjg0X6BhxmWeNwCjmjE66y2fzNBSo6oGRwSBj0ERZGW5WqqKKIFvMZBTV94rxf+cfp
	 cgutExjGb0R1Guj66JL73DY4pMNJlVUhUKDA9LgU/J6gvlllp8K6yxAQzN5fMDFCD1
	 z+VIBmqs3zZnMYpUQJaYqkXe07E4Nr2n54ety4NwO8ULnVzThTh4P05/qsJufqiyox
	 qwzgPq0mW2W+g==
Received: by mail-qv1-f44.google.com with SMTP id j1so2807785qvv.8
        for <linux-oxnas@groups.io>; Tue, 16 Aug 2022 04:07:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220815143959.1511278-1-zi.yan@sent.com> <Yvtxv2jywm3+Q3ut@arm.com>
In-Reply-To: <Yvtxv2jywm3+Q3ut@arm.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 16 Aug 2022 19:07:24 +0800
Message-ID: <CAAhV-H6Np=L9JcrGjh8zy1Kxb8b9f_dzD00kgV6odzZV-L5pbA@mail.gmail.com>
Subject: Re: [PATCH] arch: mm: rename FORCE_MAX_ZONEORDER to ARCH_FORCE_MAX_ORDER
Content-Type: text/plain; charset="UTF-8"
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Zi Yan <ziy@nvidia.com>, Linux-MM <linux-mm@kvack.org>, David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Mike Kravetz <mike.kravetz@oracle.com>, John Hubbard <jhubbard@nvidia.com>, Yang Shi <shy828301@gmail.com>, David Rientjes <rientjes@google.com>, James Houghton <jthoughton@google.com>, Mike Rapoport <rppt@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Mike Rapoport <rppt@linux.ibm.com>, Vineet Gupta <vgupta@synopsys.com>, Shawn Guo <shawnguo@kernel.org>, Taichi Sugaya <sugaya.taichi@socionext.com>, Neil Armstrong <narmstrong@baylibre.com>, Qin Jian <qinjian@cqplus1.com>, Guo Ren <guoren@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, Yoshinori Sato <ysato@users.sourceforge.jp>, "David S. Miller" <davem@davemloft.net>, Chris Zankel <chris@zankel.net>, Arnd Bergmann <arnd@arndb.de>, Ley Foon Tan <ley.foon.tan@intel.com>, Andrew Morton <akpm@linux-foundation.org>, NXP Linux Team <linux-imx@nxp.com>, linux-snps-arc@lists.infradead.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-oxnas@groups.io, linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k <linux-m68k@lists.linux-m68k.org>, "open list:MIPS" <linux-mips@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, Linux-sh list <linux-sh@vger.kernel.org>, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org
List-ID: <linux-oxnas@groups.io>

For LoongArch:

Acked-by: Huacai Chen <chenhuacai@kernel.org>

On Tue, Aug 16, 2022 at 6:30 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Mon, Aug 15, 2022 at 10:39:59AM -0400, Zi Yan wrote:
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 571cc234d0b3..c6fcd8746f60 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -1401,7 +1401,7 @@ config XEN
> >       help
> >         Say Y if you want to run Linux in a Virtual Machine on Xen on ARM64.
> >
> > -config FORCE_MAX_ZONEORDER
> > +config ARCH_FORCE_MAX_ORDER
> >       int
> >       default "14" if ARM64_64K_PAGES
> >       default "12" if ARM64_16K_PAGES
>
> For arm64:
>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
