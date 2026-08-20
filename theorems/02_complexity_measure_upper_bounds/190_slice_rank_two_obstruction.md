# Cleared Head Scores Have Slice Rank At Most Two

## Statement

Let $H\geq2$, and let a Boolean function $f:\lbrace0,1\rbrace^n\to\lbrace0,1\rbrace$ be computed by an $H$-head score in the linear-fractional normal form. Homogenize the affine forms with a variable $z_0$. After clearing the positive denominators, the score has a homogeneous degree $H$ numerator

$$ P=c\prod_{h=1}^{H}B_h+\sum_{h=1}^{H}A_h\prod_{g\neq h}B_g. $$

There are real linear forms $L_1,L_2$ and real degree $H-1$ forms $Q_1,Q_2$ such that

$$ P=L_1Q_1+L_2Q_2. $$

Moreover, $L_2$ can be chosen to equal one of the actual attention denominators.

Consequently:

1. $P$ has real polynomial slice rank at most two.

2. The real hypersurface $V(P)$ contains the real linear space $V(L_1,L_2)$ of codimension at most two. The same containment holds after base change to $\mathbb C$.

3. If no homogeneous degree $H$ form of real slice rank at most two strictly sign-represents $f$ on the homogenized Boolean cube, then $H^{\ast}(f)\gt H$.

4. The lower relaxation can be strengthened by requiring the slice plane to contain an admissible oriented denominator.

## Proof

Absorb the global constant into the first numerator by replacing $A_1$ with $A_1+cB_1$. Isolate the first head:

$$ P=(A_1+cB_1)\prod_{h=2}^{H}B_h+B_1\sum_{h=2}^{H}A_h\prod_{\substack{g=2\cr g\neq h}}^{H}B_g. $$

Define

$$ L_1=A_1+cB_1,\qquad Q_1=\prod_{h=2}^{H}B_h,\qquad L_2=B_1,\qquad Q_2=\sum_{h=2}^{H}A_h\prod_{\substack{g=2\cr g\neq h}}^{H}B_g. $$

Then $L_1,L_2$ are real linear forms, $Q_1,Q_2$ have degree $H-1$, and $P=L_1Q_1+L_2Q_2$. The second slice generator is the actual denominator $B_1$.

Every denominator is positive on the Boolean cube, so clearing denominators preserves the strict signs of the original score. If a function uses fewer than $H$ heads, add zero-output heads with admissible positive denominators. Clearing then multiplies the lower-degree numerator by positive factors and gives the same conclusion at degree $H$.

Finally, both terms vanish on $V(L_1,L_2)$, which proves the hypersurface containment. $\blacksquare$

## Fixed-Plane Dimension

Let $q=n+1$, let $S=\mathbb R[z_0,\ldots,z_n]$, and let $S_d$ be its degree $d$ part. Fix a two-plane $U=\mathrm{span}(L_1,L_2)\subseteq S_1$ with independent generators. The degree $H$ part of its generated ideal is

$$ (U)_H=L_1S _{H-1}+L_2S _{H-1}. $$

The overlap is exactly the Koszul subspace $L_1L_2S_{H-2}$. Therefore

$$ \dim (U)_H=2\binom{n+H-1}{H-1}-\binom{n+H-2}{H-2}. $$

For fixed $U$, strict sign feasibility is one linear margin problem. The nonlinear outer search is over

$$ \mathrm{Gr}(2,n+1),\qquad \dim\mathrm{Gr}(2,n+1)=2(n-1). $$

If the two slice generators in a representation are dependent, extend their span to a two-plane containing the denominator. Thus the Grassmann relaxation still contains every valid score.

## Singular-Locus Consequence

Differentiating $P=L_1Q_1+L_2Q_2$ shows

$$ J(P)\subseteq(L_1,L_2,Q_1,Q_2), $$

where $J(P)$ is the Jacobian ideal. Hence

$$ \mathrm{Sing}(V(P))\supseteq V(L_1,L_2,Q_1,Q_2). $$

Euler's identity puts $P$ in $J(P)$, so the Jacobian ideal alone defines the projective singular scheme. Krull's height theorem bounds its height by four. Over $\mathbb C$, when $n+1\geq5$ and $P\neq0$, the singular locus has codimension at most four in the ambient projective space, equivalently codimension at most three inside $V(P)$. This is a necessary prefilter, not a characterization of slice rank two.

## Bounded Grassmann Atlas

For a computational certificate, choose a largest Plücker coordinate as pivot and write the plane as the row span of $[I_2\ T]$. Every entry of $T$ is a ratio of Plücker coordinates and therefore lies in $[-1,1]$. The $\binom{n+1}{2}$ pivot choices cover the real Grassmannian.

For each chart, evaluate the redundant feature library

$$ \left(L_1(T)(1,x)m(1,x),L_2(T)(1,x)m(1,x)\right)_m, $$

where $m$ ranges over degree $H-1$ monomials. Koszul and Boolean identities give null directions, so an inradius certificate must first select a full-rank column basis on a maximal-rank cell. The selected feature rows are affine in $T$. A rational centered-hull inradius larger than an exact row-motion bound certifies the whole cell by Gordan's alternative.

Covering the maximal-rank locus is enough. The set of planes with a nonnegative Gordan multiplier is closed, so the certificate extends to the rank-deficient boundary. Zero-inradius cells require subdivision, elimination equations, or an exact real-arithmetic solver.

## Boolean-Cube Limitation

Formal coefficient dimension is not the right screen for truth-table usefulness. After evaluation on the Boolean cube, the maximum fixed-plane rank is

$$ \min\left\lbrace D_H,2D_{H-1}-D_{H-2}\right\rbrace,\qquad D_d=\sum_{j=0}^{d}\binom{n}{j}. $$

If $H\geq\lceil(n+1)/2\rceil$, one fixed plane spans every degree at most $H$ cube polynomial. In that range, even the positivity-aware slice relaxation is exactly threshold degree and cannot improve its lower bound. The proof and the lower-head incidence criterion are in [191_boolean_cube_slice_relaxation_ceiling.md](191_boolean_cube_slice_relaxation_ceiling.md).

## Literature Connection

The slice-rank-two relaxation lies in the second secant of the reducible-form variety of type $(1,H-1)$. Relevant geometric references include [Bik and Oneto](https://arxiv.org/abs/2005.08617) and [Catalisano, Geramita, Gimigliano, Harbourne, Migliore, Nagel, and Shin](https://arxiv.org/abs/1502.00167). [Flavi, Gesmundo, Oneto, and Ventura](https://arxiv.org/abs/2509.12322) give determinantal equations for small strength and a generic-section reduction theorem for cubic slice rank two.

The broader numerical hierarchy is developed in [general_hstar_scalable_research_program.md](https://github.com/karthikviswanathn/how-many-attention-heads-xor/blob/autoresearch/artifacts/calculations/general_hstar_scalable_research_program.md).
