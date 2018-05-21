Received: by mail-ua0-f181.google.com with SMTP id y8-v6so10391579ual.5
        for <linux-oxnas@groups.io>; Mon, 21 May 2018 10:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=oFPz+R+KoBuN6xVjHkMR+m+7BG7CeAOt1StTH7RtsB8=;
        b=Bp40BNDzHg9el9WLFwngjOdKII6vn2XAfvbxjBmf5VhifFvDlkzHZHTxDfdRqSzgA5
         JPiqtsH2MIxbiosww7RY1ykP3vTCarwyynMWkMr1fbTPyO3OYDnAq9CB68itxhM5oCiE
         kYuVphEH1s5Z31fUmSi8xGlM+L6kZOvAtJSRQbEiL4pODkNXvkzsO5QG9SrdJKxAwciu
         ZavmOZNiSKeYZN3qq+/XIUgO3ekno0pAsTDSo/pfUUTVMZiyhNvpaAf1n7CmiqJx1eQX
         R/0pz+ltu3esQiV57Njzd29m9d1yQRpti12wNDUhOv85+jH/n8OcgbsE3hctdGp0WXgA
         Pjow==
MIME-Version: 1.0
From: Raymond Elliot <raymundo.elliot@gmail.com>
Date: Mon, 21 May 2018 18:06:04 +0100
Message-ID: <CABNOhB=VrOBfkdTUr4_xhT63Yk-UNWf+TkxSV9=oPJr15WSB1A@mail.gmail.com>
Subject: Help supporting Thecus N2200
Content-Type: multipart/mixed; boundary="0000000000002b0ee2056cba51d0"
To: linux-oxnas@groups.io
List-ID: <linux-oxnas@groups.io>

--0000000000002b0ee2056cba51d0
Content-Type: multipart/alternative; boundary="0000000000002b0ede056cba51ce"

--0000000000002b0ede056cba51ce
Content-Type: text/plain; charset="UTF-8"

Hi there,


While I have been doing development and architecture for a long time (25+
years) I am a bit of a kernel newbie and as such Neil Armstrong has pointed
me in this direction for help in building a kernel for the Thecus N2200
(which is an ox810se based NAS).

I apologise for the lengthy email, but Neil asked for all the steps that I
took to run it.

I assume the N2200 is ox810se board based on cat'ing /proc/cpuinfo which
reads:

Processor       : ARM926EJ-S rev 5 (v5l)
BogoMIPS        : 183.09
Features        : swp half thumb fastmult edsp java
CPU implementer : 0x41
CPU architecture: 5TEJ
CPU variant     : 0x0
CPU part        : 0x926
CPU revision    : 5
Cache type      : write-back
Cache clean     : cp15 c7 ops
Cache lockdown  : format C
Cache format    : Harvard
I size          : 32768
I assoc         : 4
I line length   : 32
I sets          : 256
D size          : 32768
D assoc         : 4
D line length   : 32
D sets          : 256

Hardware        : Oxsemi NAS
Revision        : 0000
Serial          : 00000acbd96ea900

My plan was to take a recent kernel (I started on this a while back and so
tried 4.9.93) and piggy back on the support included for the MBWE support
already there.  To test it I'm trying to build the kernel along with the
relevant device tree based on arch/arm/boot/dts/wde-mbwe.dts, deploy it to
a TFTP server and boot it manually using u-boot (the built-in version is
1.1.2) using the following script which was already defined:

ramboot=setenv bootargs root=/dev/ram rw init=/linuxrc mem=256M
mac_addr=$ethaddr mac1_addr=$eth1addr console=$consoledev,$baudrate
$othbootargs;tftp $ramdiskaddr $ramdiskfile;tftp $uimageaddr
$uimagefile;bootm $uimageaddr $ramdiskaddr

The relevant u-boot environment values are:

bootargs= mem=256M
eth1addr=00:50:8D:30:FF:B3
consoledev=ttyS0
uimageaddr=49000000
uimagefile=N2200/uImage
ramdiskaddr=4B000000
ramdiskfile=N2200/uramdisk

I've got to the stage where I can build the kernel and attempt to start it
with u-boot but the kernel crashes with a "data abort" error and a readout
of the register values, but nothing more.

Here are the steps I've taken so far.

Created a base .config file:

$ ARCH_OXNAS=y ARCH_MULTI_V5=y ARCH=arm make versatile_defconfig

My understanding of v1.1.2 of u-boot is that I need to append the DTB onto
the end of the kernel so I updated the .config using make menuconfig as
follows (.config is attached):

$ ARCH_OXNAS=y ARCH_MULTI_V5=y ARCH=arm make menuconfig

    -> Enable "System Type" / "Oxford Semiconductor OXNAS Family SoCs" /
"Support OX810SE Based Products"
    -> Enable "Boot options" / [*] Use appended device tree blob to zImage
(EXPERIMENTAL)
                                              [*]   Supplement the appended
DTB with traditional ATAG information

I then created a new arch/arm/boot/dts/thecus-n2200.dts file:

/*
 * thecus-n2200.dts - Device tree file for Thecus N2200
 *
 * Copyright (C) 2018 Raymond Elliot <raymundo.elliot@gmail.com>
 *
 * Licensed under GPLv2 or later
 */

/dts-v1/;
#include "ox810se.dtsi"

/ {
model = "Thecus N2200";

compatible = "thecus,thecus-n2200", "oxsemi,ox810se";

chosen {
bootargs = "console=ttyS1,115200n8";
};

memory {
/* Max 256MB @ 0x48000000 */
reg = <0x48000000 0x10000000>;
};

aliases {
serial1 = &uart1;
gpio0 = &gpio0;
gpio1 = &gpio1;
};

gpio-keys-polled {
compatible = "gpio-keys-polled";
#address-cells = <1>;
#size-cells = <0>;
poll-interval = <100>;

power {
label = "power";
gpios = <&gpio0 0 1>;
linux,code = <0x198>;
};

recovery {
label = "recovery";
gpios = <&gpio0 4 1>;
linux,code = <0xab>;
};
};

leds {
compatible = "gpio-leds";

a0 {
label = "activity0";
gpios = <&gpio0 25 0>;
default-state = "keep";
};

a1 {
label = "activity1";
gpios = <&gpio0 26 0>;
default-state = "keep";
};

a2 {
label = "activity2";
gpios = <&gpio0 5 0>;
default-state = "keep";
};

a3 {
label = "activity3";
gpios = <&gpio0 6 0>;
default-state = "keep";
};

a4 {
label = "activity4";
gpios = <&gpio0 7 0>;
default-state = "keep";
};

a5 {
label = "activity5";
gpios = <&gpio1 2 0>;
default-state = "keep";
};
};

i2c-gpio {
compatible = "i2c-gpio";
gpios = <&gpio0 3 0 /* sda */
&gpio0 2 0 /* scl */
>;
i2c-gpio,delay-us = <2>;        /* ~100 kHz */
#address-cells = <1>;
#size-cells = <0>;

rtc0: rtc@48 {
compatible = "st,m41t00";
reg = <0x68>;
};
};
};

&uart1 {
status = "okay";

pinctrl-names = "default";
pinctrl-1 = <&pinctrl_uart1>;
};

My first goal was to at least get some output from the serial console so at
least I could see if and where things were going wrong.  However, I wasn't
sure how to configure it, so I played around with different alias values
for serial1 and uart1, but to no avail.  The original Thecus kernel
(2.6.24) has the following defined which is why I was trying to get serial1
to work:

CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_ARCH_OXNAS_UART2=y
CONFIG_ARCH_OXNAS_CONSOLE_UART=2

I then updated arch/arm/boot/dts/Makefile to include a thecus-n2200.dtb
target.

The kernel was built using:

$ LOADADDR=0x49000000 ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make -j8
uImage dtbs

I only have bootm available in u-boot so the compressed images (uImage and
zImage) didn't work and resulted in invalid instruction crashes, so the
device tree was appended thus:

$ cat arch/arm/boot/Image arch/arm/boot/dts/thecus-n2200.dtb >
arch/arm/boot/dts/Image+dtb

I then created the final image by doing the following:

$ mkimage -A arm -O linux -T kernel -C none -a 0x49000000 -e 0x49000000 -n
"My Kernel" -d "arch/arm/boot/dts/Image+dtb" arch/arm/boot/uImage.n2200

uImage.n2200 was copied to my TFTP server and renamed N2200/uImage as per
the u-boot tftp command.

I then started the NAS and from u-boot did (the uramdisk image is the
original initramfs file from the machine):

N2200$ run ramboot
Wait GMAC to reset
Wait for PHY reset
Wait for link to come up.............Link up
Wait for auto-negotiation to complete
Link is 1000M
TFTP from server 192.168.0.50; our IP address is 192.168.0.52
Filename 'N2200/uramdisk'.
Load address: 0x4b000000
Loading: #################################################################
         #################################################################
         #################################################################
         ##############################################################
done
Bytes transferred = 1310720 (140000 hex)
Wait GMAC to reset
Wait for PHY reset
Wait for link to come up................Link up
Wait for auto-negotiation to complete
Link is 1000M
TFTP from server 192.168.0.50; our IP address is 192.168.0.52
Filename 'N2200/uImage'.
Load address: 0x49000000
Loading: #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #############################################
done
Bytes transferred = 4556591 (45872f hex)
## Booting image at 49000000 ...
   Image Name:   My Kernel
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    4556527 Bytes =  4.3 MB
   Load Address: 49000000
   Entry Point:  49000000
   Verifying Checksum ... OK
   XIP Kernel Image ... OK
## Loading Ramdisk Image at 4b000000 ...
   Image Name:   uboot initramfs
   Image Type:   ARM Linux RAMDisk Image (gzip compressed)
   Data Size:    1228235 Bytes =  1.2 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK

Starting kernel ...
 data abort
pc : [<491c0544>]    lr : [<4900000c>]
sp : 48cdd7b4  ip : 00000003  fp : 48d1664c
r10: 00000003  r9 : ffed3b51  r8 : 48cddfdc
r7 : 00000003  r6 : 00000480  r5 : 00000000  r4 : ffffb400
r3 : 00000010  r2 : 48cdd7b4  r1 : ffffda00  r0 : 000000e1
Flags: nzcv  IRQs off  FIQs off  Mode SVC_32

So that's where I'm at now and basically kinda stuck.  Any help or
suggestions you have would be very gratefully received !

Kind regards,
Raymond

--0000000000002b0ede056cba51ce
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi there,<div><br/></div><div><span style=3D"font-variant-=
ligatures:normal;  font-variant-caps:normal;  letter-spacing:normal;  text-=
align:start;  text-indent:0px;  text-transform:none;  white-space:normal;  =
word-spacing:0px;  text-decoration-style:initial;  text-decoration-color:in=
itial;  float:none;  display:inline; ;"><div style=3D"font-variant-ligature=
s:normal;  font-variant-caps:normal;  letter-spacing:normal;  text-align:st=
art;  text-indent:0px;  text-transform:none;  white-space:normal;  word-spa=
cing:0px;  text-decoration-style:initial;  text-decoration-color:initial; ;=
"><br/></div>While I have been doing development and architecture for a lon=
g time (25+ years) I am a bit of a kernel newbie and as such=C2=A0</span>Ne=
il Armstrong has pointed me in this direction for help in building a kernel=
 for the Thecus N2200 (which is an ox810se based NAS).=C2=A0=C2=A0</div><di=
v><br/></div><div><div style=3D"font-variant-ligatures:normal;  font-varian=
t-caps:normal;  letter-spacing:normal;  text-align:start;  text-indent:0px;=
  text-transform:none;  white-space:normal;  word-spacing:0px;  text-decora=
tion-style:initial;  text-decoration-color:initial; ;">I apologise for the =
lengthy email, but Neil asked for all the steps that I took to run it.</div=
><br/></div><div>I assume the N2200 is ox810se board based on cat&#39;ing /=
proc/cpuinfo which reads:<br/></div><div><div style=3D"font-variant-ligatur=
es:normal;  font-variant-caps:normal;  letter-spacing:normal;  text-align:s=
tart;  text-indent:0px;  text-transform:none;  white-space:normal;  word-sp=
acing:0px;  text-decoration-style:initial;  text-decoration-color:initial; =
;"><br/></div><div style=3D"font-variant-ligatures:normal;  font-variant-ca=
ps:normal;  letter-spacing:normal;  text-align:start;  text-indent:0px;  te=
xt-transform:none;  white-space:normal;  word-spacing:0px;  text-decoration=
-style:initial;  text-decoration-color:initial; ;"><div><defangedfont face=
=3D"monospace, monospace" size=3D"1">Processor=C2=A0 =C2=A0 =C2=A0 =C2=A0:=
 ARM926EJ-S rev 5 (v5l)</defangedfont></div><div><defangedfont face=3D"mono=
space, monospace" size=3D"1">BogoMIPS=C2=A0 =C2=A0 =C2=A0 =C2=A0 : 183.09</=
defangedfont></div><div><defangedfont face=3D"monospace, monospace" size=3D=
"1">Features=C2=A0 =C2=A0 =C2=A0 =C2=A0 : swp half thumb fastmult edsp java=
</defangedfont></div><div><defangedfont face=3D"monospace, monospace" size=
=3D"1">CPU implementer : 0x41</defangedfont></div><div><defangedfont face=
=3D"monospace, monospace" size=3D"1">CPU architecture: 5TEJ</defangedfont>=
</div><div><defangedfont face=3D"monospace, monospace" size=3D"1">CPU varia=
nt=C2=A0 =C2=A0 =C2=A0: 0x0</defangedfont></div><div><defangedfont face=3D"=
monospace, monospace" size=3D"1">CPU part=C2=A0 =C2=A0 =C2=A0 =C2=A0 : 0x92=
6</defangedfont></div><div><defangedfont face=3D"monospace, monospace" size=
=
=3D"1">CPU revision=C2=A0 =C2=A0 : 5</defangedfont></div><div><defangedfon=
t face=3D"monospace, monospace" size=3D"1">Cache type=C2=A0 =C2=A0 =C2=A0 :=
 write-back</defangedfont></div><div><defangedfont face=3D"monospace, monos=
pace" size=3D"1">Cache clean=C2=A0 =C2=A0 =C2=A0: cp15 c7 ops</defangedfont=
></div><div><defangedfont face=3D"monospace, monospace" size=3D"1">Cache lo=
ckdown=C2=A0 : format C</defangedfont></div><div><defangedfont face=3D"mono=
space, monospace" size=3D"1">Cache format=C2=A0 =C2=A0 : Harvard</defangedf=
ont></div><div><defangedfont face=3D"monospace, monospace" size=3D"1">I siz=
e=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : 32768</defangedfont></div><div><defan=
gedfont face=3D"monospace, monospace" size=3D"1">I assoc=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0: 4</defangedfont></div><div><defangedfont face=3D"monosp=
ace, monospace" size=3D"1">I line length=C2=A0 =C2=A0: 32</defangedfont></d=
iv><div><defangedfont face=3D"monospace, monospace" size=3D"1">I sets=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : 256</defangedfont></div><div><defangedfont f=
ace=3D"monospace, monospace" size=3D"1">D size=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 : 32768</defangedfont></div><div><defangedfont face=3D"monospace, m=
onospace" size=3D"1">D assoc=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: 4</defanged=
font></div><div><defangedfont face=3D"monospace, monospace" size=3D"1">D li=
ne length=C2=A0 =C2=A0: 32</defangedfont></div><div><defangedfont face=3D"m=
onospace, monospace" size=3D"1">D sets=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : =
256</defangedfont></div><div><defangedfont face=3D"monospace, monospace" si=
ze=3D"1"><br/></defangedfont></div><div><defangedfont face=3D"monospace, mo=
nospace" size=3D"1">Hardware=C2=A0 =C2=A0 =C2=A0 =C2=A0 : Oxsemi NAS</defan=
gedfont></div><div><defangedfont face=3D"monospace, monospace" size=3D"1">R=
evision=C2=A0 =C2=A0 =C2=A0 =C2=A0 : 0000</defangedfont></div><div><defange=
dfont face=3D"monospace, monospace" size=3D"1">Serial=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 : 00000acbd96ea900</defangedfont></div></div><div style=3D"f=
ont-variant-ligatures:normal;  font-variant-caps:normal;  letter-spacing:no=
rmal;  text-align:start;  text-indent:0px;  text-transform:none;  white-spa=
ce:normal;  word-spacing:0px;  text-decoration-style:initial;  text-decorat=
ion-color:initial; ;"><br/></div></div><div>My plan was to take a recent ke=
rnel (I started on this a while back and so tried 4.9.93) and piggy back on=
 the support included for the MBWE support already there.=C2=A0 To test it =
I&#39;m trying to build the kernel along with the relevant device tree base=
d on=C2=A0<span style=3D"">arch/arm/boot/dts/wde-mbwe.dts, deploy it to a T=
FTP server and boot it manually using u-boot (the built-in version is 1.1.2=
) using the following script which was already defined:</span><br/></div><d=
iv><span style=3D"font-variant-ligatures:normal;  font-variant-caps:normal;=
  letter-spacing:normal;  text-align:start;  text-indent:0px;  text-transfo=
rm:none;  white-space:normal;  word-spacing:0px;  text-decoration-style:ini=
tial;  text-decoration-color:initial;  float:none;  display:inline; ;"><br/=
></span></div><div><span style=3D"text-align:start;  text-indent:0px;  text=
-decoration-style:initial;  text-decoration-color:initial;  float:none;  di=
splay:inline; ;"><defangedfont face=3D"monospace, monospace" size=3D"1">ram=
boot=3Dsetenv bootargs root=3D/dev/ram rw init=3D/linuxrc mem=3D256M mac_ad=
dr=3D$ethaddr mac1_addr=3D$eth1addr console=3D$consoledev,$baudrate $othboo=
targs;tftp $ramdiskaddr $ramdiskfile;tftp $uimageaddr $uimagefile;bootm $ui=
mageaddr $ramdiskaddr</defangedfont><br/></span></div><div><br/></div><div>=
<span style=3D"">The relevant u-boot environment values are:</span></div><d=
iv><span style=3D""><br/></span></div><div><div><defangedfont face=3D"monos=
pace, monospace" size=3D"1">bootargs=3D mem=3D256M</defangedfont></div><div=
><defangedfont face=3D"monospace, monospace" size=3D"1">eth1addr=3D00:50:8D=
:30:FF:B3</defangedfont></div><div style=3D"text-align:start;  text-indent:=
0px;  text-decoration-style:initial;  text-decoration-color:initial; ;"><de=
fangedfont face=3D"monospace, monospace" size=3D"1">consoledev=3DttyS0</def=
angedfont></div><div><defangedfont face=3D"monospace, monospace" size=3D"1"=
>uimageaddr=3D49000000</defangedfont></div><div><defangedfont face=3D"monos=
pace, monospace" size=3D"1">uimagefile=3DN2200/uImage</defangedfont></div><=
div><defangedfont face=3D"monospace, monospace" size=3D"1">ramdiskaddr=3D4B=
000000</defangedfont></div><div><defangedfont face=3D"monospace, monospace"=
 size=3D"1">ramdiskfile=3DN2200/uramdisk</defangedfont></div><div><br/></di=
v></div><div><span style=3D"font-variant-ligatures:normal;  font-variant-ca=
ps:normal;  letter-spacing:normal;  text-align:start;  text-indent:0px;  te=
xt-transform:none;  white-space:normal;  word-spacing:0px;  text-decoration=
-style:initial;  text-decoration-color:initial;  float:none;  display:inlin=
e; ;">I&#39;ve got to the stage where I can build the kernel and attempt to=
 start it with u-boot but the kernel crashes with a &#34;data abort&#34; er=
ror and a readout of the register values, but nothing more.</span></div><di=
v><span style=3D"font-variant-ligatures:normal;  font-variant-caps:normal; =
 letter-spacing:normal;  text-align:start;  text-indent:0px;  text-transfor=
m:none;  white-space:normal;  word-spacing:0px;  text-decoration-style:init=
ial;  text-decoration-color:initial;  float:none;  display:inline; ;"><br/>=
</span></div><div><span style=3D"">Here are the steps I&#39;ve taken so far=
.</span><br/></div><div><span style=3D""><br/></span></div><div><span style=
=
=3D"">Created a base .config file:</span></div><div><span style=3D""><br/>=
</span></div><div><defangedfont face=3D"monospace, monospace" size=3D"1">$=
=C2=A0ARCH_OXNAS=3Dy ARCH_MULTI_V5=3Dy ARCH=3Darm make versatile_defconfig=
</defangedfont></div><div><span style=3D""><br/></span></div><div><span sty=
le=3D"">My understanding of v1.1.2 of u-boot is that I need to append the D=
TB onto the end of the kernel so I updated the .config using make menuconfi=
g as follows (.config is attached):</span></div><div><span style=3D""><br/>=
</span></div><div><div><defangedfont face=3D"monospace, monospace" size=3D"=
1">$ ARCH_OXNAS=3Dy ARCH_MULTI_V5=3Dy ARCH=3Darm make menuconfig</defangedf=
ont></div><div><defangedfont face=3D"monospace, monospace" size=3D"1"><br/>=
</defangedfont></div><div><defangedfont face=3D"monospace, monospace" size=
=3D"1">=C2=A0 =C2=A0 -&gt; Enable &#34;System Type&#34; / &#34;Oxford Semi=
conductor OXNAS Family SoCs&#34; / &#34;Support OX810SE Based Products&#34;=
<br/></defangedfont></div><div><defangedfont face=3D"monospace, monospace" =
size=3D"1">=C2=A0 =C2=A0 -&gt;=C2=A0Enable &#34;Boot options&#34; / [*] Use=
 appended device tree blob to zImage (EXPERIMENTAL)</defangedfont></div><di=
v><defangedfont face=3D"monospace, monospace" size=3D"1">=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=
=A0[*]=C2=A0 =C2=A0Supplement the appended DTB with traditional ATAG infor=
mation</defangedfont></div><div><span style=3D""><br/></span></div><div><sp=
an style=3D"">I then created a new arch/arm/boot/dts/thecus-n2200.dts file:=
</span></div><div><span style=3D""><br/></span></div><div><div><defangedfon=
t face=3D"monospace, monospace" size=3D"1">/*</defangedfont></div><div><def=
angedfont face=3D"monospace, monospace" size=3D"1">=C2=A0* thecus-n2200.dts=
 - Device tree file for Thecus N2200</defangedfont></div><div><defangedfont=
 face=3D"monospace, monospace" size=3D"1">=C2=A0*</defangedfont></div><div>=
<defangedfont face=3D"monospace, monospace" size=3D"1">=C2=A0* Copyright (C=
) 2018 Raymond Elliot &lt;<a href=3D"mailto:raymundo.elliot@gmail.com">raym=
undo.elliot@gmail.com</a>&gt;</defangedfont></div><div><defangedfont face=
=3D"monospace, monospace" size=3D"1">=C2=A0*</defangedfont></div><div><def=
angedfont face=3D"monospace, monospace" size=3D"1">=C2=A0* Licensed under G=
PLv2 or later</defangedfont></div><div><defangedfont face=3D"monospace, mon=
ospace" size=3D"1">=C2=A0*/</defangedfont></div><div><defangedfont face=3D"=
monospace, monospace" size=3D"1"><br/></defangedfont></div><div><defangedfo=
nt face=3D"monospace, monospace" size=3D"1">/dts-v1/;</defangedfont></div><=
div><defangedfont face=3D"monospace, monospace" size=3D"1">#include &#34;ox=
810se.dtsi&#34;</defangedfont></div><div><defangedfont face=3D"monospace, m=
onospace" size=3D"1"><br/></defangedfont></div><div><defangedfont face=3D"m=
onospace, monospace" size=3D"1">/ {</defangedfont></div><div><defangedfont =
face=3D"monospace, monospace" size=3D"1"><span style=3D"white-space:pre; ;"=
>	</span>model =3D &#34;Thecus N2200&#34;;</defangedfont></div><div><defang=
edfont face=3D"monospace, monospace" size=3D"1"><br/></defangedfont></div><=
div><defangedfont face=3D"monospace, monospace" size=3D"1"><span style=3D"w=
hite-space:pre; ;">	</span>compatible =3D &#34;thecus,thecus-n2200&#34;, &#=
34;oxsemi,ox810se&#34;;</defangedfont></div><div><defangedfont face=3D"mono=
space, monospace" size=3D"1"><br/></defangedfont></div><div><defangedfont f=
ace=3D"monospace, monospace" size=3D"1"><span style=3D"white-space:pre; ;">=
	</span>chosen {</defangedfont></div><div><defangedfont face=3D"monospace, =
monospace" size=3D"1"><span style=3D"white-space:pre; ;">	=09</span>bootarg=
s =3D &#34;console=3DttyS1,115200n8&#34;;</defangedfont></div><div><defange=
dfont face=3D"monospace, monospace" size=3D"1"><span style=3D"white-space:p=
re; ;">	</span>};</defangedfont></div><div><defangedfont face=3D"monospace,=
 monospace" size=3D"1"><br/></defangedfont></div><div><defangedfont face=3D=
"monospace, monospace" size=3D"1"><span style=3D"white-space:pre; ;">	</spa=
n>memory {</defangedfont></div><div><defangedfont face=3D"monospace, monosp=
ace" size=3D"1"><span style=3D"white-space:pre; ;">	=09</span>/* Max 256MB =
@ 0x48000000 */</defangedfont></div><div><defangedfont face=3D"monospace, m=
onospace" size=3D"1"><span style=3D"white-space:pre; ;">	=09</span>reg =3D =
&lt;0x48000000 0x10000000&gt;;</defangedfont></div><div><defangedfont face=
=3D"monospace, monospace" size=3D"1"><span style=3D"white-space:pre; ;">	<=
/span>};</defangedfont></div><div><defangedfont face=3D"monospace, monospac=
e" size=3D"1"><br/></defangedfont></div><div><defangedfont face=3D"monospac=
e, monospace" size=3D"1"><span style=3D"white-space:pre; ;">	</span>aliases=
 {</defangedfont></div><div><defangedfont face=3D"monospace, monospace" siz=
e=3D"1"><span style=3D"white-space:pre; ;">	=09</span>serial1 =3D &amp;uart=
1;</defangedfont></div><div><defangedfont face=3D"monospace, monospace" siz=
e=3D"1"><span style=3D"white-space:pre; ;">	=09</span>gpio0 =3D &amp;gpio0;=
</defangedfont></div><div><defangedfont face=3D"monospace, monospace" size=
=3D"1"><span style=3D"white-space:pre; ;">	=09</span>gpio1 =3D &amp;gpio1;=
</defangedfont></div><div><defangedfont face=3D"monospace, monospace" size=
=3D"1"><span style=3D"white-space:pre; ;">	</span>};</defangedfont></div><=
div><defangedfont face=3D"monospace, monospace" size=3D"1"><br/></defangedf=
ont></div><div><defangedfont face=3D"monospace, monospace" size=3D"1"><span=
 style=3D"white-space:pre; ;">	</span>gpio-keys-polled {</defangedfont></di=
v><div><defangedfont face=3D"monospace, monospace" size=3D"1"><span style=
=3D"white-space:pre; ;">	=09</span>compatible =3D &#34;gpio-keys-polled&#3=
4;;</defangedfont></div><div><defangedfont face=3D"monospace, monospace" si=
ze=3D"1"><span style=3D"white-space:pre; ;">	=09</span>#address-cells =3D &=
lt;1&gt;;</defangedfont></div><div><defangedfont face=3D"monospace, monospa=
ce" size=3D"1"><span style=3D"white-space:pre; ;">	=09</span>#size-cells =
=3D &lt;0&gt;;</defangedfont></div><div><defangedfont face=3D"monospace, m=
onospace" size=3D"1"><span style=3D"white-space:pre; ;">	=09</span>poll-int=
erval =3D &lt;100&gt;;</defangedfont></div><div><defangedfont face=3D"monos=
pace, monospace" size=3D"1"><br/></defangedfont></div><div><defangedfont fa=
ce=3D"monospace, monospace" size=3D"1"><span style=3D"white-space:pre; ;">	=
=
=09</span>power {</defangedfont></div><div><defangedfont face=3D"monospace=
, monospace" size=3D"1"><span style=3D"white-space:pre; ;">	=09	</span>labe=
l =3D &#34;power&#34;;</defangedfont></div><div><defangedfont face=3D"monos=
pace, monospace" size=3D"1"><span style=3D"white-space:pre; ;">	=09	</span>=
gpios =3D &lt;&amp;gpio0 0 1&gt;;</defangedfont></div><div><defangedfont fa=
ce=3D"monospace, monospace" size=3D"1"><span style=3D"white-space:pre; ;">	=
=
=09	</span>linux,code =3D &lt;0x198&gt;;</defangedfont></div><div><defange=
dfont face=3D"monospace, monospace" size=3D"1"><span style=3D"white-space:p=
re; ;">	=09</span>};</defangedfont></div><div><defangedfont face=3D"monospa=
ce, monospace" size=3D"1"><br/></defangedfont></div><div><defangedfont face=
=
=3D"monospace, monospace" size=3D"1"><span style=3D"white-space:pre; ;">	=
=09</span>recovery {</defangedfont></div><div><defangedfont face=3D"monosp=
ace, monospace" size=3D"1"><span style=3D"white-space:pre; ;">	=09	</span>l=
abel =3D &#34;recovery&#34;;</defangedfont></div><div><defangedfont face=3D=
"monospace, monospace" size=3D"1"><span style=3D"white-space:pre; ;">	=09	<=
/span>gpios =3D &lt;&amp;gpio0 4 1&gt;;</defangedfont></div><div><defangedf=
ont face=3D"monospace, monospace" size=3D"1"><span style=3D"white-space:pre=
; ;">	=09	</span>linux,code =3D &lt;0xab&gt;;</defangedfont></div><div><def=
angedfont face=3D"monospace, monospace" size=3D"1"><span style=3D"white-spa=
ce:pre; ;">	=09</span>};</defangedfont></div><div><defangedfont face=3D"mon=
ospace, monospace" size=3D"1"><span style=3D"white-space:pre; ;">	</span>};=
</defangedfont></div><div><defangedfont face=3D"monospace, monospace" size=
=3D"1"><br/></defangedfont></div><div><defangedfont face=3D"monospace, mon=
ospace" size=3D"1"><span style=3D"white-space:pre; ;">	</span>leds {</defan=
gedfont></div><div><defangedfont face=3D"monospace, monospace" size=3D"1"><=
span style=3D"white-space:pre; ;">	=09</span>compatible =3D &#34;gpio-leds&=
#34;;</defangedfont></div><div><defangedfont face=3D"monospace, monospace" =
size=3D"1"><br/></defangedfont></div><div><defangedfont face=3D"monospace, =
monospace" size=3D"1"><span style=3D"white-space:pre; ;">	=09</span>a0 {</d=
efangedfont></div><div><defangedfont face=3D"monospace, monospace" size=3D"=
1"><span style=3D"white-space:pre; ;">	=09	</span>label =3D &#34;activity0&=
#34;;</defangedfont></div><div><defangedfont face=3D"monospace, monospace" =
size=3D"1"><span style=3D"white-space:pre; ;">	=09	</span>gpios =3D &lt;&am=
p;gpio0 25 0&gt;;</defangedfont></div><div><defangedfont face=3D"monospace,=
 monospace" size=3D"1"><span style=3D"white-space:pre; ;">	=09	</span>defau=
lt-state =3D &#34;keep&#34;;</defangedfont></div><div><defangedfont face=3D=
"monospace, monospace" size=3D"1"><span style=3D"white-space:pre; ;">	=09</=
span>};</defangedfont></div><div><defangedfont face=3D"monospace, monospace=
" size=3D"1"><br/></defangedfont></div><div><defangedfont face=3D"monospace=
, monospace" size=3D"1"><span style=3D"white-space:pre; ;">	=09</span>a1 {<=
/defangedfont></div><div><defangedfont face=3D"monospace, monospace" size=
=3D"1"><span style=3D"white-space:pre; ;">	=09	</span>label =3D &#34;activ=
ity1&#34;;</defangedfont></div><div><defangedfont face=3D"monospace, monosp=
ace" size=3D"1"><span style=3D"white-space:pre; ;">	=09	</span>gpios =3D &l=
t;&amp;gpio0 26 0&gt;;</defangedfont></div><div><defangedfont face=3D"monos=
pace, monospace" size=3D"1"><span style=3D"white-space:pre; ;">	=09	</span>=
default-state =3D &#34;keep&#34;;</defangedfont></div><div><defangedfont fa=
ce=3D"monospace, monospace" size=3D"1"><span style=3D"white-space:pre; ;">	=
=
=09</span>};</defangedfont></div><div><defangedfont face=3D"monospace, mon=
ospace" size=3D"1"><br/></defangedfont></div><div><defangedfont face=3D"mon=
ospace, monospace" size=3D"1"><span style=3D"white-space:pre; ;">	=09</span=
>a2 {</defangedfont></div><div><defangedfont face=3D"monospace, monospace" =
size=3D"1"><span style=3D"white-space:pre; ;">	=09	</span>label =3D &#34;ac=
tivity2&#34;;</defangedfont></div><div><defangedfont face=3D"monospace, mon=
ospace" size=3D"1"><span style=3D"white-space:pre; ;">	=09	</span>gpios =3D=
 &lt;&amp;gpio0 5 0&gt;;</defangedfont></div><div><defangedfont face=3D"mon=
ospace, monospace" size=3D"1"><span style=3D"white-space:pre; ;">	=09	</spa=
n>default-state =3D &#34;keep&#34;;</defangedfont></div><div><defangedfont =
face=3D"monospace, monospace" size=3D"1"><span style=3D"white-space:pre; ;"=
>	=09</span>};</defangedfont></div><div><defangedfont face=3D"monospace, mo=
nospace" size=3D"1"><br/></defangedfont></div><div><defangedfont face=3D"mo=
nospace, monospace" size=3D"1"><span style=3D"white-space:pre; ;">	=09</spa=
n>a3 {</defangedfont></div><div><defangedfont face=3D"monospace, monospace"=
 size=3D"1"><span style=3D"white-space:pre; ;">	=09	</span>label =3D &#34;a=
ctivity3&#34;;</defangedfont></div><div><defangedfont face=3D"monospace, mo=
nospace" size=3D"1"><span style=3D"white-space:pre; ;">	=09	</span>gpios =
=3D &lt;&amp;gpio0 6 0&gt;;</defangedfont></div><div><defangedfont face=3D=
"monospace, monospace" size=3D"1"><span style=3D"white-space:pre; ;">	=09	<=
/span>default-state =3D &#34;keep&#34;;</defangedfont></div><div><defangedf=
ont face=3D"monospace, monospace" size=3D"1"><span style=3D"white-space:pre=
; ;">	=09</span>};</defangedfont></div><div><defangedfont face=3D"monospace=
, monospace" size=3D"1"><br/></defangedfont></div><div><defangedfont face=
=3D"monospace, monospace" size=3D"1"><span style=3D"white-space:pre; ;">	=
=09</span>a4 {</defangedfont></div><div><defangedfont face=3D"monospace, m=
onospace" size=3D"1"><span style=3D"white-space:pre; ;">	=09	</span>label =
=3D &#34;activity4&#34;;</defangedfont></div><div><defangedfont face=3D"mo=
nospace, monospace" size=3D"1"><span style=3D"white-space:pre; ;">	=09	</sp=
an>gpios =3D &lt;&amp;gpio0 7 0&gt;;</defangedfont></div><div><defangedfont=
 face=3D"monospace, monospace" size=3D"1"><span style=3D"white-space:pre; ;=
">	=09	</span>default-state =3D &#34;keep&#34;;</defangedfont></div><div><d=
efangedfont face=3D"monospace, monospace" size=3D"1"><span style=3D"white-s=
pace:pre; ;">	=09</span>};</defangedfont></div><div><defangedfont face=3D"m=
onospace, monospace" size=3D"1"><br/></defangedfont></div><div><defangedfon=
t face=3D"monospace, monospace" size=3D"1"><span style=3D"white-space:pre; =
;">	=09</span>a5 {</defangedfont></div><div><defangedfont face=3D"monospace=
, monospace" size=3D"1"><span style=3D"white-space:pre; ;">	=09	</span>labe=
l =3D &#34;activity5&#34;;</defangedfont></div><div><defangedfont face=3D"m=
onospace, monospace" size=3D"1"><span style=3D"white-space:pre; ;">	=09	</s=
pan>gpios =3D &lt;&amp;gpio1 2 0&gt;;</defangedfont></div><div><defangedfon=
t face=3D"monospace, monospace" size=3D"1"><span style=3D"white-space:pre; =
;">	=09	</span>default-state =3D &#34;keep&#34;;</defangedfont></div><div><=
defangedfont face=3D"monospace, monospace" size=3D"1"><span style=3D"white-=
space:pre; ;">	=09</span>};</defangedfont></div><div><defangedfont face=3D"=
monospace, monospace" size=3D"1"><span style=3D"white-space:pre; ;">	</span=
>};</defangedfont></div><div><defangedfont face=3D"monospace, monospace" si=
ze=3D"1"><br/></defangedfont></div><div><defangedfont face=3D"monospace, mo=
nospace" size=3D"1"><span style=3D"white-space:pre; ;">	</span>i2c-gpio {</=
defangedfont></div><div><defangedfont face=3D"monospace, monospace" size=3D=
"1"><span style=3D"white-space:pre; ;">	=09</span>compatible =3D &#34;i2c-g=
pio&#34;;</defangedfont></div><div><defangedfont face=3D"monospace, monospa=
ce" size=3D"1"><span style=3D"white-space:pre; ;">	=09</span>gpios =3D &lt;=
&amp;gpio0 3 0 /* sda */</defangedfont></div><div><defangedfont face=3D"mon=
ospace, monospace" size=3D"1"><span style=3D"white-space:pre; ;">	=09	</spa=
n> &amp;gpio0 2 0 /* scl */</defangedfont></div><div><defangedfont face=3D"=
monospace, monospace" size=3D"1"><span style=3D"white-space:pre; ;">	=09	</=
span> &gt;;</defangedfont></div><div><defangedfont face=3D"monospace, monos=
pace" size=3D"1"><span style=3D"white-space:pre; ;">	=09</span>i2c-gpio,del=
ay-us =3D &lt;2&gt;;=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* ~100 kHz */</defangedfon=
t></div><div><defangedfont face=3D"monospace, monospace" size=3D"1"><span s=
tyle=3D"white-space:pre; ;">	=09</span>#address-cells =3D &lt;1&gt;;</defan=
gedfont></div><div><defangedfont face=3D"monospace, monospace" size=3D"1"><=
span style=3D"white-space:pre; ;">	=09</span>#size-cells =3D &lt;0&gt;;</de=
fangedfont></div><div><defangedfont face=3D"monospace, monospace" size=3D"1=
"><br/></defangedfont></div><div><defangedfont face=3D"monospace, monospace=
" size=3D"1"><span style=3D"white-space:pre; ;">	=09</span>rtc0: rtc@48 {</=
defangedfont></div><div><defangedfont face=3D"monospace, monospace" size=3D=
"1"><span style=3D"white-space:pre; ;">	=09	</span>compatible =3D &#34;st,m=
41t00&#34;;</defangedfont></div><div><defangedfont face=3D"monospace, monos=
pace" size=3D"1"><span style=3D"white-space:pre; ;">	=09	</span>reg =3D &lt=
;0x68&gt;;</defangedfont></div><div><defangedfont face=3D"monospace, monosp=
ace" size=3D"1"><span style=3D"white-space:pre; ;">	=09</span>};</defangedf=
ont></div><div><defangedfont face=3D"monospace, monospace" size=3D"1"><span=
 style=3D"white-space:pre; ;">	</span>};</defangedfont></div><div><defanged=
font face=3D"monospace, monospace" size=3D"1">};</defangedfont></div><div><=
defangedfont face=3D"monospace, monospace" size=3D"1"><br/></defangedfont><=
/div><div><defangedfont face=3D"monospace, monospace" size=3D"1">&amp;uart1=
 {</defangedfont></div><div><defangedfont face=3D"monospace, monospace" siz=
e=3D"1"><span style=3D"white-space:pre; ;">	</span>status =3D &#34;okay&#34=
;;</defangedfont></div><div><defangedfont face=3D"monospace, monospace" siz=
e=3D"1"><br/></defangedfont></div><div><defangedfont face=3D"monospace, mon=
ospace" size=3D"1"><span style=3D"white-space:pre; ;">	</span>pinctrl-names=
 =3D &#34;default&#34;;</defangedfont></div><div><defangedfont face=3D"mono=
space, monospace" size=3D"1"><span style=3D"white-space:pre; ;">	</span>pin=
ctrl-1 =3D &lt;&amp;pinctrl_uart1&gt;;</defangedfont></div><div><defangedfo=
nt face=3D"monospace, monospace" size=3D"1">};</defangedfont></div></div><d=
iv style=3D""><br/></div></div><div><span style=3D"font-variant-ligatures:n=
ormal;  font-variant-caps:normal;  letter-spacing:normal;  text-align:start=
;  text-indent:0px;  text-transform:none;  white-space:normal;  word-spacin=
g:0px;  text-decoration-style:initial;  text-decoration-color:initial;  flo=
at:none;  display:inline; ;">My first goal was to at least get some output =
from the serial console so at least I could see if and where things were go=
ing wrong.=C2=A0 However, I wasn&#39;t sure how to configure it, so I playe=
d around with different alias values for serial1 and uart1, but to no avail=
.=C2=A0 The original Thecus kernel (2.6.24) has the following defined which=
 is why I was trying to get serial1 to work:</span></div><div><span style=
=3D"font-variant-ligatures:normal;  font-variant-caps:normal;  letter-spac=
ing:normal;  text-align:start;  text-indent:0px;  text-transform:none;  whi=
te-space:normal;  word-spacing:0px;  text-decoration-style:initial;  text-d=
ecoration-color:initial;  float:none;  display:inline; ;"><br/></span></div=
><div><span style=3D"text-align:start;  text-indent:0px;  text-decoration-s=
tyle:initial;  text-decoration-color:initial;  float:none;  display:inline;=
 ;"><div><defangedfont face=3D"monospace, monospace" size=3D"1">CONFIG_SERI=
AL_8250=3Dy</defangedfont></div><div><defangedfont face=3D"monospace, monos=
pace" size=3D"1">CONFIG_SERIAL_8250_CONSOLE=3Dy</defangedfont></div><div><d=
efangedfont face=3D"monospace, monospace" size=3D"1">CONFIG_SERIAL_8250_PCI=
=
=3Dy</defangedfont></div><div><defangedfont face=3D"monospace, monospace" =
size=3D"1">CONFIG_SERIAL_8250_NR_UARTS=3D4</defangedfont></div><div><defang=
edfont face=3D"monospace, monospace" size=3D"1">CONFIG_SERIAL_8250_RUNTIME_=
UARTS=3D4</defangedfont></div><div><div><defangedfont face=3D"monospace, mo=
nospace" size=3D"1">CONFIG_SERIAL_CORE=3Dy</defangedfont></div><div><defang=
edfont face=3D"monospace, monospace" size=3D"1">CONFIG_SERIAL_CORE_CONSOLE=
=3Dy</defangedfont></div></div><div><defangedfont face=3D"monospace, monos=
pace" size=3D"1">CONFIG_ARCH_OXNAS_UART2=3Dy<br/></defangedfont></div><div>=
<defangedfont face=3D"monospace, monospace" size=3D"1">CONFIG_ARCH_OXNAS_CO=
NSOLE_UART=3D2</defangedfont><br/></div><div><br/></div></span></div><div><=
span style=3D"font-variant-ligatures:normal;  font-variant-caps:normal;  le=
tter-spacing:normal;  text-align:start;  text-indent:0px;  text-transform:n=
one;  white-space:normal;  word-spacing:0px;  text-decoration-style:initial=
;  text-decoration-color:initial;  float:none;  display:inline; ;">I then u=
pdated arch/arm/boot/dts/Makefile to include a thecus-n2200.dtb target.</sp=
an><br/></div><div><span style=3D"font-variant-ligatures:normal;  font-vari=
ant-caps:normal;  letter-spacing:normal;  text-align:start;  text-indent:0p=
x;  text-transform:none;  white-space:normal;  word-spacing:0px;  text-deco=
ration-style:initial;  text-decoration-color:initial;  float:none;  display=
:inline; ;"><br/></span></div><div><span style=3D"font-variant-ligatures:no=
rmal;  font-variant-caps:normal;  letter-spacing:normal;  text-align:start;=
  text-indent:0px;  text-transform:none;  white-space:normal;  word-spacing=
:0px;  text-decoration-style:initial;  text-decoration-color:initial;  floa=
t:none;  display:inline; ;">The kernel was built using:</span></div><div><s=
pan style=3D"font-variant-ligatures:normal;  font-variant-caps:normal;  let=
ter-spacing:normal;  text-align:start;  text-indent:0px;  text-transform:no=
ne;  white-space:normal;  word-spacing:0px;  text-decoration-style:initial;=
  text-decoration-color:initial;  float:none;  display:inline; ;"><br/></sp=
an></div><div><defangedfont face=3D"monospace, monospace" size=3D"1"><span =
style=3D"font-variant-ligatures:normal;  font-variant-caps:normal;  letter-=
spacing:normal;  text-align:start;  text-indent:0px;  text-transform:none; =
 white-space:normal;  word-spacing:0px;  text-decoration-style:initial;  te=
xt-decoration-color:initial;  float:none;  display:inline; ;">$=C2=A0</span=
>LOADADDR=3D0x49000000 ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- make -=
j8 uImage dtbs</defangedfont></div><div><br/></div><div><span style=3D"font=
-variant-ligatures:normal;  font-variant-caps:normal;  letter-spacing:norma=
l;  text-align:start;  text-indent:0px;  text-transform:none;  white-space:=
normal;  word-spacing:0px;  text-decoration-style:initial;  text-decoration=
-color:initial;  float:none;  display:inline; ;">I only have bootm availabl=
e in u-boot so the compressed images (uImage and zImage) didn&#39;t work an=
d resulted in invalid instruction crashes, so t</span>he device tree was ap=
pended thus:</div><div><br/></div><div><defangedfont face=3D"monospace, mon=
ospace" size=3D"1">$ cat arch/arm/boot/Image arch/arm/boot/dts/thecus-n2200=
.dtb &gt; arch/arm/boot/dts/Image+dtb</defangedfont></div><div><br/></div><=
div>I then created the final image by doing the following:</div><div><br/><=
/div><div>$ mkimage -A arm -O linux -T kernel -C none -a 0x49000000 -e 0x49=
000000=C2=A0-n &#34;My Kernel&#34; -d &#34;arch/arm/boot/dts/Image+dtb&#34;=
 arch/arm/boot/uImage.n2200<br/></div><div><br/></div><div>uImage.n2200 was=
 copied to my TFTP server and renamed=C2=A0<span style=3D"font-variant-liga=
tures:normal;  font-variant-caps:normal;  letter-spacing:normal;  text-alig=
n:start;  text-indent:0px;  text-transform:none;  white-space:normal;  word=
-spacing:0px;  text-decoration-style:initial;  text-decoration-color:initia=
l;  float:none;  display:inline; ;">N2200/uImage=C2=A0<span style=3D"font-v=
ariant-ligatures:normal;  font-variant-caps:normal;  letter-spacing:normal;=
  text-align:start;  text-indent:0px;  text-transform:none;  white-space:no=
rmal;  word-spacing:0px;  text-decoration-style:initial;  text-decoration-c=
olor:initial;  float:none;  display:inline; ;">as per the u-boot tftp comma=
nd.</span></span></div><div><br/></div><div>I then started the NAS and from=
 u-boot did (the uramdisk image is the original initramfs file from the mac=
hine):</div><div><br/></div><div><defangedfont face=3D"monospace, monospace=
" size=3D"1">N2200$ run ramboot</defangedfont></div><div><div><defangedfont=
 face=3D"monospace, monospace" size=3D"1">Wait GMAC to reset</defangedfont>=
</div><div><defangedfont face=3D"monospace, monospace" size=3D"1">Wait for =
PHY reset</defangedfont></div><div><defangedfont face=3D"monospace, monospa=
ce" size=3D"1">Wait for link to come up.............Link up</defangedfont><=
/div><div><defangedfont face=3D"monospace, monospace" size=3D"1">Wait for a=
uto-negotiation to complete</defangedfont></div><div><defangedfont face=3D"=
monospace, monospace" size=3D"1">Link is 1000M</defangedfont></div><div><de=
fangedfont face=3D"monospace, monospace" size=3D"1">TFTP from server 192.16=
8.0.50; our IP address is 192.168.0.52</defangedfont></div><div><defangedfo=
nt face=3D"monospace, monospace" size=3D"1">Filename &#39;N2200/uramdisk&#3=
9;.</defangedfont></div><div><defangedfont face=3D"monospace, monospace" si=
ze=3D"1">Load address: 0x4b000000</defangedfont></div><div><defangedfont fa=
ce=3D"monospace, monospace" size=3D"1">Loading: ###########################=
######################################</defangedfont></div><div><defangedfo=
nt face=3D"monospace, monospace" size=3D"1">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=
=A0#################################################################</defa=
ngedfont></div><div><defangedfont face=3D"monospace, monospace" size=3D"1">=
=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0########################################=
#########################</defangedfont></div><div><defangedfont face=3D"mo=
nospace, monospace" size=3D"1">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0##########=
####################################################</defangedfont></div><d=
iv><defangedfont face=3D"monospace, monospace" size=3D"1">done</defangedfon=
t></div><div><defangedfont face=3D"monospace, monospace" size=3D"1">Bytes t=
ransferred =3D 1310720 (140000 hex)</defangedfont></div><div><defangedfont =
face=3D"monospace, monospace" size=3D"1">Wait GMAC to reset</defangedfont><=
/div><div><defangedfont face=3D"monospace, monospace" size=3D"1">Wait for P=
HY reset</defangedfont></div><div><defangedfont face=3D"monospace, monospac=
e" size=3D"1">Wait for link to come up................Link up</defangedfont=
></div><div><defangedfont face=3D"monospace, monospace" size=3D"1">Wait for=
 auto-negotiation to complete</defangedfont></div><div><defangedfont face=
=3D"monospace, monospace" size=3D"1">Link is 1000M</defangedfont></div><di=
v><defangedfont face=3D"monospace, monospace" size=3D"1">TFTP from server 1=
92.168.0.50; our IP address is 192.168.0.52</defangedfont></div><div><defan=
gedfont face=3D"monospace, monospace" size=3D"1">Filename &#39;N2200/uImage=
&#39;.</defangedfont></div><div><defangedfont face=3D"monospace, monospace"=
 size=3D"1">Load address: 0x49000000</defangedfont></div><div><defangedfont=
 face=3D"monospace, monospace" size=3D"1">Loading: ########################=
#########################################</defangedfont></div><div><defange=
dfont face=3D"monospace, monospace" size=3D"1">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=
=C2=A0#################################################################</d=
efangedfont></div><div><defangedfont face=3D"monospace, monospace" size=3D"=
1">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0######################################=
###########################</defangedfont></div><div><defangedfont face=3D"=
monospace, monospace" size=3D"1">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0########=
#########################################################</defangedfont></d=
iv><div><defangedfont face=3D"monospace, monospace" size=3D"1">=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0##################################################=
###############</defangedfont></div><div><defangedfont face=3D"monospace, m=
onospace" size=3D"1">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0####################=
#############################################</defangedfont></div><div><def=
angedfont face=3D"monospace, monospace" size=3D"1">=C2=A0 =C2=A0 =C2=A0 =C2=
=
=A0 =C2=A0################################################################=
#</defangedfont></div><div><defangedfont face=3D"monospace, monospace" size=
=
=3D"1">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#################################=
################################</defangedfont></div><div><defangedfont fac=
e=3D"monospace, monospace" size=3D"1">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0###=
##############################################################</defangedfon=
t></div><div><defangedfont face=3D"monospace, monospace" size=3D"1">=C2=A0 =
=
=C2=A0 =C2=A0 =C2=A0 =C2=A0###############################################=
##################</defangedfont></div><div><defangedfont face=3D"monospace=
, monospace" size=3D"1">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#################=
################################################</defangedfont></div><div><=
defangedfont face=3D"monospace, monospace" size=3D"1">=C2=A0 =C2=A0 =C2=A0 =
=
=C2=A0 =C2=A0#############################################################=
####</defangedfont></div><div><defangedfont face=3D"monospace, monospace" s=
ize=3D"1">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0###############################=
##################################</defangedfont></div><div><defangedfont f=
ace=3D"monospace, monospace" size=3D"1">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#=
############################################</defangedfont></div><div><defa=
ngedfont face=3D"monospace, monospace" size=3D"1">done</defangedfont></div>=
<div><defangedfont face=3D"monospace, monospace" size=3D"1">Bytes transferr=
ed =3D 4556591 (45872f hex)</defangedfont></div><div><defangedfont face=3D"=
monospace, monospace" size=3D"1">## Booting image at 49000000 ...</defanged=
font></div><div><defangedfont face=3D"monospace, monospace" size=3D"1">=C2=
=A0 =C2=A0Image Name:=C2=A0 =C2=A0My Kernel</defangedfont></div><div><defa=
ngedfont face=3D"monospace, monospace" size=3D"1">=C2=A0 =C2=A0Image Type:=
=C2=A0 =C2=A0ARM Linux Kernel Image (uncompressed)</defangedfont></div><di=
v><defangedfont face=3D"monospace, monospace" size=3D"1">=C2=A0 =C2=A0Data =
Size:=C2=A0 =C2=A0 4556527 Bytes =3D=C2=A0 4.3 MB</defangedfont></div><div>=
<defangedfont face=3D"monospace, monospace" size=3D"1">=C2=A0 =C2=A0Load Ad=
dress: 49000000</defangedfont></div><div><defangedfont face=3D"monospace, m=
onospace" size=3D"1">=C2=A0 =C2=A0Entry Point:=C2=A0 49000000</defangedfont=
></div><div><defangedfont face=3D"monospace, monospace" size=3D"1">=C2=A0 =
=C2=A0Verifying Checksum ... OK</defangedfont></div><div><defangedfont fac=
e=3D"monospace, monospace" size=3D"1">=C2=A0 =C2=A0XIP Kernel Image ... OK<=
/defangedfont></div><div><defangedfont face=3D"monospace, monospace" size=
=3D"1">## Loading Ramdisk Image at 4b000000 ...</defangedfont></div><div><=
defangedfont face=3D"monospace, monospace" size=3D"1">=C2=A0 =C2=A0Image Na=
me:=C2=A0 =C2=A0uboot initramfs</defangedfont></div><div><defangedfont face=
=
=3D"monospace, monospace" size=3D"1">=C2=A0 =C2=A0Image Type:=C2=A0 =C2=A0=
ARM Linux RAMDisk Image (gzip compressed)</defangedfont></div><div><defange=
dfont face=3D"monospace, monospace" size=3D"1">=C2=A0 =C2=A0Data Size:=C2=
=A0 =C2=A0 1228235 Bytes =3D=C2=A0 1.2 MB</defangedfont></div><div><defang=
edfont face=3D"monospace, monospace" size=3D"1">=C2=A0 =C2=A0Load Address: =
00000000</defangedfont></div><div><defangedfont face=3D"monospace, monospac=
e" size=3D"1">=C2=A0 =C2=A0Entry Point:=C2=A0 00000000</defangedfont></div>=
<div><defangedfont face=3D"monospace, monospace" size=3D"1">=C2=A0 =C2=A0Ve=
rifying Checksum ... OK</defangedfont></div><div><defangedfont face=3D"mono=
space, monospace" size=3D"1"><br/></defangedfont></div><div><defangedfont f=
ace=3D"monospace, monospace" size=3D"1">Starting kernel ...</defangedfont><=
/div></div><div><defangedfont face=3D"monospace, monospace" size=3D"1"><spa=
n style=3D"font-variant-ligatures:normal;  font-variant-caps:normal;  lette=
r-spacing:normal;  text-align:start;  text-indent:0px;  text-transform:none=
;  white-space:normal;  word-spacing:0px;  text-decoration-style:initial;  =
text-decoration-color:initial;  float:none;  display:inline; ;"><span>=C2=
=A0</span>data abort</span><br style=3D"font-variant-ligatures:normal;  fo=
nt-variant-caps:normal;  letter-spacing:normal;  text-align:start;  text-in=
dent:0px;  text-transform:none;  white-space:normal;  word-spacing:0px;  te=
xt-decoration-style:initial;  text-decoration-color:initial; ;"/><span styl=
e=3D"font-variant-ligatures:normal;  font-variant-caps:normal;  letter-spac=
ing:normal;  text-align:start;  text-indent:0px;  text-transform:none;  whi=
te-space:normal;  word-spacing:0px;  text-decoration-style:initial;  text-d=
ecoration-color:initial;  float:none;  display:inline; ;">pc : [&lt;491c054=
4&gt;]=C2=A0 =C2=A0 lr : [&lt;4900000c&gt;]</span><br style=3D"font-variant=
-ligatures:normal;  font-variant-caps:normal;  letter-spacing:normal;  text=
-align:start;  text-indent:0px;  text-transform:none;  white-space:normal; =
 word-spacing:0px;  text-decoration-style:initial;  text-decoration-color:i=
nitial; ;"/><span style=3D"font-variant-ligatures:normal;  font-variant-cap=
s:normal;  letter-spacing:normal;  text-align:start;  text-indent:0px;  tex=
t-transform:none;  white-space:normal;  word-spacing:0px;  text-decoration-=
style:initial;  text-decoration-color:initial;  float:none;  display:inline=
; ;">sp : 48cdd7b4=C2=A0 ip : 00000003=C2=A0 fp : 48d1664c</span><br style=
=3D"font-variant-ligatures:normal;  font-variant-caps:normal;  letter-spac=
ing:normal;  text-align:start;  text-indent:0px;  text-transform:none;  whi=
te-space:normal;  word-spacing:0px;  text-decoration-style:initial;  text-d=
ecoration-color:initial; ;"/><span style=3D"font-variant-ligatures:normal; =
 font-variant-caps:normal;  letter-spacing:normal;  text-align:start;  text=
-indent:0px;  text-transform:none;  white-space:normal;  word-spacing:0px; =
 text-decoration-style:initial;  text-decoration-color:initial;  float:none=
;  display:inline; ;">r10: 00000003=C2=A0 r9 : ffed3b51=C2=A0 r8 : 48cddfdc=
</span><br style=3D"font-variant-ligatures:normal;  font-variant-caps:norma=
l;  letter-spacing:normal;  text-align:start;  text-indent:0px;  text-trans=
form:none;  white-space:normal;  word-spacing:0px;  text-decoration-style:i=
nitial;  text-decoration-color:initial; ;"/><span style=3D"font-variant-lig=
atures:normal;  font-variant-caps:normal;  letter-spacing:normal;  text-ali=
gn:start;  text-indent:0px;  text-transform:none;  white-space:normal;  wor=
d-spacing:0px;  text-decoration-style:initial;  text-decoration-color:initi=
al;  float:none;  display:inline; ;">r7 : 00000003=C2=A0 r6 : 00000480=C2=
=A0 r5 : 00000000=C2=A0 r4 : ffffb400</span><br style=3D"font-variant-liga=
tures:normal;  font-variant-caps:normal;  letter-spacing:normal;  text-alig=
n:start;  text-indent:0px;  text-transform:none;  white-space:normal;  word=
-spacing:0px;  text-decoration-style:initial;  text-decoration-color:initia=
l; ;"/><span style=3D"font-variant-ligatures:normal;  font-variant-caps:nor=
mal;  letter-spacing:normal;  text-align:start;  text-indent:0px;  text-tra=
nsform:none;  white-space:normal;  word-spacing:0px;  text-decoration-style=
:initial;  text-decoration-color:initial;  float:none;  display:inline; ;">=
r3 : 00000010=C2=A0 r2 : 48cdd7b4=C2=A0 r1 : ffffda00=C2=A0 r0 : 000000e1</=
span><br style=3D"font-variant-ligatures:normal;  font-variant-caps:normal;=
  letter-spacing:normal;  text-align:start;  text-indent:0px;  text-transfo=
rm:none;  white-space:normal;  word-spacing:0px;  text-decoration-style:ini=
tial;  text-decoration-color:initial; ;"/><span style=3D"font-variant-ligat=
ures:normal;  font-variant-caps:normal;  letter-spacing:normal;  text-align=
:start;  text-indent:0px;  text-transform:none;  white-space:normal;  word-=
spacing:0px;  text-decoration-style:initial;  text-decoration-color:initial=
;  float:none;  display:inline; ;">Flags: nzcv=C2=A0 IRQs off=C2=A0 FIQs of=
f=C2=A0 Mode SVC_32</span><br/></defangedfont></div><div><br/></div><div>So=
 that&#39;s where I&#39;m at now and basically kinda stuck.=C2=A0 Any help =
or suggestions you have would be very gratefully received !</div><div><br/>=
</div><div>Kind regards,</div><div>Raymond</div></div>

--0000000000002b0ede056cba51ce--

--0000000000002b0ee2056cba51d0
Content-Type: application/octet-stream; name=".config"
Content-Disposition: attachment; filename=".config"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jhghl5ip0

IwojIEF1dG9tYXRpY2FsbHkgZ2VuZXJhdGVkIGZpbGU7IERPIE5PVCBFRElULgojIExpbnV4L2Fy
bSA0LjkuOTMgS2VybmVsIENvbmZpZ3VyYXRpb24KIwpDT05GSUdfQVJNPXkKQ09ORklHX0FSTV9I
QVNfU0dfQ0hBSU49eQpDT05GSUdfTUlHSFRfSEFWRV9QQ0k9eQpDT05GSUdfU1lTX1NVUFBPUlRT
X0FQTV9FTVVMQVRJT049eQpDT05GSUdfSEFWRV9QUk9DX0NQVT15CkNPTkZJR19TVEFDS1RSQUNF
X1NVUFBPUlQ9eQpDT05GSUdfTE9DS0RFUF9TVVBQT1JUPXkKQ09ORklHX1RSQUNFX0lSUUZMQUdT
X1NVUFBPUlQ9eQpDT05GSUdfUldTRU1fWENIR0FERF9BTEdPUklUSE09eQpDT05GSUdfRklYX0VB
UkxZQ09OX01FTT15CkNPTkZJR19HRU5FUklDX0hXRUlHSFQ9eQpDT05GSUdfR0VORVJJQ19DQUxJ
QlJBVEVfREVMQVk9eQpDT05GSUdfTkVFRF9ETUFfTUFQX1NUQVRFPXkKQ09ORklHX0FSQ0hfU1VQ
UE9SVFNfVVBST0JFUz15CkNPTkZJR19WRUNUT1JTX0JBU0U9MHhmZmZmMDAwMApDT05GSUdfQVJN
X1BBVENIX1BIWVNfVklSVD15CkNPTkZJR19HRU5FUklDX0JVRz15CkNPTkZJR19QR1RBQkxFX0xF
VkVMUz0yCkNPTkZJR19ERUZDT05GSUdfTElTVD0iL2xpYi9tb2R1bGVzLyRVTkFNRV9SRUxFQVNF
Ly5jb25maWciCkNPTkZJR19JUlFfV09SSz15CkNPTkZJR19CVUlMRFRJTUVfRVhUQUJMRV9TT1JU
PXkKCiMKIyBHZW5lcmFsIHNldHVwCiMKQ09ORklHX0JST0tFTl9PTl9TTVA9eQpDT05GSUdfSU5J
VF9FTlZfQVJHX0xJTUlUPTMyCkNPTkZJR19DUk9TU19DT01QSUxFPSJhcm0tbGludXgtZ251ZWFi
aS0iCiMgQ09ORklHX0NPTVBJTEVfVEVTVCBpcyBub3Qgc2V0CkNPTkZJR19MT0NBTFZFUlNJT049
IiIKIyBDT05GSUdfTE9DQUxWRVJTSU9OX0FVVE8gaXMgbm90IHNldApDT05GSUdfSEFWRV9LRVJO
RUxfR1pJUD15CkNPTkZJR19IQVZFX0tFUk5FTF9MWk1BPXkKQ09ORklHX0hBVkVfS0VSTkVMX1ha
PXkKQ09ORklHX0hBVkVfS0VSTkVMX0xaTz15CkNPTkZJR19IQVZFX0tFUk5FTF9MWjQ9eQpDT05G
SUdfS0VSTkVMX0daSVA9eQojIENPTkZJR19LRVJORUxfTFpNQSBpcyBub3Qgc2V0CiMgQ09ORklH
X0tFUk5FTF9YWiBpcyBub3Qgc2V0CiMgQ09ORklHX0tFUk5FTF9MWk8gaXMgbm90IHNldAojIENP
TkZJR19LRVJORUxfTFo0IGlzIG5vdCBzZXQKQ09ORklHX0RFRkFVTFRfSE9TVE5BTUU9Iihub25l
KSIKQ09ORklHX1NXQVA9eQpDT05GSUdfU1lTVklQQz15CkNPTkZJR19TWVNWSVBDX1NZU0NUTD15
CiMgQ09ORklHX1BPU0lYX01RVUVVRSBpcyBub3Qgc2V0CkNPTkZJR19DUk9TU19NRU1PUllfQVRU
QUNIPXkKQ09ORklHX0ZIQU5ETEU9eQojIENPTkZJR19VU0VMSUIgaXMgbm90IHNldAojIENPTkZJ
R19BVURJVCBpcyBub3Qgc2V0CgojCiMgSVJRIHN1YnN5c3RlbQojCkNPTkZJR19HRU5FUklDX0lS
UV9QUk9CRT15CkNPTkZJR19HRU5FUklDX0lSUV9TSE9XPXkKQ09ORklHX0dFTkVSSUNfSVJRX1NI
T1dfTEVWRUw9eQpDT05GSUdfSEFSRElSUVNfU1dfUkVTRU5EPXkKQ09ORklHX0lSUV9ET01BSU49
eQpDT05GSUdfSEFORExFX0RPTUFJTl9JUlE9eQpDT05GSUdfSVJRX0ZPUkNFRF9USFJFQURJTkc9
eQpDT05GSUdfU1BBUlNFX0lSUT15CkNPTkZJR19BUkNIX0NMT0NLU09VUkNFX0RBVEE9eQpDT05G
SUdfR0VORVJJQ19DTE9DS0VWRU5UUz15CgojCiMgVGltZXJzIHN1YnN5c3RlbQojCkNPTkZJR19U
SUNLX09ORVNIT1Q9eQpDT05GSUdfTk9fSFpfQ09NTU9OPXkKIyBDT05GSUdfSFpfUEVSSU9ESUMg
aXMgbm90IHNldApDT05GSUdfTk9fSFpfSURMRT15CiMgQ09ORklHX05PX0haIGlzIG5vdCBzZXQK
Q09ORklHX0hJR0hfUkVTX1RJTUVSUz15CgojCiMgQ1BVL1Rhc2sgdGltZSBhbmQgc3RhdHMgYWNj
b3VudGluZwojCkNPTkZJR19USUNLX0NQVV9BQ0NPVU5USU5HPXkKIyBDT05GSUdfVklSVF9DUFVf
QUNDT1VOVElOR19HRU4gaXMgbm90IHNldAojIENPTkZJR19JUlFfVElNRV9BQ0NPVU5USU5HIGlz
IG5vdCBzZXQKIyBDT05GSUdfQlNEX1BST0NFU1NfQUNDVCBpcyBub3Qgc2V0CiMgQ09ORklHX1RB
U0tTVEFUUyBpcyBub3Qgc2V0CgojCiMgUkNVIFN1YnN5c3RlbQojCkNPTkZJR19USU5ZX1JDVT15
CiMgQ09ORklHX1JDVV9FWFBFUlQgaXMgbm90IHNldApDT05GSUdfU1JDVT15CiMgQ09ORklHX1RB
U0tTX1JDVSBpcyBub3Qgc2V0CiMgQ09ORklHX1JDVV9TVEFMTF9DT01NT04gaXMgbm90IHNldAoj
IENPTkZJR19UUkVFX1JDVV9UUkFDRSBpcyBub3Qgc2V0CiMgQ09ORklHX1JDVV9FWFBFRElURV9C
T09UIGlzIG5vdCBzZXQKIyBDT05GSUdfQlVJTERfQklOMkMgaXMgbm90IHNldAojIENPTkZJR19J
S0NPTkZJRyBpcyBub3Qgc2V0CkNPTkZJR19MT0dfQlVGX1NISUZUPTE0CkNPTkZJR19OTUlfTE9H
X0JVRl9TSElGVD0xMwpDT05GSUdfR0VORVJJQ19TQ0hFRF9DTE9DSz15CiMgQ09ORklHX0NHUk9V
UFMgaXMgbm90IHNldAojIENPTkZJR19DSEVDS1BPSU5UX1JFU1RPUkUgaXMgbm90IHNldApDT05G
SUdfTkFNRVNQQUNFUz15CkNPTkZJR19VVFNfTlM9eQpDT05GSUdfSVBDX05TPXkKIyBDT05GSUdf
VVNFUl9OUyBpcyBub3Qgc2V0CkNPTkZJR19QSURfTlM9eQpDT05GSUdfTkVUX05TPXkKIyBDT05G
SUdfU0NIRURfQVVUT0dST1VQIGlzIG5vdCBzZXQKIyBDT05GSUdfU1lTRlNfREVQUkVDQVRFRCBp
cyBub3Qgc2V0CiMgQ09ORklHX1JFTEFZIGlzIG5vdCBzZXQKQ09ORklHX0JMS19ERVZfSU5JVFJE
PXkKQ09ORklHX0lOSVRSQU1GU19TT1VSQ0U9IiIKQ09ORklHX1JEX0daSVA9eQpDT05GSUdfUkRf
QlpJUDI9eQpDT05GSUdfUkRfTFpNQT15CkNPTkZJR19SRF9YWj15CkNPTkZJR19SRF9MWk89eQpD
T05GSUdfUkRfTFo0PXkKQ09ORklHX0NDX09QVElNSVpFX0ZPUl9QRVJGT1JNQU5DRT15CiMgQ09O
RklHX0NDX09QVElNSVpFX0ZPUl9TSVpFIGlzIG5vdCBzZXQKQ09ORklHX1NZU0NUTD15CkNPTkZJ
R19BTk9OX0lOT0RFUz15CkNPTkZJR19IQVZFX1VJRDE2PXkKQ09ORklHX0JQRj15CiMgQ09ORklH
X0VYUEVSVCBpcyBub3Qgc2V0CkNPTkZJR19VSUQxNj15CkNPTkZJR19NVUxUSVVTRVI9eQojIENP
TkZJR19TR0VUTUFTS19TWVNDQUxMIGlzIG5vdCBzZXQKQ09ORklHX1NZU0ZTX1NZU0NBTEw9eQoj
IENPTkZJR19TWVNDVExfU1lTQ0FMTCBpcyBub3Qgc2V0CkNPTkZJR19LQUxMU1lNUz15CiMgQ09O
RklHX0tBTExTWU1TX0FMTCBpcyBub3Qgc2V0CiMgQ09ORklHX0tBTExTWU1TX0FCU09MVVRFX1BF
UkNQVSBpcyBub3Qgc2V0CkNPTkZJR19LQUxMU1lNU19CQVNFX1JFTEFUSVZFPXkKQ09ORklHX1BS
SU5USz15CkNPTkZJR19QUklOVEtfTk1JPXkKQ09ORklHX0JVRz15CkNPTkZJR19FTEZfQ09SRT15
CkNPTkZJR19CQVNFX0ZVTEw9eQpDT05GSUdfRlVURVg9eQpDT05GSUdfRVBPTEw9eQpDT05GSUdf
U0lHTkFMRkQ9eQpDT05GSUdfVElNRVJGRD15CkNPTkZJR19FVkVOVEZEPXkKIyBDT05GSUdfQlBG
X1NZU0NBTEwgaXMgbm90IHNldApDT05GSUdfU0hNRU09eQpDT05GSUdfQUlPPXkKQ09ORklHX0FE
VklTRV9TWVNDQUxMUz15CiMgQ09ORklHX1VTRVJGQVVMVEZEIGlzIG5vdCBzZXQKQ09ORklHX01F
TUJBUlJJRVI9eQojIENPTkZJR19FTUJFRERFRCBpcyBub3Qgc2V0CkNPTkZJR19IQVZFX1BFUkZf
RVZFTlRTPXkKQ09ORklHX1BFUkZfVVNFX1ZNQUxMT0M9eQoKIwojIEtlcm5lbCBQZXJmb3JtYW5j
ZSBFdmVudHMgQW5kIENvdW50ZXJzCiMKIyBDT05GSUdfUEVSRl9FVkVOVFMgaXMgbm90IHNldApD
T05GSUdfVk1fRVZFTlRfQ09VTlRFUlM9eQpDT05GSUdfQ09NUEFUX0JSSz15CkNPTkZJR19TTEFC
PXkKIyBDT05GSUdfU0xVQiBpcyBub3Qgc2V0CiMgQ09ORklHX1NMQUJfRlJFRUxJU1RfUkFORE9N
IGlzIG5vdCBzZXQKIyBDT05GSUdfU1lTVEVNX0RBVEFfVkVSSUZJQ0FUSU9OIGlzIG5vdCBzZXQK
IyBDT05GSUdfUFJPRklMSU5HIGlzIG5vdCBzZXQKQ09ORklHX0hBVkVfT1BST0ZJTEU9eQojIENP
TkZJR19LUFJPQkVTIGlzIG5vdCBzZXQKIyBDT05GSUdfSlVNUF9MQUJFTCBpcyBub3Qgc2V0CiMg
Q09ORklHX1VQUk9CRVMgaXMgbm90IHNldAojIENPTkZJR19IQVZFXzY0QklUX0FMSUdORURfQUND
RVNTIGlzIG5vdCBzZXQKQ09ORklHX0FSQ0hfVVNFX0JVSUxUSU5fQlNXQVA9eQpDT05GSUdfSEFW
RV9LUFJPQkVTPXkKQ09ORklHX0hBVkVfS1JFVFBST0JFUz15CkNPTkZJR19IQVZFX09QVFBST0JF
Uz15CkNPTkZJR19IQVZFX05NST15CkNPTkZJR19IQVZFX0FSQ0hfVFJBQ0VIT09LPXkKQ09ORklH
X0hBVkVfRE1BX0NPTlRJR1VPVVM9eQpDT05GSUdfR0VORVJJQ19TTVBfSURMRV9USFJFQUQ9eQpD
T05GSUdfR0VORVJJQ19JRExFX1BPTExfU0VUVVA9eQpDT05GSUdfSEFWRV9SRUdTX0FORF9TVEFD
S19BQ0NFU1NfQVBJPXkKQ09ORklHX0hBVkVfQ0xLPXkKQ09ORklHX0hBVkVfRE1BX0FQSV9ERUJV
Rz15CkNPTkZJR19IQVZFX1BFUkZfUkVHUz15CkNPTkZJR19IQVZFX1BFUkZfVVNFUl9TVEFDS19E
VU1QPXkKQ09ORklHX0hBVkVfQVJDSF9KVU1QX0xBQkVMPXkKQ09ORklHX0FSQ0hfV0FOVF9JUENf
UEFSU0VfVkVSU0lPTj15CkNPTkZJR19IQVZFX0dDQ19QTFVHSU5TPXkKIyBDT05GSUdfR0NDX1BM
VUdJTlMgaXMgbm90IHNldApDT05GSUdfSEFWRV9DQ19TVEFDS1BST1RFQ1RPUj15CiMgQ09ORklH
X0NDX1NUQUNLUFJPVEVDVE9SIGlzIG5vdCBzZXQKQ09ORklHX0NDX1NUQUNLUFJPVEVDVE9SX05P
TkU9eQojIENPTkZJR19DQ19TVEFDS1BST1RFQ1RPUl9SRUdVTEFSIGlzIG5vdCBzZXQKIyBDT05G
SUdfQ0NfU1RBQ0tQUk9URUNUT1JfU1RST05HIGlzIG5vdCBzZXQKQ09ORklHX0hBVkVfQ09OVEVY
VF9UUkFDS0lORz15CkNPTkZJR19IQVZFX1ZJUlRfQ1BVX0FDQ09VTlRJTkdfR0VOPXkKQ09ORklH
X0hBVkVfSVJRX1RJTUVfQUNDT1VOVElORz15CkNPTkZJR19IQVZFX01PRF9BUkNIX1NQRUNJRklD
PXkKQ09ORklHX01PRFVMRVNfVVNFX0VMRl9SRUw9eQpDT05GSUdfQVJDSF9IQVNfRUxGX1JBTkRP
TUlaRT15CkNPTkZJR19IQVZFX0FSQ0hfTU1BUF9STkRfQklUUz15CkNPTkZJR19IQVZFX0VYSVRf
VEhSRUFEPXkKQ09ORklHX0FSQ0hfTU1BUF9STkRfQklUU19NSU49OApDT05GSUdfQVJDSF9NTUFQ
X1JORF9CSVRTX01BWD0xNgpDT05GSUdfQVJDSF9NTUFQX1JORF9CSVRTPTgKIyBDT05GSUdfSEFW
RV9BUkNIX0hBU0ggaXMgbm90IHNldAojIENPTkZJR19JU0FfQlVTX0FQSSBpcyBub3Qgc2V0CkNP
TkZJR19DTE9ORV9CQUNLV0FSRFM9eQpDT05GSUdfT0xEX1NJR1NVU1BFTkQzPXkKQ09ORklHX09M
RF9TSUdBQ1RJT049eQojIENPTkZJR19DUFVfTk9fRUZGSUNJRU5UX0ZGUyBpcyBub3Qgc2V0CiMg
Q09ORklHX0hBVkVfQVJDSF9WTUFQX1NUQUNLIGlzIG5vdCBzZXQKCiMKIyBHQ09WLWJhc2VkIGtl
cm5lbCBwcm9maWxpbmcKIwpDT05GSUdfQVJDSF9IQVNfR0NPVl9QUk9GSUxFX0FMTD15CkNPTkZJ
R19IQVZFX0dFTkVSSUNfRE1BX0NPSEVSRU5UPXkKQ09ORklHX1NMQUJJTkZPPXkKQ09ORklHX1JU
X01VVEVYRVM9eQpDT05GSUdfQkFTRV9TTUFMTD0wCkNPTkZJR19NT0RVTEVTPXkKIyBDT05GSUdf
TU9EVUxFX0ZPUkNFX0xPQUQgaXMgbm90IHNldApDT05GSUdfTU9EVUxFX1VOTE9BRD15CiMgQ09O
RklHX01PRFVMRV9GT1JDRV9VTkxPQUQgaXMgbm90IHNldAojIENPTkZJR19NT0RWRVJTSU9OUyBp
cyBub3Qgc2V0CiMgQ09ORklHX01PRFVMRV9TUkNWRVJTSU9OX0FMTCBpcyBub3Qgc2V0CiMgQ09O
RklHX01PRFVMRV9TSUcgaXMgbm90IHNldAojIENPTkZJR19NT0RVTEVfQ09NUFJFU1MgaXMgbm90
IHNldAojIENPTkZJR19UUklNX1VOVVNFRF9LU1lNUyBpcyBub3Qgc2V0CkNPTkZJR19CTE9DSz15
CkNPTkZJR19MQkRBRj15CkNPTkZJR19CTEtfREVWX0JTRz15CiMgQ09ORklHX0JMS19ERVZfQlNH
TElCIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9JTlRFR1JJVFkgaXMgbm90IHNldAojIENP
TkZJR19CTEtfQ01ETElORV9QQVJTRVIgaXMgbm90IHNldAoKIwojIFBhcnRpdGlvbiBUeXBlcwoj
CkNPTkZJR19QQVJUSVRJT05fQURWQU5DRUQ9eQojIENPTkZJR19BQ09STl9QQVJUSVRJT04gaXMg
bm90IHNldAojIENPTkZJR19BSVhfUEFSVElUSU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfT1NGX1BB
UlRJVElPTiBpcyBub3Qgc2V0CiMgQ09ORklHX0FNSUdBX1BBUlRJVElPTiBpcyBub3Qgc2V0CiMg
Q09ORklHX0FUQVJJX1BBUlRJVElPTiBpcyBub3Qgc2V0CiMgQ09ORklHX01BQ19QQVJUSVRJT04g
aXMgbm90IHNldApDT05GSUdfTVNET1NfUEFSVElUSU9OPXkKIyBDT05GSUdfQlNEX0RJU0tMQUJF
TCBpcyBub3Qgc2V0CiMgQ09ORklHX01JTklYX1NVQlBBUlRJVElPTiBpcyBub3Qgc2V0CiMgQ09O
RklHX1NPTEFSSVNfWDg2X1BBUlRJVElPTiBpcyBub3Qgc2V0CiMgQ09ORklHX1VOSVhXQVJFX0RJ
U0tMQUJFTCBpcyBub3Qgc2V0CiMgQ09ORklHX0xETV9QQVJUSVRJT04gaXMgbm90IHNldAojIENP
TkZJR19TR0lfUEFSVElUSU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfVUxUUklYX1BBUlRJVElPTiBp
cyBub3Qgc2V0CiMgQ09ORklHX1NVTl9QQVJUSVRJT04gaXMgbm90IHNldAojIENPTkZJR19LQVJN
QV9QQVJUSVRJT04gaXMgbm90IHNldApDT05GSUdfRUZJX1BBUlRJVElPTj15CiMgQ09ORklHX1NZ
U1Y2OF9QQVJUSVRJT04gaXMgbm90IHNldAojIENPTkZJR19DTURMSU5FX1BBUlRJVElPTiBpcyBu
b3Qgc2V0CgojCiMgSU8gU2NoZWR1bGVycwojCkNPTkZJR19JT1NDSEVEX05PT1A9eQpDT05GSUdf
SU9TQ0hFRF9ERUFETElORT15CkNPTkZJR19JT1NDSEVEX0NGUT15CiMgQ09ORklHX0RFRkFVTFRf
REVBRExJTkUgaXMgbm90IHNldApDT05GSUdfREVGQVVMVF9DRlE9eQojIENPTkZJR19ERUZBVUxU
X05PT1AgaXMgbm90IHNldApDT05GSUdfREVGQVVMVF9JT1NDSEVEPSJjZnEiCkNPTkZJR19JTkxJ
TkVfU1BJTl9VTkxPQ0tfSVJRPXkKQ09ORklHX0lOTElORV9SRUFEX1VOTE9DSz15CkNPTkZJR19J
TkxJTkVfUkVBRF9VTkxPQ0tfSVJRPXkKQ09ORklHX0lOTElORV9XUklURV9VTkxPQ0s9eQpDT05G
SUdfSU5MSU5FX1dSSVRFX1VOTE9DS19JUlE9eQpDT05GSUdfQVJDSF9TVVBQT1JUU19BVE9NSUNf
Uk1XPXkKQ09ORklHX0ZSRUVaRVI9eQoKIwojIFN5c3RlbSBUeXBlCiMKQ09ORklHX01NVT15CkNP
TkZJR19BUkNIX01VTFRJUExBVEZPUk09eQojIENPTkZJR19BUkNIX0dFTUlOSSBpcyBub3Qgc2V0
CiMgQ09ORklHX0FSQ0hfRUJTQTExMCBpcyBub3Qgc2V0CiMgQ09ORklHX0FSQ0hfRVA5M1hYIGlz
IG5vdCBzZXQKIyBDT05GSUdfQVJDSF9GT09UQlJJREdFIGlzIG5vdCBzZXQKIyBDT05GSUdfQVJD
SF9ORVRYIGlzIG5vdCBzZXQKIyBDT05GSUdfQVJDSF9JT1AxM1hYIGlzIG5vdCBzZXQKIyBDT05G
SUdfQVJDSF9JT1AzMlggaXMgbm90IHNldAojIENPTkZJR19BUkNIX0lPUDMzWCBpcyBub3Qgc2V0
CiMgQ09ORklHX0FSQ0hfSVhQNFhYIGlzIG5vdCBzZXQKIyBDT05GSUdfQVJDSF9ET1ZFIGlzIG5v
dCBzZXQKIyBDT05GSUdfQVJDSF9LUzg2OTUgaXMgbm90IHNldAojIENPTkZJR19BUkNIX1c5MFg5
MDAgaXMgbm90IHNldAojIENPTkZJR19BUkNIX0xQQzMyWFggaXMgbm90IHNldAojIENPTkZJR19B
UkNIX1BYQSBpcyBub3Qgc2V0CiMgQ09ORklHX0FSQ0hfUlBDIGlzIG5vdCBzZXQKIyBDT05GSUdf
QVJDSF9TQTExMDAgaXMgbm90IHNldAojIENPTkZJR19BUkNIX1MzQzI0WFggaXMgbm90IHNldAoj
IENPTkZJR19BUkNIX0RBVklOQ0kgaXMgbm90IHNldAojIENPTkZJR19BUkNIX09NQVAxIGlzIG5v
dCBzZXQKCiMKIyBNdWx0aXBsZSBwbGF0Zm9ybSBzZWxlY3Rpb24KIwoKIwojIENQVSBDb3JlIGZh
bWlseSBzZWxlY3Rpb24KIwojIENPTkZJR19BUkNIX01VTFRJX1Y0IGlzIG5vdCBzZXQKIyBDT05G
SUdfQVJDSF9NVUxUSV9WNFQgaXMgbm90IHNldApDT05GSUdfQVJDSF9NVUxUSV9WNT15CkNPTkZJ
R19BUkNIX01VTFRJX1Y0X1Y1PXkKIyBDT05GSUdfQVJDSF9NVUxUSV9WNiBpcyBub3Qgc2V0CiMg
Q09ORklHX0FSQ0hfTVVMVElfVjcgaXMgbm90IHNldApDT05GSUdfQVJDSF9NVUxUSV9DUFVfQVVU
Tz15CiMgQ09ORklHX0FSQ0hfTVZFQlUgaXMgbm90IHNldAojIENPTkZJR19NQUNIX0FTTTkyNjAg
aXMgbm90IHNldAojIENPTkZJR19BUkNIX0FUOTEgaXMgbm90IHNldAojIENPTkZJR19BUkNIX0lO
VEVHUkFUT1IgaXMgbm90IHNldAojIENPTkZJR19BUkNIX0FTUEVFRCBpcyBub3Qgc2V0CiMgQ09O
RklHX0FSQ0hfTVY3OFhYMCBpcyBub3Qgc2V0CiMgQ09ORklHX0FSQ0hfTVhDIGlzIG5vdCBzZXQK
IyBDT05GSUdfQVJDSF9NWFMgaXMgbm90IHNldAojIENPTkZJR19BUkNIX05PTUFESUsgaXMgbm90
IHNldAojIENPTkZJR19BUkNIX05TUElSRSBpcyBub3Qgc2V0CiMgQ09ORklHX0FSQ0hfT1JJT041
WCBpcyBub3Qgc2V0CiMgQ09ORklHX0FSQ0hfTU1QIGlzIG5vdCBzZXQKQ09ORklHX0FSQ0hfT1hO
QVM9eQpDT05GSUdfTUFDSF9PWDgxMFNFPXkKIyBDT05GSUdfQVJDSF9SRUFMVklFVyBpcyBub3Qg
c2V0CiMgQ09ORklHX1BMQVRfU1BFQVIgaXMgbm90IHNldAojIENPTkZJR19BUkNIX1UzMDAgaXMg
bm90IHNldAojIENPTkZJR19BUkNIX1ZFUlNBVElMRSBpcyBub3Qgc2V0CiMgQ09ORklHX0FSQ0hf
V004NTA1IGlzIG5vdCBzZXQKCiMKIyBQcm9jZXNzb3IgVHlwZQojCkNPTkZJR19DUFVfQVJNOTI2
VD15CkNPTkZJR19DUFVfMzJ2NT15CkNPTkZJR19DUFVfQUJSVF9FVjVUSj15CkNPTkZJR19DUFVf
UEFCUlRfTEVHQUNZPXkKQ09ORklHX0NQVV9DQUNIRV9WSVZUPXkKQ09ORklHX0NQVV9DT1BZX1Y0
V0I9eQpDT05GSUdfQ1BVX1RMQl9WNFdCST15CkNPTkZJR19DUFVfQ1AxNT15CkNPTkZJR19DUFVf
Q1AxNV9NTVU9eQpDT05GSUdfQ1BVX1VTRV9ET01BSU5TPXkKCiMKIyBQcm9jZXNzb3IgRmVhdHVy
ZXMKIwojIENPTkZJR19BUkNIX1BIWVNfQUREUl9UXzY0QklUIGlzIG5vdCBzZXQKQ09ORklHX0FS
TV9USFVNQj15CiMgQ09ORklHX0NQVV9JQ0FDSEVfRElTQUJMRSBpcyBub3Qgc2V0CiMgQ09ORklH
X0NQVV9EQ0FDSEVfRElTQUJMRSBpcyBub3Qgc2V0CiMgQ09ORklHX0NQVV9EQ0FDSEVfV1JJVEVU
SFJPVUdIIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1BVX0NBQ0hFX1JPVU5EX1JPQklOIGlzIG5vdCBz
ZXQKQ09ORklHX05FRURfS1VTRVJfSEVMUEVSUz15CkNPTkZJR19LVVNFUl9IRUxQRVJTPXkKIyBD
T05GSUdfQ0FDSEVfTDJYMCBpcyBub3Qgc2V0CkNPTkZJR19BUk1fTDFfQ0FDSEVfU0hJRlQ9NQoj
IENPTkZJR19ERUJVR19ST0RBVEEgaXMgbm90IHNldApDT05GSUdfTVVMVElfSVJRX0hBTkRMRVI9
eQoKIwojIEJ1cyBzdXBwb3J0CiMKIyBDT05GSUdfUENJIGlzIG5vdCBzZXQKIyBDT05GSUdfUENJ
X0RPTUFJTlNfR0VORVJJQyBpcyBub3Qgc2V0CiMgQ09ORklHX1BDSV9TWVNDQUxMIGlzIG5vdCBz
ZXQKIyBDT05GSUdfUENDQVJEIGlzIG5vdCBzZXQKCiMKIyBLZXJuZWwgRmVhdHVyZXMKIwpDT05G
SUdfVk1TUExJVF8zRz15CiMgQ09ORklHX1ZNU1BMSVRfM0dfT1BUIGlzIG5vdCBzZXQKIyBDT05G
SUdfVk1TUExJVF8yRyBpcyBub3Qgc2V0CiMgQ09ORklHX1ZNU1BMSVRfMUcgaXMgbm90IHNldApD
T05GSUdfUEFHRV9PRkZTRVQ9MHhDMDAwMDAwMApDT05GSUdfQVJDSF9OUl9HUElPPTAKQ09ORklH
X1BSRUVNUFRfTk9ORT15CiMgQ09ORklHX1BSRUVNUFRfVk9MVU5UQVJZIGlzIG5vdCBzZXQKIyBD
T05GSUdfUFJFRU1QVCBpcyBub3Qgc2V0CkNPTkZJR19IWl9GSVhFRD0wCkNPTkZJR19IWl8xMDA9
eQojIENPTkZJR19IWl8yMDAgaXMgbm90IHNldAojIENPTkZJR19IWl8yNTAgaXMgbm90IHNldAoj
IENPTkZJR19IWl8zMDAgaXMgbm90IHNldAojIENPTkZJR19IWl81MDAgaXMgbm90IHNldAojIENP
TkZJR19IWl8xMDAwIGlzIG5vdCBzZXQKQ09ORklHX0haPTEwMApDT05GSUdfU0NIRURfSFJUSUNL
PXkKQ09ORklHX0FFQUJJPXkKQ09ORklHX09BQklfQ09NUEFUPXkKIyBDT05GSUdfQVJDSF9TUEFS
U0VNRU1fREVGQVVMVCBpcyBub3Qgc2V0CiMgQ09ORklHX0FSQ0hfU0VMRUNUX01FTU9SWV9NT0RF
TCBpcyBub3Qgc2V0CkNPTkZJR19IQVZFX0FSQ0hfUEZOX1ZBTElEPXkKIyBDT05GSUdfSElHSE1F
TSBpcyBub3Qgc2V0CkNPTkZJR19DUFVfU1dfRE9NQUlOX1BBTj15CkNPTkZJR19BUkNIX1dBTlRf
R0VORVJBTF9IVUdFVExCPXkKIyBDT05GSUdfQVJNX01PRFVMRV9QTFRTIGlzIG5vdCBzZXQKQ09O
RklHX0ZMQVRNRU09eQpDT05GSUdfRkxBVF9OT0RFX01FTV9NQVA9eQpDT05GSUdfSEFWRV9NRU1C
TE9DSz15CkNPTkZJR19OT19CT09UTUVNPXkKIyBDT05GSUdfSEFWRV9CT09UTUVNX0lORk9fTk9E
RSBpcyBub3Qgc2V0CkNPTkZJR19TUExJVF9QVExPQ0tfQ1BVUz05OTk5OTkKQ09ORklHX0NPTVBB
Q1RJT049eQpDT05GSUdfTUlHUkFUSU9OPXkKIyBDT05GSUdfUEhZU19BRERSX1RfNjRCSVQgaXMg
bm90IHNldAojIENPTkZJR19LU00gaXMgbm90IHNldApDT05GSUdfREVGQVVMVF9NTUFQX01JTl9B
RERSPTQwOTYKQ09ORklHX05FRURfUEVSX0NQVV9LTT15CiMgQ09ORklHX0NMRUFOQ0FDSEUgaXMg
bm90IHNldAojIENPTkZJR19GUk9OVFNXQVAgaXMgbm90IHNldAojIENPTkZJR19DTUEgaXMgbm90
IHNldAojIENPTkZJR19aUE9PTCBpcyBub3Qgc2V0CiMgQ09ORklHX1pCVUQgaXMgbm90IHNldAoj
IENPTkZJR19aU01BTExPQyBpcyBub3Qgc2V0CkNPTkZJR19HRU5FUklDX0VBUkxZX0lPUkVNQVA9
eQojIENPTkZJR19JRExFX1BBR0VfVFJBQ0tJTkcgaXMgbm90IHNldApDT05GSUdfRk9SQ0VfTUFY
X1pPTkVPUkRFUj0xMQpDT05GSUdfQUxJR05NRU5UX1RSQVA9eQojIENPTkZJR19VQUNDRVNTX1dJ
VEhfTUVNQ1BZIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VDQ09NUCBpcyBub3Qgc2V0CkNPTkZJR19T
V0lPVExCPXkKQ09ORklHX0lPTU1VX0hFTFBFUj15CiMgQ09ORklHX1BBUkFWSVJUIGlzIG5vdCBz
ZXQKIyBDT05GSUdfUEFSQVZJUlRfVElNRV9BQ0NPVU5USU5HIGlzIG5vdCBzZXQKCiMKIyBCb290
IG9wdGlvbnMKIwpDT05GSUdfVVNFX09GPXkKQ09ORklHX0FUQUdTPXkKIyBDT05GSUdfREVQUkVD
QVRFRF9QQVJBTV9TVFJVQ1QgaXMgbm90IHNldApDT05GSUdfWkJPT1RfUk9NX1RFWFQ9MHgwCkNP
TkZJR19aQk9PVF9ST01fQlNTPTB4MApDT05GSUdfQVJNX0FQUEVOREVEX0RUQj15CkNPTkZJR19B
Uk1fQVRBR19EVEJfQ09NUEFUPXkKQ09ORklHX0FSTV9BVEFHX0RUQl9DT01QQVRfQ01ETElORV9G
Uk9NX0JPT1RMT0FERVI9eQojIENPTkZJR19BUk1fQVRBR19EVEJfQ09NUEFUX0NNRExJTkVfRVhU
RU5EIGlzIG5vdCBzZXQKQ09ORklHX0NNRExJTkU9InJvb3Q9MWYwMyBtZW09MzJNIgpDT05GSUdf
Q01ETElORV9GUk9NX0JPT1RMT0FERVI9eQojIENPTkZJR19DTURMSU5FX0VYVEVORCBpcyBub3Qg
c2V0CiMgQ09ORklHX0NNRExJTkVfRk9SQ0UgaXMgbm90IHNldAojIENPTkZJR19LRVhFQyBpcyBu
b3Qgc2V0CiMgQ09ORklHX0NSQVNIX0RVTVAgaXMgbm90IHNldApDT05GSUdfQVVUT19aUkVMQURE
Uj15CiMgQ09ORklHX0VGSSBpcyBub3Qgc2V0CgojCiMgQ1BVIFBvd2VyIE1hbmFnZW1lbnQKIwoK
IwojIENQVSBGcmVxdWVuY3kgc2NhbGluZwojCiMgQ09ORklHX0NQVV9GUkVRIGlzIG5vdCBzZXQK
CiMKIyBDUFUgSWRsZQojCiMgQ09ORklHX0NQVV9JRExFIGlzIG5vdCBzZXQKIyBDT05GSUdfQVJD
SF9ORUVEU19DUFVfSURMRV9DT1VQTEVEIGlzIG5vdCBzZXQKCiMKIyBGbG9hdGluZyBwb2ludCBl
bXVsYXRpb24KIwoKIwojIEF0IGxlYXN0IG9uZSBlbXVsYXRpb24gbXVzdCBiZSBzZWxlY3RlZAoj
CkNPTkZJR19GUEVfTldGUEU9eQojIENPTkZJR19GUEVfTldGUEVfWFAgaXMgbm90IHNldAojIENP
TkZJR19GUEVfRkFTVEZQRSBpcyBub3Qgc2V0CkNPTkZJR19WRlA9eQoKIwojIFVzZXJzcGFjZSBi
aW5hcnkgZm9ybWF0cwojCkNPTkZJR19CSU5GTVRfRUxGPXkKQ09ORklHX0VMRkNPUkU9eQpDT05G
SUdfQ09SRV9EVU1QX0RFRkFVTFRfRUxGX0hFQURFUlM9eQpDT05GSUdfQklORk1UX1NDUklQVD15
CiMgQ09ORklHX0JJTkZNVF9GTEFUIGlzIG5vdCBzZXQKIyBDT05GSUdfSEFWRV9BT1VUIGlzIG5v
dCBzZXQKIyBDT05GSUdfQklORk1UX01JU0MgaXMgbm90IHNldApDT05GSUdfQ09SRURVTVA9eQoK
IwojIFBvd2VyIG1hbmFnZW1lbnQgb3B0aW9ucwojCkNPTkZJR19TVVNQRU5EPXkKQ09ORklHX1NV
U1BFTkRfRlJFRVpFUj15CiMgQ09ORklHX0hJQkVSTkFUSU9OIGlzIG5vdCBzZXQKQ09ORklHX1BN
X1NMRUVQPXkKIyBDT05GSUdfUE1fQVVUT1NMRUVQIGlzIG5vdCBzZXQKIyBDT05GSUdfUE1fV0FL
RUxPQ0tTIGlzIG5vdCBzZXQKQ09ORklHX1BNPXkKIyBDT05GSUdfUE1fREVCVUcgaXMgbm90IHNl
dAojIENPTkZJR19BUE1fRU1VTEFUSU9OIGlzIG5vdCBzZXQKQ09ORklHX1BNX0NMSz15CiMgQ09O
RklHX1dRX1BPV0VSX0VGRklDSUVOVF9ERUZBVUxUIGlzIG5vdCBzZXQKQ09ORklHX0NQVV9QTT15
CkNPTkZJR19BUkNIX1NVU1BFTkRfUE9TU0lCTEU9eQpDT05GSUdfQVJNX0NQVV9TVVNQRU5EPXkK
Q09ORklHX0FSQ0hfSElCRVJOQVRJT05fUE9TU0lCTEU9eQpDT05GSUdfTkVUPXkKCiMKIyBOZXR3
b3JraW5nIG9wdGlvbnMKIwpDT05GSUdfUEFDS0VUPXkKIyBDT05GSUdfUEFDS0VUX0RJQUcgaXMg
bm90IHNldApDT05GSUdfVU5JWD15CiMgQ09ORklHX1VOSVhfRElBRyBpcyBub3Qgc2V0CkNPTkZJ
R19YRlJNPXkKIyBDT05GSUdfWEZSTV9VU0VSIGlzIG5vdCBzZXQKIyBDT05GSUdfWEZSTV9TVUJf
UE9MSUNZIGlzIG5vdCBzZXQKIyBDT05GSUdfWEZSTV9NSUdSQVRFIGlzIG5vdCBzZXQKIyBDT05G
SUdfWEZSTV9TVEFUSVNUSUNTIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0tFWSBpcyBub3Qgc2V0
CkNPTkZJR19JTkVUPXkKQ09ORklHX0lQX01VTFRJQ0FTVD15CiMgQ09ORklHX0lQX0FEVkFOQ0VE
X1JPVVRFUiBpcyBub3Qgc2V0CkNPTkZJR19JUF9QTlA9eQojIENPTkZJR19JUF9QTlBfREhDUCBp
cyBub3Qgc2V0CkNPTkZJR19JUF9QTlBfQk9PVFA9eQojIENPTkZJR19JUF9QTlBfUkFSUCBpcyBu
b3Qgc2V0CiMgQ09ORklHX05FVF9JUElQIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0lQR1JFX0RF
TVVYIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0lQX1RVTk5FTCBpcyBub3Qgc2V0CiMgQ09ORklH
X0lQX01ST1VURSBpcyBub3Qgc2V0CiMgQ09ORklHX1NZTl9DT09LSUVTIGlzIG5vdCBzZXQKIyBD
T05GSUdfTkVUX0lQVlRJIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1VEUF9UVU5ORUwgaXMgbm90
IHNldAojIENPTkZJR19ORVRfRk9VIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5FVF9BSCBpcyBub3Qg
c2V0CiMgQ09ORklHX0lORVRfRVNQIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5FVF9JUENPTVAgaXMg
bm90IHNldAojIENPTkZJR19JTkVUX1hGUk1fVFVOTkVMIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5F
VF9UVU5ORUwgaXMgbm90IHNldApDT05GSUdfSU5FVF9YRlJNX01PREVfVFJBTlNQT1JUPXkKQ09O
RklHX0lORVRfWEZSTV9NT0RFX1RVTk5FTD15CkNPTkZJR19JTkVUX1hGUk1fTU9ERV9CRUVUPXkK
IyBDT05GSUdfSU5FVF9ESUFHIGlzIG5vdCBzZXQKIyBDT05GSUdfVENQX0NPTkdfQURWQU5DRUQg
aXMgbm90IHNldApDT05GSUdfVENQX0NPTkdfQ1VCSUM9eQpDT05GSUdfREVGQVVMVF9UQ1BfQ09O
Rz0iY3ViaWMiCiMgQ09ORklHX1RDUF9NRDVTSUcgaXMgbm90IHNldAojIENPTkZJR19JUFY2IGlz
IG5vdCBzZXQKIyBDT05GSUdfTkVUV09SS19TRUNNQVJLIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVU
X1BUUF9DTEFTU0lGWSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVFdPUktfUEhZX1RJTUVTVEFNUElO
RyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVEZJTFRFUiBpcyBub3Qgc2V0CiMgQ09ORklHX0lQX0RD
Q1AgaXMgbm90IHNldAojIENPTkZJR19JUF9TQ1RQIGlzIG5vdCBzZXQKIyBDT05GSUdfUkRTIGlz
IG5vdCBzZXQKIyBDT05GSUdfVElQQyBpcyBub3Qgc2V0CiMgQ09ORklHX0FUTSBpcyBub3Qgc2V0
CiMgQ09ORklHX0wyVFAgaXMgbm90IHNldAojIENPTkZJR19CUklER0UgaXMgbm90IHNldApDT05G
SUdfSEFWRV9ORVRfRFNBPXkKIyBDT05GSUdfTkVUX0RTQSBpcyBub3Qgc2V0CiMgQ09ORklHX1ZM
QU5fODAyMVEgaXMgbm90IHNldAojIENPTkZJR19ERUNORVQgaXMgbm90IHNldAojIENPTkZJR19M
TEMyIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBYIGlzIG5vdCBzZXQKIyBDT05GSUdfQVRBTEsgaXMg
bm90IHNldAojIENPTkZJR19YMjUgaXMgbm90IHNldAojIENPTkZJR19MQVBCIGlzIG5vdCBzZXQK
IyBDT05GSUdfUEhPTkVUIGlzIG5vdCBzZXQKIyBDT05GSUdfSUVFRTgwMjE1NCBpcyBub3Qgc2V0
CiMgQ09ORklHX05FVF9TQ0hFRCBpcyBub3Qgc2V0CiMgQ09ORklHX0RDQiBpcyBub3Qgc2V0CiMg
Q09ORklHX0JBVE1BTl9BRFYgaXMgbm90IHNldAojIENPTkZJR19PUEVOVlNXSVRDSCBpcyBub3Qg
c2V0CiMgQ09ORklHX1ZTT0NLRVRTIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUTElOS19ESUFHIGlz
IG5vdCBzZXQKIyBDT05GSUdfTVBMUyBpcyBub3Qgc2V0CiMgQ09ORklHX0hTUiBpcyBub3Qgc2V0
CiMgQ09ORklHX05FVF9TV0lUQ0hERVYgaXMgbm90IHNldAojIENPTkZJR19ORVRfTDNfTUFTVEVS
X0RFViBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9OQ1NJIGlzIG5vdCBzZXQKIyBDT05GSUdfU09D
S19DR1JPVVBfREFUQSBpcyBub3Qgc2V0CkNPTkZJR19ORVRfUlhfQlVTWV9QT0xMPXkKQ09ORklH
X0JRTD15CiMgQ09ORklHX0JQRl9KSVQgaXMgbm90IHNldAoKIwojIE5ldHdvcmsgdGVzdGluZwoj
CiMgQ09ORklHX05FVF9QS1RHRU4gaXMgbm90IHNldAojIENPTkZJR19IQU1SQURJTyBpcyBub3Qg
c2V0CiMgQ09ORklHX0NBTiBpcyBub3Qgc2V0CiMgQ09ORklHX0lSREEgaXMgbm90IHNldAojIENP
TkZJR19CVCBpcyBub3Qgc2V0CiMgQ09ORklHX0FGX1JYUlBDIGlzIG5vdCBzZXQKIyBDT05GSUdf
QUZfS0NNIGlzIG5vdCBzZXQKIyBDT05GSUdfU1RSRUFNX1BBUlNFUiBpcyBub3Qgc2V0CkNPTkZJ
R19XSVJFTEVTUz15CiMgQ09ORklHX0NGRzgwMjExIGlzIG5vdCBzZXQKIyBDT05GSUdfTElCODAy
MTEgaXMgbm90IHNldAoKIwojIENGRzgwMjExIG5lZWRzIHRvIGJlIGVuYWJsZWQgZm9yIE1BQzgw
MjExCiMKQ09ORklHX01BQzgwMjExX1NUQV9IQVNIX01BWF9TSVpFPTAKIyBDT05GSUdfV0lNQVgg
aXMgbm90IHNldAojIENPTkZJR19SRktJTEwgaXMgbm90IHNldAojIENPTkZJR19ORVRfOVAgaXMg
bm90IHNldAojIENPTkZJR19DQUlGIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0VQSF9MSUIgaXMgbm90
IHNldAojIENPTkZJR19ORkMgaXMgbm90IHNldAojIENPTkZJR19MV1RVTk5FTCBpcyBub3Qgc2V0
CiMgQ09ORklHX0RTVF9DQUNIRSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9ERVZMSU5LIGlzIG5v
dCBzZXQKQ09ORklHX01BWV9VU0VfREVWTElOSz15CkNPTkZJR19IQVZFX0NCUEZfSklUPXkKCiMK
IyBEZXZpY2UgRHJpdmVycwojCgojCiMgR2VuZXJpYyBEcml2ZXIgT3B0aW9ucwojCkNPTkZJR19V
RVZFTlRfSEVMUEVSPXkKQ09ORklHX1VFVkVOVF9IRUxQRVJfUEFUSD0iIgojIENPTkZJR19ERVZU
TVBGUyBpcyBub3Qgc2V0CkNPTkZJR19TVEFOREFMT05FPXkKQ09ORklHX1BSRVZFTlRfRklSTVdB
UkVfQlVJTEQ9eQpDT05GSUdfRldfTE9BREVSPXkKQ09ORklHX0ZJUk1XQVJFX0lOX0tFUk5FTD15
CkNPTkZJR19FWFRSQV9GSVJNV0FSRT0iIgojIENPTkZJR19GV19MT0FERVJfVVNFUl9IRUxQRVJf
RkFMTEJBQ0sgaXMgbm90IHNldApDT05GSUdfQUxMT1dfREVWX0NPUkVEVU1QPXkKIyBDT05GSUdf
REVCVUdfRFJJVkVSIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfREVWUkVTIGlzIG5vdCBzZXQK
IyBDT05GSUdfREVCVUdfVEVTVF9EUklWRVJfUkVNT1ZFIGlzIG5vdCBzZXQKIyBDT05GSUdfU1lT
X0hZUEVSVklTT1IgaXMgbm90IHNldAojIENPTkZJR19HRU5FUklDX0NQVV9ERVZJQ0VTIGlzIG5v
dCBzZXQKQ09ORklHX1JFR01BUD15CkNPTkZJR19SRUdNQVBfSTJDPXkKQ09ORklHX1JFR01BUF9T
UEk9eQpDT05GSUdfUkVHTUFQX01NSU89eQojIENPTkZJR19ETUFfU0hBUkVEX0JVRkZFUiBpcyBu
b3Qgc2V0CgojCiMgQnVzIGRldmljZXMKIwojIENPTkZJR19CUkNNU1RCX0dJU0JfQVJCIGlzIG5v
dCBzZXQKIyBDT05GSUdfVkVYUFJFU1NfQ09ORklHIGlzIG5vdCBzZXQKIyBDT05GSUdfQ09OTkVD
VE9SIGlzIG5vdCBzZXQKQ09ORklHX01URD15CiMgQ09ORklHX01URF9URVNUUyBpcyBub3Qgc2V0
CiMgQ09ORklHX01URF9SRURCT09UX1BBUlRTIGlzIG5vdCBzZXQKQ09ORklHX01URF9DTURMSU5F
X1BBUlRTPXkKIyBDT05GSUdfTVREX0FGU19QQVJUUyBpcyBub3Qgc2V0CkNPTkZJR19NVERfT0Zf
UEFSVFM9eQojIENPTkZJR19NVERfQVI3X1BBUlRTIGlzIG5vdCBzZXQKCiMKIyBVc2VyIE1vZHVs
ZXMgQW5kIFRyYW5zbGF0aW9uIExheWVycwojCkNPTkZJR19NVERfQkxLREVWUz15CkNPTkZJR19N
VERfQkxPQ0s9eQojIENPTkZJR19GVEwgaXMgbm90IHNldAojIENPTkZJR19ORlRMIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSU5GVEwgaXMgbm90IHNldAojIENPTkZJR19SRkRfRlRMIGlzIG5vdCBzZXQK
IyBDT05GSUdfU1NGREMgaXMgbm90IHNldAojIENPTkZJR19TTV9GVEwgaXMgbm90IHNldAojIENP
TkZJR19NVERfT09QUyBpcyBub3Qgc2V0CiMgQ09ORklHX01URF9TV0FQIGlzIG5vdCBzZXQKIyBD
T05GSUdfTVREX1BBUlRJVElPTkVEX01BU1RFUiBpcyBub3Qgc2V0CgojCiMgUkFNL1JPTS9GbGFz
aCBjaGlwIGRyaXZlcnMKIwpDT05GSUdfTVREX0NGST15CiMgQ09ORklHX01URF9KRURFQ1BST0JF
IGlzIG5vdCBzZXQKQ09ORklHX01URF9HRU5fUFJPQkU9eQpDT05GSUdfTVREX0NGSV9BRFZfT1BU
SU9OUz15CkNPTkZJR19NVERfQ0ZJX05PU1dBUD15CiMgQ09ORklHX01URF9DRklfQkVfQllURV9T
V0FQIGlzIG5vdCBzZXQKIyBDT05GSUdfTVREX0NGSV9MRV9CWVRFX1NXQVAgaXMgbm90IHNldAoj
IENPTkZJR19NVERfQ0ZJX0dFT01FVFJZIGlzIG5vdCBzZXQKQ09ORklHX01URF9NQVBfQkFOS19X
SURUSF8xPXkKQ09ORklHX01URF9NQVBfQkFOS19XSURUSF8yPXkKQ09ORklHX01URF9NQVBfQkFO
S19XSURUSF80PXkKIyBDT05GSUdfTVREX01BUF9CQU5LX1dJRFRIXzggaXMgbm90IHNldAojIENP
TkZJR19NVERfTUFQX0JBTktfV0lEVEhfMTYgaXMgbm90IHNldAojIENPTkZJR19NVERfTUFQX0JB
TktfV0lEVEhfMzIgaXMgbm90IHNldApDT05GSUdfTVREX0NGSV9JMT15CkNPTkZJR19NVERfQ0ZJ
X0kyPXkKIyBDT05GSUdfTVREX0NGSV9JNCBpcyBub3Qgc2V0CiMgQ09ORklHX01URF9DRklfSTgg
aXMgbm90IHNldAojIENPTkZJR19NVERfT1RQIGlzIG5vdCBzZXQKQ09ORklHX01URF9DRklfSU5U
RUxFWFQ9eQojIENPTkZJR19NVERfQ0ZJX0FNRFNURCBpcyBub3Qgc2V0CiMgQ09ORklHX01URF9D
RklfU1RBQSBpcyBub3Qgc2V0CkNPTkZJR19NVERfQ0ZJX1VUSUw9eQojIENPTkZJR19NVERfUkFN
IGlzIG5vdCBzZXQKIyBDT05GSUdfTVREX1JPTSBpcyBub3Qgc2V0CiMgQ09ORklHX01URF9BQlNF
TlQgaXMgbm90IHNldAoKIwojIE1hcHBpbmcgZHJpdmVycyBmb3IgY2hpcCBhY2Nlc3MKIwojIENP
TkZJR19NVERfQ09NUExFWF9NQVBQSU5HUyBpcyBub3Qgc2V0CkNPTkZJR19NVERfUEhZU01BUD15
CiMgQ09ORklHX01URF9QSFlTTUFQX0NPTVBBVCBpcyBub3Qgc2V0CiMgQ09ORklHX01URF9QSFlT
TUFQX09GIGlzIG5vdCBzZXQKIyBDT05GSUdfTVREX1BMQVRSQU0gaXMgbm90IHNldAoKIwojIFNl
bGYtY29udGFpbmVkIE1URCBkZXZpY2UgZHJpdmVycwojCiMgQ09ORklHX01URF9EQVRBRkxBU0gg
aXMgbm90IHNldAojIENPTkZJR19NVERfU1NUMjVMIGlzIG5vdCBzZXQKIyBDT05GSUdfTVREX1NM
UkFNIGlzIG5vdCBzZXQKIyBDT05GSUdfTVREX1BIUkFNIGlzIG5vdCBzZXQKIyBDT05GSUdfTVRE
X01URFJBTSBpcyBub3Qgc2V0CiMgQ09ORklHX01URF9CTE9DSzJNVEQgaXMgbm90IHNldAoKIwoj
IERpc2stT24tQ2hpcCBEZXZpY2UgRHJpdmVycwojCiMgQ09ORklHX01URF9ET0NHMyBpcyBub3Qg
c2V0CiMgQ09ORklHX01URF9OQU5EIGlzIG5vdCBzZXQKIyBDT05GSUdfTVREX09ORU5BTkQgaXMg
bm90IHNldAoKIwojIExQRERSICYgTFBERFIyIFBDTSBtZW1vcnkgZHJpdmVycwojCiMgQ09ORklH
X01URF9MUEREUiBpcyBub3Qgc2V0CiMgQ09ORklHX01URF9MUEREUjJfTlZNIGlzIG5vdCBzZXQK
IyBDT05GSUdfTVREX1NQSV9OT1IgaXMgbm90IHNldAojIENPTkZJR19NVERfVUJJIGlzIG5vdCBz
ZXQKQ09ORklHX0RUQz15CkNPTkZJR19PRj15CiMgQ09ORklHX09GX1VOSVRURVNUIGlzIG5vdCBz
ZXQKQ09ORklHX09GX0ZMQVRUUkVFPXkKQ09ORklHX09GX0VBUkxZX0ZMQVRUUkVFPXkKQ09ORklH
X09GX0FERFJFU1M9eQpDT05GSUdfT0ZfSVJRPXkKQ09ORklHX09GX05FVD15CkNPTkZJR19PRl9S
RVNFUlZFRF9NRU09eQojIENPTkZJR19PRl9PVkVSTEFZIGlzIG5vdCBzZXQKQ09ORklHX0FSQ0hf
TUlHSFRfSEFWRV9QQ19QQVJQT1JUPXkKIyBDT05GSUdfUEFSUE9SVCBpcyBub3Qgc2V0CkNPTkZJ
R19CTEtfREVWPXkKIyBDT05GSUdfQkxLX0RFVl9OVUxMX0JMSyBpcyBub3Qgc2V0CiMgQ09ORklH
X0JMS19ERVZfQ09XX0NPTU1PTiBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfTE9PUCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfRFJCRCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZf
TkJEIGlzIG5vdCBzZXQKQ09ORklHX0JMS19ERVZfUkFNPXkKQ09ORklHX0JMS19ERVZfUkFNX0NP
VU5UPTE2CkNPTkZJR19CTEtfREVWX1JBTV9TSVpFPTQwOTYKIyBDT05GSUdfQ0RST01fUEtUQ0RW
RCBpcyBub3Qgc2V0CiMgQ09ORklHX0FUQV9PVkVSX0VUSCBpcyBub3Qgc2V0CiMgQ09ORklHX01H
X0RJU0sgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX1JCRCBpcyBub3Qgc2V0CgojCiMgTWlz
YyBkZXZpY2VzCiMKIyBDT05GSUdfU0VOU09SU19MSVMzTFYwMkQgaXMgbm90IHNldAojIENPTkZJ
R19BRDUyNVhfRFBPVCBpcyBub3Qgc2V0CiMgQ09ORklHX0RVTU1ZX0lSUSBpcyBub3Qgc2V0CiMg
Q09ORklHX0lDUzkzMlM0MDEgaXMgbm90IHNldAojIENPTkZJR19FTkNMT1NVUkVfU0VSVklDRVMg
aXMgbm90IHNldAojIENPTkZJR19BUERTOTgwMkFMUyBpcyBub3Qgc2V0CiMgQ09ORklHX0lTTDI5
MDAzIGlzIG5vdCBzZXQKIyBDT05GSUdfSVNMMjkwMjAgaXMgbm90IHNldAojIENPTkZJR19TRU5T
T1JTX1RTTDI1NTAgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0JIMTc3MCBpcyBub3Qgc2V0
CiMgQ09ORklHX1NFTlNPUlNfQVBEUzk5MFggaXMgbm90IHNldAojIENPTkZJR19ITUM2MzUyIGlz
IG5vdCBzZXQKIyBDT05GSUdfRFMxNjgyIGlzIG5vdCBzZXQKIyBDT05GSUdfVElfREFDNzUxMiBp
cyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TV0lUQ0hfRlNBOTQ4MCBpcyBub3Qgc2V0CiMgQ09ORklH
X0xBVFRJQ0VfRUNQM19DT05GSUcgaXMgbm90IHNldAojIENPTkZJR19TUkFNIGlzIG5vdCBzZXQK
IyBDT05GSUdfQzJQT1JUIGlzIG5vdCBzZXQKCiMKIyBFRVBST00gc3VwcG9ydAojCiMgQ09ORklH
X0VFUFJPTV9BVDI0IGlzIG5vdCBzZXQKIyBDT05GSUdfRUVQUk9NX0FUMjUgaXMgbm90IHNldApD
T05GSUdfRUVQUk9NX0xFR0FDWT1tCiMgQ09ORklHX0VFUFJPTV9NQVg2ODc1IGlzIG5vdCBzZXQK
IyBDT05GSUdfRUVQUk9NXzkzQ1g2IGlzIG5vdCBzZXQKIyBDT05GSUdfRUVQUk9NXzkzWFg0NiBp
cyBub3Qgc2V0CgojCiMgVGV4YXMgSW5zdHJ1bWVudHMgc2hhcmVkIHRyYW5zcG9ydCBsaW5lIGRp
c2NpcGxpbmUKIwojIENPTkZJR19USV9TVCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTElT
M19TUEkgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0xJUzNfSTJDIGlzIG5vdCBzZXQKCiMK
IyBBbHRlcmEgRlBHQSBmaXJtd2FyZSBkb3dubG9hZCBtb2R1bGUKIwojIENPTkZJR19BTFRFUkFf
U1RBUEwgaXMgbm90IHNldAoKIwojIEludGVsIE1JQyBCdXMgRHJpdmVyCiMKCiMKIyBTQ0lGIEJ1
cyBEcml2ZXIKIwoKIwojIFZPUCBCdXMgRHJpdmVyCiMKCiMKIyBJbnRlbCBNSUMgSG9zdCBEcml2
ZXIKIwoKIwojIEludGVsIE1JQyBDYXJkIERyaXZlcgojCgojCiMgU0NJRiBEcml2ZXIKIwoKIwoj
IEludGVsIE1JQyBDb3Byb2Nlc3NvciBTdGF0ZSBNYW5hZ2VtZW50IChDT1NNKSBEcml2ZXJzCiMK
CiMKIyBWT1AgRHJpdmVyCiMKIyBDT05GSUdfRUNITyBpcyBub3Qgc2V0CiMgQ09ORklHX0NYTF9C
QVNFIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1hMX0FGVV9EUklWRVJfT1BTIGlzIG5vdCBzZXQKCiMK
IyBTQ1NJIGRldmljZSBzdXBwb3J0CiMKQ09ORklHX1NDU0lfTU9EPXkKIyBDT05GSUdfUkFJRF9B
VFRSUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0kgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0RN
QSBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfTkVUTElOSyBpcyBub3Qgc2V0CiMgQ09ORklHX0FU
QSBpcyBub3Qgc2V0CiMgQ09ORklHX01EIGlzIG5vdCBzZXQKQ09ORklHX05FVERFVklDRVM9eQpD
T05GSUdfTUlJPXkKQ09ORklHX05FVF9DT1JFPXkKIyBDT05GSUdfQk9ORElORyBpcyBub3Qgc2V0
CiMgQ09ORklHX0RVTU1ZIGlzIG5vdCBzZXQKIyBDT05GSUdfRVFVQUxJWkVSIGlzIG5vdCBzZXQK
IyBDT05GSUdfTkVUX1RFQU0gaXMgbm90IHNldAojIENPTkZJR19NQUNWTEFOIGlzIG5vdCBzZXQK
IyBDT05GSUdfVlhMQU4gaXMgbm90IHNldAojIENPTkZJR19NQUNTRUMgaXMgbm90IHNldAojIENP
TkZJR19ORVRDT05TT0xFIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUUE9MTCBpcyBub3Qgc2V0CiMg
Q09ORklHX05FVF9QT0xMX0NPTlRST0xMRVIgaXMgbm90IHNldAojIENPTkZJR19UVU4gaXMgbm90
IHNldAojIENPTkZJR19UVU5fVk5FVF9DUk9TU19MRSBpcyBub3Qgc2V0CiMgQ09ORklHX1ZFVEgg
aXMgbm90IHNldAojIENPTkZJR19OTE1PTiBpcyBub3Qgc2V0CgojCiMgQ0FJRiB0cmFuc3BvcnQg
ZHJpdmVycwojCgojCiMgRGlzdHJpYnV0ZWQgU3dpdGNoIEFyY2hpdGVjdHVyZSBkcml2ZXJzCiMK
Q09ORklHX0VUSEVSTkVUPXkKIyBDT05GSUdfQUxURVJBX1RTRSBpcyBub3Qgc2V0CkNPTkZJR19O
RVRfVkVORE9SX0FNQVpPTj15CkNPTkZJR19ORVRfVkVORE9SX0FSQz15CiMgQ09ORklHX0FSQ19F
TUFDIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9BVVJPUkEgaXMgbm90IHNldApDT05G
SUdfTkVUX0NBREVOQ0U9eQojIENPTkZJR19NQUNCIGlzIG5vdCBzZXQKQ09ORklHX05FVF9WRU5E
T1JfQlJPQURDT009eQojIENPTkZJR19CNDQgaXMgbm90IHNldAojIENPTkZJR19CQ01HRU5FVCBp
cyBub3Qgc2V0CiMgQ09ORklHX1NZU1RFTVBPUlQgaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRP
Ul9DSVJSVVM9eQojIENPTkZJR19DUzg5eDAgaXMgbm90IHNldAojIENPTkZJR19ETTkwMDAgaXMg
bm90IHNldAojIENPTkZJR19ETkVUIGlzIG5vdCBzZXQKQ09ORklHX05FVF9WRU5ET1JfRVpDSElQ
PXkKIyBDT05GSUdfRVpDSElQX05QU19NQU5BR0VNRU5UX0VORVQgaXMgbm90IHNldApDT05GSUdf
TkVUX1ZFTkRPUl9GQVJBREFZPXkKIyBDT05GSUdfRlRNQUMxMDAgaXMgbm90IHNldAojIENPTkZJ
R19GVEdNQUMxMDAgaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9ISVNJTElDT049eQojIENP
TkZJR19ISVg1SEQyX0dNQUMgaXMgbm90IHNldAojIENPTkZJR19ISVNJX0ZFTUFDIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSElQMDRfRVRIIGlzIG5vdCBzZXQKIyBDT05GSUdfSE5TIGlzIG5vdCBzZXQK
IyBDT05GSUdfSE5TX0RTQUYgaXMgbm90IHNldAojIENPTkZJR19ITlNfRU5FVCBpcyBub3Qgc2V0
CkNPTkZJR19ORVRfVkVORE9SX0lOVEVMPXkKQ09ORklHX05FVF9WRU5ET1JfSTgyNVhYPXkKQ09O
RklHX05FVF9WRU5ET1JfTUFSVkVMTD15CiMgQ09ORklHX01WTURJTyBpcyBub3Qgc2V0CiMgQ09O
RklHX01WTkVUQV9CTSBpcyBub3Qgc2V0CkNPTkZJR19ORVRfVkVORE9SX01JQ1JFTD15CiMgQ09O
RklHX0tTODg1MSBpcyBub3Qgc2V0CiMgQ09ORklHX0tTODg1MV9NTEwgaXMgbm90IHNldApDT05G
SUdfTkVUX1ZFTkRPUl9NSUNST0NISVA9eQojIENPTkZJR19FTkMyOEo2MCBpcyBub3Qgc2V0CiMg
Q09ORklHX0VOQ1gyNEo2MDAgaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9OQVRTRU1JPXkK
Q09ORklHX05FVF9WRU5ET1JfTkVUUk9OT01FPXkKQ09ORklHX05FVF9WRU5ET1JfODM5MD15CiMg
Q09ORklHX0FYODg3OTYgaXMgbm90IHNldAojIENPTkZJR19FVEhPQyBpcyBub3Qgc2V0CkNPTkZJ
R19ORVRfVkVORE9SX1FVQUxDT01NPXkKIyBDT05GSUdfUUNBNzAwMCBpcyBub3Qgc2V0CiMgQ09O
RklHX1FDT01fRU1BQyBpcyBub3Qgc2V0CkNPTkZJR19ORVRfVkVORE9SX1JFTkVTQVM9eQpDT05G
SUdfTkVUX1ZFTkRPUl9ST0NLRVI9eQpDT05GSUdfTkVUX1ZFTkRPUl9TQU1TVU5HPXkKIyBDT05G
SUdfU1hHQkVfRVRIIGlzIG5vdCBzZXQKQ09ORklHX05FVF9WRU5ET1JfU0VFUT15CkNPTkZJR19O
RVRfVkVORE9SX1NNU0M9eQpDT05GSUdfU01DOTFYPXkKIyBDT05GSUdfU01DOTExWCBpcyBub3Qg
c2V0CiMgQ09ORklHX1NNU0M5MTFYIGlzIG5vdCBzZXQKQ09ORklHX05FVF9WRU5ET1JfU1RNSUNS
Tz15CiMgQ09ORklHX1NUTU1BQ19FVEggaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9TWU5P
UFNZUz15CiMgQ09ORklHX1NZTk9QU1lTX0RXQ19FVEhfUU9TIGlzIG5vdCBzZXQKQ09ORklHX05F
VF9WRU5ET1JfVklBPXkKIyBDT05GSUdfVklBX1JISU5FIGlzIG5vdCBzZXQKIyBDT05GSUdfVklB
X1ZFTE9DSVRZIGlzIG5vdCBzZXQKQ09ORklHX05FVF9WRU5ET1JfV0laTkVUPXkKIyBDT05GSUdf
V0laTkVUX1c1MTAwIGlzIG5vdCBzZXQKIyBDT05GSUdfV0laTkVUX1c1MzAwIGlzIG5vdCBzZXQK
IyBDT05GSUdfUEhZTElCIGlzIG5vdCBzZXQKIyBDT05GSUdfTUlDUkVMX0tTODk5NU1BIGlzIG5v
dCBzZXQKIyBDT05GSUdfUFBQIGlzIG5vdCBzZXQKIyBDT05GSUdfU0xJUCBpcyBub3Qgc2V0Cgoj
CiMgSG9zdC1zaWRlIFVTQiBzdXBwb3J0IGlzIG5lZWRlZCBmb3IgVVNCIE5ldHdvcmsgQWRhcHRl
ciBzdXBwb3J0CiMKQ09ORklHX1dMQU49eQpDT05GSUdfV0xBTl9WRU5ET1JfQURNVEVLPXkKQ09O
RklHX1dMQU5fVkVORE9SX0FUSD15CiMgQ09ORklHX0FUSF9ERUJVRyBpcyBub3Qgc2V0CkNPTkZJ
R19XTEFOX1ZFTkRPUl9BVE1FTD15CkNPTkZJR19XTEFOX1ZFTkRPUl9CUk9BRENPTT15CkNPTkZJ
R19XTEFOX1ZFTkRPUl9DSVNDTz15CkNPTkZJR19XTEFOX1ZFTkRPUl9JTlRFTD15CkNPTkZJR19X
TEFOX1ZFTkRPUl9JTlRFUlNJTD15CiMgQ09ORklHX0hPU1RBUCBpcyBub3Qgc2V0CkNPTkZJR19X
TEFOX1ZFTkRPUl9NQVJWRUxMPXkKQ09ORklHX1dMQU5fVkVORE9SX01FRElBVEVLPXkKQ09ORklH
X1dMQU5fVkVORE9SX1JBTElOSz15CkNPTkZJR19XTEFOX1ZFTkRPUl9SRUFMVEVLPXkKQ09ORklH
X1dMQU5fVkVORE9SX1JTST15CkNPTkZJR19XTEFOX1ZFTkRPUl9TVD15CkNPTkZJR19XTEFOX1ZF
TkRPUl9UST15CkNPTkZJR19XTEFOX1ZFTkRPUl9aWURBUz15CgojCiMgRW5hYmxlIFdpTUFYIChO
ZXR3b3JraW5nIG9wdGlvbnMpIHRvIHNlZSB0aGUgV2lNQVggZHJpdmVycwojCiMgQ09ORklHX1dB
TiBpcyBub3Qgc2V0CiMgQ09ORklHX0lTRE4gaXMgbm90IHNldAojIENPTkZJR19OVk0gaXMgbm90
IHNldAoKIwojIElucHV0IGRldmljZSBzdXBwb3J0CiMKQ09ORklHX0lOUFVUPXkKQ09ORklHX0lO
UFVUX0xFRFM9eQojIENPTkZJR19JTlBVVF9GRl9NRU1MRVNTIGlzIG5vdCBzZXQKIyBDT05GSUdf
SU5QVVRfUE9MTERFViBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX1NQQVJTRUtNQVAgaXMgbm90
IHNldAojIENPTkZJR19JTlBVVF9NQVRSSVhLTUFQIGlzIG5vdCBzZXQKCiMKIyBVc2VybGFuZCBp
bnRlcmZhY2VzCiMKQ09ORklHX0lOUFVUX01PVVNFREVWPXkKQ09ORklHX0lOUFVUX01PVVNFREVW
X1BTQVVYPXkKQ09ORklHX0lOUFVUX01PVVNFREVWX1NDUkVFTl9YPTEwMjQKQ09ORklHX0lOUFVU
X01PVVNFREVWX1NDUkVFTl9ZPTc2OAojIENPTkZJR19JTlBVVF9KT1lERVYgaXMgbm90IHNldAoj
IENPTkZJR19JTlBVVF9FVkRFViBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX0VWQlVHIGlzIG5v
dCBzZXQKCiMKIyBJbnB1dCBEZXZpY2UgRHJpdmVycwojCkNPTkZJR19JTlBVVF9LRVlCT0FSRD15
CiMgQ09ORklHX0tFWUJPQVJEX0FEUDU1ODggaXMgbm90IHNldAojIENPTkZJR19LRVlCT0FSRF9B
RFA1NTg5IGlzIG5vdCBzZXQKQ09ORklHX0tFWUJPQVJEX0FUS0JEPXkKIyBDT05GSUdfS0VZQk9B
UkRfUVQxMDcwIGlzIG5vdCBzZXQKIyBDT05GSUdfS0VZQk9BUkRfUVQyMTYwIGlzIG5vdCBzZXQK
IyBDT05GSUdfS0VZQk9BUkRfTEtLQkQgaXMgbm90IHNldAojIENPTkZJR19LRVlCT0FSRF9HUElP
IGlzIG5vdCBzZXQKIyBDT05GSUdfS0VZQk9BUkRfR1BJT19QT0xMRUQgaXMgbm90IHNldAojIENP
TkZJR19LRVlCT0FSRF9UQ0E2NDE2IGlzIG5vdCBzZXQKIyBDT05GSUdfS0VZQk9BUkRfVENBODQx
OCBpcyBub3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJEX01BVFJJWCBpcyBub3Qgc2V0CiMgQ09ORklH
X0tFWUJPQVJEX0xNODMyMyBpcyBub3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJEX0xNODMzMyBpcyBu
b3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJEX01BWDczNTkgaXMgbm90IHNldAojIENPTkZJR19LRVlC
T0FSRF9NQ1MgaXMgbm90IHNldAojIENPTkZJR19LRVlCT0FSRF9NUFIxMjEgaXMgbm90IHNldAoj
IENPTkZJR19LRVlCT0FSRF9ORVdUT04gaXMgbm90IHNldAojIENPTkZJR19LRVlCT0FSRF9PUEVO
Q09SRVMgaXMgbm90IHNldAojIENPTkZJR19LRVlCT0FSRF9TQU1TVU5HIGlzIG5vdCBzZXQKIyBD
T05GSUdfS0VZQk9BUkRfU1RPV0FXQVkgaXMgbm90IHNldAojIENPTkZJR19LRVlCT0FSRF9TVU5L
QkQgaXMgbm90IHNldAojIENPTkZJR19LRVlCT0FSRF9PTUFQNCBpcyBub3Qgc2V0CiMgQ09ORklH
X0tFWUJPQVJEX1hUS0JEIGlzIG5vdCBzZXQKIyBDT05GSUdfS0VZQk9BUkRfQ0FQMTFYWCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJEX0JDTSBpcyBub3Qgc2V0CkNPTkZJR19JTlBVVF9NT1VT
RT15CkNPTkZJR19NT1VTRV9QUzI9eQpDT05GSUdfTU9VU0VfUFMyX0FMUFM9eQpDT05GSUdfTU9V
U0VfUFMyX0JZRD15CkNPTkZJR19NT1VTRV9QUzJfTE9HSVBTMlBQPXkKQ09ORklHX01PVVNFX1BT
Ml9TWU5BUFRJQ1M9eQpDT05GSUdfTU9VU0VfUFMyX0NZUFJFU1M9eQpDT05GSUdfTU9VU0VfUFMy
X1RSQUNLUE9JTlQ9eQojIENPTkZJR19NT1VTRV9QUzJfRUxBTlRFQ0ggaXMgbm90IHNldAojIENP
TkZJR19NT1VTRV9QUzJfU0VOVEVMSUMgaXMgbm90IHNldAojIENPTkZJR19NT1VTRV9QUzJfVE9V
Q0hLSVQgaXMgbm90IHNldApDT05GSUdfTU9VU0VfUFMyX0ZPQ0FMVEVDSD15CiMgQ09ORklHX01P
VVNFX1NFUklBTCBpcyBub3Qgc2V0CiMgQ09ORklHX01PVVNFX0FQUExFVE9VQ0ggaXMgbm90IHNl
dAojIENPTkZJR19NT1VTRV9CQ001OTc0IGlzIG5vdCBzZXQKIyBDT05GSUdfTU9VU0VfQ1lBUEEg
aXMgbm90IHNldAojIENPTkZJR19NT1VTRV9FTEFOX0kyQyBpcyBub3Qgc2V0CiMgQ09ORklHX01P
VVNFX1ZTWFhYQUEgaXMgbm90IHNldAojIENPTkZJR19NT1VTRV9HUElPIGlzIG5vdCBzZXQKIyBD
T05GSUdfTU9VU0VfU1lOQVBUSUNTX0kyQyBpcyBub3Qgc2V0CiMgQ09ORklHX01PVVNFX1NZTkFQ
VElDU19VU0IgaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9KT1lTVElDSyBpcyBub3Qgc2V0CiMg
Q09ORklHX0lOUFVUX1RBQkxFVCBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX1RPVUNIU0NSRUVO
IGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfTUlTQyBpcyBub3Qgc2V0CiMgQ09ORklHX1JNSTRf
Q09SRSBpcyBub3Qgc2V0CgojCiMgSGFyZHdhcmUgSS9PIHBvcnRzCiMKQ09ORklHX1NFUklPPXkK
IyBDT05GSUdfU0VSSU9fU0VSUE9SVCBpcyBub3Qgc2V0CkNPTkZJR19TRVJJT19MSUJQUzI9eQoj
IENPTkZJR19TRVJJT19SQVcgaXMgbm90IHNldAojIENPTkZJR19TRVJJT19BTFRFUkFfUFMyIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0VSSU9fUFMyTVVMVCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklP
X0FSQ19QUzIgaXMgbm90IHNldAojIENPTkZJR19TRVJJT19BUEJQUzIgaXMgbm90IHNldAojIENP
TkZJR19VU0VSSU8gaXMgbm90IHNldAojIENPTkZJR19HQU1FUE9SVCBpcyBub3Qgc2V0CgojCiMg
Q2hhcmFjdGVyIGRldmljZXMKIwpDT05GSUdfVFRZPXkKQ09ORklHX1ZUPXkKQ09ORklHX0NPTlNP
TEVfVFJBTlNMQVRJT05TPXkKQ09ORklHX1ZUX0NPTlNPTEU9eQpDT05GSUdfVlRfQ09OU09MRV9T
TEVFUD15CkNPTkZJR19IV19DT05TT0xFPXkKQ09ORklHX1ZUX0hXX0NPTlNPTEVfQklORElORz15
CkNPTkZJR19VTklYOThfUFRZUz15CkNPTkZJR19MRUdBQ1lfUFRZUz15CkNPTkZJR19MRUdBQ1lf
UFRZX0NPVU5UPTE2CiMgQ09ORklHX1NFUklBTF9OT05TVEFOREFSRCBpcyBub3Qgc2V0CiMgQ09O
RklHX05fR1NNIGlzIG5vdCBzZXQKIyBDT05GSUdfVFJBQ0VfU0lOSyBpcyBub3Qgc2V0CkNPTkZJ
R19ERVZNRU09eQpDT05GSUdfREVWS01FTT15CgojCiMgU2VyaWFsIGRyaXZlcnMKIwpDT05GSUdf
U0VSSUFMX0VBUkxZQ09OPXkKQ09ORklHX1NFUklBTF84MjUwPXkKQ09ORklHX1NFUklBTF84MjUw
X0RFUFJFQ0FURURfT1BUSU9OUz15CiMgQ09ORklHX1NFUklBTF84MjUwX0ZJTlRFSyBpcyBub3Qg
c2V0CkNPTkZJR19TRVJJQUxfODI1MF9DT05TT0xFPXkKQ09ORklHX1NFUklBTF84MjUwX05SX1VB
UlRTPTQKQ09ORklHX1NFUklBTF84MjUwX1JVTlRJTUVfVUFSVFM9NApDT05GSUdfU0VSSUFMXzgy
NTBfRVhURU5ERUQ9eQpDT05GSUdfU0VSSUFMXzgyNTBfTUFOWV9QT1JUUz15CkNPTkZJR19TRVJJ
QUxfODI1MF9TSEFSRV9JUlE9eQojIENPTkZJR19TRVJJQUxfODI1MF9ERVRFQ1RfSVJRIGlzIG5v
dCBzZXQKQ09ORklHX1NFUklBTF84MjUwX1JTQT15CkNPTkZJR19TRVJJQUxfODI1MF9GU0w9eQoj
IENPTkZJR19TRVJJQUxfODI1MF9EVyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklBTF84MjUwX0VN
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSUFMXzgyNTBfUlQyODhYIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0VSSUFMX09GX1BMQVRGT1JNIGlzIG5vdCBzZXQKCiMKIyBOb24tODI1MCBzZXJpYWwgcG9y
dCBzdXBwb3J0CiMKIyBDT05GSUdfU0VSSUFMX0VBUkxZQ09OX0FSTV9TRU1JSE9TVCBpcyBub3Qg
c2V0CiMgQ09ORklHX1NFUklBTF9NQVgzMTAwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSUFMX01B
WDMxMFggaXMgbm90IHNldAojIENPTkZJR19TRVJJQUxfVUFSVExJVEUgaXMgbm90IHNldApDT05G
SUdfU0VSSUFMX0NPUkU9eQpDT05GSUdfU0VSSUFMX0NPUkVfQ09OU09MRT15CiMgQ09ORklHX1NF
UklBTF9TQ0NOWFAgaXMgbm90IHNldAojIENPTkZJR19TRVJJQUxfU0MxNklTN1hYIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0VSSUFMX0JDTTYzWFggaXMgbm90IHNldAojIENPTkZJR19TRVJJQUxfQUxU
RVJBX0pUQUdVQVJUIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSUFMX0FMVEVSQV9VQVJUIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0VSSUFMX0lGWDZYNjAgaXMgbm90IHNldAojIENPTkZJR19TRVJJQUxf
WElMSU5YX1BTX1VBUlQgaXMgbm90IHNldAojIENPTkZJR19TRVJJQUxfQVJDIGlzIG5vdCBzZXQK
IyBDT05GSUdfU0VSSUFMX0ZTTF9MUFVBUlQgaXMgbm90IHNldAojIENPTkZJR19TRVJJQUxfQ09O
RVhBTlRfRElHSUNPTE9SIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSUFMX1NUX0FTQyBpcyBub3Qg
c2V0CiMgQ09ORklHX1NFUklBTF9TVE0zMiBpcyBub3Qgc2V0CiMgQ09ORklHX0hWQ19EQ0MgaXMg
bm90IHNldAojIENPTkZJR19JUE1JX0hBTkRMRVIgaXMgbm90IHNldApDT05GSUdfSFdfUkFORE9N
PW0KIyBDT05GSUdfSFdfUkFORE9NX1RJTUVSSU9NRU0gaXMgbm90IHNldAojIENPTkZJR19SMzk2
NCBpcyBub3Qgc2V0CiMgQ09ORklHX1JBV19EUklWRVIgaXMgbm90IHNldAojIENPTkZJR19UQ0df
VFBNIGlzIG5vdCBzZXQKIyBDT05GSUdfWElMTFlCVVMgaXMgbm90IHNldAoKIwojIEkyQyBzdXBw
b3J0CiMKQ09ORklHX0kyQz15CkNPTkZJR19JMkNfQk9BUkRJTkZPPXkKQ09ORklHX0kyQ19DT01Q
QVQ9eQpDT05GSUdfSTJDX0NIQVJERVY9bQojIENPTkZJR19JMkNfTVVYIGlzIG5vdCBzZXQKQ09O
RklHX0kyQ19IRUxQRVJfQVVUTz15CgojCiMgSTJDIEhhcmR3YXJlIEJ1cyBzdXBwb3J0CiMKCiMK
IyBJMkMgc3lzdGVtIGJ1cyBkcml2ZXJzIChtb3N0bHkgZW1iZWRkZWQgLyBzeXN0ZW0tb24tY2hp
cCkKIwojIENPTkZJR19JMkNfQ0JVU19HUElPIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX0RFU0lH
TldBUkVfUExBVEZPUk0gaXMgbm90IHNldAojIENPTkZJR19JMkNfRU1FVjIgaXMgbm90IHNldAoj
IENPTkZJR19JMkNfR1BJTyBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19PQ09SRVMgaXMgbm90IHNl
dAojIENPTkZJR19JMkNfUENBX1BMQVRGT1JNIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX1BYQV9Q
Q0kgaXMgbm90IHNldAojIENPTkZJR19JMkNfUkszWCBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19T
SU1URUMgaXMgbm90IHNldAojIENPTkZJR19JMkNfWElMSU5YIGlzIG5vdCBzZXQKCiMKIyBFeHRl
cm5hbCBJMkMvU01CdXMgYWRhcHRlciBkcml2ZXJzCiMKIyBDT05GSUdfSTJDX1BBUlBPUlRfTElH
SFQgaXMgbm90IHNldAojIENPTkZJR19JMkNfVEFPU19FVk0gaXMgbm90IHNldAoKIwojIE90aGVy
IEkyQy9TTUJ1cyBidXMgZHJpdmVycwojCiMgQ09ORklHX0kyQ19TVFVCIGlzIG5vdCBzZXQKIyBD
T05GSUdfSTJDX1NMQVZFIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX0RFQlVHX0NPUkUgaXMgbm90
IHNldAojIENPTkZJR19JMkNfREVCVUdfQUxHTyBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19ERUJV
R19CVVMgaXMgbm90IHNldApDT05GSUdfU1BJPXkKIyBDT05GSUdfU1BJX0RFQlVHIGlzIG5vdCBz
ZXQKQ09ORklHX1NQSV9NQVNURVI9eQoKIwojIFNQSSBNYXN0ZXIgQ29udHJvbGxlciBEcml2ZXJz
CiMKIyBDT05GSUdfU1BJX0FMVEVSQSBpcyBub3Qgc2V0CiMgQ09ORklHX1NQSV9BWElfU1BJX0VO
R0lORSBpcyBub3Qgc2V0CiMgQ09ORklHX1NQSV9CSVRCQU5HIGlzIG5vdCBzZXQKIyBDT05GSUdf
U1BJX0NBREVOQ0UgaXMgbm90IHNldAojIENPTkZJR19TUElfREVTSUdOV0FSRSBpcyBub3Qgc2V0
CiMgQ09ORklHX1NQSV9HUElPIGlzIG5vdCBzZXQKIyBDT05GSUdfU1BJX0ZTTF9TUEkgaXMgbm90
IHNldAojIENPTkZJR19TUElfT0NfVElOWSBpcyBub3Qgc2V0CiMgQ09ORklHX1NQSV9QWEEyWFhf
UENJIGlzIG5vdCBzZXQKIyBDT05GSUdfU1BJX1JPQ0tDSElQIGlzIG5vdCBzZXQKIyBDT05GSUdf
U1BJX1NDMThJUzYwMiBpcyBub3Qgc2V0CiMgQ09ORklHX1NQSV9YQ09NTSBpcyBub3Qgc2V0CiMg
Q09ORklHX1NQSV9YSUxJTlggaXMgbm90IHNldAojIENPTkZJR19TUElfWllOUU1QX0dRU1BJIGlz
IG5vdCBzZXQKCiMKIyBTUEkgUHJvdG9jb2wgTWFzdGVycwojCiMgQ09ORklHX1NQSV9TUElERVYg
aXMgbm90IHNldAojIENPTkZJR19TUElfTE9PUEJBQ0tfVEVTVCBpcyBub3Qgc2V0CiMgQ09ORklH
X1NQSV9UTEU2MlgwIGlzIG5vdCBzZXQKIyBDT05GSUdfU1BNSSBpcyBub3Qgc2V0CiMgQ09ORklH
X0hTSSBpcyBub3Qgc2V0CgojCiMgUFBTIHN1cHBvcnQKIwojIENPTkZJR19QUFMgaXMgbm90IHNl
dAoKIwojIFBQUyBnZW5lcmF0b3JzIHN1cHBvcnQKIwoKIwojIFBUUCBjbG9jayBzdXBwb3J0CiMK
IyBDT05GSUdfUFRQXzE1ODhfQ0xPQ0sgaXMgbm90IHNldAoKIwojIEVuYWJsZSBQSFlMSUIgYW5k
IE5FVFdPUktfUEhZX1RJTUVTVEFNUElORyB0byBzZWUgdGhlIGFkZGl0aW9uYWwgY2xvY2tzLgoj
CkNPTkZJR19QSU5DVFJMPXkKCiMKIyBQaW4gY29udHJvbGxlcnMKIwpDT05GSUdfUElOTVVYPXkK
Q09ORklHX1BJTkNPTkY9eQpDT05GSUdfR0VORVJJQ19QSU5DT05GPXkKIyBDT05GSUdfREVCVUdf
UElOQ1RSTCBpcyBub3Qgc2V0CiMgQ09ORklHX1BJTkNUUkxfQU1EIGlzIG5vdCBzZXQKQ09ORklH
X1BJTkNUUkxfT1hOQVM9eQojIENPTkZJR19QSU5DVFJMX1NJTkdMRSBpcyBub3Qgc2V0CkNPTkZJ
R19BUkNIX0hBVkVfQ1VTVE9NX0dQSU9fSD15CkNPTkZJR19HUElPTElCPXkKQ09ORklHX09GX0dQ
SU89eQpDT05GSUdfR1BJT0xJQl9JUlFDSElQPXkKIyBDT05GSUdfREVCVUdfR1BJTyBpcyBub3Qg
c2V0CiMgQ09ORklHX0dQSU9fU1lTRlMgaXMgbm90IHNldAoKIwojIE1lbW9yeSBtYXBwZWQgR1BJ
TyBkcml2ZXJzCiMKIyBDT05GSUdfR1BJT183NFhYX01NSU8gaXMgbm90IHNldAojIENPTkZJR19H
UElPX0FMVEVSQSBpcyBub3Qgc2V0CiMgQ09ORklHX0dQSU9fRFdBUEIgaXMgbm90IHNldAojIENP
TkZJR19HUElPX0VNIGlzIG5vdCBzZXQKIyBDT05GSUdfR1BJT19HRU5FUklDX1BMQVRGT1JNIGlz
IG5vdCBzZXQKIyBDT05GSUdfR1BJT19HUkdQSU8gaXMgbm90IHNldAojIENPTkZJR19HUElPX01P
Q0tVUCBpcyBub3Qgc2V0CiMgQ09ORklHX0dQSU9fTVBDOFhYWCBpcyBub3Qgc2V0CiMgQ09ORklH
X0dQSU9fU1lTQ09OIGlzIG5vdCBzZXQKIyBDT05GSUdfR1BJT19YSUxJTlggaXMgbm90IHNldAoj
IENPTkZJR19HUElPX1pFVklPIGlzIG5vdCBzZXQKIyBDT05GSUdfR1BJT19aWCBpcyBub3Qgc2V0
CgojCiMgSTJDIEdQSU8gZXhwYW5kZXJzCiMKIyBDT05GSUdfR1BJT19BRFA1NTg4IGlzIG5vdCBz
ZXQKIyBDT05GSUdfR1BJT19BRE5QIGlzIG5vdCBzZXQKIyBDT05GSUdfR1BJT19NQVg3MzAwIGlz
IG5vdCBzZXQKIyBDT05GSUdfR1BJT19NQVg3MzJYIGlzIG5vdCBzZXQKIyBDT05GSUdfR1BJT19Q
Q0E5NTNYIGlzIG5vdCBzZXQKIyBDT05GSUdfR1BJT19QQ0Y4NTdYIGlzIG5vdCBzZXQKIyBDT05G
SUdfR1BJT19TWDE1MFggaXMgbm90IHNldAojIENPTkZJR19HUElPX1RQSUMyODEwIGlzIG5vdCBz
ZXQKIyBDT05GSUdfR1BJT19UUzQ5MDAgaXMgbm90IHNldAoKIwojIE1GRCBHUElPIGV4cGFuZGVy
cwojCiMgQ09ORklHX0hUQ19FR1BJTyBpcyBub3Qgc2V0CgojCiMgU1BJIEdQSU8gZXhwYW5kZXJz
CiMKIyBDT05GSUdfR1BJT183NFgxNjQgaXMgbm90IHNldAojIENPTkZJR19HUElPX01BWDczMDEg
aXMgbm90IHNldAojIENPTkZJR19HUElPX01DMzM4ODAgaXMgbm90IHNldAojIENPTkZJR19HUElP
X1BJU09TUiBpcyBub3Qgc2V0CgojCiMgU1BJIG9yIEkyQyBHUElPIGV4cGFuZGVycwojCiMgQ09O
RklHX0dQSU9fTUNQMjNTMDggaXMgbm90IHNldAojIENPTkZJR19XMSBpcyBub3Qgc2V0CiMgQ09O
RklHX1BPV0VSX0FWUyBpcyBub3Qgc2V0CkNPTkZJR19QT1dFUl9SRVNFVD15CiMgQ09ORklHX1BP
V0VSX1JFU0VUX0JSQ01LT05BIGlzIG5vdCBzZXQKIyBDT05GSUdfUE9XRVJfUkVTRVRfQlJDTVNU
QiBpcyBub3Qgc2V0CiMgQ09ORklHX1BPV0VSX1JFU0VUX0dQSU8gaXMgbm90IHNldAojIENPTkZJ
R19QT1dFUl9SRVNFVF9HUElPX1JFU1RBUlQgaXMgbm90IHNldAojIENPTkZJR19QT1dFUl9SRVNF
VF9MVEMyOTUyIGlzIG5vdCBzZXQKIyBDT05GSUdfUE9XRVJfUkVTRVRfUkVTVEFSVCBpcyBub3Qg
c2V0CkNPTkZJR19QT1dFUl9SRVNFVF9WRVJTQVRJTEU9eQojIENPTkZJR19QT1dFUl9SRVNFVF9T
WVNDT04gaXMgbm90IHNldAojIENPTkZJR19QT1dFUl9SRVNFVF9TWVNDT05fUE9XRVJPRkYgaXMg
bm90IHNldAojIENPTkZJR19TWVNDT05fUkVCT09UX01PREUgaXMgbm90IHNldAojIENPTkZJR19Q
T1dFUl9TVVBQTFkgaXMgbm90IHNldAojIENPTkZJR19IV01PTiBpcyBub3Qgc2V0CiMgQ09ORklH
X1RIRVJNQUwgaXMgbm90IHNldAojIENPTkZJR19XQVRDSERPRyBpcyBub3Qgc2V0CkNPTkZJR19T
U0JfUE9TU0lCTEU9eQoKIwojIFNvbmljcyBTaWxpY29uIEJhY2twbGFuZQojCiMgQ09ORklHX1NT
QiBpcyBub3Qgc2V0CkNPTkZJR19CQ01BX1BPU1NJQkxFPXkKCiMKIyBCcm9hZGNvbSBzcGVjaWZp
YyBBTUJBCiMKIyBDT05GSUdfQkNNQSBpcyBub3Qgc2V0CgojCiMgTXVsdGlmdW5jdGlvbiBkZXZp
Y2UgZHJpdmVycwojCiMgQ09ORklHX01GRF9DT1JFIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0FD
VDg5NDVBIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0FTMzcxMSBpcyBub3Qgc2V0CiMgQ09ORklH
X01GRF9BUzM3MjIgaXMgbm90IHNldAojIENPTkZJR19QTUlDX0FEUDU1MjAgaXMgbm90IHNldAoj
IENPTkZJR19NRkRfQUFUMjg3MF9DT1JFIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0FUTUVMX0ZM
RVhDT00gaXMgbm90IHNldAojIENPTkZJR19NRkRfQVRNRUxfSExDREMgaXMgbm90IHNldAojIENP
TkZJR19NRkRfQkNNNTkwWFggaXMgbm90IHNldAojIENPTkZJR19NRkRfQVhQMjBYX0kyQyBpcyBu
b3Qgc2V0CiMgQ09ORklHX01GRF9DUk9TX0VDIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0FTSUMz
IGlzIG5vdCBzZXQKIyBDT05GSUdfUE1JQ19EQTkwM1ggaXMgbm90IHNldAojIENPTkZJR19NRkRf
REE5MDUyX1NQSSBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9EQTkwNTJfSTJDIGlzIG5vdCBzZXQK
IyBDT05GSUdfTUZEX0RBOTA1NSBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9EQTkwNjIgaXMgbm90
IHNldAojIENPTkZJR19NRkRfREE5MDYzIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0RBOTE1MCBp
cyBub3Qgc2V0CiMgQ09ORklHX01GRF9FWFlOT1NfTFBBU1MgaXMgbm90IHNldAojIENPTkZJR19N
RkRfTUMxM1hYWF9TUEkgaXMgbm90IHNldAojIENPTkZJR19NRkRfTUMxM1hYWF9JMkMgaXMgbm90
IHNldAojIENPTkZJR19NRkRfSEk2NDIxX1BNSUMgaXMgbm90IHNldAojIENPTkZJR19IVENfUEFT
SUMzIGlzIG5vdCBzZXQKIyBDT05GSUdfSFRDX0kyQ1BMRCBpcyBub3Qgc2V0CiMgQ09ORklHX0lO
VEVMX1NPQ19QTUlDIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0tFTVBMRCBpcyBub3Qgc2V0CiMg
Q09ORklHX01GRF84OFBNODAwIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEXzg4UE04MDUgaXMgbm90
IHNldAojIENPTkZJR19NRkRfODhQTTg2MFggaXMgbm90IHNldAojIENPTkZJR19NRkRfTUFYMTQ1
NzcgaXMgbm90IHNldAojIENPTkZJR19NRkRfTUFYNzc2MjAgaXMgbm90IHNldAojIENPTkZJR19N
RkRfTUFYNzc2ODYgaXMgbm90IHNldAojIENPTkZJR19NRkRfTUFYNzc2OTMgaXMgbm90IHNldAoj
IENPTkZJR19NRkRfTUFYNzc4NDMgaXMgbm90IHNldAojIENPTkZJR19NRkRfTUFYODkwNyBpcyBu
b3Qgc2V0CiMgQ09ORklHX01GRF9NQVg4OTI1IGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX01BWDg5
OTcgaXMgbm90IHNldAojIENPTkZJR19NRkRfTUFYODk5OCBpcyBub3Qgc2V0CiMgQ09ORklHX01G
RF9NVDYzOTcgaXMgbm90IHNldAojIENPTkZJR19NRkRfTUVORjIxQk1DIGlzIG5vdCBzZXQKIyBD
T05GSUdfRVpYX1BDQVAgaXMgbm90IHNldAojIENPTkZJR19NRkRfUkVUVSBpcyBub3Qgc2V0CiMg
Q09ORklHX01GRF9QQ0Y1MDYzMyBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9QTTg5MjFfQ09SRSBp
cyBub3Qgc2V0CiMgQ09ORklHX01GRF9SVDUwMzMgaXMgbm90IHNldAojIENPTkZJR19NRkRfUkM1
VDU4MyBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9SSzgwOCBpcyBub3Qgc2V0CiMgQ09ORklHX01G
RF9STjVUNjE4IGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1NFQ19DT1JFIGlzIG5vdCBzZXQKIyBD
T05GSUdfTUZEX1NJNDc2WF9DT1JFIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1NNNTAxIGlzIG5v
dCBzZXQKIyBDT05GSUdfTUZEX1NLWTgxNDUyIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1NNU0Mg
aXMgbm90IHNldAojIENPTkZJR19BQlg1MDBfQ09SRSBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9T
VE1QRSBpcyBub3Qgc2V0CkNPTkZJR19NRkRfU1lTQ09OPXkKIyBDT05GSUdfTUZEX1RJX0FNMzM1
WF9UU0NBREMgaXMgbm90IHNldAojIENPTkZJR19NRkRfTFAzOTQzIGlzIG5vdCBzZXQKIyBDT05G
SUdfTUZEX0xQODc4OCBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9QQUxNQVMgaXMgbm90IHNldAoj
IENPTkZJR19UUFM2MTA1WCBpcyBub3Qgc2V0CiMgQ09ORklHX1RQUzY1MDEwIGlzIG5vdCBzZXQK
IyBDT05GSUdfVFBTNjUwN1ggaXMgbm90IHNldAojIENPTkZJR19NRkRfVFBTNjUwODYgaXMgbm90
IHNldAojIENPTkZJR19NRkRfVFBTNjUwOTAgaXMgbm90IHNldAojIENPTkZJR19NRkRfVFBTNjUy
MTcgaXMgbm90IHNldAojIENPTkZJR19NRkRfVElfTFA4NzNYIGlzIG5vdCBzZXQKIyBDT05GSUdf
TUZEX1RQUzY1MjE4IGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1RQUzY1ODZYIGlzIG5vdCBzZXQK
IyBDT05GSUdfTUZEX1RQUzY1OTEwIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1RQUzY1OTEyX0ky
QyBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9UUFM2NTkxMl9TUEkgaXMgbm90IHNldAojIENPTkZJ
R19NRkRfVFBTODAwMzEgaXMgbm90IHNldAojIENPTkZJR19UV0w0MDMwX0NPUkUgaXMgbm90IHNl
dAojIENPTkZJR19UV0w2MDQwX0NPUkUgaXMgbm90IHNldAojIENPTkZJR19NRkRfV0wxMjczX0NP
UkUgaXMgbm90IHNldAojIENPTkZJR19NRkRfTE0zNTMzIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZE
X1RDMzU4OVggaXMgbm90IHNldAojIENPTkZJR19NRkRfVE1JTyBpcyBub3Qgc2V0CiMgQ09ORklH
X01GRF9UN0w2NlhCIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1RDNjM4N1hCIGlzIG5vdCBzZXQK
IyBDT05GSUdfTUZEX1RDNjM5M1hCIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0FSSVpPTkFfSTJD
IGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0FSSVpPTkFfU1BJIGlzIG5vdCBzZXQKIyBDT05GSUdf
TUZEX1dNODQwMCBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9XTTgzMVhfSTJDIGlzIG5vdCBzZXQK
IyBDT05GSUdfTUZEX1dNODMxWF9TUEkgaXMgbm90IHNldAojIENPTkZJR19NRkRfV004MzUwX0ky
QyBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9XTTg5OTQgaXMgbm90IHNldAojIENPTkZJR19SRUdV
TEFUT1IgaXMgbm90IHNldAojIENPTkZJR19NRURJQV9TVVBQT1JUIGlzIG5vdCBzZXQKCiMKIyBH
cmFwaGljcyBzdXBwb3J0CiMKIyBDT05GSUdfSU1YX0lQVVYzX0NPUkUgaXMgbm90IHNldAojIENP
TkZJR19EUk0gaXMgbm90IHNldAoKIwojIEFDUCAoQXVkaW8gQ29Qcm9jZXNzb3IpIENvbmZpZ3Vy
YXRpb24KIwoKIwojIEZyYW1lIGJ1ZmZlciBEZXZpY2VzCiMKQ09ORklHX0ZCPXkKIyBDT05GSUdf
RklSTVdBUkVfRURJRCBpcyBub3Qgc2V0CkNPTkZJR19GQl9DTURMSU5FPXkKQ09ORklHX0ZCX05P
VElGWT15CiMgQ09ORklHX0ZCX0REQyBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX0JPT1RfVkVTQV9T
VVBQT1JUIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfQ0ZCX0ZJTExSRUNUIGlzIG5vdCBzZXQKIyBD
T05GSUdfRkJfQ0ZCX0NPUFlBUkVBIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfQ0ZCX0lNQUdFQkxJ
VCBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX0NGQl9SRVZfUElYRUxTX0lOX0JZVEUgaXMgbm90IHNl
dAojIENPTkZJR19GQl9TWVNfRklMTFJFQ1QgaXMgbm90IHNldAojIENPTkZJR19GQl9TWVNfQ09Q
WUFSRUEgaXMgbm90IHNldAojIENPTkZJR19GQl9TWVNfSU1BR0VCTElUIGlzIG5vdCBzZXQKIyBD
T05GSUdfRkJfRk9SRUlHTl9FTkRJQU4gaXMgbm90IHNldAojIENPTkZJR19GQl9TWVNfRk9QUyBp
cyBub3Qgc2V0CiMgQ09ORklHX0ZCX1NWR0FMSUIgaXMgbm90IHNldAojIENPTkZJR19GQl9NQUNN
T0RFUyBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX0JBQ0tMSUdIVCBpcyBub3Qgc2V0CkNPTkZJR19G
Ql9NT0RFX0hFTFBFUlM9eQojIENPTkZJR19GQl9USUxFQkxJVFRJTkcgaXMgbm90IHNldAoKIwoj
IEZyYW1lIGJ1ZmZlciBoYXJkd2FyZSBkcml2ZXJzCiMKIyBDT05GSUdfRkJfT1BFTkNPUkVTIGlz
IG5vdCBzZXQKIyBDT05GSUdfRkJfUzFEMTNYWFggaXMgbm90IHNldAojIENPTkZJR19GQl9JQk1f
R1hUNDUwMCBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX1ZJUlRVQUwgaXMgbm90IHNldAojIENPTkZJ
R19GQl9NRVRST05PTUUgaXMgbm90IHNldAojIENPTkZJR19GQl9CUk9BRFNIRUVUIGlzIG5vdCBz
ZXQKIyBDT05GSUdfRkJfQVVPX0sxOTBYIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfU0lNUExFIGlz
IG5vdCBzZXQKIyBDT05GSUdfRkJfU1NEMTMwNyBpcyBub3Qgc2V0CkNPTkZJR19CQUNLTElHSFRf
TENEX1NVUFBPUlQ9eQpDT05GSUdfTENEX0NMQVNTX0RFVklDRT1tCiMgQ09ORklHX0xDRF9MNEYw
MDI0MlQwMyBpcyBub3Qgc2V0CiMgQ09ORklHX0xDRF9MTVMyODNHRjA1IGlzIG5vdCBzZXQKIyBD
T05GSUdfTENEX0xUVjM1MFFWIGlzIG5vdCBzZXQKIyBDT05GSUdfTENEX0lMSTkyMlggaXMgbm90
IHNldAojIENPTkZJR19MQ0RfSUxJOTMyMCBpcyBub3Qgc2V0CiMgQ09ORklHX0xDRF9URE8yNE0g
aXMgbm90IHNldAojIENPTkZJR19MQ0RfVkdHMjQzMkE0IGlzIG5vdCBzZXQKIyBDT05GSUdfTENE
X1BMQVRGT1JNIGlzIG5vdCBzZXQKIyBDT05GSUdfTENEX1M2RTYzTTAgaXMgbm90IHNldAojIENP
TkZJR19MQ0RfTEQ5MDQwIGlzIG5vdCBzZXQKIyBDT05GSUdfTENEX0FNUzM2OUZHMDYgaXMgbm90
IHNldAojIENPTkZJR19MQ0RfTE1TNTAxS0YwMyBpcyBub3Qgc2V0CiMgQ09ORklHX0xDRF9IWDgz
NTcgaXMgbm90IHNldApDT05GSUdfQkFDS0xJR0hUX0NMQVNTX0RFVklDRT15CkNPTkZJR19CQUNL
TElHSFRfR0VORVJJQz15CiMgQ09ORklHX0JBQ0tMSUdIVF9QTTg5NDFfV0xFRCBpcyBub3Qgc2V0
CiMgQ09ORklHX0JBQ0tMSUdIVF9BRFA4ODYwIGlzIG5vdCBzZXQKIyBDT05GSUdfQkFDS0xJR0hU
X0FEUDg4NzAgaXMgbm90IHNldAojIENPTkZJR19CQUNLTElHSFRfTE0zNjM5IGlzIG5vdCBzZXQK
IyBDT05GSUdfQkFDS0xJR0hUX0dQSU8gaXMgbm90IHNldAojIENPTkZJR19CQUNLTElHSFRfTFY1
MjA3TFAgaXMgbm90IHNldAojIENPTkZJR19CQUNLTElHSFRfQkQ2MTA3IGlzIG5vdCBzZXQKIyBD
T05GSUdfVkdBU1RBVEUgaXMgbm90IHNldAoKIwojIENvbnNvbGUgZGlzcGxheSBkcml2ZXIgc3Vw
cG9ydAojCkNPTkZJR19EVU1NWV9DT05TT0xFPXkKQ09ORklHX0ZSQU1FQlVGRkVSX0NPTlNPTEU9
eQojIENPTkZJR19GUkFNRUJVRkZFUl9DT05TT0xFX0RFVEVDVF9QUklNQVJZIGlzIG5vdCBzZXQK
IyBDT05GSUdfRlJBTUVCVUZGRVJfQ09OU09MRV9ST1RBVElPTiBpcyBub3Qgc2V0CiMgQ09ORklH
X0xPR08gaXMgbm90IHNldApDT05GSUdfU09VTkQ9eQpDT05GSUdfU09VTkRfT1NTX0NPUkU9eQpD
T05GSUdfU09VTkRfT1NTX0NPUkVfUFJFQ0xBSU09eQpDT05GSUdfU05EPW0KQ09ORklHX1NORF9U
SU1FUj1tCkNPTkZJR19TTkRfUENNPW0KIyBDT05GSUdfU05EX1NFUVVFTkNFUiBpcyBub3Qgc2V0
CkNPTkZJR19TTkRfT1NTRU1VTD15CkNPTkZJR19TTkRfTUlYRVJfT1NTPW0KQ09ORklHX1NORF9Q
Q01fT1NTPW0KQ09ORklHX1NORF9QQ01fT1NTX1BMVUdJTlM9eQpDT05GSUdfU05EX1BDTV9USU1F
Uj15CiMgQ09ORklHX1NORF9IUlRJTUVSIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0RZTkFNSUNf
TUlOT1JTIGlzIG5vdCBzZXQKQ09ORklHX1NORF9TVVBQT1JUX09MRF9BUEk9eQpDT05GSUdfU05E
X1BST0NfRlM9eQpDT05GSUdfU05EX1ZFUkJPU0VfUFJPQ0ZTPXkKIyBDT05GSUdfU05EX1ZFUkJP
U0VfUFJJTlRLIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05G
SUdfU05EX1JBV01JRElfU0VRIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX09QTDNfTElCX1NFUSBp
cyBub3Qgc2V0CiMgQ09ORklHX1NORF9PUEw0X0xJQl9TRVEgaXMgbm90IHNldAojIENPTkZJR19T
TkRfU0JBV0VfU0VRIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0VNVTEwSzFfU0VRIGlzIG5vdCBz
ZXQKQ09ORklHX1NORF9EUklWRVJTPXkKIyBDT05GSUdfU05EX0RVTU1ZIGlzIG5vdCBzZXQKIyBD
T05GSUdfU05EX0FMT09QIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX01UUEFWIGlzIG5vdCBzZXQK
IyBDT05GSUdfU05EX1NFUklBTF9VMTY1NTAgaXMgbm90IHNldAojIENPTkZJR19TTkRfTVBVNDAx
IGlzIG5vdCBzZXQKCiMKIyBIRC1BdWRpbwojCkNPTkZJR19TTkRfSERBX1BSRUFMTE9DX1NJWkU9
NjQKQ09ORklHX1NORF9BUk09eQpDT05GSUdfU05EX1NQST15CiMgQ09ORklHX1NORF9TT0MgaXMg
bm90IHNldAojIENPTkZJR19TT1VORF9QUklNRSBpcyBub3Qgc2V0CgojCiMgSElEIHN1cHBvcnQK
IwpDT05GSUdfSElEPXkKIyBDT05GSUdfSElEX0JBVFRFUllfU1RSRU5HVEggaXMgbm90IHNldAoj
IENPTkZJR19ISURSQVcgaXMgbm90IHNldAojIENPTkZJR19VSElEIGlzIG5vdCBzZXQKQ09ORklH
X0hJRF9HRU5FUklDPXkKCiMKIyBTcGVjaWFsIEhJRCBkcml2ZXJzCiMKQ09ORklHX0hJRF9BNFRF
Q0g9eQojIENPTkZJR19ISURfQUNSVVggaXMgbm90IHNldApDT05GSUdfSElEX0FQUExFPXkKIyBD
T05GSUdfSElEX0FVUkVBTCBpcyBub3Qgc2V0CkNPTkZJR19ISURfQkVMS0lOPXkKQ09ORklHX0hJ
RF9DSEVSUlk9eQpDT05GSUdfSElEX0NISUNPTlk9eQojIENPTkZJR19ISURfUFJPRElLRVlTIGlz
IG5vdCBzZXQKIyBDT05GSUdfSElEX0NNRURJQSBpcyBub3Qgc2V0CkNPTkZJR19ISURfQ1lQUkVT
Uz15CiMgQ09ORklHX0hJRF9EUkFHT05SSVNFIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0VNU19G
RiBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9FTEVDT00gaXMgbm90IHNldApDT05GSUdfSElEX0Va
S0VZPXkKIyBDT05GSUdfSElEX0dFTUJJUkQgaXMgbm90IHNldAojIENPTkZJR19ISURfR0ZSTSBp
cyBub3Qgc2V0CiMgQ09ORklHX0hJRF9LRVlUT1VDSCBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9L
WUUgaXMgbm90IHNldAojIENPTkZJR19ISURfV0FMVE9QIGlzIG5vdCBzZXQKIyBDT05GSUdfSElE
X0dZUkFUSU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0lDQURFIGlzIG5vdCBzZXQKIyBDT05G
SUdfSElEX1RXSU5IQU4gaXMgbm90IHNldApDT05GSUdfSElEX0tFTlNJTkdUT049eQojIENPTkZJ
R19ISURfTENQT1dFUiBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9MRUQgaXMgbm90IHNldAojIENP
TkZJR19ISURfTEVOT1ZPIGlzIG5vdCBzZXQKQ09ORklHX0hJRF9MT0dJVEVDSD15CiMgQ09ORklH
X0hJRF9MT0dJVEVDSF9ISURQUCBpcyBub3Qgc2V0CiMgQ09ORklHX0xPR0lURUNIX0ZGIGlzIG5v
dCBzZXQKIyBDT05GSUdfTE9HSVJVTUJMRVBBRDJfRkYgaXMgbm90IHNldAojIENPTkZJR19MT0dJ
Rzk0MF9GRiBpcyBub3Qgc2V0CiMgQ09ORklHX0xPR0lXSEVFTFNfRkYgaXMgbm90IHNldAojIENP
TkZJR19ISURfTUFHSUNNT1VTRSBpcyBub3Qgc2V0CkNPTkZJR19ISURfTUlDUk9TT0ZUPXkKQ09O
RklHX0hJRF9NT05URVJFWT15CiMgQ09ORklHX0hJRF9NVUxUSVRPVUNIIGlzIG5vdCBzZXQKIyBD
T05GSUdfSElEX09SVEVLIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1BBTlRIRVJMT1JEIGlzIG5v
dCBzZXQKIyBDT05GSUdfSElEX1BFVEFMWU5YIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1BJQ09M
Q0QgaXMgbm90IHNldAojIENPTkZJR19ISURfUExBTlRST05JQ1MgaXMgbm90IHNldAojIENPTkZJ
R19ISURfUFJJTUFYIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1NBSVRFSyBpcyBub3Qgc2V0CiMg
Q09ORklHX0hJRF9TQU1TVU5HIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1NQRUVETElOSyBpcyBu
b3Qgc2V0CiMgQ09ORklHX0hJRF9TVEVFTFNFUklFUyBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9T
VU5QTFVTIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1JNSSBpcyBub3Qgc2V0CiMgQ09ORklHX0hJ
RF9HUkVFTkFTSUEgaXMgbm90IHNldAojIENPTkZJR19ISURfU01BUlRKT1lQTFVTIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSElEX1RJVk8gaXMgbm90IHNldAojIENPTkZJR19ISURfVE9QU0VFRCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0hJRF9USElOR00gaXMgbm90IHNldAojIENPTkZJR19ISURfVEhSVVNU
TUFTVEVSIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1dBQ09NIGlzIG5vdCBzZXQKIyBDT05GSUdf
SElEX1dJSU1PVEUgaXMgbm90IHNldAojIENPTkZJR19ISURfWElOTU8gaXMgbm90IHNldAojIENP
TkZJR19ISURfWkVST1BMVVMgaXMgbm90IHNldAojIENPTkZJR19ISURfWllEQUNST04gaXMgbm90
IHNldAojIENPTkZJR19ISURfU0VOU09SX0hVQiBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9BTFBT
IGlzIG5vdCBzZXQKCiMKIyBJMkMgSElEIHN1cHBvcnQKIwojIENPTkZJR19JMkNfSElEIGlzIG5v
dCBzZXQKQ09ORklHX1VTQl9PSENJX0xJVFRMRV9FTkRJQU49eQpDT05GSUdfVVNCX1NVUFBPUlQ9
eQpDT05GSUdfVVNCX0FSQ0hfSEFTX0hDRD15CiMgQ09ORklHX1VTQiBpcyBub3Qgc2V0CgojCiMg
VVNCIHBvcnQgZHJpdmVycwojCgojCiMgVVNCIFBoeXNpY2FsIExheWVyIGRyaXZlcnMKIwojIENP
TkZJR19VU0JfUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfTk9QX1VTQl9YQ0VJViBpcyBub3Qgc2V0
CiMgQ09ORklHX1VTQl9HUElPX1ZCVVMgaXMgbm90IHNldAojIENPTkZJR19VU0JfVUxQSSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1VTQl9HQURHRVQgaXMgbm90IHNldAojIENPTkZJR19VU0JfTEVEX1RS
SUcgaXMgbm90IHNldAojIENPTkZJR19VU0JfVUxQSV9CVVMgaXMgbm90IHNldAojIENPTkZJR19V
V0IgaXMgbm90IHNldApDT05GSUdfTU1DPXkKIyBDT05GSUdfTU1DX0RFQlVHIGlzIG5vdCBzZXQK
Q09ORklHX1BXUlNFUV9FTU1DPXkKQ09ORklHX1BXUlNFUV9TSU1QTEU9eQoKIwojIE1NQy9TRC9T
RElPIENhcmQgRHJpdmVycwojCkNPTkZJR19NTUNfQkxPQ0s9eQpDT05GSUdfTU1DX0JMT0NLX01J
Tk9SUz04CkNPTkZJR19NTUNfQkxPQ0tfQk9VTkNFPXkKIyBDT05GSUdfU0RJT19VQVJUIGlzIG5v
dCBzZXQKIyBDT05GSUdfTU1DX1RFU1QgaXMgbm90IHNldAoKIwojIE1NQy9TRC9TRElPIEhvc3Qg
Q29udHJvbGxlciBEcml2ZXJzCiMKIyBDT05GSUdfTU1DX1NESENJIGlzIG5vdCBzZXQKIyBDT05G
SUdfTU1DX1NQSSBpcyBub3Qgc2V0CiMgQ09ORklHX01NQ19EVyBpcyBub3Qgc2V0CiMgQ09ORklH
X01NQ19VU0RISTZST0wwIGlzIG5vdCBzZXQKIyBDT05GSUdfTU1DX01USyBpcyBub3Qgc2V0CiMg
Q09ORklHX01FTVNUSUNLIGlzIG5vdCBzZXQKQ09ORklHX05FV19MRURTPXkKQ09ORklHX0xFRFNf
Q0xBU1M9eQojIENPTkZJR19MRURTX0NMQVNTX0ZMQVNIIGlzIG5vdCBzZXQKCiMKIyBMRUQgZHJp
dmVycwojCiMgQ09ORklHX0xFRFNfQkNNNjMyOCBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfQkNN
NjM1OCBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfTE0zNTMwIGlzIG5vdCBzZXQKIyBDT05GSUdf
TEVEU19MTTM2NDIgaXMgbm90IHNldAojIENPTkZJR19MRURTX1BDQTk1MzIgaXMgbm90IHNldAoj
IENPTkZJR19MRURTX0dQSU8gaXMgbm90IHNldAojIENPTkZJR19MRURTX0xQMzk0NCBpcyBub3Qg
c2V0CiMgQ09ORklHX0xFRFNfTFA1NTIxIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19MUDU1MjMg
aXMgbm90IHNldAojIENPTkZJR19MRURTX0xQNTU2MiBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNf
TFA4NTAxIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19MUDg4NjAgaXMgbm90IHNldAojIENPTkZJ
R19MRURTX1BDQTk1NVggaXMgbm90IHNldAojIENPTkZJR19MRURTX1BDQTk2M1ggaXMgbm90IHNl
dAojIENPTkZJR19MRURTX0RBQzEyNFMwODUgaXMgbm90IHNldAojIENPTkZJR19MRURTX0JEMjgw
MiBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfTFQzNTkzIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVE
U19UQ0E2NTA3IGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19UTEM1OTFYWCBpcyBub3Qgc2V0CiMg
Q09ORklHX0xFRFNfTE0zNTV4IGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19JUzMxRkwzMTlYIGlz
IG5vdCBzZXQKIyBDT05GSUdfTEVEU19JUzMxRkwzMlhYIGlzIG5vdCBzZXQKCiMKIyBMRUQgZHJp
dmVyIGZvciBibGluaygxKSBVU0IgUkdCIExFRCBpcyB1bmRlciBTcGVjaWFsIEhJRCBkcml2ZXJz
IChISURfVEhJTkdNKQojCiMgQ09ORklHX0xFRFNfQkxJTktNIGlzIG5vdCBzZXQKQ09ORklHX0xF
RFNfU1lTQ09OPXkKCiMKIyBMRUQgVHJpZ2dlcnMKIwpDT05GSUdfTEVEU19UUklHR0VSUz15CiMg
Q09ORklHX0xFRFNfVFJJR0dFUl9USU1FUiBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfVFJJR0dF
Ul9PTkVTSE9UIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19UUklHR0VSX01URCBpcyBub3Qgc2V0
CkNPTkZJR19MRURTX1RSSUdHRVJfSEVBUlRCRUFUPXkKIyBDT05GSUdfTEVEU19UUklHR0VSX0JB
Q0tMSUdIVCBpcyBub3Qgc2V0CkNPTkZJR19MRURTX1RSSUdHRVJfQ1BVPXkKIyBDT05GSUdfTEVE
U19UUklHR0VSX0dQSU8gaXMgbm90IHNldAojIENPTkZJR19MRURTX1RSSUdHRVJfREVGQVVMVF9P
TiBpcyBub3Qgc2V0CgojCiMgaXB0YWJsZXMgdHJpZ2dlciBpcyB1bmRlciBOZXRmaWx0ZXIgY29u
ZmlnIChMRUQgdGFyZ2V0KQojCiMgQ09ORklHX0xFRFNfVFJJR0dFUl9UUkFOU0lFTlQgaXMgbm90
IHNldAojIENPTkZJR19MRURTX1RSSUdHRVJfQ0FNRVJBIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVE
U19UUklHR0VSX1BBTklDIGlzIG5vdCBzZXQKIyBDT05GSUdfQUNDRVNTSUJJTElUWSBpcyBub3Qg
c2V0CkNPTkZJR19FREFDX0FUT01JQ19TQ1JVQj15CkNPTkZJR19FREFDX1NVUFBPUlQ9eQojIENP
TkZJR19FREFDIGlzIG5vdCBzZXQKQ09ORklHX1JUQ19MSUI9eQpDT05GSUdfUlRDX0NMQVNTPXkK
Q09ORklHX1JUQ19IQ1RPU1lTPXkKQ09ORklHX1JUQ19IQ1RPU1lTX0RFVklDRT0icnRjMCIKQ09O
RklHX1JUQ19TWVNUT0hDPXkKQ09ORklHX1JUQ19TWVNUT0hDX0RFVklDRT0icnRjMCIKIyBDT05G
SUdfUlRDX0RFQlVHIGlzIG5vdCBzZXQKCiMKIyBSVEMgaW50ZXJmYWNlcwojCkNPTkZJR19SVENf
SU5URl9TWVNGUz15CkNPTkZJR19SVENfSU5URl9QUk9DPXkKQ09ORklHX1JUQ19JTlRGX0RFVj15
CiMgQ09ORklHX1JUQ19JTlRGX0RFVl9VSUVfRU1VTCBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19E
UlZfVEVTVCBpcyBub3Qgc2V0CgojCiMgSTJDIFJUQyBkcml2ZXJzCiMKIyBDT05GSUdfUlRDX0RS
Vl9BQkI1WkVTMyBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfQUJYODBYIGlzIG5vdCBzZXQK
Q09ORklHX1JUQ19EUlZfRFMxMzA3PXkKIyBDT05GSUdfUlRDX0RSVl9EUzEzMDdfQ0VOVFVSWSBp
cyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfRFMxMzc0IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRD
X0RSVl9EUzE2NzIgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX0hZTTg1NjMgaXMgbm90IHNl
dAojIENPTkZJR19SVENfRFJWX01BWDY5MDAgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX1JT
NUMzNzIgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX0lTTDEyMDggaXMgbm90IHNldAojIENP
TkZJR19SVENfRFJWX0lTTDEyMDIyIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9YMTIwNSBp
cyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfUENGODUyMyBpcyBub3Qgc2V0CiMgQ09ORklHX1JU
Q19EUlZfUENGODUwNjMgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX1BDRjg1NjMgaXMgbm90
IHNldAojIENPTkZJR19SVENfRFJWX1BDRjg1ODMgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJW
X000MVQ4MCBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfQlEzMksgaXMgbm90IHNldAojIENP
TkZJR19SVENfRFJWX1MzNTM5MEEgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX0ZNMzEzMCBp
cyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfUlg4MDEwIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRD
X0RSVl9SWDg1ODEgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX1JYODAyNSBpcyBub3Qgc2V0
CiMgQ09ORklHX1JUQ19EUlZfRU0zMDI3IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9SVjg4
MDMgaXMgbm90IHNldAoKIwojIFNQSSBSVEMgZHJpdmVycwojCiMgQ09ORklHX1JUQ19EUlZfTTQx
VDkzIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9NNDFUOTQgaXMgbm90IHNldAojIENPTkZJ
R19SVENfRFJWX0RTMTMwMiBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfRFMxMzA1IGlzIG5v
dCBzZXQKIyBDT05GSUdfUlRDX0RSVl9EUzEzNDMgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJW
X0RTMTM0NyBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfRFMxMzkwIGlzIG5vdCBzZXQKIyBD
T05GSUdfUlRDX0RSVl9NQVg2OTE2IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9SOTcwMSBp
cyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfUlg0NTgxIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRD
X0RSVl9SWDYxMTAgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX1JTNUMzNDggaXMgbm90IHNl
dAojIENPTkZJR19SVENfRFJWX01BWDY5MDIgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX1BD
RjIxMjMgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX01DUDc5NSBpcyBub3Qgc2V0CkNPTkZJ
R19SVENfSTJDX0FORF9TUEk9eQoKIwojIFNQSSBhbmQgSTJDIFJUQyBkcml2ZXJzCiMKIyBDT05G
SUdfUlRDX0RSVl9EUzMyMzIgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX1BDRjIxMjcgaXMg
bm90IHNldAojIENPTkZJR19SVENfRFJWX1JWMzAyOUMyIGlzIG5vdCBzZXQKCiMKIyBQbGF0Zm9y
bSBSVEMgZHJpdmVycwojCiMgQ09ORklHX1JUQ19EUlZfQ01PUyBpcyBub3Qgc2V0CiMgQ09ORklH
X1JUQ19EUlZfRFMxMjg2IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9EUzE1MTEgaXMgbm90
IHNldAojIENPTkZJR19SVENfRFJWX0RTMTU1MyBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZf
RFMxNjg1X0ZBTUlMWSBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfRFMxNzQyIGlzIG5vdCBz
ZXQKIyBDT05GSUdfUlRDX0RSVl9EUzI0MDQgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX1NU
SzE3VEE4IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9NNDhUODYgaXMgbm90IHNldAojIENP
TkZJR19SVENfRFJWX000OFQzNSBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfTTQ4VDU5IGlz
IG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9NU002MjQyIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRD
X0RSVl9CUTQ4MDIgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX1JQNUMwMSBpcyBub3Qgc2V0
CiMgQ09ORklHX1JUQ19EUlZfVjMwMjAgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX1pZTlFN
UCBpcyBub3Qgc2V0CgojCiMgb24tQ1BVIFJUQyBkcml2ZXJzCiMKIyBDT05GSUdfUlRDX0RSVl9T
TlZTIGlzIG5vdCBzZXQKCiMKIyBISUQgU2Vuc29yIFJUQyBkcml2ZXJzCiMKIyBDT05GSUdfRE1B
REVWSUNFUyBpcyBub3Qgc2V0CgojCiMgRE1BQlVGIG9wdGlvbnMKIwojIENPTkZJR19TWU5DX0ZJ
TEUgaXMgbm90IHNldAojIENPTkZJR19BVVhESVNQTEFZIGlzIG5vdCBzZXQKIyBDT05GSUdfVUlP
IGlzIG5vdCBzZXQKIyBDT05GSUdfVklSVF9EUklWRVJTIGlzIG5vdCBzZXQKCiMKIyBWaXJ0aW8g
ZHJpdmVycwojCiMgQ09ORklHX1ZJUlRJT19NTUlPIGlzIG5vdCBzZXQKCiMKIyBNaWNyb3NvZnQg
SHlwZXItViBndWVzdCBzdXBwb3J0CiMKIyBDT05GSUdfU1RBR0lORyBpcyBub3Qgc2V0CiMgQ09O
RklHX0dPTERGSVNIIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0hST01FX1BMQVRGT1JNUyBpcyBub3Qg
c2V0CkNPTkZJR19DTEtERVZfTE9PS1VQPXkKQ09ORklHX0hBVkVfQ0xLX1BSRVBBUkU9eQpDT05G
SUdfQ09NTU9OX0NMSz15CgojCiMgQ29tbW9uIENsb2NrIEZyYW1ld29yawojCiMgQ09ORklHX0NP
TU1PTl9DTEtfU0k1MzUxIGlzIG5vdCBzZXQKIyBDT05GSUdfQ09NTU9OX0NMS19TSTUxNCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0NPTU1PTl9DTEtfU0k1NzAgaXMgbm90IHNldAojIENPTkZJR19DT01N
T05fQ0xLX0NEQ0U3MDYgaXMgbm90IHNldAojIENPTkZJR19DT01NT05fQ0xLX0NEQ0U5MjUgaXMg
bm90IHNldAojIENPTkZJR19DT01NT05fQ0xLX0NTMjAwMF9DUCBpcyBub3Qgc2V0CiMgQ09ORklH
X0NMS19RT1JJUSBpcyBub3Qgc2V0CiMgQ09ORklHX0NPTU1PTl9DTEtfTlhQIGlzIG5vdCBzZXQK
IyBDT05GSUdfQ09NTU9OX0NMS19QWEEgaXMgbm90IHNldAojIENPTkZJR19DT01NT05fQ0xLX1BJ
QzMyIGlzIG5vdCBzZXQKQ09ORklHX0NPTU1PTl9DTEtfT1hOQVM9eQoKIwojIEhhcmR3YXJlIFNw
aW5sb2NrIGRyaXZlcnMKIwoKIwojIENsb2NrIFNvdXJjZSBkcml2ZXJzCiMKQ09ORklHX0NMS1NS
Q19PRj15CkNPTkZJR19DTEtTUkNfUFJPQkU9eQpDT05GSUdfQ0xLU1JDX01NSU89eQpDT05GSUdf
QVJNX1RJTUVSX1NQODA0PXkKIyBDT05GSUdfQVRNRUxfUElUIGlzIG5vdCBzZXQKQ09ORklHX09Y
TkFTX1JQU19USU1FUj15CiMgQ09ORklHX1NIX1RJTUVSX0NNVCBpcyBub3Qgc2V0CiMgQ09ORklH
X1NIX1RJTUVSX01UVTIgaXMgbm90IHNldAojIENPTkZJR19TSF9USU1FUl9UTVUgaXMgbm90IHNl
dAojIENPTkZJR19FTV9USU1FUl9TVEkgaXMgbm90IHNldAojIENPTkZJR19NQUlMQk9YIGlzIG5v
dCBzZXQKQ09ORklHX0lPTU1VX1NVUFBPUlQ9eQoKIwojIEdlbmVyaWMgSU9NTVUgUGFnZXRhYmxl
IFN1cHBvcnQKIwojIENPTkZJR19JT01NVV9JT19QR1RBQkxFX0xQQUUgaXMgbm90IHNldAojIENP
TkZJR19JT01NVV9JT19QR1RBQkxFX0FSTVY3UyBpcyBub3Qgc2V0CiMgQ09ORklHX0FSTV9TTU1V
IGlzIG5vdCBzZXQKCiMKIyBSZW1vdGVwcm9jIGRyaXZlcnMKIwojIENPTkZJR19TVEVfTU9ERU1f
UlBST0MgaXMgbm90IHNldAoKIwojIFJwbXNnIGRyaXZlcnMKIwoKIwojIFNPQyAoU3lzdGVtIE9u
IENoaXApIHNwZWNpZmljIERyaXZlcnMKIwoKIwojIEJyb2FkY29tIFNvQyBkcml2ZXJzCiMKIyBD
T05GSUdfU09DX0JSQ01TVEIgaXMgbm90IHNldAojIENPTkZJR19TVU5YSV9TUkFNIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU09DX1RJIGlzIG5vdCBzZXQKIyBDT05GSUdfUE1fREVWRlJFUSBpcyBub3Qg
c2V0CiMgQ09ORklHX0VYVENPTiBpcyBub3Qgc2V0CiMgQ09ORklHX01FTU9SWSBpcyBub3Qgc2V0
CiMgQ09ORklHX0lJTyBpcyBub3Qgc2V0CiMgQ09ORklHX1BXTSBpcyBub3Qgc2V0CkNPTkZJR19J
UlFDSElQPXkKQ09ORklHX0FSTV9HSUNfTUFYX05SPTEKQ09ORklHX1ZFUlNBVElMRV9GUEdBX0lS
UT15CkNPTkZJR19WRVJTQVRJTEVfRlBHQV9JUlFfTlI9NAojIENPTkZJR19JUEFDS19CVVMgaXMg
bm90IHNldApDT05GSUdfQVJDSF9IQVNfUkVTRVRfQ09OVFJPTExFUj15CkNPTkZJR19SRVNFVF9D
T05UUk9MTEVSPXkKIyBDT05GSUdfUkVTRVRfQVRINzkgaXMgbm90IHNldAojIENPTkZJR19SRVNF
VF9CRVJMSU4gaXMgbm90IHNldAojIENPTkZJR19SRVNFVF9MUEMxOFhYIGlzIG5vdCBzZXQKIyBD
T05GSUdfUkVTRVRfTUVTT04gaXMgbm90IHNldApDT05GSUdfUkVTRVRfT1hOQVM9eQojIENPTkZJ
R19SRVNFVF9QSVNUQUNISU8gaXMgbm90IHNldAojIENPTkZJR19SRVNFVF9TT0NGUEdBIGlzIG5v
dCBzZXQKIyBDT05GSUdfUkVTRVRfU1RNMzIgaXMgbm90IHNldAojIENPTkZJR19SRVNFVF9TVU5Y
SSBpcyBub3Qgc2V0CiMgQ09ORklHX1RJX1NZU0NPTl9SRVNFVCBpcyBub3Qgc2V0CiMgQ09ORklH
X1JFU0VUX1pZTlEgaXMgbm90IHNldAojIENPTkZJR19GTUMgaXMgbm90IHNldAoKIwojIFBIWSBT
dWJzeXN0ZW0KIwojIENPTkZJR19HRU5FUklDX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX1BIWV9Q
WEFfMjhOTV9IU0lDIGlzIG5vdCBzZXQKIyBDT05GSUdfUEhZX1BYQV8yOE5NX1VTQjIgaXMgbm90
IHNldAojIENPTkZJR19CQ01fS09OQV9VU0IyX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX1BPV0VS
Q0FQIGlzIG5vdCBzZXQKIyBDT05GSUdfTUNCIGlzIG5vdCBzZXQKCiMKIyBQZXJmb3JtYW5jZSBt
b25pdG9yIHN1cHBvcnQKIwojIENPTkZJR19SQVMgaXMgbm90IHNldAoKIwojIEFuZHJvaWQKIwoj
IENPTkZJR19BTkRST0lEIGlzIG5vdCBzZXQKIyBDT05GSUdfTlZNRU0gaXMgbm90IHNldAojIENP
TkZJR19TVE0gaXMgbm90IHNldAojIENPTkZJR19JTlRFTF9USCBpcyBub3Qgc2V0CgojCiMgRlBH
QSBDb25maWd1cmF0aW9uIFN1cHBvcnQKIwojIENPTkZJR19GUEdBIGlzIG5vdCBzZXQKCiMKIyBG
aXJtd2FyZSBEcml2ZXJzCiMKIyBDT05GSUdfRklSTVdBUkVfTUVNTUFQIGlzIG5vdCBzZXQKIyBD
T05GSUdfRldfQ0ZHX1NZU0ZTIGlzIG5vdCBzZXQKCiMKIyBGaWxlIHN5c3RlbXMKIwpDT05GSUdf
RVhUMl9GUz15CiMgQ09ORklHX0VYVDJfRlNfWEFUVFIgaXMgbm90IHNldAojIENPTkZJR19FWFQz
X0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfRVhUNF9GUyBpcyBub3Qgc2V0CiMgQ09ORklHX1JFSVNF
UkZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfSkZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfWEZT
X0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfR0ZTMl9GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0JUUkZT
X0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfTklMRlMyX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfRjJG
U19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0ZTX1BPU0lYX0FDTCBpcyBub3Qgc2V0CkNPTkZJR19F
WFBPUlRGUz15CiMgQ09ORklHX0VYUE9SVEZTX0JMT0NLX09QUyBpcyBub3Qgc2V0CkNPTkZJR19G
SUxFX0xPQ0tJTkc9eQpDT05GSUdfTUFOREFUT1JZX0ZJTEVfTE9DS0lORz15CiMgQ09ORklHX0ZT
X0VOQ1JZUFRJT04gaXMgbm90IHNldApDT05GSUdfRlNOT1RJRlk9eQpDT05GSUdfRE5PVElGWT15
CkNPTkZJR19JTk9USUZZX1VTRVI9eQojIENPTkZJR19GQU5PVElGWSBpcyBub3Qgc2V0CiMgQ09O
RklHX1FVT1RBIGlzIG5vdCBzZXQKIyBDT05GSUdfUVVPVEFDVEwgaXMgbm90IHNldAojIENPTkZJ
R19BVVRPRlM0X0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfRlVTRV9GUyBpcyBub3Qgc2V0CiMgQ09O
RklHX09WRVJMQVlfRlMgaXMgbm90IHNldAoKIwojIENhY2hlcwojCiMgQ09ORklHX0ZTQ0FDSEUg
aXMgbm90IHNldAoKIwojIENELVJPTS9EVkQgRmlsZXN5c3RlbXMKIwojIENPTkZJR19JU085NjYw
X0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfVURGX0ZTIGlzIG5vdCBzZXQKCiMKIyBET1MvRkFUL05U
IEZpbGVzeXN0ZW1zCiMKQ09ORklHX0ZBVF9GUz1tCiMgQ09ORklHX01TRE9TX0ZTIGlzIG5vdCBz
ZXQKQ09ORklHX1ZGQVRfRlM9bQpDT05GSUdfRkFUX0RFRkFVTFRfQ09ERVBBR0U9NDM3CkNPTkZJ
R19GQVRfREVGQVVMVF9JT0NIQVJTRVQ9Imlzbzg4NTktMSIKIyBDT05GSUdfRkFUX0RFRkFVTFRf
VVRGOCBpcyBub3Qgc2V0CiMgQ09ORklHX05URlNfRlMgaXMgbm90IHNldAoKIwojIFBzZXVkbyBm
aWxlc3lzdGVtcwojCkNPTkZJR19QUk9DX0ZTPXkKQ09ORklHX1BST0NfU1lTQ1RMPXkKQ09ORklH
X1BST0NfUEFHRV9NT05JVE9SPXkKIyBDT05GSUdfUFJPQ19DSElMRFJFTiBpcyBub3Qgc2V0CkNP
TkZJR19LRVJORlM9eQpDT05GSUdfU1lTRlM9eQojIENPTkZJR19UTVBGUyBpcyBub3Qgc2V0CiMg
Q09ORklHX0hVR0VUTEJfUEFHRSBpcyBub3Qgc2V0CiMgQ09ORklHX0NPTkZJR0ZTX0ZTIGlzIG5v
dCBzZXQKQ09ORklHX01JU0NfRklMRVNZU1RFTVM9eQojIENPTkZJR19PUkFOR0VGU19GUyBpcyBu
b3Qgc2V0CiMgQ09ORklHX0FERlNfRlMgaXMgbm90IHNldAojIENPTkZJR19BRkZTX0ZTIGlzIG5v
dCBzZXQKIyBDT05GSUdfSEZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfSEZTUExVU19GUyBpcyBu
b3Qgc2V0CiMgQ09ORklHX0JFRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19CRlNfRlMgaXMgbm90
IHNldAojIENPTkZJR19FRlNfRlMgaXMgbm90IHNldApDT05GSUdfSkZGUzJfRlM9eQpDT05GSUdf
SkZGUzJfRlNfREVCVUc9MApDT05GSUdfSkZGUzJfRlNfV1JJVEVCVUZGRVI9eQojIENPTkZJR19K
RkZTMl9GU19XQlVGX1ZFUklGWSBpcyBub3Qgc2V0CiMgQ09ORklHX0pGRlMyX1NVTU1BUlkgaXMg
bm90IHNldAojIENPTkZJR19KRkZTMl9GU19YQVRUUiBpcyBub3Qgc2V0CiMgQ09ORklHX0pGRlMy
X0NPTVBSRVNTSU9OX09QVElPTlMgaXMgbm90IHNldApDT05GSUdfSkZGUzJfWkxJQj15CiMgQ09O
RklHX0pGRlMyX0xaTyBpcyBub3Qgc2V0CkNPTkZJR19KRkZTMl9SVElNRT15CiMgQ09ORklHX0pG
RlMyX1JVQklOIGlzIG5vdCBzZXQKIyBDT05GSUdfTE9HRlMgaXMgbm90IHNldApDT05GSUdfQ1JB
TUZTPXkKIyBDT05GSUdfU1FVQVNIRlMgaXMgbm90IHNldAojIENPTkZJR19WWEZTX0ZTIGlzIG5v
dCBzZXQKQ09ORklHX01JTklYX0ZTPXkKIyBDT05GSUdfT01GU19GUyBpcyBub3Qgc2V0CiMgQ09O
RklHX0hQRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19RTlg0RlNfRlMgaXMgbm90IHNldAojIENP
TkZJR19RTlg2RlNfRlMgaXMgbm90IHNldApDT05GSUdfUk9NRlNfRlM9eQpDT05GSUdfUk9NRlNf
QkFDS0VEX0JZX0JMT0NLPXkKIyBDT05GSUdfUk9NRlNfQkFDS0VEX0JZX01URCBpcyBub3Qgc2V0
CiMgQ09ORklHX1JPTUZTX0JBQ0tFRF9CWV9CT1RIIGlzIG5vdCBzZXQKQ09ORklHX1JPTUZTX09O
X0JMT0NLPXkKIyBDT05GSUdfUFNUT1JFIGlzIG5vdCBzZXQKIyBDT05GSUdfU1lTVl9GUyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1VGU19GUyBpcyBub3Qgc2V0CkNPTkZJR19ORVRXT1JLX0ZJTEVTWVNU
RU1TPXkKQ09ORklHX05GU19GUz15CkNPTkZJR19ORlNfVjI9eQpDT05GSUdfTkZTX1YzPXkKIyBD
T05GSUdfTkZTX1YzX0FDTCBpcyBub3Qgc2V0CiMgQ09ORklHX05GU19WNCBpcyBub3Qgc2V0CiMg
Q09ORklHX05GU19TV0FQIGlzIG5vdCBzZXQKQ09ORklHX1JPT1RfTkZTPXkKQ09ORklHX05GU0Q9
eQpDT05GSUdfTkZTRF9WMz15CiMgQ09ORklHX05GU0RfVjNfQUNMIGlzIG5vdCBzZXQKIyBDT05G
SUdfTkZTRF9WNCBpcyBub3Qgc2V0CkNPTkZJR19HUkFDRV9QRVJJT0Q9eQpDT05GSUdfTE9DS0Q9
eQpDT05GSUdfTE9DS0RfVjQ9eQpDT05GSUdfTkZTX0NPTU1PTj15CkNPTkZJR19TVU5SUEM9eQoj
IENPTkZJR19TVU5SUENfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19DRVBIX0ZTIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQ0lGUyBpcyBub3Qgc2V0CiMgQ09ORklHX05DUF9GUyBpcyBub3Qgc2V0CiMg
Q09ORklHX0NPREFfRlMgaXMgbm90IHNldAojIENPTkZJR19BRlNfRlMgaXMgbm90IHNldApDT05G
SUdfTkxTPW0KQ09ORklHX05MU19ERUZBVUxUPSJpc284ODU5LTEiCiMgQ09ORklHX05MU19DT0RF
UEFHRV80MzcgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfNzM3IGlzIG5vdCBzZXQK
IyBDT05GSUdfTkxTX0NPREVQQUdFXzc3NSBpcyBub3Qgc2V0CkNPTkZJR19OTFNfQ09ERVBBR0Vf
ODUwPW0KIyBDT05GSUdfTkxTX0NPREVQQUdFXzg1MiBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19D
T0RFUEFHRV84NTUgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODU3IGlzIG5vdCBz
ZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg2MCBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RF
UEFHRV84NjEgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODYyIGlzIG5vdCBzZXQK
IyBDT05GSUdfTkxTX0NPREVQQUdFXzg2MyBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFH
RV84NjQgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODY1IGlzIG5vdCBzZXQKIyBD
T05GSUdfTkxTX0NPREVQQUdFXzg2NiBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84
NjkgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfOTM2IGlzIG5vdCBzZXQKIyBDT05G
SUdfTkxTX0NPREVQQUdFXzk1MCBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV85MzIg
aXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfOTQ5IGlzIG5vdCBzZXQKIyBDT05GSUdf
TkxTX0NPREVQQUdFXzg3NCBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5XzggaXMgbm90
IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfMTI1MCBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19D
T0RFUEFHRV8xMjUxIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0FTQ0lJIGlzIG5vdCBzZXQKQ09O
RklHX05MU19JU084ODU5XzE9bQojIENPTkZJR19OTFNfSVNPODg1OV8yIGlzIG5vdCBzZXQKIyBD
T05GSUdfTkxTX0lTTzg4NTlfMyBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5XzQgaXMg
bm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV81IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0lT
Tzg4NTlfNiBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5XzcgaXMgbm90IHNldAojIENP
TkZJR19OTFNfSVNPODg1OV85IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0lTTzg4NTlfMTMgaXMg
bm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV8xNCBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19J
U084ODU5XzE1IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0tPSThfUiBpcyBub3Qgc2V0CiMgQ09O
RklHX05MU19LT0k4X1UgaXMgbm90IHNldAojIENPTkZJR19OTFNfTUFDX1JPTUFOIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTkxTX01BQ19DRUxUSUMgaXMgbm90IHNldAojIENPTkZJR19OTFNfTUFDX0NF
TlRFVVJPIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX01BQ19DUk9BVElBTiBpcyBub3Qgc2V0CiMg
Q09ORklHX05MU19NQUNfQ1lSSUxMSUMgaXMgbm90IHNldAojIENPTkZJR19OTFNfTUFDX0dBRUxJ
QyBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19NQUNfR1JFRUsgaXMgbm90IHNldAojIENPTkZJR19O
TFNfTUFDX0lDRUxBTkQgaXMgbm90IHNldAojIENPTkZJR19OTFNfTUFDX0lOVUlUIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTkxTX01BQ19ST01BTklBTiBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19NQUNf
VFVSS0lTSCBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19VVEY4IGlzIG5vdCBzZXQKCiMKIyBLZXJu
ZWwgaGFja2luZwojCgojCiMgcHJpbnRrIGFuZCBkbWVzZyBvcHRpb25zCiMKIyBDT05GSUdfUFJJ
TlRLX1RJTUUgaXMgbm90IHNldApDT05GSUdfTUVTU0FHRV9MT0dMRVZFTF9ERUZBVUxUPTQKIyBD
T05GSUdfQk9PVF9QUklOVEtfREVMQVkgaXMgbm90IHNldAoKIwojIENvbXBpbGUtdGltZSBjaGVj
a3MgYW5kIGNvbXBpbGVyIG9wdGlvbnMKIwojIENPTkZJR19ERUJVR19JTkZPIGlzIG5vdCBzZXQK
Q09ORklHX0VOQUJMRV9XQVJOX0RFUFJFQ0FURUQ9eQpDT05GSUdfRU5BQkxFX01VU1RfQ0hFQ0s9
eQpDT05GSUdfRlJBTUVfV0FSTj0xMDI0CiMgQ09ORklHX1NUUklQX0FTTV9TWU1TIGlzIG5vdCBz
ZXQKIyBDT05GSUdfUkVBREFCTEVfQVNNIGlzIG5vdCBzZXQKIyBDT05GSUdfVU5VU0VEX1NZTUJP
TFMgaXMgbm90IHNldAojIENPTkZJR19QQUdFX09XTkVSIGlzIG5vdCBzZXQKIyBDT05GSUdfREVC
VUdfRlMgaXMgbm90IHNldAojIENPTkZJR19IRUFERVJTX0NIRUNLIGlzIG5vdCBzZXQKIyBDT05G
SUdfREVCVUdfU0VDVElPTl9NSVNNQVRDSCBpcyBub3Qgc2V0CkNPTkZJR19TRUNUSU9OX01JU01B
VENIX1dBUk5fT05MWT15CiMgQ09ORklHX0RFQlVHX0ZPUkNFX1dFQUtfUEVSX0NQVSBpcyBub3Qg
c2V0CkNPTkZJR19NQUdJQ19TWVNSUT15CkNPTkZJR19NQUdJQ19TWVNSUV9ERUZBVUxUX0VOQUJM
RT0weDEKQ09ORklHX0RFQlVHX0tFUk5FTD15CgojCiMgTWVtb3J5IERlYnVnZ2luZwojCiMgQ09O
RklHX1BBR0VfRVhURU5TSU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfUEFHRUFMTE9DIGlz
IG5vdCBzZXQKIyBDT05GSUdfUEFHRV9QT0lTT05JTkcgaXMgbm90IHNldAojIENPTkZJR19ERUJV
R19PQkpFQ1RTIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfU0xBQiBpcyBub3Qgc2V0CkNPTkZJ
R19IQVZFX0RFQlVHX0tNRU1MRUFLPXkKIyBDT05GSUdfREVCVUdfS01FTUxFQUsgaXMgbm90IHNl
dAojIENPTkZJR19ERUJVR19TVEFDS19VU0FHRSBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX1ZN
IGlzIG5vdCBzZXQKQ09ORklHX0RFQlVHX01FTU9SWV9JTklUPXkKIyBDT05GSUdfREVCVUdfU0hJ
UlEgaXMgbm90IHNldAoKIwojIERlYnVnIExvY2t1cHMgYW5kIEhhbmdzCiMKIyBDT05GSUdfTE9D
S1VQX0RFVEVDVE9SIGlzIG5vdCBzZXQKIyBDT05GSUdfREVURUNUX0hVTkdfVEFTSyBpcyBub3Qg
c2V0CiMgQ09ORklHX1dRX1dBVENIRE9HIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFOSUNfT05fT09Q
UyBpcyBub3Qgc2V0CkNPTkZJR19QQU5JQ19PTl9PT1BTX1ZBTFVFPTAKQ09ORklHX1BBTklDX1RJ
TUVPVVQ9MApDT05GSUdfU0NIRURfREVCVUc9eQojIENPTkZJR19TQ0hFRF9JTkZPIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0NIRURTVEFUUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDSEVEX1NUQUNLX0VO
RF9DSEVDSyBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX1RJTUVLRUVQSU5HIGlzIG5vdCBzZXQK
IyBDT05GSUdfVElNRVJfU1RBVFMgaXMgbm90IHNldAoKIwojIExvY2sgRGVidWdnaW5nIChzcGlu
bG9ja3MsIG11dGV4ZXMsIGV0Yy4uLikKIwojIENPTkZJR19ERUJVR19SVF9NVVRFWEVTIGlzIG5v
dCBzZXQKIyBDT05GSUdfREVCVUdfU1BJTkxPQ0sgaXMgbm90IHNldAojIENPTkZJR19ERUJVR19N
VVRFWEVTIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfV1dfTVVURVhfU0xPV1BBVEggaXMgbm90
IHNldAojIENPTkZJR19ERUJVR19MT0NLX0FMTE9DIGlzIG5vdCBzZXQKIyBDT05GSUdfUFJPVkVf
TE9DS0lORyBpcyBub3Qgc2V0CiMgQ09ORklHX0xPQ0tfU1RBVCBpcyBub3Qgc2V0CiMgQ09ORklH
X0RFQlVHX0FUT01JQ19TTEVFUCBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX0xPQ0tJTkdfQVBJ
X1NFTEZURVNUUyBpcyBub3Qgc2V0CiMgQ09ORklHX0xPQ0tfVE9SVFVSRV9URVNUIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU1RBQ0tUUkFDRSBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX0tPQkpFQ1Qg
aXMgbm90IHNldApDT05GSUdfREVCVUdfQlVHVkVSQk9TRT15CiMgQ09ORklHX0RFQlVHX0xJU1Qg
aXMgbm90IHNldAojIENPTkZJR19ERUJVR19QSV9MSVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfREVC
VUdfU0cgaXMgbm90IHNldAojIENPTkZJR19ERUJVR19OT1RJRklFUlMgaXMgbm90IHNldAojIENP
TkZJR19ERUJVR19DUkVERU5USUFMUyBpcyBub3Qgc2V0CgojCiMgUkNVIERlYnVnZ2luZwojCiMg
Q09ORklHX1BST1ZFX1JDVSBpcyBub3Qgc2V0CiMgQ09ORklHX1NQQVJTRV9SQ1VfUE9JTlRFUiBp
cyBub3Qgc2V0CiMgQ09ORklHX1RPUlRVUkVfVEVTVCBpcyBub3Qgc2V0CiMgQ09ORklHX1JDVV9Q
RVJGX1RFU1QgaXMgbm90IHNldAojIENPTkZJR19SQ1VfVE9SVFVSRV9URVNUIGlzIG5vdCBzZXQK
IyBDT05GSUdfUkNVX1RSQUNFIGlzIG5vdCBzZXQKIyBDT05GSUdfUkNVX0VRU19ERUJVRyBpcyBu
b3Qgc2V0CiMgQ09ORklHX0RFQlVHX1dRX0ZPUkNFX1JSX0NQVSBpcyBub3Qgc2V0CiMgQ09ORklH
X0RFQlVHX0JMT0NLX0VYVF9ERVZUIGlzIG5vdCBzZXQKIyBDT05GSUdfTk9USUZJRVJfRVJST1Jf
SU5KRUNUSU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfRkFVTFRfSU5KRUNUSU9OIGlzIG5vdCBzZXQK
IyBDT05GSUdfTEFURU5DWVRPUCBpcyBub3Qgc2V0CkNPTkZJR19IQVZFX0ZVTkNUSU9OX1RSQUNF
Uj15CkNPTkZJR19IQVZFX0ZVTkNUSU9OX0dSQVBIX1RSQUNFUj15CkNPTkZJR19IQVZFX0RZTkFN
SUNfRlRSQUNFPXkKQ09ORklHX0hBVkVfRlRSQUNFX01DT1VOVF9SRUNPUkQ9eQpDT05GSUdfSEFW
RV9TWVNDQUxMX1RSQUNFUE9JTlRTPXkKQ09ORklHX0hBVkVfQ19SRUNPUkRNQ09VTlQ9eQpDT05G
SUdfVFJBQ0lOR19TVVBQT1JUPXkKQ09ORklHX0ZUUkFDRT15CiMgQ09ORklHX0ZVTkNUSU9OX1RS
QUNFUiBpcyBub3Qgc2V0CiMgQ09ORklHX0lSUVNPRkZfVFJBQ0VSIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0NIRURfVFJBQ0VSIGlzIG5vdCBzZXQKIyBDT05GSUdfSFdMQVRfVFJBQ0VSIGlzIG5vdCBz
ZXQKIyBDT05GSUdfRU5BQkxFX0RFRkFVTFRfVFJBQ0VSUyBpcyBub3Qgc2V0CiMgQ09ORklHX0ZU
UkFDRV9TWVNDQUxMUyBpcyBub3Qgc2V0CiMgQ09ORklHX1RSQUNFUl9TTkFQU0hPVCBpcyBub3Qg
c2V0CkNPTkZJR19CUkFOQ0hfUFJPRklMRV9OT05FPXkKIyBDT05GSUdfUFJPRklMRV9BTk5PVEFU
RURfQlJBTkNIRVMgaXMgbm90IHNldAojIENPTkZJR19QUk9GSUxFX0FMTF9CUkFOQ0hFUyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NUQUNLX1RSQUNFUiBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZf
SU9fVFJBQ0UgaXMgbm90IHNldAojIENPTkZJR19QUk9CRV9FVkVOVFMgaXMgbm90IHNldAojIENP
TkZJR19UUkFDRVBPSU5UX0JFTkNITUFSSyBpcyBub3Qgc2V0CkNPTkZJR19UUkFDSU5HX0VWRU5U
U19HUElPPXkKCiMKIyBSdW50aW1lIFRlc3RpbmcKIwojIENPTkZJR19URVNUX0xJU1RfU09SVCBp
cyBub3Qgc2V0CiMgQ09ORklHX0JBQ0tUUkFDRV9TRUxGX1RFU1QgaXMgbm90IHNldAojIENPTkZJ
R19SQlRSRUVfVEVTVCBpcyBub3Qgc2V0CiMgQ09ORklHX0lOVEVSVkFMX1RSRUVfVEVTVCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1BFUkNQVV9URVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfQVRPTUlDNjRf
U0VMRlRFU1QgaXMgbm90IHNldAojIENPTkZJR19URVNUX0hFWERVTVAgaXMgbm90IHNldAojIENP
TkZJR19URVNUX1NUUklOR19IRUxQRVJTIGlzIG5vdCBzZXQKIyBDT05GSUdfVEVTVF9LU1RSVE9Y
IGlzIG5vdCBzZXQKIyBDT05GSUdfVEVTVF9QUklOVEYgaXMgbm90IHNldAojIENPTkZJR19URVNU
X0JJVE1BUCBpcyBub3Qgc2V0CiMgQ09ORklHX1RFU1RfVVVJRCBpcyBub3Qgc2V0CiMgQ09ORklH
X1RFU1RfUkhBU0hUQUJMRSBpcyBub3Qgc2V0CiMgQ09ORklHX1RFU1RfSEFTSCBpcyBub3Qgc2V0
CiMgQ09ORklHX0RNQV9BUElfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19URVNUX0xLTSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1RFU1RfVVNFUl9DT1BZIGlzIG5vdCBzZXQKIyBDT05GSUdfVEVTVF9C
UEYgaXMgbm90IHNldAojIENPTkZJR19URVNUX0ZJUk1XQVJFIGlzIG5vdCBzZXQKIyBDT05GSUdf
VEVTVF9VREVMQVkgaXMgbm90IHNldAojIENPTkZJR19NRU1URVNUIGlzIG5vdCBzZXQKIyBDT05G
SUdfVEVTVF9TVEFUSUNfS0VZUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NBTVBMRVMgaXMgbm90IHNl
dApDT05GSUdfSEFWRV9BUkNIX0tHREI9eQojIENPTkZJR19LR0RCIGlzIG5vdCBzZXQKIyBDT05G
SUdfQVJDSF9XQU5UU19VQlNBTl9OT19OVUxMIGlzIG5vdCBzZXQKIyBDT05GSUdfVUJTQU4gaXMg
bm90IHNldApDT05GSUdfQVJDSF9IQVNfREVWTUVNX0lTX0FMTE9XRUQ9eQojIENPTkZJR19TVFJJ
Q1RfREVWTUVNIGlzIG5vdCBzZXQKIyBDT05GSUdfQVJNX1BURFVNUCBpcyBub3Qgc2V0CkNPTkZJ
R19BUk1fVU5XSU5EPXkKQ09ORklHX0RFQlVHX1VTRVI9eQpDT05GSUdfREVCVUdfTEw9eQpDT05G
SUdfREVCVUdfSUNFRENDPXkKIyBDT05GSUdfREVCVUdfU0VNSUhPU1RJTkcgaXMgbm90IHNldAoj
IENPTkZJR19ERUJVR19MTF9VQVJUXzgyNTAgaXMgbm90IHNldAojIENPTkZJR19ERUJVR19MTF9V
QVJUX1BMMDFYIGlzIG5vdCBzZXQKQ09ORklHX0RFQlVHX0xMX0lOQ0xVREU9ImRlYnVnL2ljZWRj
Yy5TIgojIENPTkZJR19ERUJVR19VQVJUXzgyNTAgaXMgbm90IHNldApDT05GSUdfREVCVUdfVU5D
T01QUkVTUz15CkNPTkZJR19VTkNPTVBSRVNTX0lOQ0xVREU9ImRlYnVnL3VuY29tcHJlc3MuaCIK
IyBDT05GSUdfRUFSTFlfUFJJTlRLIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfU0VUX01PRFVM
RV9ST05YIGlzIG5vdCBzZXQKIyBDT05GSUdfQ09SRVNJR0hUIGlzIG5vdCBzZXQKCiMKIyBTZWN1
cml0eSBvcHRpb25zCiMKIyBDT05GSUdfS0VZUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFQ1VSSVRZ
X0RNRVNHX1JFU1RSSUNUIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VDVVJJVFkgaXMgbm90IHNldAoj
IENPTkZJR19TRUNVUklUWUZTIGlzIG5vdCBzZXQKQ09ORklHX0hBVkVfSEFSREVORURfVVNFUkNP
UFlfQUxMT0NBVE9SPXkKQ09ORklHX0hBVkVfQVJDSF9IQVJERU5FRF9VU0VSQ09QWT15CiMgQ09O
RklHX0hBUkRFTkVEX1VTRVJDT1BZIGlzIG5vdCBzZXQKQ09ORklHX0RFRkFVTFRfU0VDVVJJVFlf
REFDPXkKQ09ORklHX0RFRkFVTFRfU0VDVVJJVFk9IiIKQ09ORklHX0NSWVBUTz15CgojCiMgQ3J5
cHRvIGNvcmUgb3IgaGVscGVyCiMKQ09ORklHX0NSWVBUT19BTEdBUEk9eQpDT05GSUdfQ1JZUFRP
X0FMR0FQSTI9eQpDT05GSUdfQ1JZUFRPX0FFQUQ9bQpDT05GSUdfQ1JZUFRPX0FFQUQyPXkKQ09O
RklHX0NSWVBUT19CTEtDSVBIRVIyPXkKQ09ORklHX0NSWVBUT19IQVNIPW0KQ09ORklHX0NSWVBU
T19IQVNIMj15CkNPTkZJR19DUllQVE9fUk5HPW0KQ09ORklHX0NSWVBUT19STkcyPXkKQ09ORklH
X0NSWVBUT19STkdfREVGQVVMVD1tCkNPTkZJR19DUllQVE9fQUtDSVBIRVIyPXkKQ09ORklHX0NS
WVBUT19LUFAyPXkKIyBDT05GSUdfQ1JZUFRPX1JTQSBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBU
T19ESCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19FQ0RIIGlzIG5vdCBzZXQKQ09ORklHX0NS
WVBUT19NQU5BR0VSPW0KQ09ORklHX0NSWVBUT19NQU5BR0VSMj15CiMgQ09ORklHX0NSWVBUT19V
U0VSIGlzIG5vdCBzZXQKQ09ORklHX0NSWVBUT19NQU5BR0VSX0RJU0FCTEVfVEVTVFM9eQojIENP
TkZJR19DUllQVE9fR0YxMjhNVUwgaXMgbm90IHNldApDT05GSUdfQ1JZUFRPX05VTEw9bQpDT05G
SUdfQ1JZUFRPX05VTEwyPXkKQ09ORklHX0NSWVBUT19XT1JLUVVFVUU9eQojIENPTkZJR19DUllQ
VE9fQ1JZUFREIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX01DUllQVEQgaXMgbm90IHNldAoj
IENPTkZJR19DUllQVE9fQVVUSEVOQyBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19URVNUIGlz
IG5vdCBzZXQKCiMKIyBBdXRoZW50aWNhdGVkIEVuY3J5cHRpb24gd2l0aCBBc3NvY2lhdGVkIERh
dGEKIwojIENPTkZJR19DUllQVE9fQ0NNIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0dDTSBp
cyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19DSEFDSEEyMFBPTFkxMzA1IGlzIG5vdCBzZXQKIyBD
T05GSUdfQ1JZUFRPX1NFUUlWIGlzIG5vdCBzZXQKQ09ORklHX0NSWVBUT19FQ0hBSU5JVj1tCgoj
CiMgQmxvY2sgbW9kZXMKIwojIENPTkZJR19DUllQVE9fQ0JDIGlzIG5vdCBzZXQKIyBDT05GSUdf
Q1JZUFRPX0NUUiBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19DVFMgaXMgbm90IHNldAojIENP
TkZJR19DUllQVE9fRUNCIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0xSVyBpcyBub3Qgc2V0
CiMgQ09ORklHX0NSWVBUT19QQ0JDIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1hUUyBpcyBu
b3Qgc2V0CiMgQ09ORklHX0NSWVBUT19LRVlXUkFQIGlzIG5vdCBzZXQKCiMKIyBIYXNoIG1vZGVz
CiMKIyBDT05GSUdfQ1JZUFRPX0NNQUMgaXMgbm90IHNldApDT05GSUdfQ1JZUFRPX0hNQUM9bQoj
IENPTkZJR19DUllQVE9fWENCQyBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19WTUFDIGlzIG5v
dCBzZXQKCiMKIyBEaWdlc3QKIwojIENPTkZJR19DUllQVE9fQ1JDMzJDIGlzIG5vdCBzZXQKIyBD
T05GSUdfQ1JZUFRPX0NSQzMyIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0NSQ1QxMERJRiBp
cyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19HSEFTSCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBU
T19QT0xZMTMwNSBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19NRDQgaXMgbm90IHNldAojIENP
TkZJR19DUllQVE9fTUQ1IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX01JQ0hBRUxfTUlDIGlz
IG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1JNRDEyOCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBU
T19STUQxNjAgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fUk1EMjU2IGlzIG5vdCBzZXQKIyBD
T05GSUdfQ1JZUFRPX1JNRDMyMCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19TSEExIGlzIG5v
dCBzZXQKQ09ORklHX0NSWVBUT19TSEEyNTY9bQojIENPTkZJR19DUllQVE9fU0hBNTEyIGlzIG5v
dCBzZXQKIyBDT05GSUdfQ1JZUFRPX1NIQTMgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fVEdS
MTkyIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1dQNTEyIGlzIG5vdCBzZXQKCiMKIyBDaXBo
ZXJzCiMKQ09ORklHX0NSWVBUT19BRVM9eQojIENPTkZJR19DUllQVE9fQU5VQklTIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQ1JZUFRPX0FSQzQgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fQkxPV0ZJ
U0ggaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fQ0FNRUxMSUEgaXMgbm90IHNldAojIENPTkZJ
R19DUllQVE9fQ0FTVDUgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fQ0FTVDYgaXMgbm90IHNl
dAojIENPTkZJR19DUllQVE9fREVTIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0ZDUllQVCBp
cyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19LSEFaQUQgaXMgbm90IHNldAojIENPTkZJR19DUllQ
VE9fU0FMU0EyMCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19DSEFDSEEyMCBpcyBub3Qgc2V0
CiMgQ09ORklHX0NSWVBUT19TRUVEIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1NFUlBFTlQg
aXMgbm90IHNldAojIENPTkZJR19DUllQVE9fVEVBIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRP
X1RXT0ZJU0ggaXMgbm90IHNldAoKIwojIENvbXByZXNzaW9uCiMKIyBDT05GSUdfQ1JZUFRPX0RF
RkxBVEUgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fTFpPIGlzIG5vdCBzZXQKIyBDT05GSUdf
Q1JZUFRPXzg0MiBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19MWjQgaXMgbm90IHNldAojIENP
TkZJR19DUllQVE9fTFo0SEMgaXMgbm90IHNldAoKIwojIFJhbmRvbSBOdW1iZXIgR2VuZXJhdGlv
bgojCiMgQ09ORklHX0NSWVBUT19BTlNJX0NQUk5HIGlzIG5vdCBzZXQKQ09ORklHX0NSWVBUT19E
UkJHX01FTlU9bQpDT05GSUdfQ1JZUFRPX0RSQkdfSE1BQz15CiMgQ09ORklHX0NSWVBUT19EUkJH
X0hBU0ggaXMgbm90IHNldApDT05GSUdfQ1JZUFRPX0RSQkc9bQpDT05GSUdfQ1JZUFRPX0pJVFRF
UkVOVFJPUFk9bQojIENPTkZJR19DUllQVE9fVVNFUl9BUElfSEFTSCBpcyBub3Qgc2V0CiMgQ09O
RklHX0NSWVBUT19VU0VSX0FQSV9TS0NJUEhFUiBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19V
U0VSX0FQSV9STkcgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fVVNFUl9BUElfQUVBRCBpcyBu
b3Qgc2V0CkNPTkZJR19DUllQVE9fSFc9eQoKIwojIENlcnRpZmljYXRlcyBmb3Igc2lnbmF0dXJl
IGNoZWNraW5nCiMKIyBDT05GSUdfQVJNX0NSWVBUTyBpcyBub3Qgc2V0CiMgQ09ORklHX0JJTkFS
WV9QUklOVEYgaXMgbm90IHNldAoKIwojIExpYnJhcnkgcm91dGluZXMKIwpDT05GSUdfQklUUkVW
RVJTRT15CiMgQ09ORklHX0hBVkVfQVJDSF9CSVRSRVZFUlNFIGlzIG5vdCBzZXQKQ09ORklHX1JB
VElPTkFMPXkKQ09ORklHX0dFTkVSSUNfU1RSTkNQWV9GUk9NX1VTRVI9eQpDT05GSUdfR0VORVJJ
Q19TVFJOTEVOX1VTRVI9eQpDT05GSUdfR0VORVJJQ19ORVRfVVRJTFM9eQpDT05GSUdfR0VORVJJ
Q19QQ0lfSU9NQVA9eQpDT05GSUdfR0VORVJJQ19JTz15CkNPTkZJR19BUkNIX1VTRV9DTVBYQ0hH
X0xPQ0tSRUY9eQojIENPTkZJR19DUkNfQ0NJVFQgaXMgbm90IHNldAojIENPTkZJR19DUkMxNiBp
cyBub3Qgc2V0CiMgQ09ORklHX0NSQ19UMTBESUYgaXMgbm90IHNldAojIENPTkZJR19DUkNfSVRV
X1QgaXMgbm90IHNldApDT05GSUdfQ1JDMzI9eQojIENPTkZJR19DUkMzMl9TRUxGVEVTVCBpcyBu
b3Qgc2V0CkNPTkZJR19DUkMzMl9TTElDRUJZOD15CiMgQ09ORklHX0NSQzMyX1NMSUNFQlk0IGlz
IG5vdCBzZXQKIyBDT05GSUdfQ1JDMzJfU0FSV0FURSBpcyBub3Qgc2V0CiMgQ09ORklHX0NSQzMy
X0JJVCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSQzcgaXMgbm90IHNldAojIENPTkZJR19MSUJDUkMz
MkMgaXMgbm90IHNldAojIENPTkZJR19DUkM4IGlzIG5vdCBzZXQKIyBDT05GSUdfQVVESVRfQVJD
SF9DT01QQVRfR0VORVJJQyBpcyBub3Qgc2V0CiMgQ09ORklHX1JBTkRPTTMyX1NFTEZURVNUIGlz
IG5vdCBzZXQKQ09ORklHX1pMSUJfSU5GTEFURT15CkNPTkZJR19aTElCX0RFRkxBVEU9eQpDT05G
SUdfTFpPX0NPTVBSRVNTPXkKQ09ORklHX0xaT19ERUNPTVBSRVNTPXkKQ09ORklHX0xaNF9ERUNP
TVBSRVNTPXkKQ09ORklHX1haX0RFQz15CkNPTkZJR19YWl9ERUNfWDg2PXkKQ09ORklHX1haX0RF
Q19QT1dFUlBDPXkKQ09ORklHX1haX0RFQ19JQTY0PXkKQ09ORklHX1haX0RFQ19BUk09eQpDT05G
SUdfWFpfREVDX0FSTVRIVU1CPXkKQ09ORklHX1haX0RFQ19TUEFSQz15CkNPTkZJR19YWl9ERUNf
QkNKPXkKIyBDT05GSUdfWFpfREVDX1RFU1QgaXMgbm90IHNldApDT05GSUdfREVDT01QUkVTU19H
WklQPXkKQ09ORklHX0RFQ09NUFJFU1NfQlpJUDI9eQpDT05GSUdfREVDT01QUkVTU19MWk1BPXkK
Q09ORklHX0RFQ09NUFJFU1NfWFo9eQpDT05GSUdfREVDT01QUkVTU19MWk89eQpDT05GSUdfREVD
T01QUkVTU19MWjQ9eQpDT05GSUdfR0VORVJJQ19BTExPQ0FUT1I9eQpDT05GSUdfSEFTX0lPTUVN
PXkKQ09ORklHX0hBU19JT1BPUlRfTUFQPXkKQ09ORklHX0hBU19ETUE9eQpDT05GSUdfRFFMPXkK
Q09ORklHX05MQVRUUj15CkNPTkZJR19HRU5FUklDX0FUT01JQzY0PXkKIyBDT05GSUdfQ09SRElD
IGlzIG5vdCBzZXQKIyBDT05GSUdfRERSIGlzIG5vdCBzZXQKIyBDT05GSUdfSVJRX1BPTEwgaXMg
bm90IHNldApDT05GSUdfTElCRkRUPXkKQ09ORklHX0ZPTlRfU1VQUE9SVD15CkNPTkZJR19GT05U
Uz15CiMgQ09ORklHX0ZPTlRfOHg4IGlzIG5vdCBzZXQKIyBDT05GSUdfRk9OVF84eDE2IGlzIG5v
dCBzZXQKIyBDT05GSUdfRk9OVF82eDExIGlzIG5vdCBzZXQKIyBDT05GSUdfRk9OVF83eDE0IGlz
IG5vdCBzZXQKIyBDT05GSUdfRk9OVF9QRUFSTF84eDggaXMgbm90IHNldApDT05GSUdfRk9OVF9B
Q09STl84eDg9eQojIENPTkZJR19GT05UX01JTklfNHg2IGlzIG5vdCBzZXQKIyBDT05GSUdfRk9O
VF82eDEwIGlzIG5vdCBzZXQKIyBDT05GSUdfRk9OVF9TVU44eDE2IGlzIG5vdCBzZXQKIyBDT05G
SUdfRk9OVF9TVU4xMngyMiBpcyBub3Qgc2V0CiMgQ09ORklHX0ZPTlRfMTB4MTggaXMgbm90IHNl
dAojIENPTkZJR19TR19TUExJVCBpcyBub3Qgc2V0CiMgQ09ORklHX1NHX1BPT0wgaXMgbm90IHNl
dApDT05GSUdfQVJDSF9IQVNfU0dfQ0hBSU49eQpDT05GSUdfU0JJVE1BUD15CiMgQ09ORklHX1ZJ
UlRVQUxJWkFUSU9OIGlzIG5vdCBzZXQK

--0000000000002b0ee2056cba51d0--
