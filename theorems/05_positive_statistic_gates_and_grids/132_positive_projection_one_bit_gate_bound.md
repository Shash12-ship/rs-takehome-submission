# Positive-Projection One-Bit Gate Bound

## Statement

Let

$$ t(y)=\sum_{i=1}^{m}\lambda_i y_i, \qquad \lambda_i\gt0, $$

and let $F:\mathrm{Im}(t)\to\lbrace0,1\rbrace$. Define

$$ T(y):=F(t(y)). $$

Write the image of $t$ as

$$ 0=\tau_0\lt\tau_1\lt\cdots\lt\tau_{M-1}. $$

Let $G:\lbrace0,1\rbrace^{2}\to\lbrace0,1\rbrace$ be any two-input Boolean gate, and define

$$ H_G(z,y):=G(z,T(y)). $$

Form the concatenated gate sequence

$$ \mathcal{S}_{G,t} := G(0,F(\tau_0)),\ldots,G(0,F(\tau_{M-1})), G(1,F(\tau_0)),\ldots,G(1,F(\tau_{M-1})). $$

Let $C_{G,t}$ be the number of sign changes in this sequence. Then

$$ H^{\ast}(H_G)\leq C_{G,t}. $$

More precisely:

1. If $C_{G,t}=0$, then $H^{\ast}(H_G)=0$.

2. If $C_{G,t}=1$, then $H^{\ast}(H_G)=1$.

3. If $C_{G,t}=2$, then

$$ H^{\ast}(H_G)= \begin{cases} 1 & \text{if } H_G \text{ is a nonconstant LTF},\cr 2 & \text{otherwise}. \end{cases} $$

> **Interpretation.** A raw bit appended to a positive-projection feature remains a positive projection after separating the two slices. The cost is the sign-change count of the two gate slices written end to end.

## Proof

Choose

$$ B\gt\tau_{M-1}. $$

Define the positive weighted sum

$$ s(z,y):=Bz+t(y). $$

Its image is ordered as

$$ \tau_0\lt\tau_1\lt\cdots\lt\tau_{M-1}\lt B+\tau_0\lt B+\tau_1\lt\cdots\lt B+\tau_{M-1}. $$

Define $R:\mathrm{Im}(s)\to\lbrace0,1\rbrace$ by

$$ R(\tau_j):=G(0,F(\tau_j)), \qquad R(B+\tau_j):=G(1,F(\tau_j)). $$

Then

$$ H_G(z,y)=R(s(z,y)). $$

The sign-change count of $R$ along the ordered image of $s$ is exactly $C_{G,t}$, by construction. The positive-projection sign-change theorem [013_positive_projection_sign_changes.md](../01_foundations_and_normal_form/013_positive_projection_sign_changes.md) gives

$$ H^{\ast}(H_G)\leq C_{G,t}. $$

If $C_{G,t}=0$, then $R$ is constant on $\mathrm{Im}(s)$, so $H_G$ is constant and $H^{\ast}(H_G)=0$.

If $C_{G,t}=1$, then the same theorem gives $H^{\ast}(H_G)\leq1$, and $H_G$ is nonconstant. The zero-head and one-head characterization [011_one_head_characterization.md](../01_foundations_and_normal_form/011_one_head_characterization.md) gives

$$ H^{\ast}(H_G)=1. $$

If $C_{G,t}=2$, then $H^{\ast}(H_G)\leq2$. If $H_G$ is a nonconstant LTF, the one-head characterization gives $H^{\ast}(H_G)=1$. Otherwise $H_G$ is nonconstant and not an LTF, so the same characterization gives $H^{\ast}(H_G)\geq2$. Hence $H^{\ast}(H_G)=2$ in the non-LTF case. $\blacksquare$

## Consequences

Let $C$ be the sign-change count of $F$ along $\mathrm{Im}(t)$. For literal gates such as $z\wedge T$, $z\vee T$, and their complements, the concatenated sequence has at most $C+1$ sign changes. Therefore

$$ H^{\ast}(z\wedge T)\leq C+1, \qquad H^{\ast}(z\vee T)\leq C+1, $$

and the same bound holds for their complements.

For XOR and XNOR, this lemma recovers the doubled sign-change count in [131_positive_projection_fresh_xor_sign_change_bound.md](131_positive_projection_fresh_xor_sign_change_bound.md).
