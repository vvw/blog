---
title: REISUB - Magic SysRq key
author: Yinyanghu
tags: Linux, Keyboard, OS, CS
---

常见的104-Key的Keyboard上其实有些Key我们几乎不使用，例如SysRq, ScrollLock。尽管现在已经不怎么使用，但是它们依然存在，因为它们在历史上曾经风光一时。今天我们就来说说SysRq的故事。

![](/images/2013-07-22-reisub/A.svg "104 Key Keyboard")

<br>

# History

---

SysRq的全称是[System Request](http://en.wikipedia.org/wiki/System_request)，他的出现可以追溯到[IBM System/370 mainframe computer](http://en.wikipedia.org/wiki/System/370)。

当时的OS为了给用户提供底层系统功能(low-level system function)，于是在许多Keyboard(如[QWERTY](http://en.wikipedia.org/wiki/QWERTY))上使用了SysRq这个Key发送软件中断(Software Interrupt)给OS。与其它的Key不同的是，[Keyboard Buffer](http://en.wikipedia.org/wiki/Keyboard_buffer)不缓冲这个按键，而是直接发送。而随着早期OS的逐渐消失，Dos、Windows的崛起，SysRq这个Key也逐渐被人们遗忘，最终沦落到和PrintScreen Key同住一片屋檐下的尴尬地位。

<br>

# Magic SysRq Key

---

Linux不愧是世界上最优秀的OS Kernel之一！这帮老Geeks、老Hackers向来不忘记老祖宗留下的东西。于是在Linux Kernel中便有了[Magic SysRq Key](http://en.wikipedia.org/wiki/Magic_SysRq_key)这个玩意儿。

说白了，Magic SysRq Key就是利用SysRq Key来直接向Linux Kernel发送底层指令。许多情况下，系统虽然出现crash，但是稳定Kernel没准还在正常工作，于是这个时候我们尽管不能通过常规的方法来控制我们的PC，但是却可以利用Magic SysRq Key引导我们的系统，安全的Restart。

1. 按住Alt + SysRq Key

2. 缓慢的依次按下R, E, I, S, U, B这几个Key

3. 系统安全的Restart

这几个Key的意义如下：

* R: Switch the keyboard from raw mode to XLATE mode

* E: Send the SIGTERM signal to all processes except init

* I: Send the SIGKILL signal to all processes except init

* S: Sync all mounted filesystems

* U: Remount all mounted filesystems in read-only mode

* B: Immediately reboot the system, without unmounting partitions or syncing

这仅仅是Magic SysRq Key的一小部分功能，全部功能列表请参见[这里](http://en.wikipedia.org/wiki/Magic_SysRq_key)。如何快速的记住这几个Key呢？Geek们提供了诸多方法：

> "**R**aising **E**lephants **I**s **S**o **U**tterly **B**oring"

> "**R**eboot **E**ven **I**f **S**ystem **U**tterly **B**roken"

> "simply the word **_BUSIER_** read backwards"


除了通过SysRq Key可以调用Magic SysRq Key，还有另外一种方法

``` bash
echo b > /proc/sysrq-trigger
```

这等价于按下了Alt + SysRq + B这几个Key。

<br>

# Reference

---

* [Wikipedia: Magic SysRq Key](http://en.wikipedia.org/wiki/Magic_SysRq_key)

* [Wikipedia: System Request](http://en.wikipedia.org/wiki/System_request)

* [Wikipedia: QWERTY](http://en.wikipedia.org/wiki/QWERTY)

* [Linux Magic Key——SysRq(R-E-I-S-U-B)](http://www.linuxfly.org/post/545/)

* [Gently Restart a Frozen System](http://lifehacker.com/298891/gently-restart-a-frozen-system)

* [REISUB - the gentle Linux restart](http://kember.net/articles/reisub-the-gentle-linux-restart/)

---

☯ Yinyanghu, 2013
