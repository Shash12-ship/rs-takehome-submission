# Multi-Raw Gate Over Positive-Statistic Feature Bound

## Statement

Let $k\geq1$, let $z\in\lbrace0,1\rbrace^{k}$ be raw bits, and let

$$ T(y)=F(t(y)), \qquad t(y)=\sum_{i=1}^{m}\lambda_i y_i, \qquad \lambda_i\gt0. $$

Write the image of $t$ as

$$ \tau_0\lt\tau_1\lt\cdots\lt\tau_{M-1}, $$

and let $C$ be the sign-change count of $F$ along this ordered image. Let

$$ G:\lbrace0,1\rbrace^{k}\times\lbrace0,1\rbrace\to\lbrace0,1\rbrace $$

be any Boolean gate, and define

$$ H_G(z,y):=G(z,T(y)). $$

Choose positive raw weights $\rho_1,\ldots,\rho_k$ with distinct subset sums, and order the raw assignments as in Lemma 147. For each raw assignment $a$, define the one-variable slice

$$ G_a(u):=G(a,u). $$

Let

$$ N_G:=\left\lvert\lbrace a:G_a\text{ is }u\text{ or }1-u\rbrace\right\rvert. $$

Let $J_{\rho,G}$ be the number of boundary jumps between consecutive raw slices:

$$ J_{\rho,G} := \left\lvert \left\lbrace q\in\lbrace0,\ldots,2^k-2\rbrace: G_{a^{(q)}}(F(\tau_{M-1})) \neq G_{a^{(q+1)}}(F(\tau_0)) \right\rbrace \right\rvert. $$

Then

$$ H^{\ast}(H_G)\leq N_G C+J_{\rho,G}. $$

> **Interpretation.** A multi-raw gate over one positive-statistic feature pays one copy of the feature's variation for each raw slice that actually depends on the feature, plus actual boundary jumps between raw slices.

## Proof

For each raw assignment $a$, the slice

$$ H_G(a,y)=G_a(T(y)) $$

is either constant, $T(y)$, or $1-T(y)$. If it is constant, its sign-change count along $t$ is $0$. If it is $T$ or $1-T$, its sign-change count is $C$. Hence the total within-slice contribution in Lemma 147 is $N_GC$.

The boundary contribution in Lemma 147 is exactly $J_{\rho,G}$ by definition. Applying Lemma 147 gives

$$ H^{\ast}(H_G)\leq N_GC+J_{\rho,G}. $$

$\blacksquare$

## Consequence

For $k=1$, Lemmas 139 and 140 can be sharper because they exploit algebraic relations between the two slices. For larger $k$, this lemma is a direct multi-slice fallback whose quality depends on the raw-slice ordering.
