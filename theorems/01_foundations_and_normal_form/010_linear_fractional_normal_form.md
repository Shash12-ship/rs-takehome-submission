# Linear-Fractional Normal Form

## Statement

This note gives an exact normal form for $H^{\ast}(f)$ in the model from [../../model.md](../../model.md).

For parameters

$$ \gamma \gt 0, \qquad \rho_1, \ldots, \rho_n \gt 0, \qquad \alpha \gt 0, $$

and

$$ \eta, \delta, m_1, \ldots, m_n \in \mathbb{R}, $$

define a one-head atom

$$ \phi(x) := \frac{ \eta + \sum_{i=1}^{n} \rho_i \alpha^{x_i}(m_i + \delta x_i) }{ \gamma + \sum_{i=1}^{n} \rho_i \alpha^{x_i} }. $$

Here $x_i \in \lbrace0,1\rbrace$, so $\alpha^{x_i}$ means $1$ when $x_i = 0$ and $\alpha$ when $x_i = 1$.

Define $L_{\mathrm{frac}}(f)$ to be the least $H$ such that there exist one-head atoms

$$ \phi_1, \ldots, \phi_H $$

and a constant $c \in \mathbb{R}$ with

$$ f(x) = 1 \qquad \Longleftrightarrow \qquad c + \sum_{h=1}^{H} \phi_h(x) \gt 0 $$

for every $x \in \lbrace0,1\rbrace^n$. For $H = 0$, the sum is empty.

Then

$$ H^{\ast}(f) = L_{\mathrm{frac}}(f). $$

> **Interpretation.** The exact model-native invariant for head complexity is the minimum number of one-head linear-fractional atoms whose sum, plus a constant, sign-represents $f$. The first two levels of this hierarchy are pinned down in [011_one_head_characterization.md](011_one_head_characterization.md).

## Proof

We prove the normal form in both directions.

### Theorem 1. Every attention head gives one atom

Fix an $H$-head model and a final readout vector $w$ with threshold $\tau$.

For head $h$, write

$$ q_h := W_Q^{(h)} u_=. $$

This vector is constant as a function of the input $x$.

For each input position $i$, define

$$ \rho_{h,i} := \exp \left( \left\langle q_h, W_K^{(h)}(e_0 + p_i) \right\rangle \right) \gt 0, $$

and

$$ \alpha_h := \exp \left( \left\langle q_h, W_K^{(h)}(e_1 - e_0) \right\rangle \right) \gt 0. $$

Then the unnormalized attention weight assigned by head $h$ to input position $i$ is

$$ \rho_{h,i} \alpha_h^{x_i}. $$

Now define the scalar value seen by the final readout. For each input position $i$, set

$$ m_{h,i} := \left\langle w, W_O^{(h)} W_V^{(h)}(e_0 + p_i) \right\rangle, $$

and

$$ \delta_h := \left\langle w, W_O^{(h)} W_V^{(h)}(e_1 - e_0) \right\rangle. $$

So the scalar value contribution at position $i$ is

$$ m_{h,i} + \delta_h x_i. $$

For the query token itself, define

$$ \gamma_h := \exp \left( \left\langle q_h, W_K^{(h)} u_= \right\rangle \right) \gt 0, $$

and

$$ \eta_h := \gamma_h \left\langle w, W_O^{(h)} W_V^{(h)} u_= \right\rangle. $$

Therefore the scalar contribution of head $h$ to the final readout is exactly

$$ \phi_h(x) = \frac{ \eta_h + \sum_{i=1}^{n} \rho_{h,i} \alpha_h^{x_i}(m_{h,i} + \delta_h x_i) }{ \gamma_h + \sum_{i=1}^{n} \rho_{h,i} \alpha_h^{x_i} }. $$

This is a one-head atom.

The full affine score of the model is

$$ w^\top r(x) - \tau = c + \sum_{h=1}^{H} \phi_h(x), $$

where

$$ c := w^\top u_= - \tau. $$

Thus every $H$-head model gives an $H$-atom representation.

### Theorem 2. Every atom is realized by one attention head

Now suppose we are given $H$ atoms. We construct an $H$-head model realizing their sum.

If $H = 0$, the represented function is constant, and a zero-head model computes it by choosing the readout threshold on the correct side of the constant query score. So assume $H \geq 1$.

For each head $h$, take an independent block with orthonormal basis

$$ q_h, k_h, v_h, o_h. $$

Use the direct sum of all these blocks as the model space, and take $d_{\mathrm{head}} = d_{\mathrm{model}}$.

Define token embeddings by

$$ e_0 := 0, $$

$$ e_1 := \sum_{h=1}^{H} \bigl((\log \alpha_h) k_h + \delta_h v_h\bigr), $$

and

$$ e_= := \sum_{h=1}^{H} \left( q_h + (\log \gamma_h) k_h + \frac{\eta_h}{\gamma_h} v_h \right). $$

For input position $i$, set

$$ p_i := \sum_{h=1}^{H} \bigl((\log \rho_{h,i}) k_h + m_{h,i} v_h\bigr), $$

and set $p_= := 0$.

For head $h$, choose linear maps as follows.

1. $W_Q^{(h)}$ sends $q_h$ to $q_h$ and annihilates every other basis vector.
2. $W_K^{(h)}$ sends $k_h$ to $q_h$ and annihilates every other basis vector.
3. $W_V^{(h)}$ sends $v_h$ to $o_h$ and annihilates every other basis vector.
4. $W_O^{(h)}$ fixes $o_h$ and annihilates every other basis vector.

Then the query vector for head $h$ is $q_h$.

At input position $i$, the logit is

$$ \log \rho_{h,i} + x_i \log \alpha_h, $$

so the unnormalized attention weight is

$$ \rho_{h,i} \alpha_h^{x_i}. $$

The value written in the $o_h$ direction at that position is

$$ m_{h,i} + \delta_h x_i. $$

At the query token, the logit is $\log \gamma_h$, the unnormalized attention weight is $\gamma_h$, and the value written in the $o_h$ direction is $\eta_h / \gamma_h$.

Therefore the projected output of head $h$ is exactly

$$ \phi_h(x)   o_h. $$

Choose the final readout vector

$$ w := \sum_{h=1}^{H} o_h $$

and choose threshold

$$ \tau := -c. $$

The skip connection at the query token is orthogonal to every $o_h$, so it contributes nothing to $w^\top r(x)$. Hence

$$ w^\top r(x) - \tau = c + \sum_{h=1}^{H} \phi_h(x). $$

So the model computes exactly the Boolean function represented by the atoms.

### Combining the two directions

Theorem 1 shows $H^{\ast}(f) \geq L_{\mathrm{frac}}(f)$ and Theorem 2 shows $H^{\ast}(f) \leq L_{\mathrm{frac}}(f)$. Together,

$$ H^{\ast}(f) = L_{\mathrm{frac}}(f). \qquad \blacksquare $$
