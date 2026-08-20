# Affine Hull Clean Supports Use At Most Two Heads

## Statement

Let

$$ A\subseteq\lbrace0,1\rbrace^n $$

be nonempty. Write $\mathrm{aff}(A)$ for the affine hull of $A$ in $\mathbb{R}^n$.

Call $A$ *affine hull clean* if

$$ \mathrm{aff}(A)\cap\lbrace0,1\rbrace^n=A. $$

Suppose $f:\lbrace0,1\rbrace^n\to\lbrace0,1\rbrace$ has a label class $A$ such that:

1. $A$ is affine hull clean.
2. $\mathrm{aff}(A)\neq\mathbb{R}^n$.

Then

$$ H^{\ast}(f)\leq2. $$

More precisely,

$$ H^{\ast}(f) = \begin{cases} 0 & \text{if } f \text{ is constant},\cr 1 & \text{if } f \text{ is a nonconstant linear threshold function},\cr 2 & \text{otherwise}. \end{cases} $$

> **Interpretation.** A label class is two-head easy whenever it is exactly the cube slice cut out by its own proper affine hull. The proof turns that affine hull into one affine level set, then invokes the affine level-set theorem.

## Proof

By complement invariance [028_restrictions_and_sign_rank.md](../02_complexity_measure_upper_bounds/028_restrictions_and_sign_rank.md), it is enough to handle the case

$$ f^{-1}(1)=A. $$

Let

$$ W:=\mathrm{aff}(A). $$

By assumption, $W$ is a proper affine subspace of $\mathbb{R}^n$. Let $\mathcal{L}_W$ be the real vector space of affine functions that vanish on $W$:

$$ \mathcal{L}_W := \lbrace L:\mathbb{R}^n\to\mathbb{R}\text{ affine}:L(w)=0\text{ for every }w\in W\rbrace. $$

Since $W$ is proper, $\mathcal{L}_W$ is nonzero.

For each cube point

$$ r\in\lbrace0,1\rbrace^n\setminus A, $$

the set

$$ \mathcal{H}_r := \lbrace L\in\mathcal{L}_W:L(r)=0\rbrace $$

is a proper hyperplane in $\mathcal{L}_W$. Indeed, $A$ is affine hull clean, so $r\notin W$. Since $r\notin W$, there exists an affine function vanishing on $W$ but not on $r$, which means the evaluation map $L\mapsto L(r)$ is not identically zero on $\mathcal{L}_W$.

A finite union of proper hyperplanes cannot cover the real vector space $\mathcal{L}_W$. Choose

$$ L\in\mathcal{L}_W\setminus\bigcup_{r\notin A}\mathcal{H}_r. $$

Then $L$ vanishes on $A$, because $A\subseteq W$, and $L$ is nonzero at every cube point outside $A$. Therefore

$$ A=\lbrace x\in\lbrace0,1\rbrace^n:L(x)=0\rbrace. $$

Hence

$$ f(x)=\mathbf{1}[L(x)=0]. $$

The affine level-set theorem [061_affine_level_set_upper_bound.md](061_affine_level_set_upper_bound.md) gives

$$ H^{\ast}(f)\leq2. $$

The exact case split follows from the zero-head and one-head characterization [011_one_head_characterization.md](../01_foundations_and_normal_form/011_one_head_characterization.md): constants have value $0$, nonconstant LTFs have value $1$, and nonconstant non-LTFs need at least two heads. Together with the two-head upper bound, this proves the statement. $\blacksquare$

## Consequence

The two-point support theorem [064_two_point_support_exact.md](064_two_point_support_exact.md) is a special case. If $p\neq q$ are cube vertices, then the line through $p$ and $q$ contains no other cube vertex. Indeed, any Boolean point on that line has the form

$$ p+\lambda(q-p), $$

and any coordinate where $p$ and $q$ differ forces $\lambda\in\lbrace0,1\rbrace$.

Thus every one-point or two-point label class is affine hull clean. More generally, any proper cube slice that is exactly the intersection of the cube with an affine subspace is a two-head predicate, unless it is already constant or one-head.
