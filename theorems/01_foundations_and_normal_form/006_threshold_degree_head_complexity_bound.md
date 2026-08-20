# Threshold Degree Is Bounded By Head Complexity

## Statement

If a Boolean function $f : \lbrace0,1\rbrace^n \to \lbrace0,1\rbrace$ is computable in the model from [../../model.md](../../model.md), then

$$ \deg_{\pm}(f) \leq H^{\ast}(f). $$

Here $\deg_{\pm}(f)$ denotes the threshold degree of $f$, namely the minimum degree of a real polynomial that sign-represents $f$ on the Boolean cube.

## What Threshold Degree Means

A real polynomial $P(x_1, \ldots, x_n)$ **sign-represents** $f$ on the Boolean cube if

$$P(x) \gt 0 \quad \text{whenever } f(x) = 1,$$

and

$$P(x) \lt 0 \quad \text{whenever } f(x) = 0.$$

The **threshold degree** of $f$, denoted $\deg_{\pm}(f)$, is the minimum degree of a real polynomial that sign-represents $f$.

The classifier in the attention model has the form $\text{score}(x) \gt \tau$, that is, $\text{score}(x) - \tau \gt 0$. So if we can turn the score function into a polynomial without changing its sign on the Boolean cube, then we obtain a polynomial sign representation of the computed Boolean function. That is exactly why threshold degree is the right lower-bound notion for this argument.

## Proof

Let $f$ be computed by an $H$-head model, where $H = H^{\ast}(f)$. We produce a sign-representing polynomial of degree at most $H$ in three steps.

### Theorem 1. On a finite domain, exact classification can be made strict

Let $X$ be a finite set, and let $f : X \to \lbrace0,1\rbrace$ be nonconstant. Suppose a real-valued score function $S$ and threshold $\tau$ satisfy

$$S(x) \gt \tau \quad \text{iff} \quad f(x) = 1.$$

Then there exists another threshold $\tau'$ such that

$$S(x) - \tau' \gt 0 \text{ when } f(x) = 1,$$

$$S(x) - \tau' \lt 0 \text{ when } f(x) = 0.$$

#### Proof

Define

$$m_{-} := \max \lbrace S(x) : f(x) = 0 \rbrace, \qquad m_{+} := \min \lbrace S(x) : f(x) = 1 \rbrace.$$

These quantities exist because $X$ is finite and both classes are nonempty.

From the hypothesis,

$$m_{-} \leq \tau \lt m_{+}.$$

In particular $m_{-} \lt m_{+}$. Choose any $\tau'$ with

$$m_{-} \lt \tau' \lt m_{+}.$$

Then:

1. if $f(x) = 0$, then $S(x) \leq m_{-} \lt \tau'$, so $S(x) - \tau' \lt 0$;
2. if $f(x) = 1$, then $S(x) \geq m_{+} \gt \tau'$, so $S(x) - \tau' \gt 0$.

This is exactly the desired strict sign separation.

### Theorem 2. The scalar contribution of one head is a ratio of affine functions

Fix one attention head $h$, and let $w_{\mathrm{out}} \in \mathbb{R}^{d_{\mathrm{model}}}$ be the final readout vector from [../../model.md](../../model.md).

Let

$$ s_h(x) := \bigl\langle w_{\mathrm{out}},  y^{(h)}(x) \bigr\rangle $$

be the contribution of head $h$ to the final probe score on input $x \in \lbrace0,1\rbrace^n$.

Then there exist affine functions $a_h, b_h : \mathbb{R}^n \to \mathbb{R}$ such that on the Boolean cube:

$$s_h(x) = \frac{a_h(x)}{b_h(x)}$$

and

$$b_h(x) \gt 0 \quad \text{for every } x \in \lbrace0,1\rbrace^n.$$

#### Proof

Fix the head $h$.

Because there is only one attention layer, the representation at input position $i$ is completely determined by the position $i$ and the local bit value $x_i \in \lbrace0,1\rbrace$. The query representation at the designated query token is constant across all inputs.

Therefore, for each input position $i$ and bit value $b \in \lbrace0,1\rbrace$, there are fixed real constants

$$ \ell_{i,b} \in \mathbb{R}, \qquad \mu_{i,b} \in \mathbb{R} $$

with the following meaning:

1. when $x_i = b$, the unnormalized attention weight contributed by position $i$ is $\exp(\ell_{i,b})$,
2. after composing the projected value written by head $h$ with the final linear probe $w_{\mathrm{out}}$, the corresponding scalar numerator term is $\exp(\ell_{i,b}) \mu_{i,b}$.

Indeed, if $u_{i,b}$ denotes the fixed model-space input vector at position $i$ carrying bit value $b$, then

$$ \mu_{i,b} := \bigl\langle w_{\mathrm{out}},  W_O^{(h)} W_V^{(h)} u_{i,b} \bigr\rangle. $$

Likewise, the query position contributes fixed constants

$$ \ell_{=} \in \mathbb{R}, \qquad \mu_{=} \in \mathbb{R}. $$

Set

$$ \lambda_{i,b} := \exp(\ell_{i,b}) \gt 0, \qquad \lambda_{=} := \exp(\ell_{=}) \gt 0. $$

Now write the head's scalar score as

$$s_h(x) = \frac{N_h(x)}{D_h(x)}$$

where

$$D_h(x) = \lambda_{=} + \sum_{i=1}^{n} \lambda_{i,x_i},$$

$$N_h(x) = \lambda_{=}   \mu_{=} + \sum_{i=1}^{n} \lambda_{i,x_i}   \mu_{i,x_i}.$$

Because $x_i \in \lbrace0,1\rbrace$, each local term can be written as

$$\lambda_{i,x_i} = \lambda_{i,0}(1 - x_i) + \lambda_{i,1} x_i,$$

$$\lambda_{i,x_i}   \mu_{i,x_i} = (\lambda_{i,0}   \mu_{i,0})(1 - x_i) + (\lambda_{i,1}   \mu_{i,1}) x_i.$$

So both $D_h$ and $N_h$ are affine functions of the variables $x_1, \ldots, x_n$.

Set

$$b_h := D_h, \qquad a_h := N_h.$$

Then $s_h(x) = a_h(x) / b_h(x)$ on the Boolean cube.

Also, every term in $D_h(x)$ is strictly positive, so $b_h(x) \gt 0$ for every Boolean input.

### Theorem 3. Any H-head classifier has threshold degree at most H

Let $f : \lbrace0,1\rbrace^n \to \lbrace0,1\rbrace$ be computed by an $H$-head model in the one-layer architecture.

Then there exists a real polynomial $P(x_1, \ldots, x_n)$ of degree at most $H$ such that

$$P(x) \gt 0 \text{ exactly on the inputs where } f(x) = 1,$$

$$P(x) \lt 0 \text{ exactly on the inputs where } f(x) = 0.$$

In other words, $f$ has threshold degree at most $H$.

#### Proof

If $f$ is constant, then its threshold degree is $0$, so there is nothing to prove. We therefore assume $f$ is nonconstant.

Because the final readout is linear, the total scalar score decomposes as a constant term coming from the fixed query residual plus a sum of scalar contributions from the $H$ heads.

Let the raw readout score be

$$U(x) = c + \sum_{h=1}^{H} s_h(x)$$

where $c$ is the constant contribution from the query residual and the readout threshold has not yet been absorbed.

Because the model computes $f$, there exists some threshold $\tau$ such that

$$U(x) \gt \tau \quad \text{iff} \quad f(x) = 1.$$

By Theorem 1, because $f$ is nonconstant, there exists another threshold $\tau'$ such that

$$U(x) - \tau' \gt 0 \text{ on positive examples},$$

$$U(x) - \tau' \lt 0 \text{ on negative examples}.$$

Now set

$$S(x) := U(x) - \tau'.$$

Then

$$S(x) = c' + \sum_{h=1}^{H} s_h(x)$$

for the constant $c' := c - \tau'$.

Also

$$S(x) \gt 0 \text{ on positive examples}, \qquad S(x) \lt 0 \text{ on negative examples}.$$

By Theorem 2, for each head $h$ we can write

$$s_h(x) = \frac{a_h(x)}{b_h(x)}$$

with $a_h, b_h$ affine and $b_h(x) \gt 0$ on the Boolean cube.

Therefore

$$S(x) = c' + \sum_{h=1}^{H} \frac{a_h(x)}{b_h(x)}.$$

Now multiply by the positive common denominator

$$B(x) := \prod_{h=1}^{H} b_h(x).$$

Since $B(x) \gt 0$ on the Boolean cube, the sign of $S(x)$ is the same as the sign of

$$P(x) := B(x)   S(x) = c' \prod_{h=1}^{H} b_h(x) + \sum_{h=1}^{H} a_h(x) \prod_{g \neq h} b_g(x).$$

Each $a_h$ and $b_h$ is affine, so every summand has degree at most $H$.

Hence $P$ is a polynomial of degree at most $H$.

Because $B(x) \gt 0$, $P$ has exactly the same sign pattern as $S$.

So $P$ sign-represents the Boolean function $f$ on $\lbrace0,1\rbrace^n$.

### Conclusion

Since $f$ is computed by $H^{\ast}(f)$ heads, Theorem 3 produces a polynomial of degree at most $H^{\ast}(f)$ that sign-represents $f$. Therefore

$$ \deg_{\pm}(f) \leq H^{\ast}(f). \qquad \blacksquare $$
