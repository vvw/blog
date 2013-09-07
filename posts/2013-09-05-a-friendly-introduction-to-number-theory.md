---
title: [Book] A Friendly Introduction to Number Theory - Silverman(Incomplete...)
author: Yinyanghu
tags: Book, Number Theory, Mathematics, Algorithm, Note
---

![](/images/2013-09-05-frint/book.jpg "A Friendly Introduction to Number Thoery")

## Theorems

---

#### Theorem A: Fermat's Last Theorem

> The equation $a^n + b^n = c^n$ has no solutions in positive integers if $n \geq 3$

* attack: modularity, elliptic curve

* proof: [Andrew Wiles](http://en.wikipedia.org/wiki/Andrew_Wiles)

<br />

#### Theorem B: Linear Equation Theorem

> Let $a$ and $b$ be nonzero integers, and let $g = gcd(a, b)$. The equation $ax + by = g$ always has a solution $(x_0, y_0)$ in integers, and this solution can be found by the Euclidean algorithm method. Then every solution to the equation can be obtained by substituting integers $k$ into the formula $$(x_0 + k \cdot \frac{b}{g}, y_0 - k \cdot \frac{a}{g})$$

Special Solution $\Longrightarrow$ General Solution
$$(x_0 + k \cdot \frac{b}{g})\cdot a + (y_0 - k \cdot \frac{a}{g}) \cdot b = ax_0 + by_0 = gcd(a, b)$$

<br />

#### Theorem C: The Fundamental Theorem of Arithmetic

> Every integer $n \geq 2$ can be factored into a product of primes $n = p_1p_2\cdots p_r$ in exactly one way

<br />

#### Theorem D: Linear Congruence Theorem

> let $a$, $c$ and $m$ be integers with $m \geq 1$, and let $g = gcd(a, m)$
>
> (1) if $g \nmid c$, then the congruence $ax \equiv c \pmod{m}$ has no solution
>
> (2) if $g \mid c$, then the congruence $ax \equiv c \pmod{m}$ has exactly $g$ incongruent solutions

<br />

#### Theorem E: Fermat's Little Theorem

> Let $p$ be a prime number, and let $a$ be any number with $a \not\equiv 0 \pmod{p}$. Then $a^{p - 1} \equiv 1 \pmod{p}$

<br />

#### Theorem E+: Euler's Theorem

> If $gcd(a, m) = 1$, then $a^{\phi(m)} \equiv 1 \pmod{m}$

<br />

#### Theorem F: Chinese Reminder Theorem

> Let $m$ and $n$ be integers with $gcd(m, n) = 1$, and let $b$ and $c$ be any integers. Then the simultaneous congruences
> $$\begin{equation} \begin{cases}x \equiv b \pmod{m} \\ x \equiv c \pmod{n} \end{cases} \end{equation}$$
> have exactly one solution with $o \leq x < mn$

<br />

#### Theorem G: Dirichlet's Theorem on Primes in Arithmetic Progressions

> Let $a$ and $m$ be integers with $gcd(a, m) = 1$. Then, there are infinitely many primes that congruent to $a$ modulo $m$
>
> That is, there are infinitely many prime numbers $P$ satisfying $P \equiv a \pmod{m}$

<br />

#### Theorem H: Infinitely Many Primes Theorem

> There are infinitely many prime numbers

<br />

#### Theorem I: The Prime Number Theorem

> When $x$ is large, the number of primes less than $x$ is approximately equal to $\frac{x}{\ln(x)}$, i.e.
> $$\lim_{x \rightarrow \infty}\frac{\pi(x)}{x/ln(x)} = 1$$

<br />

#### Theorem J: Euclid's Perfect Number Formula

> If $2^P - 1$ is a prime number, then $2^{P-1}(2^P - 1)$ is a perfect number

<br />

#### Theorem J+: Euclid's Perfect Number Theorem

> If $n$ is an even perfect number, then $n$ looks like $n = 2^{P - 1}(2^P - 1)$ where $2^P - 1$ is a Mersenne Prime

<br />

#### Theorem K: Korselt's Criterion for Carmichael Numbers

> Let $n$ be a composite number. Then $n$ is a Carmichael number $\iff$ it is odd and every prime $P$ dividing $n$ satisfies the following conditions:
>
> 1. $P^2 \nmid n$
>
> 2. $(P - 1) \mid (n - 1)$

> (A Carmichael number is a composite number $n$ with the property that $a^n \equiv a \pmod{n}$ for every integer $1 \leq a \leq n$)

<br />

#### Theorem L: Euler's Phi Function Summation Formula

> Let $d_1, d_2, \cdots, d_r$ be the divisors of $n$. Then,
> $$\phi(d_1) + \phi(d_2) + \cdots + \phi(d_r) = n$$

<br />

#### Theorem M: Primitive Root Theorem

> Every prime $P$ has a primitive root. More precisely, there are exactly $\phi(P - 1)$ primitive root modulo $P$

##### Lemma

> Define $\psi(d) = \#a$ with $1 \leq a < p$ and $e_P(a) = d$
>
> $\psi = \phi$

<br />
<br />

## Properties

---

#### Property A: Euler's Phi Function

> * $\displaystyle \phi(m) = m(1 - \frac{1}{p_1})(1 - \frac{1}{p_2})\cdots(1 - \frac{1}{p_r})$, which $p_1, p_2, \cdots, p_r$ are the distinct primes that divide $m$
>
> * If $gcd(m, n) = 1$, then $\phi(mn) = \phi(m) \cdot \phi(n)$

<br />

#### Property B: Mersenne Primes

> If $a^n - 1$ is prime for some numbers $a \geq 2$ and $n \geq 2$, then $a = 2$ and $n$ must be a prime

<br />

#### Property C: Sigma Function

> * $\displaystyle\sigma(n) = \sum_{k \mid n} k$ (sum of all divisors of $n$)
>
> * If $P$ is a prime and $k \geq 1$, then
> $$ \sigma(P^k) = 1 + P + P^2 + \cdots + P^k = \frac{P^{k + 1} - 1}{P - 1}$$
>
> * If $gcd(m, n) = 1$, then $\sigma(mn) = \sigma(m)\cdot\sigma(n)$

<br />

#### Property D: A Property of Prime Numbers

> Let $P$ be an odd prime and write $P - 1 = 2^k \cdot q$ with odd $q$
>
> Let $a$ be any number not divisible by $P$. Then, *one* of the following two conditions is true:
>
> 1. $a^q \equiv 1 \pmod{P}$
>
> 2. one of the numbers $a^q, a^{2q}, a^{4q}, \cdots, a^{2^{k - 1}q} \equiv -1 \pmod{P}$

Since $P$ is a prime, the only number $k$ satisfying $k^2 \equiv 1 \pmod{P}$ is $k \equiv -1 \pmod{P}$

<br />

#### Property E: Order Divisibility Property

> * The order of a modulo $P$ is
>
>       $\begin{align}e_P(a) = \mbox{minimize } &e \\ \mbox{s.t. } &a^e \equiv 1 \pmod{P}\end{align}$
>
> * Let $P$ be a prime and $a$ be an integer satisfying $P \nmid a$. Suppose that $a^n \equiv 1 \pmod{P}$, then $e_P(a) \mid n$
>
> * $e_P(a) \mid (P - 1)$
>
> * A number $g$ with maximum order $e_P(g) = P - 1$ is called a *primitive root modulo $P$*

<br />
<br />

## Conjectures

---

#### Conjecture A: Goldbach's Conjecture

> Every even number $n \geq 4$ is a sum of two primes

<br />

#### Conjecture B: The Twin Primes Conjecture

> There are infinitely many prime numbers $P$, so that $P + 2$ is also prime

<br />

#### Conjecture C: The $N^2 + 1$ Conjecture

> There are infinitely many primes of the form $N^2 + 1$

<br />

#### Conjecture D: No Perfect Number Conjecture

> There is no odd perfect number

<br />

#### Conjecture E: Infinitely Many Carmichael Number Conjecture

> There are infinitely many Carmichael numbers

<br />

#### Conjecture F: Artin's Conjecture

> There are infinitely many primes $P$ such that 2 is a primitive root modulo $P$

<br />

#### Conjecture F+: The Generalized Artin's Conjecture

> Let $a$ be any integer that is not a perfect square and is not equal to -1. Then, there are infinitely many primes $P$ such that $a$ is a primitive root modulo $P$

<br />
<br />

## Algorithms

---

#### Algorithm A: The Euclidean Algorithm

$$
\begin{equation}
gcd(a, b) = \begin{cases}
    gcd(b, a \bmod  b), & \text{if } b \neq 0 \\
    a, & \text{otherwise}
    \end{cases}
\end{equation}
$$

Running time: $O(\log(\max(a, b)))$

<br />

#### Algorithm A+: The Extended Euclidean Algorithm

> To find a special solution to the linear equation
>
> $$ax + by = gcd(a, b)$$

$$
\begin{equation}
\begin{cases}
ax + by = gcd(a, b) \\
bx' + (a - \lfloor\frac{a}{b}\rfloor b)y' = gcd(a, b)
\end{cases}
\Rightarrow
\begin{cases}
x = y' \\
y = x' - \lfloor \frac{a}{b} \rfloor y'
\end{cases}
\end{equation}
$$

basis: $(x, y) = (1, 0)$

Running time: $O(\log(\max(a, b)))$

<br />

#### Algorithm B: Naive Method for Factoring or Checking Primality

For $n$, try dividing it by every prime number $2, 3, 5, \cdots, (\leq \sqrt{n})$

Running time: $O(\sqrt{n})$

<br />

#### Algorithm C: Finding All the Solutions to a Congruence

1. Find a solution $(u_0, v_0)$ to the linear equation $$ au + mv = g = gcd(a, m)$$

2. Then, $x_0 = u_0 \cdot \frac{c}{g}$ is a solution to $ax \equiv c \pmod{m}$

3. All the solutions: $$x \equiv x_0 + k \cdot \frac{m}{g} \pmod{m}, k = 0, 1, \cdots, g - 1$$

Special Solution $ax \equiv g \pmod{m}$ $\Longrightarrow$ Special Solution $ax \equiv c \pmod{m}$ $\Longrightarrow$ General Solution $ax \equiv c \pmod{m}$

<br />

#### Algorithm D: Solving the Simultaneous Congruences

$$
\begin{equation}
\begin{cases}
x \equiv b \pmod{m} \\
x \equiv c \pmod{n}
\end{cases}
\Rightarrow
\begin{cases}
x = b + my \\
x \equiv c \pmod{n}
\end{cases}
\Rightarrow
my \equiv c - b \pmod{n}
\end{equation}
$$
Since $gcd(m, n) = 1$, we can use *Algorithm C* to solve it

<br />

#### Algorithm E: Repeated Squaring to Compute $a^k \pmod{m}$

<br />

#### Algorithm F: Compute $K$-th Roots Modulo $m$

Let $b$, $k$ and $m$ be given integers that satisfy $gcd(b, m) = gcd(k, \phi(m)) = 1$.

Finding a solution to the congruence $x^k \equiv b \pmod{m}$

1. Compute $\phi(m)$ (Hard! **factorization**)

2. Find the inverse of $k$ modulo $\phi(m)$: $u$

    ($ku - \phi(m)v = 1$)

3. $x \equiv b^u \pmod{m}$

<br />

#### Algorithm G: Miller–Rabin Primality Test

Let $n$ be an odd integer and write $n - 1 = 2^k\cdot q$ with odd $q$. If *both* of the following conditions are true for some $a$ satisfying $n \nmid a$, then $n$ is a composite number

1. $a^q \not\equiv 1 \pmod{n}$

2. $a^{2^{i}q} \not\equiv -1 \pmod{n}$ for all $i = 0, 1, \cdots, k - 1$

(If $n$ is an odd composite number, then at least 75% of the numbers $a$ between 1 and $n - 1$ act as Miller-Rabin witnesses for $n$)

---

☯ Yinyanghu, 2013
