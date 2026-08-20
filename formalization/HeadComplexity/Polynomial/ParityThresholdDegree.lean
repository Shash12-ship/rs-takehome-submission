import HeadComplexity.Polynomial.UnivariateReduction

set_option linter.style.header false

/-!
# Theorem 7 — parity has threshold degree exactly `n`.

`deg±(PARITY_n) = n`, where `deg±` is the least total degree of a real polynomial
sign-representing the function on the Boolean cube (`thresholdDeg` below).

* **Upper bound** `deg± ≤ n`: the witness `P := -∏ i, (1 - 2 X_i)` evaluates on the
  cube to `-(-1)^{|x|}`, which is positive exactly when `|x|` is odd, i.e. when
  `PARITY_n x` is true; it has total degree `≤ n`.
* **Lower bound** `n ≤ deg±`: reuse the symmetric lower-bound machinery
  `signChanges_le_of_ThresholdDegLE` — any sign representation of total degree `H`
  forces `signChanges n (parity profile) = n ≤ H`.
-/

namespace HeadComplexity

open MvPolynomial Finset

variable {n : ℕ}

/-- The (sign-representation) threshold degree `deg±(f)`: the least `d` for which a
real polynomial of total degree `≤ d` sign-represents `f` on the cube. -/
noncomputable def thresholdDeg (f : (Fin n → Bool) → Bool) : ℕ := by
  classical
  exact if h : ∃ d, ThresholdDegLE f d then Nat.find h else 0

/-! ## The parity sign polynomial `-∏ (1 - 2 X_i)` -/

/-- Each factor `C 1 - C 2 * X i` has total degree `≤ 1`. -/
theorem totalDegree_parityFactor (i : Fin n) :
    (C (1 : ℝ) - C 2 * X i).totalDegree ≤ 1 := by
  refine (totalDegree_sub _ _).trans (max_le ?_ ?_)
  · rw [totalDegree_C]; exact Nat.zero_le _
  · refine (totalDegree_mul _ _).trans ?_
    rw [totalDegree_C, Nat.zero_add]
    exact le_of_eq (totalDegree_X i)

/-- Evaluating the parity polynomial on a cube point. -/
theorem eval_parityPoly (x : Fin n → Bool) :
    eval (cubePoint x) (-∏ i : Fin n, (C 1 - C 2 * X i))
      = -∏ i : Fin n, (1 - 2 * boolToReal (x i)) := by
  rw [map_neg, map_prod]
  congr 1
  refine Finset.prod_congr rfl (fun i _ => ?_)
  simp [cubePoint, map_sub, map_mul, eval_C, eval_X]

/-- On the cube the product of `1 - 2 x_i` is `(-1)^{|x|}`. -/
theorem prod_one_sub_two (x : Fin n → Bool) :
    ∏ i : Fin n, (1 - 2 * boolToReal (x i)) = (-1 : ℝ) ^ hammingWeight x := by
  have hterm : ∀ i : Fin n,
      (1 - 2 * boolToReal (x i) : ℝ) = if x i = true then (-1 : ℝ) else 1 := by
    intro i
    rcases Bool.eq_false_or_eq_true (x i) with h | h <;> rw [h] <;> norm_num [boolToReal]
  rw [Finset.prod_congr rfl (fun i _ => hterm i), ← Finset.prod_filter, Finset.prod_const]
  rfl

/-- `0 < -(-1)^m` exactly when `m` is odd. -/
theorem neg_neg_one_pow_pos_iff (m : ℕ) : (0 : ℝ) < -((-1 : ℝ) ^ m) ↔ Odd m := by
  constructor
  · intro h
    by_contra hodd
    rw [Nat.not_odd_iff_even] at hodd
    rw [hodd.neg_one_pow] at h
    norm_num at h
  · intro hodd
    rw [hodd.neg_one_pow]; norm_num

/-- The parity polynomial sign-represents `PARITY n`. -/
theorem signRep_parityPoly : SignRepresents (-∏ i : Fin n, (C 1 - C 2 * X i)) (PARITY n) := by
  intro x
  rw [eval_parityPoly, prod_one_sub_two, neg_neg_one_pow_pos_iff,
    PARITY_eq_symmetricFn, symmetricFn_apply]
  simp [decide_eq_true_eq]

/-- **Upper bound.** Parity has threshold degree at most `n`. -/
theorem parity_ThresholdDegLE (n : ℕ) : ThresholdDegLE (PARITY n) n := by
  refine ⟨-∏ i : Fin n, (C 1 - C 2 * X i), ?_, signRep_parityPoly⟩
  rw [totalDegree_neg]
  have h := totalDegree_prod_le_card (Finset.univ : Finset (Fin n))
    (fun i => C (1 : ℝ) - C 2 * X i) totalDegree_parityFactor
  simpa using h

/-! ## Theorem 7 -/

/-- **Theorem 7.** Parity has threshold degree exactly `n`. -/
theorem thresholdDeg_parity (n : ℕ) : thresholdDeg (PARITY n) = n := by
  classical
  have hex : ∃ d, ThresholdDegLE (PARITY n) d := ⟨n, parity_ThresholdDegLE n⟩
  rw [thresholdDeg, dif_pos hex]
  refine le_antisymm (Nat.find_min' hex (parity_ThresholdDegLE n)) ?_
  have hspec : ThresholdDegLE (n := n) (symmetricFn (fun k => decide (Odd k))) (Nat.find hex) := by
    rw [← PARITY_eq_symmetricFn]; exact Nat.find_spec hex
  have hsc := signChanges_le_of_ThresholdDegLE hspec
  rwa [signChanges_parity] at hsc

end HeadComplexity
