# LTF Raw Calibration Has Linear Worst Case

## Statement

For each $n$, define

$$ R_{\mathrm{LTF}}(n) := \max\lbrace\rho(T):T:\lbrace0,1\rbrace^{n}\to\lbrace0,1\rbrace\text{ is a nonconstant LTF}\rbrace. $$

There is an absolute constant $c\gt0$ and infinitely many $n$ such that

$$ R_{\mathrm{LTF}}(n)\geq c n. $$

Consequently, there are nonconstant linear threshold functions

$$ V_n:\lbrace0,1\rbrace^{n}\to\lbrace0,1\rbrace $$

with

$$ H^{\ast}(V_n)=1 \qquad \text{and} \qquad \rho(V_n)\geq c n. $$

> **Interpretation.** Computing an LTF after the final threshold and raw-calibrating its $0/1$ indicator are different tasks. The gap can grow linearly.

## Proof

Use the halfspace-intersection family from [105_halfspace_intersection_head_lower_bound.md](105_halfspace_intersection_head_lower_bound.md). Thus, for infinitely many $n$, there are LTFs

$$ T_n,U_n:\lbrace0,1\rbrace^{n}\to\lbrace0,1\rbrace $$

such that

$$ F_n(x):=T_n(x)\wedge U_n(x) $$

satisfies

$$ H^{\ast}(F_n)\geq c_0 n $$

for an absolute constant $c_0\gt0$.

On the other hand, $F_n$ is a strict weighted vote of the two Boolean features $T_n$ and $U_n$:

$$ F_n(x)=1 \qquad\Longleftrightarrow\qquad T_n(x)+U_n(x)-\frac{3}{2}\gt0. $$

Applying the raw-calibrated vote support bound [093_raw_calibrated_vote_support_bound.md](093_raw_calibrated_vote_support_bound.md) gives

$$ H^{\ast}(F_n) \leq \rho(T_n)+\rho(U_n). $$

Therefore

$$ \rho(T_n)+\rho(U_n)\geq c_0 n. $$

At least one of $T_n$ and $U_n$ has raw calibration cost at least $c_0n/2$. Let $V_n$ be such a choice. A constant Boolean feature has raw calibration cost $0$, because the definition of $\rho$ allows an added constant. Hence $V_n$ is nonconstant. Since $V_n$ is a nonconstant LTF, the one-head characterization gives

$$ H^{\ast}(V_n)=1. $$

Taking $c=c_0/2$ proves both displayed claims. $\blacksquare$

## Consequences

There is no finite-valued function $g$ of the head count alone such that

$$ \rho(T)\leq g(H^{\ast}(T)) $$

for all Boolean functions $T$, even after restricting to LTFs. The left side is unbounded on functions with $H^{\ast}(T)=1$.

Thus raw calibration cost is a genuine additional parameter in calibrated threshold-vote and decision-list upper bounds. It is not controlled by the fact that an inner feature is itself one-head computable.
