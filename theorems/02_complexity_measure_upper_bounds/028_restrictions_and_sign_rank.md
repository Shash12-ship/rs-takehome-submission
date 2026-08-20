# Restrictions, Juntas, And Sign-Rank Lower Bounds

## Statement

This note records reusable structural facts.

First, $H^{\ast}$ is monotone under restrictions. If $g$ is obtained from

$$ f : \lbrace0,1\rbrace^n \to \lbrace0,1\rbrace $$

by fixing some input coordinates, then

$$ H^{\ast}(g) \leq H^{\ast}(f). $$

Consequently, if some restriction of $f$ is $k$-bit parity or its complement, then

$$ H^{\ast}(f) \geq k. $$

Second, adjoining dummy variables does not change $H^{\ast}$. If

$$ F(x,y)=f(x) $$

where $y$ is a block of dummy input bits, then

$$ H^{\ast}(F)=H^{\ast}(f). $$

Consequently, if $f$ is a $k$-junta, then $H^{\ast}(f)$ is exactly the head complexity of the induced function on its essential $k$ variables.

Third, $H^{\ast}$ controls sign-rank under every input partition. Let $I\sqcup J=\lbrace1,\ldots,n\rbrace$, and write inputs as $(u,v)\in\lbrace0,1\rbrace^{I}\times\lbrace0,1\rbrace^{J}$. Let $\Sigma_f^{I,J}$ be the sign matrix

$$ \Sigma_f^{I,J}(u,v) := \begin{cases} +1 & \text{if } f(u,v)=1, \cr -1 & \text{if } f(u,v)=0. \end{cases} $$

Let $\mathrm{srank}_{I,J}(f)$ be its sign-rank, namely the minimum rank of a real matrix with the same strict sign pattern as $\Sigma_f^{I,J}$. If $f$ is nonconstant and $H=H^{\ast}(f)$, then

$$ \mathrm{srank}_{I,J}(f) \leq \min\left\lbrace 2^{H+1}-2,\ \sum _{i=0}^{\min(H,\lvert I\rvert)}\binom{\lvert I\rvert}{i},\ \sum _{j=0}^{\min(H,\lvert J\rvert)}\binom{\lvert J\rvert}{j}\right\rbrace. $$

In particular,

$$ H^{\ast}(f) \geq \left\lceil\log_2\left(\mathrm{srank}_{I,J}(f)+2\right)\right\rceil-1. $$

> **Interpretation.** Threshold degree is not the only systematic lower-bound route. The cleared score has the special tangent form of a product of affine denominators. Across any partition, this tangent structure has rank at most $2^{H+1}-2$, even when the space of all degree-at-most $H$ polynomials has much larger partition rank.

## Proof

### Lemma 1. Restriction monotonicity

Let $g$ be obtained from $f$ by fixing coordinates outside a set $K\subseteq\lbrace1,\ldots,n\rbrace$.

Take an optimal $H^{\ast}(f)$-head linear-fractional representation of $f$:

$$ c+\sum_{h=1}^{H^{\ast}(f)}\phi_h(x). $$

Each atom has the form

$$ \phi_h(x) := \frac{ \eta_h+\sum_{i=1}^{n}\rho_{h,i}\alpha_h^{x_i}(m_{h,i}+\delta_h x_i) }{ \gamma_h+\sum_{i=1}^{n}\rho_{h,i}\alpha_h^{x_i} }. $$

After fixing $x_i=\xi_i$ for $i\notin K$, the denominator becomes

$$ \gamma_h' +\sum_{i\in K}\rho_{h,i}\alpha_h^{x_i}, \qquad \gamma_h' := \gamma_h+\sum_{i\notin K}\rho_{h,i}\alpha_h^{\xi_i}. $$

Since $\gamma_h'\gt0$, this is again a valid atom denominator in the remaining variables. The numerator is transformed in the same way by absorbing the fixed-coordinate contributions into a new constant $\eta_h'$. Thus each restricted atom is still a one-head atom.

Therefore the restricted score computes $g$ using at most $H^{\ast}(f)$ heads, and

$$ H^{\ast}(g) \leq H^{\ast}(f). $$

If a restriction of $f$ is $k$-bit parity or its complement, then the restricted function has head complexity $k$ by the exact parity theorem and complement invariance from Lemma 3 below. Restriction monotonicity gives $H^{\ast}(f)\geq k$. $\blacksquare$

### Lemma 2. Dummy variables do not change head complexity

Let $f : \lbrace0,1\rbrace^k \to \lbrace0,1\rbrace$, and define

$$ F(x,y):=f(x) $$

on $\lbrace0,1\rbrace^{k+r}$. We prove

$$ H^{\ast}(F)=H^{\ast}(f). $$

The lower bound follows from restriction monotonicity by fixing the dummy block $y$ to any value.

For the upper bound, let $H:=H^{\ast}(f)$. If $H=0$, then $f$ is constant and so is $F$. Assume $H\geq1$.

Take an $H$-atom score for $f$:

$$ S(x) = c+\sum_{h=1}^{H}\phi_h(x), $$

with

$$ f(x)=1 \qquad\Longleftrightarrow\qquad S(x)\gt0. $$

Because the domain is finite and the inequalities are strict, there is a margin

$$ \Delta:=\min_{x\in\lbrace0,1\rbrace^k}\lvert S(x)\rvert\gt0. $$

For each atom

$$ \phi_h(x) = \frac{ \eta_h+\sum_{i=1}^{k}\rho_{h,i}\alpha_h^{x_i}(m_{h,i}+\delta_h x_i) }{ \gamma_h+\sum_{i=1}^{k}\rho_{h,i}\alpha_h^{x_i} }, $$

extend it to the dummy variables by giving every dummy coordinate a tiny positive weight $\varepsilon\gt0$ and any fixed real value parameters, for instance $m_{h,j}=0$ for dummy $j$. Keep $\gamma_h,\eta_h,\alpha_h,\delta_h$ and the original active-coordinate parameters unchanged.

For each fixed $h$, the extended atom $\phi_{h,\varepsilon}(x,y)$ converges uniformly to $\phi_h(x)$ on the finite cube as $\varepsilon\to0$. Hence

$$ S_{\varepsilon}(x,y) := c+\sum_{h=1}^{H}\phi_{h,\varepsilon}(x,y) $$

converges uniformly to $S(x)$.

Choose $\varepsilon$ small enough that

$$ \lvert S_{\varepsilon}(x,y)-S(x)\rvert\lt\frac{\Delta}{2} $$

for every $(x,y)$. Then $S_{\varepsilon}(x,y)$ has the same sign as $S(x)$ for every $(x,y)$, so it computes $F$. Therefore

$$ H^{\ast}(F)\leq H^{\ast}(f). $$

Together with the lower bound, this proves equality. $\blacksquare$

### Lemma 3. Complement and global coordinate symmetries

Complements preserve $H^{\ast}$. If a score $S(x)$ computes $f$ by

$$ f(x)=1 \qquad\Longleftrightarrow\qquad S(x)\gt0, $$

then $-S(x)$ computes $1-f$ with the same heads. Hence

$$ H^{\ast}(1-f)=H^{\ast}(f). $$

Permuting input coordinates also preserves $H^{\ast}$, because a coordinate permutation just relabels the positional embeddings in the construction.

Global bit flip also preserves $H^{\ast}$. To see this in the normal form, let

$$ \phi(x) := \frac{ \eta+\sum_{i=1}^{n}\rho_i\alpha^{x_i}(m_i+\delta x_i) }{ \gamma+\sum_{i=1}^{n}\rho_i\alpha^{x_i} } $$

be an atom. Then $\phi(1-y)$ equals

$$ \frac{ \eta+\sum_{i=1}^{n}\rho_i' (\alpha')^{y_i}(m_i'+\delta' y_i) }{ \gamma+\sum_{i=1}^{n}\rho_i' (\alpha')^{y_i} }, $$

where

$$ \alpha':=\alpha^{-1}, \qquad \rho_i':=\rho_i\alpha, \qquad m_i':=m_i+\delta, \qquad \delta':=-\delta. $$

Thus every atom remains an atom after replacing every input bit by its complement. Therefore

$$ H^{\ast}(x\mapsto f(1-x))=H^{\ast}(f). $$

$\blacksquare$

### Lemma 4. Low heads imply low partition sign-rank

Suppose the nonconstant function $f$ is computed with $H$ heads. Write its linear-fractional score as

$$ S(x)=c+\sum_{h=1}^{H}\frac{N_h(x)}{D_h(x)}, $$

where every $N_h,D_h$ is affine and every $D_h$ is positive on the cube. The finite set of positive inputs has a positive minimum score. Choose $\varepsilon\gt0$ smaller than that minimum and replace $c$ by $c-\varepsilon$. The shifted score is strictly positive on $f^{-1}(1)$ and strictly negative on $f^{-1}(0)$.

Clearing the positive denominators gives

$$ P(x)=(c-\varepsilon)\prod_{h=1}^{H}D_h(x)+\sum_{h=1}^{H}N_h(x)\prod_{g\neq h}D_g(x). $$

Thus the evaluation matrix of $P$ has exactly the strict sign pattern $\Sigma_f^{I,J}$.

First use only the degree bound. The polynomial $P$ has degree at most $H$. Split the variables as $(u,v)$ across $I\sqcup J$ and write

$$ P(u,v)=\sum_{\substack{A\subseteq I,\ B\subseteq J\cr \lvert A\rvert+\lvert B\rvert\leq H}}c_{A,B}u_Av_B. $$

This is a matrix factorization through the coefficient matrix $(c_{A,B})$. Therefore

$$ \mathrm{rank}(M_P)\leq\min\left\lbrace\sum_{i=0}^{\min(H,\lvert I\rvert)}\binom{\lvert I\rvert}{i},\ \sum_{j=0}^{\min(H,\lvert J\rvert)}\binom{\lvert J\rvert}{j}\right\rbrace. $$

The tangent form gives a second bound. Decompose each affine form across the partition:

$$ D_h(u,v)=a_h(u)+b_h(v),\qquad N_h(u,v)=r_h(u)+s_h(v). $$

For $T\subseteq\lbrace1,\ldots,H\rbrace$, put

$$ A_T(u)=\prod_{h\in T}a_h(u),\qquad B_{\overline{T}}(v)=\prod_{h\notin T}b_h(v), $$

and

$$ R_T(u)=\sum_{h\in T}r_h(u)\prod_{g\in T\setminus\lbrace h\rbrace}a_g(u),\qquad Q_{\overline{T}}(v)=\sum_{h\notin T}s_h(v)\prod_{g\notin T\cup\lbrace h\rbrace}b_g(v). $$

Empty products equal one and empty sums equal zero. Expanding the cleared tangent form and grouping terms by $T$ gives

$$ P(u,v)=\sum_{T\subseteq\lbrace1,\ldots,H\rbrace}\left(\left((c-\varepsilon)A_T(u)+R_T(u)\right)B_{\overline{T}}(v)+A_T(u)Q_{\overline{T}}(v)\right). $$

For every nonempty proper $T$, the summand is a sum of two outer products and has matrix rank at most two. When $T=\varnothing$, the whole summand depends only on $v$, so its matrix rank is at most one. When $T=\lbrace1,\ldots,H\rbrace$, it depends only on $u$, so its matrix rank is also at most one. Rank subadditivity now gives

$$ \mathrm{rank}(M_P)\leq1+2(2^H-2)+1=2^{H+1}-2. $$

Since $M_P$ has the same strict sign pattern as $\Sigma_f^{I,J}$,

$$ \mathrm{srank}_{I,J}(f)\leq\mathrm{rank}(M_P). $$

Combining the two rank bounds proves the statement. Finally,

$$ \mathrm{srank}_{I,J}(f)+2\leq2^{H+1} $$

implies

$$ H\geq\left\lceil\log_2\left(\mathrm{srank}_{I,J}(f)+2\right)\right\rceil-1. $$

$\blacksquare$

## Consequence

The restriction part gives a simple exact obstruction:

$$ \text{parity restriction on } k \text{ free bits} \qquad\Longrightarrow\qquad H^{\ast}(f)\geq k. $$

The dummy-variable part gives exact junta reduction. If $f$ is a $k$-junta and $f_{\mathrm{ess}}$ is its induced function on the essential variables, then

$$ H^{\ast}(f)=H^{\ast}(f_{\mathrm{ess}}). $$

Thus every exact classification or universal upper bound for $k$ input variables applies unchanged to $k$-juntas in any larger ambient cube.

The sign-rank part gives a communication-complexity lower-bound route. For any partition $I\sqcup J$,

$$ H^{\ast}(f) \geq \left\lceil\log_2\left(\mathrm{srank}_{I,J}(f)+2\right)\right\rceil-1. $$

The rank cap specializes to $6$ for two heads, recovering the structural bound used in the strict-separation lemmas. This route is weaker than the counting lower bound for a random function, but it is constructive: a single explicit high-sign-rank partition matrix certifies a concrete lower bound for that function.

There is a sharp size screen before attempting this route. To prove $H^{\ast}(f)\gt h$, the displayed inversion needs a partition sign-rank of at least

$$ 2^{h+1}-1. $$

But every $2^{\lvert I\rvert}\times2^{\lvert J\rvert}$ matrix has sign-rank at most $2^{\min(\lvert I\rvert,\lvert J\rvert)}$. Therefore a necessary condition is

$$ \min(\lvert I\rvert,\lvert J\rvert)\geq h+1, $$

and some usable partition can exist only if

$$ n\geq2h+2. $$

Thus partition sign-rank is inherently a low-head lower-bound method. When $n\lt2h+2$, it cannot rule out $h$ heads, regardless of how accurately sign-rank is estimated.
