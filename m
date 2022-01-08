Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mx.groups.io with SMTP id smtpd.web10.1944.1641612132261977607
 for <linux-oxnas@groups.io>;
 Fri, 07 Jan 2022 19:22:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1641612123;
	bh=4GzIY0ljv9AW6N0UClYd6kKAdCa39eEYRz4EIA8wuoI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pYXyuaorg1QeDc+dopbONhWLc/VQ/NyIrSlUqtnFGBjQLsu6rv9sZaZnN2N7SfDT9
	 tfnznOdv8H3ChHZgRMmCTDmhsB22xkiqrpfdqNYpwUtlz1aIK4+7dee1iJGUNHYT0i
	 jGBgZf6gBJ7D0ADL6BNKODLkZtmlS08TSHFQUwGbpYWzSBkzPxrVHYx4fqF4xgGDK9
	 VQSg3qfHnvq4wFgxGYYobF7Q+A4Hnx88qeRfW452+7iEfgtxheBQam9tWQBJbctmBY
	 qSjK3tHCKgjx9xFzud/xOAW7NMk+9V1AoAuujbB3yTPK9flQKKWvYg0HW9j/gmUEu1
	 v1e/wf0M8LcSg==
Date: Fri, 7 Jan 2022 19:22:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH v2 0/3] ARM: ox810se: Add Ethernet support
Message-ID: <20220107192201.56136f10@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20220104145646.135877-1-narmstrong@baylibre.com>
References: <20220104145646.135877-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-oxnas@groups.io, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>
List-ID: <linux-oxnas@groups.io>

On Tue,  4 Jan 2022 15:56:43 +0100 Neil Armstrong wrote:
> This adds support for the Synopsys DWMAC controller found in the
> OX820SE SoC, by using almost the same glue code as the OX820.
> 
> Patch 1 & 2 are for net branch, patch 3 will be queued to arm-soc.
> 
> Changes since v1:
> - correctly update value read from register
> - add proper tag on patch 3 for arm-soc tree

Waiting for Rob's ack, I just noticed you haven't CCed him directly.
Adding his address now, but not sure if that's enough...
