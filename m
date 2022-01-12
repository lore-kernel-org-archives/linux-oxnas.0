Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mx.groups.io with SMTP id smtpd.web09.445.1642008995042086908
 for <linux-oxnas@groups.io>;
 Wed, 12 Jan 2022 09:36:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1642008991;
	bh=zBRPIyPp6oesmkdO1v71djmT7VdtBWFe16odSnftCvk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i6RplR0U0jxWZ3QApIwzN4DZ8OVd/Tpmr0JdZrPqDSfRnrJnclsXHRyu+iLjrz4Uv
	 iOGcrIHsQP4M/Vgwq4AxdF+OonPYfeZSnwApvyPUrvcaoBUi9efatPpymZHU4ZFlVz
	 AHIHImesU8Yk8BrKk2dMdiTluN1Z/x56DO1Fx6sqe5n2+f1eaMdWNzzeBZ+1ZEbA1J
	 A5mI1KM5n7v567YhWxxUgyU2usXWIfy3KObWvmDuaVQcUc2T/E08EKxU5VcVOxGGVW
	 hZT1bBWD8ILAv8yny/N69EHcZaC1cPGjCGC0ZgkLM/sMWYN2ZWa2rMnqyJYyJj2LpL
	 YI0BqvjPMIypw==
Date: Wed, 12 Jan 2022 09:36:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH v2 0/3] ARM: ox810se: Add Ethernet support
Message-ID: <20220112093629.03ffcb65@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
In-Reply-To: <20220104145646.135877-1-narmstrong@baylibre.com>
References: <20220104145646.135877-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-oxnas@groups.io, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-ID: <linux-oxnas@groups.io>

On Tue,  4 Jan 2022 15:56:43 +0100 Neil Armstrong wrote:
> This adds support for the Synopsys DWMAC controller found in the
> OX820SE SoC, by using almost the same glue code as the OX820.

Alright, patches 1 and 2 are in net and on their way to 5.17. Thanks!
