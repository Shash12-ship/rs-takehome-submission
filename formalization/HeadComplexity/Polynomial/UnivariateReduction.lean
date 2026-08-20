import HeadComplexity.Polynomial.SymmetricLowerBound
import Mathlib.RingTheory.Polynomial.Pochhammer
import Mathlib.Data.Finset.Powerset
import Mathlib.Data.Fintype.EquivFin

set_option linter.style.header false

/-!
# Phase 3b: univariate reduction of a symmetric polynomial on the cube.

A symmetric polynomial `P : MvPolynomial (Fin n) ℝ` of total degree `≤ H`,
evaluated on the Boolean cube, is a univariate polynomial of degree `≤ H` in the
Hamming weight. Concretely we build `p : ℝ[X]` with `p.natDegree ≤ H` and
`p.eval (hammingWeight x) = eval (cubePoint x) P` for every `x`.

The route (no fundamental theorem of symmetric polynomials needed):
* on the cube each monomial is the indicator that its support lies in the
  ones-set, so `eval (cubePoint x) P = ∑_{d} coeff d · [supp d ⊆ S]` with
  `S` the ones-set (`eval_cube_eq_subset_sum`);
* grouping exponent vectors by their support `A`, the aggregated coefficient
  `supportCoeffSum P A` depends only on `A.card` for symmetric `P`
  (`supportCoeffSum_const`, proved by a coordinate permutation);
* hence `eval = ∑_j β_j · C(|S|, j)` with `β_j` the common value, and
  `C(k, j) = descPochhammer ℝ j / j!` is a degree-`j` polynomial in `k`.

Combined with `signChanges_le_natDegree` (Phase 3c) this yields the L12 lower
bound `signChanges n F ≤ H` whenever `symmetricFn F` is computable with `H`
heads (`signChanges_le_of_computableWithHeadsN`).
-/

namespace HeadComplexity

open MvPolynomial Finset
open scoped BigOperators

variable {n : ℕ}

/-! ## Evaluation on the Boolean cube as a subset-indicator sum -/

/-- The set of coordinates set to `true`. -/
def onesSet (x : Fin n → Bool) : Finset (Fin n) := univ.filter (fun i => x i = true)

@[simp] theorem onesSet_card (x : Fin n → Bool) : (onesSet x).card = hammingWeight x := rfl

theorem mem_onesSet {x : Fin n → Bool} {i : Fin n} : i ∈ onesSet x ↔ x i = true := by
  simp only [onesSet, mem_filter, mem_univ, true_and]

/-- On the cube a monomial is the indicator that its support lies in the ones-set. -/
theorem eval_cube_monomial (x : Fin n → Bool) (d : Fin n →₀ ℕ) :
    (∏ i ∈ d.support, cubePoint x i ^ d i) = if d.support ⊆ onesSet x then 1 else 0 := by
  by_cases hsub : d.support ⊆ onesSet x
  · rw [if_pos hsub]
    apply Finset.prod_eq_one
    intro i hi
    have hx : x i = true := mem_onesSet.mp (hsub hi)
    simp [cubePoint, boolToReal, hx]
  · rw [if_neg hsub]
    obtain ⟨i, hi, hix⟩ : ∃ i ∈ d.support, i ∉ onesSet x := by
      by_contra hcon; push Not at hcon; exact hsub (fun i hi => hcon i hi)
    apply Finset.prod_eq_zero hi
    have hdi : d i ≠ 0 := Finsupp.mem_support_iff.mp hi
    have hxf : x i = false := by
      cases hc : x i with
      | true => exact absurd (mem_onesSet.mpr hc) hix
      | false => rfl
    simp [cubePoint, boolToReal, hxf, zero_pow hdi]

/-- Evaluation on the cube as a sum over support-subset indicators. -/
theorem eval_cube_eq_subset_sum (x : Fin n → Bool) (P : MvPolynomial (Fin n) ℝ) :
    eval (cubePoint x) P
      = ∑ d ∈ P.support, P.coeff d * (if d.support ⊆ onesSet x then 1 else 0) := by
  rw [eval_eq]
  exact Finset.sum_congr rfl (fun d _ => by rw [eval_cube_monomial])

/-! ## A permutation sending one set onto another of the same size -/

theorem exists_perm_image {A A' : Finset (Fin n)} (h : A.card = A'.card) :
    ∃ σ : Equiv.Perm (Fin n), A.image (σ : Fin n → Fin n) = A' := by
  classical
  have hmem : {a : Fin n // a ∈ A} ≃ {a : Fin n // a ∈ A'} :=
    Fintype.equivOfCardEq (by rw [Fintype.card_coe, Fintype.card_coe, h])
  have hcompl : {a : Fin n // a ∉ A} ≃ {a : Fin n // a ∉ A'} :=
    Fintype.equivOfCardEq (by
      rw [Fintype.card_subtype_compl, Fintype.card_subtype_compl, Fintype.card_coe,
        Fintype.card_coe, h])
  refine ⟨(Equiv.sumCompl (· ∈ A)).symm.trans
      ((Equiv.sumCongr hmem hcompl).trans (Equiv.sumCompl (· ∈ A'))), ?_⟩
  apply Finset.eq_of_subset_of_card_le
  · intro b hb
    rw [Finset.mem_image] at hb
    obtain ⟨a, haA, rfl⟩ := hb
    have hsym : ((Equiv.sumCompl (· ∈ A)).symm a) = Sum.inl ⟨a, haA⟩ :=
      Equiv.sumCompl_symm_apply_of_pos haA
    simp only [Equiv.trans_apply, hsym, Equiv.sumCongr_apply, Sum.map_inl,
      Equiv.sumCompl_apply_inl]
    exact (hmem ⟨a, haA⟩).2
  · rw [Finset.card_image_of_injective _ (Equiv.injective _)]
    exact le_of_eq h.symm

/-! ## Aggregated coefficients by support set -/

variable (P : MvPolynomial (Fin n) ℝ)

/-- Sum of coefficients of monomials with a given support set. -/
def supportCoeffSum (A : Finset (Fin n)) : ℝ :=
  ∑ d ∈ P.support.filter (fun d => d.support = A), P.coeff d

/-- For symmetric `P`, `supportCoeffSum` depends only on the cardinality of the set. -/
theorem supportCoeffSum_const (hP : P.IsSymmetric) {A A' : Finset (Fin n)}
    (h : A.card = A'.card) : supportCoeffSum P A = supportCoeffSum P A' := by
  classical
  obtain ⟨σ, hσ⟩ := exists_perm_image h
  have coeff_eq : ∀ d : Fin n →₀ ℕ,
      P.coeff (Finsupp.mapDomain (σ : Fin n → Fin n) d) = P.coeff d := by
    intro d
    have hc := coeff_rename_mapDomain (σ : Fin n → Fin n) σ.injective P d
    rwa [hP σ] at hc
  have hcomp1 : ∀ e : Fin n →₀ ℕ,
      Finsupp.mapDomain (σ : Fin n → Fin n) (Finsupp.mapDomain (σ.symm : Fin n → Fin n) e) = e := by
    intro e; rw [← Finsupp.mapDomain_comp, Equiv.self_comp_symm, Finsupp.mapDomain_id]
  have hcomp2 : ∀ e : Fin n →₀ ℕ,
      Finsupp.mapDomain (σ.symm : Fin n → Fin n) (Finsupp.mapDomain (σ : Fin n → Fin n) e) = e := by
    intro e; rw [← Finsupp.mapDomain_comp, Equiv.symm_comp_self, Finsupp.mapDomain_id]
  have hsuppσ : ∀ d : Fin n →₀ ℕ,
      (Finsupp.mapDomain (σ : Fin n → Fin n) d).support = d.support.image (σ : Fin n → Fin n) :=
    fun d => Finsupp.mapDomain_support_of_injective σ.injective d
  have hsuppσ' : ∀ e : Fin n →₀ ℕ,
      (Finsupp.mapDomain (σ.symm : Fin n → Fin n) e).support
        = e.support.image (σ.symm : Fin n → Fin n) :=
    fun e => Finsupp.mapDomain_support_of_injective σ.symm.injective e
  have hA'symm : A'.image (σ.symm : Fin n → Fin n) = A := by
    rw [← hσ, Finset.image_image, Equiv.symm_comp_self, Finset.image_id]
  unfold supportCoeffSum
  refine Finset.sum_nbij' (Finsupp.mapDomain (σ : Fin n → Fin n))
    (Finsupp.mapDomain (σ.symm : Fin n → Fin n)) ?_ ?_ ?_ ?_ ?_
  · intro d hd
    rw [Finset.mem_filter] at hd ⊢
    refine ⟨?_, ?_⟩
    · rw [mem_support_iff, coeff_eq]; exact mem_support_iff.mp hd.1
    · rw [hsuppσ d, hd.2]; exact hσ
  · intro e he
    rw [Finset.mem_filter] at he ⊢
    refine ⟨?_, ?_⟩
    · rw [mem_support_iff]
      have hcoe := coeff_eq (Finsupp.mapDomain (σ.symm : Fin n → Fin n) e)
      rw [hcomp1] at hcoe
      rw [← hcoe]; exact mem_support_iff.mp he.1
    · rw [hsuppσ' e, he.2]; exact hA'symm
  · intro d _; exact hcomp2 d
  · intro e _; exact hcomp1 e
  · intro d _; rw [coeff_eq]

/-- The common value of `supportCoeffSum` on all `j`-element sets (junk `0` if none exist). -/
noncomputable def betaCoeff (j : ℕ) : ℝ :=
  if h : ∃ A : Finset (Fin n), A.card = j then supportCoeffSum P h.choose else 0

theorem supportCoeffSum_eq_beta (hP : P.IsSymmetric) (A : Finset (Fin n)) :
    supportCoeffSum P A = betaCoeff P A.card := by
  unfold betaCoeff
  have hex : ∃ B : Finset (Fin n), B.card = A.card := ⟨A, rfl⟩
  rw [dif_pos hex]
  exact supportCoeffSum_const P hP hex.choose_spec.symm

theorem support_card_le_totalDegree {d : Fin n →₀ ℕ} (hd : d ∈ P.support) :
    d.support.card ≤ P.totalDegree := by
  calc d.support.card = ∑ _i ∈ d.support, 1 := by rw [Finset.card_eq_sum_ones]
    _ ≤ ∑ i ∈ d.support, d i :=
        Finset.sum_le_sum (fun i hi => Nat.one_le_iff_ne_zero.mpr (Finsupp.mem_support_iff.mp hi))
    _ = d.sum (fun _ e => e) := rfl
    _ ≤ P.totalDegree := le_totalDegree hd

theorem betaCoeff_eq_zero_of_gt {H : ℕ} (hdeg : P.totalDegree ≤ H) {j : ℕ} (hj : H < j) :
    betaCoeff P j = 0 := by
  unfold betaCoeff
  by_cases hex : ∃ A : Finset (Fin n), A.card = j
  · rw [dif_pos hex]
    unfold supportCoeffSum
    apply Finset.sum_eq_zero
    intro d hd
    rw [Finset.mem_filter] at hd
    exfalso
    have hcard := support_card_le_totalDegree P hd.1
    rw [hd.2, hex.choose_spec] at hcard
    omega
  · rw [dif_neg hex]

/-! ## The univariate binomial polynomial `k ↦ C(k, j)` -/

/-- The polynomial whose value at `k` is `C(k, j)`, of degree `j`. -/
noncomputable def binomPoly (j : ℕ) : Polynomial ℝ :=
  ((Nat.factorial j : ℝ)⁻¹) • descPochhammer ℝ j

theorem binomPoly_eval (j k : ℕ) : (binomPoly j).eval (k : ℝ) = (k.choose j : ℝ) := by
  rw [binomPoly, Polynomial.eval_smul, smul_eq_mul, Nat.cast_choose_eq_descPochhammer_div,
    div_eq_inv_mul]

theorem binomPoly_natDegree_le (j : ℕ) : (binomPoly j).natDegree ≤ j := by
  rw [binomPoly]
  calc (((Nat.factorial j : ℝ)⁻¹) • descPochhammer ℝ j).natDegree
      ≤ (descPochhammer ℝ j).natDegree := Polynomial.natDegree_smul_le _ _
    _ = j := descPochhammer_natDegree ℝ j

/-! ## The reduction identity -/

/-- Symmetric `P` on the cube equals `∑_j β_j · C(|x|, j)`. -/
theorem eval_eq_betaSum (hP : P.IsSymmetric) (x : Fin n → Bool) :
    eval (cubePoint x) P
      = ∑ j ∈ Finset.range (n + 1), betaCoeff P j * ((hammingWeight x).choose j : ℝ) := by
  classical
  rw [eval_cube_eq_subset_sum]
  -- group exponent vectors by their support set
  have hmaps1 : ∀ d ∈ P.support, d.support ∈ (univ : Finset (Fin n)).powerset :=
    fun d _ => Finset.mem_powerset.mpr (Finset.subset_univ _)
  rw [← Finset.sum_fiberwise_of_maps_to hmaps1]
  -- simplify each support-fiber to an indicator times the aggregated coefficient
  have hinner : ∀ A ∈ (univ : Finset (Fin n)).powerset,
      (∑ d ∈ P.support.filter (fun d => d.support = A),
          P.coeff d * (if d.support ⊆ onesSet x then (1 : ℝ) else 0))
        = (if A ⊆ onesSet x then (1 : ℝ) else 0) * supportCoeffSum P A := by
    intro A _
    rw [supportCoeffSum, Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro d hd
    rw [Finset.mem_filter] at hd
    rw [hd.2]; ring
  rw [Finset.sum_congr rfl hinner]
  -- group sets by cardinality
  have hmaps2 : ∀ A ∈ (univ : Finset (Fin n)).powerset, A.card ∈ Finset.range (n + 1) := by
    intro A hA
    rw [Finset.mem_range, Nat.lt_succ_iff]
    have : A.card ≤ (univ : Finset (Fin n)).card := Finset.card_le_card (Finset.mem_powerset.mp hA)
    simpa [Finset.card_univ] using this
  rw [← Finset.sum_fiberwise_of_maps_to hmaps2]
  apply Finset.sum_congr rfl
  intro j _
  -- count the subsets of the ones-set of size j
  have hcount : (∑ A ∈ (univ : Finset (Fin n)).powerset.filter (fun A => A.card = j),
        (if A ⊆ onesSet x then (1 : ℝ) else 0)) = ((hammingWeight x).choose j : ℝ) := by
    have hset : ((univ : Finset (Fin n)).powerset.filter (fun A => A.card = j)).filter
          (fun A => A ⊆ onesSet x) = (onesSet x).powersetCard j := by
      ext A
      simp only [Finset.mem_filter, Finset.mem_powerset, Finset.mem_powersetCard]
      constructor
      · rintro ⟨⟨_, hc⟩, hs⟩; exact ⟨hs, hc⟩
      · rintro ⟨hs, hc⟩; exact ⟨⟨Finset.subset_univ _, hc⟩, hs⟩
    rw [Finset.sum_boole, hset, Finset.card_powersetCard, onesSet_card]
  calc (∑ A ∈ (univ : Finset (Fin n)).powerset.filter (fun A => A.card = j),
          (if A ⊆ onesSet x then (1 : ℝ) else 0) * supportCoeffSum P A)
      = ∑ A ∈ (univ : Finset (Fin n)).powerset.filter (fun A => A.card = j),
          betaCoeff P j * (if A ⊆ onesSet x then (1 : ℝ) else 0) := by
        apply Finset.sum_congr rfl
        intro A hA
        rw [Finset.mem_filter] at hA
        rw [supportCoeffSum_eq_beta P hP A, hA.2]; ring
    _ = betaCoeff P j * ∑ A ∈ (univ : Finset (Fin n)).powerset.filter (fun A => A.card = j),
          (if A ⊆ onesSet x then (1 : ℝ) else 0) := by rw [Finset.mul_sum]
    _ = betaCoeff P j * ((hammingWeight x).choose j : ℝ) := by rw [hcount]

/-- **Univariate reduction.** A symmetric polynomial of total degree `≤ H` on the
cube is a univariate polynomial of degree `≤ H` in the Hamming weight. -/
theorem exists_univariate_of_symmetric {H : ℕ} (hP : P.IsSymmetric)
    (hdeg : P.totalDegree ≤ H) :
    ∃ p : Polynomial ℝ, p.natDegree ≤ H ∧
      ∀ x : Fin n → Bool, p.eval (hammingWeight x : ℝ) = eval (cubePoint x) P := by
  refine ⟨∑ j ∈ Finset.range (n + 1), betaCoeff P j • binomPoly j, ?_, ?_⟩
  · apply Polynomial.natDegree_sum_le_of_forall_le
    intro j _
    by_cases hjH : H < j
    · rw [betaCoeff_eq_zero_of_gt P hdeg hjH, zero_smul, Polynomial.natDegree_zero]
      exact Nat.zero_le _
    · push Not at hjH
      calc (betaCoeff P j • binomPoly j).natDegree
          ≤ (binomPoly j).natDegree := Polynomial.natDegree_smul_le _ _
        _ ≤ j := binomPoly_natDegree_le j
        _ ≤ H := hjH
  · intro x
    rw [eval_eq_betaSum P hP x, Polynomial.eval_finsetSum]
    apply Finset.sum_congr rfl
    intro j _
    rw [Polynomial.eval_smul, smul_eq_mul, binomPoly_eval]

/-! ## L12 lower bound -/

/-- For any `k ≤ n` there is an input of Hamming weight `k`. -/
theorem exists_hammingWeight_eq {k : ℕ} (hk : k ≤ n) :
    ∃ x : Fin n → Bool, hammingWeight x = k := by
  classical
  obtain ⟨T, _, hTcard⟩ := Finset.exists_subset_card_eq
    (show k ≤ (univ : Finset (Fin n)).card by rw [Finset.card_univ, Fintype.card_fin]; exact hk)
  refine ⟨fun i => decide (i ∈ T), ?_⟩
  rw [show hammingWeight (fun i => decide (i ∈ T)) = T.card by
        unfold hammingWeight
        congr 1
        ext i
        simp [decide_eq_true_eq]]
  exact hTcard

/-- **Threshold-degree lower bound for sign changes.** If `symmetricFn F` has
threshold degree `≤ H`, then its weight profile has at most `H` sign changes.
This is the symmetric heart of the Theorem 12 lower bound (model → polynomial is
the separate `signReprDegLe_of_computableWithHeadsN` step), and is reused for the
threshold degree of parity (Theorem 7). -/
theorem signChanges_le_of_ThresholdDegLE {H : ℕ} {F : ℕ → Bool}
    (hTD : ThresholdDegLE (n := n) (symmetricFn F) H) :
    signChanges n F ≤ H := by
  obtain ⟨P, hPdeg, hPstrict⟩ := exists_strictSignRep_of_ThresholdDegLE hTD
  -- symmetrize
  have hQdeg : (symmetrize P).totalDegree ≤ H := symmetrize_totalDegree_le hPdeg
  have hQsym : (symmetrize P).IsSymmetric := symmetrize_isSymmetric P
  have hQstrict : StrictSignRep (symmetrize P) (symmetricFn F) := symmetrize_strictSignRep hPstrict
  -- univariate reduction
  obtain ⟨p, hpdeg, hpval⟩ := exists_univariate_of_symmetric (symmetrize P) hQsym hQdeg
  have hpos : ∀ k, k ≤ n → F k = true → 0 < p.eval (k : ℝ) := by
    intro k hk hFk
    obtain ⟨x, hx⟩ := exists_hammingWeight_eq hk
    rw [← hx, hpval x]
    apply (hQstrict x).1
    rw [symmetricFn_apply, hx]; exact hFk
  have hneg : ∀ k, k ≤ n → F k = false → p.eval (k : ℝ) < 0 := by
    intro k hk hFk
    obtain ⟨x, hx⟩ := exists_hammingWeight_eq hk
    rw [← hx, hpval x]
    apply (hQstrict x).2
    rw [symmetricFn_apply, hx]; exact hFk
  calc signChanges n F ≤ p.natDegree := signChanges_le_natDegree p F n hpos hneg
    _ ≤ H := hpdeg

/-- **Theorem 12 lower bound.** If a symmetric Boolean function `symmetricFn F` is
computable with `H` heads, then the number of sign changes of its weight profile
`F` is at most `H`. -/
theorem signChanges_le_of_computableWithHeadsN {H : ℕ} {F : ℕ → Bool}
    (hcomp : computableWithHeadsN n H (symmetricFn F)) :
    signChanges n F ≤ H :=
  signChanges_le_of_ThresholdDegLE (signReprDegLe_of_computableWithHeadsN hcomp)

end HeadComplexity
