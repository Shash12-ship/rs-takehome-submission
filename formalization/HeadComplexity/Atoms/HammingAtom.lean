import HeadComplexity.Polynomial.UnivariateReduction
import Mathlib.Analysis.SpecialFunctions.Log.Basic

set_option linter.style.header false

/-!
# L12 upper bound: one head realizes one linear-fractional atom.

Following the linear-fractional normal form, each attention head whose scores
depend only on the token type contributes, under a fixed readout, a term
`b / (k + a)` in the Hamming weight `k = |x|`.  We build such a head explicitly
with `d = 2` and `W_Q = W_K = W_V = id`, pushing all structure into the token
embedding:

* coordinate `0` is the **score** channel, coordinate `1` the **value** channel;
* `tokenEmbed 0 = (0, b/n)`, `tokenEmbed 1 = (log 2 / s, b/(2n))`,
  `tokenEmbed 2 = (s, 0)` with `s = sqrt (log (a - n))`.

Then the softmax weight at a bit position is `1` (bit `0`) or `2` (bit `1`), the
query weight is `a - n`, the denominator is `(n-k)·1 + k·2 + (a-n) = k + a`, and
the readout `⟪e₁, ·⟫` of the numerator is the constant `b`.  Hence
`⟪e₁, attnUpdate x⟫ = b / (k + a)`.  The same readout `e₁` adds the atoms of
several heads, so a partial-fraction decomposition of the sign pattern gives the
full `C(F)`-head construction.
-/

namespace HeadComplexity

open MvPolynomial Finset Head
open scoped BigOperators InnerProductSpace

variable {n : ℕ}

/-- Token embedding of the atom head for parameters `a, b` over `n` bits. -/
noncomputable def atomTok (n : ℕ) (a b : ℝ) : Fin 3 → Vec 2 :=
  ![ EuclideanSpace.single 1 (b / n),
     EuclideanSpace.single 0 (Real.log 2 / Real.sqrt (Real.log (a - n)))
       + EuclideanSpace.single 1 (b / (2 * n)),
     EuclideanSpace.single 0 (Real.sqrt (Real.log (a - n))) ]

/-- The atom head: scores depend only on the token, values live in coordinate 1. -/
noncomputable def atomHead (n : ℕ) (a b : ℝ) : Head n 2 where
  tokenEmbed := atomTok n a b
  posEmbed := fun _ => 0
  WQ := LinearMap.id
  WK := LinearMap.id
  WV := LinearMap.id

/-- The shared readout vector `e₁`. -/
noncomputable def atomReadout : Vec 2 := EuclideanSpace.single 1 1

section
variable (a b : ℝ)

@[simp] theorem atomHead_tokenEmbed : (atomHead n a b).tokenEmbed = atomTok n a b := rfl
@[simp] theorem atomHead_posEmbed (p : SeqPos n) : (atomHead n a b).posEmbed p = 0 := rfl

/-- The query embedding `x_=` equals `tokenEmbed 2`. -/
theorem atomHead_x_none (bits : Fin n → Bool) :
    (atomHead n a b).x bits none = atomTok n a b 2 := by
  simp [Head.x, Head.seqTok]

/-- Coordinate-0 (score channel) of each token embedding. -/
@[simp] theorem atomTok_zero_coord0 : atomTok n a b 0 0 = 0 := by
  simp [atomTok]
@[simp] theorem atomTok_one_coord0 :
    atomTok n a b 1 0 = Real.log 2 / Real.sqrt (Real.log (a - n)) := by
  simp [atomTok]
@[simp] theorem atomTok_two_coord0 : atomTok n a b 2 0 = Real.sqrt (Real.log (a - n)) := by
  simp [atomTok]

/-- Coordinate-1 (value channel) of each token embedding. -/
@[simp] theorem atomTok_zero_coord1 : atomTok n a b 0 1 = b / n := by
  simp [atomTok]
@[simp] theorem atomTok_one_coord1 : atomTok n a b 1 1 = b / (2 * n) := by
  simp [atomTok]
@[simp] theorem atomTok_two_coord1 : atomTok n a b 2 1 = 0 := by
  simp [atomTok]

@[simp] theorem atomHead_WK : (atomHead n a b).WK = LinearMap.id := rfl
@[simp] theorem atomHead_WQ : (atomHead n a b).WQ = LinearMap.id := rfl
@[simp] theorem atomHead_WV : (atomHead n a b).WV = LinearMap.id := rfl

/-- Real inner product on `Vec 2` as a coordinate sum (sidesteps the
`InnerProductSpace ℝ ℝ` instance diamond via the `rfl` theorem `inner_eq_star_dotProduct`). -/
theorem vec2_inner (x y : Vec 2) : ⟪x, y⟫_ℝ = x 0 * y 0 + x 1 * y 1 := by
  change dotProduct (y.ofLp) (star x.ofLp) = _
  simp only [dotProduct, Fin.sum_univ_two, Pi.star_apply, star_trivial]
  ring

/-- Inner product of a token with the query token (score before exp). -/
theorem atomTok_inner_two (t : Fin 3) :
    ⟪atomTok n a b t, atomTok n a b 2⟫_ℝ
      = atomTok n a b t 0 * Real.sqrt (Real.log (a - n)) := by
  rw [vec2_inner]; simp

/-- Readout `⟪e₁, ·⟫` of a token equals its value-channel coordinate. -/
theorem atomReadout_inner (t : Fin 3) :
    ⟪atomReadout, atomTok n a b t⟫_ℝ = atomTok n a b t 1 := by
  rw [vec2_inner]; simp [atomReadout]

end

/-! ## Softmax weights, denominator, numerator readout -/

section
variable (a b : ℝ) (hn : 1 ≤ n) (ha : (n : ℝ) + 1 < a)

include ha in
private theorem a_sub_n_pos : 0 < a - n := by
  have : (1 : ℝ) < a - n := by linarith
  linarith

include ha in
private theorem log_a_sub_n_pos : 0 < Real.log (a - n) := by
  apply Real.log_pos; linarith

include ha in
private theorem sqrt_log_ne : Real.sqrt (Real.log (a - n)) ≠ 0 := by
  have := log_a_sub_n_pos a ha
  positivity

include ha in
/-- Softmax weight at the query token is `a - n`. -/
theorem atomHead_sigma_none (bits : Fin n → Bool) :
    (atomHead n a b).sigma bits none = a - n := by
  have hpos := a_sub_n_pos a ha
  have hsq : Real.sqrt (Real.log (a - n)) * Real.sqrt (Real.log (a - n)) = Real.log (a - n) :=
    Real.mul_self_sqrt (le_of_lt (log_a_sub_n_pos a ha))
  unfold Head.sigma
  rw [atomHead_x_none]
  simp only [atomHead_WK, atomHead_WQ, LinearMap.id_coe, id_eq]
  rw [atomTok_inner_two, atomTok_two_coord0, hsq, Real.exp_log hpos]

include ha in
/-- Softmax weight at a bit position: `2` if the bit is set, else `1`. -/
theorem atomHead_sigma_some (bits : Fin n → Bool) (i : Fin n) :
    (atomHead n a b).sigma bits (some i) = if bits i then 2 else 1 := by
  have hs := sqrt_log_ne a ha
  unfold Head.sigma
  rw [atomHead_x_none]
  simp only [atomHead_WK, atomHead_WQ, LinearMap.id_coe, id_eq]
  have hx : (atomHead n a b).x bits (some i) = atomTok n a b (cond (bits i) 1 0) := by
    simp [Head.x, Head.seqTok]
  rw [hx, atomTok_inner_two]
  cases bits i with
  | false => simp
  | true =>
      simp only [cond_true, atomTok_one_coord0]
      rw [div_mul_cancel₀ _ hs, Real.exp_log (by norm_num)]
      simp

/-- The value vector equals the token embedding (since `W_V = id`). -/
theorem atomHead_value_eq (bits : Fin n → Bool) (p : SeqPos n) :
    (atomHead n a b).value bits p = atomTok n a b (Head.seqTok bits p) := by
  simp [Head.value, Head.x, atomHead_WV]

include ha in
/-- Denominator is `k + a` where `k = |x|`. -/
theorem atomHead_denom (bits : Fin n → Bool) :
    (atomHead n a b).denominator bits = (hammingWeight bits : ℝ) + a := by
  unfold Head.denominator
  rw [Fintype.sum_option, atomHead_sigma_none a b ha]
  have hsome : ∀ i, (atomHead n a b).sigma bits (some i) = 1 + (if bits i then (1:ℝ) else 0) := by
    intro i; rw [atomHead_sigma_some a b ha]; cases bits i with
    | false => norm_num
    | true => norm_num
  simp_rw [hsome]
  rw [Finset.sum_add_distrib, Finset.sum_const, Finset.card_univ, Fintype.card_fin]
  have hk : ∑ i : Fin n, (if bits i then (1:ℝ) else 0) = (hammingWeight bits : ℝ) := by
    rw [Finset.sum_boole]
    simp [hammingWeight]
  rw [hk, nsmul_eq_mul, mul_one]
  ring

include hn ha in
/-- Readout of the numerator is the constant `b`. -/
theorem atomHead_numread (bits : Fin n → Bool) :
    ⟪atomReadout, (atomHead n a b).numerator bits⟫_ℝ = b := by
  have hn0 : (n : ℝ) ≠ 0 := by positivity
  unfold Head.numerator
  rw [inner_sum, Fintype.sum_option]
  simp_rw [inner_smul_right, atomHead_value_eq, atomReadout_inner]
  rw [atomHead_sigma_none a b ha]
  have hquery : atomTok n a b (Head.seqTok bits none) 1 = 0 := by simp [Head.seqTok]
  rw [hquery, mul_zero, zero_add]
  have hbit : ∀ i, (atomHead n a b).sigma bits (some i)
        * atomTok n a b (Head.seqTok bits (some i)) 1 = b / n := by
    intro i
    rw [atomHead_sigma_some a b ha]
    have hseq : Head.seqTok bits (some i) = cond (bits i) 1 0 := rfl
    rw [hseq]
    cases bits i <;> simp; ring
  rw [Finset.sum_congr rfl (fun i _ => hbit i), Finset.sum_const, Finset.card_univ,
    Fintype.card_fin, nsmul_eq_mul]
  field_simp

include hn ha in
/-- **One head = one atom.** The readout of one atom head is `b / (k + a)`. -/
theorem atomHead_readout (bits : Fin n → Bool) :
    ⟪atomReadout, (atomHead n a b).attnUpdate bits⟫_ℝ
      = b / ((hammingWeight bits : ℝ) + a) := by
  unfold Head.attnUpdate
  rw [inner_smul_right, atomHead_numread a b hn ha, atomHead_denom a b ha]
  rw [div_eq_mul_inv, mul_comm]

end

/-- **A family of `C` atom heads, shared readout.** The summed readout is the sum
of the atoms `∑ h, b h / (k + a h)`. -/
theorem atomFamily_readout {C : ℕ} (hn : 1 ≤ n) (av bv : Fin C → ℝ)
    (ha : ∀ h, (n : ℝ) + 1 < av h) (bits : Fin n → Bool) :
    ⟪atomReadout, ∑ h, (atomHead n (av h) (bv h)).attnUpdate bits⟫_ℝ
      = ∑ h, bv h / ((hammingWeight bits : ℝ) + av h) := by
  rw [inner_sum]
  exact Finset.sum_congr rfl (fun h _ => atomHead_readout (av h) (bv h) hn (ha h) bits)

end HeadComplexity
