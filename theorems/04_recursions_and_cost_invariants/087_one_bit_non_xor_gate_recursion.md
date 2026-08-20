# One-Bit Non-XOR Gate Recursion

## Statement

Let

$$ T : \lbrace0,1\rbrace^{m}\to\lbrace0,1\rbrace $$

be any Boolean function, and let

$$ G : \lbrace0,1\rbrace^{2}\to\lbrace0,1\rbrace $$

be a two-input Boolean gate that is neither XOR nor XNOR. Define

$$ F(z,y):=G(z,T(y)). $$

Then

$$ H^{\ast}(F)\leq H^{\ast}(T)+1. $$

In particular,

$$ H^{\ast}(z\wedge T(y))\leq H^{\ast}(T)+1, \qquad H^{\ast}(z\vee T(y))\leq H^{\ast}(T)+1, $$

and the same bound holds after complementing either input literal or the output.

> **Interpretation.** One fresh raw bit can be combined with an arbitrary previously computed feature through any non-XOR two-input gate at the cost of one additional head. The XOR and XNOR gates remain the exceptional recursive cases.

## Proof

If $T$ is constant, then $F$ is either constant or a one-bit function of $z$. Hence $H^{\ast}(F)\leq1=H^{\ast}(T)+1$. Assume from now on that $T$ is nonconstant.

Let $H:=H^{\ast}(T)$. By the linear-fractional normal form [010_linear_fractional_normal_form.md](../01_foundations_and_normal_form/010_linear_fractional_normal_form.md), there is an $H$-atom score

$$ S(y) = c+\sum_{h=1}^{H}\phi_h(y) $$

such that

$$ T(y)=1 \qquad\Longleftrightarrow\qquad S(y)\gt0. $$

By complement invariance [028_restrictions_and_sign_rank.md](../02_complexity_measure_upper_bounds/028_restrictions_and_sign_rank.md), the same head count also sign-represents $1-T$, using the score $-S$.

Every two-input Boolean gate that is neither XOR nor XNOR is, up to constants, input literals, and output complement, either a conjunction of two literals or a disjunction of two literals. Constant gates and input-literal gates have head complexity at most $\max\lbrace H,1\rbrace\leq H+1$. Thus it is enough to handle

$$ r(z)\wedge U(y) \qquad \text{and} \qquad r(z)\vee U(y), $$

where $r(z)$ is either $z$ or $1-z$, and $U$ is either $T$ or $1-T$.

Choose a score $S_U(y)$ with $H$ atoms such that

$$ U(y)=1 \qquad\Longleftrightarrow\qquad S_U(y)\gt0. $$

The dummy-variable construction from [028_restrictions_and_sign_rank.md](../02_complexity_measure_upper_bounds/028_restrictions_and_sign_rank.md) gives the following stronger fact: for every $\eta\gt0$, the same $H$ atoms can be realized on the enlarged input $(z,y)$ with a score $S_{U,\eta}(z,y)$ satisfying

$$ \lvert S_{U,\eta}(z,y)-S_U(y)\rvert\lt\eta \qquad \text{for all }(z,y). $$

The raw literal $r(z)$ also admits arbitrarily accurate one-head atom approximations on the enlarged cube. For $r(z)=z$, use

$$ \psi_{z,\eta}(z,y) := \frac{z}{\delta+z+\kappa\sum_i y_i}. $$

For $r(z)=1-z$, use

$$ \psi_{\bar z,\eta}(z,y) := \frac{1-z}{\delta+1-z+\kappa\sum_i(1-y_i)}. $$

The denominators have a common orientation and stay positive on the cube, so the denominator-orientation theorem [032_denominator_orientation.md](../02_complexity_measure_upper_bounds/032_denominator_orientation.md) makes these one-head atoms. Taking $\delta$ and $\kappa$ small makes the chosen atom $\psi_{r,\eta}$ uniformly $\eta$-close to $r$.

### Conjunction

Let

$$ M:=\max_{y}S_U(y). $$

Since $U$ is nonconstant, $M\gt0$. Pick $A\gt0$ and $B\gt A M$. Consider the ideal score

$$ R_{\wedge}(z,y):=A S_U(y)+B r(z)-B. $$

If $r(z)=1$, then

$$ R_{\wedge}(z,y)=A S_U(y), $$

so its sign is the sign of $U(y)$. If $r(z)=0$, then

$$ R_{\wedge}(z,y)=A S_U(y)-B\leq A M-B\lt0. $$

Thus $R_{\wedge}$ sign-represents $r\wedge U$ with a positive finite margin $\Delta_{\wedge}$. Choose approximation errors for $S_U$ and $r$ so that

$$ A\lvert S_{U,\eta}(z,y)-S_U(y)\rvert +B\lvert \psi_{r,\eta}(z,y)-r(z)\rvert \lt \frac{\Delta_{\wedge}}{2} $$

for every $(z,y)$. Then

$$ A S_{U,\eta}(z,y)+B\psi_{r,\eta}(z,y)-B $$

has the same sign as $R_{\wedge}$ everywhere. This uses the $H$ approximate dummy-extended atoms for $U$ and one additional atom for $r$.

Therefore

$$ H^{\ast}(r\wedge U)\leq H+1. $$

### Disjunction

Let

$$ m:=\min_{y}S_U(y). $$

Since $U$ is nonconstant, $m\lt0$. Pick $A\gt0$ and $B\gt A(-m)$. Consider

$$ R_{\vee}(z,y):=A S_U(y)+B r(z). $$

If $r(z)=0$, then $R_{\vee}(z,y)=A S_U(y)$, so its sign is the sign of $U(y)$. If $r(z)=1$, then

$$ R_{\vee}(z,y)\geq A m+B\gt0. $$

Thus $R_{\vee}$ sign-represents $r\vee U$ with positive finite margin $\Delta_{\vee}$. Again choose the approximation errors for $S_U$ and $r$ small enough that

$$ A\lvert S_{U,\eta}(z,y)-S_U(y)\rvert +B\lvert \psi_{r,\eta}(z,y)-r(z)\rvert \lt \frac{\Delta_{\vee}}{2} $$

everywhere. Then

$$ A S_{U,\eta}(z,y)+B\psi_{r,\eta}(z,y) $$

has the same sign as $R_{\vee}$ everywhere. This gives an $(H+1)$-head representation of $r\vee U$.

The conjunction and disjunction cases cover all non-XOR gates after the literal and complement reductions above. Hence

$$ H^{\ast}(F)\leq H^{\ast}(T)+1. $$

$\blacksquare$

## Consequences

The cofactor-recursion target is settled for one of its two simplest feature-dependent cases:

$$ H^{\ast}(z\wedge T)\leq H^{\ast}(T)+1. $$

The same proof handles $z\vee T$, implications, reverse implications, NAND, NOR, and all literal variants.

Combined with the one-bit gate threshold-degree trichotomy, this isolates XOR and XNOR as the only one-bit gates that both raise threshold degree and remain outside the proved $H^{\ast}(T)+1$ recursion theorem.
