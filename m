Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
 by mx.groups.io with SMTP id smtpd.web11.933.1636575915058946300
 for <linux-oxnas@groups.io>;
 Wed, 10 Nov 2021 12:25:15 -0800
Received: by mail-yb1-f170.google.com with SMTP id v64so9509387ybi.5
        for <linux-oxnas@groups.io>; Wed, 10 Nov 2021 12:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9MsVmtL6rQ21ppCeVmSbqNc8w+cgDqx9cYxOXHOd3hQ=;
        b=Nx0R0kPmYT0RAUPs/9cUc8r5DhZ5eCgF/GhHPkmrq0AjhpuNlrIs5xodOz4TnhIZjB
         fHl+6TOjvN71xUpz7me2X6bvXWLt3tYeDXcrM2fXuxJaIBCKLH8xIuM9uYCEdzgxLqF0
         xJFWNCItkA8VIWU7fwCe0DSR/Ff7N3A1QMjn5isQ9vyx0YYj3419zF3DoCAqwUxV97Gi
         0Lw+/408g3nuiFYDDCTUuHLcFjgmd0Vzf8VvotaVIr7vDjSjNJpleklWJ5Owku775I1+
         6RJ3uJxMeDFICw4UluYwxiunYqp0KyfDfApMfGTDgpWHdKMtK6EMJ2rtp+3RvWJRHS8C
         yMLQ==
MIME-Version: 1.0
References: <20210929000735.585237-1-saravanak@google.com> <20210929000735.585237-2-saravanak@google.com>
 <YYu4EglV7SBZU2Iy@ryzen>
In-Reply-To: <YYu4EglV7SBZU2Iy@ryzen>
From: Saravana Kannan <saravanak@google.com>
Date: Wed, 10 Nov 2021 12:24:38 -0800
Message-ID: <CAGETcx_m3f5JgrKQXZ5DUxDkpGhAau9G8uYm8a0iQ8JbcD0Rtg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] drivers: bus: simple-pm-bus: Add support for probing simple bus only devices
Content-Type: text/plain; charset="UTF-8"
To: Abel Vesa <abelvesa@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, Neil Armstrong <narmstrong@baylibre.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Damien Le Moal <damien.lemoal@wdc.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, kernel-team@android.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-oxnas@groups.io, linux-renesas-soc@vger.kernel.org, linux-omap@vger.kernel.org, linux-riscv@lists.infradead.org
List-ID: <linux-oxnas@groups.io>

On Wed, Nov 10, 2021 at 4:16 AM Abel Vesa <abelvesa@kernel.org> wrote:
>
> On 21-09-28 17:07:33, Saravana Kannan wrote:
> > fw_devlink could end up creating device links for bus only devices.
> > However, bus only devices don't get probed and can block probe() or
> > sync_state() [1] call backs of other devices. To avoid this, probe these
> > devices using the simple-pm-bus driver.
> >
> > However, there are instances of devices that are not simple buses (they get
> > probed by their specific drivers) that also list the "simple-bus" (or other
> > bus only compatible strings) in their compatible property to automatically
> > populate their child devices. We still want these devices to get probed by
> > their specific drivers. So, we make sure this driver only probes devices
> > that are only buses.
> >
> > [1] - https://lore.kernel.org/lkml/CAPDyKFo9Bxremkb1dDrr4OcXSpE0keVze94Cm=zrkOVxHHxBmQ@mail.gmail.com/
> > Fixes: c442a0d18744 ("driver core: Set fw_devlink to "permissive" behavior by default")
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > Tested-by: Saravana Kannan <saravanak@google.com>
> > Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/bus/simple-pm-bus.c | 42 ++++++++++++++++++++++++++++++++++---
> >  1 file changed, 39 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/bus/simple-pm-bus.c b/drivers/bus/simple-pm-bus.c
> > index 01a3d0cd08ed..6b8d6257ed8a 100644
> > --- a/drivers/bus/simple-pm-bus.c
> > +++ b/drivers/bus/simple-pm-bus.c
> > @@ -13,11 +13,36 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/pm_runtime.h>
> >
> > -
> >  static int simple_pm_bus_probe(struct platform_device *pdev)
> >  {
> > -     const struct of_dev_auxdata *lookup = dev_get_platdata(&pdev->dev);
> > -     struct device_node *np = pdev->dev.of_node;
> > +     const struct device *dev = &pdev->dev;
> > +     const struct of_dev_auxdata *lookup = dev_get_platdata(dev);
> > +     struct device_node *np = dev->of_node;
> > +     const struct of_device_id *match;
> > +
> > +     /*
> > +      * Allow user to use driver_override to bind this driver to a
> > +      * transparent bus device which has a different compatible string
> > +      * that's not listed in simple_pm_bus_of_match. We don't want to do any
> > +      * of the simple-pm-bus tasks for these devices, so return early.
> > +      */
> > +     if (pdev->driver_override)
> > +             return 0;
> > +
> > +     match = of_match_device(dev->driver->of_match_table, dev);
> > +     /*
> > +      * These are transparent bus devices (not simple-pm-bus matches) that
> > +      * have their child nodes populated automatically.  So, don't need to
> > +      * do anything more. We only match with the device if this driver is
> > +      * the most specific match because we don't want to incorrectly bind to
> > +      * a device that has a more specific driver.
> > +      */
> > +     if (match && match->data) {
> > +             if (of_property_match_string(np, "compatible", match->compatible) == 0)
> > +                     return 0;
> > +             else
> > +                     return -ENODEV;
> > +     }
>
> This change is breaking the expected behavior for the already existent
> simple-bus nodes. All the simple-bus compatibles should be replaced now
> to simple-pm-bus. In my case, on some i.MX8 platforms, without the
> devlink, the devices suspend sequence changes (and even breaks).
>
> To avoid breaking the already existent simple-bus nodes, maybe the logic
> should've been reversed: keep the simple-bus as is and add another
> compatible, IDK, something like simple-trasnparent-bus, or something.

The intent of this change IS to affect existing simple-bus nodes (but
not in the way it's affecting you). But if it's breaking stuff, we
obviously need to fix it.

I have a hunch on what's going on in your case, but can you point me
to the specific simple-bus node that's getting affected? I'm expecting
it to be a simple-bus node that gets added AFTER this driver is
registered at device_initcall (module_init gets converted to
device_initcall).

Also, can you try this hack patch to see if it helps your case?
https://lore.kernel.org/lkml/CAGETcx9U130Oq-umrvXME4JhEpO0Wadoki3kNxx=0-YvTR6PtQ@mail.gmail.com/

I have some thoughts on how I could fix this, but I need to think
about a few cases.

-Saravana

>
> >
> >       dev_dbg(&pdev->dev, "%s\n", __func__);
> >
> > @@ -31,14 +56,25 @@ static int simple_pm_bus_probe(struct platform_device *pdev)
> >
> >  static int simple_pm_bus_remove(struct platform_device *pdev)
> >  {
> > +     const void *data = of_device_get_match_data(&pdev->dev);
> > +
> > +     if (pdev->driver_override || data)
> > +             return 0;
> > +
> >       dev_dbg(&pdev->dev, "%s\n", __func__);
> >
> >       pm_runtime_disable(&pdev->dev);
> >       return 0;
> >  }
> >
> > +#define ONLY_BUS     ((void *) 1) /* Match if the device is only a bus. */
> > +
> >  static const struct of_device_id simple_pm_bus_of_match[] = {
> >       { .compatible = "simple-pm-bus", },
> > +     { .compatible = "simple-bus",   .data = ONLY_BUS },
> > +     { .compatible = "simple-mfd",   .data = ONLY_BUS },
> > +     { .compatible = "isa",          .data = ONLY_BUS },
> > +     { .compatible = "arm,amba-bus", .data = ONLY_BUS },
> >       { /* sentinel */ }
> >  };
> >  MODULE_DEVICE_TABLE(of, simple_pm_bus_of_match);
> > --
> > 2.33.0.685.g46640cef36-goog
> >
