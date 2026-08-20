import HeadComplexity.BooleanCube.SymmetricSignChanges
import Mathlib.Topology.Algebra.Polynomial
import Mathlib.Topology.Order.IntermediateValue

set_option linter.style.header false

/-!
# Univariate sign-change root bound (Theorem 12 lower bound, polynomial core).

If a real univariate polynomial `p` strictly sign-represents a weight profile
`F` on `{0, 1, …, n}` (positive where `F` is true, negative where false), then
the number of sign changes of `F` is at most `p.natDegree`.

This is the self-contained polynomial heart of the L12 lower bound: each sign
change of `F` forces, by the intermediate value theorem, a root of `p` strictly
between two consecutive integers; these roots lie in disjoint open intervals, so
they are distinct, and a real polynomial has at most `natDegree` roots.
-/

namespace HeadComplexity

open Polynomial Set

/-- A real polynomial strictly sign-representing `F` on `{0,…,n}` has degree at
least the number of sign changes of `F`. -/
theorem signChanges_le_natDegree (p : ℝ[X]) (F : ℕ → Bool) (n : ℕ)
    (hpos : ∀ k, k ≤ n → F k = true → 0 < p.eval (k : ℝ))
    (hneg : ∀ k, k ≤ n → F k = false → p.eval (k : ℝ) < 0) :
    signChanges n F ≤ p.natDegree := by
  have hp0 : p ≠ 0 := by
    rintro rfl
    cases hF : F 0 with
    | false => simpa using hneg 0 (Nat.zero_le n) hF
    | true => simpa using hpos 0 (Nat.zero_le n) hF
  -- A root strictly between t and t+1 for every sign change.
  have hroot : ∀ t, t < n → F t ≠ F (t + 1) →
      ∃ c, c ∈ Ioo (t : ℝ) ((t + 1 : ℕ) : ℝ) ∧ p.eval c = 0 := by
    intro t ht hne
    have htn : t ≤ n := le_of_lt ht
    have ht1n : t + 1 ≤ n := ht
    have hcont : ContinuousOn (fun x => p.eval x) (Icc (t : ℝ) ((t + 1 : ℕ) : ℝ)) :=
      (Polynomial.continuous p).continuousOn
    have hab : (t : ℝ) ≤ ((t + 1 : ℕ) : ℝ) := by exact_mod_cast Nat.le_succ t
    cases hFt : F t with
    | false =>
        have hFt1 : F (t + 1) = true := by
          cases hh : F (t + 1) with
          | false => exact absurd (hFt.trans hh.symm) hne
          | true => rfl
        have e1 : p.eval (t : ℝ) < 0 := hneg t htn hFt
        have e2 : (0 : ℝ) < p.eval ((t + 1 : ℕ) : ℝ) := hpos (t + 1) ht1n hFt1
        obtain ⟨c, hc, hce⟩ := intermediate_value_Ioo hab hcont ⟨e1, e2⟩
        exact ⟨c, hc, hce⟩
    | true =>
        have hFt1 : F (t + 1) = false := by
          cases hh : F (t + 1) with
          | false => rfl
          | true => exact absurd (hFt.trans hh.symm) hne
        have e1 : (0 : ℝ) < p.eval (t : ℝ) := hpos t htn hFt
        have e2 : p.eval ((t + 1 : ℕ) : ℝ) < 0 := hneg (t + 1) ht1n hFt1
        obtain ⟨c, hc, hce⟩ := intermediate_value_Ioo' hab hcont ⟨e2, e1⟩
        exact ⟨c, hc, hce⟩
  rw [signChanges]
  set S := (Finset.range n).filter (fun t => F t ≠ F (t + 1)) with hSdef
  -- Total choice function picking a root for each sign change.
  have key : ∀ t : ℕ, ∃ c : ℝ,
      t ∈ S → c ∈ Ioo (t : ℝ) ((t + 1 : ℕ) : ℝ) ∧ p.eval c = 0 := by
    intro t
    by_cases htS : t ∈ S
    · have ht : t < n ∧ F t ≠ F (t + 1) := by
        rw [hSdef, Finset.mem_filter, Finset.mem_range] at htS; exact htS
      obtain ⟨c, hc1, hc2⟩ := hroot t ht.1 ht.2
      exact ⟨c, fun _ => ⟨hc1, hc2⟩⟩
    · exact ⟨0, fun h => absurd h htS⟩
  choose g hg using key
  -- g is injective on S (disjoint open intervals) and lands in the roots.
  have hinj : Set.InjOn g (S : Set ℕ) := by
    intro a ha b hb hgab
    rw [Finset.mem_coe] at ha hb
    rcases lt_trichotomy a b with hlt | heq | hlt
    · exfalso
      have hga := (hg a ha).1
      have hgb := (hg b hb).1
      have hstep : ((a + 1 : ℕ) : ℝ) ≤ (b : ℝ) := by exact_mod_cast hlt
      have : g a < g b := lt_of_lt_of_le hga.2 (le_trans hstep (le_of_lt hgb.1))
      exact (ne_of_lt this) hgab
    · exact heq
    · exfalso
      have hga := (hg a ha).1
      have hgb := (hg b hb).1
      have hstep : ((b + 1 : ℕ) : ℝ) ≤ (a : ℝ) := by exact_mod_cast hlt
      have : g b < g a := lt_of_lt_of_le hgb.2 (le_trans hstep (le_of_lt hga.1))
      exact (ne_of_lt this) hgab.symm
  have hmaps : S.image g ⊆ p.roots.toFinset := by
    intro y hy
    rw [Finset.mem_image] at hy
    obtain ⟨t, htS, rfl⟩ := hy
    rw [Multiset.mem_toFinset, mem_roots hp0]
    exact (hg t htS).2
  calc S.card = (S.image g).card := (Finset.card_image_of_injOn hinj).symm
    _ ≤ p.roots.toFinset.card := Finset.card_le_card hmaps
    _ ≤ Multiset.card p.roots := Multiset.toFinset_card_le _
    _ ≤ p.natDegree := Polynomial.card_roots' p

end HeadComplexity
