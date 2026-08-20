import HeadComplexity.BooleanCube.Families

set_option linter.style.header false

/-!
# Symmetric sign changes.

For a symmetric Boolean function `f(x) = F(|x|)`, the final theorem
`HStar_symmetricFn` in `Results/SymmetricComplexity.lean` states that the head complexity equals
the number of sign changes of the profile `F` along the Hamming-weight axis:

$$ H^{*}(f) = C(F) := \#\{ t \in \{1,\dots,n\} : F(t-1) \neq F(t) \}. $$

This file contains the profile-level definitions and elementary checkerboard
consequences used by that theorem:

* `symmetricFn F` and the sign-change count `signChanges n F = C(F)`;
* the general-`n` lower bound that a *width-1 spike* in `F`
  (`F w = F (w+2) ≠ F (w+1)`) forces `H^{*} ≥ 2`, via the checkerboard engine.
  This single theorem subsumes the parity and exact-count lower bounds;
* the parity sign-change count `signChanges_parity`.
-/

namespace HeadComplexity

open scoped BigOperators
open Head (restrictBits)

variable {n : ℕ}

/-- A symmetric Boolean function: its value depends only on the Hamming weight,
through a profile `F : ℕ → Bool`. -/
def symmetricFn (F : ℕ → Bool) (bits : Fin n → Bool) : Bool :=
  F (hammingWeight bits)

@[simp] theorem symmetricFn_apply (F : ℕ → Bool) (bits : Fin n → Bool) :
    symmetricFn F bits = F (hammingWeight bits) := rfl

/-- `PARITY n` is the symmetric function with profile `Odd`. -/
theorem PARITY_eq_symmetricFn : PARITY n = symmetricFn (fun k => decide (Odd k)) := rfl

/-- `EXACT n k` is the symmetric function with profile `· = k`. -/
theorem EXACT_eq_symmetricFn (k : ℕ) : EXACT n k = symmetricFn (fun m => decide (m = k)) := rfl

/-- The number of sign changes of the weight profile `F` along `0, 1, …, n`. -/
def signChanges (n : ℕ) (F : ℕ → Bool) : ℕ :=
  ((Finset.range n).filter fun t => F t ≠ F (t + 1)).card

/-! ## A base of prescribed off-coordinate weight -/

/-- For `m ≤ n - 2` there is a base assignment whose two-coordinate restriction
on `{firstIndex, secondIndex}` realizes Hamming weights `m, m+1, m+2` at the
checkerboard corners. -/
theorem exists_checkerboard_base (hn : 2 ≤ n) (m : ℕ) (hm : m ≤ n - 2) :
    ∃ base : Fin n → Bool, ∀ a b : Bool,
      hammingWeight (restrictBits base (firstIndex hn) (secondIndex hn) (a, b))
        = (if a then 1 else 0) + (if b then 1 else 0) + m := by
  have hij : firstIndex hn ≠ secondIndex hn := firstIndex_ne_secondIndex hn
  set i := firstIndex hn
  set j := secondIndex hn
  have hcard : m ≤ ({i, j}ᶜ : Finset (Fin n)).card := by
    rw [Finset.card_compl, Fintype.card_fin, Finset.card_pair hij]; omega
  obtain ⟨T, hTsub, hTcard⟩ := Finset.exists_subset_card_eq hcard
  set base : Fin n → Bool := fun x => decide (x ∈ T) with hbase
  have hoff : (Finset.filter (fun x => base x = true)
      ({i, j}ᶜ : Finset (Fin n))).card = m := by
    have hset : (Finset.filter (fun x => base x = true)
        ({i, j}ᶜ : Finset (Fin n))) = T := by
      ext x
      simp only [Finset.mem_filter, hbase, decide_eq_true_eq]
      exact ⟨fun h => h.2, fun h => ⟨hTsub h, h⟩⟩
    rw [hset, hTcard]
  exact ⟨base, fun a b => by rw [hammingWeight_restrictBits base i j hij, hoff]⟩

/-! ## General-`n` lower bound from a width-1 spike -/

/-- **Theorem 12 lower bound (spike).** If the profile `F` has a width-1 spike at
weight `w` (`F (w+1) ≠ F w` and `F (w+2) = F w`), then the symmetric function
`symmetricFn F` cannot be computed with a single head. This is the checkerboard
obstruction phrased on the Hamming-weight axis. -/
theorem symmetricFn_spike_not_computable_with_one_head (F : ℕ → Bool) (hn : 2 ≤ n)
    (w : ℕ) (hw : w + 2 ≤ n) (h1 : F (w + 1) ≠ F w) (h2 : F (w + 2) = F w) :
    ¬ computableWithHeadsN n 1 (symmetricFn F) := by
  have hij : firstIndex hn ≠ secondIndex hn := firstIndex_ne_secondIndex hn
  obtain ⟨base, hbase⟩ := exists_checkerboard_base hn w (by omega)
  have e_ff : symmetricFn F
      (restrictBits base (firstIndex hn) (secondIndex hn) (false, false)) = F w := by
    simp only [symmetricFn]; rw [hbase false false, if_false_one]; simp
  have e_tt : symmetricFn F
      (restrictBits base (firstIndex hn) (secondIndex hn) (true, true)) = F w := by
    simp only [symmetricFn]
    rw [hbase true true, if_true_one, show (1 : ℕ) + 1 + w = w + 2 from by omega]
    exact h2
  have e_ft : symmetricFn F
      (restrictBits base (firstIndex hn) (secondIndex hn) (false, true)) = !(F w) := by
    simp only [symmetricFn]
    rw [hbase false true, if_false_one, if_true_one, show (0 : ℕ) + 1 + w = w + 1 from by omega]
    exact Bool.eq_not_of_ne h1
  have e_tf : symmetricFn F
      (restrictBits base (firstIndex hn) (secondIndex hn) (true, false)) = !(F w) := by
    simp only [symmetricFn]
    rw [hbase true false, if_true_one, if_false_one, show (1 : ℕ) + 0 + w = w + 1 from by omega]
    exact Bool.eq_not_of_ne h1
  exact checkerboard_restriction_not_computable_with_one_head (symmetricFn F)
    base (firstIndex hn) (secondIndex hn) hij (F w) e_ff e_tt e_ft e_tf

/-! ## Sign-change counts -/

/-- A width-1 spike contributes (at least) two sign changes to `C(F)`. -/
theorem signChanges_ge_two_of_spike (F : ℕ → Bool) (w : ℕ) (hw : w + 2 ≤ n)
    (h1 : F (w + 1) ≠ F w) (h2 : F (w + 2) = F w) : 2 ≤ signChanges n F := by
  rw [signChanges]
  have hsub : ({w, w + 1} : Finset ℕ)
      ⊆ (Finset.range n).filter (fun t => F t ≠ F (t + 1)) := by
    intro x hx
    rw [Finset.mem_insert, Finset.mem_singleton] at hx
    rw [Finset.mem_filter, Finset.mem_range]
    rcases hx with rfl | rfl
    · exact ⟨by omega, fun h => h1 h.symm⟩
    · refine ⟨by omega, ?_⟩
      change F (w + 1) ≠ F (w + 2)
      rw [h2]; exact h1
  calc 2 = ({w, w + 1} : Finset ℕ).card := by rw [Finset.card_pair (by omega)]
    _ ≤ _ := Finset.card_le_card hsub

/-- **Parity has the maximal sign-change count `n`.** Every adjacent pair of
weights flips parity. -/
theorem signChanges_parity : signChanges n (fun k => decide (Odd k)) = n := by
  rw [signChanges, Finset.filter_true_of_mem, Finset.card_range]
  intro t _
  by_cases h : Odd t
  · have h1 : ¬ Odd (t + 1) := by rw [Nat.odd_add_one]; exact not_not.mpr h
    simp [h, h1]
  · have h1 : Odd (t + 1) := by rw [Nat.odd_add_one]; exact h
    simp [h, h1]

/-! ## Theorem 12

The full Theorem 12 is the equality

  `HStar n (symmetricFn F) = signChanges n F`,

proved unconditionally in `Results/SymmetricComplexity.lean` (`HStar_symmetricFn`): its lower bound
is built in `Polynomial/SymmetricLowerBound.lean` + `Polynomial/UnivariateReduction.lean` (model →
threshold degree → symmetrize → univariate root count) and its upper bound is the
explicit `signChanges`-many-head softmax construction in `Atoms/SignPolynomial.lean` +
`Atoms/PartialFraction.lean` + `Atoms/HammingAtom.lean`.

What this file contributes is the first nontrivial slice of that lower bound: a
*width-1 spike* in `F` simultaneously forces `signChanges n F ≥ 2`
(`signChanges_ge_two_of_spike`) and `¬ computableWithHeadsN n 1 (symmetricFn F)`
(`symmetricFn_spike_not_computable_with_one_head`), i.e. `H^{*} ≥ 2`. Combined
with `signChanges_parity = n`, the parity end of the spectrum (`C = n`) is in
place on the combinatorial side, and its `≥ 2` complexity bound on the model
side. -/

end HeadComplexity
