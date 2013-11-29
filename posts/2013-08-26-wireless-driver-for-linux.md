---
title: Wireless Driver for Linux
author: Yinyanghu
tags: Wireless, Linux, Driver, Archlinux
---

# Linux Device Driver

-----

唉！Linux Kernel什么都好就是底层这些firmware driver实在是不给力，且不说性能不能完全发挥，还有糟糕的Power Management，甚至常常引起Kernel Panic。之所以出现这种情况，无外乎以下几点原因：

* 硬件厂商说到底关注的是市场，他们只关心有多少用户使用他们的硬件，而对于个人PC而言，Linux的用户数量肯定远远小于Windows，不开发Linux平台的driver理所当然；近些年来，随着Android的普及，Linux用户数量日益增加，这帮厂商们也开始投入一定的人力物力支持Linux；越来越多的游戏也开始登录Linux平台，Nvidia和AMD为了兼顾Android以及游戏市场，也开始对Linux有所支持。（P.S. 不禁又想起Linus对着媒体镜头向Nvidia竖中指的景象～）

* 维护Linux平台driver的成本太高。其实Linux Kernel为firmware提供了非常好的framework，driver的开发其实比在Windows平台上容易的多，而且理论上来说同样的硬件在Linux下的性能应该完胜Windows；但是Linux Kernel更新太快，Kernel的开发线又过多，版本之间变化也大，导致了Linux上的driver维护异常繁琐。

* 既然没有官方的driver，Geeks当然不会眼睁睁的看着自己的设备无法使用，所以无数的Geeks自发的开发unofficial driver，但是由于这些Geeks仅仅是unofficial developer，对firmware的理解当然有时会存在一些问题，而且能不能持续性的维护也得看他们的心情，毕竟他们并没有从这项工作中赚得一分钱。值得一提的是，有些unofficial driver甚至可以秒杀official driver。

* 同样作为Unix后裔的Mac，有成百上千的Apple Developer为相同firmware的几款机子设计调试driver，当然能让kernel对firmware支持得完美无瑕；所以从来没有听说过Mac用户为driver问题头疼过（除非你是那种在Mac上运行的Windows的用户）。Linux用户羡慕嫉妒恨啊～

总的来说，随着user以及developer的增加，Linux平台愈发引人注目，Linux的未来一片光明。

<br />

# Solution?

-----

作为一个饱受Linux Driver问题困扰的Linux用户，我也来谈谈我是如何度过这艰难的岁月。

1. 时间可以解决大部分问题！一般firmware刚刚问世的时候，如果没有很好的offical driver的支持，那你只能无奈的等待unofficial driver，这一过程大概可以持续1~2年。举一例子，三年前我的这个本刚刚买的时候，有线无线网卡都不能用，但是现在都有很好的unofficial driver支持。但是时间也会引入新的问题，随着Kernel的更新，并不能保证一定与以前的interface兼容；所以，_没有最好的driver，只有在特定Kernel版本下最好的driver_

2. 总是那么几家硬件制造商的firmware有driver问题，以我的经验来总结一下

* Graphics: Nvidia, AMD(ATI)都有问题，虽然都提供闭源driver，但是都离Windows平台上的driver差距甚大；反而Intel的CPU集成显示芯片都有着良好支持

* Ethernet & Wireless: Realtek以及Intel的Chipset都能良好支持；Broadcom不推荐使用，几乎每款Chipset都存在问题

* Mainboard: 主要就是Sensors能否正常工作

* USB Device: 一般不会遇到什么问题

3. 通过上述总结，其实不难看出有这么一个原则: **(集成 > 独立 && Intel是良心公司)**

4. 如果打算购买的在Linux平台上使用的firmware，最好先Google一下相应driver的情况

5. 尽情动手折腾吧！往往在你最最崩溃甚至心生放弃之念的时候，一切会变得柳暗花明。做好打持久战的准备，多多尝试

<br />


# Wireless Driver

-----

竟然吐槽了这么多？汗。。。。。实在是按耐不住长期内心中压抑的不爽。正文现在开始！主要介绍两款WLAN Adapter，如果你碰巧拥有相同型号的Wireless Adapter并且被driver问题所困扰，可以参考下面的方法。

## Broadcom BCM43225

_(这个Adapter在Linux下貌似不支持AP Mode)_

### Ubuntu

如果我没有记错的话，Ubuntu 12.04, 12.10使用Broadcom STA driver `broadcom-wl`，机身上的WiFi指示灯也可以正常工作。

### Archlinux

Archlinux紧追Linux Kernel的更新脚步，使用的是Open source kernel driver `brcmsmac`(也就是过去的`brcm80211`)。Linux 3.10之前的Kernel一直运行基本正常，偶尔在WiFi on/off的时候引起Kernel Panic。还有就是机身上WiFi指示灯永远不亮。。。

具体详见[Broadcom wireless](https://wiki.archlinux.org/index.php/Broadcom_wireless)

但是最近更新的Linux 3.10，只要是一收发数据包，就会引起Kernel Panic；表面上来看，引起Kernel Panic的原因是Divide-by-Zero Exception，更本质的原因是由于Kernel提供的interface发生了改变，该[Bug](https://bugzilla.redhat.com/show_bug.cgi?id=989269)现在正在[讨论](https://bbs.archlinux.org/viewtopic.php?id=168177)以及修复中，预计可能在Linux 3.11中解决。惊喜的是，常年不亮的WiFi指示灯终于正常了，可是灯亮了又有什么用呢？

暂时解决问题的方法是rollback到Linux 3.9的版本上；或是暂时禁用brcmsmac module，使用外置USB WLAN Adapter。

## Realtek RTL8188CUS

_我购买的是TL-WN725N，貌似只有最早出场的一批用的是这个firmware_

### Raspberry Pi

当时之所以买这个WLAN Adapter，是为了在我的Raspberry Pi上使用；在[Raspbian](http://www.raspbian.org)上，该Adapter的driver很完善，AP, Ad-hoc, Infrastructure都运行良好。Raspberry Pi Forum上也有很多文章讨论这款Adapter。

_P.S. 在Raspberry Pi上如果热插拔会导致restart_

### Ubuntu

貌似Ubuntu上该Adapter即插即用，完全没有问题，不过要开启AP mode还需要折腾一下。

### Archlinux

Realtek官网上提供的official driver由于只支持到Linux 3.0，现在source code已经无法正常`make`了；并且如果使用Linux的`rtl8192cu` module，会出现能扫描到周围WiFi却连接不上的尴尬情况；幸运的是，在AUR中，刚刚(本文写的前一天晚上)有人更新了这个driver，所以只需要`yaourt dkms-8192cu`即可。这个driver相当给力，即使离AP很远，信号强度也能保持150Mb/s，当然也可能是由于Adapter和AP都是TP-Link产品的缘故。（有文章提到过，使用一家厂商生产出来的Adapter和AP可以使速率更高、信号强度更好）

_P.S. 热插拔会导致Kernel Panic_

#### _P.S. Ndiswrapper对于这两款Adapter都不能正常工作，并且RTL8188CUS还会引起Kernel Panic，所以尽量还是不要使用Ndiswrapper。_

-----

☯ Yinyanghu, 2013
