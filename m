Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
 by mx.groups.io with SMTP id smtpd.web08.1147.1634859791590780138
 for <linux-oxnas@groups.io>;
 Thu, 21 Oct 2021 16:43:11 -0700
Received: by mail-yb1-f169.google.com with SMTP id i65so2266254ybb.2
        for <linux-oxnas@groups.io>; Thu, 21 Oct 2021 16:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iItbf96vJqUXBAPNWl/S+u6NWGXbFnqP3nMjz13MqBo=;
        b=TFl4VR+n/Tz2N//3hY0nsO9nfx6KQXwngK5dVh8zYiQrFuwtAtD1xgWfiNqrn4Shvw
         1JUxPOVPbUcuwvhE1OI3HYqKqDLWxoQ1WSOGRdSJw1F8LhaxoEnmEA+oqoS/AmHvrH6z
         UNtKwsU9qRjI38BVq4xkPUsYU/9KeW+o0BzqdsD8AQjEsK8O3Q2ywuMzIV1hvf2knjMr
         V8uyr6rzS0w+sPLRG7eZhp3iBxqsIoVIi/FKzGhcpn9YgjJwPZbRNb3qsN7A3rgwBUnw
         cIaAwWRZZyQIjjsE4+HrK93XFrVxGV0Jog7RENlVKKDwUQGYLm7/Ii/LdwTFhq4eO2X6
         H7zg==
MIME-Version: 1.0
References: <20210929000735.585237-1-saravanak@google.com> <20210929000735.585237-3-saravanak@google.com>
 <CAMi1Hd0HvPOT277mx8hNTU9NQH2ti7h5qc5+rxOkRWwbfrhyQQ@mail.gmail.com>
In-Reply-To: <CAMi1Hd0HvPOT277mx8hNTU9NQH2ti7h5qc5+rxOkRWwbfrhyQQ@mail.gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 21 Oct 2021 16:42:34 -0700
Message-ID: <CAGETcx_YZOd05Gg53ZR8mfVhFUzwQWo4MrrWF8JHF_DCwEtunw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] drivers: bus: Delete CONFIG_SIMPLE_PM_BUS
Content-Type: text/plain; charset="UTF-8"
To: Amit Pundir <amit.pundir@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>, Neil Armstrong <narmstrong@baylibre.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Damien Le Moal <damien.lemoal@wdc.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Android Kernel Team <kernel-team@android.com>, linux-arm-kernel@lists.infradead.org, lkml <linux-kernel@vger.kernel.org>, linux-oxnas@groups.io, linux-renesas-soc@vger.kernel.org, linux-omap@vger.kernel.org, linux-riscv@lists.infradead.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, John Stultz <john.stultz@linaro.org>
List-ID: <linux-oxnas@groups.io>

On Thu, Oct 21, 2021 at 4:21 AM Amit Pundir <amit.pundir@linaro.org> wrote:
>
> Hi Saravana,
>
> This patch broke v5.15-rc6 on RB5 (sm8250 | qcom/qrb5165-rb5.dts).
> I can't boot past this point https://www.irccloud.com/pastebin/raw/Nv6ZwHmW.

Amit top posting? How did that happen? :)

The fact you are seeing this issue is super strange though. The driver
literally does nothing other than allowing some sync_state() callbacks
to happen. I also grepped for the occurence of "simple-bus" in
arch/arm64/boot/dts/qcom/ and the only instance for 8250 is for the
soc node.

The only thing I can think of is that without my patch some
sync_state() callbacks weren't getting called and maybe it was masking
some other issue.

Can you try to boot with this log (see log patch below) and see if the
device hangs right after a sync_state() callback? Also, looking at the
different sync_state() implementations in upstream, I'm guessing one
of the devices isn't voting for interconnect bandwidth when it should
have.

Another thing you could do is boot without the simple-bus changes and
then look for all instances of "state_synced" in /sys/devices and then
see if any of them has the value "0" after boot up is complete.

-Saravana

-- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1099,6 +1099,7 @@ static void device_links_flush_sync_list(struct
list_head *list,
                if (dev != dont_lock_dev)
                        device_lock(dev);

+               dev_info(dev, "Calling sync_state()\n");
                if (dev->bus->sync_state)
                        dev->bus->sync_state(dev);
                else if (dev->driver && dev->driver->sync_state)
