# Theorem Folders

The lemma and theorem proofs are grouped into six thematic folders. Numbering inside each
filename is preserved (it matches the order in [`../theorems.md`](../theorems.md), the
statement ledger). The folders follow the natural arc of the development, from the
structural core out to the current frontier.

| folder | files | theme |
|---|---|---|
| `01_foundations_and_normal_form` | 001-027 | Linear-fractional normal form, checkerboard one-head lower bound, threshold-degree bounds, symmetric & positive-projection sign-change theory, small-`n` exact classification, universal per-width determinant-span bounds, counting lower bound. |
| `02_complexity_measure_upper_bounds` | 028-045, 190-197 | Restriction/junta/sign-rank invariances, classical upper bounds, Fourier support, the slice-rank-two obstruction and its exact Boolean-cube ceiling, the multiway sign-tensor limitation, exact positive-secant diagonal blow-ups, atomic-margin sparsification, optimal Fourier-tail selection, and exact box-sum affine bounds. |
| `03_function_families_and_affine_geometry` | 046-073 | Exact head complexity for named families (affine parity, inner product, equality, intersection / Hamming-distance / directed-defect profiles, two- and three-pair families) and affine geometry (level sets, slabs, two-point and clean supports, positive runs), plus depth-two-tree and hybrid exactness. |
| `04_recursions_and_cost_invariants` | 074-126 | Cofactor and one-bit branching recursions, decision lists / threshold votes / calibration, the cylinder-threshold cost (`ctc`) and affine-cylinder cost (`actc`) invariants and their cofactor interpolation, and the halfspace-intersection lower bound. |
| `05_positive_statistic_gates_and_grids` | 127-179 | The current frontier: one-bit gates over a positive statistic, multi-raw-slice and shared-statistic sandwiches, raw-mask gates, positive grids, Hamming-layer and multigrid profile bounds. |
| `06_strict_separations` | 180 onward | Explicit strict separations down to eight bits, including antipodal-slice and Hamming-threshold constructions, plus exact classification through four bits and the five-bit degree-two and degree-four classes. |

The organizing spine across all folders is the sandwich

```
deg_±(f)  ≤  H*(f) = L_frac(f)  ≤  C_+(f)  ≤  M_+(f) − 1
```

with a parallel sparse-polynomial route `deg_± ≤ H* ≤ afs_± ≤ ptfsp`. Most lemmas
are machinery for one of these inequalities, or exactness results where a lower
bound (degree / checkerboard) meets an upper bound (sign-changes / construction).
Theorem 189 shows that the first inequality can be strict on eight input bits. Theorems 186 and 187 prove equality throughout the five-bit degree-four and degree-two classes, respectively. Theorem 190 adds a general slice-rank-two obstruction between threshold degree and exact head feasibility. Theorem 191 identifies exactly when Boolean evaluation collapses that relaxation back to threshold degree. Theorem 192 extends the tangent rank cap to multiway coordinate tensors and proves that rank alone cannot improve the balanced matrix input-count screen. Theorem 193 replaces the positive-secant endpoint diagonal by finitely charted tangent directions without changing strict feasibility. Theorem 194 retains the mixture scalar and gives a closed compactification with only one signed inequality per truth-table vertex. Theorem 195 sparsifies any well-conditioned convex combination of normalized one-head score vectors. Theorem 196 computes the optimal absolute Fourier-tail compiler certificate by an exact knapsack dynamic program. Theorem 197 computes exact affine intervals on box-sum cells by a greedy fractional-knapsack rule.
