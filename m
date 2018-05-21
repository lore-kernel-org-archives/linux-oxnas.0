Received: by mail-wr0-f178.google.com with SMTP id t16-v6so11960154wrm.9
        for <linux-oxnas@groups.io>; Mon, 21 May 2018 01:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=HBofT8KPputh0bbMeutLmLzUW1ZQl/YGmIpA1GYNoOM=;
        b=xq7vsXdr8SQW9L24fH27IjSZvTn/EmMFLO8aNsMqwP3o1Tkwd/ca/N4dda7LaK+cQ4
         wbsfavgOQD7+omQ9i/jxE1ZpN/iC5FXdp9tnf30DdihiKHKmJUzIhgZsOhTkfH8HgM4y
         QB8RSTbP3f2EHEuEgMH09OvphwjdnikK16FRdR9N529up4spFcQP2tK7SSskIDUEJvyf
         /R5X8MJzOfKDChQmq43Ot5fH0BRFEkG3S4xYSp04KVxNzhHzMXwUn2o+9UZjvLx8B0dO
         YY0jX0n0907XRtRh5dA6HFfoUut2AAI5nqA20fFrM1uN+aqEwfJXqPyIAhRdzEyTJfFx
         Xxgg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: Help relating to OXNAS Platform Bindings for Western Digital My Book World
References: <CABNOhB=XQYwYEsSxFm3ruWh5z7Yf-=TPfU9s4E7uYXpx6VojSA@mail.gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <51753f41-ee94-6f1b-c023-9c0f19851112@baylibre.com>
Date: Mon, 21 May 2018 10:43:21 +0200
MIME-Version: 1.0
In-Reply-To: <CABNOhB=XQYwYEsSxFm3ruWh5z7Yf-=TPfU9s4E7uYXpx6VojSA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
To: Raymond Elliot <raymundo.elliot@gmail.com>
Cc: linux-oxnas@groups.io
List-ID: <linux-oxnas@groups.io>

Hi,

On 18/05/2018 18:40, Raymond Elliot wrote:
> Hi there,
> 
> Apologies if it's the wrong thing to do to contact you directly.  If there is a better way of getting an answer please let me know.

You can also mail linux-oxnas@groups.io which is the kernel dev mailing-list.

> 
> I have been looking at your kernel updates for the above NAS (https://lwn.net/Articles/681483/) and was hoping to be able to use them to port the kernel to the Thecus N2200 which is also an ox810se-based NAS.
> 
> Though I've been in software development and architecture for 25+ years, I'm a relative newbie when it comes to kernel builds.
> 
> To test my kernel, my approach is to build the kernel (4.9.93) and deploy it to a TFTP server and use the factory u-boot to start it up.

Why 4.9.43 ? You should be able to use the latest 4.16 and even 4.17-rc

> 
> I am hoping that I might be able to get a working kernel if I piggy-back on the OXNAS changes you have had and create a device tree specific to the N2200.
> 
> As such, I have attempted to create an arch/arm/boot/dts/thecus-n2200.dts file based on the wd-mbwe.dts file with what I understand to be different on the N2200.
> 

Can you provide the dts you created ?

> I can get the kernel to build and for u-boot to pull it down and attempt to run it, but I don't get any serial console output and the kernel subsequently crashes with the following error:

and the kernel .config ?

> 
> Starting kernel ...
> 
> data abort
> pc : [<491c0544>]    lr : [<4900000c>]
> sp : 48cdd7b4  ip : 00000003  fp : 48d1664c
> r10: 00000003  r9 : ffed3b51  r8 : 48cddfdc
> r7 : 00000003  r6 : 00000480  r5 : 00000000  r4 : ffffb400
> r3 : 00000010  r2 : 48cdd7b4  r1 : ffffda00  r0 : 000000e1
> Flags: nzcv  IRQs off  FIQs off  Mode SVC_32
> 
> My guess is that you managed to get a working kernel for the WD MBWE so even if you have no idea where I'm going wrong, it would be great to understand the approach you took to adding the support you did.

Yes, I made it work, can you provide all the steps you used to run it on the target ?

For reference, these are my commands I an running :
cat arch/arm/boot/zImage arch/arm/boot/dts/wd-mbwe.dtb > arch/arm/boot/zImage.dtb
mkimage -A arm -O linux -T kernel -C none -a 0x48500000 -e 0x48500000 -n 'Linux' -d arch/arm/boot/zImage.dtb uImage

Then on U-Boot:
setenv ipaddr 192.168.1.240
setenv serverip 192.168.1.21
tftpboot 0x48008000 oxnas/uImage
bootm 0x48008000

> 
> Kind regards,
> Raymond

Neil
