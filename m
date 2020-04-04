Received: from fudo.makrotopia.org (fudo.makrotopia.org [185.142.180.71])
 by mx.groups.io with SMTP id smtpd.web11.2105.1586022079422619161
 for <linux-oxnas@groups.io>;
 Sat, 04 Apr 2020 10:41:19 -0700
Date: Sat, 4 Apr 2020 18:41:03 +0100
From: "Daniel Golle" <daniel@makrotopia.org>
Subject: ata_bmdma_qc_prep causing page fault
Message-ID: <20200404174103.GA209497@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: linux-ide@vger.kernel.org, linux-oxnas@groups.io
List-ID: <linux-oxnas@groups.io>

Hi!

I'm working on porting the driver for the SATA controller
included in OX820 into modern kernels and getting it more fit for
potential inclusion in upstream Linux.

Original driver source from OXNAS SDK:
https://github.com/WarheadsSE/OX820-2.6-linux/blob/master/drivers/ata/ox820sata.c

My version based on Ma Haijun's previous work:
https://git.openwrt.org/?p=openwrt/openwrt.git;a=blob;f=target/linux/oxnas/files/drivers/ata/sata_oxnas.c

While things are generally working, I reliably keep seeing kernel oops
when ever the system has been under load for a short while (in this
case a md raid1 sync operation running in background was enough):

[ 3557.139765] 8<--- cut here ---
[ 3557.142822] Unable to handle kernel paging request at virtual address d080b004
[ 3557.150010] pgd = 577d9dbb
[ 3557.152704] [d080b004] *pgd=6b00b811, *pte=00000000, *ppte=00000000
[ 3557.158952] Internal error: Oops: 807 [#1] SMP ARM
[ 3557.163717] Modules linked in: iptable_nat xt_state xt_nat xt_conntrack xt_REDIRECT xt_MASQUERADE xt_CT rndis_host nf_nat nf_conntrc
[ 3557.163929]  blowfish_generic blowfish_common anubis ecdh_generic ecc xts xcbc crypto_user algif_skcipher algif_rng algif_hash algic
[ 3557.305221] CPU: 1 PID: 77 Comm: kworker/1:1H Tainted: G         C        5.4.28 #0
[ 3557.312837] Hardware name: Generic DT based system
[ 3557.317616] Workqueue: kblockd blk_mq_requeue_work
[ 3557.322575] PC is at ata_bmdma_qc_prep+0x40/0xd0 [libata]
[ 3557.327951] LR is at 0x8000
[ 3557.330726] pc : [<bf228630>]    lr : [<00008000>]    psr: 80000093
[ 3557.336960] sp : cb671d88  ip : 689b8000  fp : ca15d5d8
[ 3557.342156] r10: ca148a00  r9 : 00008000  r8 : d080a808
[ 3557.347356] r7 : 000000fd  r6 : d080a810  r5 : ca03c7b4  r4 : 000000ff
[ 3557.353848] r3 : 00002000  r2 : ffff8000  r1 : d080b000  r0 : c9b7e7d0
[ 3557.360340] Flags: Nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
[ 3557.367523] Control: 00c5787d  Table: 6a1f000a  DAC: 00000051
[ 3557.373242] Process kworker/1:1H (pid: 77, stack limit = 0x794bc266)
[ 3557.379566] Stack: (0xcb671d88 to 0xcb672000)
[ 3557.383907] 1d80:                   ca03c7b4 d0866000 00000000 00000001 00000015 00130000
[ 3557.392051] 1da0: ca148a00 bf249708 ca03c7b4 ca03c000 ca03d5e0 c010b268 00000015 00130000
[ 3557.400197] 1dc0: ca148a00 bf216684 00000000 ca03d920 ca03c7b4 00000000 ca03d920 bf21e7c8
[ 3557.408343] 1de0: ca03c000 bf21ead8 ca03d920 ca15d550 ca03c000 80000013 00000000 cb671e68
[ 3557.416488] 1e00: ca148a00 bf2211e8 ca15d4a0 ca150800 ca150000 ca15d550 00000000 bf1cee24
[ 3557.424634] 1e20: 8a4d477e 00000000 cb2f5fe0 ca15d4d0 cb671e98 ca148a00 00000000 ca15d4a0
[ 3557.432778] 1e40: 00000000 00000000 cb2f5fe0 c031b110 cb148fc0 00000000 00008200 cbd87a40
[ 3557.440924] 1e60: 00000000 35d20e00 ca15d4a0 cbd87a01 35d20e00 ca148a00 ca148a04 cb671e98
[ 3557.449064] 1e80: cb2f5fe0 00000000 00000000 00000060 ffffe000 c03200ec cb671e98 cb671e98
[ 3557.457208] 1ea0: ca148a00 00000000 00000000 00000000 00000000 c0319164 ca148a00 00000000
[ 3557.465351] 1ec0: 00000000 c03197d4 00000001 00000000 ca148a00 00000000 00000000 00000000
[ 3557.473495] 1ee0: 00000060 c031a5ec 00000000 cb2f5fe0 00000000 cb2f5fe0 00000000 c031a6ac
[ 3557.481638] 1f00: cb671ee0 00000080 cb671f10 c031bec0 cb671f10 cb671f10 cbd8c300 cb2f63b8
[ 3557.489786] 1f20: cb6417e0 cbd87840 cbd8c300 c0130f10 00000008 cbd87858 cb6417e0 cb6417f4
[ 3557.497932] 1f40: cbd87840 00000008 cbd87858 c0902ca0 cbd87840 c0131190 cb148f60 cb678c20
[ 3557.506078] 1f60: ffffe000 00000000 cb67a2c0 cb678c20 cb670000 cb6417e0 c0131164 cb071eb4
[ 3557.514224] 1f80: cb67a2dc c013619c 00000001 cb678c20 c013606c 00000000 00000000 00000000
[ 3557.522365] 1fa0: 00000000 00000000 00000000 c01010e8 00000000 00000000 00000000 00000000
[ 3557.530511] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[ 3557.538652] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
[ 3557.547159] [<bf228630>] (ata_bmdma_qc_prep [libata]) from [<bf249708>] (sata_oxnas_qc_prep+0x6c/0x148 [sata_oxnas])
[ 3557.557913] [<bf249708>] (sata_oxnas_qc_prep [sata_oxnas]) from [<bf216684>] (ata_qc_issue+0x11c/0x2f4 [libata])
[ 3557.568394] [<bf216684>] (ata_qc_issue [libata]) from [<bf21ead8>] (ata_scsi_rw_xlat+0x310/0x3dc [libata])
[ 3557.578342] [<bf21ead8>] (ata_scsi_rw_xlat [libata]) from [<bf2211e8>] (ata_scsi_queuecmd+0x9c/0x4cc [libata])
[ 3557.588682] [<bf2211e8>] (ata_scsi_queuecmd [libata]) from [<bf1cee24>] (scsi_queue_rq+0x620/0x81c [scsi_mod])
[ 3557.598871] [<bf1cee24>] (scsi_queue_rq [scsi_mod]) from [<c031b110>] (blk_mq_dispatch_rq_list+0xa8/0x5e4)
[ 3557.608501] [<c031b110>] (blk_mq_dispatch_rq_list) from [<c03200ec>] (blk_mq_sched_dispatch_requests+0xf4/0x178)
[ 3557.618644] [<c03200ec>] (blk_mq_sched_dispatch_requests) from [<c0319164>] (__blk_mq_run_hw_queue+0x94/0x190)
[ 3557.628610] [<c0319164>] (__blk_mq_run_hw_queue) from [<c03197d4>] (__blk_mq_delay_run_hw_queue+0x170/0x17c)
[ 3557.638397] [<c03197d4>] (__blk_mq_delay_run_hw_queue) from [<c031a5ec>] (blk_mq_run_hw_queue+0xb8/0x140)
[ 3557.647923] [<c031a5ec>] (blk_mq_run_hw_queue) from [<c031a6ac>] (blk_mq_run_hw_queues+0x38/0x4c)
[ 3557.656757] [<c031a6ac>] (blk_mq_run_hw_queues) from [<c031bec0>] (blk_mq_requeue_work+0x148/0x150)
[ 3557.665771] [<c031bec0>] (blk_mq_requeue_work) from [<c0130f10>] (process_one_work+0x214/0x468)
[ 3557.674437] [<c0130f10>] (process_one_work) from [<c0131190>] (worker_thread+0x2c/0x5d8)
[ 3557.682503] [<c0131190>] (worker_thread) from [<c013619c>] (kthread+0x130/0x144)
[ 3557.689873] [<c013619c>] (kthread) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
[ 3557.697059] Exception stack(0xcb671fb0 to 0xcb671ff8)
[ 3557.702087] 1fa0:                                     00000000 00000000 00000000 00000000
[ 3557.710228] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[ 3557.718371] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[ 3557.724958] Code: e1a07004 e2468008 ea000007 e6ff3073 (e5813004) 
[ 3557.731025] ---[ end trace a89aa84a5c9cf43e ]---

I've tried with disabling SMP to exclude congruency issues which
didn't help. The bug has also been confirmed to occur on devices with
only one SATA port and on devices with different amount of RAM.

Looking at the code, I don't see any reason why the
queued command handed to ata_bmdma_qc_prep(qc) should contain pointers
to invalid memory.

1805 static void sata_oxnas_qc_prep(struct ata_queued_cmd *qc)
1806 {
1807         struct sata_oxnas_port_priv *pd;
1808         int port_no = qc->ap->port_no;
1809 
1810         /* if the port's not connected, complete now with an error */
1811         if (!sata_oxnas_check_link(qc->ap)) {
1812                 ata_port_err(qc->ap,
1813                         "port %d not connected completing with error\n",
1814                         port_no);
1815                 qc->err_mask |= AC_ERR_ATA_BUS;
1816                 ata_qc_complete(qc);
1817         }
1818 
1819         sata_oxnas_reset_ucode(qc->ap->host, 0, 0);
1820 
1821         /* both pio and dma commands use dma */
1822         if (ata_is_dma(qc->tf.protocol) || ata_is_pio(qc->tf.protocol)) {
1823 
1824                 /* program the scatterlist into the prd table */
1825                 ata_bmdma_qc_prep(qc);
                     ^^^^^^^^^^^^^^^^^^^^^^

I'm aware that the driver in it's current state needs a lot of cleaning
and modifications to be suitable for inclusion. However, I'd still like
to understand what goes wrong here and get to a working state which can
then be further cleaned up.

So any hints are appreciated :)



Best regards


Daniel
