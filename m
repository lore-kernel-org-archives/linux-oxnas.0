Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
 by mx.groups.io with SMTP id smtpd.web10.96289.1680596929792898589
 for <linux-oxnas@groups.io>;
 Tue, 04 Apr 2023 01:28:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=94yBqneQ9Lj342QeW9TDCvZXFWBiR0sn8rxyuOp0TBc=;
 b=a7kqVGSrGtvl9HpnkoTThRciRdt+crJz2OXCnWJ0XV8ViQz14hFGDo7TGiTXb8xQWgIt
 3/bMr4nQ9w0nW5x+w07eTH19g2OHnnqqg5U1gBm+1eRz3GBRklqQL00GRGHSulM+PXET
 uWfAvGd5FBHLsXOHIchy8Aohivg7LTnyM/uBn1SDQWYvwK/mwFcD9cF7OJn0LyBIxV2A
 3ds1+c01N6QEBd0oYnaFzLy3jfVxpb9rcP0qQ8dUCC80ZvxoqycugLn2jNG46EUDbHyM
 oWCh7NXZgOZcIKgbhFkndrV7VoUb1LCSb6Vdy8Za22pjtpx1l/4JVaKy7Wczlr1ZD6XR 8g== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1680596868; bh=94yBqneQ9Lj342QeW9TDCvZXFWBiR0sn8rxyuOp0TBc=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=GPFoyRAIHf7LjB9oRkoCPh7YfXuW004CD4F2kq/F6Vdv2ntMVJTQPiOMsLKFUBqAr
	 WAQ6vU73eVocQtlrPtBU2metNIJZJGgZdnPR6FTRh7fYisM9NSrsgJ0Ma77EjnjnvS
	 Iy+m5jd/LFqkuuOON0bsrF8ewng08UPBH1tKUT/tkv7PVPvc6HiplNA70nXcuDV32V
	 0yUTOssIJbcQlxOUp6QT3vtbVCyCXN7LWuIrLmrF42SaaUgkyp4U0ZkUlu3IruDKhV
	 LB3oHKrkurdPe7Xcb+jqt+TAaVkpQm1aVEdn1W12zz39Dv0mpzQDop2jfRQGRoKgqq
	 hnftEGnW5To+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94yBqneQ9Lj342QeW9TDCvZXFWBiR0sn8rxyuOp0TBc=;
 b=S4Vd5tYgdcrXzOQ3bEgFj+/IfpPK7in4gr0tMFqxld8FtkVDWIMnqStvA34RTxtvHI06mX9BwCcA/7W5r5lG01Vswzj5DzeYMFWLnfj5prbrPnSersMZdGJzfLBHHZLfiEqMhxG+0JCQg6MA1UdSKZNObVrmIeTR0nuYUC/Ww1k=
From: Shahab Vahedi <Shahab.Vahedi@synopsys.com>
Subject: Re: [PATCH 13/21] arc: dma-mapping: skip invalidating before bidirectional DMA
Date: Tue, 4 Apr 2023 08:27:08 +0000
Message-ID: <44b1ee5f-399d-9c3d-b050-02b2dea249be@synopsys.com>
References: <20230327121317.4081816-1-arnd@kernel.org>
 <20230327121317.4081816-14-arnd@kernel.org>
 <2b298e8c-e6fc-a973-9f42-b6a88e92838a@kernel.org>
In-Reply-To: <2b298e8c-e6fc-a973-9f42-b6a88e92838a@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <8AEF97A884463F49BD330A84DD8259EB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
To: Vineet Gupta <vgupta@kernel.org>, Arnd Bergmann <arnd@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Neil Armstrong <neil.armstrong@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S. Miller" <davem@davemloft.net>, Max Filippov <jcmvbkbc@gmail.com>, Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Conor Dooley <conor.dooley@microchip.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-oxnas@groups.io" <linux-oxnas@groups.io>, "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>, Shahab Vahedi <Shahab.Vahedi@synopsys.com>
List-ID: <linux-oxnas@groups.io>

T24gNC8yLzIzIDA4OjUyLCBWaW5lZXQgR3VwdGEgd3JvdGU6DQo+IENDIFNoYWhhYg0KPiANCj4g
T24gMy8yNy8yMyAxNzo0MywgQXJuZCBCZXJnbWFubiB3cm90ZToNCj4+IEZyb206IEFybmQgQmVy
Z21hbm48YXJuZEBhcm5kYi5kZT4NCj4+DQo+PiBTb21lIGFyY2hpdGVjdHVyZXMgdGhhdCBuZWVk
IHRvIGludmFsaWRhdGUgYnVmZmVycyBhZnRlciBiaWRpcmVjdGlvbmFsDQo+PiBETUEgYmVjYXVz
ZSBvZiBzcGVjdWxhdGl2ZSBwcmVmZXRjaGluZyBvbmx5IGRvIGEgc2ltcGxlciB3cml0ZWJhY2sN
Cj4+IGJlZm9yZSB0aGF0IERNQSwgd2hpbGUgYXJjaGl0ZWN0dXJlcyB0aGF0IGRvbid0IG5lZWQg
dG8gZG8gdGhlIHNlY29uZA0KPj4gaW52YWxpZGF0ZSB0ZW5kIHRvIGhhdmUgYSBjb21iaW5lZCB3
cml0ZWJhY2sraW52YWxpZGF0ZSBiZWZvcmUgdGhlDQo+PiBETUEuDQo+Pg0KPj4gYXJjIGlzIG9u
ZSBvZiB0aGUgYXJjaGl0ZWN0dXJlcyB0aGF0IGRvZXMgYm90aCwgd2hpY2ggc2VlbXMgdW5uZWNl
c3NhcnkuDQo+Pg0KPj4gQ2hhbmdlIGl0IHRvIGJlaGF2ZSBsaWtlIGFybS9hcm02NC94dGVuc2Eg
aW5zdGVhZCwgYW5kIHVzZSBqdXN0IGENCj4+IHdyaXRlYmFjayBiZWZvcmUgdGhlIERNQSB3aGVu
IHdlIGRvIHRoZSBpbnZhbGlkYXRlIGFmdGVyd2FyZHMuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTog
QXJuZCBCZXJnbWFubjxhcm5kQGFybmRiLmRlPg0KPiANCj4gUmV2aWV3ZWQtYnk6IFZpbmVldCBH
dXB0YSA8dmd1cHRhQGtlcm5lbC5vcmc+DQo+IA0KPiBTaGFoYWIgY2FuIHlvdSBnaXZlIHRoaXMg
YSBzcGluIG9uIGhzZGsgLSBydW4gZ2xpYmMgdGVzdHN1aXRlIG92ZXIgc3NoIGFuZCBtYWtlIHN1
cmUgbm90aGluZyBzdHJhbmdlIGhhcHBlbnMuDQo+IA0KPiBUaHgsDQo+IC1WaW5lZXQNCg0KT24g
aXQuDQotLSANClNoYWhhYg0KDQo=
