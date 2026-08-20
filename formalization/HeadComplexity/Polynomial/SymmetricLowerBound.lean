import HeadComplexity.Polynomial.ModelToPolynomial
import HeadComplexity.Polynomial.UnivariateSignChanges

set_option linter.style.header false

/-!
# L12 lower bound chain.

Assembling `HStar n (symmetricFn F) ≥ signChanges n F` from:
* `signReprDegLe_of_computableWithHeadsN` (L6): `H` heads → degree-≤H sign rep;
* strictification (here): turn `0 < eval ↔ f` into a strict sign representation;
* symmetrization (here): average over `Equiv.Perm` to a symmetric polynomial;
* univariate reduction (`Polynomial/UnivariateReduction.lean`): a symmetric polynomial of
  total degree `≤ H` on the cube is a univariate polynomial of degree `≤ H` in the
  Hamming weight (no multilinearity assumed — on the cube any polynomial reduces);
* `signChanges_le_natDegree` (`Polynomial/UnivariateSignChanges.lean`): degree ≥ sign changes.

The chain is complete: `signChanges_le_of_computableWithHeadsN`
(`Polynomial/UnivariateReduction.lean`) discharges the lower bound, and together with the
upper bound it yields the unconditional `HStar_symmetricFn` in `Results/SymmetricComplexity.lean`.
-/

namespace HeadComplexity

open MvPolynomial

variable {n : ℕ}

/-- Strict sign representation: positive on true points, negative on false points. -/
def StrictSignRep (P : MvPolynomial (Fin n) ℝ) (f : (Fin n → Bool) → Bool) : Prop :=
  ∀ x, (f x = true → 0 < eval (cubePoint x) P) ∧ (f x = false → eval (cubePoint x) P < 0)

/-- At a false point a sign-representing polynomial is `≤ 0`. -/
private theorem eval_nonpos_of_false {P : MvPolynomial (Fin n) ℝ} {f : (Fin n → Bool) → Bool}
    (hP : ∀ x, (0 < eval (cubePoint x) P ↔ f x = true)) {x : Fin n → Bool}
    (hx : f x = false) : eval (cubePoint x) P ≤ 0 := by
  by_contra h
  push Not at h
  have := (hP x).mp h
  rw [hx] at this
  exact Bool.false_ne_true this

/-- **Strictification.** A threshold-degree-`≤ H` representation can be turned into a
strict one of the same degree by a small downward shift. -/
theorem exists_strictSignRep_of_ThresholdDegLE {f : (Fin n → Bool) → Bool} {H : ℕ}
    (h : ThresholdDegLE f H) :
    ∃ P : MvPolynomial (Fin n) ℝ, P.totalDegree ≤ H ∧ StrictSignRep P f := by
  classical
  obtain ⟨P, hPdeg, hPsign⟩ := h
  set T : Finset (Fin n → Bool) := Finset.univ.filter (fun x => f x = true) with hT
  -- choose a positive shift `ε` smaller than every true-point value
  obtain ⟨ε, hεpos, hεlt⟩ :
      ∃ ε : ℝ, 0 < ε ∧ ∀ x, f x = true → ε < eval (cubePoint x) P := by
    by_cases hTne : T.Nonempty
    · refine ⟨T.inf' hTne (fun x => eval (cubePoint x) P) / 2, ?_, ?_⟩
      · apply half_pos
        rw [Finset.lt_inf'_iff]
        intro x hx
        rw [hT, Finset.mem_filter] at hx
        exact (hPsign x).mpr hx.2
      · intro x hx
        have hxT : x ∈ T := by rw [hT, Finset.mem_filter]; exact ⟨Finset.mem_univ x, hx⟩
        have hle := Finset.inf'_le (fun x => eval (cubePoint x) P) hxT
        have hpos : 0 < eval (cubePoint x) P := (hPsign x).mpr hx
        have : (0:ℝ) < T.inf' hTne (fun x => eval (cubePoint x) P) := by
          rw [Finset.lt_inf'_iff]; intro y hy
          rw [hT, Finset.mem_filter] at hy; exact (hPsign y).mpr hy.2
        linarith
    · refine ⟨1, one_pos, ?_⟩
      intro x hx
      exact absurd (Finset.mem_filter.mpr ⟨Finset.mem_univ x, hx⟩)
        (by rw [← hT]; exact fun hm => hTne ⟨x, hm⟩)
  refine ⟨P - C ε, ?_, ?_⟩
  · exact (totalDegree_sub _ _).trans (by rw [totalDegree_C]; exact max_le hPdeg (Nat.zero_le _))
  · intro x
    have hev : eval (cubePoint x) (P - C ε) = eval (cubePoint x) P - ε := by
      rw [map_sub, eval_C]
    refine ⟨fun hx => ?_, fun hx => ?_⟩
    · rw [hev]; linarith [hεlt x hx]
    · rw [hev]; linarith [eval_nonpos_of_false hPsign hx]

/-! ## Symmetrization (Phase 3a) -/

open scoped BigOperators

/-- Hamming weight is invariant under permuting coordinates. -/
theorem hammingWeight_comp_perm (x : Fin n → Bool) (σ : Equiv.Perm (Fin n)) :
    hammingWeight (fun i => x (σ i)) = hammingWeight x := by
  unfold hammingWeight
  rw [Finset.card_filter, Finset.card_filter]
  exact Equiv.sum_comp σ (fun j => if x j = true then 1 else 0)

/-- Average over all coordinate permutations. -/
noncomputable def symmetrize (P : MvPolynomial (Fin n) ℝ) : MvPolynomial (Fin n) ℝ :=
  ∑ σ : Equiv.Perm (Fin n), rename σ P

theorem symmetrize_totalDegree_le {P : MvPolynomial (Fin n) ℝ} {H : ℕ}
    (hP : P.totalDegree ≤ H) : (symmetrize P).totalDegree ≤ H :=
  totalDegree_finsetSum_le (fun _ _ => (totalDegree_rename_le _ _).trans hP)

theorem symmetrize_isSymmetric (P : MvPolynomial (Fin n) ℝ) :
    (symmetrize P).IsSymmetric := by
  intro τ
  unfold symmetrize
  rw [map_sum, ← Equiv.sum_comp (Equiv.mulLeft τ) (fun σ => rename (σ : Fin n → Fin n) P)]
  refine Finset.sum_congr rfl (fun σ _ => ?_)
  rw [rename_rename]
  congr 1

/-- Symmetrization preserves a strict sign representation of a symmetric function. -/
theorem symmetrize_strictSignRep {F : ℕ → Bool} {P : MvPolynomial (Fin n) ℝ}
    (hP : StrictSignRep P (symmetricFn F)) :
    StrictSignRep (symmetrize P) (symmetricFn F) := by
  have key : ∀ (x : Fin n → Bool) (σ : Equiv.Perm (Fin n)),
      symmetricFn F (fun i => x (σ i)) = symmetricFn F x := by
    intro x σ; simp only [symmetricFn]; rw [hammingWeight_comp_perm]
  have hcomp : ∀ (x : Fin n → Bool) (σ : Equiv.Perm (Fin n)),
      cubePoint x ∘ (σ : Fin n → Fin n) = cubePoint (fun i => x (σ i)) := fun x σ => rfl
  intro x
  refine ⟨fun hx => ?_, fun hx => ?_⟩
  · unfold symmetrize
    rw [map_sum]
    refine Finset.sum_pos (fun σ _ => ?_) Finset.univ_nonempty
    rw [eval_rename, hcomp x σ]
    exact (hP (fun i => x (σ i))).1 ((key x σ).trans hx)
  · unfold symmetrize
    rw [map_sum]
    refine Finset.sum_neg (fun σ _ => ?_) Finset.univ_nonempty
    rw [eval_rename, hcomp x σ]
    exact (hP (fun i => x (σ i))).2 ((key x σ).trans hx)

end HeadComplexity
