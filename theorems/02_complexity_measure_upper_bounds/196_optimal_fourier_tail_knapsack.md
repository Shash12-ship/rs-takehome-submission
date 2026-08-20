# Optimal Fourier-Tail Knapsack

## Statement

Let $f : \lbrace0,1\rbrace^n \to \lbrace0,1\rbrace$, put $q(x)=2f(x)-1$, let $V=2^n$, and use the unnormalized Walsh coefficients

$$ c_S=\sum_{x\in\lbrace0,1\rbrace^n}q(x)\chi_S(x),\qquad q(x)=\frac1V\sum_S c_S\chi_S(x). $$

Always retain the constant coefficient $c_{\varnothing}$. Bundle all nonzero singleton coefficients into one item of value

$$ m_1=\sum_{\lvert S\rvert=1}\lvert c_S\rvert $$

and cost one. For every $S$ with $\lvert S\rvert\geq2$ and $c_S\neq0$, create one item of value $\lvert c_S\rvert$ and cost $\lvert S\rvert$.

If a set $I$ of these items leaves omitted value strictly below $V$, then

$$ H^{\ast}(f)\leq\sum_{j\in I}\mathrm{cost}(j). $$

Moreover, the minimum right side obtainable from this Fourier-tail criterion can be computed exactly in

$$ O(nV^2) $$

integer-arithmetic operations. Computing the Walsh coefficients first costs $O(nV)$ operations. A one-dimensional dynamic program uses $O(nV)$ value storage, and a standard reconstruction pass recovers an optimal retained support.

> **Scope.** This optimizes the sufficient Fourier-tail certificate from Theorem 45. It does not compute the minimum Fourier support of an arbitrary sign polynomial, and it does not compute $H^{\ast}(f)$.

## Proof

### Lemma 1. Tail mass gives a strict sign certificate

For a retained family $\mathcal A$ containing the constant coefficient, put

$$ R(x)=\sum_{S\in\mathcal A}c_S\chi_S(x). $$

The unnormalized Walsh inversion formula gives

$$ Vq(x)-R(x)=\sum_{S\notin\mathcal A}c_S\chi_S(x). $$

Since every Walsh character has absolute value one,

$$ \lvert Vq(x)-R(x)\rvert\leq\sum_{S\notin\mathcal A}\lvert c_S\rvert. $$

If the omitted mass is below $V$, then $\lvert q(x)-R(x)/V\rvert\lt1$ at every vertex. Hence $q(x)R(x)\gt0$ everywhere. The Fourier support-cost compiler in Theorem 45 proves the displayed head bound. $\blacksquare$

### Lemma 2. Singleton coefficients form one indivisible cost class

All retained constant and singleton Walsh characters form one affine function. They therefore cost at most one head in total. Once that one-head cost is paid, retaining every nonzero singleton coefficient can only decrease the omitted mass and cannot increase the compiler cost. Thus an optimal tail certificate either omits all singleton coefficients or retains all of them. This justifies the bundled singleton item. $\blacksquare$

### Lemma 3. Exact dynamic program

Let the item values be positive integers $m_j$ and the costs be positive integers $w_j$. Let

$$ M=\sum_jm_j,\qquad T=\max\lbrace0,M-V+1\rbrace. $$

Because all quantities are integral, omitted mass below $V$ is equivalent to retained item value at least $T$. For each cost $c$, keep the maximum retained value achievable with cost exactly $c$. The usual descending-cost zero-one knapsack update is

$$ D_{\mathrm{new}}(c)=\max\lbrace D_{\mathrm{old}}(c),D_{\mathrm{old}}(c-w_j)+m_j\rbrace. $$

The answer is the least $c$ with $D(c)\geq T$.

There are at most $V$ items. Their total cost is at most

$$ 1+\sum_{\lvert S\rvert\geq2}\lvert S\rvert\leq1+nV. $$

Consequently, the dynamic program takes $O(nV^2)$ integer operations and $O(nV)$ value storage. Backtracking data may be stored directly, or the support may be recovered with a standard divide-and-conquer reconstruction pass. Lemmas 1 and 2 show that the recovered support has the minimum compiler cost among all certificates based on the absolute Fourier-tail test. $\blacksquare$

## Algorithmic Consequence

The fast default is the greedy ordering by coefficient mass per head cost, followed by exact full-cube verification. It takes one Walsh-Hadamard transform and a support sort. Run the exact knapsack only when the greedy Fourier upper bound is close enough to the current lower bound that an optimal tail certificate could close the interval.

The implementation is `optimal_fourier_tail_upper_bound` in `src/hstar/sparse_ptf.py`. It groups characters by degree, sorts each equal-cost group by mass, and runs the knapsack over degree-prefix choices. The verifier compares its answer with brute-force item selection on all $256$ three-bit truth tables. On the fixed six-bit mask `0xcc4b244f3c92d063`, it improves the greedy tail compiler cost from $119$ to $117$.

The spectral viewpoint is adjacent to the sparse polynomial-threshold analysis of [Bruck and Smolensky](https://doi.org/10.1137/0221003). The exact knapsack conclusion here uses the repository's model-specific Fourier compiler and the strict finite-cube tail inequality.
