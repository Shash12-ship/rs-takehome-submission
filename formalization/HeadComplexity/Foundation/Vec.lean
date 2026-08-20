import Mathlib.Analysis.InnerProductSpace.PiL2
import Mathlib.Analysis.Convex.Segment
import Mathlib.Analysis.SpecialFunctions.Exp
import Mathlib.Analysis.Complex.Exponential
import Mathlib.Data.Matrix.Mul
import Mathlib.LinearAlgebra.Matrix.ToLin

set_option linter.style.header false

/-!
# Shared definitions for the head-complexity formalization.

This file provides common imports and the `Vec` abbreviation used
throughout the project.
-/

namespace HeadComplexity

/-- The standard `d`-dimensional real inner product space. -/
abbrev Vec (d : ℕ) : Type := EuclideanSpace ℝ (Fin d)

end HeadComplexity
