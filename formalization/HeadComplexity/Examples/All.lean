import HeadComplexity.Examples.OneHead
import HeadComplexity.Examples.TwoHeads
import HeadComplexity.Examples.BooleanFunctions

set_option linter.style.header false

/-!
# Examples umbrella.

This module collects the endpoint examples. The imported modules contain the
supporting constructions and helper theorems; the aliases below are the public
example-facing table of contents.
-/

namespace HeadComplexity

/-- **Example 1.** No single head computes XOR from the residual stream. -/
alias example1_one_head_cannot_xor := one_head_cannot_xor_residual

/-- **Example 2.** The explicit two-head construction computes XOR. -/
alias example2_two_heads_compute_xor := two_heads_suffice

/-- **Example 3.** The constantly-false function has head complexity `0`. -/
alias example3_HStar_false := HStar_false

/-- **Example 4.** The constantly-true function has head complexity `0`. -/
alias example4_HStar_true := HStar_true

/-- **Example 5.** `OR` has head complexity `1`. -/
alias example5_HStar_or := HStar_or

/-- **Example 6.** `AND` has head complexity `1`. -/
alias example6_HStar_and := HStar_and

/-- **Example 7.** `NOR` has head complexity `1`. -/
alias example7_HStar_nor := HStar_nor

/-- **Example 8.** `NAND` has head complexity `1`. -/
alias example8_HStar_nand := HStar_nand

/-- **Example 9.** `XOR` has head complexity `2`. -/
alias example9_HStar_xor := HStar_xor

/-- **Example 10.** `XNOR` has head complexity `2`. -/
alias example10_HStar_xnor := HStar_xnor

/-- **Example 11.** Every symmetric two-bit Boolean function has the listed exact
head complexity. -/
alias example11_HStar_symmFn := HStar_symmFn

end HeadComplexity
