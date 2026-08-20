# Output-Normalized Atomic-Margin Sparsification

## Statement

Let $f : \lbrace0,1\rbrace^n \to \lbrace0,1\rbrace$ and put $y_x=2f(x)-1$. Let $\mathcal A_n\subseteq\mathbb R^{2^n}$ be the symmetric set of all valid one-head score vectors on the cube, normalized by

$$ \lVert a\rVert_{\infty}\leq1. $$

Suppose there exist $c\in\mathbb R$, $\Lambda\gt0$, $\gamma\gt0$, and $u\in\mathrm{conv}(\mathcal A_n)$ such that

$$ y_x(c+\Lambda u_x)\geq\gamma\qquad\text{for every }x\in\lbrace0,1\rbrace^n. $$

Then there is an absolute constant $C$ such that

$$ H^{\ast}(f)\leq C(n+1)\left(\frac{\Lambda}{\gamma}\right)^2. $$

Define the output-normalized atomic condition number

$$ \kappa_{\mathrm{atom}}(f)=\inf\left\lbrace\frac{\Lambda}{\gamma}:y_x(c+\Lambda u_x)\geq\gamma,\quad u\in\mathrm{conv}(\mathcal A_n),\quad \Lambda\gt0,\quad \gamma\gt0\right\rbrace. $$

For every nonconstant $f$,

$$ H^{\ast}(f)\leq C(n+1)\kappa_{\mathrm{atom}}(f)^2. $$

> **Interpretation.** A well-conditioned convex combination of genuine one-head score vectors can be sparsified into a short exact head representation. The normalization is in function-output space, not in a parameter norm.

## Proof

Let $V=2^n$ and choose

$$ p=\max\lbrace2,\lceil\log V\rceil\rbrace. $$

Every normalized atom satisfies

$$ \lVert a\rVert_p\leq V^{1/p}\leq e. $$

The approximate Carathéodory theorem of [Mirrokni, Paes Leme, Vladu, and Wong](https://arxiv.org/abs/1512.08602) says that a point in the convex hull of a set contained in an $\ell_p$ ball of radius $D$ can be approximated within $\varepsilon$ in $\ell_p$ norm by a convex combination of

$$ O\left(\frac{D^2p}{\varepsilon^2}\right) $$

points from the set. Apply it to $u$ with $D=e$ and

$$ \varepsilon=\frac{\gamma}{2\Lambda}. $$

There are atoms $a^{(1)},\ldots,a^{(m)}\in\mathcal A_n$ and convex weights $\alpha_j$ such that

$$ \widetilde u=\sum_{j=1}^{m}\alpha_j a^{(j)},\qquad \lVert\widetilde u-u\rVert_p\leq\frac{\gamma}{2\Lambda}, $$

with

$$ m\leq C(n+1)\left(\frac{\Lambda}{\gamma}\right)^2 $$

for an absolute constant $C$. Since $\lVert z\rVert_{\infty}\leq\lVert z\rVert_p$,

$$ y_x(c+\Lambda\widetilde u_x)\geq\frac\gamma2\gt0 $$

at every cube vertex.

Each $a^{(j)}$ is a valid one-head score vector. The coefficient $\Lambda\alpha_j$ is absorbed into that head's final readout weight, and $c$ is the global readout bias. Hence $c+\Lambda\widetilde u$ is an $m$-head score with the signs of $f$. This proves the first claim. Taking the infimum gives the invariant bound. $\blacksquare$

## Certificate And Estimation Consequence

For a fixed strictly positive oriented denominator $B$, pricing a normalized affine numerator $A$ against residual weights $r_x$ is a linear program:

$$ \max_A\sum_x r_x\frac{A(x)}{B(x)}\qquad\text{subject to}\qquad -B(x)\leq A(x)\leq B(x)\quad\text{for every }x. $$

The denominator remains an outer nonlinear variable, but a finite denominator library gives an ordinary atomic max-margin master problem. Column generation can alternate between:

1. solving the active atomic-margin master;

2. pricing normalized numerators for candidate denominators;

3. searching the denominator simplex for a better priced atom;

4. sparsifying, rationalizing, and verifying the resulting finite head score on the full cube.

A rational finite atomic decomposition with a positive exact cube margin is already a direct upper certificate. The theorem explains why a good output-normalized margin should lead to a short decomposition. Failure to find a small atomic condition number is not a lower bound on $H^{\ast}(f)$.
