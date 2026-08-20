# One-Bit LTF Branching

## Statement

Let

$$ L(y)=\beta+\sum_{i\in S}\alpha_i y_i $$

be a strict affine sign representation of a Boolean function

$$ T:\lbrace0,1\rbrace^{m}\to\lbrace0,1\rbrace, \qquad T(y)=1 \Longleftrightarrow L(y)\gt0, $$

and assume $L(y)\neq0$ on the cube. Thus $T(y)=0$ if and only if $L(y)\lt0$. Assume $\alpha_i\neq0$ for $i\in S$. Let

$$ G:\lbrace0,1\rbrace^2\to\lbrace0,1\rbrace $$

be arbitrary, and define

$$ f(z,y):=G(z,T(y)). $$

Then

$$ H^{\ast}(f)\leq1+\lvert S\rvert. $$

In particular, if $\lvert S\rvert\leq1$, then

$$ H^{\ast}(f) = \begin{cases} 0 & \text{if } f \text{ is constant},\cr 1 & \text{if } f \text{ is a nonconstant linear threshold function},\cr 2 & \text{otherwise}. \end{cases} $$

> **Interpretation.** Branching on one raw bit between two labels determined by the same LTF costs at most one head plus the number of variables used by that LTF. This includes $z\wedge T(y)$, $z\vee T(y)$, $z\oplus T(y)$, and their complements.

## Proof

Split on the coordinate $z$. The two cofactors are

$$ f_0(y)=G(0,T(y)), \qquad f_1(y)=G(1,T(y)). $$

For each $b\in\lbrace0,1\rbrace$, the map $u\mapsto G(b,u)$ is a one-bit Boolean function. Hence $f_b$ is one of the four functions

$$ 0, \qquad 1, \qquad T, \qquad 1-T. $$

Choose affine sign representations as follows:

$$ -1 \quad\text{for the constant }0, \qquad 1 \quad\text{for the constant }1, \qquad L \quad\text{for }T, \qquad -L \quad\text{for }1-T. $$

The strictness of $L$ on the finite cube ensures that $-L$ strictly sign-represents $1-T$.

The slope vectors of any two choices in this list differ only on coordinates in $S$. Therefore their slope distance is at most

$$ \lvert S\rvert. $$

The LTF cofactor slope-distance theorem [076_ltf_cofactor_slope_distance.md](076_ltf_cofactor_slope_distance.md) gives

$$ H^{\ast}(f)\leq1+\lvert S\rvert. $$

If $\lvert S\rvert\leq1$, then the same theorem gives $H^{\ast}(f)\leq2$. The exact value is forced by the zero-head and one-head characterization [011_one_head_characterization.md](../01_foundations_and_normal_form/011_one_head_characterization.md): constants have value $0$, nonconstant LTFs have value $1$, and every remaining function has value exactly $2$. $\blacksquare$

## Consequences

The XOR-with-an-LTF family satisfies

$$ H^{\ast}(z\oplus T(y))\leq1+\lvert\mathrm{supp}(L)\rvert. $$

When $T$ is a single input bit, this recovers the exact two-head $\mathrm{XOR}_2$ case. More generally, the theorem gives a simple bound for every two-variable outer Boolean gate applied to one raw coordinate and one LTF feature.
