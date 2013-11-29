---
title: Selection Algorithm
author: Yinyanghu
tags: Algorithm, TCS, Selection, Sorting, Median, Data Structure
---

In computer science, a selection algorithm is an algorithm for finding the $K$th smallest number in a list or array.

* $K = 1$: Minimum

* $K = 2$: Second minimum

* $K = \lfloor\frac{N}{2}\rfloor$: Median

* $K = N$: Maximum

We introduce some algorithms for solving the selection problem.

<br />

# Sorting \& Partial Sorting

-----

## Selection by sorting

The simplest idea for the selection problem is sorting the list or array and then selecting any desired element. Generally, the sorting algorithm is based on the comparison. The lower bound of the comparsion-based sorting algorithm is $\mathcal{O}(N\log N)$. Quicksort is a good choice!

However, the naive algorithm doesn't means useless. In fact, this algorithm is an online algorithm with $\mathcal{O}(N \log N)$ - Preprocessing time and $\mathcal{O}(1)$ - Querying time. Furthermore, if we need *Insert* operation, we could maintain the structure using Insertion Sorting.

## Selection by partial sorting

In computer science, partial sorting is a relaxed variant of the sorting algorithm. Partial sorting is returning a list of the $K$ smallest(or largest) elements in order.

* **Balanced Binary Search Tree**

Add each element into the BST with at most $K$ elements. Whenever the data structure has more than $K$ elements, we remove the largest element, which can be done in $\mathcal{O}(\log K)$ time. Therefore, the total running time is $\mathcal{O}(N \log K)$.  

* **Heap or Priority Queue**

Since we can build a heap in $\mathcal{O}(N)$ time, getting the $K$ smallest(largest) elements by calling *DeleteMin* $K$ times leads to a time bound of $\mathcal{O}(N + K \log K)$ on this algorithm.

* **Skip Lists**

(Not very clearly!)

<br />

# Quickselect

-----

Linear performance can be archieved by a partition-based selection algorithm, most basically Quickselect. It was developed by Tony Hoare. It is almost the same with the Quicksort developed by Hoare as well.

Quickselect uses the same overall approach as Quicksort, choosing one element as a pivot and partitioning the data in two based on the pivot, accordingly as less than or greater than the pivot. However, instead of recursing into both sides, as in Quicksort, Quickselect only recurses into one side - the side with the element it is searching for. This reduce the average complexity from $\mathcal{O}(N \log N)$ to $\mathcal{O}(N)$.

The performance is directly impacted by the choice of pivot. The easiest solution is to choose a random pivot, like Randomized Quicksort, which yield worst case of $3N + \mathcal{O}(N)$ expected.

<br />

# Median of Medians

-----

To guarantee the worst case is still linear time for the selection problem, **BFPRT**(Blum, Floyd, Pratt, Riveest, Tarjan) use a more sophisticated pivot strategy.

The algorithm consists of an algorithm to find an approximate median in linear time, which is then used as a pivot in Quickselect. In other words, it uses an optimal approximate median-selection algorithm to build an optimal general selection algorithm.

**The approximate median-selection algorithm can also be used as a pivot strategy in Quicksort, yielding an optimal algorithm, with worst-case complexity $\mathcal{O}(N \log N)$.**

### Algorithm

The algorithm divides the list into groups of five elements. Then, for each group of five, the median is calculated. These medians construct a sublist of $N / 5$ elements. And then recursively find the median on this sublist. Finally, the "median of medians" is chosen to be the pivot and continue to find the median using Quickselect.

### Analysis

* Pivot $x$

> **Claim**: The median of medians, $x$, is between $\frac{3}{10}N$ and $\frac{7}{10}N$ in rank.

![](/images/2013-10-02-selection/median.jpg "Pivot")

As shown in the figure, the median of medians $x$ is greater than the elements in gray area($a \rightarrow b$ means the $a < b$, we are assuming all the elements are distinct). And the number of the elements in gray area is $\frac{3}{10}N$. The similar fact is also for the upper bound.

* The running time

$$T(N) \leq T(\frac{N}{5}) + T(\frac{7N}{10}) + \mathcal{O}(N)$$

It's easy to prove that

> If $a + b < 1$ and $T(n) = T(an) + T(bn) + \mathcal{O}(n)$, then $T(n) = \mathcal{O}(n)$

Therefore, $T(N) = \mathcal{O}(N)$

* Why we choose 5 elements as a group?

    * Computing median of an odd list is faster and simpler

    * Five is the smallest odd number such that median of medians works

    * Finding the median of a larger group takes longer time

        **(In the worst case of 5 elements, we need 6 comparisons to find the median)**

(Need more thinking!)

<br />

# LazySelect

-----

(From the [Etone's *Randomized Algorithm* lecture note](http://tcs.nju.edu.cn/wiki/index.php/%E9%9A%8F%E6%9C%BA%E7%AE%97%E6%B3%95\_(Fall\_2011)/Median\_Selection))

We introduce a randomized median selection algorithm called **LazySelect**, which is a variant on a randomized algorithm due to **Floyd** and **Rivest**.

The idea of this algorithm is random sampling. For a set $S$, let $m \in S$ denote the median. We observe that if we can find two elements $d, u \in S$ satisfying the following properties:

1. The median is between $d$ and $u$ in the sorted order, i.e. $d \leq m \leq u$

2. The total number of elements between $d$ and $u$ is small, specially for $C = \{x \in S| d \leq x \leq u\}$, $|C| = \mathcal{o}(n / \log n)$

Provided $d$ and $u$ with these two properties, within linear time, we can compute the rank $d$ in $S$, construct $C$, and sort $C$. Therefore, the median $m$ of $S$ can be picked from $C$ in linear time.

So how can we select such elements $d$ and $u$ from $S$? Certainly sorting $S$ would give us the elements, but isn't that exactly what we want to avoid in the first place?

Observe that $d$ and $u$ are only asked to roughly satisfy some constrains. This hints us maybe we can construct a *sketch* of $S$ which is small enough to sort cheaply and roughly represents $S$, and then pick $d$ and $u$ from this sketch. We construct the sketch by randomly sampling a relatively small number of elements from $S$. Then the strategy of algorithm is outlined by:

> * Sample a set $R$ of elements from $S$
>
> * Sort $R$ and choose $d$ and $u$ somewhere around the median of $R$
> 
> * If $d$ and $u$ have the desirable properties, we can compute the median in linear time, or otherwise the algorithm fails

The parameters to be fixed are, the size of $R$(small enough to sort in linear time and large enough to contain sufficient information of $S$); and the order of $d$ and $u$ in $R$(not too close to have $m$ between them, and not too far away to have $C$ sortable in linear time).

**We choose the size of $R$ as $n^{3/4}$, and $d$ and $u$ are within $\sqrt{n}$ range around the median of $R$**

### Algorithm: LazySelect

> **Input**: a set $S$ of $n$ elements over totally ordered domain.
> 
> 1. Pick a multi-set $R$ of $\left\lceil n^{3/4}\right\rceil$ elements in $S$, chosen independently and uniformly at random with replacement, and sort $R$.
> 
> 2. Let $d$ be the $\left\lfloor\frac{1}{2}n^{3/4}-\sqrt{n}\right\rfloor$-th smallest element in $R$, and let $u$ be the $\left\lceil\frac{1}{2}n^{3/4}+\sqrt{n}\right\rceil$-th smallest element in $R$.
> 
> 3. Construct $C=\{x\in S\mid d\le x\le u\}$ and compute the ranks $r_d=|\{x\in S\mid x < d\}|$ and $r_u=|\{x\in S\mid x < u\}|$.
> 
> 4. If $r_d>\frac{n}{2}$ or $r_u<\frac{n}{2}$ or $|C|>4n^{3/4}$ then return FAIL.
> 
> 5. Sort $C$ and return the $\left(\left\lfloor\frac{n}{2}\right\rfloor-r_d+1\right)$th element in the sorted order of $C$.

### Analysis

The algorithm always terminates in linear time because each line of the algorithm costs at most linear time. The last three line guarantees that the algorithm returns the correct median if it does not fail.

We then only need to bound the probability that the algorithm returns a FAIL. Let $m \in S$ be the median of $S$. By the algorithm, we know that the algorithm returns a FAIL if and only if at least one of the following events occurs:

* $\mathcal{E}_1: Y=|\{x\in R\mid x\le m\}|<\frac{1}{2}n^{3/4}-\sqrt{n}$

* $\mathcal{E}_2: Z=|\{x\in R\mid x\ge m\}|<\frac{1}{2}n^{3/4}-\sqrt{n}$

* $\mathcal{E}_3: |C|>4n^{3/4}$

$\mathcal{E}_3$ directly follows the third condition in Step 4. $\mathcal{E}_1$ and $\mathcal{E}_2$ are a bit tricky. The first condition in Step 4 is that $r_d>\frac{n}{2}$, which looks not exactly the same as $\mathcal{E}_1$, but both $\mathcal{E}_1$ and that $r_d>\frac{n}{2}$ are equivalent to the same event: the $\left\lfloor\frac{1}{2}n^{3/4}-\sqrt{n}\right\rfloor$-th smallest element in $R$ is greater than $m$, thus they are actually equivalent. Similarly, $\mathcal{E}_2$ is equivalent to the second condition of Step 4.

We now bound the probabilities of these events one by one.

> **Lemma 1**: $\Pr[\mathcal{E}_1]\le \frac{1}{4}n^{-1/4}$

> **Proof**:
>
> Let $X_i$ be the $i$th sampled element in Line 1 of the algorithm. Let $Y_i$ be a indicator random variable such that
> $$
Y_i=
\begin{cases}
1, & \mbox{if }X_i\le m\\
0, & \mbox{otherwise}
\end{cases}
$$
>
> It is obvious that $Y=\sum_{i=1}^{n^{3/4}}Y_i$, where $Y$ is as defined in $\mathcal{E}_1$. For every $X_i$, there are $\left\lceil\frac{n}{2}\right\rceil$ elements in $S$ that are less than or equal to the median. The probability that $Y_i=1$ is
>
> $$
p=\Pr[Y_i=1]=\Pr[X_i\le m]=\frac{1}{n}\left\lceil\frac{n}{2}\right\rceil,
$$
>
> which is within the range of $\left[\frac{1}{2},\frac{1}{2}+\frac{1}{2n}\right]$. Thus
>
> $$
\mathbf{E}[Y]=n^{3/4}p\ge \frac{1}{2}n^{3/4}.
$$
> 
> The event $\mathcal{E}_1$ is defined as that $Y<\frac{1}{2}n^{3/4}-\sqrt{n}$.
> 
> Note that $Y_i$'s are Bernoulli trials, and $Y$ is the sum of $n^{3/4}$ Bernoulli trials, which follows binomial distribution with parameters $n^{3/4}$ and $p$. Thus, the variance is 
> 
> $$
\mathbf{Var}[Y]=n^{3/4}p(1-p)\le \frac{1}{4}n^{3/4}.
$$
>
> Applying Chebyshev's inequality,
> $$
\begin{align}
\Pr[\mathcal{E}_1]
&=
\Pr\left[Y<\frac{1}{2}n^{3/4}-\sqrt{n}\right]\\
&\le
\Pr\left[|Y-\mathbf{E}[Y]|>\sqrt{n}\right]\\
&\le
\frac{\mathbf{Var}[Y]}{n}\\
&\le\frac{1}{4}n^{-1/4}.
\end{align}
$$
> $\square$

By a similar analysis, we can obtain the following bound for the event $\mathcal{E}_2$.

> **Lemma 2**: $\Pr[\mathcal{E}_2]\le \frac{1}{4}n^{-1/4}$

We now bound the probability of the event $\mathcal{E}_3$.

> **Lemma 3**: $\Pr[\mathcal{E}_3]\le \frac{1}{2}n^{-1/4}$

> **Proof**:
> 
> The event $\mathcal{E}_3$ is defined as that $|C|>4 n^{3/4}$, which by the Pigeonhole Principle, implies that at leas one of the following must be true:
> 
> * $\mathcal{E}_3'$: at least $2n^{3/4}$ elements of $C$ is greater than $m$;
> * $\mathcal{E}_3''$: at least $2n^{3/4}$ elements of $C$ is smaller than $m$.
> 
> We bound the probability that $\mathcal{E}_3'$ occurs; the second will have the same bound by symmetry.
> 
> Recall that $C$ is the region in $S$ between $d$ and $u$. If there are at least $2n^{3/4}$ elements of $C$ greater than the median $m$ of $S$, then the rank of $u$ in the sorted order of $S$ must be at least $\frac{1}{2}n+2n^{3/4}$ and thus $R$ has at least $\frac{1}{2}n^{3/4}-\sqrt{n}$ samples among the $\frac{1}{2}n-2n^{3/4}$ largest elements in $S$.
> 
> Let $X_i\in\{0,1\}$ indicate whether the $i$th sample is among the $\frac{1}{2}n-2n^{3/4}$ largest elements in $S$. Let $X=\sum_{i=1}^{n^{3/4}}X_i$ be the number of samples in $R$ among the $\frac{1}{2}n-2n^{3/4}$ largest elements in $S$.
> 
> It holds that
> $$
p=\Pr[X_i=1]=\frac{\frac{1}{2}n-2n^{3/4}}{n}=\frac{1}{2}-2n^{-1/4}
$$
> 
> $X$ is a binomial random variable with 
> 
> $$
\mathbf{E}[X]=n^{3/4}p=\frac{1}{2}n^{3/4}-2\sqrt{n},
$$
and
$$
\mathbf{Var}[X]=n^{3/4}p(1-p)=\frac{1}{4}n^{3/4}-4n^{1/4}<\frac{1}{4}n^{3/4}.
$$
> 
> Applying Chebyshev's inequality,
> $$
\begin{align}
\Pr[\mathcal{E}_3']
&=
\Pr\left[X\ge\frac{1}{2}n^{3/4}-\sqrt{n}\right]\\
&\le
\Pr\left[|X-\mathbf{E}[X]|\ge\sqrt{n}\right]\\
&\le
\frac{\mathbf{Var}[X]}{n}\\
&\le\frac{1}{4}n^{-1/4}.
\end{align}
$$
> 
> Symmetrically, we have that $\Pr[\mathcal{E}_3'']\le\frac{1}{4}n^{-1/4}$.
> 
> Applying the union bound
> $$
\Pr[\mathcal{E}_3]\le \Pr[\mathcal{E}_3']+\Pr[\mathcal{E}_3'']\le\frac{1}{2}n^{-1/4}
$$
> $\square$


Combining the three bounds. Applying the union bound to them, the probability that the algorithm returns a FAIL is at most 
$$
\Pr[\mathcal{E}_1]+\Pr[\mathcal{E}_2]+\Pr[\mathcal{E}_3]\le n^{-1/4}.
$$

Therefore the algorithm always terminates in linear time and returns the correct median with high probability.

<br />

# History

-----

## Randomized Algorithm

* [1960' **Hoare**] **Quickselect**, expected running time is $\mathcal{O}(N)$

    $\#$comparison: $3N + \mathcal{o}(N)$ expected

* [1975' **Floyd, Rivest**] Randomized algorithm

    $\#$comparison: $1.5N + \mathcal{o}(N)$ expected

#### Lower Bound

* [1989' **Munro, Cunto**]

    Any randomized algorithm(based on comparison) takes at least $1.5N + \mathcal{o}(N)$ expected $\#$comparisons

## Non-randomized Algorithm

* [1973' **BFPRT**] **Median of medians**, non-randomized selection in $O(N)$ time

#### Upper Bound

* [1973' **BFPRT**] $5.43N + \mathcal{o}(N)$

* [1976' **Schonhage, Paterson, Pippenger**] $3N + \mathcal{o}(N)$

* [1995' **Dor, Zwick**] $2.95N$

#### Lower Bound

* [1973' **BFPRT**] $1.5N - \mathcal{O}(1)$

* [1982' **Munro, Poblete**] $1.83N - \mathcal{O}(1)$

* [1985' **Bent, John**] $2N - \mathcal{o}(N)$

* [1996' **Dor, Zwick**] $(2 + \epsilon)N$, $\epsilon = 2^{-80}$

## Conclusion

* Randomization provably helps!

* It is still unknown **exactly** how many comparisons are needed to determine the median.

<br />

# Lower Bound

-----

> [1973' **BFPRT**] **Theorem**: Finding the median $m$ of $n$ elements takes $\geq 1.5n$ comparisons in worst case.

> **Proof**:
>
> Any algorithm that tries to find the median needs to know the median and know the elements that are bigger and the ones that are smaller. Therefore you have to establish a path of comparison between each element and the median to establish the median. Therefore, $n - 1$ comparisions are essential.
> 
> To find a lower bound, you can imagine a game in which your are trying to minimize the number of comparisons and the adversary will try to force maximizing the number of comparisons. So the adversary in this case would try to force maximizing the number of comparisons. So the adversary in this case would try to do comparisons that are not necessary to establish the median.(Adversary argument)
> 
> ![](/images/2013-10-02-selection/lbA.png "lower bound")
> 
> Every time a comparison is done, he would put the winner up and the looser down, and he can do so until he either identified $n/2$ winners or $n/2$ looser. Playing this game, the adversary can force $(n - 1)/2$ extra comparisons to be made but then you still have to do $n - 1$ comparisons to establish the median, so that $1.5n$ comparisons have to be done in total.
> 
> ![](/images/2013-10-02-selection/lbB.png "lower bound")

<br />

# Reference

-----

* [Wikipedia: Selection Algorithm](http://en.wikipedia.org/wiki/Selection\_algorithm)

* [Wikipedia: Quickselect](http://en.wikipedia.org/wiki/Quickselect)

* [Wikipedia: Median of Medians](http://en.wikipedia.org/wiki/Median\_of\_medians)

* [Wikipedia: Partial Sorting](http://en.wikipedia.org/wiki/Partial\_sorting)

* [Wikipedia: Online Algorithm](http://en.wikipedia.org/wiki/Online\_algorithm)

* [Book] Introduction to Algorithms (Third Edition) - *Cormen, Leiserson, Rivest & Stein*

* [Book] Probability and Computing: Rnadomized Algorithms and Probabilistic Analysis - *Mitzenmacher & Upfal*

* University of Waterloo, [CS466 Lecture Note](https://www.student.cs.uwaterloo.ca/~cs466/Lecture7.pdf)

* The University of British Columbia, [CS 500 Lecture Note](http://www.cs.ubc.ca/~romanh/courses/cpsc500/lectures/L08-1006.pdf)

* [Etone, Randomized Algorithm: Median Selection](http://tcs.nju.edu.cn/wiki/index.php/%E9%9A%8F%E6%9C%BA%E7%AE%97%E6%B3%95\_(Fall\_2011)/Median\_Selection), [Slide](ftp://tcs.nju.edu.cn/slides/random2011/random4.pdf)

* [Paper] Progress in Selection - *M Peterson* - 1997

* [Paper] Expected Time Bounds for Selection - *RW Floyd & RL Rivest* - 1975

* [Paper] On Lower Bounds for Selecting the Median - *D Dor, J Hstad, S Ulfberg & U Zwick* - 1996

* [Paper] Finding the Median - *A Schonhage, M Paterson & N Pippenger* - 1976

* [Paper] Median selection requires $(2 + \epsilon)n$ comparisons - *D Dor & U Zwick* - 1999

* [Paper] Time Bounds for Selection - *M Blum, RW Floyd, V Pratt, RL Rivest & RE Tarjan* - 1973

* [Paper] A Lower Bound for Determining the Median - *JI Munro & PV Poblete* - 1982

* [Paper] Selecting the median - *D Dor & U Zwick* - 1995

* [Paper] Finding the Median Requires $2n$ Comparisons - *SW Bent & JW John* - 1985

* [Paper] Algorithm 63 (PARTITION) and algorithm 65 (FIND) - *CAR Hoare* - 1961

<br />

-----

☯ Yinyanghu, 2013

