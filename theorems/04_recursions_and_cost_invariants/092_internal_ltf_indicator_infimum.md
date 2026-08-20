# Internal LTF Indicator Infimum

## Statement

Let

$$ T(x_1,x_2,x_3):=x_1\wedge(x_2\vee x_3). $$

Then the best uniform approximation error of $T$ by a single one-head atom has infimum exactly

$$ \frac{1}{4}. $$

More explicitly,

$$ \inf_{\phi} \max_{x\in\lbrace0,1\rbrace^3}\lvert \phi(x)-T(x)\rvert = \frac{1}{4}, $$

where $\phi$ ranges over one-head atoms.

> **Interpretation.** The $1/4$ obstruction for the internal LTF $x_1\wedge(x_2\vee x_3)$ is sharp. The obstruction is not a loose proof artifact; it is the exact one-atom approximation barrier.

## Proof

The lower bound is Lemma 91: every one-head atom has uniform error at least $1/4$ against $T$.

It remains to construct one-head atoms with error arbitrarily close to $1/4$. Fix

$$ 0\lt\tau\lt\frac{1}{8}, $$

and define

$$ B_{\tau}(x) := 2-x_1-\tau x_2-\tau x_3, $$

and

$$ A(x) := -\frac{1}{2} +\frac{3}{4}x_1 +\frac{1}{2}x_2 +\frac{1}{2}x_3. $$

Since $B_{\tau}$ has strictly negative variable coefficients and

$$ 2\gt1+2\tau, $$

the denominator-orientation theorem makes

$$ \phi_{\tau}(x):=\frac{A(x)}{B_{\tau}(x)} $$

a one-head atom.

Now evaluate the eight cube points. On false inputs,

$$ \begin{array}{c|c|c} x & A(x) & B_{\tau}(x) \cr \hline (0,0,0) & -1/2 & 2 \cr (0,0,1) & 0 & 2-\tau \cr (0,1,0) & 0 & 2-\tau \cr (0,1,1) & 1/2 & 2-2\tau \cr (1,0,0) & 1/4 & 1 \end{array} $$

Thus the false-input errors are at most

$$ \max\left\lbrace \frac{1}{4}, \frac{1}{4(1-\tau)} \right\rbrace = \frac{1}{4(1-\tau)}. $$

On true inputs,

$$ \begin{array}{c|c|c} x & A(x) & B_{\tau}(x) \cr \hline (1,0,1) & 3/4 & 1-\tau \cr (1,1,0) & 3/4 & 1-\tau \cr (1,1,1) & 5/4 & 1-2\tau \end{array} $$

For the first two true inputs,

$$ \left\lvert \frac{3}{4(1-\tau)}-1 \right\rvert = \frac{1-4\tau}{4(1-\tau)} \leq \frac{1}{4}. $$

For the last true input,

$$ \left\lvert \frac{5}{4(1-2\tau)}-1 \right\rvert = \frac{1+8\tau}{4(1-2\tau)}. $$

Therefore

$$ \max_x\lvert \phi_{\tau}(x)-T(x)\rvert \leq \frac{1+8\tau}{4(1-2\tau)}. $$

Letting $\tau\to0^{+}$ gives

$$ \inf_{\phi} \max_x\lvert \phi(x)-T(x)\rvert \leq \frac{1}{4}. $$

Together with Lemma 91, this proves the equality. $\blacksquare$

## Consequence

The finite LP diagnostic for LTF indicator approximation is detecting the real atom geometry on this example. Its value near $1/4$ is not merely numerical slack; it is the exact limiting error for one atom.
