Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web11.155794.1692171377608455291
 for <linux-oxnas@groups.io>;
 Wed, 16 Aug 2023 00:36:18 -0700
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-3fe2d218eedso58616055e9.0
        for <linux-oxnas@groups.io>; Wed, 16 Aug 2023 00:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692171376; x=1692776176;
        h=content-transfer-encoding:organization:autocrypt:subject:from:cc:to
         :content-language:reply-to:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MVFR2mk66kDJZxjvBrEwT33QDlRbkFQrANG0dtdmM64=;
        b=aSBCLGrIoVjMOpZForqAJ3kQeAtpPB7geoZHvMvHnRPpajcSIi0F/bIpt1anONbFJ0
         R/fHR7ulieNwsmTPTchW0HnMrSNBnM0XUwBf47bjOAEW+7lwVFHj0cqaMPPB70UD1ANc
         QwyB1HaRXi8d6lhk9RtlzV9Mh6+Zj6FOHIInchggAacP6vAlTuBj8OquFfYv8mkO0K9t
         EMMieEaOGRCt4RA7RCz6G62xX6cOFEo7tBZrjq6iQwmSrz8P+UZfJQZfewEvoaH841gQ
         LOy7SPoHj8zpbRUWzhz15OihycbQXH90Y4dM1mZ0sMtqdWZqXHtrqsnHD7trU3QGeGO/
         en9w==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <8ec6b604-f1b8-4178-8bb4-9cd504f381ca@linaro.org>
Date: Wed, 16 Aug 2023 09:36:14 +0200
MIME-Version: 1.0
Reply-To: neil.armstrong@linaro.org
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Subject: Final removal of Linux Oxnas support
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "linux-oxnas@groups.io" <linux-oxnas@groups.io>
Cc: Daniel Golle <daniel@makrotopia.org>, open list <linux-kernel@vger.kernel.org>
List-ID: <linux-oxnas@groups.io>

Hi All,

If you followed the recent events, the complete Oxnas support will be removed from mainline
Linux tree in v6.6 following DT & arch-arm removal in v6.4.

The Oxnas support will still be present in the current LTS kernels, and I'll be
happy to help if someone wants to revive the oxnas support somehow.

Finally, huge thanks to Daniel who kept Oxnas alive in Openwrt based on my
mainline work !

I will leave the oxnas mainling-list and the kernel.org git tree alive for
a while.

Thanks,
Neil
-- 
Neil Armstrong <neil.armstrong@linaro.org>
Senior Software Engineer - Linaro Developer Services
https://linaro.org/services
