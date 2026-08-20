import HeadComplexity.Atoms.HammingAtom
import HeadComplexity.Atoms.PartialFraction
import HeadComplexity.Foundation.Softmax
import Mathlib.LinearAlgebra.Lagrange
import Mathlib.Algebra.BigOperators.Fin

set_option linter.style.header false

/-!
# Weighted-sum interpolation construction.

If `f(x) = F(t(x))` for a positive weighted sum `t(x) = ∑ λ_i x_i` with image of
size `M`, then `f` is computable with `M - 1` heads. The `H*` corollaries live
in `Results/WeightedUpperBound.lean`.

The head construction generalizes `atomHead`: with `d = 2`, `W_Q = W_K = W_V = id`,
score channel `0`, value channel `1`, and `s = √(log (a - Λ))` (`Λ = ∑ λ_i`):

* `posEmbed (some i) = single 0 (log λ_i / s)` injects `log λ_i` into position `i`'s
  logit, so the softmax weight there is `λ_i` (bit 0) or `2 λ_i` (bit 1);
* the query token has logit `s² = log (a - Λ)`, weight `a - Λ`.

Hence the denominator is `∑_i (λ_i + λ_i x_i) + (a - Λ) = t(x) + a`, and the readout
`⟪e₁, ·⟫` of the numerator is the constant `b`, so `⟪e₁, attnUpdate x⟫ = b/(t(x)+a)`.
Reusing `real_partial_fraction` and a Lagrange sign polynomial gives the `M-1` heads.
-/

namespace HeadComplexity

open MvPolynomial Finset Head
open scoped BigOperators InnerProductSpace

variable {n : ℕ}

/-- Total weight `Λ = ∑ λ_i`. -/
noncomputable def wLam (lam : Fin n → ℝ) : ℝ := ∑ i, lam i

/-- Weighted statistic `t(x) = ∑_{i : x_i} λ_i`. -/
noncomputable def wT (lam : Fin n → ℝ) (bits : Fin n → Bool) : ℝ := ∑ i, if bits i then lam i else 0

/-- Score scale `s = √(log (a - Λ))`. -/
noncomputable def wScore (lam : Fin n → ℝ) (a : ℝ) : ℝ := Real.sqrt (Real.log (a - wLam lam))

/-- Token embedding of the weighted atom head. -/
noncomputable def wTok (lam : Fin n → ℝ) (a b : ℝ) : Fin 3 → Vec 2 :=
  ![ EuclideanSpace.single 1 (b / wLam lam),
     EuclideanSpace.single 0 (Real.log 2 / wScore lam a)
       + EuclideanSpace.single 1 (b / (2 * wLam lam)),
     EuclideanSpace.single 0 (wScore lam a) ]

/-- Positional embedding: position `i` carries `log λ_i / s` in the score channel. -/
noncomputable def wPos (lam : Fin n → ℝ) (a : ℝ) : SeqPos n → Vec 2
  | some i => EuclideanSpace.single 0 (Real.log (lam i) / wScore lam a)
  | none => 0

/-- The weighted atom head over `n` bits. -/
noncomputable def weightedAtomHead (lam : Fin n → ℝ) (a b : ℝ) : Head n 2 where
  tokenEmbed := wTok lam a b
  posEmbed := wPos lam a
  WQ := LinearMap.id
  WK := LinearMap.id
  WV := LinearMap.id

section
variable (lam : Fin n → ℝ) (a b : ℝ)

@[simp] theorem wTok_zero_coord0 : wTok lam a b 0 0 = 0 := by simp [wTok]
@[simp] theorem wTok_one_coord0 : wTok lam a b 1 0 = Real.log 2 / wScore lam a := by simp [wTok]
@[simp] theorem wTok_two_coord0 : wTok lam a b 2 0 = wScore lam a := by simp [wTok]
@[simp] theorem wTok_zero_coord1 : wTok lam a b 0 1 = b / wLam lam := by simp [wTok]
@[simp] theorem wTok_one_coord1 : wTok lam a b 1 1 = b / (2 * wLam lam) := by simp [wTok]
@[simp] theorem wTok_two_coord1 : wTok lam a b 2 1 = 0 := by simp [wTok]

@[simp] theorem weightedAtomHead_WK : (weightedAtomHead lam a b).WK = LinearMap.id := rfl
@[simp] theorem weightedAtomHead_WQ : (weightedAtomHead lam a b).WQ = LinearMap.id := rfl
@[simp] theorem weightedAtomHead_WV : (weightedAtomHead lam a b).WV = LinearMap.id := rfl

/-- The query embedding equals `tokenEmbed 2` (positional part is zero). -/
theorem wHead_x_none (bits : Fin n → Bool) :
    (weightedAtomHead lam a b).x bits none = wTok lam a b 2 := by
  simp [Head.x, Head.seqTok, weightedAtomHead, wPos]

/-- Score-channel coordinate of position `i`. -/
theorem wHead_x_some_coord0 (bits : Fin n → Bool) (i : Fin n) :
    ((weightedAtomHead lam a b).x bits (some i)) 0
      = wTok lam a b (cond (bits i) 1 0) 0 + Real.log (lam i) / wScore lam a := by
  simp only [Head.x, Head.seqTok, weightedAtomHead, wPos]
  rw [PiLp.add_apply, PiLp.single_apply]
  simp

/-- Value-channel coordinate of position `i` (unaffected by `posEmbed`). -/
theorem wHead_x_some_coord1 (bits : Fin n → Bool) (i : Fin n) :
    ((weightedAtomHead lam a b).x bits (some i)) 1
      = wTok lam a b (cond (bits i) 1 0) 1 := by
  simp only [Head.x, Head.seqTok, weightedAtomHead, wPos]
  rw [PiLp.add_apply, PiLp.single_apply]
  simp

/-- Readout `⟪e₁, ·⟫` reads the value channel (coordinate `1`). -/
theorem wReadout_inner (v : Vec 2) : ⟪atomReadout, v⟫_ℝ = v 1 := by
  rw [atomReadout, vec2_inner]; simp

end

section
variable (lam : Fin n → ℝ) (a b : ℝ) (hn : 1 ≤ n) (hlam : ∀ i, 0 < lam i)
  (ha : wLam lam + 1 < a)

include hn hlam in
private theorem wLam_pos : 0 < wLam lam := by
  letI : Nonempty (Fin n) := Fin.pos_iff_nonempty.mp hn
  unfold wLam
  exact positiveNormalizer_pos lam hlam

include ha in
private theorem wa_sub_pos : 0 < a - wLam lam := by linarith

include ha in
private theorem wlog_pos : 0 < Real.log (a - wLam lam) := by
  apply Real.log_pos; linarith

include ha in
private theorem wScore_ne : wScore lam a ≠ 0 := by
  have := wlog_pos lam a ha
  unfold wScore; positivity

include ha in
private theorem wScore_sq : wScore lam a * wScore lam a = Real.log (a - wLam lam) := by
  unfold wScore
  exact Real.mul_self_sqrt (le_of_lt (wlog_pos lam a ha))

include ha in
/-- Softmax weight at the query token is `a - Λ`. -/
theorem wHead_sigma_none (bits : Fin n → Bool) :
    (weightedAtomHead lam a b).sigma bits none = a - wLam lam := by
  unfold Head.sigma
  rw [wHead_x_none]
  simp only [weightedAtomHead_WK, weightedAtomHead_WQ, LinearMap.id_coe, id_eq]
  rw [vec2_inner]
  simp only [wTok_two_coord0, wTok_two_coord1, mul_zero, add_zero]
  rw [wScore_sq lam a ha, Real.exp_log (wa_sub_pos lam a ha)]

include hlam ha in
/-- Softmax weight at position `i`: `2 λ_i` if the bit is set, else `λ_i`. -/
theorem wHead_sigma_some (bits : Fin n → Bool) (i : Fin n) :
    (weightedAtomHead lam a b).sigma bits (some i) = if bits i then 2 * lam i else lam i := by
  have hs := wScore_ne lam a ha
  unfold Head.sigma
  rw [wHead_x_none]
  simp only [weightedAtomHead_WK, weightedAtomHead_WQ, LinearMap.id_coe, id_eq]
  rw [vec2_inner]
  simp only [wTok_two_coord0, wTok_two_coord1, mul_zero, add_zero]
  rw [wHead_x_some_coord0]
  cases bits i with
  | false =>
      simp only [cond_false, wTok_zero_coord0, zero_add]
      rw [div_mul_cancel₀ _ hs, Real.exp_log (hlam i)]
      simp
  | true =>
      simp only [cond_true, wTok_one_coord0]
      rw [← add_div, div_mul_cancel₀ _ hs,
        show Real.log 2 + Real.log (lam i) = Real.log (2 * lam i) from
          (Real.log_mul (by norm_num) (hlam i).ne').symm,
        Real.exp_log (mul_pos (by norm_num) (hlam i))]
      simp

/-- The value vector equals the embedding (since `W_V = id`). -/
theorem wHead_value (bits : Fin n → Bool) (p : SeqPos n) :
    (weightedAtomHead lam a b).value bits p = (weightedAtomHead lam a b).x bits p := by
  simp [Head.value, weightedAtomHead]

include hlam ha in
/-- Denominator is `t(x) + a`. -/
theorem wHead_denom (bits : Fin n → Bool) :
    (weightedAtomHead lam a b).denominator bits = wT lam bits + a := by
  unfold Head.denominator
  rw [Fintype.sum_option, wHead_sigma_none lam a b ha]
  have hsome : ∀ i, (weightedAtomHead lam a b).sigma bits (some i)
      = lam i + (if bits i then lam i else 0) := by
    intro i; rw [wHead_sigma_some lam a b hlam ha]; cases bits i <;> simp; ring
  simp_rw [hsome]
  rw [Finset.sum_add_distrib]
  unfold wT wLam
  ring

include hn hlam ha in
/-- Readout `⟪e₁, ·⟫` of the numerator is the constant `b`. -/
theorem wHead_numread (bits : Fin n → Bool) :
    ⟪atomReadout, (weightedAtomHead lam a b).numerator bits⟫_ℝ = b := by
  have hL := (wLam_pos lam hn hlam).ne'
  unfold Head.numerator
  rw [inner_sum, Fintype.sum_option]
  simp_rw [inner_smul_right, wHead_value]
  have hquery : ⟪atomReadout, (weightedAtomHead lam a b).x bits none⟫_ℝ = 0 := by
    rw [wHead_x_none, wReadout_inner, wTok_two_coord1]
  rw [hquery, mul_zero, zero_add]
  have hbit : ∀ i, (weightedAtomHead lam a b).sigma bits (some i)
        * ⟪atomReadout, (weightedAtomHead lam a b).x bits (some i)⟫_ℝ = b * lam i / wLam lam := by
    intro i
    rw [wHead_sigma_some lam a b hlam ha, wReadout_inner, wHead_x_some_coord1]
    cases bits i <;> simp <;> ring
  rw [Finset.sum_congr rfl (fun i _ => hbit i)]
  rw [← Finset.sum_div, ← Finset.mul_sum, show ∑ i, lam i = wLam lam from rfl,
    mul_div_assoc, div_self hL, mul_one]

include hn hlam ha in
/-- **One weighted head = one atom `b/(t(x)+a)`.** -/
theorem weightedAtom_readout (bits : Fin n → Bool) :
    ⟪atomReadout, (weightedAtomHead lam a b).attnUpdate bits⟫_ℝ = b / (wT lam bits + a) := by
  unfold Head.attnUpdate
  rw [inner_smul_right, wHead_numread lam a b hn hlam ha, wHead_denom lam a b hlam ha]
  rw [div_eq_mul_inv, mul_comm]

/-- **A family of `C` weighted heads, shared readout.** -/
theorem weightedAtomFamily_readout {C : ℕ} (hn : 1 ≤ n) (hlam : ∀ i, 0 < lam i)
    (av bv : Fin C → ℝ) (hav : ∀ h, wLam lam + 1 < av h) (bits : Fin n → Bool) :
    ⟪atomReadout, ∑ h, (weightedAtomHead lam (av h) (bv h)).attnUpdate bits⟫_ℝ
      = ∑ h, bv h / (wT lam bits + av h) := by
  rw [inner_sum]
  exact Finset.sum_congr rfl
    (fun h _ => weightedAtom_readout lam (av h) (bv h) hn hlam (hav h) bits)

end

/-- The weighted statistic is nonnegative. -/
theorem wT_nonneg {lam : Fin n → ℝ} (hlam : ∀ i, 0 < lam i) (bits : Fin n → Bool) :
    0 ≤ wT lam bits :=
  Finset.sum_nonneg (fun i _ => by by_cases h : bits i <;> simp [h, (hlam i).le])

open Polynomial in
/-- **Rational atoms for a weighted-sum function.** There are `M-1` shift/coefficient
pairs and a threshold realizing `f` through `∑ b_h/(t(x)+a_h)`. -/
theorem exists_weighted_atoms (lam : Fin n → ℝ) (hlam : ∀ i, 0 < lam i)
    (f : (Fin n → Bool) → Bool) (G : ℝ → Bool) (hf : ∀ bits, f bits = G (wT lam bits)) :
    ∃ (av bv : Fin ((Finset.univ.image (wT lam)).card - 1) → ℝ) (τ : ℝ),
      (∀ h, wLam lam + 1 < av h) ∧
      ∀ bits, ((∑ h, bv h / (wT lam bits + av h)) > τ ↔ f bits = true) := by
  classical
  set S := Finset.univ.image (wT lam) with hS
  set M := S.card with hMdef
  set P := Lagrange.interpolate S id (fun x => if G x then (1 : ℝ) else -1) with hP
  have hPdeg : P.natDegree ≤ M - 1 :=
    Polynomial.natDegree_le_iff_degree_le.mpr
      (Lagrange.degree_interpolate_le (r := fun x => if G x then (1 : ℝ) else -1) (Set.injOn_id _))
  have hPsign : ∀ bits, 0 < P.eval (wT lam bits) ↔ f bits = true := by
    intro bits
    have hmem : wT lam bits ∈ S := Finset.mem_image_of_mem _ (Finset.mem_univ bits)
    have heval : P.eval (wT lam bits) = if G (wT lam bits) then (1 : ℝ) else -1 := by
      have := Lagrange.eval_interpolate_at_node (s := S) (v := id)
        (r := fun x => if G x then (1 : ℝ) else -1) (Set.injOn_id _) hmem
      simpa [hP] using this
    rw [heval, hf bits]
    cases G (wT lam bits) <;> norm_num
  set av : Fin (M - 1) → ℝ := fun h => wLam lam + 2 + (h : ℕ) with hav
  have havinj : Function.Injective av := by
    intro x y hxy
    rw [hav] at hxy
    simp only [add_right_inj, Nat.cast_inj] at hxy
    exact Fin.ext hxy
  have hLnn : 0 ≤ wLam lam := Finset.sum_nonneg (fun i _ => (hlam i).le)
  have havpos : ∀ h, wLam lam + 1 < av h := by
    intro h; rw [hav]; have : (0 : ℝ) ≤ (h : ℕ) := Nat.cast_nonneg _; linarith
  obtain ⟨A, bv, hpf⟩ := real_partial_fraction P av havinj hPdeg
  refine ⟨av, bv, -A, havpos, ?_⟩
  intro bits
  have hTnn := wT_nonneg hlam bits
  have hfacpos : ∀ h : Fin (M - 1), (0 : ℝ) < wT lam bits + av h := by
    intro h; rw [hav]; have : (0 : ℝ) ≤ (h : ℕ) := Nat.cast_nonneg _; linarith
  have hQpos : 0 < ∏ h : Fin (M - 1), (wT lam bits + av h) :=
    Finset.prod_pos (fun h _ => hfacpos h)
  have herase_ne : ∀ h : Fin (M - 1),
      (∏ j ∈ Finset.univ.erase h, (wT lam bits + av j)) ≠ 0 :=
    fun h => Finset.prod_ne_zero_iff.mpr (fun j _ => ne_of_gt (hfacpos j))
  have hQfac : ∀ h : Fin (M - 1),
      (∏ j, (wT lam bits + av j))
        = (wT lam bits + av h) * ∏ j ∈ Finset.univ.erase h, (wT lam bits + av j) :=
    fun h =>
      (Finset.mul_prod_erase Finset.univ (fun j => wT lam bits + av j) (Finset.mem_univ h)).symm
  have hkey : (∑ h, bv h / (wT lam bits + av h))
      = P.eval (wT lam bits) / (∏ h, (wT lam bits + av h)) - A := by
    have h1 : (∑ h, bv h / (wT lam bits + av h))
        = (∑ h, bv h * ∏ j ∈ Finset.univ.erase h, (wT lam bits + av j))
          / (∏ h, (wT lam bits + av h)) := by
      rw [Finset.sum_div]
      refine Finset.sum_congr rfl (fun h _ => ?_)
      rw [hQfac h, mul_div_mul_right _ _ (herase_ne h)]
    rw [h1, hpf (wT lam bits)]
    field_simp
    ring
  rw [gt_iff_lt, hkey, lt_sub_iff_add_lt, neg_add_cancel, lt_div_iff₀ hQpos, zero_mul]
  exact (hPsign bits)

/-- **Theorem 9 (computability form).** A function of a positive weighted sum with
image size `M` is computable with `M - 1` heads. -/
theorem weighted_computable (lam : Fin n → ℝ) (hlam : ∀ i, 0 < lam i)
    (f : (Fin n → Bool) → Bool) (G : ℝ → Bool) (hf : ∀ bits, f bits = G (wT lam bits)) :
    computableWithHeadsN n ((Finset.univ.image (wT lam)).card - 1) f := by
  classical
  rcases Nat.eq_zero_or_pos n with hn0 | hn
  · subst hn0
    have hcard : (Finset.univ.image (wT lam)).card - 1 = 0 := by
      have h1 : (Finset.univ.image (wT lam)).card ≤ 1 :=
        Finset.card_image_le.trans (by simp)
      omega
    rw [hcard]
    refine ⟨2, (Fin.elim0 : HeadFamily 0 2 0), (0 : Vec 2), (if f default then -1 else 1), ?_⟩
    intro bits
    rw [headFamilyAttnUpdate_zero, inner_zero_right, Subsingleton.elim bits default]
    cases f default <;> norm_num
  · obtain ⟨av, bv, τ, hav, hatom⟩ := exists_weighted_atoms lam hlam f G hf
    refine ⟨2, fun h => weightedAtomHead lam (av h) (bv h), atomReadout, τ, ?_⟩
    intro bits
    change ⟪atomReadout, ∑ h, (weightedAtomHead lam (av h) (bv h)).attnUpdate bits⟫_ℝ > τ ↔ _
    rw [weightedAtomFamily_readout lam hn hlam av bv hav bits]
    exact hatom bits

/-! ## Universal computability: every function is computable -/

/-- The binary weighting `λ_i = 2^i` separates all inputs. -/
theorem wT_two_pow_injective :
    Function.Injective (wT (n := n) (fun i => (2 : ℝ) ^ (i : ℕ))) := by
  have key : ∀ bits : Fin n → Bool,
      wT (fun i => (2 : ℝ) ^ (i : ℕ)) bits
        = ((finFunctionFinEquiv (fun i => if bits i then (1 : Fin 2) else 0) : ℕ) : ℝ) := by
    intro bits
    rw [finFunctionFinEquiv_apply, Nat.cast_sum]
    unfold wT
    refine Finset.sum_congr rfl (fun i _ => ?_)
    by_cases hb : bits i <;> simp [hb]
  intro b b' h
  rw [key, key] at h
  have h2 : finFunctionFinEquiv (fun i => if b i then (1 : Fin 2) else 0)
      = finFunctionFinEquiv (fun i => if b' i then (1 : Fin 2) else 0) := by
    apply Fin.val_injective
    exact_mod_cast h
  have h3 := finFunctionFinEquiv.injective h2
  funext i
  have hi := congrFun h3 i
  by_cases hb : b i <;> by_cases hb' : b' i <;> simp_all

/-- Every Boolean function is computable with at most `2^n - 1` heads. -/
theorem universal_computable (f : (Fin n → Bool) → Bool) :
    computableWithHeadsN n (2 ^ n - 1) f := by
  classical
  set lam : Fin n → ℝ := fun i => (2 : ℝ) ^ (i : ℕ) with hlamdef
  have hlam : ∀ i, 0 < lam i := fun i => by rw [hlamdef]; positivity
  have hinj : Function.Injective (wT lam) := wT_two_pow_injective
  have hf : ∀ bits, f bits = (f ∘ Function.invFun (wT lam)) (wT lam bits) := by
    intro bits
    change f bits = f (Function.invFun (wT lam) (wT lam bits))
    rw [Function.leftInverse_invFun hinj bits]
  have hcomp := weighted_computable lam hlam f _ hf
  have hcard : (Finset.univ.image (wT lam)).card = 2 ^ n := by
    rw [Finset.card_image_of_injective _ hinj, Finset.card_univ]
    simp
  rw [hcard] at hcomp
  exact hcomp

end HeadComplexity
