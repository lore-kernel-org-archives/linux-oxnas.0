Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com [64.147.123.18])
 by mx.groups.io with SMTP id smtpd.web11.11767.1681390329225874052
 for <linux-oxnas@groups.io>;
 Thu, 13 Apr 2023 05:52:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1681390322; x=1681397522; bh=NR
	7qDHxvmrn4O6C7ghCGmkwcCMB9CqvbPSwmBqWhNIE=; b=ZXclSBnVVRa8vpoYG+
	Nh7NGI1Sfo/+IhOueSX6qtWqFgLpX1O7kGpe874+9lPVAkHB/MzUC6Ip3Qt5J4S1
	bo+Igz4vPJgrOb5hGwvGzYSyD9RAM686r7y8aQw66DlT4Mt340zXnCYSOX2rluiN
	l6kWpyNhBIXZQ/WjHlR82CZljPrL2zeVzs/VKz/0NnIUPr0YWmnDYjaoDj48NIs+
	UFfZMJaZFIZIs03gVqCq4iH3pg/lZtVMlR8XIkQ70K5m2tAxwHrPsotuz4IugI93
	6XX70k3nZhX+AhqXZznQyr38x7nSAEkpDTOnIVRV2ikChkz1k3AGDfv3Jf0wEK6q
	B4Qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1681390322; x=1681397522; bh=NR7qDHxvmrn4O
	6C7ghCGmkwcCMB9CqvbPSwmBqWhNIE=; b=gqOA+P8sXOuT1JOfKkqGPELz//AFF
	f2eiDN24y3pX47Aau9zsWL6E8P7Knx1xYRVsUHNfPuY3xLBDKbzMqkoi7VrJfZ+o
	W2mfsUlFecf2kgDULdtR2hU7Te44ccwG0sZJJ62Vj9KlDW/g2YbNj73dSar7sZor
	Lalym6dR+k04Z8y/YiYW1TKtaKYCSHw8QkHRYjo8Tdd4ZZV+YIE/S2VHOdNo6IMp
	Z1kBRS94su8sb72OzoxxZQuCPo8irGFKsthakuC3qSU4fnAaIq/6lBOlIe4lj5le
	uqmU2YzZXlg34GD8AxHkIBUzub0qWgTia98RBKzwE2Iz+p4RVnYEoo8Ig==
Mime-Version: 1.0
Message-Id: <66899d69-1339-4a61-8612-6f8e452b0b26@app.fastmail.com>
In-Reply-To: 
 <OS0PR01MB5922EDAFCD6DA0313DB99C5E86989@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230327121317.4081816-1-arnd@kernel.org>
 <20230327121317.4081816-22-arnd@kernel.org>
 <OS0PR01MB5922EDAFCD6DA0313DB99C5E86989@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Date: Thu, 13 Apr 2023 14:51:40 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH 21/21] dma-mapping: replace custom code with generic implementation
Content-Type: text/plain
To: Biju Das <biju.das.jz@bp.renesas.com>, Arnd Bergmann <arnd@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Neil Armstrong <neil.armstrong@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, guoren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S . Miller" <davem@davemloft.net>, Max Filippov <jcmvbkbc@gmail.com>, Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, "Lad, Prabhakar  <prabhakar.mahadev-lad.rj@bp.renesas.com>, Conor.Dooley" <conor.dooley@microchip.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-oxnas@groups.io" <linux-oxnas@groups.io>, "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>
List-ID: <linux-oxnas@groups.io>

On Thu, Apr 13, 2023, at 14:13, Biju Das wrote:
> Hi all,
>
> FYI, this patch breaks on RZ/G2L SMARC EVK board and Arnd will send V2 
> for fixing this issue.
>
> [10:53] <biju> [    3.384408] Unable to handle kernel paging request at 
> virtual address 000000004afb0080

Right, sorry about this, I accidentally removed the 'phys_to_virt()'
conversion on arm64.

     Arnd
