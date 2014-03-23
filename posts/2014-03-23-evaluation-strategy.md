---
title: Evaluation Strategy
author: Yinyanghu
tags: Programming Language, Lambda Calculus
---

# Strict evaluation

---

In strict evaluation, the arguments to a function are always evaluated completely before the function is applied.

**Eager evaluation**: The evaluation strategy where evaluation of all function arguments is done before their values are required.

Church encoding: eager evaluation of operators maps to strict evaluation of functions.

Eager evaluation is used to implement strict functions.

### Applicative order

* Alias: leftmost innermost

* Example:

```
double x = plus x x
average x y = divide (plus x y) 2

double (average 2 4) =>
double (divide (plus 2 4) 2) =>
double (divide 6 2) =>
double 3 =>
plus 3 3 =>
6
```

### Call by value

* Features:

	* The argument expression is evaluated, and the resulting value is bound to the corresponding variable in the function.
			
	* Anything passed into a function call is unchanged in the caller's scope when the function returns.

* Used in languages: C, Pascal, Scheme, OCaml, Java, Common Lisp

### Call by reference

* Features:

	* A function receives an implicit reference to a variable used as argument, rather than a copy of its value. 

	* Provide an additional channel of communication between the called function and the calling function.
	
	* In purely functional languages there is typically no semantic difference between *call-by-reference* and *call-by-value*, since their data structures are immutable. So they are typically described as *call by value* even though implementations frequently use *call-by-reference* internally for the efficiency benefits.
	
* Used in languages: FORTRAN, Perl (default); C++, PHP, Visual Basic, .NET, C# (supported)

### Call by sharing

* Alias: call by object, call by object-sharing

* Features:

	* Combine *call-by-value* and *call-by-reference*
	
	* Assignment to function arguments within the function cannot be visible to the caller's scope.

	* Mutation to function arguments within the function can be visible to the caller's scope.
	
	* For immutable objects, there is no real difference between *call-by-value* and *call-by-sharing*.

* Used in languages: Python, Ruby, Scheme, OCaml

* Example(Python):
	
```
def f(l):
	l.append(1)

def g(l):
	l = l + [1]
	
m = n = []
print f(m)
print g(n)
```

<br />

# Non-strict evaluation

---

In non-strict evaluation, arguments to a function are not evaluated unless they are actually used in the evaluation of the function body.

**Lazy evaluation**: The evaluation strategy which delays the evaluation of an expression until its value is needed and which also avoids repeated evaluations.

The benefits of lazy evaluation include:

* Performance increases by avoiding needless calculations, and error conditions in evaluating compound expressions

* The ability to construct potentially infinite data structures

* The ability to define control flow as abstractions instead of primitives

Church encoding: lazy evaluation of operators maps to non-strict evaluation of functions.

### Normal order

* Alias: leftmost outermost

* Example:

```
double x = plus x x
average x y = divide (plus x y) 2

double (average 2 4) =>
plus (average 2 4) (average 2 4) =>
plus (divide (plus 2 4) 2) (average 2 4) =>
plus (divide 6 2) (average 2 4) =>
plus 3 (average 2 4) =>
plus 3 (divide (plus 2 4) 2) =>
plus 3 (divide 6 2) =>
plus 3 3 =>
6
```


### Call by name

* Features:
	
	* The arguments to a function are not evaluated before the function is called.
	
	* They are substituted directly into the function body using **capture-avoiding substitution**.

	* If an argument is not used in the function body, the argument is never evaluated.
	
	* But if it is used several times, it is re-evaluated each time it appears.(*call-by-name* is often slower.)
	
* Used in languages: Algol 60

### Call by need

* Features:

	* A memorized version of *call-by-name* where, if the function argument is evaluated, that value is stored for subsequent uses.
	
	* In purely functional languages, this produces the same results as *call-by-name*, but always faster.
	
	* Lazy evaluation is the most commonly used implementation strategy for *call-by-need*.
	
* Used in languages: Haskell, R, .NET(supported)

* Example(Haskell):

```
fibs = 0 : 1 : zipWith (+) fibs (tail fibs)
```

<br />

# Nondeterministic strategy

---

### Full beta-reduction

### Call by future

### Optimistic evaluation

<br />

# Reference

---

* [Wikipedia: Evaluation strategy](http://en.wikipedia.org/wiki/Evaluation_strategy)

* [Wikipedia: Lazy evaluation](http://en.wikipedia.org/wiki/Lazy_evaluation)

* [Wikipedia: Eager evaluation](http://en.wikipedia.org/wiki/Eager_evaluation)

* [Wikipedia: Reduction strategy(lambda calculus)](http://en.wikipedia.org/wiki/Reduction_strategy_(lambda_calculus))

* [Wikipedia: Lambda Calculus](http://en.wikipedia.org/wiki/Lambda_calculus)

* [Wikipedia: Church encoding](http://en.wikipedia.org/wiki/Church_encoding)

* [Normal Order and Applicative Order](http://mitpress.mit.edu/sicp/full-text/sicp/book/node85.html)

* [Lecture24: Evaluation Strategies](http://www.cse.iitd.ac.in/~saroj/LFP/LFP_2013/sml6.pdf)

* [Operational Semantics of Pure Functional Languages](http://courses.cs.washington.edu/courses/cse505/99au/functional/applicative-normal.pdf)

* [CSE 505 Lecture Notes: Parameter Passing](http://courses.cs.washington.edu/courses/cse505/99au/imperative/parameters.html)

---

☯ Yinyanghu, 2014

