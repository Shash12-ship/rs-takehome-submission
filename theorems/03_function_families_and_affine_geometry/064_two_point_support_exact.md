# Two-Point Supports Use At Most Two Heads

## Statement

Let

$$ f:\lbrace0,1\rbrace^n\to\lbrace0,1\rbrace $$

and define

$$ s(f):=\min\lbrace\lvert f^{-1}(1)\rvert,\lvert f^{-1}(0)\rvert\rbrace. $$

If

$$ s(f)\leq2, $$

then

$$ H^{\ast}(f)\leq2. $$

More precisely,

$$ H^{\ast}(f) = \begin{cases} 0 & \text{if } f \text{ is constant},\cr 1 & \text{if } f \text{ is a nonconstant linear threshold function},\cr 2 & \text{otherwise}. \end{cases} $$

> **Interpretation.** The sparse-support upper bound gives $H^{\ast}(f)\leq2s(f)$. The first nontrivial sparse case is sharper: one or two exceptional points always cost at most two heads.

## Proof

By complement invariance [028_restrictions_and_sign_rank.md](../02_complexity_measure_upper_bounds/028_restrictions_and_sign_rank.md), it is enough to handle the case

$$ \lvert f^{-1}(1)\rvert\leq2. $$

If $f^{-1}(1)$ is empty, then $f$ is constant. If $f^{-1}(1)=\lbrace p\rbrace$, then the singleton indicator is a linear threshold function:

$$ \mathbf{1}[x=p]=1 \qquad\Longleftrightarrow\qquad \sum_{i:p_i=1}x_i+\sum_{i:p_i=0}(1-x_i)\gt n-\frac{1}{2}. $$

Thus $H^{\ast}(f)\leq1$ in the singleton case.

It remains to handle

$$ f^{-1}(1)=\lbrace p,q\rbrace, \qquad p\neq q. $$

If $n=1$, then $\lbrace p,q\rbrace=\lbrace0,1\rbrace$ and $f$ is constant. Assume $n\geq2$.

Let

$$ v:=q-p\in\mathbb{R}^n $$

and consider the linear subspace

$$ U:=\lbrace a\in\mathbb{R}^n:a\cdot v=0\rbrace. $$

For each cube point

$$ r\in\lbrace0,1\rbrace^n\setminus\lbrace p,q\rbrace, $$

the set

$$ H_r:=\lbrace a\in U:a\cdot(r-p)=0\rbrace $$

is a proper hyperplane in $U$. Indeed, if $H_r=U$, then $r-p$ is orthogonal to all of $U$, so $r-p$ lies in the one-dimensional space spanned by $v$. Thus

$$ r=p+\lambda(q-p) $$

for some real $\lambda$. Looking coordinatewise on any coordinate where $p$ and $q$ differ, the Boolean condition $r_i\in\lbrace0,1\rbrace$ forces $\lambda\in\lbrace0,1\rbrace$. Then $r=p$ or $r=q$, a contradiction.

A finite union of proper hyperplanes cannot cover $U$. Choose

$$ a\in U\setminus\bigcup_{r\neq p,q}H_r. $$

Define the affine function

$$ L(x):=a\cdot(x-p). $$

Then

$$ L(p)=0, \qquad L(q)=a\cdot(q-p)=a\cdot v=0, $$

while for every other cube point $r$,

$$ L(r)=a\cdot(r-p)\neq0. $$

Therefore

$$ f(x)=\mathbf{1}[L(x)=0]. $$

The affine level-set theorem [061_affine_level_set_upper_bound.md](061_affine_level_set_upper_bound.md) gives

$$ H^{\ast}(f)\leq2. $$

Returning through complement invariance proves the same upper bound whenever $s(f)\leq2$.

Finally, the exact case split follows from the zero-head and one-head characterization [011_one_head_characterization.md](../01_foundations_and_normal_form/011_one_head_characterization.md): constants have value $0$, nonconstant LTFs have value $1$, and every nonconstant non-LTF needs at least two heads. Together with the two-head upper bound, this proves the statement. $\blacksquare$

## Consequence

For every nonconstant function whose smaller label class has size two, the only remaining question is whether that two-point support is linearly separable from its complement. If not, its exact value is

$$ H^{\ast}(f)=2. $$

In particular, sparse rare-event functions start with the exact sequence

$$ s(f)=1 \Longrightarrow H^{\ast}(f)=1, \qquad s(f)=2 \Longrightarrow H^{\ast}(f)\leq2. $$
