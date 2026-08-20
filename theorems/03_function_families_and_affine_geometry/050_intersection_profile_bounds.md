# Intersection-Profile Bounds

## Statement

Let $F:\lbrace0,1,\ldots,m\rbrace\to\lbrace0,1\rbrace$ and define the intersection-profile function

$$ f_F(x,y) := F \left(\sum_{i=1}^{m}x_i y_i\right), \qquad x,y\in\lbrace0,1\rbrace^m. $$

Let $C(F)$ be the number of sign changes in the sequence

$$ F(0),F(1),\ldots,F(m). $$

Then

$$ C(F) \leq H^{\ast}(f_F) \leq \sum_{r=1}^{C(F)}\binom{m}{r}, $$

with the convention that the empty sum is $0$.

> **Interpretation.** Functions of the intersection size behave like symmetric functions after the substitution $z_i=x_i y_i$. The lower bound comes from the genuine symmetric restriction $y=1^m$, while the upper bound pays for the sparse expansion in the pair monomials $x_i y_i$.

## Proof

### Lemma 1. Symmetric restriction lower bound

Restrict

$$ y_1=\cdots=y_m=1. $$

On this subcube,

$$ f_F(x,1) = F \left(\sum_{i=1}^{m}x_i\right). $$

This is the symmetric Boolean function on $m$ variables with Hamming-weight label sequence

$$ F(0),F(1),\ldots,F(m). $$

By the symmetric sign-change theorem [012_symmetric_sign_changes.md](../01_foundations_and_normal_form/012_symmetric_sign_changes.md), this restricted function has head complexity $C(F)$. Restriction monotonicity from [028_restrictions_and_sign_rank.md](../02_complexity_measure_upper_bounds/028_restrictions_and_sign_rank.md) gives

$$ H^{\ast}(f_F)\geq C(F). $$

### Lemma 2. A degree-C(F) sign polynomial in the intersection size

Let

$$ q_k:= \begin{cases} +1 & \text{if } F(k)=1,\cr -1 & \text{if } F(k)=0. \end{cases} $$

Let

$$ \mathcal{J}:=\lbrace j\in\lbrace0,\ldots,m-1\rbrace:q_j\neq q_{j+1}\rbrace. $$

Then $\lvert\mathcal{J}\rvert=C(F)$. Define

$$ R(t):= q_0\prod_{j\in\mathcal{J}}\left(j+\frac{1}{2}-t\right). $$

For an integer $k\in\lbrace0,\ldots,m\rbrace$, the factor indexed by $j$ is positive when $k\leq j$ and negative when $k\geq j+1$. Hence the sign of $R(k)$ flips exactly once for every label change crossed before $k$. Therefore

$$ q_k R(k)\gt0 $$

for every $k\in\lbrace0,\ldots,m\rbrace$, so $R$ sign-represents $F$ on the intersection-size levels and has degree $C(F)$.

### Lemma 3. Sparse expansion upper bound

Set

$$ z_i:=x_i y_i, \qquad s(x,y):=\sum_{i=1}^{m}z_i. $$

By Lemma 2, $R(s(x,y))$ sign-represents $f_F$. As a polynomial in the variables $z_1,\ldots,z_m$, it has degree at most $C(F)$. After multilinear reduction using $z_i^2=z_i$, it is a linear combination of monomials

$$ \prod_{i\in S}z_i = \prod_{i\in S}x_i y_i $$

with

$$ 1\leq\lvert S\rvert\leq C(F). $$

Thus the number of nonconstant monomials in the original $2m$ Boolean variables is at most

$$ \sum_{r=1}^{C(F)}\binom{m}{r}. $$

Applying the polynomial-threshold sparsity upper bound [041_ptf_sparsity_upper_bound.md](../02_complexity_measure_upper_bounds/041_ptf_sparsity_upper_bound.md) gives

$$ H^{\ast}(f_F) \leq \sum_{r=1}^{C(F)}\binom{m}{r}. $$

Together with Lemma 1, this proves the theorem. $\blacksquare$

## Consequence

### Lemma 4. Nonempty intersection and disjointness

Define

$$ \mathrm{INT}_m(x,y) := \mathbf{1} \left[\sum_{i=1}^{m}x_i y_i\geq1\right], $$

and

$$ \mathrm{DISJ}_m:=1-\mathrm{INT}_m. $$

For $m=1$,

$$ H^{\ast}(\mathrm{INT}_1) = H^{\ast}(\mathrm{DISJ}_1) =1, $$

because these are $\mathrm{AND}$ and $\mathrm{NAND}$ on two bits.

For $m\geq2$,

$$ 2\leq H^{\ast}(\mathrm{INT}_m)\leq m $$

and

$$ 2\leq H^{\ast}(\mathrm{DISJ}_m)\leq m. $$

In particular,

$$ H^{\ast}(\mathrm{INT}_2) = H^{\ast}(\mathrm{DISJ}_2) =2. $$

The next endpoint is also exact by [059_three_pair_endpoint_exact.md](059_three_pair_endpoint_exact.md):

$$ H^{\ast}(\mathrm{INT}_3) = H^{\ast}(\mathrm{DISJ}_3) =2. $$

**Proof.** The upper bound $m$ is the theorem with one sign change. It also follows from the monotone DNF

$$ \mathrm{INT}_m(x,y) = \bigvee_{i=1}^{m}(x_i\wedge y_i) $$

and complement invariance for $\mathrm{DISJ}_m$.

It remains to prove the lower bound for $m\geq2$. Suppose $\mathrm{INT}_m$ were a linear threshold function. Restrict all coordinates except $x_1,x_2,y_1,y_2$ to $0$. Then there would be real coefficients $a_1,a_2,b_1,b_2,c$ whose affine score is positive on intersecting inputs and negative on disjoint inputs.

The inputs $(x,y)=(e_1,e_1)$ and $(e_2,e_2)$ are intersecting, so

$$ a_1+b_1+c\gt0, \qquad a_2+b_2+c\gt0. $$

The inputs $(e_1,e_2)$ and $(e_2,e_1)$ are disjoint, so

$$ a_1+b_2+c\lt0, \qquad a_2+b_1+c\lt0. $$

Adding the first two inequalities gives

$$ a_1+a_2+b_1+b_2+2c\gt0, $$

while adding the last two gives

$$ a_1+a_2+b_1+b_2+2c\lt0, $$

a contradiction. Thus $\mathrm{INT}_m$ is not a linear threshold function. By the one-head characterization [011_one_head_characterization.md](../01_foundations_and_normal_form/011_one_head_characterization.md), $H^{\ast}(\mathrm{INT}_m)\geq2$.

Complement invariance from [028_restrictions_and_sign_rank.md](../02_complexity_measure_upper_bounds/028_restrictions_and_sign_rank.md) gives the same lower and upper bounds for $\mathrm{DISJ}_m$. When $m=2$, the lower and upper bounds coincide. $\blacksquare$

### Lemma 5. Inner product mod two revisited

For

$$ \mathrm{IP}_m(x,y)=\bigoplus_{i=1}^{m}x_i y_i, $$

the label sequence as a function of $\sum_i x_i y_i$ alternates at every adjacent level, so $C(F)=m$. The theorem recovers

$$ m\leq H^{\ast}(\mathrm{IP}_m)\leq2^m-1. $$

The lower bound here is the affine-parity restriction $y=1^m$, and the upper bound is the full sparse expansion in the pair monomials.
