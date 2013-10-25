---
title: printf vs. vprintf
author: Yinyanghu
tags: C, Programming 
---

`printf`, `fprintf`, `sprintf`这三个`stdio.h`中常用的Formatted Output Function想必大家并不陌生 其实在这三个function的背后 还有三个function 分别为`vprintf`, `vfprintf`, `vsprintf`

# Question

---

**它们是做什么用的?**

**与`printf`, `vfprintf`, `vsprintf`又有什么区别与联系?**

<br />

# Answer

---

在StackOverflow上 [Chris Lutz](http://stackoverflow.com/users/60777/chris-lutz)给了一个不错的答案:

* `printf()`作为普通的Formatted Output Function是很友好的

* 当你想写一个自己的`printf()`时 `vprintf()`友好的提供了接口

For example,

```c
int error(char *fmt, ...)
{
    int result;
    va_list args;
    va_start(args, fmt);
    fputs("Error: ", stderr);
    result = vprintf(stderr, fmt, args);
    va_end(args);
    return result;
}
```

通过调用`vprintf()` 我们实现了一个类似于`printf()`的function:`error()`

这段code的核心是利用`va_start()`和`va_end()`对variable argument lists进行操作 并将结果`va_list args`传入底层function `vprintf()`进行进一步解析并Output 在这之间我们就可以随意定制自己的Output Style

<br />

# Reference

---

* [Book] The C Programming Language (Second Edition) - *Kernighan & Ritchie*

* StackOverflow: [what's the difference between the printf and vprintf function families, and when should I use one over the other?](http://stackoverflow.com/questions/1485805/whats-the-difference-between-the-printf-and-vprintf-function-families-and-when)

---

☯ Yinyanghu, 2013
