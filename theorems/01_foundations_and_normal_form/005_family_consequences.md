# Consequences For Standard Function Families

This note packages the lower bound from [003_checkerboard_obstruction.md](003_checkerboard_obstruction.md), the upper bound from [004_symmetric_thresholds.md](004_symmetric_thresholds.md), and the later exact symmetric characterization from [012_symmetric_sign_changes.md](012_symmetric_sign_changes.md), all in the formal model from [../model.md](../../model.md).

We write $H^{\ast}(f)$ for the minimum number of heads needed to compute $f : \lbrace0,1\rbrace^n \to \lbrace0,1\rbrace$ in the one-layer attention model.

## Theorem 1. Symmetric Thresholds Have Exact Head Complexity 1

For $1 \leq t \leq n$,

$$ T_{n,t}(x)  =  \mathbf{1} \left[ \lvert x\rvert \geq t \right] $$

satisfies

$$ H^{\ast}(T_{n,t})  =  1. $$

### Special cases

1. $H^{\ast}(\mathrm{OR}_n) = 1$,
2. $H^{\ast}(\mathrm{AND}_n) = 1$,
3. $H^{\ast}(\mathrm{MAJORITY}_n) = 1$.

The proof is exactly the one-head construction from the previous note, together with the trivial fact that zero heads only produce constant outputs.

## Theorem 2. Parity Has Exact Head Complexity n

For $n \geq 2$, define

$$ \mathrm{PARITY}_n(x)  =  x_1 \oplus x_2 \oplus \cdots \oplus x_n. $$

Then the exact value is

$$ H^{\ast}(\mathrm{PARITY}_n) = n. $$

The lower-bound proof below still gives the first nontrivial obstruction, namely $H^{\ast}(\mathrm{PARITY}_n) \geq 2$. The exact value follows from the symmetric sign-change theorem, since parity changes value between every pair of adjacent Hamming weights.

**Checkerboard proof of the first lower bound.** Fix coordinates $i \neq j$, and fix every other coordinate to $0$. On the remaining two free bits $(a,b)$, the parity function becomes

$$ \mathrm{PARITY}_n(\ldots, a, \ldots, b, \ldots)  =  a \oplus b. $$

So the restricted truth table is

$$ 0,   1,   1,   0, $$

which is exactly the checkerboard pattern. By the checkerboard restriction lower bound, one head is impossible. Since parity is nonconstant, zero heads are also impossible. Hence $H^{\ast}(\mathrm{PARITY}_n) \geq 2$. $\blacksquare$

## Theorem 3. Internal Exact-Count Functions Have Exact Head Complexity 2

For $0 \leq k \leq n$, define

$$ \mathrm{EXACT}_{n,k}(x)  =  \mathbf{1} \left[ \lvert x\rvert = k \right]. $$

Then for every internal count $1 \leq k \leq n-1$,

$$ H^{\ast}(\mathrm{EXACT}_{n,k}) = 2. $$

The upper bound follows from the symmetric sign-change theorem, because the Hamming-weight sequence for $\mathrm{EXACT}_{n,k}$ has two sign changes when $1 \leq k \leq n - 1$. The checkerboard proof below gives the matching lower bound.

**Checkerboard proof of the lower bound.** Fix two free coordinates $i \neq j$. Set exactly $k - 1$ of the remaining coordinates to $1$ and the rest to $0$. This is possible because $1 \leq k \leq n - 1$.

Now evaluate $\mathrm{EXACT}_{n,k}$ on the two free bits:

1. $(0,0)$ gives total weight $k-1$, so the output is $0$.
2. $(0,1)$ gives total weight $k$, so the output is $1$.
3. $(1,0)$ gives total weight $k$, so the output is $1$.
4. $(1,1)$ gives total weight $k+1$, so the output is $0$.

Thus the restriction is again

$$ 0,   1,   1,   0. $$

So one head is impossible by the checkerboard lower bound, and therefore $H^{\ast}(\mathrm{EXACT}_{n,k}) \geq 2$. $\blacksquare$

## Edge Cases Of Exact Count

The edge cases are different:

1. $\mathrm{EXACT}_{n,0}$ is the predicate *all bits are zero*. This is a threshold of Hamming weight from below, so it is computable with one head by flipping the probe sign in the symmetric-threshold construction.
2. $\mathrm{EXACT}_{n,n}$ is exactly $\mathrm{AND}_n$, so it has head complexity $1$.

So the internal exact-count predicates have exact head complexity $2$.

## Current Picture For Symmetric Families

The symmetric sign-change theorem gives the complete picture.

1. Constant functions have head complexity $0$.
2. Symmetric threshold functions have head complexity $1$.
3. Internal exact-count functions have head complexity $2$.
4. Parity has head complexity $n$.
5. In general, a symmetric function has head complexity equal to the number of sign changes in its Hamming-weight truth table.

This already answers part of the *natural families* question from the problem statement.

## What Remains Open

These notes determine the symmetric families, but they do not determine whether there is a single invariant that captures nonsymmetric functions as well.

So the current evidence is enough to characterize the symmetric hierarchy exactly. The remaining gap is to find the right nonsymmetric analogue.
