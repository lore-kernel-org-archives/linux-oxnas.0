DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2014; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	 bh=IVB28Db9ZKXqdHKKo03v707cx3bqKns8Z36Y8D2nxKo=; b=XCLNhu4n9w/9bFuyRnjjDuhdS
	1/0Qiy+5ruIfFQs4mkW7H7lqpSBUXBc+NnrE4hgmCj+LqYBw8nITtieuKU+gc6xun1xT2zeZNQLLY
	LfiA+3S7VCuMDmw8PGxxBoK3zDWPcI6IaTg60GUClM/qEzaKmQbB5bVfB8SQ8rifQx9AY=;
Date: Thu, 13 Dec 2018 17:59:52 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: [PATCH 0/9] Clean up ARM SMP/CPU hotplug implementations
Message-ID: <20181213175952.GC26090@n2100.armlinux.org.uk>
MIME-Version: 1.0
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org, linux-oxnas@groups.io, linux-samsung-soc@vger.kernel.org, linux-soc@vger.kernel.org
Cc: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Andy Gross <andy.gross@linaro.org>, Barry Song <baohua@kernel.org>, David Brown <david.brown@linaro.org>, Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Liviu Dudau <liviu.dudau@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Neil Armstrong <narmstrong@baylibre.com>, Patrice Chotard <patrice.chotard@st.com>, Shiraz Hashim <shiraz.linux.kernel@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>, Tony Lindgren <tony@atomide.com>, Viresh Kumar <vireshk@kernel.org>
List-ID: <linux-oxnas@groups.io>

There is a lot of apparent copied code in arch/arm for handling SMP/
CPU hotplug, much of which is inappropriate or plain buggy.  This
seems to be a topic that occasionally comes up.

The "pen_release" thing was created for ARM Ltd development platforms
where there was no way to individually control secondary CPUs leaving
the boot loader - they all jumped to whatever physical code address
was supplied at the same time.  This made it necessary for _these_
platforms to have a "holding pen" for the CPUs while the kernel
initialised.

The "boot_lock" thing was also created for ARM Ltd development
platforms which had restricted bus bandwidth, and which used the
loops_per_jiffy delay mechanism, which was calibrated for each
secondary CPU.  With the restricted bus bandwidth, activity from the
boot CPU would affect the delay calibration adversely.

Lastly, the Versatile CPU hotplug implementation is an entirely
ficticious one - these platforms do _not_ support CPU hotplug as
there is no way to actually disable any of the secondary CPUs, or
reset them.  Such an implementation is not acceptable when supporting
features such as suspend or kexec.  As the Versatile platforms are
ARM development platforms which do not have suspend support, this is
acceptable there, but not for production hardware.

None of these three facilities/implementations should be used on
modern production hardware, yet we have a number of copies of this
code.

This series addresses that by removing the inappropriate copies of
some Realview/Versatile Express specific workarounds, and makes it
(hopefully) more clear that introducing this code is really not
acceptable.

To discourage copying the Versatile code, further comments are added
and the functions renamed for CPU hotplug to be "immitation" to make
it clear that it's not a real implementation.

We tried reducing the duplication in the past with ideas around
consolidating the pen_release/boot_lock/immitation hotplug stuff,
but I nacked that because it's not an acceptable implementation for
production hardware.  However, we did decide to consolidate the
"pen_release" definition.  In hind sight, that was a mistake,
because that gave more credence to that way of doing things, and
also gave rise to buggy implementations which only read from that
variable - meaning it served no useful purpose.

There are some rather complex cases that remain, and those need the
SoC folk to fix.

I have left the Actions Semi patch in place since following patches
depend on it, but there is a five-patch series from Linus Walleij
that address this platform which should replace this patch - with
the patch concerned marked as "RFT" - request for testing.

 arch/arm/include/asm/smp.h                         |   1 -
 arch/arm/kernel/smp.c                              |   6 --
 arch/arm/mach-actions/platsmp.c                    |  15 ---
 arch/arm/mach-exynos/headsmp.S                     |   2 +-
 arch/arm/mach-exynos/platsmp.c                     |  31 +++---
 arch/arm/mach-omap2/omap-smp.c                     |  20 ----
 arch/arm/mach-oxnas/Makefile                       |   1 -
 arch/arm/mach-oxnas/hotplug.c                      | 109 --------------------
 arch/arm/mach-oxnas/platsmp.c                      |   4 -
 arch/arm/mach-prima2/common.h                      |   2 +
 arch/arm/mach-prima2/headsmp.S                     |   2 +-
 arch/arm/mach-prima2/hotplug.c                     |   3 +-
 arch/arm/mach-prima2/platsmp.c                     |  17 ++--
 arch/arm/mach-qcom/platsmp.c                       |  26 -----
 arch/arm/mach-realview/Makefile                    |   1 -
 arch/arm/mach-realview/hotplug.c                   | 111 ---------------------
 arch/arm/mach-realview/hotplug.h                   |   1 -
 arch/arm/mach-realview/platsmp-dt.c                |   8 +-
 arch/arm/mach-spear/generic.h                      |   2 +
 arch/arm/mach-spear/headsmp.S                      |   2 +-
 arch/arm/mach-spear/hotplug.c                      |   4 +-
 arch/arm/mach-spear/platsmp.c                      |  27 +++--
 arch/arm/mach-sti/Makefile                         |   2 +-
 arch/arm/mach-sti/headsmp.S                        |  43 --------
 arch/arm/mach-sti/platsmp.c                        |  62 +-----------
 arch/arm/mach-vexpress/Makefile                    |   1 -
 arch/arm/mach-vexpress/core.h                      |   2 -
 arch/arm/mach-vexpress/platsmp.c                   |   7 ++
 arch/arm/plat-versatile/Makefile                   |   1 +
 arch/arm/plat-versatile/headsmp.S                  |   2 +-
 .../{mach-vexpress => plat-versatile}/hotplug.c    |  47 ++++-----
 arch/arm/plat-versatile/include/plat/platsmp.h     |   2 +
 arch/arm/plat-versatile/platsmp.c                  |  47 ++++++---
 33 files changed, 132 insertions(+), 479 deletions(-)
 delete mode 100644 arch/arm/mach-oxnas/hotplug.c
 delete mode 100644 arch/arm/mach-realview/hotplug.c
 delete mode 100644 arch/arm/mach-realview/hotplug.h
 delete mode 100644 arch/arm/mach-sti/headsmp.S
 rename arch/arm/{mach-vexpress => plat-versatile}/hotplug.c (56%)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
