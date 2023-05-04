Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [91.207.212.93])
 by mx.groups.io with SMTP id smtpd.web10.44167.1683184174359652134
 for <linux-oxnas@groups.io>;
 Thu, 04 May 2023 00:09:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=BdevYqMi76NwKC3zRXAgy5PN3WHuWUsGRFi5mAmNrPU=;
 b=diBkdS5cAS1F6aGRwKb+ZnpjXcLvvpzZASwgoOP/4T8WkojTtCRd77G8y0wSpK265DFf
 5SRXoIc/CY5v7rG7eBolJXEjxs5ZNy928g9ffgPPkIG0/TUSRBSkZ69nPsngOZ/qKR6R
 Dc+Duyu4G38L9DAJuDKUVJ6ZFi6zwRDwUa2XBGJ9YcUUsZ7jKuPAExnDi3F2gWKNlaiV
 lGX9W7eGu6apovH/vVztA94SREXjCBuLXZ1Ef+IcSl/mQmGRz5U83sXo5yh+4sPvoItI
 nXSuhuHXKRPRxWD3ghAGp+VdxBVGEfJFlyDZ2TPVqtOzUXuqFoZcaBR526anQtwoamsn 5g== 
Message-ID: <95076d3b-5667-8cb3-c09a-e0b7dc2b03c3@foss.st.com>
Date: Thu, 4 May 2023 09:09:14 +0200
MIME-Version: 1.0
Subject: Re: [Linux-stm32] [RFC PATCH 0/1] Categorize ARM dts directory
References: <20220328000915.15041-1-ansuelsmth@gmail.com>
 <85eb14ec-f465-7447-ad77-a3dabc666f47@kernel.org>
 <YkKRYnN84D9VZhGj@Ansuel-xps.localdomain>
 <CAL_Jsq+RQQ-ADMxLPUFwk6S6kGmb6oNDy4k52fnU0EtbUvqmSA@mail.gmail.com>
 <CAMuHMdWNTE48MFy6fqxAsfMWz9b6E7dVNXtXtESP95sxk2PGwA@mail.gmail.com>
 <CAL_JsqJthKTm8bhRF2B=ae1tvtPeYYXx_Tm76qQtSwLtH5C6VA@mail.gmail.com>
 <720a2829-b6b5-411c-ac69-9a53e881f48d@app.fastmail.com>
 <CAL_JsqKCtmkwzKa01gyG65fH8ye6R3KhR41PJbJhOJ4X9j=znA@mail.gmail.com>
 <99b49e6b-e963-415a-a2c9-72505087833c@app.fastmail.com>
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <99b49e6b-e963-415a-a2c9-72505087833c@app.fastmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>
Cc: linux-aspeed@lists.ozlabs.org, linux-realtek-soc@lists.infradead.org, linux-arm-kernel@axis.com, linux-stm32@st-md-mailman.stormreply.com, chrome-platform@lists.linux.dev, linux-samsung-soc@vger.kernel.org, openbmc@lists.ozlabs.org, Krzysztof Kozlowski <krzk@kernel.org>, linux-rockchip@lists.infradead.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-actions@lists.infradead.org, linux-unisoc@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, linux-tegra@vger.kernel.org, linux-amlogic@lists.infradead.org, Linux-OMAP <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Christian Marangi <ansuelsmth@gmail.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, kernel@dh-electronics.com, Olof Johansson <olof@lixom.net>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "linux-oxnas@groups.io" <linux-oxnas@groups.io>
List-ID: <linux-oxnas@groups.io>

On 5/3/23 13:02, Arnd Bergmann wrote:
> On Tue, May 2, 2023, at 21:40, Rob Herring wrote:
>> On Tue, May 2, 2023 at 3:15=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wro=
te:
>=20

...

>=20
>>      'stm' : 'stm32',
>>      'sti' : 'sti',
>>      'st-pin' : 'sti',
>>      'ste' : 'st-ericsson',
>>      'spear' : 'spear',
>=20
> I would put all five of these into 'st'. The ux500 was developed
> in st-ericsson, but last sold by st, and the other ones are all
> original st products.

Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>

thanks
Alex

>=20
>        Arnd
> _______________________________________________
> Linux-stm32 mailing list
> Linux-stm32@st-md-mailman.stormreply.com
> https://st-md-mailman.stormreply.com/mailman/listinfo/linux-stm32

