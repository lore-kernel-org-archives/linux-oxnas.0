Date: Tue, 16 Apr 2019 21:26:22 +0200
From: "Daniel Golle" <daniel@makrotopia.org>
Subject: Re: [PATCH 3/4] clocksource/drivers/oxnas: Fix OX820 compatible
Message-ID: <20190416192621.GE1409@makrotopia.org>
References: <92427592-507b-e280-01bf-763d795c8a2f@linaro.org>
 <20190416124640.20058-1-daniel.lezcano@linaro.org>
 <20190416124640.20058-3-daniel.lezcano@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20190416124640.20058-3-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>, "moderated list:ARM/OXNAS platform support" <linux-arm-kernel@lists.infradead.org>, "moderated list:ARM/OXNAS platform support" <linux-oxnas@groups.io>
List-ID: <linux-oxnas@groups.io>

Works great here

On Tue, Apr 16, 2019 at 02:46:39PM +0200, Daniel Lezcano wrote:
> From: Neil Armstrong <narmstrong@baylibre.com>
> 
> The OX820 compatible is wrong is the driver, fix it.
> 
> Fixes: 2ea3401e2a84 ("clocksource/drivers/oxnas: Add OX820 compatible")
> Reported-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Daniel Golle <daniel@makrotopia.org>

> ---
>  drivers/clocksource/timer-oxnas-rps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/timer-oxnas-rps.c b/drivers/clocksource/timer-oxnas-rps.c
> index eed6feff8b5f..30c6f4ce672b 100644
> --- a/drivers/clocksource/timer-oxnas-rps.c
> +++ b/drivers/clocksource/timer-oxnas-rps.c
> @@ -296,4 +296,4 @@ static int __init oxnas_rps_timer_init(struct device_node *np)
>  TIMER_OF_DECLARE(ox810se_rps,
>  		       "oxsemi,ox810se-rps-timer", oxnas_rps_timer_init);
>  TIMER_OF_DECLARE(ox820_rps,
> -		       "oxsemi,ox820se-rps-timer", oxnas_rps_timer_init);
> +		       "oxsemi,ox820-rps-timer", oxnas_rps_timer_init);
> -- 
> 2.17.1
> 
