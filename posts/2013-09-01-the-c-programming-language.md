---
title: [Book] The C Programming Language - Kernighan & Ritchie
author: Yinyanghu
tags: C, Unix, Book, Note, Ritchie, Kernighan, Programming
---

## Overture

---

最近闲来无事 于是随手那了本薄书来看 家中和计算机相关的书中最薄的书就是这本《C程序设计语言》了 这本书还是我在学校里回收的废弃书中捡来的 扉页上写着一行字`JSL 101130039` 通过在学校Database中的查阅 曾经这本书的主人应该是一个叫*吉诗鹭*的学化学的妹子(我还真是无聊啊。。。) 虽然是妹子我还是要坚持我一贯的传统 鄙视一下这个不懂得珍惜书的妹子 当然学化学的人不愿意留着这类书 我也表示理解 不管怎么说这书到了我的手上 它也算是实现了它的价值 我的废话真是越来越多了。。。

C language之父 大师K&R写的书 自然要怀着一种崇敬的心来阅读欣赏 尽管C是我为数不多掌握的programming language 但是几十万行的code下来 对这个language的理解也还算可以 所以从知识的角度来讲 读这本书也算是一个查缺补漏的过程 **我还是要吐槽一下这本书中文版的渣翻译** 于是果断找来英文电子版来看

相对于《Thinking in C++》 《C++ Primer》这类厚的跟词典似的书 《The C Programming Language》实在是太薄了 难以置信能在200多页的书中详尽介绍一种影响力如此之深远的programming language 然而大师们做到了 从`hello world`开始 到经典的Binary Search, Shellsort, Quicksort, Binary Search Tree, Hash Table 再到后来实现`stdio.h`等经典C library的code 甚至为了解释复杂到令人头疼的Declaration 实现了一个recursive-descent parser来帮助理解 他们对C真的如同对自己孩子一样了解 书中不仅仅准确表达了知识 更体现出一种属于他们那个时代所特有的UNIX文化气息

大师K&R虽然身为顶级的hacker 却没有过多的在书中表现他们的技巧 他们深知一个programming language的优劣并不是靠技巧体现的 他们在短短的200页纸中表现了C language的灵魂 对于任何想要使用C language的人来说这就足够了 多说无益 尽情领略吧

向Kernighan和Ritchie两位大师致敬

![](/images/2013-09-01-c/book.png "The C Programming Language")

<br />

## Chapter 1: A Tutorial Introduction

---

# `main()`: undeclared return type are taken as `int`

# `printf`

* Error

    ```c
    printf("ABC
    ");
    ```

* Using `\` at the end of line


# [Magic Number](http://en.wikipedia.org/wiki/Magic_number_(programming))

# `getchar()`, `putchar()`

# `A = B = C = 0` <==> `(A = (B = (C = 0)))`

<br />

## Chapter 2 - Types, Operators and Expressions

---

# Variable Names

* At least the first 31 characters of an internal name are significant. For function names and external variables, the number may be less than 31, because external names may be used by assemblers and loaders over which the language has no control. For external names, the standard guarantees uniqueness only for 6 characters and a single case.

# Constants

* An integer constant like `1234` is an `int`. A `long` constant is written with a terminal `l` or `L` , as in `123456789L`; an integer constant too big to fit into an `int` will also be taken as a long. Unsigned constants are written with a terminal `u` or `U`, and the suffix `ul` or `UL` indicates `unsigned long`.

* Floating-point constants contain a decimal point(`123.4`) or an exponent(`1e-2`) or both; their type is `double`, unless suffixed. The suffixes `f` or `F` indicate a `float` constant; `l` or `L` indicate a `long double`.

* Certain characters can be represented in character and string constants by escape sequences like `\n`(newline); these sequences look like two characters, but represent only one. In addition, an arbitrary byte-sized bit pattern can be specified by `\ooo` where `ooo` is one to three octal digits or by `\xhh` where `hh` is one or more hexadecimal digits.

# `"A""B"` <==> `"AB"`

# `'A'` vs. `"A"`

Integer vs. Array of Char

# Program Style

* `if (!valid)` is better than `if (valid == 0)`

* block

    ```c
    while () {
    
    }
    ```

# Arithmetic shift vs. Logical shift

# Type Conversion: narrower --> wider

# Implicit Arithmetic Conversion

* An example

    ```c
    -1L < 1U
    -1L > 1UL
    ```

# Cast: `(type)expression`

# [EBCDIC Character Set](http://en.wikipedia.org/wiki/EBCDIC)

# random: `rand()` and `srand()`

# Bitwise Operation

* GetBits

    ```c
    /* getbits: get n bits from position p */
    unsigned getbits(unsigned x, int p, int n)
    {
        return (x >> (p + 1 - n)) & ~(~0 << n);
    }
    ```

* SetBits

    (Returns x with the n bits that begin at position p set to the rightmost n bits of y , leaving the other bits unchanged)

* Invert

    (Returns x with the n bits that begin at position p inverted (i.e., 1 changed into 0 and vice versa), leaving the others unchanged)

* RightRot

    (Returns the value of the integer x rotated to the right by n positions)

* `x &= (x - 1)`

    Deletes the rightmost 1-bit in x

# Side Effects

* `a[i] = i++;`

<br />

## Chapter 3 - Control Flow

---

# `,` vs. `;`

* In C, the semicolon is a statement terminator, rather than a separator as it is in languages like Pascal.

# Binary Search

```c
/* binsearch: find x in v[0] <= v[1] <= ... <= v[n - 1] */
int binsearch(int x, int v[], int n)
{
    int low, high, mid;
    low = 0;
    high = n - 1;
    while (low <= high) {
        mid = (low + high) / 2;
        if (x < v[mid])
            high = mid + 1;
        else if (x > v[mid])
            low = mid + 1;
        else
            return mid;
    }
    return -1;
}
```

# Cases serve just as labels

# ShellSort

```c
void shellsort(int v[], int n)
{
    int gap, i, j, temp;
    for (gap = n / 2; gap > 0; gap /= 2)
        for (i = gap; i < n; i ++)
            for (j = i - gap; j >= 0 && v[j] > v[j + gap]; j -= gap) {
                temp = v[j];
                v[j] = v[j + gap];
                v[j + gap] = temp;
            }
}
```

<br />

## Chapter 4 - Functions and Program Structure

---

# The Minimal Function

* if the return type is omitted, `int` is assumed

    ```c
    dummy() {}
    ```

# No Return or `return;`

# `int f() {}` vs. `int f(void) {}`

# External Linkage

# Definition vs. Declaration

# Array sizes must be specified with the definition, but are optional with an extern declaration

# External, Static and Register

* static

    * internal static variables provide private, permanent storage within a single function

    * if a function is declared static , however, its name is invisible outside of the file in which it is declared

    * the static declaration, applied to an external variable or function, limits the scope of that object to the rest of the source file being compiled

* register

    * excess register declarations are harmless

    * it is not possible to take the address of a register variable, regardless of whether the variable is actually placed in a register

# Block Structure

* C is not a block-structured language in the sense of Pascal or similar languages, because functions may not be defined within other functions

* variables can be defined in a block-structured fashion within a function

* an automatic variable declared and initialized in a block is initialized each time the block is entered (**Performance?**)

# Initialization

* In the absence of explicit initialization, external and static variables are guaranteed to be initialized to zero; automatic and register variables have undefined (i.e., garbage) initial values

* Scalar variables may be initialized when they are defined, by following the name with an equals sign and an expression

* For external and static variables, the initializer must be a constant expression; the initialization is done once, conceptionally before the program begins execution. For automatic and register variables, the initializer is not restricted to being a constant


# Recursion: Quicksort

```c

/* qsort: sort v[left]...v[right] into increasing order */
void qsort(int v[], int left, int right)
{
    int i, last;
    void swap(int v[], int i, int j);

    if (left >= right) return;

    swap(v, left, (left + right) / 2);
    last = left;
    for (i = left + 1; i <= right; i ++)
        if (v[i] < v[left])
            swap(v, ++ last, i);
    swap(v, left, last);
    qsort(v, left, last - 1);
    qsort(v, last + 1, right);
}

/* swap: interchange v[i] and v[j] */
void swap(int v[], int i, int j)
{
    int temp;
    temp = v[i]; v[i] = v[j]; v[j] = temp;
}

```

# The C Preprocessor

* include

* define

    * Some pitfalls

        ```c
        #define max(A, B) ((A) > (B) ? (A) : (B))
        max(i ++, j ++);

        #define square(x) x * x
        square(z + 1);
        ```

    * Formal parameters are not replaced within quoted strings. If, however, a parameter name is preceded by a `#` in the replacement text, the combination will be expanded into a quoted string with the parameter replaced by the actual argument.

        ```c
        #define dprint(expr)    printf(#expr " = %g\n", expr)
        ```

        when this is invoked, as in `dprint(x/y)`, the macro is expanded into

        ```c
        print("x/y" " = %g\n", x/y);
        ```

        and the strings are concatenated, so the effect is

        ```c
        printf("x/y = %g\n", x/y);
        ```

        Within the actual argument, each `"` is replaced by `\"` and each `\` by `\\`, so the result is a legal string constant.

    * The preprocessor operator `##` provides a way to concatenate actual arguments during macro expansion. If a parameter in the replacement text is adjacent to a `##` , the parameter is replaced by the actual argument, the `##` and surrounding white space are removed, and the result is re-scanned.

        ```c
        #define paste(front, back)  front ## back
        ```

        so `paste(name, 1)` creates the token `name1`

        *The rules for nested uses of `##` are arcane*

* undef

* if, endif, elif, else, ifdef, ifndef

<br />

## Chapter 5 - Pointers and Arrays

---

Pointers are much used in C, partly because they are sometimes the only way to express a computation, and partly because they usually lead to more compact and efficient code than can be obtained in other ways.

`int *p;`: expression \*dp has values of `int`

# Stack Idiom

```c
*p++ = val; /* push */
val = *--p; /* pop */
```

# Multi-dimensional Arrays

```c
int f(int A[2][3]) {}
int f(int A[][3]) {}
int f(int (*A)[3]) {}
/* int f(int *A[3]) {} is wrong! */
```
More generally, only the first dimension (subscript) of an array is free; all the others have to be specified.

# Pointers vs. Multi-dimensional Arrays

```c
char *name[] = { "Illegal month", "Jan", "Feb", "Mar" };

char aname[][15] = { "Illegal month", "Jan", "Feb", "Mar" };
```

# `argc` and `argv`


# Pointers to Functions

```c
int *f(): /* f: function returning pointer to int */

int (*pf)(); /* pf: pointer to function returning int */
```

# Complicated Declarations

* `char **p`: pointer to char
* `int (*p)[10]`: pointer to array[10] of int
* `int *p[10]`: array[10] of pointer to int
* `void *f()`: function returning pointer to void
* `void (*f)()`: pointer to function returning void
* `char (*(*x())[])()`: function returning pointer to array[] of pointer to function return char
* `char (*(*x[3])())[5]`: array[3] of pointer to function returning pointer to array[5] of char

*A recursive-descent parser: `dcl` and `direct-dcl`*

<br />

## Chapter 6 - Structures

---

# Initialize

A structure can be initialized by following its definition with a list of initializers, each a constant expression, for the members:

```c
struct maxpt = { 320, 200 };
```

An automatic structure may also be initialized by assignment or by calling a function that returns a structure of the right type.

# Pointer

`(*p).x` <==> `p -> x`

# Self-referential Structures

* Binary Tree

* Hash Table

# Typedef

interpreted by the compiler, it can cope with textual substitutions that are beyond the capabilities of the preprocessor

```c
typedef int (*PFI)(char *, char *);
```

creates the type `PFI`, for "pointer to function (of two `char *` arguments)returning `int`"

Why we use `typedef`:

* purely aesthetic issues

* if `typedef`s are used for data types that may be machine-dependent, only the `typedef`s need change when the program is moved

* to provide better documentation for a program

# Union

* A union may only be initialized with a value of the type of its first member

* A union may be thought of as a structure all of whose members begin at offset 0 and whose size is sufficient to contain any of its members

* A small hack

    ```c
    union {
        struct {
            int type;
        } n;
        struct {
            int type;
            int intnode;
        } ni;
        struct {
            int type;
            float floatnode;
        } nf;
    } u;

    u.nf.type = FLOAT;
    u.nf.floatnode = 3.14;

    if (u.n.type == FLOAT)
        sin(u.nf.floatnode)
    ```

# Bit-fields

When storage space is at a premium, it may be necessary to pack several objects into a single machine word; one common use is a set of single-bit flags in applications like compiler symbol tables. Externally-imposed data formats, such as interfaces to hardware devices, also often require the ability to get at pieces of a word.

```c
struct {
    unsigned int A: 8;
    unsigned int B: 8;
    unsigned int C: 8;
    unsigned int D: 4;
    unsigned int E: 4;
} flags;

```

* Almost everything about fields is implementation-dependent

> Fields are assigned left to right on some machines and right to left on others

* Fields need not be names; unnamed fields (a colon and width only) are used for padding

* The special width 0 may be used to force alignment at the next word boundary

* Fields may be declared only as `int`s; for portability, specify signed or unsigned explicitly

<br />

## Chapter 7 - Input and Output

---

# Formatted Output - `printf`

Each conversion specification begins with a % and ends with a conversion character. Between the % and the conversion character there may be, in order:

* A minus sign, which specifies left adjustment of the converted argument

* A number that specifies the minimum field width. The converted argument will be printed in a field at least this wide. If necessary it will be padded on the left (or right, if left adjustment is called for) to make up the field width

* A period, which separates the field width from the precision

* A number, the precision, that specifies the maximum number of characters to be printed from a string, or the number of digits after the decimal point of a floating-point value, or the minimum number of digits for an integer

* An `h` if the integer is to be printed as a short , or `l` if as a long

`printf(s)` vs. `printf("%s", s)`

# Variable-length Argument Lists

# Formatted Input - `scanf`

# Exit

`exit` calls `fclose` for each open output file, to flush out any buffered output.

# Miscellaneous Functions

##### String Operations

In `<string.h>`

* `strcat(char *s, char *t)`
* `strncat(char *s, char *t, int n)`
* `strcmp(char *s, char *t)`
* `strncmp(char *s, char *t, int n)`
* `strcpy(char *s, char *t)`
* `strncpy(char *s, char *t, int n)`
* `strlen(char *s)`
* `strchar(char *s, char c)`
* `strrchr(char *s, char c)`

##### Character Class Testing and Conversion

In `<ctype.h>`

* `isalpha(char c)`
* `isupper(char c)`
* `islower(char c)`
* `isdigit(char c)`
* `isalnum(char c)`
* `isspace(char c)`
* `toupper(char c)`
* `tolower(char c)`

##### Ungetc

* `ungetc(int c, FILE *fp)`

##### Command Execution

* `system(char *s)`

##### Storage Management

* `void *malloc(size_t n)`
* `void *calloc(size_t n, size_t size)`
* `free(void *p)`

##### Mathematical Functions

In `<math.h>`

* `sin(x)`
* `cos(x)`
* `atan2(y, x)`
* `exp(x)`
* `log(x)`
* `log10(x)`
* `pow(x, y)`
* `sqrt(x)`
* `fabs(x)`

##### Random Number Generation

In `<stdlib.h>`

The function `rand()` computes a sequence of pseudo-random integers in the range zero to `RAND_MAX`

* `rand()`
* `srand()`

<br />

## Chapter 8 - The UNIX System Interface

---

* system call
* file descriptor
* low level I/O - `read` and `write`

# Open, Creat, Close, Unlink

* `open` is rather like the `fopen`, except that instead of returning a file pointer, it returns a file descriptor, which is just an `int`

* The standard library function `vprintf` is like `printf` except that the variable argument list is replaced by a single argument that has been initialized by calling the `va_start` macro. Similarly, `vfprintf` and `vsprintf` match `fprintf` and `sprintf` .

* There is a limit (often about 20) on the number of files that a program may open simultaneously. Accordingly, any program that intends to process many files must be prepared to re-use file descriptors. The function `close(int fd)` breaks the connection between a file descriptor and an open file, and frees the file descriptor for use with some other file; it corresponds to `fclose` in the standard library except that there is no buffer to flush. Termination of a program via `exit` or return from the main program closes all open files.

# Random Access - Lseek

The system call `lseek` provides a way to move around in a file without reading or writing any data:

```c
long lseek(int fd, long offset, int origin)
```

sets the current position in the file whose descriptor is `fd` to `offset` , which is taken relative to the location specified by `origin`. Subsequent reading or writing will begin at that position. `origin` can be 0, 1, or 2 to specify that `offset` is to be measured from the beginning, from the current position, or from the end of the file respectively.

The standard library function `fseek` is similar to `lseek` except that the first argument is a `FILE *`

# Listing Directories

# A Storage Allocator

<br />

## Appendix

---

# Storage Class

* automatic: declaration within a block, `auto`, `register`

* static: global declaration, `static`, `extern`

# Integral Promotion and Integral Conversions

# Parameter vs. Argument

The term argument is used for an expression passed by a function call; the term parameter is used for an input object (or its identifier) received by a function definition, or described in a function declaration

# Comma Operator

A pair of expressions separated by a comma is evaluated left-to-right, and the value of the left expression is discarded. The type and value of the result are the type and value of the right operand.

For example,

```c
f(a, (t = 3, t + 2), c)
```

has three arguments, the second of which has the value 5

# Const and Volatile

The `const` and `volatile` properties are new with the ANSI standard. The purpose of `const` is to announce objects that may be placed in read-only memory, and perhaps to increase opportunities for optimization. The purpose of `volatile` is to force an implementation to suppress optimization that could otherwise occur.

* A small trick:

    ```c
    int i, *pi, *const cpi = &i;
    const int ci = 3, *pci;
    ```

The declarations declare an integer `i` and a pointer to an integer `pi` . The value of the constant pointer `cpi` may not be changed; it will always point to the same location, although the value to which it refers may be altered.

The integer `ci` is constant, and may not be changed(though it may be initialized, as here.) The type of `pci` is "pointer to `const int`," and `pci` itself may be changed to point to another place, but the value to which it points may not be altered by assigning through `pci`.

# Initialization

* The initializer for a structure is either an expression of the same type, or a brace-enclosed list of initializers for its members in order. Unnamed bit-field members are ignored, and are not initialized. If there are fewer initializers in the list than members of the structure, the trailing members are initialized with 0. There may not be more initializers than members. Unnamed bit-field members are ignored,and are not initialized.

* The initializer for an array is a brace-enclosed list of initializers for its members. If the array has unknown size, the number of initializers determines the size of the array, and its type becomes complete.  If the array has fixed size, the number of initializers may not exceed the number of members of the array; if there are fewer, the trailing members are initialized with 0.

* An _aggregate_ is a structure or array. If an aggregate contains members of aggregate type, the initialization rules apply recursively. Braces may be elided in the initialization as follows: if the initializer for an aggregate’s member that itself is an aggregate begins with a left brace, then the succeding comma-separated list of initializers initializes the members of the subaggregate; it is erroneous for there to be more initializers than members. If, however, the initializer for a subaggregate does not begin with a left brace, then only enough elements from the list are taken into account for the members of the subaggregate; any remaining members are left to initialize the next member of the aggregate of which the subaggregate is a part.

For example,

```c
float y[4][3] = {
    {1}, {2}, {3}, {4}
};
```
initializes the first column of `y` and leaves the rest 0.

# Type Equivalence

* Two type specifier lists are equivalent if they contain the same set of type specifiers, taking into account that some specifiers can be implied by others (for example, `long` alone implies `long int`). Structures, unions, and enumerations with different tags are distinct, and a tagless union, structure, or enumeration specifies a unique type.

* Two types are the same if their abstract declarators, after expanding any `typedef` types, and deleting any function parameter specifiers, are the same up to the equivalence of type specifier lists. Array sizes and function parameter types are significant.

# Function Definitions

* New-style function

    ```c
    int max(int a, int b, int c)
    {

    }
    ```

* Old-style function

    ```c
    int max(a, b, c)
    int a, b, c;
    {

    }
    ```

# Preprocessing

Preprocessing itself takes place in several logically successive phases that may, in a particular implementation, be condensed.

1. First, trigraph sequences are replaced by their equivalents. Should the operating system environment require it, newline characters are introduced between the lines of the source file

2. Each occurrence of a backslash character \ followed by a newline is deleted, this splicing lines

3. The program is split into tokens separated by white-space characters; comments are replaced by a single space. Then preprocessing directives are obeyed, and macros are expanded

4. Escape sequences in character constants and string literals are replaced by their equivalents; then adjacent string literals are concatenated

5. The result is translated, then linked together with other programs and libraries, by collecting the necessary programs and data, and connecting external functions and object references to their definitions


##### define

Two special operators influence the replacement process.

* First, if an occurrence of a parameter in the replacement token sequence is immediately preceded by `#`, string quotes `"` are placed around the corresponding parameter, and then both the `#` and the parameter identifier are replaced by the quoted argument. A `\` character is inserted before each `"` or `\` character that appears surrounding, or inside, a string literal or character constant in the argument.

* Second, if the definition token sequence for macro contains a `##` operator, then just after replacement of the parameters, each `##` is deleted, together with any white space on either side, so as to concatenate the adjacent tokens and form a new token. The effect is undefined if invalid tokens are produced, or if the result depends on the order of processing of the `##` operators. Also, `##` may not appear at the beginning or end of a replacement token sequence.

The replacement token sequence is repeatedly rescanned for more defined identifiers. However, once a given identifier has been replaced in a given expansion, it is not replaced if it turns up again during rescanning; instead it is left unchanged. Even if the final value of a macro expansion begins with with # , it is not taken to be a preprocessing directive.

* A small trick:

    ```c
    #define cat(x, y)
    ```
the call `cat(var, 123)` yields `var123`. However, the call `cat(cat(1, 2), 3)` is undefined: the presence of `##` prevents the arguments of the outer call from being expanded. Thus it produces the token string `cat ( 1 , 2 )3` and `)3` is not a legal token. If a second level of macro definition is introduced,

    ```c
    #define xcat(x, y)      cat(x, y)
    ```

things work more smoothly; `xcat(xcat(1, 2), 3)` does produce `123`, because the expansion of `xcat` itself does not involve the `##` operator.

##### include

`#include <filename>` vs. `#include "filename"`

# Line Control

```c
# line constant "filename"
# line constant
```

# Error Generation

```c
# error ...
```

# Pragmas

```c
# pragma ...
```

# Null directive

(no effect)

```c
#
```

# Predefined names

* `__LINE__`: A decimal constant containing the current source line number
* `__FILE__`: A string literal containing the name of the file being compiled
* `__DATE__`: A string literal containing the date of compilation, in the form "Mmmm dd yyyy"
* `__TIME__`: A string literal containing the time of compilation, in the form "hh:mm:ss"
* `__STDC__`: The constant 1. It is intended that this identifier be defined to be 1 only in standard-conforming implementations


<br />

## Algorithms in this book

---

* Binary Search

* Shellsort

* Quicksort

* Hash

* Binary Search Tree

<br />

## Good Examples

---

* wc(Unix)

* Recursive-descent Parser

* Listing Directories

* Storage Allocator

<br />

## Standard Library

---

* `<assert.h>`: Diagnostics
* `<ctype.h>`: Character Class Tests
* `<errno.h>`
* `<float.h>`: Implementation-defined Limits
* `<limits.h>`: Implementation-defined Limits
* `<locale.h>`
* `<math.h>`: Mathematical Functions
* `<setjmp.h>`: Non-local Jumps
* `<signal.h>`: Signals
* `<stdarg.h>`: Variable Argument Lists
* `<stddef.h>`
* `<stdio.h>`: Input and Output
* `<stdlib.h>`: Utility Functions
* `<string.h>`: String Functions
* `<time.h>`: Date and Time Functions

---

☯ Yinyanghu, 2013
