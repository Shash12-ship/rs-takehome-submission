# Multi-Raw Gate Sandwich And Single-Slice Exactness

## Statement

Let

$$ T(y)=F(t(y)), \qquad t(y)=\sum_{i=1}^{m}\lambda_i y_i, \qquad \lambda_i\gt0, $$

be a nonconstant positive-statistic feature. Write the image of $t$ as

$$ \tau_0\lt\tau_1\lt\cdots\lt\tau_{M-1}, $$

and let $C$ be the sign-change count of $F$ along this image. Put

$$ e_{\min}:=F(\tau_0), \qquad e_{\max}:=F(\tau_{M-1}). $$

For a Boolean gate

$$ G:\lbrace0,1\rbrace^{k}\times\lbrace0,1\rbrace\to\lbrace0,1\rbrace, $$

define

$$ H_G(z,y):=G(z,T(y)), $$

and write

$$ g_e(a):=G(a,e) \qquad \text{for }e\in\lbrace0,1\rbrace. $$

Let

$$ N_G:=\left\lvert\lbrace a\in\lbrace0,1\rbrace^{k}:g_0(a)\neq g_1(a)\rbrace\right\rvert. $$

Then the following sandwich holds:

$$ \max\left\lbrace \mathbf{1}_{N_G\gt0}H^{\ast}(T), H^{\ast}(g_0), H^{\ast}(g_1) \right\rbrace \leq H^{\ast}(H_G) \leq N_GC+B_{+}(g_{e_{\max}},g_{e_{\min}}). $$

Here $\mathbf{1}_{N_G\gt0}H^{\ast}(T)$ means $0$ if $N_G=0$ and $H^{\ast}(T)$ otherwise.

In particular, if

$$ H^{\ast}(T)=C, \qquad N_G=1, \qquad B_{+}(g_{e_{\max}},g_{e_{\min}})=0, $$

then

$$ H^{\ast}(H_G)=C. $$

> **Interpretation.** Multi-raw gates over one positive-statistic feature have a usable two-sided bracket. If exactly one raw slice depends on the feature and the endpoint boundary can be made silent, the upper bound is exact whenever the feature itself is exact.

## Proof

The upper bound is exactly the positive mixed boundary gate bound [151_positive_mixed_boundary_gate_bound.md](151_positive_mixed_boundary_gate_bound.md).

For the lower bounds, use restriction monotonicity from Lemma 28. Since $T$ is nonconstant, it attains both values $0$ and $1$ on the finite cube.

Fix $e\in\lbrace0,1\rbrace$ and choose $y^{(e)}$ such that

$$ T(y^{(e)})=e. $$

Restricting $H_G$ to this value of $y$ gives the raw function

$$ z\mapsto G(z,e)=g_e(z). $$

Therefore

$$ H^{\ast}(g_e)\leq H^{\ast}(H_G) $$

for $e=0,1$.

If $N_G\gt0$, choose a raw assignment $a$ with

$$ g_0(a)\neq g_1(a). $$

Then the one-variable slice

$$ y\mapsto G(a,T(y)) $$

is either $T(y)$ or $1-T(y)$. Complement invariance and restriction monotonicity give

$$ H^{\ast}(T)\leq H^{\ast}(H_G). $$

Combining these lower bounds with the upper bound proves the sandwich.

Under the final hypotheses, the upper bound becomes

$$ H^{\ast}(H_G)\leq C. $$

The lower bound from the dependent raw slice gives

$$ H^{\ast}(H_G)\geq H^{\ast}(T)=C. $$

Thus $H^{\ast}(H_G)=C$. $\blacksquare$

## Consequence

This theorem turns the ordered-slice upper bounds into exact theorems whenever the feature is already solved and the raw gate has only one feature-dependent slice with no endpoint jump.
