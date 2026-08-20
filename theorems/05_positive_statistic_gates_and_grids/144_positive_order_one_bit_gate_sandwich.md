# Positive-Order One-Bit Gate Sandwich

## Statement

Let $f:\lbrace0,1\rbrace^{m}\to\lbrace0,1\rbrace$, and let $C_{+}(f)$ be the optimized positive-projection sign-change count from [013_positive_projection_sign_changes.md](../01_foundations_and_normal_form/013_positive_projection_sign_changes.md). For a two-input gate $G$, define

$$ H_G(z,y):=G(z,f(y)). $$

Then:

1. if $G$ is constant, then $H^{\ast}(H_G)=0$;
2. if $G$ is a raw-bit literal, then $H^{\ast}(H_G)=1$;
3. if $f$ is nonconstant and $G$ is XOR or XNOR, then

$$ \deg_{\pm}(f)+1 \leq H^{\ast}(H_G) \leq C_{+}(f)+1; $$

4. if $f$ is nonconstant and $G$ is any other feature-dependent gate, then

$$ \deg_{\pm}(f) \leq H^{\ast}(H_G) \leq C_{+}(f). $$

For constant $f$, the same table reduces to the exact constant or raw-bit literal cases.

> **Interpretation.** The positive-order sign-change invariant is stable under one-bit gates, with exactly one extra unit for XOR and XNOR.

## Proof

The constant and raw-bit literal cases are immediate. If $f$ is constant, then every $G(z,f(y))$ is constant or a raw-bit literal, so the final sentence follows.

Assume now that $f$ is nonconstant. By the definition of $C_{+}(f)$, choose a positive weighted sum

$$ t(y)=\sum_{i=1}^{m}\lambda_i y_i, \qquad \lambda_i\gt0, $$

and a function $F$ on the image of $t$ such that

$$ f(y)=F(t(y)) $$

and the ordered label sequence of $F$ has exactly $C_{+}(f)$ sign changes.

Apply the positive-statistic one-bit gate sandwich [143_positive_statistic_one_bit_gate_sandwich.md](143_positive_statistic_one_bit_gate_sandwich.md) to $T=f$ and $C=C_{+}(f)$. The lower bounds are the one-bit gate threshold-degree trichotomy and the general inequality $\deg_{\pm}\leq H^{\ast}$; the upper bounds are Lemmas 139 and 140 optimized over the positive projection. $\blacksquare$

## Consequence

The desired recursion

$$ H^{\ast}(z\oplus f)\leq H^{\ast}(f)+1 $$

holds for every function with $H^{\ast}(f)=C_{+}(f)$. More generally, this lemma gives the proved fallback

$$ H^{\ast}(z\oplus f)\leq C_{+}(f)+1 $$

for every Boolean function $f$.
