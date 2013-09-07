---
title: Probability Space
author: Yinyanghu
tags: Probability, Mathematics, Theory, TCS
---

## Probability Space

---

A probability space is a **triple** $(\Omega, \Sigma, \Pr)$

* The [sample space](http://en.wikipedia.org/wiki/Sample_space) $\Omega$, which is the arbitrary non-empty set of all possible outcomes

* The [$\sigma$-algebra](http://en.wikipedia.org/wiki/Sigma-algebra) $\Sigma \subseteq 2^{\Omega}$, which is a set of subsets of $\Omega$ (the set of all [events](http://en.wikipedia.org/wiki/Event_(probability_theory))), satisfying

    * (K1) $\Omega \in \Sigma$ and $\emptyset \in \Sigma$ (the *certain* event and the *impossible* evnt)

    * (K2) If $A, B \in \Sigma$, then $A \cap B, A \cup B, A - B \in \Sigma$ (*intersection*, *union* and *difference* of two events are events)

* The probability measure $\Pr: \Sigma \rightarrow \mathbb{R}$ is a function that maps each event to a non-negative real number, satisfying

    * (K3) $\Pr(\Omega) = 1$

    * (K4) If $A \cap B = \emptyset$ (*disjoint* events), then $\Pr(A \cup B) = \Pr(A) + \Pr(B)$

    * (K5) For a decreasing sequence of events $A_1 \supset A_2 \supset \cdots A_n \supset \cdots$ of events with $\displaystyle \bigcap_{n}A_n = \emptyset$, it holds that $\displaystyle \lim_{n \rightarrow \infty} \Pr(A_n) = 0 $

---

The statements (K1) ~ (K5) are axioms of probability.

The last axiom (K5) is redundant if $\Sigma$ is finite, thus it is only essential when there are infinitely many events. The role of axiom (K5) in probability theory is like [Zorn's Lemma](http://en.wikipedia.org/wiki/Zorn\'s_lemma) (or equivalently the [Axiom of Choice](http://en.wikipedia.org/wiki/Axiom_of_choice)) in axiomatic set theory.

The axiom foundation of probability theory is laid by [Kolmogorov](http://en.wikipedia.org/wiki/Andrey_Kolmogorov), one of the greatest mathematician of the 20th century, who advanced various very different fields of mathematics.

<br />

## Reference

---

* [Wikipedia: Probability space](http://en.wikipedia.org/wiki/Probability_space)

* [Etone, Randomized Algorithm: Probability Space](http://tcs.nju.edu.cn/wiki/index.php/%E9%9A%8F%E6%9C%BA%E7%AE%97%E6%B3%95_(Fall_2011)/Probability_Space)

---

☯ Yinyanghu, 2013
