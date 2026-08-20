import HeadComplexity.Atoms.TwoHeadClearing
import HeadComplexity.Polynomial.AntipodalTwoProduct
import HeadComplexity.Polynomial.ParityThresholdDegree
import HeadComplexity.Results.FractionalNormalForm
import HeadComplexity.Results.RestrictionLowerBounds

set_option linter.style.header false

/-!
# Theorem 13: threshold degree is not head complexity

Define `f10` by the sign of

`Q(x,y) = (∑ i, x i) * (∑ j, y j) - 3 * ∑ i, x i * y i`

for two blocks of five signed Boolean variables. The explicit quadratic gives
`thresholdDeg f10 = 2`. Five antipodal slices force full rank in every cleared
quadratic sign representation, while two attention heads can produce rank at
most four. Consequently `3 ≤ HStar 10 f10`.

Theorem 13 reuses the fractional normal form, clears two positive denominators,
and applies a five-dimensional antipodal rank obstruction. The auxiliary theorem
`f10QInt_mod_four` proves nonvanishing analytically, without an exhaustive
Boolean-cube computation.
-/

namespace HeadComplexity

open MvPolynomial Finset
open AntipodalTwoProduct

/-- The first five coordinates of a ten-bit input. -/
private def f10Left (z : Fin 10 → Bool) (i : Fin 5) : Bool :=
  z (Fin.castAdd 5 i)

/-- The last five coordinates of a ten-bit input. -/
private def f10Right (z : Fin 10 → Bool) (i : Fin 5) : Bool :=
  z (Fin.natAdd 5 i)

/-- The ten-bit quadratic score
`(∑ xᵢ)(∑ yᵢ) - 3 ∑ xᵢyᵢ` in the `{±1}` encoding. -/
def f10Q (z : Fin 10 → Bool) : ℝ :=
  (∑ i : Fin 5, bitSign (f10Left z i)) *
      (∑ i : Fin 5, bitSign (f10Right z i)) -
    3 * ∑ i : Fin 5, bitSign (f10Left z i) * bitSign (f10Right z i)

/-- The Boolean function cut out by the positive values of `f10Q`. -/
noncomputable def f10 (z : Fin 10 → Bool) : Bool :=
  decide (0 < f10Q z)

/-- The affine polynomial representing one signed Boolean coordinate. -/
private noncomputable def f10SpinPoly (j : Fin 10) : MvPolynomial (Fin 10) ℝ :=
  C 1 - C 2 * X j

/-- The multivariate polynomial corresponding to `f10Q`. -/
private noncomputable def f10Poly : MvPolynomial (Fin 10) ℝ :=
  (∑ i : Fin 5, f10SpinPoly (Fin.castAdd 5 i)) *
      (∑ i : Fin 5, f10SpinPoly (Fin.natAdd 5 i)) -
    C 3 * ∑ i : Fin 5,
      f10SpinPoly (Fin.castAdd 5 i) * f10SpinPoly (Fin.natAdd 5 i)

private theorem eval_f10SpinPoly (z : Fin 10 → Bool) (j : Fin 10) :
    eval (cubePoint z) (f10SpinPoly j) = bitSign (z j) := by
  cases h : z j <;>
    norm_num [f10SpinPoly, bitSign, cubePoint, boolToReal, h]

private theorem eval_f10Poly (z : Fin 10 → Bool) :
    eval (cubePoint z) f10Poly = f10Q z := by
  simp [f10Poly, f10Q, f10Left, f10Right, eval_f10SpinPoly]

private theorem f10Poly_totalDegree_le : f10Poly.totalDegree ≤ 2 := by
  have hspin : ∀ j : Fin 10, (f10SpinPoly j).totalDegree ≤ 1 := by
    intro j
    exact totalDegree_parityFactor j
  have hleft :
      (∑ i : Fin 5, f10SpinPoly (Fin.castAdd 5 i)).totalDegree ≤ 1 :=
    totalDegree_finsetSum_le (fun i _ => hspin _)
  have hright :
      (∑ i : Fin 5, f10SpinPoly (Fin.natAdd 5 i)).totalDegree ≤ 1 :=
    totalDegree_finsetSum_le (fun i _ => hspin _)
  have hdiag :
      (∑ i : Fin 5,
        f10SpinPoly (Fin.castAdd 5 i) *
          f10SpinPoly (Fin.natAdd 5 i)).totalDegree ≤ 2 := by
    refine totalDegree_finsetSum_le (fun i _ => ?_)
    exact (totalDegree_mul _ _).trans (Nat.add_le_add (hspin _) (hspin _))
  refine (totalDegree_sub _ _).trans (max_le ?_ ?_)
  · exact (totalDegree_mul _ _).trans (Nat.add_le_add hleft hright)
  · refine (totalDegree_mul _ _).trans ?_
    rw [totalDegree_C, Nat.zero_add]
    exact hdiag

private theorem f10Poly_signRepresents : SignRepresents f10Poly f10 := by
  intro z
  rw [eval_f10Poly]
  simp [f10]

theorem f10_ThresholdDegLE_two : ThresholdDegLE f10 2 :=
  ⟨f10Poly, f10Poly_totalDegree_le, f10Poly_signRepresents⟩

/-- A two-dimensional face on which `f10` is XOR. -/
private def f10CheckerBase : Fin 10 → Bool :=
  ![false, false, false, true, true,
    false, false, true, false, true]

private theorem f10Q_checker (a b : Bool) :
    f10Q (Head.restrictBits f10CheckerBase 0 5 (a, b))
      = -2 * bitSign a * bitSign b := by
  let z := Head.restrictBits f10CheckerBase 0 5 (a, b)
  have hx : (fun i : Fin 5 => f10Left z i) =
      ![a, false, false, true, true] := by
    funext i
    fin_cases i <;>
      simp [z, f10Left, f10CheckerBase, Head.restrictBits, Fin.castAdd]
  have hy : (fun i : Fin 5 => f10Right z i) =
      ![b, false, true, false, true] := by
    funext i
    fin_cases i <;>
      simp [z, f10Right, f10CheckerBase, Head.restrictBits, Fin.natAdd]
  change (∑ i : Fin 5, bitSign (f10Left z i)) *
      (∑ i : Fin 5, bitSign (f10Right z i)) -
    3 * ∑ i : Fin 5, bitSign (f10Left z i) * bitSign (f10Right z i)
      = -2 * bitSign a * bitSign b
  simp_rw [congrFun hx, congrFun hy]
  fin_cases a <;> fin_cases b <;>
    norm_num [Fin.sum_univ_succ, bitSign]

private theorem f10_checkerboard :
    f10 (Head.restrictBits f10CheckerBase 0 5 (false, false)) = false ∧
    f10 (Head.restrictBits f10CheckerBase 0 5 (true, true)) = false ∧
    f10 (Head.restrictBits f10CheckerBase 0 5 (false, true)) = true ∧
    f10 (Head.restrictBits f10CheckerBase 0 5 (true, false)) = true := by
  constructor
  · norm_num [f10, f10Q_checker, bitSign]
  constructor
  · norm_num [f10, f10Q_checker, bitSign]
  constructor <;> norm_num [f10, f10Q_checker, bitSign]

private theorem f10_not_ThresholdDegLE_one : ¬ ThresholdDegLE f10 1 := by
  intro h
  obtain ⟨h00, h11, h01, h10⟩ := f10_checkerboard
  have hnot := parity_restriction_not_computable_with_one_head f10 f10CheckerBase
    0 5 (by decide) h00 h11 h01 h10
  exact hnot (computable_one_of_isLTF f10 ((ThresholdDegLE_one_iff_isLTF f10).mp h))

/-- The ten-bit counterexample has threshold degree exactly two. -/
theorem thresholdDeg_f10 : thresholdDeg f10 = 2 := by
  classical
  have hex : ∃ d, ThresholdDegLE f10 d := ⟨2, f10_ThresholdDegLE_two⟩
  rw [thresholdDeg, dif_pos hex]
  apply le_antisymm
  · exact Nat.find_min' hex f10_ThresholdDegLE_two
  · by_contra h
    have hfind : Nat.find hex ≤ 1 := by omega
    obtain ⟨P, hPdeg, hPsign⟩ := Nat.find_spec hex
    exact f10_not_ThresholdDegLE_one ⟨P, hPdeg.trans hfind, hPsign⟩

/-! ## The two-head obstruction -/

/-- Join two five-bit blocks into the ten-bit model input. -/
private def f10Join (x y : FiveBits) : Fin 10 → Bool :=
  fun i ↦ @Fin.addCases 5 5 (fun _ ↦ Bool) x y i

@[simp] private theorem f10Join_castAdd (x y : FiveBits) (i : Fin 5) :
    f10Join x y (Fin.castAdd 5 i) = x i := by
  simp [f10Join]

@[simp] private theorem f10Join_natAdd (x y : FiveBits) (i : Fin 5) :
    f10Join x y (Fin.natAdd 5 i) = y i := by
  exact Fin.addCases_right _

@[simp] private theorem f10Left_join (x y : FiveBits) : f10Left (f10Join x y) = x := by
  funext i
  simp [f10Left]

@[simp] private theorem f10Right_join (x y : FiveBits) : f10Right (f10Join x y) = y := by
  funext i
  exact f10Join_natAdd x y i

private theorem boolToReal_eq_bitSign (b : Bool) :
    boolToReal b = (1 - bitSign b) / 2 := by
  cases b <;> norm_num [boolToReal, bitSign]

/-- Re-express a degree-at-most-one polynomial as a centered affine form on
the two five-bit blocks. -/
private noncomputable def affinePolynomialToBiAffine
    (P : MvPolynomial (Fin 10) ℝ) : BiAffine where
  const := P.coeff 0
    + ∑ i : Fin 5, P.coeff (Finsupp.single (Fin.castAdd 5 i) 1) / 2
    + ∑ j : Fin 5, P.coeff (Finsupp.single (Fin.natAdd 5 j) 1) / 2
  xCoeff := fun i ↦ -P.coeff (Finsupp.single (Fin.castAdd 5 i) 1) / 2
  yCoeff := fun j ↦ -P.coeff (Finsupp.single (Fin.natAdd 5 j) 1) / 2

private theorem affinePolynomialToBiAffine_eval
    (P : MvPolynomial (Fin 10) ℝ) (hP : P.totalDegree ≤ 1)
    (x y : FiveBits) :
    (affinePolynomialToBiAffine P).eval x y =
      MvPolynomial.eval (cubePoint (f10Join x y)) P := by
  rw [eval_cubePoint_affine P hP]
  simp only [BiAffine.eval, affinePolynomialToBiAffine]
  rw [Fin.sum_univ_add (a := 5) (b := 5)]
  simp only [f10Join_castAdd, f10Join_natAdd]
  simp_rw [boolToReal_eq_bitSign]
  ring_nf
  simp only [Finset.sum_add_distrib]
  ring

/-- The concrete target viewed as a function of two five-bit blocks. -/
private noncomputable def f10Pair (x y : FiveBits) : Bool :=
  f10 (f10Join x y)

private theorem f10Q_join (x y : FiveBits) :
    f10Q (f10Join x y) =
      (∑ i, bitSign (x i)) * (∑ j, bitSign (y j)) -
        3 * ∑ i, bitSign (x i) * bitSign (y i) := by
  simp [f10Q, f10Left_join, f10Right_join]

/-! The following integer certificate replaces the finite Python check that the
quadratic never vanishes. The proof is the identity
`Q = 10 + 4 * (-A - B + A * B - 3 * C)`, where `A`, `B`, and `C` are integer
bit counts. -/

def bitSignInt (b : Bool) : ℤ := if b then -1 else 1

private def bitValueInt (b : Bool) : ℤ := if b then 1 else 0

private theorem bitSignInt_eq (b : Bool) :
    bitSignInt b = 1 - 2 * bitValueInt b := by
  cases b <;> rfl

def f10QInt (x y : FiveBits) : ℤ :=
  (∑ i, bitSignInt (x i)) * (∑ j, bitSignInt (y j)) -
    3 * ∑ i, bitSignInt (x i) * bitSignInt (y i)

/-- The integer score is always two modulo four. -/
theorem f10QInt_mod_four (x y : FiveBits) : f10QInt x y % 4 = 2 := by
  let A : ℤ := ∑ i, bitValueInt (x i)
  let B : ℤ := ∑ i, bitValueInt (y i)
  let C : ℤ := ∑ i, bitValueInt (x i) * bitValueInt (y i)
  have hx : (∑ i, bitSignInt (x i)) = 5 - 2 * A := by
    simp_rw [bitSignInt_eq]
    simp only [A, Finset.sum_sub_distrib, Finset.sum_const,
      Finset.card_univ, Fintype.card_fin]
    rw [← Finset.mul_sum]
    norm_num
  have hy : (∑ i, bitSignInt (y i)) = 5 - 2 * B := by
    simp_rw [bitSignInt_eq]
    simp only [B, Finset.sum_sub_distrib, Finset.sum_const,
      Finset.card_univ, Fintype.card_fin]
    rw [← Finset.mul_sum]
    norm_num
  have hxy : (∑ i, bitSignInt (x i) * bitSignInt (y i)) =
      5 - 2 * A - 2 * B + 4 * C := by
    calc
      (∑ i, bitSignInt (x i) * bitSignInt (y i)) =
          ∑ i, (1 - 2 * bitValueInt (x i) - 2 * bitValueInt (y i) +
            4 * (bitValueInt (x i) * bitValueInt (y i))) := by
        apply Finset.sum_congr rfl
        intro i _
        rw [bitSignInt_eq, bitSignInt_eq]
        ring
      _ = 5 - 2 * A - 2 * B + 4 * C := by
        simp only [A, B, C, Finset.sum_add_distrib, Finset.sum_sub_distrib,
          Finset.sum_const, Finset.card_univ, Fintype.card_fin]
        simp only [← Finset.mul_sum]
        norm_num
  have hformula : f10QInt x y =
      10 + 4 * (-A - B + A * B - 3 * C) := by
    rw [f10QInt, hx, hy, hxy]
    ring
  rw [hformula]
  omega

private theorem bitSignInt_cast (b : Bool) : ((bitSignInt b : ℤ) : ℝ) = bitSign b := by
  cases b <;> norm_num [bitSignInt, bitSign]

private theorem f10QInt_cast (x y : FiveBits) :
    ((f10QInt x y : ℤ) : ℝ) = f10Q (f10Join x y) := by
  rw [f10Q_join]
  simp [f10QInt, bitSignInt_cast]

private theorem f10Q_join_ne_zero (x y : FiveBits) : f10Q (f10Join x y) ≠ 0 := by
  intro hzero
  have hcast : ((f10QInt x y : ℤ) : ℝ) = 0 := by
    rw [f10QInt_cast, hzero]
  have hint : f10QInt x y = 0 := by
    exact_mod_cast hcast
  have hmod := f10QInt_mod_four x y
  rw [hint] at hmod
  norm_num at hmod

/-- The displayed quadratic is a strict sign representation on all 1,024 inputs. -/
theorem f10Q_ne_zero (z : Fin 10 → Bool) : f10Q z ≠ 0 := by
  have hjoin : f10Join (f10Left z) (f10Right z) = z := by
    change @Fin.addCases 5 5 (fun _ ↦ Bool)
      (fun i : Fin 5 ↦ z (Fin.castAdd 5 i))
      (fun j : Fin 5 ↦ z (Fin.natAdd 5 j)) = z
    exact Fin.addCases_castAdd_natAdd (m := 5) (n := 5) z
  simpa only [hjoin] using f10Q_join_ne_zero (f10Left z) (f10Right z)

private theorem f10Q_antipode_left (x y : FiveBits) :
    f10Q (f10Join (bitAntipode x) y) = -f10Q (f10Join x y) := by
  rw [f10Q_join, f10Q_join]
  simp only [bitSign_antipode, Finset.sum_neg_distrib, neg_mul]
  ring

private theorem f10Q_antipode_right (x y : FiveBits) :
    f10Q (f10Join x (bitAntipode y)) = -f10Q (f10Join x y) := by
  rw [f10Q_join, f10Q_join]
  simp only [bitSign_antipode, Finset.sum_neg_distrib, mul_neg]
  ring

private theorem f10Q_antipodalSlice (x : FiveBits) (j : Fin 5) :
    f10Q (f10Join x (antipodalSlice j)) = 6 * bitSign (x j) := by
  rw [f10Q_join]
  fin_cases j <;>
    simp [antipodalSlice, bitSign, Fin.sum_univ_succ] <;>
    ring_nf
  all_goals split <;> norm_num

private theorem f10Pair_hasFiveAntipodalSlices : HasFiveAntipodalSlices f10Pair := by
  intro x j
  have hq := f10Q_antipodalSlice x j
  constructor
  · unfold f10Pair f10
    rw [hq]
    cases hx : x j <;> norm_num [bitSign, hx]
  constructor
  · unfold f10Pair f10
    rw [f10Q_antipode_right, hq]
    cases hx : x j <;> norm_num [bitSign, hx]
  constructor
  · unfold f10Pair f10
    rw [f10Q_antipode_left, hq]
    cases hx : x j <;> norm_num [bitSign, hx]
  · unfold f10Pair f10
    rw [f10Q_antipode_left, f10Q_antipode_right, hq]
    cases hx : x j <;> norm_num [bitSign, hx]

/-- The five antipodal slices rule out every cleared two-product polynomial. -/
theorem f10_no_cleared_affine
    (L₁ R₁ L₂ R₂ : MvPolynomial (Fin 10) ℝ)
    (hL₁ : L₁.totalDegree ≤ 1) (hR₁ : R₁.totalDegree ≤ 1)
    (hL₂ : L₂.totalDegree ≤ 1) (hR₂ : R₂.totalDegree ≤ 1) :
    ¬ SignRepresents (L₁ * R₁ + L₂ * R₂) f10 := by
  intro hsign
  let L₁' := affinePolynomialToBiAffine L₁
  let R₁' := affinePolynomialToBiAffine R₁
  let L₂' := affinePolynomialToBiAffine L₂
  let R₂' := affinePolynomialToBiAffine R₂
  have hpair : ∀ x y,
      0 < twoProductScore L₁' R₁' L₂' R₂' x y ↔ f10Pair x y = true := by
    intro x y
    change 0 <
      (affinePolynomialToBiAffine L₁).eval x y *
          (affinePolynomialToBiAffine R₁).eval x y +
        (affinePolynomialToBiAffine L₂).eval x y *
          (affinePolynomialToBiAffine R₂).eval x y ↔
      f10 (f10Join x y) = true
    rw [affinePolynomialToBiAffine_eval L₁ hL₁,
      affinePolynomialToBiAffine_eval R₁ hR₁,
      affinePolynomialToBiAffine_eval L₂ hL₂,
      affinePolynomialToBiAffine_eval R₂ hR₂]
    simpa only [map_add, map_mul] using hsign (f10Join x y)
  exact (no_twoProduct_signRepresentation f10Pair f10Pair_hasFiveAntipodalSlices
    L₁' R₁' L₂' R₂') hpair

/-- Two fractional atoms cannot compute the concrete target. -/
theorem f10_not_fracComputable_two : ¬ fracComputable 10 2 f10 := by
  apply not_fracComputable_two_of_no_cleared_affine
  intro L₁ R₁ L₂ R₂ hL₁ hR₁ hL₂ hR₂ _hR₁pos _hR₂pos
  exact f10_no_cleared_affine L₁ R₁ L₂ R₂ hL₁ hR₁ hL₂ hR₂

/-- Two attention heads cannot compute the concrete target. -/
theorem f10_not_computableWithHeadsN_two : ¬ computableWithHeadsN 10 2 f10 := by
  rw [computableWithHeadsN_iff_fracComputable]
  exact f10_not_fracComputable_two

theorem HStar_f10_ge_two : 2 ≤ HStar 10 f10 := by
  obtain ⟨h00, h11, h01, h10⟩ := f10_checkerboard
  exact checkerboard_restriction_HStar_ge_two f10 f10CheckerBase
    0 5 (by decide) h00 h11 h01 h10

/-- The concrete target needs at least three attention heads. -/
theorem HStar_f10_ge_three : 3 ≤ HStar 10 f10 := by
  by_contra h
  have hge := HStar_f10_ge_two
  have heq : HStar 10 f10 = 2 := by omega
  exact f10_not_computableWithHeadsN_two (heq ▸ HStar_computable f10)

/-- Explicit strict separation between threshold degree and head complexity. -/
theorem f10_strict_separation : thresholdDeg f10 < HStar 10 f10 := by
  rw [thresholdDeg_f10]
  exact HStar_f10_ge_three

end HeadComplexity
