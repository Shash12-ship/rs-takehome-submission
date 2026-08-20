# Explicit Strict Separation Between Threshold Degree And Head Complexity

## Statement

Split a ten-bit input into two blocks of five bits. Encode each bit by a sign, with $0$ represented by $+1$ and $1$ represented by $-1$. Write the resulting sign vectors as

$$ x=(x_1,\ldots,x_5)\in\lbrace-1,+1\rbrace^5, \qquad y=(y_1,\ldots,y_5)\in\lbrace-1,+1\rbrace^5. $$

Define the quadratic score

$$ Q(x,y):=\left(\sum_{i=1}^{5}x_i\right)\left(\sum_{j=1}^{5}y_j\right)-3\sum_{i=1}^{5}x_i y_i, $$

and define the Boolean function $f_{10}$ by

$$ f_{10}(x,y)=1 \qquad\Longleftrightarrow\qquad Q(x,y) \gt 0. $$

Then

$$ \deg_{\pm}(f_{10})=2 \lt 3\leq H^{\ast}(f_{10}). $$

In particular,

$$ \deg_{\pm}(f_{10})\neq H^{\ast}(f_{10}). $$

> **Interpretation.** Threshold degree is always a lower bound for head complexity by [006_threshold_degree_head_complexity_bound.md](../01_foundations_and_normal_form/006_threshold_degree_head_complexity_bound.md), but this explicit function shows that the lower bound can be strict.

## Proof

We first verify the quadratic certificate and then rule out every two-head representation.

### Theorem 1. The quadratic score never vanishes

Let $A$ be the number of negative coordinates of $x$, let $B$ be the number of negative coordinates of $y$, and let $C$ be the number of coordinates at which both signs are negative. Then

$$ \sum_i x_i=5-2A, \qquad \sum_i y_i=5-2B, \qquad \sum_i x_i y_i=5-2A-2B+4C. $$

Substituting these identities into the definition of $Q$ gives

$$ \begin{aligned} Q(x,y)&=(5-2A)(5-2B)-3(5-2A-2B+4C) \cr &=10+4(-A-B+AB-3C). \end{aligned} $$

Therefore

$$ Q(x,y)\equiv 2\pmod 4. $$

In particular, $Q(x,y)$ is never zero. Thus $Q$ is a strict sign representation of $f_{10}$. $\blacksquare$

### Theorem 2. The threshold degree is exactly two

Each signed coordinate is an affine function of the corresponding Boolean bit. Hence $Q$ becomes a polynomial of degree at most two in the original ten Boolean variables. Therefore

$$ \deg_{\pm}(f_{10})\leq 2. $$

For the reverse inequality, restrict to the two-dimensional face

$$ x=(a,1,1,-1,-1), \qquad y=(b,1,-1,1,-1), $$

where $a,b\in\lbrace-1,+1\rbrace$ are free. On this face,

$$ \sum_i x_i=a, \qquad \sum_i y_i=b, \qquad \sum_i x_i y_i=ab. $$

Consequently,

$$ Q(x,y)=-2ab. $$

The score is positive exactly when $a$ and $b$ have opposite signs. In the underlying Boolean coordinates this is the XOR checkerboard: the two equal-bit corners are negative and the two unequal-bit corners are positive.

No affine function can sign-represent this checkerboard. Since every polynomial of degree at most one is affine, $f_{10}$ has no degree-one threshold representation. Therefore

$$ \deg_{\pm}(f_{10})\geq 2. $$

Combining the two inequalities gives

$$ \deg_{\pm}(f_{10})=2. \qquad \blacksquare $$

### Theorem 3. Two heads clear to two products of affine forms

Suppose, for contradiction, that two attention heads compute $f_{10}$. By the exact linear-fractional normal form from [010_linear_fractional_normal_form.md](../01_foundations_and_normal_form/010_linear_fractional_normal_form.md), their scalar score has the form

$$ S(z)=c+\frac{N_0(z)}{D_0(z)}+\frac{N_1(z)}{D_1(z)}, $$

where every numerator and denominator is affine and

$$ D_0(z) \gt 0, \qquad D_1(z) \gt 0 $$

on the Boolean cube.

Multiplying by the positive common denominator preserves the classifier. The cleared score is

$$ \begin{aligned} P(z)&=D_0(z)D_1(z)S(z) \cr &=\bigl(cD_0(z)+N_0(z)\bigr)D_1(z)+N_1(z)D_0(z). \end{aligned} $$

Thus $P$ has the form

$$ P=L_1R_1+L_2R_2, $$

where all four factors are affine. Moreover,

$$ P(z) \gt 0 \qquad\Longleftrightarrow\qquad f_{10}(z)=1. $$

It remains to show that no sum of two products of affine forms can have this sign pattern.

### Theorem 4. Every two-product score has mixed rank at most four

Continue to write the variables as two signed blocks $x,y\in\lbrace-1,+1\rbrace^5$. Every affine form can be written as

$$ L(x,y)=\ell_0+a_L\mathbin{\cdot}x+b_L\mathbin{\cdot}y. $$

For any function $g$ on the two signed blocks, define its mixed antipodal difference by

$$ \Delta g(x,y):=g(x,y)-g(x,-y)-g(-x,y)+g(-x,-y). $$

If $L$ and $R$ are affine, direct expansion gives

$$ \Delta(LR)(x,y)=4\left((a_L\mathbin{\cdot}x)(b_R\mathbin{\cdot}y)+(a_R\mathbin{\cdot}x)(b_L\mathbin{\cdot}y)\right). $$

Now let

$$ g=L_1R_1+L_2R_2. $$

For each $j\in\lbrace1,\ldots,5\rbrace$, let $s^{(j)}$ be the sign vector whose $j$-th coordinate is $-1$ and whose other coordinates are $+1$. Since the mixed difference is linear in $x$, there is a five by five matrix $M$ such that

$$ \Delta g(x,s^{(j)})=\sum_{i=1}^{5}M_{ij}x_i. $$

The expansion above shows that $M$ factors through four dimensions:

$$ M=4\begin{bmatrix} a_{L_1}&a_{R_1}&a_{L_2}&a_{R_2} \end{bmatrix}\begin{bmatrix} b_{R_1}\mathbin{\cdot}s^{(1)}&\cdots&b_{R_1}\mathbin{\cdot}s^{(5)} \cr b_{L_1}\mathbin{\cdot}s^{(1)}&\cdots&b_{L_1}\mathbin{\cdot}s^{(5)} \cr b_{R_2}\mathbin{\cdot}s^{(1)}&\cdots&b_{R_2}\mathbin{\cdot}s^{(5)} \cr b_{L_2}\mathbin{\cdot}s^{(1)}&\cdots&b_{L_2}\mathbin{\cdot}s^{(5)} \end{bmatrix}. $$

The first factor has four columns and the second has four rows. Hence

$$ \mathrm{rank}(M)\leq 4. \qquad \blacksquare $$

### Theorem 5. The target sign pattern forces mixed rank five

Fix $j$ and write $s=s^{(j)}$. Since the sum of the coordinates of $s$ is $3$,

$$ \sum_i x_i s_i=\sum_i x_i-2x_j. $$

Therefore

$$ Q(x,s)=3\sum_i x_i-3\left(\sum_i x_i-2x_j\right)=6x_j. $$

The score $Q$ changes sign when either whole block is negated. Thus the four points

$$ (x,s), \qquad (x,-s), \qquad (-x,s), \qquad (-x,-s) $$

have the alternating target signs determined by $x_j$. Any score $g$ that is positive exactly on the true inputs of $f_{10}$ must consequently satisfy

$$ 0 \lt x_j\Delta g(x,s^{(j)}) $$

for every sign vector $x$ and every coordinate $j$.

Apply this to the cleared two-head score from Theorem 3. Using the matrix from Theorem 4, the forced inequality becomes

$$ 0 \lt x_j\sum_{i=1}^{5}M_{ij}x_i. $$

Fix a column $j$. Choose $x_j=1$, and for each $i\neq j$ choose $x_i$ so that

$$ M_{ij}x_i=-\lvert M_{ij}\rvert. $$

The forced inequality then gives

$$ M_{jj} \gt\sum_{i\neq j}\lvert M_{ij}\rvert. $$

This holds for every column. Hence $M$ is strictly column diagonally dominant. The Levy-Desplanques theorem, equivalently the relevant Gershgorin nonsingularity criterion, implies that $M$ is invertible. Therefore

$$ \mathrm{rank}(M)=5. $$

This contradicts the rank bound from Theorem 4. Hence no sum of two products of affine forms can realize the target sign pattern. By Theorem 3, two attention heads cannot compute $f_{10}$. $\blacksquare$

### Conclusion

The checkerboard restriction in Theorem 2 already rules out zero and one head. Theorem 5 rules out two heads. Therefore

$$ H^{\ast}(f_{10})\geq 3. $$

Together with the exact threshold-degree calculation,

$$ \deg_{\pm}(f_{10})=2 \lt 3\leq H^{\ast}(f_{10}). $$

Thus threshold degree and head complexity are not equal for all Boolean functions. $\blacksquare$

## Consequence

The general lower bound

$$ \deg_{\pm}(f)\leq H^{\ast}(f) $$

can be strict even for an explicit function on ten bits. This theorem establishes only the lower bound $H^{\ast}(f_{10})\geq3$; it does not claim the exact value of $H^{\ast}(f_{10})$.
