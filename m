Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
 by mx.groups.io with SMTP id smtpd.web12.1944.1589271856756312629
 for <linux-oxnas@groups.io>;
 Tue, 12 May 2020 01:24:17 -0700
Received: by mail-wm1-f66.google.com with SMTP id h4so20727983wmb.4
        for <linux-oxnas@groups.io>; Tue, 12 May 2020 01:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ggr14XlgBh8EMUJAaXyLbn8TYhao1h67+MKW9QffqQA=;
        b=BlSv9wO9EpU2bfDYWrkc6U/izllw0YDwVAaM8XXtWTZAGT3qHljt7t90do6W5z8yIM
         7VNI4LfZWTiT9/N75dwSyGxJlwPjT4gykfTOEZyzilQXkF5vO+1ieeIivX5oykGVT6pD
         fcfvWOj1Vm5aSP2uMZrsEYCLakxc5GPx0QyYqAG4jL24rgxnb+2s3cBeA9fGSpuT/I3N
         y0lM2Pinz3TPoDSEznx0RNgbAU5A3B2TN2WgYYdifHPn24RRDdMuqfinuuJlMrTm8rt5
         W2tZ6N0Aazs/f+Yyk+D2k4BU6Lrth+1f0OyFKzI4EEQGUFZRu7s7AItrLEEfRwe161BU
         iIXg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] ARM: oxnas: make ox820_boot_secondary static
References: <1589247973-29728-1-git-send-email-mafeng.ma@huawei.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <799e6df7-7698-f2a7-e8eb-fd491c1cad8f@baylibre.com>
Date: Tue, 12 May 2020 10:24:13 +0200
MIME-Version: 1.0
In-Reply-To: <1589247973-29728-1-git-send-email-mafeng.ma@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Ma Feng <mafeng.ma@huawei.com>, linux@armlinux.org.uk
Cc: linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io, linux-kernel@vger.kernel.org
List-ID: <linux-oxnas@groups.io>

On 12/05/2020 03:46, Ma Feng wrote:
> Fix sparse warning:
> 
> arch/arm/mach-oxnas/platsmp.c:30:12: warning: symbol 'ox820_boot_secondary' was
> not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Ma Feng <mafeng.ma@huawei.com>
> ---
>  arch/arm/mach-oxnas/platsmp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-oxnas/platsmp.c b/arch/arm/mach-oxnas/platsmp.c
> index ab35275..f0a50b9 100644
> --- a/arch/arm/mach-oxnas/platsmp.c
> +++ b/arch/arm/mach-oxnas/platsmp.c
> @@ -27,7 +27,8 @@ static void __iomem *gic_cpu_ctrl;
>  #define GIC_CPU_CTRL			0x00
>  #define GIC_CPU_CTRL_ENABLE		1
> 
> -int __init ox820_boot_secondary(unsigned int cpu, struct task_struct *idle)
> +static int __init ox820_boot_secondary(unsigned int cpu,
> +		struct task_struct *idle)
>  {
>  	/*
>  	 * Write the address of secondary startup into the
> --
> 2.7.4
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
