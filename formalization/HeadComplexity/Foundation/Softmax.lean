import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Algebra.BigOperators.Field
import Mathlib.Algebra.Module.Basic
import Mathlib.Analysis.SpecialFunctions.Exp

set_option linter.style.header false

/-!
# Finite softmax normalizers.

This module contains model-independent facts about finite positive normalizers
and softmax weights. The transformer model later on specializes these theorems
to its unnormalized attention weights `sigma`.
-/

namespace HeadComplexity

open Finset

/-- A finite sum of strictly positive terms over a nonempty type is strictly
positive. -/
theorem positiveNormalizer_pos {ι : Type*} [Fintype ι] [Nonempty ι]
    (w : ι → ℝ) (hw : ∀ i, 0 < w i) : 0 < ∑ i, w i := by
  apply Finset.sum_pos
  · intro i _
    exact hw i
  · exact Finset.univ_nonempty

/-- The finite softmax denominator `∑ i, exp (s i)`. -/
noncomputable def softmaxDenom {ι : Type*} [Fintype ι] (s : ι → ℝ) : ℝ :=
  ∑ i, Real.exp (s i)

/-- Finite softmax weights. -/
noncomputable def softmax {ι : Type*} [Fintype ι] (s : ι → ℝ) : ι → ℝ :=
  fun i => Real.exp (s i) / softmaxDenom s

/-- The finite softmax denominator is strictly positive. -/
theorem softmaxDenom_pos {ι : Type*} [Fintype ι] [Nonempty ι]
    (s : ι → ℝ) : 0 < softmaxDenom s := by
  exact positiveNormalizer_pos (fun i => Real.exp (s i)) (fun _ => Real.exp_pos _)

/-- Each finite softmax weight is strictly positive. -/
theorem softmax_pos {ι : Type*} [Fintype ι] [Nonempty ι]
    (s : ι → ℝ) (i : ι) : 0 < softmax s i :=
  div_pos (Real.exp_pos _) (softmaxDenom_pos s)

/-- Finite softmax weights are nonnegative. -/
theorem softmax_nonneg {ι : Type*} [Fintype ι] [Nonempty ι]
    (s : ι → ℝ) (i : ι) : 0 ≤ softmax s i :=
  (softmax_pos s i).le

/-- Finite softmax weights sum to one. -/
theorem softmax_sum_one {ι : Type*} [Fintype ι] [Nonempty ι]
    (s : ι → ℝ) : ∑ i, softmax s i = 1 := by
  simp only [softmax, softmaxDenom, ← Finset.sum_div]
  exact div_self (softmaxDenom_pos s).ne'

/-- A two-term normalized weighted sum written with divisions is the
inverse-scaled sum of its weighted summands. -/
theorem twoTermWeightedAverage_eq_inv_smul_sum
    {V : Type*} [AddCommGroup V] [Module ℝ V] (a b : ℝ) (u v : V) :
    (a / (a + b)) • u + (b / (a + b)) • v = (a + b)⁻¹ • (a • u + b • v) := by
  rw [smul_add, smul_smul, smul_smul]
  congr 1
  · rw [div_eq_mul_inv, mul_comm]
  · rw [div_eq_mul_inv, mul_comm]

end HeadComplexity
