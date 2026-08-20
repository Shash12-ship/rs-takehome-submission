# Symmetric-Feature One-Bit Gate Exactness

## Statement

Let

$$ T:\lbrace0,1\rbrace^{m}\to\lbrace0,1\rbrace $$

be a nonconstant symmetric Boolean function. Let $C$ be the number of sign changes in its Hamming-weight sequence

$$ T(0),T(1),\ldots,T(m). $$

For any two-input Boolean gate $G$, define

$$ H_G(z,y):=G(z,T(y)). $$

Then

$$ H^{\ast}(H_G)= \begin{cases} 0 & \text{if }G\text{ is constant},\cr 1 & \text{if }G\text{ is a raw-bit literal},\cr C+1 & \text{if }G\text{ is XOR or XNOR},\cr C & \text{otherwise}. \end{cases} $$

> **Interpretation.** The exact symmetric classification is stable under adjoining one raw bit and applying any two-input gate.

## Proof

Write

$$ t(y)=\sum_{i=1}^{m}y_i. $$

Then $T(y)=F(t(y))$ for a positive statistic $t$, and $C$ is exactly the sign-change count of $F$ on the ordered image $\lbrace0,1,\ldots,m\rbrace$.

The symmetric exactness theorem [012_symmetric_sign_changes.md](../01_foundations_and_normal_form/012_symmetric_sign_changes.md) gives

$$ \deg_{\pm}(T)=H^{\ast}(T)=C. $$

The degree-tight positive-statistic gate classification [141_degree_tight_positive_statistic_gate_classification.md](141_degree_tight_positive_statistic_gate_classification.md) now applies and gives the displayed table. $\blacksquare$

## Consequence

For parity on $m$ feature variables, $C=m$. Thus XOR with a fresh raw bit has exact value $m+1$, while every non-XOR feature-dependent one-bit gate over parity has exact value $m$.
