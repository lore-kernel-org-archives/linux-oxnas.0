Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web11.103111.1692001955990361521
 for <linux-oxnas@groups.io>;
 Mon, 14 Aug 2023 01:32:36 -0700
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3197808bb08so505551f8f.2
        for <linux-oxnas@groups.io>; Mon, 14 Aug 2023 01:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692001954; x=1692606754;
        h=content-transfer-encoding:organization:reply-to:content-language:cc
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PNZQqo4ZyBJ6uD5xvDvqRAAFxsgCDJevt+fCQXqqKbM=;
        b=Q+Pex536L3molux4sK8DDSGu+CXwccqwirDZBktMhMBsQyyIi4lME088Ow7X8HbgfN
         4OfRJXH/52czUhOHz9P9zTpc67BjDNiUROHdMqzgjx89gedCVcMT4LH7aIrPVgjVxpij
         djHljCOoNUJIcDNXuxVc+CJgiHCQlybC92WhCLBoluxEcHArYz8ljHBob1XkTprAoSqy
         Xu1pJuIEFqf8/SKRu1nKFgTMLEsTGPc2A+lTJogPREw+cicz9Tz4OoCCQlfLMZ4I+/IK
         fLcJEY+Kj/8+uidrL/Q5oW3WxVngx2Nd+0qQkFZa29+2/wxt44cYF7yUaz8aS7u1oxRN
         EifQ==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <3f91bb89-bf7b-d967-a302-2a8e1b0c3b01@linaro.org>
Date: Mon, 14 Aug 2023 10:32:33 +0200
MIME-Version: 1.0
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Subject: [PULL] final oxnas removal for 6.6
Reply-To: neil.armstrong@linaro.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: soc@kernel.org, arm@kernel.org
Cc: linux-oxnas@groups.io, linux-arm-kernel@lists.infradead.org
List-ID: <linux-oxnas@groups.io>

Hi,

Please pull this PR to remove all the remaining files for OXNAS support.

The other patches have been merged by the respective maintainers, Mark acked
for routing the irq-versatile changes via a SoC PR.

Thanks,
Neil

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

   Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

   https://git.kernel.org/pub/scm/linux/kernel/git/narmstrong/linux-oxnas.git tags/oxnas-final-for-6.6

for you to fetch changes up to b1627ad5f457c8cea08bb2ab6b24d1c0381fbe30:

   MAINTAINERS: remove OXNAS entry (2023-08-14 10:26:56 +0200)

----------------------------------------------------------------
Final OXNAS removal PR for v6.6:
- Remove irq-versatile-fpga compatible entry
- Mark irq-versatile-fpga oxnas compatible as deprecated
- Remove OXNAS maintainers entry

----------------------------------------------------------------
Neil Armstrong (3):
       irqchip: irq-versatile-fpga: remove obsolete oxnas compatible
       dt-bindings: interrupt-controller: arm,versatile-fpga-irq: mark oxnas compatible as deprecated
       MAINTAINERS: remove OXNAS entry

  .../bindings/interrupt-controller/arm,versatile-fpga-irq.txt   |  4 +++-
  MAINTAINERS                                                    | 10 ----------
  drivers/irqchip/irq-versatile-fpga.c                           |  1 -
  3 files changed, 3 insertions(+), 12 deletions(-)
