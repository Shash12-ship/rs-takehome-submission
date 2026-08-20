import HeadComplexity.BooleanCube.SymmetricSignChanges
import Mathlib.Algebra.Polynomial.Roots
import Mathlib.Algebra.Polynomial.BigOperators
import Mathlib.Algebra.Order.BigOperators.Ring.Finset

set_option linter.style.header false

/-!
# Sign polynomial for a weight profile (L12 upper bound).

For `F : ℕ → Bool` and `n`, we build `P : ℝ[X]` with `natDegree P ≤ signChanges n F`
and, for every `k ≤ n`, `0 < P.eval k ↔ F k = true`.  `P` places a root at each
half-integer `t + 1/2` where `F` changes between `t` and `t+1`, scaled by a global
sign chosen from `F n`.
-/

open Polynomial Finset

namespace HeadComplexity

variable (F : ℕ → Bool) (n : ℕ)

/-- The set of sign-change positions of `F` below `n`. -/
def changeSet : Finset ℕ := (Finset.range n).filter (fun t => F t ≠ F (t + 1))

/-- Number of sign changes at position `≥ k`. -/
def negCount (k : ℕ) : ℕ := ((changeSet F n).filter (fun t => k ≤ t)).card

theorem changeSet_card : (changeSet F n).card = signChanges n F := rfl

/-- Recurrence for `negCount` across one step. -/
theorem negCount_succ {k : ℕ} (hk : k < n) :
    negCount F n k = negCount F n (k + 1) + (if F k ≠ F (k + 1) then 1 else 0) := by
  classical
  unfold negCount changeSet
  rw [Finset.filter_filter, Finset.filter_filter]
  have hsplit : ((Finset.range n).filter (fun t => F t ≠ F (t + 1) ∧ k ≤ t))
      = ((Finset.range n).filter (fun t => F t ≠ F (t + 1) ∧ k + 1 ≤ t))
        ∪ ((Finset.range n).filter (fun t => F t ≠ F (t + 1) ∧ t = k)) := by
    rw [← Finset.filter_or]
    apply Finset.filter_congr
    intro t ht
    rw [Finset.mem_range] at ht
    constructor
    · rintro ⟨h1, h2⟩; rcases Nat.lt_or_ge k t with h | h
      · exact Or.inl ⟨h1, h⟩
      · exact Or.inr ⟨h1, le_antisymm h h2⟩
    · rintro (⟨h1, h2⟩ | ⟨h1, h2⟩)
      · exact ⟨h1, by omega⟩
      · exact ⟨h1, by omega⟩
  have hdisj : Disjoint ((Finset.range n).filter (fun t => F t ≠ F (t + 1) ∧ k + 1 ≤ t))
      ((Finset.range n).filter (fun t => F t ≠ F (t + 1) ∧ t = k)) := by
    rw [Finset.disjoint_filter]
    intro x _ hx; omega
  rw [hsplit, Finset.card_union_of_disjoint hdisj]
  congr 1
  -- the second set is `{k}` iff `F k ≠ F (k+1)`, else `∅`
  by_cases hF : F k ≠ F (k + 1)
  · rw [if_pos hF]
    rw [show ((Finset.range n).filter (fun t => F t ≠ F (t + 1) ∧ t = k)) = {k} from ?_]
    · exact Finset.card_singleton k
    · ext t
      simp only [Finset.mem_filter, Finset.mem_range, Finset.mem_singleton]
      constructor
      · rintro ⟨_, _, rfl⟩; rfl
      · rintro rfl; exact ⟨hk, hF, rfl⟩
  · rw [if_neg hF]
    rw [Finset.card_eq_zero, Finset.filter_eq_empty_iff]
    intro t _ ⟨h1, h2⟩; subst h2; exact hF h1

/-- **Flip parity (auxiliary).** -/
theorem eq_Fn_iff_even_negCount_aux (F : ℕ → Bool) (n : ℕ) :
    ∀ (d k : ℕ), k + d = n → ((F k = F n) ↔ Even (negCount F n k)) := by
  intro d
  induction d with
  | zero =>
      intro k hk
      have hkn : k = n := by omega
      rw [hkn]
      have h0 : negCount F n n = 0 := by
        unfold negCount changeSet
        rw [Finset.card_eq_zero, Finset.filter_eq_empty_iff]
        intro t ht
        rw [Finset.mem_filter, Finset.mem_range] at ht
        omega
      simp [h0]
  | succ d ih =>
      intro k hk
      have hkn : k < n := by omega
      have hrec := negCount_succ (F := F) (n := n) hkn
      have hIH := ih (k + 1) (by omega)
      by_cases hF : F k = F (k + 1)
      · rw [hrec, if_neg (not_not.mpr hF), add_zero, hF]; exact hIH
      · rw [hrec, if_pos hF, Nat.even_add_one, ← hIH]
        revert hF; cases F k <;> cases F (k + 1) <;> cases F n <;> decide

/-- **Flip parity.** `F k = F n` exactly when the number of sign changes above `k`
is even. -/
theorem eq_Fn_iff_even_negCount {k : ℕ} (hk : k ≤ n) :
    (F k = F n) ↔ Even (negCount F n k) :=
  eq_Fn_iff_even_negCount_aux F n (n - k) k (by omega)

/-- **Product sign.** The product of `k - (t + ½)` over sign changes is positive
exactly when an even number of changes lie at or above `k`. -/
theorem prod_sign (F : ℕ → Bool) (n k : ℕ) :
    (0 < ∏ t ∈ changeSet F n, ((k : ℝ) - ((t : ℝ) + 1 / 2))) ↔ Even (negCount F n k) := by
  classical
  have hpow : (0 < (-1 : ℝ) ^ negCount F n k) ↔ Even (negCount F n k) := by
    rcases Nat.even_or_odd (negCount F n k) with he | ho
    · rw [he.neg_one_pow]; simp [he]
    · rw [ho.neg_one_pow]
      constructor
      · intro h; norm_num at h
      · intro h; rw [Nat.even_iff] at h; rw [Nat.odd_iff] at ho; omega
  rw [← hpow, ← Finset.prod_filter_mul_prod_filter_not (changeSet F n) (fun t => k ≤ t)]
  have hge : ∏ t ∈ (changeSet F n).filter (fun t => k ≤ t), ((k : ℝ) - ((t : ℝ) + 1 / 2))
      = (-1) ^ negCount F n k
        * ∏ t ∈ (changeSet F n).filter (fun t => k ≤ t), ((t : ℝ) + 1 / 2 - (k : ℝ)) := by
    rw [show negCount F n k = ((changeSet F n).filter (fun t => k ≤ t)).card from rfl,
      ← Finset.prod_neg]
    exact Finset.prod_congr rfl (fun t _ => by ring)
  have hge_pos : 0 <
      ∏ t ∈ (changeSet F n).filter (fun t => k ≤ t), ((t : ℝ) + 1 / 2 - (k : ℝ)) := by
    apply Finset.prod_pos
    intro t ht; rw [Finset.mem_filter] at ht
    have : (k : ℝ) ≤ (t : ℝ) := by exact_mod_cast ht.2
    linarith
  have hlt_pos : 0 <
      ∏ t ∈ (changeSet F n).filter (fun t => ¬ k ≤ t), ((k : ℝ) - ((t : ℝ) + 1 / 2)) := by
    apply Finset.prod_pos
    intro t ht; rw [Finset.mem_filter] at ht
    have : (t : ℝ) + 1 ≤ (k : ℝ) := by exact_mod_cast (Nat.lt_of_not_le ht.2)
    linarith
  rw [hge, mul_assoc, mul_pos_iff_of_pos_right (mul_pos hge_pos hlt_pos)]

/-- Each factor `k - (t + ½)` is nonzero (a half-integer is never an integer). -/
theorem factor_ne_zero (k t : ℕ) : ((k : ℝ) - ((t : ℝ) + 1 / 2)) ≠ 0 := by
  intro hc
  have hr : (2 : ℝ) * (k : ℝ) = 2 * (t : ℝ) + 1 := by linarith
  have hcast : ((2 * k : ℕ) : ℝ) = ((2 * t + 1 : ℕ) : ℝ) := by push_cast; linarith [hr]
  have := Nat.cast_injective hcast
  omega

/-- **Sign polynomial.** There is `P` of degree `≤ signChanges n F` with
`0 < P.eval k ↔ F k = true` for all `k ≤ n`. -/
theorem exists_sign_poly (F : ℕ → Bool) (n : ℕ) :
    ∃ P : Polynomial ℝ, P.natDegree ≤ signChanges n F
      ∧ ∀ k : ℕ, k ≤ n → (0 < P.eval (k : ℝ) ↔ F k = true) := by
  classical
  refine ⟨C (if F n then (1 : ℝ) else -1) * ∏ t ∈ changeSet F n, (X - C ((t : ℝ) + 1 / 2)), ?_, ?_⟩
  · rw [natDegree_C_mul (by split <;> norm_num : (if F n then (1 : ℝ) else -1) ≠ 0),
      natDegree_prod _ _ (fun i _ => (monic_X_sub_C _).ne_zero)]
    simp only [natDegree_X_sub_C, Finset.sum_const, smul_eq_mul, mul_one]
    rw [changeSet_card]
  · intro k hk
    have heval : (C (if F n then (1 : ℝ) else -1)
          * ∏ t ∈ changeSet F n, (X - C ((t : ℝ) + 1 / 2))).eval (k : ℝ)
        = (if F n then (1 : ℝ) else -1) * ∏ t ∈ changeSet F n, ((k : ℝ) - ((t : ℝ) + 1 / 2)) := by
      rw [eval_mul, eval_C, eval_prod]; simp
    rw [heval]
    have hpar := eq_Fn_iff_even_negCount F n hk
    have hsgn := prod_sign F n k
    have hne : (∏ t ∈ changeSet F n, ((k : ℝ) - ((t : ℝ) + 1 / 2))) ≠ 0 :=
      Finset.prod_ne_zero_iff.mpr (fun t _ => factor_ne_zero k t)
    by_cases hFn : F n = true
    · rw [if_pos hFn, one_mul, hsgn, ← hpar, hFn]
    · have hFn' : F n = false := by revert hFn; cases F n <;> simp
      rw [if_neg hFn, neg_one_mul, neg_pos]
      have hlt : ((∏ t ∈ changeSet F n, ((k : ℝ) - ((t : ℝ) + 1 / 2))) < 0)
          ↔ ¬ (0 < ∏ t ∈ changeSet F n, ((k : ℝ) - ((t : ℝ) + 1 / 2))) :=
        ⟨fun h => not_lt.mpr (le_of_lt h), fun h => lt_of_le_of_ne (not_lt.mp h) hne⟩
      rw [hlt, hsgn, ← hpar, hFn']
      cases F k <;> simp

end HeadComplexity
