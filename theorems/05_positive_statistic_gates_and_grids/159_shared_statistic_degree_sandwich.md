# Shared-Statistic Degree Sandwich

## Statement

Use the setup of Theorem 158. Suppose that for each raw assignment $a$ there is a univariate polynomial $P_a(u)$ of degree at most $d_a$ such that

$$ \mathrm{sgn}(P_a(t(y)))= \begin{cases} +1 & \text{if } f(a,y)=1,\cr -1 & \text{if } f(a,y)=0 \end{cases} $$

for every $y\in\lbrace0,1\rbrace^{m}$. Let

$$ \delta_a:=\deg_{\pm}\bigl(F_a(t(y))\bigr), $$

and define the endpoint raw functions

$$ q(a):=F_a(\tau_0), \qquad p(a):=F_a(\tau_{M-1}). $$

Then

$$ \max_a \delta_a \leq H^{\ast}(f) \leq \sum_a d_a+B_{+}(p,q). $$

In particular, if $d_a\leq d$ for all $a$, then

$$ H^{\ast}(f)\leq2^k d+B_{+}(p,q). $$

If all endpoints are a common label $b$, then

$$ \max_a\delta_a \leq H^{\ast}(f) \leq \sum_a d_a. $$

> **Interpretation.** Slice threshold degree gives the lower side, univariate sign-polynomial degree gives the upper side, and the only coupling term is the mixed endpoint boundary.

## Proof

Let $C_a$ be the sign-change count of the slice $F_a$ along the ordered image of $t$.

For the lower bound, restrict $f$ to each raw assignment $a$. Restriction monotonicity and the threshold-degree lower bound give

$$ \delta_a\leq H^{\ast}\bigl(F_a(t(y))\bigr)\leq H^{\ast}(f). $$

Taking the maximum over $a$ gives

$$ \max_a\delta_a\leq H^{\ast}(f). $$

For the upper bound, fix $a$. The polynomial $P_a$ is nonzero on every point of the image of $t$, because it strictly sign-represents the slice. If the slice label changes between consecutive image points, then $P_a$ changes sign between those two points and has a real root in the open interval between them. Distinct adjacent sign changes give disjoint intervals, so

$$ C_a\leq d_a. $$

The shared-statistic slice sandwich [158_shared_statistic_slice_sandwich.md](158_shared_statistic_slice_sandwich.md) gives

$$ H^{\ast}(f) \leq \sum_a C_a+B_{+}(p,q) \leq \sum_a d_a+B_{+}(p,q). $$

If $d_a\leq d$ for all $a$, then $\sum_a d_a\leq2^k d$, giving the uniform-degree bound.

If all endpoints are the same label $b$, Theorem 158 gives $B_{+}(p,q)=0$, which gives the final bracket. $\blacksquare$

## Consequence

This theorem refines Lemma 150 by adding the lower side and by expressing the boundary term as the optimized mixed endpoint cost.
