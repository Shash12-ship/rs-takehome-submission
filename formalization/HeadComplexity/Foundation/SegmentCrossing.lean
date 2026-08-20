import Mathlib.Analysis.Convex.Segment
import HeadComplexity.Foundation.Vec

set_option linter.style.header false

/-!
# Segment crossing obstruction.

If a point `P` lies on the segment `[p, q]` and also on the segment
`[r, s]`, then no linear functional can place `p, q` strictly below
a threshold `τ` while placing `r, s` strictly above it. This is the
geometric core of the one-head XOR impossibility argument.
-/

namespace HeadComplexity

/-- A convex combination of two reals, both at most `τ`, is at most `τ`. -/
private theorem convex_sum_le {a b τ x y : ℝ}
    (ha : 0 ≤ a) (hb : 0 ≤ b) (hab : a + b = 1)
    (hx : x ≤ τ) (hy : y ≤ τ) : a * x + b * y ≤ τ := by
  have max_le : max x y ≤ τ := by apply max_le hx hy
  have := Convex.combo_le_max x y ha hb hab
  simp only [smul_eq_mul] at this
  exact le_trans this max_le

/-- A convex combination of two reals, both strictly greater than `τ`,
is strictly greater than `τ`. -/
private theorem lt_convex_sum {a b τ x y : ℝ}
    (ha : 0 ≤ a) (hb : 0 ≤ b) (hab : a + b = 1)
    (hx : τ < x) (hy : τ < y) : τ < a * x + b * y := by
  have min_lt : τ < min x y := by apply lt_min hx hy
  have := Convex.min_le_combo x y ha hb hab
  simp only [smul_eq_mul] at this
  exact lt_of_lt_of_le min_lt this

/-- **Segment crossing obstruction.** If a point `P` lies simultaneously on
the segments `[p, q]` and `[r, s]`, then no linear functional `L` can place
`L p, L q` weakly below a threshold `τ` while placing `L r, L s` strictly
above `τ`. The asymmetry (weak `≤` on one side, strict `<` on the other) is
exactly what the XOR-impossibility application needs. -/
theorem segment_cross_not_separable
    {V : Type*} [AddCommGroup V] [Module ℝ V]
    {p q r s : V} (L : V →ₗ[ℝ] ℝ) {τ : ℝ}
    (hp : L p ≤ τ) (hq : L q ≤ τ) (hr : τ < L r) (hs : τ < L s)
    {P : V} (hPpq : P ∈ segment ℝ p q) (hPrs : P ∈ segment ℝ r s) : False := by
  obtain ⟨a, b, ha, hb, hab, hP1⟩ := hPpq
  obtain ⟨c, e, hc, he, hce, hP2⟩ := hPrs
  have hLP_le : L P ≤ τ := by
    rw [← hP1, map_add, L.map_smul, L.map_smul, smul_eq_mul, smul_eq_mul]
    exact convex_sum_le ha hb hab hp hq
  have hLP_gt : τ < L P := by
    rw [← hP2, map_add, L.map_smul, L.map_smul, smul_eq_mul, smul_eq_mul]
    exact lt_convex_sum hc he hce hr hs
  exact not_le.mpr hLP_gt hLP_le

end HeadComplexity
