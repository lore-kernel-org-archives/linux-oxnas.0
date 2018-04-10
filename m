Received: by mail-qt0-f194.google.com with SMTP id s2so13489888qti.2
        for <linux-oxnas@groups.io>; Tue, 10 Apr 2018 07:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=0sIk8BseQCCfUhAQRIFn8uRbQcBOgWJ20L0qcIa7nuU=;
        b=I0rQsGS7URIAi0CWO6ErO+ksga159oIh/Gzzou0XCmWk7llAqteS5Ps15PdbYw1mtt
         nVFwK3fX9KBvocN+IyT1G9dFwfHKHdYU0M7Pb00/SYNMwQqTP9jDmZu8xVXI8fV05u9W
         kuTvwDTyhit/xH3y2vGBP1nonW+PFTZXfFH3Ym6MAlowzpaAqI3L9HDRgCkLv/pQH9Ix
         NxA1bfjAhJKnKIihMmJDzgSIs5hITAbeOQT/uJtNyOUl1ZkT/1FCctnB2aGOVh+P80kZ
         rZlve3KPrEYrbgNhAQoXyFiq+8YNB6aY9cW6tZG06QLDr6Cy6Pnfi3j3UAQO7n0XkB9I
         VQeA==
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <1523349825-1969-1-git-send-email-narmstrong@baylibre.com>
References: <1523349825-1969-1-git-send-email-narmstrong@baylibre.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 10 Apr 2018 16:41:46 +0200
Message-ID: <CAK8P3a2PACp3fzg+jfvdAwaxZNQkP391nNy7nnW8wBqGVpkzKg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Migrate oxnas list to groups.io
Content-Type: text/plain; charset="UTF-8"
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: arm-soc <arm@kernel.org>, "moderated list:ARM/OXNAS platform support" <linux-oxnas@lists.tuxfamily.org>, linux-oxnas@groups.io, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-oxnas@groups.io>

On Tue, Apr 10, 2018 at 10:43 AM, Neil Armstrong
<narmstrong@baylibre.com> wrote:
> The linux-oxnas migrates from tuxfamily to groups.io for a simpler
> administration and maintainance.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to fixes branch.

    Arnd
