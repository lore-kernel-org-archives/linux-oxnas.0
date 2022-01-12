Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
 by mx.groups.io with SMTP id smtpd.web08.17208.1641950601438380356
 for <linux-oxnas@groups.io>;
 Tue, 11 Jan 2022 17:23:21 -0800
Received: by mail-oi1-f172.google.com with SMTP id q186so1455169oih.8
        for <linux-oxnas@groups.io>; Tue, 11 Jan 2022 17:23:21 -0800 (PST)
Return-Path: <robherring2@gmail.com>
Date: Tue, 11 Jan 2022 19:23:19 -0600
From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH net-next v2 1/3] dt-bindings: net: oxnas-dwmac: Add bindings for OX810SE
Message-ID: <Yd4th9QfJO62KkQC@robh.at.kernel.org>
References: <20220104145646.135877-1-narmstrong@baylibre.com>
 <20220104145646.135877-2-narmstrong@baylibre.com>
MIME-Version: 1.0
In-Reply-To: <20220104145646.135877-2-narmstrong@baylibre.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: kuba@kernel.org, netdev@vger.kernel.org, linux-oxnas@groups.io, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, davem@davemloft.net, devicetree@vger.kernel.org
List-ID: <linux-oxnas@groups.io>

On Tue, 04 Jan 2022 15:56:44 +0100, Neil Armstrong wrote:
> Add SoC specific bindings for OX810SE support.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  Documentation/devicetree/bindings/net/oxnas-dwmac.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
