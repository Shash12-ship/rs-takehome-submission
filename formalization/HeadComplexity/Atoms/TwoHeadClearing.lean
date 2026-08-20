import HeadComplexity.Atoms.FracAtom
import HeadComplexity.Polynomial.ModelToPolynomial

set_option linter.style.header false

/-!
# Clearing two fractional atoms

This module exposes the product structure hidden by the general model-to-polynomial
degree bound. Each fractional atom has an affine numerator and a positive affine
denominator on the Boolean cube. Clearing two positive denominators produces a
sum of two products of affine polynomials.
-/

namespace HeadComplexity

open Finset MvPolynomial
open scoped BigOperators

namespace FracAtom

/-- The affine denominator polynomial of a fractional atom. -/
noncomputable def denPoly (φ : FracAtom n) : MvPolynomial (Fin n) ℝ :=
  C φ.γ + ∑ i, affineAt i (φ.ρ i) (φ.ρ i * φ.α)

/-- The affine numerator polynomial of a fractional atom. -/
noncomputable def numPoly (φ : FracAtom n) : MvPolynomial (Fin n) ℝ :=
  C φ.η + ∑ i, affineAt i (φ.ρ i * φ.m i)
    (φ.ρ i * φ.α * (φ.m i + φ.δ))

theorem denPoly_eval (φ : FracAtom n) (x : Fin n → Bool) :
    MvPolynomial.eval (cubePoint x) φ.denPoly = φ.γ + ∑ i, φ.wt x i := by
  simp only [denPoly, map_add, eval_C, map_sum, affineAt_eval]
  congr 1
  refine Finset.sum_congr rfl (fun i _ => ?_)
  unfold wt
  cases x i <;> simp

theorem numPoly_eval (φ : FracAtom n) (x : Fin n → Bool) :
    MvPolynomial.eval (cubePoint x) φ.numPoly =
      φ.η + ∑ i, φ.wt x i * (φ.m i + if x i then φ.δ else 0) := by
  simp only [numPoly, map_add, eval_C, map_sum, affineAt_eval]
  congr 1
  refine Finset.sum_congr rfl (fun i _ => ?_)
  cases hx : x i
  · simp [wt, hx]
  · simp [wt, hx]

theorem denPoly_totalDegree_le (φ : FracAtom n) : φ.denPoly.totalDegree ≤ 1 := by
  unfold denPoly
  refine (totalDegree_add _ _).trans (max_le ?_ ?_)
  · rw [totalDegree_C]
    omega
  · exact totalDegree_finsetSum_le (fun i _ => affineAt_totalDegree_le _ _ _)

theorem numPoly_totalDegree_le (φ : FracAtom n) : φ.numPoly.totalDegree ≤ 1 := by
  unfold numPoly
  refine (totalDegree_add _ _).trans (max_le ?_ ?_)
  · rw [totalDegree_C]
    omega
  · exact totalDegree_finsetSum_le (fun i _ => affineAt_totalDegree_le _ _ _)

theorem eval_eq_numPoly_div_denPoly (φ : FracAtom n) (x : Fin n → Bool) :
    φ.eval x = MvPolynomial.eval (cubePoint x) φ.numPoly /
      MvPolynomial.eval (cubePoint x) φ.denPoly := by
  unfold FracAtom.eval
  rw [numPoly_eval, denPoly_eval]

theorem denPoly_pos (φ : FracAtom n) (x : Fin n → Bool) :
    0 < MvPolynomial.eval (cubePoint x) φ.denPoly := by
  rw [denPoly_eval]
  exact φ.denom_pos x

end FracAtom

/-- Reduce a two-fraction obstruction to an obstruction for a sum of two
products of affine polynomials. -/
theorem not_fracComputable_two_of_no_cleared_affine
    {n : ℕ} {f : (Fin n → Bool) → Bool}
    (hobs : ∀ (L₁ R₁ L₂ R₂ : MvPolynomial (Fin n) ℝ),
      L₁.totalDegree ≤ 1 → R₁.totalDegree ≤ 1 →
      L₂.totalDegree ≤ 1 → R₂.totalDegree ≤ 1 →
      (∀ x, 0 < MvPolynomial.eval (cubePoint x) R₁) →
      (∀ x, 0 < MvPolynomial.eval (cubePoint x) R₂) →
      ¬ SignRepresents (L₁ * R₁ + L₂ * R₂) f) :
    ¬ fracComputable n 2 f := by
  rintro ⟨φ, c, hsign⟩
  let N₀ := (φ 0).numPoly
  let D₀ := (φ 0).denPoly
  let N₁ := (φ 1).numPoly
  let D₁ := (φ 1).denPoly
  let L₁ := MvPolynomial.C c * D₀ + N₀
  have hL₁ : L₁.totalDegree ≤ 1 := by
    unfold L₁
    refine (totalDegree_add _ _).trans (max_le ?_ (φ 0).numPoly_totalDegree_le)
    refine (totalDegree_mul _ _).trans ?_
    have hc : (MvPolynomial.C c : MvPolynomial (Fin n) ℝ).totalDegree ≤ 0 := by
      rw [totalDegree_C]
    simpa [D₀] using Nat.add_le_add hc (φ 0).denPoly_totalDegree_le
  apply hobs L₁ D₁ N₁ D₀ hL₁ (φ 1).denPoly_totalDegree_le
    (φ 1).numPoly_totalDegree_le (φ 0).denPoly_totalDegree_le
    (φ 1).denPoly_pos (φ 0).denPoly_pos
  intro x
  have hs := hsign x
  rw [Fin.sum_univ_two, (φ 0).eval_eq_numPoly_div_denPoly,
    (φ 1).eval_eq_numPoly_div_denPoly] at hs
  rw [← hs]
  simp only [L₁, D₁, N₁, D₀, N₀, map_add, map_mul, eval_C]
  let b := MvPolynomial.eval (cubePoint x) (φ 0).denPoly
  let d := MvPolynomial.eval (cubePoint x) (φ 1).denPoly
  let n0 := MvPolynomial.eval (cubePoint x) (φ 0).numPoly
  let n1 := MvPolynomial.eval (cubePoint x) (φ 1).numPoly
  have hb : 0 < b := (φ 0).denPoly_pos x
  have hd : 0 < d := (φ 1).denPoly_pos x
  have hb0 : b ≠ 0 := hb.ne'
  have hd0 : d ≠ 0 := hd.ne'
  have hid : (c * b + n0) * d + n1 * b = b * d * (c + (n0 / b + n1 / d)) := by
    field_simp
    ring
  have hiff : 0 < (c * b + n0) * d + n1 * b ↔ 0 < c + (n0 / b + n1 / d) := by
    rw [hid]
    exact mul_pos_iff_of_pos_left (mul_pos hb hd)
  simpa only [b, d, n0, n1] using hiff

end HeadComplexity
