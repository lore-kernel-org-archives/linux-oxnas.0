Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
 by mx.groups.io with SMTP id smtpd.web10.50579.1680255378570784261
 for <linux-oxnas@groups.io>;
 Fri, 31 Mar 2023 02:36:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LizQNlR5xeQ9Nx7+wKPFYUJj75jOfRmgpvd1Wr0G7No=; b=UKbXTqzhq2L4s+MyI6LAhZHXPR
	JEXjbEnQAW9YjlzhOJTLAm3faUqrzczga5/5A+k3OzAcg8y2zTvhiGLWpnnuu9Ohj85XsU4grnYcD
	yk5M61TG+xOGvvpr7BdospIoI188Iq0Jt42tRt/xOCB196NQnP2eeZJxFhk6W8d3WLrvzOeDmeDGp
	JdEZ4IItk3nxicikeyfyOXcN5BcpLJAlq5iFuQOYzNedzBy1kDsV1y5AtlHxecOF2ffvGBufXeIlS
	4QoK4UR/YHLQPaOKfszLD1j9qGgpZKpcHV1ssSQAyjuKCuBpMtpEGtTDYtwzgJ2cUFhaZW4SwHxwU
	CCfEAozA==;
Date: Fri, 31 Mar 2023 10:35:26 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
Subject: Re: [PATCH 15/21] ARM: dma-mapping: always invalidate WT caches before DMA
Message-ID: <ZCapXlrqMOpRxkSu@shell.armlinux.org.uk>
References: <20230327121317.4081816-1-arnd@kernel.org>
 <20230327121317.4081816-16-arnd@kernel.org>
 <ZCai0FmZiOqsMkzc@shell.armlinux.org.uk>
MIME-Version: 1.0
In-Reply-To: <ZCai0FmZiOqsMkzc@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S. Miller" <davem@davemloft.net>, Max Filippov <jcmvbkbc@gmail.com>, Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Conor Dooley <conor.dooley@microchip.com>, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org
List-ID: <linux-oxnas@groups.io>

On Fri, Mar 31, 2023 at 10:07:28AM +0100, Russell King (Oracle) wrote:
> On Mon, Mar 27, 2023 at 02:13:11PM +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > Most ARM CPUs can have write-back caches and that require
> > cache management to be done in the dma_sync_*_for_device()
> > operation. This is typically done in both writeback and
> > writethrough mode.
> > 
> > The cache-v4.S (arm720/740/7tdmi/9tdmi) and cache-v4wt.S
> > (arm920t, arm940t) implementations are the exception here,
> > and only do the cache management after the DMA is complete,
> > in the dma_sync_*_for_cpu() operation.
> > 
> > Change this for consistency with the other platforms. This
> > should have no user visible effect.
> 
> NAK...
> 
> The reason we do cache management _after_ is to ensure that there
> is no stale data. The kernel _has_ (at the very least in the past)
> performed DMA to data structures that are embedded within other
> data structures, resulting in cache lines being shared. If one of
> those cache lines is touched while DMA is progressing, then we
> must to cache management _after_ the DMA operation has completed.
> Doing it before is no good.

It looks like the main offender of "touching cache lines shared
with DMA" has now been resolved - that was the SCSI sense buffer,
and was fixed some time ago:

commit de25deb18016f66dcdede165d07654559bb332bc
Author: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Date:   Wed Jan 16 13:32:17 2008 +0900

/if/ that is the one and only case, then we're probably fine, but
having been through an era where this kind of thing was the norm
and requests to fix it did not get great responses from subsystem
maintainers, I just don't trust the kernel not to want to DMA to
overlapping cache lines.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
