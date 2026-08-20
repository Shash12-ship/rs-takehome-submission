# Three-Bit Threshold-Vote Match

## Statement

For a Boolean function $f:\lbrace0,1\rbrace^n\to\lbrace0,1\rbrace$, define $s_{\mathrm{LTF}}(f)$ to be the least $s$ such that there are linear threshold functions

$$ T_1,\ldots,T_s:\lbrace0,1\rbrace^n\to\lbrace0,1\rbrace $$

and real coefficients $c_0,c_1,\ldots,c_s$ with

$$ f(x)=1 \qquad\Longleftrightarrow\qquad c_0+\sum_{j=1}^{s}c_jT_j(x)\gt0 $$

for every $x\in\lbrace0,1\rbrace^n$. For $s=0$, this means that $f$ is constant.

Then for every three-bit Boolean function

$$ f:\lbrace0,1\rbrace^3\to\lbrace0,1\rbrace, $$

we have

$$ s_{\mathrm{LTF}}(f)=H^{\ast}(f)=\deg_{\pm}(f). $$

More explicitly:

$$ s_{\mathrm{LTF}}(f) = \begin{cases} 0 & \text{if } f \text{ is constant},\cr 1 & \text{if } f \text{ is a nonconstant linear threshold function},\cr 3 & \text{if } f \text{ is parity or anti-parity},\cr 2 & \text{otherwise}. \end{cases} $$

> **Interpretation.** Threshold-vote size agrees exactly with $H^{\ast}$ throughout the first nontrivial classified cube. This is a finite match, not a global characterization.

## Proof

### Lemma 1. Finite two-vote certificate

The finite enumeration in `src/hstar/threshold_votes.py` checks the following exact objects.

First, it tests each three-bit truth table for strict affine separability by solving the homogeneous margin feasibility problem

$$ y_x\left(a_0+\sum_{i=1}^{3}a_ix_i\right)\geq1 \qquad \text{for every }x\in\lbrace0,1\rbrace^3, $$

where $y_x=+1$ on true inputs and $y_x=-1$ on false inputs. This identifies the $104$ three-bit linear threshold truth tables, including the two constants.

Second, it enumerates all unordered pairs $T_1,T_2$ of nonconstant three-bit linear threshold truth tables and all $14$ two-bit outer linear threshold functions $G$. For each choice it records the composed table

$$ x\mapsto G(T_1(x),T_2(x)). $$

Running

```bash
python -m src.hstar.threshold_votes
```

returns

```json
{
  "n_bits": 3,
  "three_bit_ltf_count": 104,
  "nonconstant_three_bit_ltf_count": 102,
  "two_bit_outer_ltf_count": 14,
  "covered_by_two_votes_or_less": 254,
  "missing_from_two_votes_or_less": [
    "01101001",
    "10010110"
  ],
  "parity": "01101001",
  "anti_parity": "10010110",
  "missing_are_exactly_parity_and_anti_parity": true
}
```

Thus every three-bit function except parity and anti-parity has threshold-vote size at most $2$, while parity and anti-parity have threshold-vote size at least $3$.

### Lemma 2. Three votes compute parity and anti-parity

For $j=1,2,3$, let

$$ A_j(x):=\mathbf{1}[\lvert x\rvert\geq j]. $$

Each $A_j$ is a linear threshold function. On Hamming weights $0,1,2,3$, the score

$$ S(x):=-\frac{1}{2}+A_1(x)-2A_2(x)+2A_3(x) $$

takes the values

$$ -\frac{1}{2},\quad \frac{1}{2},\quad -\frac{3}{2},\quad \frac{1}{2}. $$

Therefore $S(x)\gt0$ exactly on odd Hamming weight inputs, so

$$ s_{\mathrm{LTF}}(\mathrm{XOR}_3)\leq3. $$

Flipping the final threshold sign gives anti-parity with the same number of votes.

Together with Lemma 1,

$$ s_{\mathrm{LTF}}(\mathrm{XOR}_3) = s_{\mathrm{LTF}}(1-\mathrm{XOR}_3) =3. $$

### Conclusion

Constants have $s_{\mathrm{LTF}}=0$. Nonconstant linear threshold functions have $s_{\mathrm{LTF}}=1$, and no non-LTF can have threshold-vote size $1$.

By Lemma 1 and Lemma 2, every remaining non-parity three-bit function has threshold-vote size exactly $2$, while parity and anti-parity have threshold-vote size exactly $3$.

The exact three-bit classification [016_three_bit_exact_classification.md](../01_foundations_and_normal_form/016_three_bit_exact_classification.md) gives

$$ H^{\ast}(f)=\deg_{\pm}(f) $$

for every three-bit Boolean function. The top threshold-degree theorem [027_top_threshold_degree.md](../01_foundations_and_normal_form/027_top_threshold_degree.md) identifies parity and anti-parity as the only three-bit functions of threshold degree $3$. Threshold degree $1$ is exactly the nonconstant LTF case, and the one-head theorem [011_one_head_characterization.md](../01_foundations_and_normal_form/011_one_head_characterization.md) gives the same $H^{\ast}$ value on that class. Therefore the case split above matches the $H^{\ast}$ case split exactly:

$$ s_{\mathrm{LTF}}(f)=H^{\ast}(f)=\deg_{\pm}(f). $$

$\blacksquare$
