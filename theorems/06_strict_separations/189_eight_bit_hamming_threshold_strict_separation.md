# Eight-Bit Hamming-Threshold Strict Separation

## Statement

For $x,y\in\lbrace0,1\rbrace^4$, define

$$ \Delta(x,y):=\sum_{i=1}^4(x_i+y_i-2x_i y_i). $$

Thus $\Delta(x,y)$ is the Hamming distance between $x$ and $y$. Let

$$ f_8(x,y)=1 \qquad\Longleftrightarrow\qquad \Delta(x,y)\geq2. $$

Then

$$ \deg_{\pm}(f_8)=2 \qquad\text{and}\qquad H^{\ast}(f_8)=3. $$

Consequently,

$$ \deg_{\pm}(f_8)\lt H^{\ast}(f_8). $$

> **Interpretation.** The radius-one Hamming ball threshold on two four-bit strings is an explicit eight-bit strict separation. Its shell transitions force a column-max spectral inequality that is incompatible with an admissible factor of a cleared two-head score, while an exact integer certificate gives a matching three-head construction.

## Proof

### Lemma 1. The function has threshold degree two

The polynomial

$$ p_0(x,y)=\Delta(x,y)-\frac{3}{2} $$

strictly sign-represents $f_8$, so $\deg_{\pm}(f_8)\leq2$.

Fix the first pair to be unequal and the last two pairs to be equal. On the remaining pair, $f_8$ restricts to two-bit XOR. Since XOR is not a linear threshold function, $\deg_{\pm}(f_8)\geq2$. Therefore

$$ \deg_{\pm}(f_8)=2. \qquad\blacksquare $$

### Lemma 2. Every quadratic representation has negative mixed curvature

Let $p$ be any quadratic polynomial with the signs of $f_8$. Write its mixed part as

$$ p(x,y)=p_X(x)+p_Y(y)+x^{\top}K y, \qquad S=\frac{K+K^{\top}}{2}. $$

Then $S\prec0$. In particular, $K$ is nonsingular.

**Proof.** Consider a rectangle with row endpoints $x_0,x_1$ and column endpoints $y_0,y_1$ whose diagonal vertices have Hamming distance at most one and whose off-diagonal vertices have Hamming distance at least two. The mixed second difference gives

$$ (x_0-x_1)^{\top}K(y_0-y_1)\lt0. $$

Transposing the rectangle gives the same inequality with $K^{\top}$. Thus, if $a=x_0-x_1$ and $b=y_0-y_1$, then

$$ a^{\top}Sb\lt0. $$

Let $e_1,\ldots,e_4$ be the standard basis and put $p_i=e_1+\cdots+e_i$. The following direction pairs have such checkerboard rectangles:

$$ \begin{aligned} &(p_i,p_i) &&(1\leq i\leq4), \cr &(p_1,p_3),(p_2,p_3),(p_2,p_4),(p_3,p_4), \cr &(p_1,p_2-e_3),(p_1,p_4-e_2),(p_1,p_4-e_3), \cr &(p_4,e_1+e_2),(p_4,e_1+e_3),(p_4,e_1+e_4). \end{aligned} $$

Explicit bitstring endpoints for all fourteen rectangles are checked by the exact verifier. Since

$$ (p_2-e_3)+p_3=2p_2, $$

the certificate also gives $p_1^{\top}Sp_2\lt0$.

The same certified inequalities therefore hold after applying any signed coordinate permutation simultaneously to both direction vectors. Given nonzero $z\in\mathbb{R}^4$, choose such a transformation $T$ so that $T^{\top}z$ has nonnegative coordinates in decreasing order. Replace $S$ by $T^{\top}ST$ and rename the transformed coordinates. Thus we may assume

$$ z_1\geq z_2\geq z_3\geq z_4\geq0. $$

Write

$$ z=\alpha_1p_1+\alpha_2p_2+\alpha_3p_3+\alpha_4p_4, $$

where

$$ \alpha_1=z_1-z_2, \qquad \alpha_2=z_2-z_3, \qquad \alpha_3=z_3-z_4, \qquad \alpha_4=z_4. $$

All the coefficients are nonnegative. Every term in the expansion of $z^{\top}Sz$ is strictly negative except for the possibly uncontrolled cross term $p_1^{\top}Sp_4$.

If $\alpha_1\geq\alpha_4$, set

$$ q_2=p_4-e_2, \qquad q_3=p_4-e_3, \qquad q_4=p_4-e_4. $$

The certified pairs give $p_1^{\top}Sq_j\lt0$, and $q_2+q_3+q_4=p_1+2p_4$. Hence

$$ \alpha_1^2p_1^{\top}Sp_1+2\alpha_1\alpha_4p_1^{\top}Sp_4=\alpha_1(\alpha_1-\alpha_4)p_1^{\top}Sp_1+\alpha_1\alpha_4\sum_{j=2}^4p_1^{\top}Sq_j\leq0. $$

If $\alpha_4\geq\alpha_1$, set

$$ r_2=e_1+e_2, \qquad r_3=e_1+e_3, \qquad r_4=e_1+e_4. $$

Now $p_4^{\top}Sr_j\lt0$ and $r_2+r_3+r_4=2p_1+p_4$, so

$$ \alpha_4^2p_4^{\top}Sp_4+2\alpha_1\alpha_4p_1^{\top}Sp_4=\alpha_4(\alpha_4-\alpha_1)p_4^{\top}Sp_4+\alpha_1\alpha_4\sum_{j=2}^4p_4^{\top}Sr_j\leq0. $$

The controlled expression is strictly negative when $\alpha_1+\alpha_4\gt0$. If $\alpha_1=\alpha_4=0$, one of $\alpha_2,\alpha_3$ is positive and supplies a strictly negative diagonal term. Therefore $z^{\top}Sz\lt0$ for every nonzero $z$, proving $S\prec0$.

Finally, $Kz=0$ would give $z^{\top}Sz=z^{\top}Kz=0$. Hence $K$ is nonsingular. $\blacksquare$

### Lemma 3. A two-head score gives an admissible dual-null factor

Suppose for contradiction that $H^{\ast}(f_8)\leq2$. The linear-fractional normal form and denominator-orientation theorem give a score

$$ c+\frac{N_1}{B}+\frac{N_2}{D}, $$

where $N_1,N_2,B,D$ are affine and $B,D$ are positive on the Boolean cube. Clearing the positive denominators gives the quadratic

$$ p=(cB+N_1)D+N_2B. $$

Set $A=cB+N_1$ and $C=N_2$. If either denominator were constant, the mixed coefficient matrix of $p=AD+CB$ would have rank at most two, contrary to Lemma 2. Thus both denominators are nonconstant, and all slopes of each denominator are nonzero with one common sign.

Pass to sign coordinates $u,v\in\lbrace-1,1\rbrace^4$. Complementing all eight input bits preserves $f_8$, so choose the orientation in which every slope of $B$ is positive. Define the affine factor map

$$ F(u,v)=r+Pu+Qv\in\mathbb{R}^4 $$

whose coordinates are $A,D,C,B$, and define

$$ q(z)=z_1z_2+z_3z_4=z^{\top}Jz. $$

Then $p(u,v)=q(F(u,v))$, and $J$ is nonsingular with inertia $(2,2)$. The mixed coefficient matrix is

$$ K=2P^{\top}JQ. $$

Lemma 2 makes $K$ nonsingular, so both $P$ and $Q$ are nonsingular.

The coordinate covector selecting $B$ will be denoted by $\ell$. It is null for the dual quadratic form:

$$ \ell^{\top}J^{-1}\ell=0. $$

Since $B$ has positive slopes and is positive on the cube, write

$$ \ell(F(u,v))=c_0+a^{\top}u+b^{\top}v $$

with

$$ a\gt0, \qquad b\gt0, \qquad c_0\gt\mathbf{1}^{\top}a+\mathbf{1}^{\top}b. $$

Thus every putative two-head representation supplies an admissible dual-null covector. $\blacksquare$

### Lemma 4. Shell transitions give a normalized pointwise system

Under the assumptions of Lemma 3, there are matrices $U,V$, vectors $w,\mu$, and positive diagonal entries $U_{jj}$ such that

$$ U+U^{\top}\succ0, \qquad V=V^{\top}, \qquad \mathrm{inertia}(V)=(2,2), $$

and, for every $i\neq j$,

$$ |w_j|+|U_{ji}-V_{ji}|+\sum_{k\notin\lbrace i,j\rbrace}|U_{jk}+V_{jk}|\lt U_{jj}. $$

They also satisfy

$$ a=U^{\top}\mu\gt0, \qquad b=V\mu\gt0, \qquad \mu^{\top}V\mu=0, $$

and

$$ \mu^{\top}w\gt\mathbf{1}^{\top}a+\mathbf{1}^{\top}b. $$

**Proof.** Put

$$ A_i=P_i+Q_i, \qquad B_i=P_i-Q_i, \qquad d_i=B_i-A_i=-2Q_i. $$

For a defect set $T\subseteq\lbrace1,2,3,4\rbrace$ and $\epsilon\in\lbrace-1,1\rbrace^4$, the corresponding factor-space vertex is

$$ F_T(\epsilon)=r+\sum_{i\in T}B_i\epsilon_i+\sum_{i\notin T}A_i\epsilon_i. $$

Define

$$ \delta_j=q(B_j)-q(A_j)=-4P_j^{\top}JQ_j. $$

Fix distinct $i,j$. Every point with defect set $\lbrace i\rbrace$ is negative, while the corresponding point with defect set $\lbrace i,j\rbrace$ is positive. Their score difference is

$$ \delta_j+2d_j^{\top}Jr\epsilon_j+2d_j^{\top}JB_i\epsilon_i\epsilon_j+2\sum_{k\notin\lbrace i,j\rbrace}d_j^{\top}JA_k\epsilon_j\epsilon_k\gt0. $$

The four displayed signs vary independently. Taking the minimum gives

$$ \delta_j\gt2\left(|d_j^{\top}Jr|+|d_j^{\top}JB_i|+\sum_{k\notin\lbrace i,j\rbrace}|d_j^{\top}JA_k|\right). $$

In particular, every $\delta_j$ is positive. Let $\Delta=\mathrm{diag}(\delta_1,\ldots,\delta_4)$ and define the matrix $\Phi$ by its rows

$$ \Phi_j z=\frac{2d_j^{\top}Jz}{\delta_j}. $$

Since $Q$ is nonsingular, so is $\Phi$. Set

$$ C_0=\Phi P, \qquad E=\Phi Q, \qquad t=\Phi r. $$

Direct calculation gives

$$ (C_0)_{jj}=1, \qquad \Delta E=E^{\top}\Delta, \qquad \Delta C_0+C_0^{\top}\Delta\succ0. $$

The last inequality follows from Lemma 2 because

$$ \Delta C_0+C_0^{\top}\Delta=-4(Q^{\top}JP+P^{\top}JQ). $$

The pointwise transition inequality becomes

$$ |t_j|+|(C_0)_{ji}-E_{ji}|+\sum_{k\notin\lbrace i,j\rbrace}|(C_0)_{jk}+E_{jk}|\lt1. $$

Write $\ell=\Phi^{\top}\lambda$. The identity

$$ \Phi J^{-1}\Phi^{\top}=-4E\Delta^{-1} $$

converts dual nullness into

$$ \lambda^{\top}E\Delta^{-1}\lambda=0. $$

Finally, set

$$ U=\Delta C_0, \qquad V=\Delta E, \qquad w=\Delta t, \qquad \mu=\Delta^{-1}\lambda. $$

Then $U+U^{\top}\succ0$, $V$ is symmetric, and $V$ is congruent to $E\Delta^{-1}$. The identity involving $\Phi J^{-1}\Phi^{\top}$ shows that $V$ has inertia $(2,2)$. Multiplying each pointwise row by $\delta_j$ gives the displayed contractions. The factor slopes, intercept, and null equation become

$$ a=U^{\top}\mu, \qquad b=V\mu, \qquad c_0=\mu^{\top}w, \qquad \mu^{\top}V\mu=0. $$

The admissibility inequalities from Lemma 3 complete the normalized system. $\blacksquare$

### Lemma 5. Four-dimensional column-max spectral inequality

Let $M$ be a real $4\times4$ matrix for which some positive diagonal matrix $D$ makes $DM$ symmetric. Suppose

$$ M\mathbf{1}\gt0. $$

If $M$ has at least two positive eigenvalues, then

$$ \mathrm{tr}(M)+2\sum_{j=1}^4\max_{i\neq j}M_{ij}\gt0. $$

The maxima are column maxima.

**Proof.** Put $C=DM$, $Q=D^{-1}$, and $q_i=Q_{ii}$. Then $C$ is symmetric,

$$ g=C\mathbf{1}\gt0, $$

and $M$ is similar to the symmetric matrix $Q^{1/2}CQ^{1/2}$. Hence $M$ and $C$ have the same inertia. Define

$$ \mathcal{F}_q(A)=\sum_iq_iA_{ii}+2\sum_j\max_{i\neq j}(q_iA_{ij}) $$

for symmetric $A$. The desired expression is $\mathcal{F}_q(C)$.

Let

$$ \sigma=\mathbf{1}^{\top}g, \qquad B=C-\frac{gg^{\top}}{\sigma}. $$

Then $B$ is symmetric and $B\mathbf{1}=0$. Since $C$ is a positive semidefinite rank-one update of $B$, two positive eigenvalues of $C$ force at least one positive eigenvalue of $B$. Moreover, $gg^{\top}/\sigma$ is entrywise positive and $\mathcal{F}_q$ is increasing in every matrix entry. Therefore

$$ \mathcal{F}_q(C)\gt\mathcal{F}_q(B). $$

It remains to show that a symmetric zero-row-sum matrix $B$ with a positive eigenvalue has $\mathcal{F}_q(B)\gt0$. Suppose instead that $\mathcal{F}_q(B)\leq0$.

Let $f$ range over maps on $\lbrace1,2,3,4\rbrace$ with $f(j)\neq j$, and define

$$ \ell_f(B)=\sum_iq_iB_{ii}+2\sum_jq_{f(j)}B_{f(j),j}. $$

The three choices in each column maximum are independent, so

$$ \mathcal{F}_q(B)=\max_f\ell_f(B). $$

Thus $\ell_f(B)\leq0$ for every $f$. Since $B\mathbf{1}=0$, put

$$ a^f_{ij}=q_i+q_j-2q_i\mathbf{1}[f(j)=i]-2q_j\mathbf{1}[f(i)=j] \qquad (i\lt j). $$

Then

$$ -\ell_f(B)=\sum_{i\lt j}B_{ij}a^f_{ij}\geq0. $$

We claim that every squared-distance vector on four real points is a nonnegative combination of the vectors $a^f$. Fix $x\in\mathbb{R}^4$. The claim is immediate if all $x_i$ are equal. Otherwise, define

$$ v_i=\frac{1}{q_i}, \qquad S_0=\sum_iv_i, \qquad \overline{x}=\frac{1}{S_0}\sum_iv_ix_i, $$

$$ V_0=\sum_iv_i(x_i-\overline{x})^2, \qquad y_i=\frac{x_i-\overline{x}}{\sqrt{V_0}}. $$

Then

$$ \sum_iv_iy_i=0, \qquad \sum_iv_iy_i^2=1. $$

For every unordered pair $\lbrace i,j\rbrace$, define

$$ c_{ij}=\frac{v_iv_j}{2}\left(q_i+q_j-(y_i-y_j)^2\right). $$

Weighted Cauchy-Schwarz gives $(y_i-y_j)^2\leq q_i+q_j$, so $c_{ij}\geq0$. The weighted variance identity gives

$$ \sum_{i\lt j}v_iv_j(y_i-y_j)^2=S_0. $$

Since there are four vertices,

$$ \sum_{i\lt j}c_{ij}=S_0=\sum_iv_i. $$

We now split each edge capacity $c_{ij}$ between its endpoints so that vertex $i$ receives exactly $v_i$. The fractional edge-allocation criterion says that such a split exists exactly when

$$ \sum_{i\in A}v_i\geq\sum_{\lbrace i,j\rbrace\subseteq A}c_{ij} $$

for every vertex set $A$. The inequality is immediate for sets of size at most one. For a two-vertex set,

$$ c_{ij}\leq\frac{v_i+v_j}{2}\leq v_i+v_j. $$

The full-set condition is equality. For a three-vertex set whose missing vertex is $k$, the condition is equivalent to

$$ \sum_{j\neq k}c_{kj}\geq v_k. $$

The left side equals

$$ \frac{S_0+v_k-S_0v_ky_k^2}{2}. $$

The two normalizations and Cauchy-Schwarz give

$$ (v_ky_k)^2=\left(\sum_{j\neq k}v_jy_j\right)^2\leq(S_0-v_k)(1-v_ky_k^2). $$

Rearranging yields $S_0v_ky_k^2\leq S_0-v_k$, which proves the three-vertex condition.

Therefore there are nonnegative numbers $z_{ij}$ for $i\neq j$ such that

$$ z_{ij}+z_{ji}=c_{ij}, \qquad \sum_{j\neq i}z_{ij}=v_i. $$

Set $p_{ij}=z_{ij}/v_i$. Each row of $(p_{ij})$ is a probability distribution on the other three vertices. Dividing the edge-splitting identity by $v_iv_j$ gives

$$ q_jp_{ij}+q_ip_{ji}=\frac{q_i+q_j-(y_i-y_j)^2}{2}. $$

Choose a random map $f$ by choosing $f(i)=j$ with probability $p_{ij}$, independently over the four vertices. Then

$$ \mathbb{E}[a^f_{ij}]=q_i+q_j-2q_ip_{ji}-2q_jp_{ij}=(y_i-y_j)^2. $$

Since $(x_i-x_j)^2=V_0(y_i-y_j)^2$, the squared-distance vector is the nonnegative combination

$$ \left((x_i-x_j)^2\right)_{i\lt j}=\sum_fV_0\mathbb{P}(f)\left(a^f_{ij}\right)_{i\lt j}. $$

Taking the same combination of the inequalities $-\ell_f(B)\geq0$ gives

$$ \sum_{i\lt j}B_{ij}(x_i-x_j)^2\geq0. $$

Because $B\mathbf{1}=0$,

$$ x^{\top}Bx=-\sum_{i\lt j}B_{ij}(x_i-x_j)^2\leq0. $$

Thus $B$ is negative semidefinite, contradicting its positive eigenvalue. This proves the column-max inequality. $\blacksquare$

### Lemma 6. The normalized system is impossible

**Proof.** First suppose every coordinate of $\mu$ is nonzero. Put

$$ s_i=\mathrm{sgn}(\mu_i), \qquad r_i=|\mu_i|, \qquad S=\mathrm{diag}(s_i), \qquad R=\mathrm{diag}(r_i). $$

Since $a\gt0$, one has $\mathbf{1}^{\top}a\geq s^{\top}a$. For each row $j$, choose an exceptional index $i\neq j$. Multiply its pointwise contraction by $r_j$. The diagonal $U_{jj}$ term cancels in

$$ \mu^{\top}w-s^{\top}a=\sum_j\mu_j\left(w_j-\sum_ks_kU_{jk}\right) $$

because $\mu_js_j=r_j$. For real $X,Y$ and $t\in\lbrace-1,1\rbrace$, the two scalar inequalities

$$ -|X-Y|-tX\leq-tY, \qquad -|X+Y|-tX\leq tY $$

then give

$$ \mu^{\top}w-\mathbf{1}^{\top}a\lt\sum_j\left(\mu_j\sum_{k\neq j}s_kV_{jk}-2\mu_js_iV_{ji}\right). $$

Choose $i$ row by row to maximize $\mu_js_iV_{ji}$. Denote the resulting upper bound by

$$ R_{\min}=\sum_j\left(\mu_j\sum_{k\neq j}s_kV_{jk}-2\max_{i\neq j}(\mu_js_iV_{ji})\right). $$

Define

$$ W=SVS, \qquad H=RWR, \qquad q_i=\frac{1}{r_i}, \qquad g=H\mathbf{1}. $$

The matrix $H$ has inertia $(2,2)$. Since $b=V\mu\gt0$,

$$ g_j=r_js_jb_j, \qquad \mathrm{sgn}(g_j)=s_j, \qquad \sum_jg_j=\mu^{\top}V\mu=0. $$

Moreover,

$$ \mathbf{1}^{\top}b=\sum_jq_j|g_j|, $$

and the upper bound becomes

$$ R_{\min}=\sum_j\left(\sum_{k\neq j}q_kH_{jk}-2\max_{i\neq j}(q_iH_{ij})\right). $$

The strict intercept inequality gives

$$ \mathbf{1}^{\top}b\lt\mu^{\top}w-\mathbf{1}^{\top}a\lt R_{\min}. $$

Consequently,

$$ L:=\mathbf{1}^{\top}b-R_{\min}\lt0. $$

Reindexing the double sum and using $g=H\mathbf{1}$ gives

$$ L=\sum_iq_i(H_{ii}+|g_i|-g_i)+2\sum_j\max_{i\neq j}(q_iH_{ij}). $$

Set

$$ C=H+\mathrm{diag}(|g|-g). $$

Then

$$ C\mathbf{1}=|g|\gt0, \qquad C-H\succeq0. $$

Thus $C$ has at least two positive eigenvalues. Put $Q_0=\mathrm{diag}(q_i)$ and $M=Q_0C$. The matrix $M$ has positive row sums and is similar to the symmetric matrix $Q_0^{1/2}CQ_0^{1/2}$. It therefore has at least two positive eigenvalues. Finally,

$$ L=\mathrm{tr}(M)+2\sum_j\max_{i\neq j}M_{ij}. $$

Lemma 5 says $L\gt0$, contradicting $L\lt0$.

It remains to remove the assumption that all coordinates of $\mu$ are nonzero. Choose $k$ with $\mu_k\neq0$, and let $h_i=1$ when $\mu_i=0$ and $h_i=0$ otherwise. In particular, $h_k=0$. Consider

$$ \psi(t,\alpha)=(\mu+th+\alpha e_k)^{\top}V(\mu+th+\alpha e_k). $$

At $(t,\alpha)=(0,0)$,

$$ \psi(0,0)=0, \qquad \frac{\partial\psi}{\partial\alpha}(0,0)=2(V\mu)_k=2b_k\gt0. $$

The implicit function theorem gives a continuous function $\alpha(t)$ near zero for which $\alpha(0)=0$ and $\psi(t,\alpha(t))=0$. For every sufficiently small nonzero $t$, the vector $\mu+th+\alpha(t)e_k$ has no zero coordinate. All positivity and intercept conditions are strict, so they persist for a sufficiently small choice of $t$. Applying the preceding argument to this perturbed null vector gives the same contradiction. $\blacksquare$

### Lemma 7. Three heads suffice

Order the input variables as

$$ z=(x_1,x_2,x_3,x_4,y_1,y_2,y_3,y_4). $$

Define three affine denominators by

$$ \begin{aligned} D_1(z)&=34-z_1-6z_2-z_3-8z_4-z_5-z_6-z_7-z_8, \cr D_2(z)&=31-4z_1-z_2-3z_3-7z_4-5z_5-6z_6-3z_7-z_8, \cr D_3(z)&=32-z_1-z_2-6z_3-z_4-z_5-6z_6-6z_7-4z_8. \end{aligned} $$

Their respective ranges on the Boolean cube are $[14,34]$, $[1,31]$, and $[6,32]$. In particular, they are positive and all their slopes have one common sign. Define the affine numerators

$$ \begin{aligned} A_1(z)={}&-476+1794z_1+2403z_2+2934z_3+132z_4+1890z_5-4130z_6+2868z_7-661z_8, \cr A_2(z)={}&622-2333z_1-1471z_2+188z_3+3074z_4-2633z_5+2202z_6+208z_7-1392z_8, \cr A_3(z)={}&-1006+1501z_1-577z_2-1950z_3-4044z_4+1799z_5+1406z_6-1914z_7+2472z_8. \end{aligned} $$

Consider the three-atom score

$$ s(z)=1+\frac{A_1(z)}{D_1(z)}+\frac{A_2(z)}{D_2(z)}+\frac{A_3(z)}{D_3(z)}. $$

Clearing its positive denominators gives

$$ P(z)=D_1D_2D_3+A_1D_2D_3+A_2D_1D_3+A_3D_1D_2. $$

Exact evaluation at all $256$ vertices gives

$$ \min_z (2f_8(z)-1)P(z)=58\gt0. $$

Thus $s$ strictly sign-represents $f_8$. By the denominator-orientation theorem, every ratio $A_i/D_i$ is a one-head atom. Hence

$$ H^{\ast}(f_8)\leq3. \qquad\blacksquare $$

### Conclusion

A two-head representation would give the normalized system of Lemma 4, but Lemma 6 proves that this system is impossible. Therefore

$$ H^{\ast}(f_8)\geq3. $$

Lemma 7 gives the matching upper bound. Together with Lemma 1,

$$ \deg_{\pm}(f_8)=2\lt3=H^{\ast}(f_8). \qquad\blacksquare $$

## Exact verification

The [lower-bound verifier](../../artifacts/calculations/verify_eight_bit_hamming_threshold_separation.py) checks all $256$ values of the quadratic threshold, the fourteen checkerboard rectangles, the direction identities used in the curvature proof, and the finite algebraic identities in the normalized and spectral reductions. Its output is

```text
input bits: 8
quadratic value range: (-3, 5)
minimum doubled margin: 1
checkerboard rectangles: 14
column-choice maps: 81
certificate: verified
```

The [three-head verifier](../../artifacts/calculations/verify_f8_three_head_upper.py) reads the [integer certificate archive](../../artifacts/calculations/f8_three_head_upper_search.json), checks denominator orientation and positivity, and evaluates the cleared score exactly at every vertex. Its output includes

```text
denominator ranges: [(14, 34), (1, 31), (6, 32)]
minimum signed cleared score: 58
three-head certificate: verified
```

## Consequence

Combined with the exact classification through four bits, the least possible strict-separation dimension satisfies

$$ 5\leq n_{\mathrm{sep}}\leq8. $$
