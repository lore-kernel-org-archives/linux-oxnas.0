Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web12.4019.1641283832882819785
 for <linux-oxnas@groups.io>;
 Tue, 04 Jan 2022 00:10:33 -0800
Received: by mail-wm1-f44.google.com with SMTP id c66so22669075wma.5
        for <linux-oxnas@groups.io>; Tue, 04 Jan 2022 00:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XtZPNg5BQ2lnjrzwucV2YutRAMLHihSI4hljd/dvjjQ=;
        b=UIEksoicnTnbSAoKcrAyVcpWdKN+T7XDY3vxn8ND3Bj46J/5DgwNNmbOq4zUyTfz1i
         1cZhrodOO1N3Xt1bL1wqT006VJvBlsl1PvJY0ELWL/IZ792SaBU2WNUjsdlgcQNfyWZB
         wE1KcLgPRf1mxJxiGohnYPnD7EheF58ExKmf34RQODJDRe+tFXl2mSxZfaCnijRp5W90
         5WTFpiwvnbz0E3N3zb5AijS4CAbWecjwhE/hlBkhEmbsWNgDkKUayPBFVrygmVCZnCno
         ojXqhbvYk9+OxyLWWstRO6e651xKN/Meruc+yaqNuHKQ2ct4pF3sTw78hixHVhMNHfFc
         gVKA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 0/3] ARM: ox810se: Add Ethernet support
References: <20220103175638.89625-1-narmstrong@baylibre.com>
 <20220103200637.0b9d7e4f@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <151bbcee-2f3b-4454-4244-523917cd4900@baylibre.com>
Date: Tue, 4 Jan 2022 09:10:30 +0100
MIME-Version: 1.0
In-Reply-To: <20220103200637.0b9d7e4f@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io, linux-kernel@vger.kernel.org
List-ID: <linux-oxnas@groups.io>

Hi,

On 04/01/2022 05:06, Jakub Kicinski wrote:
> On Mon,  3 Jan 2022 18:56:35 +0100 Neil Armstrong wrote:
>> This adds support for the Synopsys DWMAC controller found in the
>> OX820SE SoC, by using almost the same glue code as the OX820.
>>
>> Neil Armstrong (3):
>>   dt-bindings: net: oxnas-dwmac: Add bindings for OX810SE
>>   net: stmmac: dwmac-oxnas: Add support for OX810SE
>>   ARM: dts: ox810se: Add Ethernet support
> 
> Judging by the subject tag on patches 1 and 2 and To: I presume you
> intend this series to be merged via net-next? Can you please repost
> with patch 3 CCed to netdev as well? It didn't register in patchwork.

It was on purpose, I planned to push the DT through arm-soc, sorry it wasn't
explicit in the cover letter.

Neil
