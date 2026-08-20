import HeadComplexity.Model.AdditiveSplit
import HeadComplexity.Examples.TwoBit

set_option linter.style.header false

/-!
# Theorem 1: one attention head cannot compute XOR.

A single `Head 2 d` would give a one-head realization of the two-bit XOR
function, but the model-level checkerboard lower bound rules that out.
-/

namespace HeadComplexity

open scoped InnerProductSpace

variable {d : ℕ} (H : Head 2 d)

/-- The Bool-product view of a two-bit input. -/
private def pairBits (ab : Bool × Bool) : Fin 2 → Bool :=
  bits2 ab.1 ab.2

@[simp] private theorem pairBits_mk (a b : Bool) :
    pairBits (a, b) = bits2 a b := rfl

private theorem restrictBits_pairBits (ab : Bool × Bool) :
    Head.restrictBits (fun _ : Fin 2 => false) 0 1 ab = pairBits ab := by
  rcases ab with ⟨a, b⟩
  exact restrictBits_zero_one a b

/-- The attention numerator as a Bool-product map. -/
private noncomputable def boolNumerator (H : Head 2 d) (ab : Bool × Bool) : Vec d :=
  H.numerator (pairBits ab)

/-- The attention denominator as a Bool-product map. -/
private noncomputable def boolDenominator (H : Head 2 d) (ab : Bool × Bool) : ℝ :=
  H.denominator (pairBits ab)

/-- The attention update as a Bool-product map. -/
private noncomputable def boolUpdate (H : Head 2 d) (ab : Bool × Bool) : Vec d :=
  H.attnUpdate (pairBits ab)

/-- The attention denominator is strictly positive on the Bool-product view. -/
theorem denominator_pos (ab : Bool × Bool) : 0 < boolDenominator H ab := by
  simpa [boolDenominator] using Head.denominator_pos H (pairBits ab)

theorem denominator_ne_zero (ab : Bool × Bool) : boolDenominator H ab ≠ 0 :=
  (denominator_pos H ab).ne'

/-- The two-bit numerator split, obtained by specializing the generalized model. -/
theorem numerator_additive_split :
    ∃ (A B : Bool → Vec d) (C : Vec d), ∀ a b : Bool,
      boolNumerator H (a, b) = A a + B b + C := by
  have h01 : (0 : Fin 2) ≠ 1 := by decide
  rcases Head.numerator_additive_split H (fun _ : Fin 2 => false) 0 1 h01 with
    ⟨A, B, C, h⟩
  refine ⟨A, B, C, ?_⟩
  intro a b
  simpa [boolNumerator, pairBits, restrictBits_zero_one] using h a b

/-- The two-bit denominator split, obtained by specializing the generalized model. -/
theorem denominator_additive_split :
    ∃ (α β : Bool → ℝ) (γ : ℝ), ∀ a b : Bool,
      boolDenominator H (a, b) = α a + β b + γ := by
  have h01 : (0 : Fin 2) ≠ 1 := by decide
  rcases Head.denominator_additive_split H (fun _ : Fin 2 => false) 0 1 h01 with
    ⟨α, β, γ, h⟩
  refine ⟨α, β, γ, ?_⟩
  intro a b
  simpa [boolDenominator, pairBits, restrictBits_zero_one] using h a b

/-- The antipode identity for the attention numerator: summing `N(a,b)`
over the diagonal equals summing over the off-diagonal. -/
theorem numerator_antipode :
    boolNumerator H (false, false) + boolNumerator H (true, true)
    = boolNumerator H (false, true) + boolNumerator H (true, false) := by
  exact boolSquare_antipode_of_additive_split
    (fun a b => boolNumerator H (a, b)) (numerator_additive_split H)

/-- The antipode identity for the attention denominator: summing `D(a,b)`
across the diagonal equals summing across the off-diagonal. -/
theorem denominator_antipode :
    boolDenominator H (false, false) + boolDenominator H (true, true)
    = boolDenominator H (false, true) + boolDenominator H (true, false) := by
  exact boolSquare_antipode_of_additive_split
    (fun a b => boolDenominator H (a, b)) (denominator_additive_split H)

/-- Multiplying the attention update by the denominator recovers the numerator. -/
theorem denom_smul_attn (ab : Bool × Bool) :
    boolDenominator H ab • boolUpdate H ab = boolNumerator H ab := by
  simpa [boolDenominator, boolUpdate, boolNumerator] using Head.denom_smul_attn H (pairBits ab)

/-- The **midpoint** `P` of the four attention outputs: `𝒟⁻¹ • 𝒩`. -/
noncomputable def midpoint : Vec d :=
  (boolDenominator H (false, false) + boolDenominator H (true, true))⁻¹
  • (boolNumerator H (false, false) + boolNumerator H (true, true))

/-- The midpoint lies on the diagonal segment `[z(ff,ff), z(tt,tt)]`. -/
theorem midpoint_in_diag_segment :
    midpoint H ∈ segment ℝ (boolUpdate H (false, false)) (boolUpdate H (true, true)) := by
  set D0 := boolDenominator H (false, false)
  set D1 := boolDenominator H (true, true)
  have hpos : (0 : ℝ) < D0 + D1 :=
    add_pos (denominator_pos H _) (denominator_pos H _)
  refine ⟨D0 / (D0 + D1), D1 / (D0 + D1), ?_, ?_, ?_, ?_⟩
  · exact div_nonneg (denominator_pos H _).le hpos.le
  · exact div_nonneg (denominator_pos H _).le hpos.le
  · rw [← add_div, div_self hpos.ne']
  · unfold midpoint
    rw [← denom_smul_attn H (false, false), ← denom_smul_attn H (true, true)]
    exact twoTermWeightedAverage_eq_inv_smul_sum _ _ _ _

/-- The midpoint also lies on the off-diagonal segment `[z(ff,tt), z(tt,ff)]`,
because the denominator and numerator antipode identities make both
representations of the midpoint equal. -/
theorem midpoint_in_offdiag_segment :
    midpoint H ∈ segment ℝ (boolUpdate H (false, true)) (boolUpdate H (true, false)) := by
  set D0 := boolDenominator H (false, true)
  set D1 := boolDenominator H (true, false)
  have hpos : (0 : ℝ) < D0 + D1 :=
    add_pos (denominator_pos H _) (denominator_pos H _)
  refine ⟨D0 / (D0 + D1), D1 / (D0 + D1), ?_, ?_, ?_, ?_⟩
  · exact div_nonneg (denominator_pos H _).le hpos.le
  · exact div_nonneg (denominator_pos H _).le hpos.le
  · rw [← add_div, div_self hpos.ne']
  · unfold midpoint
    rw [numerator_antipode H, denominator_antipode H,
        ← denom_smul_attn H (false, true), ← denom_smul_attn H (true, false)]
    exact twoTermWeightedAverage_eq_inv_smul_sum _ _ _ _

/-- A separate proof that no single attention head can compute XOR:
for every `H`, the bare attention update is not linearly separable into
XOR classes. -/
example {d : ℕ} (H : Head 2 d) :
     ¬ computesXor H.attnUpdate := by
  rintro ⟨w, τ, hw⟩
  -- Diagonal inputs (XOR = false): `⟨w, z⟩ ≤ τ`.
  have h00 : ⟪w, boolUpdate H (false, false)⟫_ℝ ≤ τ := by
    by_contra h
    have hx := (hw (bits2 false false)).mp (by
      simpa [boolUpdate, pairBits] using lt_of_not_ge h)
    simp [xorFn] at hx
  have h11 : ⟪w, boolUpdate H (true, true)⟫_ℝ ≤ τ := by
    by_contra h
    have hx := (hw (bits2 true true)).mp (by
      simpa [boolUpdate, pairBits] using lt_of_not_ge h)
    simp [xorFn] at hx
  -- Off-diagonal inputs (XOR = true): `⟨w, z⟩ > τ`.
  have h01 : τ < ⟪w, boolUpdate H (false, true)⟫_ℝ := by
    have hx := (hw (bits2 false true)).mpr (by simp [xorFn])
    simpa [boolUpdate, pairBits] using hx
  have h10 : τ < ⟪w, boolUpdate H (true, false)⟫_ℝ := by
    have hx := (hw (bits2 true false)).mpr (by simp [xorFn])
    simpa [boolUpdate, pairBits] using hx
  -- Apply the segment-crossing obstruction.
  exact segment_cross_not_separable (innerLeftLin w) h00 h11 h01 h10
    (midpoint_in_diag_segment H) (midpoint_in_offdiag_segment H)

/-- **Theorem 1 (attention update form).** No single head computes
two-bit XOR from the bare attention update. -/
theorem one_head_cannot_xor_attnUpdate {d : ℕ} (H : Head 2 d) :
    ¬ computesXor H.attnUpdate := by
  intro hxor
  have hcomp : computableWithHeadsN 2 1 xorFn := by
    refine ⟨d, fun _ => H, ?_⟩
    rcases hxor with ⟨w, τ, hw⟩
    refine ⟨w, τ, ?_⟩
    intro bits
    simpa [computesXor, headFamilyAttnUpdate] using hw bits
  have h00 : xorFn (Head.restrictBits (fun _ => false) 0 1 (false, false)) = false := by
    simp [xorFn, Head.restrictBits]
  have h11 : xorFn (Head.restrictBits (fun _ => false) 0 1 (true, true)) = false := by
    simp [xorFn, Head.restrictBits]
  have h01 : xorFn (Head.restrictBits (fun _ => false) 0 1 (false, true)) = true := by
    simp [xorFn, Head.restrictBits]
  have h10 : xorFn (Head.restrictBits (fun _ => false) 0 1 (true, false)) = true := by
    simp [xorFn, Head.restrictBits]
  exact (parity_restriction_not_computable_with_one_head
    xorFn (fun _ => false) 0 1 (by decide) h00 h11 h01 h10) hcomp

/-- The skip connection does not change two-bit XOR computability. -/
theorem computesXor_residual_iff_attnUpdate {d : ℕ} (H : Head 2 d) :
    computesXor H.residual ↔ computesXor H.attnUpdate := by
  simpa [computesXor] using Head.computesPred_residual_iff_attnUpdate H xorFn

/-- **Theorem 1 (full residual form).** No single head computes
two-bit XOR from the query residual stream. -/
theorem one_head_cannot_xor_residual {d : ℕ} (H : Head 2 d) :
    ¬ computesXor H.residual := by
  rw [computesXor_residual_iff_attnUpdate]
  exact one_head_cannot_xor_attnUpdate H

end HeadComplexity
