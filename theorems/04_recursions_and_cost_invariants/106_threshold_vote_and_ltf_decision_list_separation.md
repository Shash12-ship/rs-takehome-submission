# Threshold-Vote And LTF Decision-List Separation

## Statement

Let $s_{\mathrm{LTF}}(f)$ be the minimum number of linear threshold function indicators in a strict weighted vote for $f$.

There is an infinite family of Boolean functions $F_n:\lbrace0,1\rbrace^{n}\to\lbrace0,1\rbrace$ such that

$$ s_{\mathrm{LTF}}(F_n)\leq2 \qquad \text{but} \qquad H^{\ast}(F_n)\geq c n $$

for an absolute constant $c\gt0$.

The same family has LTF decision-list length at most $2$. Thus neither threshold-vote size nor LTF decision-list length is a constant-factor upper bound for $H^{\ast}$.

> **Interpretation.** The three-bit threshold-vote match and the equality-family match are genuine small or structured coincidences. Globally, the model needs calibrated raw scores, not merely a small weighted vote of thresholded LTF outputs.

## Proof

Use the halfspace-intersection family from [105_halfspace_intersection_head_lower_bound.md](105_halfspace_intersection_head_lower_bound.md):

$$ F_n(x)=T_n(x)\wedge U_n(x), $$

where $T_n$ and $U_n$ are linear threshold functions and

$$ H^{\ast}(F_n)\geq c n. $$

The same function has a strict weighted vote over two LTF indicators:

$$ F_n(x)=1 \qquad\Longleftrightarrow\qquad T_n(x)+U_n(x)-\frac{3}{2}\gt0. $$

Hence

$$ s_{\mathrm{LTF}}(F_n)\leq2. $$

It also has a length-two LTF decision list. Test $T_n$ first. If $T_n(x)=0$, output $0$. If $T_n(x)=1$, test $U_n$. Output $1$ if $U_n(x)=1$, and output $0$ otherwise. This computes $T_n\wedge U_n$ with two LTF tests.

Since $H^{\ast}(F_n)\geq c n$ while both auxiliary sizes are at most $2$, no constant $C$ can make either inequality

$$ H^{\ast}(f)\leq C  s_{\mathrm{LTF}}(f) $$

or

$$ H^{\ast}(f)\leq C  L_{\mathrm{LTFDL}}(f) $$

valid for all Boolean functions, where $L_{\mathrm{LTFDL}}(f)$ denotes LTF decision-list length. $\blacksquare$

## Consequences

The calibrated threshold-vote theorem is not a technical nicety. It is the missing hypothesis: a small threshold vote helps only when the inner threshold indicators can be accessed by raw one-head atoms with enough uniform accuracy to preserve the outer margin.

Similarly, arbitrary LTF decision lists cannot be bounded by length alone. The surviving decision-list program must either restrict the tests to calibrated families or pay a raw calibration cost $\rho(T_j)$ for each tested feature.
