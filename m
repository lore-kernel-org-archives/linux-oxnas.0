Received: from huawei.com (huawei.com [45.249.212.191])
 by mx.groups.io with SMTP id smtpd.web11.10187.1572830235145602265
 for <linux-oxnas@groups.io>;
 Sun, 03 Nov 2019 17:17:15 -0800
Subject: Re: [PATCH -next 01/30] pinctrl: pxa25x: use devm_platform_ioremap_resource() to simplify code
References: <20191017122640.22976-1-yuehaibing@huawei.com>
 <20191017122640.22976-2-yuehaibing@huawei.com>
 <CACRpkdb8D_zxHfzY=+ramnNjXVsN9MMO8Q-3=iZFLS2A_ZDQuw@mail.gmail.com>
From: Yuehaibing <yuehaibing@huawei.com>
Message-ID: <c8b14d9b-253b-47a1-641f-e89d2cc79686@huawei.com>
Date: Mon, 4 Nov 2019 09:17:07 +0800
MIME-Version: 1.0
In-Reply-To: <CACRpkdb8D_zxHfzY=+ramnNjXVsN9MMO8Q-3=iZFLS2A_ZDQuw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Lars Persson <lars.persson@axis.com>, "Ludovic Desroches  <ludovic.desroches@microchip.com>, Nicolas Ferre" <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Baruch Siach <baruch@tkos.co.il>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm-kernel@axis.com, linux-oxnas@groups.io, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, MSM <linux-arm-msm@vger.kernel.org>, linux-tegra@vger.kernel.org, Vladimir Zapolskiy <vz@mleia.com>, Neil Armstrong <narmstrong@baylibre.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chen-Yu Tsai <wens@csie.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, Andy Gross <agross@kernel.org>
List-ID: <linux-oxnas@groups.io>

On 2019/11/4 8:18, Linus Walleij wrote:
> On Thu, Oct 17, 2019 at 2:48 PM YueHaibing <yuehaibing@huawei.com> wrote:
> 
>> Use devm_platform_ioremap_resource() to simplify the code a bit.
>> This is detected by coccinelle.
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> These are too many patches changing too little.
> One patch should be one technical step.
> 
> I'd say squash them all into one big patch and resend.
> 
> You can collect the ACKs you received, but don't put
> too many people on CC, they will be annoyed.

Ok, will do that, thanks!

> 
> Yours,
> Linus Walleij
> 
> .
> 

