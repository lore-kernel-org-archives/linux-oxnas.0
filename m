Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by mx.groups.io with SMTP id smtpd.web08.25908.1660718234573985739
 for <linux-oxnas@groups.io>;
 Tue, 16 Aug 2022 23:37:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1660718232;
	bh=5lvMCowArwqyA9jSE0Pt5Ze40kYbuyRJPhxadHGIwKI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=V5KRJdowJmJQRJnS7vKpdn3ZRXD54gk+olJ2P9NPfjmi7kMUASVQ2UXCdDQyrJ2l4
	 iCeFUua0EzB2yY0V/Z2I6yNQvrzfQPnJW1W5hxs27Vmfkv+k2UjzPlcs8lpiwhfw0s
	 rXEgyRzix9FElmstXFR+laxsxOuSRDwwsndo9tYxJEmh/ZBPqWv8VEb8et3MiTTUHN
	 x10j5udzl/wNVZu2HvSBSJ+AMCucLU+aGNDpNcmlYlO+lqwPbmi66mdTVNq3+seiCv
	 ALvJpMs3moLPQf8qL2I07gi/1+uKcpDS0UK8SnIKfeX71p9KEinWWl/Ojv6Y5XtZQh
	 hNA8dcj2NpgRA==
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] arch: mm: rename FORCE_MAX_ZONEORDER to ARCH_FORCE_MAX_ORDER
In-Reply-To: <20220815143959.1511278-1-zi.yan@sent.com>
References: <20220815143959.1511278-1-zi.yan@sent.com>
Date: Wed, 17 Aug 2022 16:36:57 +1000
Message-ID: <87tu6bv0ja.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
To: Zi Yan <zi.yan@sent.com>, linux-mm@kvack.org
Cc: Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, "Kirill A . Shutemov  <kirill.shutemov@linux.intel.com>, Mike Kravetz" <mike.kravetz@oracle.com>, John Hubbard <jhubbard@nvidia.com>, Yang Shi <shy828301@gmail.com>, David Rientjes <rientjes@google.com>, James Houghton <jthoughton@google.com>, Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>, Vineet Gupta <vgupta@synopsys.com>, Shawn Guo <shawnguo@kernel.org>, Taichi Sugaya <sugaya.taichi@socionext.com>, Neil Armstrong <narmstrong@baylibre.com>, Qin Jian <qinjian@cqplus1.com>, Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, Yoshinori Sato <ysato@users.sourceforge.jp>, "David S. Miller" <davem@davemloft.net>, Chris Zankel <chris@zankel.net>, Arnd Bergmann <arnd@arndb.de>, Ley Foon Tan <ley.foon.tan@intel.com>, Andrew Morton <akpm@linux-foundation.org>, NXP Linux Team <linux-imx@nxp.com>, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io, linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org
List-ID: <linux-oxnas@groups.io>

Zi Yan <zi.yan@sent.com> writes:
> From: Zi Yan <ziy@nvidia.com>
>
> This Kconfig option is used by individual arch to set its desired
> MAX_ORDER. Rename it to reflect its actual use.
>
> Acked-by: Mike Rapoport <rppt@linux.ibm.com>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
...
>  arch/powerpc/Kconfig                         | 2 +-
>  arch/powerpc/configs/85xx/ge_imp3a_defconfig | 2 +-
>  arch/powerpc/configs/fsl-emb-nonhw.config    | 2 +-

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
