Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web09.33313.1615193815232555972
 for <linux-oxnas@groups.io>;
 Mon, 08 Mar 2021 00:56:56 -0800
Received: by mail-wr1-f45.google.com with SMTP id v15so10546714wrx.4
        for <linux-oxnas@groups.io>; Mon, 08 Mar 2021 00:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S0kXMv1KhXA1L/lPLco3OI9Kq8yC83nBtYw81gut9/A=;
        b=lA5Jw0aJ5ydOOSIygPuUjKGKJsAXMgVWkVohvGLvre3n4O2aFJYvnN82ewVY7+qni4
         UZxOKcWYOrwrNC6wjuKagE1Ya2lSmHUEWvkCpGH21jg9NyqmShB93kyy3qW2x0/X7o6Q
         DML3g5WDksvOtGeI0w9tuIW+7idUZARF8myV+rM9frZrW1Y/xCOSBF++WOLqlpvUK/7m
         fIkKhfs9MXQqxMjXRPiiPhBPOAUSGEIlKy5GTPUoLxp1Fq6oyBjy11XlqMP1sHnTnEIr
         AwKC6N7hvSG5dsGZILa76Zm+DXuQ2R5FhiMrjRb3TgGdqvVBcOGq48aQfS1j6pNFn/xx
         dwEg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] reset: oxnas: replace file name with short description
References: <20210304160358.21030-1-p.zabel@pengutronix.de>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <586b67bb-d842-16c5-ca21-98914e101535@baylibre.com>
Date: Mon, 8 Mar 2021 09:54:42 +0100
MIME-Version: 1.0
In-Reply-To: <20210304160358.21030-1-p.zabel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Philipp Zabel <p.zabel@pengutronix.de>, linux-kernel@vger.kernel.org
Cc: linux-oxnas@groups.io
List-ID: <linux-oxnas@groups.io>

On 04/03/2021 17:03, Philipp Zabel wrote:
> Fixes a checkpatch warning:
> 
>   WARNING: It's generally not useful to have the filename in the file
>   #3: FILE: drivers/reset/reset-oxnas.c:3:
>   + * drivers/reset/reset-oxnas.c
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  drivers/reset/reset-oxnas.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/reset/reset-oxnas.c b/drivers/reset/reset-oxnas.c
> index c4013165bdda..8209f922dc16 100644
> --- a/drivers/reset/reset-oxnas.c
> +++ b/drivers/reset/reset-oxnas.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * drivers/reset/reset-oxnas.c
> + * Oxford Semiconductor Reset Controller driver
>   *
>   * Copyright (C) 2016 Neil Armstrong <narmstrong@baylibre.com>
>   * Copyright (C) 2014 Ma Haijun <mahaijuns@gmail.com>
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
