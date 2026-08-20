import HeadComplexity.Model.SkipConnection

set_option linter.style.header false

/-!
# Two-bit example helpers.

The examples use the `Head` model directly.  This file keeps only
the lightweight two-bit notation: named Boolean functions on `Fin 2 → Bool` and
the XOR-specific readout predicate used by the endpoint examples.
-/

namespace HeadComplexity

/-- The two-bit input with first bit `a` and second bit `b`. -/
def bits2 (a b : Bool) : Fin 2 → Bool
  | 0 => a
  | 1 => b

@[simp] theorem bits2_zero (a b : Bool) : bits2 a b 0 = a := rfl
@[simp] theorem bits2_one (a b : Bool) : bits2 a b 1 = b := rfl

/-- The standard two-coordinate restriction of a 2-bit input is `bits2`. -/
theorem restrictBits_zero_one (a b : Bool) :
    Head.restrictBits (fun _ : Fin 2 => false) 0 1 (a, b) = bits2 a b := by
  funext i
  fin_cases i <;> simp [Head.restrictBits, bits2]

/-- XOR on two generalized-model input bits. -/
def xorFn : (Fin 2 → Bool) → Bool := fun bits => xor (bits 0) (bits 1)

/-- A vector-valued two-bit function computes XOR under a linear readout. -/
def computesXor {d : ℕ} (g : (Fin 2 → Bool) → Vec d) : Prop :=
  computesPred xorFn g

@[simp] theorem xorFn_bits2 (a b : Bool) :
    xorFn (bits2 a b) = xor a b := rfl

end HeadComplexity
