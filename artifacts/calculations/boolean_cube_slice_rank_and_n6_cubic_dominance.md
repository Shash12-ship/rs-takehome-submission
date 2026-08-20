# Exact Boolean-Cube Slice-Rank Certificate

## Scope

The standalone verifier
`verify_boolean_cube_slice_rank_and_n6_cubic_dominance.py` checks two claims.

1. On the grid $2\leq n\leq7$ and $2\leq H\leq n$, the explicit plane

   $U_0=\mathrm{span}(1,x_0+\cdots+x_{n-1})$

   attains the rank in Theorem 191:

   $r_H=\min\lbrace D_H,2D_{H-1}-D_{H-2}\rbrace$.

   It also constructs and checks the $D_{H-2}$ independent Koszul kernel
   vectors $(L_2R,-L_1R)$.

2. For $n=6$ and $H=3$, it stores an explicit integer chart point
   $(T,c_1,c_2)$ and reconstructs the full $42\times54$ parameter Jacobian by
   exact finite differences. Its rank is $42$ modulo $1000003$. Therefore the
   integer Jacobian has rank $42$ over $\mathbb Q$, proving that the evaluated
   cubic slice incidence is dominant and contains a real Euclidean-open set.

The script uses only the Python standard library.

## Verification

Run:

```bash
python artifacts/calculations/verify_boolean_cube_slice_rank_and_n6_cubic_dominance.py
```

The final lines report the grid count, the Jacobian dimensions, the modular
rank, the pivot columns, and a nonzero pivot determinant.

## Interpretation

The rank formula is proved in
`lemmas/02_complexity_measure_upper_bounds/191_boolean_cube_slice_relaxation_ceiling.md`.
The finite grid is an independent executable audit of its multiplication-map
calculation, not a replacement for the proof.

The Jacobian certificate proves dominance of the plain evaluated slice family
for cubic six-bit coefficient space. It does not assert that every truth-table
sign cone meets that family, nor that the particular parity-triple sign cone
does.
