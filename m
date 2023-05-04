Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
 by mx.groups.io with SMTP id smtpd.web10.46200.1683195141448184722
 for <linux-oxnas@groups.io>;
 Thu, 04 May 2023 03:12:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=f9IPUEpyBrx41XXxSrkiHV0HEd6PMWxGjklTbCAmGKM=; b=Q2NqYN/Fkihy43H/8u3aGt/ofV
	0Y3XG6lm1CdWYvSiyatBQ0G5rRbPax1/SdmoCS8XzIq+LwlMiGRbgHOk4KJPHv71XsXkaJq2rJ5Aj
	oxG9AvHjaWpZz4law9GcRvdMWb5N2Wifr9JYNfIetVLNCPLXypTpm6Is4LWo3d1NTmynlrimN4Eny
	cZnL0m6aof24zIK6IikSgO1ZfVrw6maAcn74DcOlxGeJrmSHo3wewf0gylo8qjrdlLr+aqmrpi/tX
	7yIxxbUSVIgoGy+PMVarbqsZ8KOUU+VZLp5gLcuM3Hi+fibA8zNzcOqtUa8fp+v1dquHPB76oUNO6
	/bHPZLnw==;
Date: Thu, 4 May 2023 11:11:47 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
Subject: Re: [RFC PATCH 0/1] Categorize ARM dts directory
Message-ID: <ZFOE4wd31hpJh0ro@shell.armlinux.org.uk>
References: <20220328000915.15041-1-ansuelsmth@gmail.com>
 <85eb14ec-f465-7447-ad77-a3dabc666f47@kernel.org>
 <YkKRYnN84D9VZhGj@Ansuel-xps.localdomain>
 <CAL_Jsq+RQQ-ADMxLPUFwk6S6kGmb6oNDy4k52fnU0EtbUvqmSA@mail.gmail.com>
 <CAMuHMdWNTE48MFy6fqxAsfMWz9b6E7dVNXtXtESP95sxk2PGwA@mail.gmail.com>
 <CAL_JsqJthKTm8bhRF2B=ae1tvtPeYYXx_Tm76qQtSwLtH5C6VA@mail.gmail.com>
 <720a2829-b6b5-411c-ac69-9a53e881f48d@app.fastmail.com>
 <CAL_JsqKCtmkwzKa01gyG65fH8ye6R3KhR41PJbJhOJ4X9j=znA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKCtmkwzKa01gyG65fH8ye6R3KhR41PJbJhOJ4X9j=znA@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Rob Herring <robh+dt@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Olof Johansson <olof@lixom.net>, Christian Marangi <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org, linux-sunxi@lists.linux.dev, Linux-OMAP <linux-omap@vger.kernel.org>, linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com, linux-aspeed@lists.ozlabs.org, linux-rpi-kernel@lists.infradead.org, chrome-platform@lists.linux.dev, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, linux-samsung-soc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, kernel@dh-electronics.com, linux-mediatek@lists.infradead.org, openbmc@lists.ozlabs.org, linux-tegra@vger.kernel.org, "linux-oxnas@groups.io" <linux-oxnas@groups.io>, linux-arm-msm@vger.kernel.org, linux-unisoc@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-realtek-soc@lists.infradead.org
List-ID: <linux-oxnas@groups.io>

On Tue, May 02, 2023 at 02:40:19PM -0500, Rob Herring wrote:
> I think the only issue remaining is finalizing the mapping of
> platforms to subdirs. What I have currently is a mixture of SoC
> families and vendors. The most notable are all the Freescale/NXP
> platforms, pxa, socfpga, and stm32. It's not consistent with arm64
> either. Once that's finalized, I still need to go update MAINTAINERS.

I haven't followed this discussion at all, so here's a question.

What does this mean for the _installed_ dtb files? Do they move
location? If they do, lots is going to break, because there will
be u-boot configurations and other scripts that assume the flat
directory structure for the installed dtb files.

I don't think changing the installed dtb structure is acceptable
at this point in time. It's something that _should_ have been
thought about when ARM was converted to dtb, it's too late to be
changing that now.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
