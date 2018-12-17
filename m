Received: by mail-pl1-f193.google.com with SMTP id a14so5603914plm.12
        for <linux-oxnas@groups.io>; Sun, 16 Dec 2018 22:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AFpXFwHMVO/VpPcfAVPRAu1XtJGJYWGygCyS0HseBIs=;
        b=aUBd9zzVxe70o2CMwY1samH0vs0vIfuBZj0lpIQn1OdZjB+m76kdR0QEIaK3TPKxlS
         2poA4ElRgLx7BulLv1aI/FGclF0J80fo+/ZwGcUDsgy9JZWVIk2AY4xiRifjgVRQRRVs
         Q9u5CENsDLs9M5BJDchPE3sQPMyAiRnDBK3iQ=
Return-Path: <viresh.kumar@linaro.org>
Date: Mon, 17 Dec 2018 11:46:08 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 9/9] ARM: smp: remove arch-provided "pen_release"
Message-ID: <20181217061608.tlxl24xwfksadj4d@vireshk-i7>
References: <20181213175952.GC26090@n2100.armlinux.org.uk>
 <E1gXVIY-0008DI-MU@rmk-PC.armlinux.org.uk>
 <20181214043923.2gusomvei424vw7m@vireshk-i7>
 <20181214131200.GL9507@n2100.armlinux.org.uk>
MIME-Version: 1.0
In-Reply-To: <20181214131200.GL9507@n2100.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Barry Song <baohua@kernel.org>, linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, linux-omap@vger.kernel.org, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <vireshk@kernel.org>, linux-oxnas@groups.io, linux-soc@vger.kernel.org, Shiraz Hashim <shiraz.linux.kernel@gmail.com>, linux-arm-kernel@lists.infradead.org
List-ID: <linux-oxnas@groups.io>

On 14-12-18, 13:12, Russell King - ARM Linux wrote:
> On Fri, Dec 14, 2018 at 10:09:23AM +0530, Viresh Kumar wrote:
> > On 13-12-18, 18:01, Russell King wrote:
> > > diff --git a/arch/arm/mach-spear/generic.h b/arch/arm/mach-spear/generic.h
> > > index 909b97c0b237..815333fc320c 100644
> > > --- a/arch/arm/mach-spear/generic.h
> > > +++ b/arch/arm/mach-spear/generic.h
> > > @@ -20,6 +20,8 @@
> > >  
> > >  #include <asm/mach/time.h>
> > >  
> > > +extern volatile int prima2_pen_release;
> > 
> >                        prima2 ?
> > 
> > I haven't tried but this may cause build regressions as well, I am
> > surprised on how this passed for you.
> 
> Thanks.
> 
> These patches aren't all build tested -

Ah okay.

> I don't see the point of wasting
> hours build testing when these platforms /really/ need something better.

I was expecting it to be build tested at least, to be honest. But anyway, we
will see build failures from bots if any such cases exist.

> This is not supposed to be a finished patch, but a patch to get folk
> to do something about this issue.
> 
> Please fix this issue properly.  I can't give you a patch to do that,
> you need to sort it yourself, but failure to do anything _will_ result
> in an updated version of this patch being merged.

Yeah, I know. I have seen the thread and it was lack of knowledge in the
beginning which made us copy code from rest of ARM platforms. That was stupid
and there can't be any excuse for that.

Unfortunately, I don't have access to hardware to test this stuff and so
wouldn't be possible to send a patch as well.

Lets get your patch merged at least.

-- 
viresh
