Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
 by mx.groups.io with SMTP id smtpd.web11.34267.1679922150064445582
 for <linux-oxnas@groups.io>;
 Mon, 27 Mar 2023 06:02:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm1; t=
	1679922148; x=1679929348; bh=C0t+VBsIdNHlcZByrnG5NPOW3/HDBRin4l1
	1iuQ2qiw=; b=Y61mr9XUfXVFhUlJdoF8OWNZ1qM6LGTHSqUwPXey+5SLhbXuszz
	IX4F35TzFt8tNJqu3TdHQy42BVXRNe3bcFUV8/zj9nSivnmtuzQXp6yIK2l3HJtv
	arNn0qdsSFaxnf2jpGCdO42ZY/Yo7maZ9JJxQnYT9zQ6fDNdG0CMXLPJSTiBiuYc
	DxowTYLJD3TZAMG+gAP8IaltLqnFWdByE0RMezkwvVUj8PXoa7+fgC1mMOdcybmk
	FOSp8xBGb8i1lrklfr+C8l8mm7z3rZwyVo/iOqMqn8kIsrxCMYlMByaiI+EkJOfO
	AksZxvdJBavSBPl8RAWIMzvbBRTXG6xIPuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1679922148; x=1679929348; bh=C0t+VBsIdNHlcZByrnG5NPOW3/HDBRin4l1
	1iuQ2qiw=; b=S8t3E1mZSSbesGBfIrPg8iez5iynYZ434j4/P/C+PFUpzIj6OWt
	K13vVMOr45Pq/x54idE06yYJdGJHsAgbut8cysdL7NSE20F2ZB97nGf6sGl0XtnJ
	9XT1e/v2R2VMawWFs9cAUtCqiZnEUzvQi5oNF6VrsD0uvg+IwkaMgefkI++oVxUX
	P6oUU+TSxGqMMY77icyCim+29Cz39zEK5CEbEi/5s9/A6kWKWjnkM9cNn+OZr9OG
	+PTT8iBaVt9Y7UzKaNo9juS2P9bsmSmnzuVEEp99tvwuhj8CNT8gHrMIM+y46L5g
	RgKT+E9GeicOtbPmieJjqHY7nt82g7IMpvg==
Mime-Version: 1.0
Message-Id: <a0b2c6a1-9f9a-490a-af1b-52d856102bc7@app.fastmail.com>
In-Reply-To: <52eef604-085e-acf9-f3ee-41ba9d8441d2@csgroup.eu>
References: <20230327121317.4081816-1-arnd@kernel.org>
 <20230327121317.4081816-7-arnd@kernel.org>
 <52eef604-085e-acf9-f3ee-41ba9d8441d2@csgroup.eu>
Date: Mon, 27 Mar 2023 15:02:04 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH 06/21] powerpc: dma-mapping: minimize for_cpu flushing
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Arnd Bergmann <arnd@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Neil Armstrong <neil.armstrong@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, guoren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S . Miller" <davem@davemloft.net>, Max Filippov <jcmvbkbc@gmail.com>, Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, "Lad, Prabhakar  <prabhakar.mahadev-lad.rj@bp.renesas.com>, Conor.Dooley" <conor.dooley@microchip.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-oxnas@groups.io" <linux-oxnas@groups.io>, "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>
List-ID: <linux-oxnas@groups.io>

On Mon, Mar 27, 2023, at 14:56, Christophe Leroy wrote:
> Le 27/03/2023 =C3=A0 14:13, Arnd Bergmann a =C3=A9crit=C2=A0:
>> From: Arnd Bergmann <arnd@arndb.de>
>>=20
>> The powerpc dma_sync_*_for_cpu() variants do more flushes than on other
>> architectures. Reduce it to what everyone else does:
>>=20
>>   - No flush is needed after data has been sent to a device
>>=20
>>   - When data has been received from a device, the cache only needs to
>>     be invalidated to clear out cache lines that were speculatively
>>     prefetched.
>>=20
>> In particular, the second flushing of partial cache lines of bidirection=
al
>> buffers is actively harmful -- if a single cache line is written by both
>> the CPU and the device, flushing it again does not maintain coherency
>> but instead overwrite the data that was just received from the device.
>
> Hum ..... Who is right ?
>
> That behaviour was introduced by commit 03d70617b8a7 ("powerpc: Prevent=
=20
> memory corruption due to cache invalidation of unaligned DMA buffer")
>
> I think your commit log should explain why that commit was wrong, and=20
> maybe say that your patch is a revert of that commit ?

Ok, I'll try to explain this better. To clarify here: the __dma_sync()
function in commit 03d70617b8a7 is used both before and after a DMA,
but my patch 05/21 splits this in two, and patch 06/21 only changes
the part that gets called after the DMA-from-device but leaves the
part before DMA-from-device unchanged, which Andrew's patch
addressed.

As I mentioned in the cover letter, it is still unclear whether
we want to consider this the expected behavior as the documentation
seems unclear, but my series does not attempt to answer that
question.

     Arnd
