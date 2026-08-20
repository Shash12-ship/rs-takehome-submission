# Five-Bit Degree-Four Exactness

## Statement

Let $f:\lbrace0,1\rbrace^5\to\lbrace0,1\rbrace$. If

$$ \deg_{\pm}(f)=4, $$

then

$$ H^{\ast}(f)=4. $$

> **Certificate status.** The proof is computer-assisted. The reduction, family-shattering witnesses, and every residual cleared score are verified with exact integer arithmetic. Floating-point searches were used only to discover candidate denominator tuples.

## Proof

The general threshold-degree lower bound gives

$$ H^{\ast}(f)\geq4. $$

It remains to prove the matching four-head upper bound.

### Lemma 1. Degree four reduces to affine-cocircuit extensions

Work on the sign cube. Let $s:\lbrace-1,1\rbrace^5\to\lbrace-1,1\rbrace$ be the target sign table, put

$$ \chi(z):=z_1z_2z_3z_4z_5, \qquad t(z):=s(z)\chi(z), $$

and let $V_3$ be the Fourier space of degree at most three. Gordan's alternative and Fourier orthogonality give

$$ s\notin\mathrm{sgn}(V_3) \qquad\Longleftrightarrow\qquad \text{there is a nonzero affine }L\text{ with }t(z)L(z)\geq0\text{ for every }z. $$

Every nonzero pointed weak-separator cone has an extreme ray vanishing on five affinely independent cube vertices. Exact generalized cross products therefore reduce all weak affine sign tables to sign extensions of $3254$ primitive affine normals up to sign.

Coordinate permutations, simultaneous complementation of all five inputs, and output complementation reduce these normals to $65$ orbits. Their zero-set sizes are distributed as follows.

$$ \begin{array}{c|rrrrrr} \text{zero-set size} & 5 & 7 & 8 & 10 & 12 & 16 \cr \hline \text{number of orbits} & 31 & 11 & 12 & 3 & 5 & 3. \end{array} $$

The exact enumeration contains $4475540$ weak affine extensions. Two twist back to parity and its complement, which have threshold degree five. The remaining

$$ 4475538 $$

tables have threshold degree exactly four. The verifier [verify_n5_degree4_reduction.py](../../artifacts/calculations/verify_n5_degree4_reduction.py) checks the enumeration and orbit reduction exactly.

### Lemma 2. Sixty normal orbits admit uniform shattering certificates

Fix an affine normal with zero set $Z$. Away from $Z$, the target signs are forced by the normal and the parity twist. On $Z$, the signs are arbitrary.

For fixed admissible denominators $B_1,\ldots,B_4$, let $W$ be the cleared four-head score space

$$ W:=\left\lbrace c\prod_{h=1}^{4}B_h+\sum_{h=1}^{4}A_h\prod_{g\neq h}B_g:c\in\mathbb{R},\ A_h\text{ affine}\right\rbrace. $$

Suppose the restriction map $W\to\mathbb{R}^{Z}$ is surjective and there is a score $q_0\in W$ which vanishes on $Z$ and has the forced strict signs away from $Z$. Given arbitrary target signs on $Z$, choose $q_1\in W$ with those signs on $Z$. For every sufficiently large positive $M$, the score

$$ q_1+Mq_0 $$

has the requested signs on $Z$ and the forced signs away from $Z$. Thus one denominator tuple covers the whole normal family.

The exact certificate archive [n5_degree4_family_shattering_certificates.json](../../artifacts/calculations/n5_degree4_family_shattering_certificates.json) supplies such a tuple for $60$ of the $65$ normal orbits. Its verifier checks denominator positivity and orientation, exact restriction rank modulo $1000003$, exact vanishing on $Z$, and strict integer signs away from $Z$.

### Lemma 3. The five residual normal orbits have exact finite coverage

The residual orbit indices are

$$ 8, \qquad 44, \qquad 62, \qquad 63, \qquad 64. $$

Their extension families have respectively

$$ 32, \qquad 256, \qquad 65535, \qquad 65536, \qquad 65536 $$

targets after excluding the parity extension in orbit $62$. Output complements are represented canonically and are covered by complement invariance.

For orbits $8,44,63,64$, the four archives named `n5_degree4_orbit_*_exact_coverage.npz` store admissible denominator dictionaries, a witness index for every target, and integral cleared-score coefficients. The verifier [verify_n5_degree4_other_residuals.py](../../artifacts/calculations/verify_n5_degree4_other_residuals.py) reconstructs every cleared matrix and checks every target sign exactly.

For orbit $62$, the archive [n5_degree4_face_family_certificate.npz](../../artifacts/calculations/n5_degree4_face_family_certificate.npz) stores the same data for all $65535$ non-parity targets. All but two coefficient rows fit in signed $64$-bit integers; the two exceptional rows are stored as exact decimal integers. The verifier [classify_n5_degree4_face_family.py](../../artifacts/calculations/classify_n5_degree4_face_family.py) checks denominator positivity, denominator orientation, the complete target list, and all cleared-score signs using arbitrary-precision integer arithmetic.

### Conclusion

Lemmas 1 through 3 give a four-head score for every five-bit function of threshold degree four. Hence

$$ H^{\ast}(f)\leq4. $$

Together with the threshold-degree lower bound,

$$ H^{\ast}(f)=\deg_{\pm}(f)=4. \qquad\blacksquare $$

## Verification

Run the exact checks with

```text
python3 artifacts/calculations/verify_n5_degree4_reduction.py
python3 artifacts/calculations/search_n5_degree4_family_shattering.py --verify-only
python3 artifacts/calculations/verify_n5_degree4_other_residuals.py
python3 artifacts/calculations/classify_n5_degree4_face_family.py
```

The final summaries are

```text
five-bit exact degree-four functions: 4475538
verified exact H4 shattering for 60 cocircuit families
orbit 8: verified 32 exact H4 certificates using 17 denominator tuples
orbit 44: verified 256 exact H4 certificates using 36 denominator tuples
orbit 63: verified 65536 exact H4 certificates using 295 denominator tuples
orbit 64: verified 65536 exact H4 certificates using 114 denominator tuples
verified exact H4 certificates for all 65535 face-family targets
```

## Consequence

By itself, this theorem leaves threshold degree two or three as the only possibilities for a five-bit strict separation. Together with the degree-two classification in
[187_five_bit_degree_two_exact.md](187_five_bit_degree_two_exact.md), any five-bit strict separation must have threshold degree three.
