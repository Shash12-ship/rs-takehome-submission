import HeadComplexity.Model.Head

set_option linter.style.header false

/-!
# Symmetric families: parity and exact-count lower bounds.

This file defines the `n`-bit symmetric functions `PARITY` and `EXACT`, and
proves checkerboard lower bounds used by the current L1-L12 theorem stack:

* `PARITY n` needs at least two heads for `n ≥ 2`;
* `EXACT n k` needs at least two heads for `1 ≤ k ≤ n - 1`.

Both follow from the reusable general-`n` checkerboard engine in
`Model/Head.lean` (`parity_restriction_not_computable_with_one_head`,
`not_computableWithHeadsN_zero_of_false_true`). The only new work is the
elementary Hamming-weight bookkeeping under a two-coordinate restriction. Exact
values for these families are proved later from the symmetric sign-change
characterization in `Results/ExactFamilies.lean`.
-/

namespace HeadComplexity

open scoped BigOperators
open Head (restrictBits)

variable {n : ℕ}

/-- Hamming weight: the number of `true` coordinates of an `n`-bit input. -/
def hammingWeight (bits : Fin n → Bool) : ℕ :=
  (Finset.univ.filter fun i => bits i = true).card

/-- `n`-bit parity (XOR of all bits), packaged as a Boolean function. -/
def PARITY (n : ℕ) (bits : Fin n → Bool) : Bool :=
  decide (Odd (hammingWeight bits))

/-- `EXACT n k`: true iff exactly `k` of the `n` input bits are set. -/
def EXACT (n k : ℕ) (bits : Fin n → Bool) : Bool :=
  decide (hammingWeight bits = k)

/-- The two index choices `firstIndex`, `secondIndex` are distinct. -/
theorem firstIndex_ne_secondIndex (hn : 2 ≤ n) :
    firstIndex hn ≠ secondIndex hn := by
  simp [firstIndex, secondIndex, Fin.ext_iff]

/-- Hamming weight of a two-coordinate restriction: the two free coordinates
contribute `0/1` each, and the remaining coordinates contribute the weight of
the frozen base off `{i, j}`. -/
theorem hammingWeight_restrictBits (base : Fin n → Bool) (i j : Fin n) (hij : i ≠ j)
    (a b : Bool) :
    hammingWeight (restrictBits base i j (a, b))
      = (if a then 1 else 0) + (if b then 1 else 0)
        + (Finset.filter (fun x => base x = true) ({i, j}ᶜ : Finset (Fin n))).card := by
  unfold hammingWeight
  rw [Finset.card_filter, ← Finset.sum_add_sum_compl ({i, j} : Finset (Fin n))]
  congr 1
  · rw [Finset.sum_pair hij]
    have hi : restrictBits base i j (a, b) i = a := by simp [restrictBits]
    have hj : restrictBits base i j (a, b) j = b := by simp [restrictBits, Ne.symm hij]
    rw [hi, hj]
  · rw [Finset.card_filter]
    refine Finset.sum_congr rfl (fun x hx => ?_)
    rw [Finset.mem_compl, Finset.mem_insert, Finset.mem_singleton] at hx
    obtain ⟨hxi, hxj⟩ := not_or.mp hx
    simp [restrictBits, hxi, hxj]

/-- Hamming weight of a two-coordinate restriction over an all-`false` base. -/
theorem hammingWeight_restrict_false (i j : Fin n) (hij : i ≠ j) (a b : Bool) :
    hammingWeight (restrictBits (fun _ => false) i j (a, b))
      = (if a then 1 else 0) + (if b then 1 else 0) := by
  rw [hammingWeight_restrictBits _ i j hij]
  have : (Finset.filter (fun x => (fun _ => false) x = true) ({i, j}ᶜ : Finset (Fin n)))
      = (∅ : Finset (Fin n)) := by simp
  rw [this]; simp

/-! ## Parity -/

/-- Parity exhibits the XOR checkerboard pattern on the first two coordinates. -/
theorem PARITY_restrict_false_corners (i j : Fin n) (hij : i ≠ j) :
    PARITY n (restrictBits (fun _ => false) i j (false, false)) = false
    ∧ PARITY n (restrictBits (fun _ => false) i j (true, true)) = false
    ∧ PARITY n (restrictBits (fun _ => false) i j (false, true)) = true
    ∧ PARITY n (restrictBits (fun _ => false) i j (true, false)) = true := by
  refine ⟨?_, ?_, ?_, ?_⟩
  · unfold PARITY; rw [hammingWeight_restrict_false i j hij false false]; decide
  · unfold PARITY; rw [hammingWeight_restrict_false i j hij true true]; decide
  · unfold PARITY; rw [hammingWeight_restrict_false i j hij false true]; decide
  · unfold PARITY; rw [hammingWeight_restrict_false i j hij true false]; decide

/-- **Theorem 5 (parity, one head).** For `n ≥ 2`, `PARITY n` cannot be computed
with a single head. -/
theorem PARITY_not_computable_with_one_head (hn : 2 ≤ n) :
    ¬ computableWithHeadsN n 1 (PARITY n) := by
  have hij := firstIndex_ne_secondIndex hn
  obtain ⟨h00, h11, h01, h10⟩ :=
    PARITY_restrict_false_corners (firstIndex hn) (secondIndex hn) hij
  exact parity_restriction_not_computable_with_one_head (PARITY n)
    (fun _ => false) (firstIndex hn) (secondIndex hn) hij h00 h11 h01 h10

/-- **Theorem 5 (parity, zero heads).** For `n ≥ 2`, `PARITY n` cannot be computed
with zero heads. -/
theorem PARITY_not_computable_with_zero_heads (hn : 2 ≤ n) :
    ¬ computableWithHeadsN n 0 (PARITY n) := by
  have hij := firstIndex_ne_secondIndex hn
  obtain ⟨h00, _, h01, _⟩ :=
    PARITY_restrict_false_corners (firstIndex hn) (secondIndex hn) hij
  exact not_computableWithHeadsN_zero_of_false_true (PARITY n)
    (restrictBits (fun _ => false) (firstIndex hn) (secondIndex hn) (false, false))
    (restrictBits (fun _ => false) (firstIndex hn) (secondIndex hn) (false, true))
    h00 h01

/-- **Theorem 5 (parity, exact bound).** Any exact head complexity of `PARITY n`
is at least `2` when `n ≥ 2`. -/
theorem PARITY_exactHeadComplexity_ge_two (hn : 2 ≤ n) {k : ℕ}
    (hk : exactHeadComplexityN n (PARITY n) k) : 2 ≤ k := by
  have hij := firstIndex_ne_secondIndex hn
  obtain ⟨h00, h11, h01, h10⟩ :=
    PARITY_restrict_false_corners (firstIndex hn) (secondIndex hn) hij
  exact parity_restriction_exactHeadComplexity_ge_two (PARITY n)
    (fun _ => false) (firstIndex hn) (secondIndex hn) hij h00 h11 h01 h10 hk

/-! ## Exact-count predicates -/

/-- The indicator `if`-values, reduced definitionally. -/
theorem if_true_one : (if (true : Bool) then (1 : ℕ) else 0) = 1 := rfl
theorem if_false_one : (if (false : Bool) then (1 : ℕ) else 0) = 0 := rfl

/-- Hamming weight of the all-`false` input is `0`. -/
theorem hammingWeight_const_false : hammingWeight (fun _ : Fin n => false) = 0 := by
  simp [hammingWeight]

/-- Hamming weight of the indicator of a finite set is its cardinality. -/
theorem hammingWeight_indicator (S : Finset (Fin n)) :
    hammingWeight (fun x => decide (x ∈ S)) = S.card := by
  unfold hammingWeight
  congr 1
  ext x
  simp [decide_eq_true_eq]

/-- **Theorem 5 (exact-count, one head).** For `1 ≤ k ≤ n - 1`, the exact-count
predicate `EXACT n k` cannot be computed with a single head.

We freeze `k - 1` of the coordinates off `{firstIndex, secondIndex}` to `true`;
the two free coordinates then turn the count into the XOR checkerboard pattern
`k-1, k+1, k, k` on `(0,0), (1,1), (0,1), (1,0)`. -/
theorem EXACT_not_computable_with_one_head (hn : 2 ≤ n) {k : ℕ}
    (hk1 : 1 ≤ k) (hk2 : k ≤ n - 1) :
    ¬ computableWithHeadsN n 1 (EXACT n k) := by
  have hij : firstIndex hn ≠ secondIndex hn := firstIndex_ne_secondIndex hn
  set i := firstIndex hn
  set j := secondIndex hn
  -- Choose a `(k-1)`-element frozen set among the coordinates off `{i, j}`.
  have hcard : k - 1 ≤ ({i, j}ᶜ : Finset (Fin n)).card := by
    rw [Finset.card_compl, Fintype.card_fin, Finset.card_pair hij]; omega
  obtain ⟨T, hTsub, hTcard⟩ := Finset.exists_subset_card_eq hcard
  set base : Fin n → Bool := fun x => decide (x ∈ T) with hbase
  have hoff : (Finset.filter (fun x => base x = true)
      ({i, j}ᶜ : Finset (Fin n))).card = k - 1 := by
    have hset : (Finset.filter (fun x => base x = true)
        ({i, j}ᶜ : Finset (Fin n))) = T := by
      ext x
      simp only [Finset.mem_filter, hbase, decide_eq_true_eq]
      exact ⟨fun h => h.2, fun h => ⟨hTsub h, h⟩⟩
    rw [hset, hTcard]
  have h00 : EXACT n k (restrictBits base i j (false, false)) = false := by
    have hwt : hammingWeight (restrictBits base i j (false, false)) = k - 1 := by
      rw [hammingWeight_restrictBits base i j hij, hoff, if_false_one]; omega
    simp only [EXACT, hwt, decide_eq_false_iff_not]; omega
  have h11 : EXACT n k (restrictBits base i j (true, true)) = false := by
    have hwt : hammingWeight (restrictBits base i j (true, true)) = k + 1 := by
      rw [hammingWeight_restrictBits base i j hij, hoff, if_true_one]; omega
    simp only [EXACT, hwt, decide_eq_false_iff_not]; omega
  have h01 : EXACT n k (restrictBits base i j (false, true)) = true := by
    have hwt : hammingWeight (restrictBits base i j (false, true)) = k := by
      rw [hammingWeight_restrictBits base i j hij, hoff, if_false_one, if_true_one]; omega
    simp only [EXACT, hwt, decide_eq_true_eq]
  have h10 : EXACT n k (restrictBits base i j (true, false)) = true := by
    have hwt : hammingWeight (restrictBits base i j (true, false)) = k := by
      rw [hammingWeight_restrictBits base i j hij, hoff, if_true_one, if_false_one]; omega
    simp only [EXACT, hwt, decide_eq_true_eq]
  exact parity_restriction_not_computable_with_one_head (EXACT n k)
    base i j hij h00 h11 h01 h10

/-- **Theorem 5 (exact-count, zero heads).** For `1 ≤ k ≤ n`, `EXACT n k`
cannot be computed with zero heads. -/
theorem EXACT_not_computable_with_zero_heads {k : ℕ} (hk1 : 1 ≤ k) (hk2 : k ≤ n) :
    ¬ computableWithHeadsN n 0 (EXACT n k) := by
  obtain ⟨S, _, hScard⟩ := Finset.exists_subset_card_eq
    (show k ≤ (Finset.univ : Finset (Fin n)).card by
      rw [Finset.card_univ, Fintype.card_fin]; exact hk2)
  refine not_computableWithHeadsN_zero_of_false_true (EXACT n k)
    (fun _ => false) (fun x => decide (x ∈ S)) ?_ ?_
  · have : hammingWeight (fun _ : Fin n => false) = 0 := hammingWeight_const_false
    simp only [EXACT, this, decide_eq_false_iff_not]; omega
  · have : hammingWeight (fun x : Fin n => decide (x ∈ S)) = k := by
      rw [hammingWeight_indicator, hScard]
    simp only [EXACT, this, decide_eq_true_eq]

end HeadComplexity
