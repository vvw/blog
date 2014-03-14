---
title: Algorithm W
author: Yinyanghu
tags: Algorithm, Lambda Calculus, Type Inference, Logic
---

> This is the original type inference algorithm of Damas and Miller.

* The input to the algorithm is an expression and a typing environment (context) which is a set of assumptions, i.e. bindings of type variables to type expressions.

* The output of the algorithm is a type for the given expression, and a substitution of type expressions for types which results in the overall type.

---

$W(\Gamma, expr) = (\sigma, T)$, where

* $\Gamma$ is the context
* $expr$ is the expression to be typed
* $\sigma$ is the substitution of type expressions for type variables which gives the value of $T$
* $T$ is the type of $expr$

Several cases:

* if $expr$ is a **variable**, say $x$

	$W(\Gamma, expr) = (\emptyset, instantiate(x))$, where

    * $instantiate(x) = [a_1 \rightarrow b_1][a_2 \rightarrow b_2]\cdots[a_n \rightarrow b_n]T_x$,
    * $x:(\forall a_1, a_2, \cdots, a_n)T_x \in \Gamma$,
    * and $b_1, b_2, \cdots, b_n$ are fresh variables
	

* if $expr$ is an **abstraction** ($\lambda$ expression), say $\lambda x.f$

	$W(\Gamma, expr) = (\sigma_1, \sigma_1 X \rightarrow T_f)$, where
	
	* $W(\Gamma \cup \{x:X\}, f) = (\sigma_1, T_f)$,
	* and $X$ is a fresh variable


* if $expr$ is an **application**, say $expr = f g$

	$W(\Gamma, expr) = (\sigma_3 \circ \sigma_2 \circ \sigma_1, \sigma_3 X)$, where
	
	* $W(\Gamma, f) = (\sigma_1, T_f)$,
	* $W(\sigma_1 \Gamma, g) = (\sigma_2, T_g)$,
	* $U(\sigma_2 T_f, T_g \rightarrow X) = \sigma_3$,
	* and $X$ is a fresh variable
	

* if $expr$ is a **conditional**, say if $cond$ then $f$ else $g$
	
	$W(\Gamma, expr) = (\sigma_5 \circ \sigma_4 \circ \sigma_3 \circ \sigma_2 \circ \sigma_1, \sigma_5 T_g)$, where
	
	* $W(\Gamma, cond) = (\sigma_1, T_{cond})$,
    * $U(T_{cond}, Bool) = \sigma_2$,
    * $W(\sigma_2 \sigma_1 \Gamma, f) = (\sigma_3, T_f)$,
    * $W(\sigma_3 \sigma_2 \sigma_1 \Gamma, g) = (\sigma_4, T_g)$,
    * and $U(\sigma_4 T_f, T_g) = \sigma_5$


* if $expr$ is a **fix-point expression**, say fix $x.f$

    $W(\Gamma, expr) = (\sigma_2 \circ \sigma_1,\sigma_2 \circ \sigma_1 \circ X)$, where

    * $W(\Gamma \cup \{ x:X \}, f) = (\sigma_1, T_f)$,
    * $U(\sigma_1 X, T_f) = \sigma_2$,
    * and $X$ is a fresh variable

* if $expr$ is a **let expression**, say let $x = f$ in $g$

	$W(\Gamma, expr) = (\sigma_2 \circ \sigma_1, T_g)$, where

	* $W(\Gamma, f) = (\sigma_1, T_f)$,
	* $W(\sigma_1 \Gamma \cup \{ x:poly(T_f) \}, g) = (\sigma_2, T_g)$, where $poly(T_f) = (\forall x_1, x_2, \cdots, x_n)T_f$, and $x_1, x_2, \cdots, x_n$ are the free variables in $T_f$ which do not appear in $\sigma_1 \Gamma$.

---

* _Damas_ and _Milner_ proved that Algorithm W computes the **principal type** scheme for a given expression and context.

* According to _Cardelli(1985)_, the order of type inference does NOT affect the final result and it solves the system of type constraints.

* This version taken from _Field_ and _Harrison_, also treats expressions involving the fix-point operator **fix**.

---

# Reference

* [Algorithm W](http://www.exso.com/courses/cs101a/slides/ml/sml10/node19.html)

* [Wikipedia: Hindley-Milner type system](https://en.wikipedia.org/wiki/Hindley%E2%80%93Milner_type_system)

-----

☯ Yinyanghu, 2014
