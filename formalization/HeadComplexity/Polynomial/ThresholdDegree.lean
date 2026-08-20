import HeadComplexity.BooleanCube.SymmetricSignChanges
import Mathlib.Algebra.MvPolynomial.Degrees
import Mathlib.Algebra.MvPolynomial.CommRing

set_option linter.style.header false

/-!
# Threshold (sign-representation) degree on the Boolean cube.

Foundation for the Theorem 12 lower bound `H^{*}(f) ≥ C(F)`. We encode a Boolean
function `f : (Fin n → Bool) → Bool` and ask for a real polynomial whose sign
matches `f` at every cube point; the least total degree of such a polynomial is
the threshold degree. The lower-bound chain is:

`computableWithHeadsN n H f  ⇒  ThresholdDegLE f H`  (each head clears to a
degree-≤1 affine ratio; `H` heads to a degree-≤H polynomial), and for symmetric
`f`, `ThresholdDegLE f H ⇒ signChanges ≤ H`.
-/

namespace HeadComplexity

open MvPolynomial

variable {n : ℕ}

/-- Embed a Boolean coordinate into `ℝ` (`false ↦ 0`, `true ↦ 1`). -/
def boolToReal (b : Bool) : ℝ := if b then 1 else 0

/-- The real point of the cube corresponding to a Boolean assignment. -/
def cubePoint (x : Fin n → Bool) : Fin n → ℝ := fun i => boolToReal (x i)

/-- `P` sign-represents `f` on the cube: its value is positive exactly where `f`
is true. -/
def SignRepresents (P : MvPolynomial (Fin n) ℝ) (f : (Fin n → Bool) → Bool) : Prop :=
  ∀ x : Fin n → Bool, (0 < eval (cubePoint x) P ↔ f x = true)

/-- `f` has threshold degree at most `d`. -/
def ThresholdDegLE (f : (Fin n → Bool) → Bool) (d : ℕ) : Prop :=
  ∃ P : MvPolynomial (Fin n) ℝ, P.totalDegree ≤ d ∧ SignRepresents P f

end HeadComplexity
