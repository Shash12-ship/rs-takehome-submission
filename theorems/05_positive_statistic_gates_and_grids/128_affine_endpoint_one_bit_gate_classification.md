# Affine Endpoint One-Bit Gate Classification

## Statement

Let

$$ L(y)=a+\sum_{i=1}^{m}\alpha_i y_i $$

be a nonconstant affine statistic on $\lbrace0,1\rbrace^{m}$. Let $E$ be either endpoint predicate

$$ E_{\min}(y)=\mathbf{1}[L(y)=\ell_{\min}] \qquad \text{or} \qquad E_{\max}(y)=\mathbf{1}[L(y)=\ell_{\max}], $$

where

$$ \ell_{\min}:=\min_y L(y), \qquad \ell_{\max}:=\max_y L(y). $$

For any two-input Boolean gate $G:\lbrace0,1\rbrace^{2}\to\lbrace0,1\rbrace$, define

$$ F(z,y):=G(z,E(y)). $$

Then

$$ H^{\ast}(F)= \begin{cases} 0 & \text{if } G \text{ is constant},\cr 2 & \text{if } G \text{ is XOR or XNOR},\cr 1 & \text{otherwise}. \end{cases} $$

> **Interpretation.** For affine endpoint features, the one-bit gate split is exact. The only genuinely two-head interactions are fresh-bit XOR and XNOR.

## Proof

First record the structure of affine endpoint predicates. If $E=E_{\min}$, set

$$ P:=\lbrace i:\alpha_i\lt0\rbrace, \qquad N:=\lbrace i:\alpha_i\gt0\rbrace. $$

If $E=E_{\max}$, set

$$ P:=\lbrace i:\alpha_i\gt0\rbrace, \qquad N:=\lbrace i:\alpha_i\lt0\rbrace. $$

Let

$$ d:=\lvert P\rvert+\lvert N\rvert. $$

Since $L$ is nonconstant, $d\geq1$. Define the literal-match score

$$ S(y):=\sum_{i\in P}y_i+\sum_{i\in N}(1-y_i). $$

Then $0\leq S(y)\leq d$ on the cube, and

$$ E(y)=1 \qquad\Longleftrightarrow\qquad S(y)=d. $$

Thus $E$ and $1-E$ are LTFs:

$$ E(y)=1 \qquad\Longleftrightarrow\qquad S(y)-d+\frac12\gt0, $$

and

$$ 1-E(y)=1 \qquad\Longleftrightarrow\qquad d-\frac12-S(y)\gt0. $$

We next check the two feature-literal conjunctions that can occur in non-XOR gates. Let $r(z)$ be either $z$ or $1-z$. Then

$$ r(z)\wedge E(y)=1 \qquad\Longleftrightarrow\qquad S(y)+d  r(z)\gt2d-\frac12. $$

Indeed, on true inputs the left side is $2d$, while on false inputs it is at most $2d-1$.

Similarly,

$$ r(z)\wedge(1-E(y))=1 \qquad\Longleftrightarrow\qquad (d+1)r(z)-S(y)\gt\frac32. $$

On true inputs, $r=1$ and $S\leq d-1$, so the score is at least $2$. If $r=1$ and $E=1$, the score is $1$; if $r=0$, the score is at most $0$. Thus this predicate is also an LTF. Complements of LTFs are LTFs, by negating the separator and shifting the threshold.

Now classify $G$ by its true set in the two-bit square. If $G$ is constant, then $F$ is constant, so $H^{\ast}(F)=0$.

If $G$ is XOR or XNOR, Lemma 127 gives

$$ H^{\ast}(F)=2. $$

Assume from now on that $G$ is nonconstant and neither XOR nor XNOR. If $G$ has two true inputs, then its two true inputs are adjacent in the two-bit square, so $G$ depends on only one of its two inputs. Therefore $F$ is one of $z$, $1-z$, $E$, or $1-E$, all of which are nonconstant LTFs.

If $G$ has one true input, then $F$ is one of

$$ r(z)\wedge E(y), \qquad r(z)\wedge(1-E(y)), $$

for a raw literal $r$. These are nonconstant LTFs by the explicit separators above.

If $G$ has three true inputs, then $1-G$ has one true input. Hence $1-F$ is a nonconstant LTF by the previous case, and so $F$ is also a nonconstant LTF.

Thus every remaining nonconstant gate gives a nonconstant LTF $F$. The one-head characterization [011_one_head_characterization.md](../01_foundations_and_normal_form/011_one_head_characterization.md) then yields

$$ H^{\ast}(F)=1. $$

This completes the classification. $\blacksquare$

## Consequence

For affine endpoint features, the optimized non-XOR machinery is unnecessary: all non-XOR and non-XNOR one-bit gates are already one-head functions. The only endpoint gates that need the fresh-XOR threshold-degree lower bound are XOR and XNOR.
