# Monotone Antichain Upper Bound

## Statement

Let

$$ f : \lbrace0,1\rbrace^n \to \lbrace0,1\rbrace $$

be monotone. For a set $S\subseteq\lbrace1,\ldots,n\rbrace$, write $1_S$ for its indicator vector.

Define the minimal true sets

$$ \mathcal{M}_1(f) := \left\lbrace S : f(1_S)=1 \text{ and } f(1_T)=0 \text{ for every } T\subsetneq S \right\rbrace, $$

and the maximal false sets

$$ \mathcal{M}_0(f) := \left\lbrace S : f(1_S)=0 \text{ and } f(1_T)=1 \text{ for every } T\supsetneq S \right\rbrace. $$

Then

$$ H^{\ast}(f) \leq \min\lbrace\lvert\mathcal{M}_1(f)\rvert,\lvert\mathcal{M}_0(f)\rvert\rbrace. $$

Moreover, both $\mathcal{M}_1(f)$ and $\mathcal{M}_0(f)$ are antichains, so Sperner's bound gives

$$ H^{\ast}(f) \leq \binom{n}{\lfloor n/2\rfloor}. $$

> **Interpretation.** Every monotone Boolean function has a head bound controlled by its boundary antichain. This is often much smaller than the generic positive-projection interpolation bound $2^n-1$.

## Proof

### Lemma 1. Minimal true sets give a monotone DNF

If $\mathcal{M}_1(f)=\varnothing$, then $f$ is constant $0$ by monotonicity, and $H^{\ast}(f)=0$.

If $\varnothing\in\mathcal{M}_1(f)$, then $f$ is constant $1$ by monotonicity, and $H^{\ast}(f)=0$.

Otherwise, every set in $\mathcal{M}_1(f)$ is nonempty. We claim

$$ f(x) = \bigvee_{S\in\mathcal{M}_1(f)} \bigwedge_{i\in S}x_i. $$

If the right-hand side is true, then $x_i=1$ for all $i\in S$ for some minimal true set $S$. Thus $1_S\leq x$ coordinatewise, so monotonicity gives $f(x)=1$.

Conversely, suppose $f(x)=1$. Let

$$ X:=\lbrace i:x_i=1\rbrace. $$

Since $f(1_X)=1$ and the cube is finite, there is a subset $S\subseteq X$ minimal under inclusion with $f(1_S)=1$. Then $S\in\mathcal{M}_1(f)$, so the corresponding conjunction is true on $x$.

Thus $f$ has a monotone DNF with $\lvert\mathcal{M}_1(f)\rvert$ nonempty terms. The monotone DNF upper bound from [029_monotone_dnf_upper_bound.md](029_monotone_dnf_upper_bound.md) gives

$$ H^{\ast}(f)\leq\lvert\mathcal{M}_1(f)\rvert. $$

### Lemma 2. Maximal false sets give a monotone CNF

If $\mathcal{M}_0(f)=\varnothing$, then $f$ is constant $1$ by monotonicity, and $H^{\ast}(f)=0$.

If $\lbrace1,\ldots,n\rbrace\in\mathcal{M}_0(f)$, then $f$ is constant $0$ by monotonicity, and $H^{\ast}(f)=0$.

Otherwise, every set $\lbrace1,\ldots,n\rbrace\setminus S$ with $S\in\mathcal{M}_0(f)$ is nonempty. We claim

$$ f(x) = \bigwedge_{S\in\mathcal{M}_0(f)} \bigvee_{i\notin S}x_i. $$

If $f(x)=0$, set

$$ X:=\lbrace i:x_i=1\rbrace. $$

Since $f(1_X)=0$ and the cube is finite, there is a superset $S\supseteq X$ maximal under inclusion with $f(1_S)=0$. Then $S\in\mathcal{M}_0(f)$, and the clause $\bigvee _{i\notin S}x_i$ is false because $X\subseteq S$.

Conversely, suppose the displayed CNF is false. Then for some $S\in\mathcal{M}_0(f)$, every coordinate outside $S$ has $x_i=0$. Equivalently, if $X=\lbrace i:x_i=1\rbrace$, then $X\subseteq S$. Since $f(1_S)=0$ and $1_X\leq1_S$, monotonicity gives $f(x)=0$.

Thus $f$ has a monotone CNF with $\lvert\mathcal{M}_0(f)\rvert$ nonempty clauses. The monotone CNF upper bound from [029_monotone_dnf_upper_bound.md](029_monotone_dnf_upper_bound.md) gives

$$ H^{\ast}(f)\leq\lvert\mathcal{M}_0(f)\rvert. $$

Combining Lemmas 1 and 2 gives

$$ H^{\ast}(f) \leq \min\lbrace\lvert\mathcal{M}_1(f)\rvert,\lvert\mathcal{M}_0(f)\rvert\rbrace. $$

### Lemma 3. The boundary families are antichains

If $S,T\in\mathcal{M}_1(f)$ and $S\subsetneq T$, then $T$ is not minimal true, a contradiction. Hence $\mathcal{M}_1(f)$ is an antichain.

If $S,T\in\mathcal{M}_0(f)$ and $S\subsetneq T$, then $S$ is not maximal false, a contradiction. Hence $\mathcal{M}_0(f)$ is an antichain.

### Lemma 4. Sperner's bound

Let $\mathcal{A}\subseteq2^{\lbrace1,\ldots,n\rbrace}$ be an antichain. A maximal chain in the subset lattice is determined by an ordering of the $n$ coordinates, so there are $n!$ maximal chains.

A set $S$ of size $k$ lies in exactly

$$ k!(n-k)! $$

maximal chains: first order the elements of $S$, then order the elements outside $S$.

Since $\mathcal{A}$ is an antichain, every maximal chain contains at most one set from $\mathcal{A}$. Therefore

$$ \sum_{S\in\mathcal{A}} \lvert S\rvert!(n-\lvert S\rvert)! \leq n!. $$

Dividing by $n!$ gives

$$ \sum_{S\in\mathcal{A}} \frac{1}{\binom{n}{\lvert S\rvert}} \leq 1. $$

For every $S$,

$$ \binom{n}{\lvert S\rvert} \leq \binom{n}{\lfloor n/2\rfloor}. $$

Thus

$$ \frac{\lvert\mathcal{A}\rvert}{\binom{n}{\lfloor n/2\rfloor}} \leq \sum_{S\in\mathcal{A}} \frac{1}{\binom{n}{\lvert S\rvert}} \leq 1, $$

and

$$ \lvert\mathcal{A}\rvert \leq \binom{n}{\lfloor n/2\rfloor}. $$

Applying this to $\mathcal{M}_1(f)$ and $\mathcal{M}_0(f)$ proves

$$ H^{\ast}(f) \leq \binom{n}{\lfloor n/2\rfloor}. $$

$\blacksquare$

## Consequence

For monotone functions, the relevant upper-bound parameter is not the total number of true inputs but the size of the monotone boundary. In particular,

$$ H^{\ast}(f) \leq \min\lbrace\lvert\mathcal{M}_1(f)\rvert,\lvert\mathcal{M}_0(f)\rvert\rbrace \leq \binom{n}{\lfloor n/2\rfloor}. $$

For symmetric monotone thresholds this recovers only $H^{\ast}(f)\leq1$, because the boundary has one layer. For general monotone functions, it gives a uniform sub $2^n$ upper bound from antichain structure alone.
