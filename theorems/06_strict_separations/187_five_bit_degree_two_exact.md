# Five-Bit Degree-Two Exactness

## Statement

Let $f:\lbrace0,1\rbrace^5\to\lbrace0,1\rbrace$. If

$$ \deg_{\pm}(f)=2, $$

then

$$ H^{\ast}(f)=2. $$

> **Certificate status.** The reduction to fully locked complementary-cycle sign cells is analytic. The last case is computer-assisted: an exhaustive exact cocircuit enumeration and an exact tangent-tope cover reduce it to $380$ archived symmetry classes, each of which has an exact rational two-head certificate.

## Proof

The threshold-degree lower bound [006_threshold_degree_head_complexity_bound.md](../01_foundations_and_normal_form/006_threshold_degree_head_complexity_bound.md) gives

$$ H^{\ast}(f)\geq2. $$

It remains to prove the matching upper bound.

### Lemma 1. Reduction to fully locked complementary cycles

Work on the sign cube. Let $s:\lbrace-1,1\rbrace^5\to\lbrace-1,1\rbrace$ be the target sign table, let $\Phi(z)$ contain the $16$ Fourier monomials of degree at most two, and define the open sign cone

$$ \mathcal{C}_s=\left\lbrace\theta:s(z)\langle\Phi(z),\theta\rangle\gt0\text{ for every }z\in\lbrace-1,1\rbrace^5\right\rbrace. $$

Perturb a point of $\mathcal{C}_s$ so that its ten quadratic coefficients are nonzero, and color the edges of $K_5$ by their signs. The rank-four matrix-completion argument in [the universal two-head reduction](https://github.com/karthikviswanathn/how-many-attention-heads-xor/blob/autoresearch/artifacts/calculations/n5_universal_h2_theorem_lead.md) proves that a monochromatic triangle gives a factorization

$$ q=AD+CB $$

in the Boolean quotient, with one affine denominator in an admissible orientation cone. Replacing $D$ by $D+kB$ and $C$ by $C-kA$ for a sufficiently large positive $k$ puts the other denominator in the same cone without changing $q$. The linear-fractional normal form therefore gives two heads.

If the edge coloring has no monochromatic triangle, each color has degree two at every vertex. Hence the two color classes are complementary five-cycles, uniquely up to coordinate permutation and global color reversal.

Fix one such coloring and write $\sigma_e\in\lbrace-1,1\rbrace$ for its prescribed edge signs. If some edge sign is not locked throughout $\mathcal{C}_s$, convexity gives a path inside $\mathcal{C}_s$ from the original representative to one reversing that edge. Perturb the path so it crosses the ten edge-coordinate hyperplanes one at a time. Immediately after the first crossing, exactly one edge of a complementary-cycle coloring has flipped, which creates a monochromatic triangle. This again gives two heads.

Thus only a **fully locked** complementary-cycle cell remains. For such a cell, every signed edge basis vector has a nonnegative moment representation

$$ \sigma_e e_e=\sum_z\lambda^e_zs(z)\Phi(z), \qquad \lambda^e_z\geq0. $$

Indeed, this cone membership is equivalent by polyhedral separation to the assertion that every strict representative has the prescribed sign on edge $e$.

### Lemma 2. The locked cells form an exact finite archive

A fully locked cell has no nonzero affine polynomial in its closed sign cone. To see this, suppose an affine $g$ satisfies $s(z)g(z)\geq0$ everywhere. Pairing $g$ with the ten locking identities shows that every vertex in the positive support of each $\lambda^e$ lies in the zero set $Z$ of $g$. Consequently all ten edge basis vectors lie in

$$ V_Z=\mathrm{span}\left\lbrace\Phi(z):z\in Z\right\rbrace. $$

If $g$ has a nonzero slope $g_i$, choose $j\neq i$. The quadratic $g(z)z_j$ vanishes on $Z$, so its coefficient vector is orthogonal to $V_Z$. It cannot also be orthogonal to every edge basis vector, because its $ij$ coefficient is $g_i\neq0$. A nonzero constant has empty zero set and is impossible for the same reason. Thus $g=0$.

Put

$$ \ell(\theta)=\sum_e\sigma_e\theta_e. $$

Full locking makes $\ell$ positive on every nonzero point of the closed sign cone. Therefore its section $\ell=1$ is a bounded polytope. A vertex of this section spans an extreme ray with $15$ independent zero evaluations.

The exact support-seventeen enumerator [enumerate_n5_support17_circuit_orbits.cpp](../../artifacts/calculations/enumerate_n5_support17_circuit_orbits.cpp) enumerates every such rank $15$ cocircuit ray. After filtering by the closed complementary-cycle orthant, it gives

$$ 87142\text{ primitive rays}, \qquad 2272\text{ order-}40\text{ ray orbits}. $$

The [cocircuit inventory verifier](../../artifacts/calculations/verify_n5_c5_cocircuit_inventory.py) checks primitivity, rank, parity-twisted self-duality, the orthant inequalities, the symmetry quotient, and the archive digests with exact arithmetic.

Fix one quotient ray $q$ with zero set $Z$. A sign cell incident to $q$ is fixed by $\mathrm{sgn}(q)$ away from $Z$ and chooses one sign at each point of $Z$. The exact tangent cover uses three kinds of leaves.

1. A wrong-edge leaf supplies a quadratic $h$ that weakly has the chosen signs but reverses a prescribed edge. Such a cell is not fully locked.

2. A Gordan leaf supplies nonnegative integers, not all zero, satisfying

   $\sum_z\lambda_zs(z)\Phi(z)+\sum_e\mu_e\sigma_e e_e=0$.

   Pairing this identity with a strict representative in the prescribed edge orthant gives a strictly positive sum equal to zero, so the chosen tangent assignment is not realizable.

3. An archive leaf identifies the sign table with a symmetry image of one of $380$ stored masks.

For simple rays, exact rational edge-forcing equations eliminate additional tangent subcubes before these clauses are applied. The final archive has $5837$ primitive wrong-edge quadratics and $892$ nonnegative integer Gordan circuits. The [tangent-cover verifier](../../artifacts/calculations/verify_n5_c5_cocircuit_tangent_cover.py) checks every identity and every Boolean tangent cube exactly, without an optimization solver. It follows that every fully locked complementary-cycle cell is symmetry-equivalent to one of the $380$ archived classes.

### Lemma 3. Every archived class has two heads

For an archived sign table $s$, normalize its closed sign polytope by

$$ \mathcal{P}_s=\left\lbrace\theta:s(z)\langle\Phi(z),\theta\rangle\geq0\text{ for every }z,\quad \sum_zs(z)\langle\Phi(z),\theta\rangle=1\right\rbrace. $$

Maximize a prescribed signed chord coefficient on $\mathcal{P}_s$. The exact [fixed-chord extremizer verifier](../../artifacts/calculations/verify_n5_c5_fixed_chord_extremizer.py) reconstructs a rational optimizer ray, proves its optimality with a rational dual supported on its zero evaluations, reconstructs a rational strict interior point, and verifies an exact rational two-scale Schur witness after perturbing toward that interior point.

Chord $02$ certifies $379$ classes. The single exceptional class is certified by chord $14$. Thus all $380$ classes have a trace-preserving rank-four completion of inertia $(2,2)$ whose dual null cone contains an admissible affine factor. The dual-isotropic factor criterion converts each completion into a two-product factorization with admissible denominators, hence into a two-head score.

Lemmas 1 through 3 show that every strict five-bit quadratic threshold has head complexity at most two. Combining this with the lower bound gives

$$ H^{\ast}(f)=\deg_{\pm}(f)=2. \qquad\blacksquare $$

## Verification

Run the analytic finite checks and exact archives with

```text
python3 artifacts/calculations/verify_n5_k5_stress_reduction.py
python3 artifacts/calculations/verify_n5_c5_cocircuit_inventory.py
python3 artifacts/calculations/verify_n5_c5_cocircuit_tangent_cover.py artifacts/calculations/n5_c5_tangent_clause_cover.json
python3 artifacts/calculations/verify_n5_c5_fixed_chord_extremizer.py --incidence artifacts/calculations/n5_c5_locked_extreme_ray_incidence.json
```

The final exact summaries include

```text
closed-C5 primitive cocircuit rays: 87142
closed-C5 cocircuit ray orbits: 2272
wrong-edge clauses: 5837
Gordan clauses: 892
verified exact cocircuit tangent clause cover
archived quotient classes checked: 380
objective edge counts: {(0, 2): 379, (1, 4): 1}
```

## Consequence

Together with the exact constant and one-head characterizations, every five-bit function of threshold degree at most two has head complexity equal to its threshold degree. Combined with the degree-four theorem and the exact parity theorem, any five-bit strict separation must have threshold degree three.
