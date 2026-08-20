# Internal LTF Indicator Obstruction

## Statement

Define

$$ T(x_1,x_2,x_3) := x_1\wedge(x_2\vee x_3). $$

Equivalently,

$$ T(x)=1 \qquad\Longleftrightarrow\qquad 2x_1+x_2+x_3\geq3. $$

Thus $T$ is a monotone linear threshold function. Nevertheless, for every one-head atom $\phi$ on $\lbrace0,1\rbrace^3$,

$$ \max_{x\in\lbrace0,1\rbrace^3}\lvert \phi(x)-T(x)\rvert \geq \frac{1}{4}. $$

Consequently, not every LTF indicator admits arbitrarily accurate one-head atom approximations.

> **Interpretation.** One head can compute every LTF after applying a final threshold, but the raw one-head score need not approximate the LTF's $0/1$ indicator. This is the calibrated-indicator obstruction left by the decision-list and threshold-vote theorems.

## Proof

Let

$$ \phi(x)=\frac{A(x)}{B(x)} $$

be a one-head atom, where $A$ and $B$ are affine and $B(x)\gt0$ on the cube. By denominator orientation, either $B$ is constant, or all variable coefficients of $B$ have the same sign.

Suppose

$$ \lvert \phi(x)-T(x)\rvert\leq\epsilon \qquad \text{for every }x. $$

We prove $\epsilon\geq1/4$.

### Lemma 1. AND slice lower bound

On the slice $x_3=0$, the function $T$ is the two-bit AND of $x_1$ and $x_2$. Write

$$ B_{ab}:=B(a,b,0), \qquad A_{ab}:=A(a,b,0). $$

The affine identity on this square gives

$$ A_{00}+A_{11}=A_{01}+A_{10}, \qquad B_{00}+B_{11}=B_{01}+B_{10}. $$

The point $(1,1,0)$ is true, while the other three points on the slice are false. Hence

$$ A_{11}\geq(1-\epsilon)B_{11}, \qquad A_{00}\geq-\epsilon B_{00}, $$

and

$$ A_{01}\leq\epsilon B_{01}, \qquad A_{10}\leq\epsilon B_{10}. $$

Therefore

$$ \begin{aligned} (1-\epsilon)B_{11}-\epsilon B_{00} &\leq A_{11}+A_{00} \cr &= A_{01}+A_{10} \cr &\leq \epsilon(B_{01}+B_{10}). \end{aligned} $$

Using $B_{01}+B_{10}=B_{00}+B_{11}$, we get

$$ B_{11} \leq 2\epsilon(B_{00}+B_{11}). $$

Thus

$$ \epsilon \geq \frac{B(1,1,0)}{2(B(0,0,0)+B(1,1,0))}. $$

### Lemma 2. OR slice lower bound

On the slice $x_1=1$, the function $T$ is the two-bit OR of $x_2$ and $x_3$. Write

$$ \widetilde B_{ab}:=B(1,a,b), \qquad \widetilde A_{ab}:=A(1,a,b). $$

The affine identity on this square gives

$$ \widetilde A_{00}+\widetilde A_{11} = \widetilde A_{01}+\widetilde A_{10}, \qquad \widetilde B_{00}+\widetilde B_{11} = \widetilde B_{01}+\widetilde B_{10}. $$

The point $(1,0,0)$ is false, while the other three points on the slice are true. Hence

$$ \widetilde A_{00}\leq\epsilon\widetilde B_{00}, \qquad \widetilde A_{11}\leq(1+\epsilon)\widetilde B_{11}, $$

and

$$ \widetilde A_{01}\geq(1-\epsilon)\widetilde B_{01}, \qquad \widetilde A_{10}\geq(1-\epsilon)\widetilde B_{10}. $$

Therefore

$$ \begin{aligned} \epsilon\widetilde B_{00}+(1+\epsilon)\widetilde B_{11} &\geq \widetilde A_{00}+\widetilde A_{11} \cr &= \widetilde A_{01}+\widetilde A_{10} \cr &\geq (1-\epsilon)(\widetilde B_{01}+\widetilde B_{10}). \end{aligned} $$

Using $\widetilde B_{01}+\widetilde B_{10}=\widetilde B_{00}+\widetilde B_{11}$, we get

$$ \widetilde B_{00} \leq 2\epsilon(\widetilde B_{00}+\widetilde B_{11}). $$

Thus

$$ \epsilon \geq \frac{B(1,0,0)}{2(B(1,0,0)+B(1,1,1))}. $$

### Conclusion

If $B$ has positive orientation, then

$$ B(1,1,0)\geq B(0,0,0). $$

The AND-slice bound gives

$$ \epsilon \geq \frac{B(1,1,0)}{2(B(0,0,0)+B(1,1,0))} \geq \frac{1}{4}. $$

If $B$ has negative orientation, then

$$ B(1,1,1)\leq B(1,0,0). $$

The OR-slice bound gives

$$ \epsilon \geq \frac{B(1,0,0)}{2(B(1,0,0)+B(1,1,1))} \geq \frac{1}{4}. $$

If $B$ is constant, either displayed argument gives $\epsilon\geq1/4$. Hence every one-head atom has uniform error at least $1/4$ against $T$. $\blacksquare$

## Consequences

The calibrated threshold-vote and calibrated decision-list theorems cannot be turned into unconditional theorems for arbitrary LTF gates by independently replacing each LTF gate with one approximate indicator atom.

The obstruction is not that $T$ is hard to compute with one head: $T$ is itself an LTF, so $H^{\ast}(T)=1$. The obstruction is that the final threshold in the one-head computation is doing essential work.
