# Model Specification

## Purpose

This file fixes the mathematical model used throughout the project.

We study Boolean functions

$$f : \lbrace 0,1\rbrace^n \to \lbrace 0,1\rbrace$$

computed by a one-layer attention-only architecture with a linear readout from a designated query token.

## Input Sequence

For an input

$$x = (x_1, \ldots, x_n) \in \lbrace 0,1\rbrace^n,$$

the model sees the sequence

$$(x_1, \ldots, x_n, =).$$

The final symbol `=` is a distinguished query token. We only read out the residual stream at that token.

## Embeddings

Fix a model dimension $d_{\mathrm{model}} \geq 1$ and a head dimension $d_{\mathrm{head}} \geq 1$.

Choose token embeddings

$$e_0, e_1, e_= \in \mathbb{R}^{d_{\mathrm{model}}}$$

and positional embeddings

$$p_1, \ldots, p_n, p_= \in \mathbb{R}^{d_{\mathrm{model}}}.$$

For an input $x$, define the embedded vectors

$$u_i(x) := e_{x_i} + p_i \qquad \text{for } 1 \leq i \leq n,$$

and

$$u_=(x) := e_= + p_=.$$

Note that $u_=(x)$ is constant as a function of $x$.

## One Attention Head

For each head $h \in \lbrace 1, \ldots, H\rbrace$, choose matrices

$$W_Q^{(h)}, W_K^{(h)}, W_V^{(h)} \in \mathbb{R}^{d_{\mathrm{head}} \times d_{\mathrm{model}}}.$$

Also choose output-projection blocks

$$W_O^{(h)} \in \mathbb{R}^{d_{\mathrm{model}} \times d_{\mathrm{head}}}.$$

Equivalently, one may concatenate these blocks into a single matrix

$$W_O = \begin{bmatrix} W_O^{(1)} & \cdots & W_O^{(H)} \end{bmatrix} \in \mathbb{R}^{d_{\mathrm{model}} \times H d_{\mathrm{head}}}.$$

For each position

$$j \in \lbrace 1, \ldots, n, =\rbrace,$$

define

$$q^{(h)}(x) := W_Q^{(h)} u_=(x) \in \mathbb{R}^{d_{\mathrm{head}}},$$

$$k_j^{(h)}(x) := W_K^{(h)} u_j(x) \in \mathbb{R}^{d_{\mathrm{head}}},$$

and

$$v_j^{(h)}(x) := W_V^{(h)} u_j(x) \in \mathbb{R}^{d_{\mathrm{head}}}.$$

The query-token logit is

$$\ell_j^{(h)}(x) := \bigl(q^{(h)}(x)\bigr)^\top k_j^{(h)}(x).$$

The attention weights are the softmax probabilities

$$\alpha_j^{(h)}(x) := \frac{\exp\bigl(\ell_j^{(h)}(x)\bigr)}{\sum_{k \in \lbrace 1,\ldots,n,=\rbrace} \exp\bigl(\ell_k^{(h)}(x)\bigr)}.$$

The unprojected output of head $h$ at the query position is

$$\widetilde y^{(h)}(x) := \sum_{j \in \lbrace 1,\ldots,n,=\rbrace} \alpha_j^{(h)}(x) v_j^{(h)}(x) \in \mathbb{R}^{d_{\mathrm{head}}}.$$

The projected contribution of head $h$ to the residual stream is

$$y^{(h)}(x) := W_O^{(h)} \widetilde y^{(h)}(x) \in \mathbb{R}^{d_{\mathrm{model}}}.$$

## Residual Stream At The Query Token

With $H$ parallel heads, the residual stream at the query token after the attention layer is

$$r(x) := u_=(x) + \sum_{h=1}^{H} y^{(h)}(x).$$

This is the only representation used by the final classifier.

## Readout

Choose a readout vector

$$w \in \mathbb{R}^{d_{\mathrm{model}}}$$

and a threshold

$$\tau \in \mathbb{R}.$$

The classifier outputs

$$f(x) = 1 \qquad \Longleftrightarrow \qquad w^\top r(x) \gt \tau.$$

Equivalently, one may write an affine score

$$S(x) := w^\top r(x) - \tau$$

and classify by the rule

$$f(x) = 1 \qquad \Longleftrightarrow \qquad S(x) \gt 0.$$

## Computability And Head Complexity

A Boolean function $f$ is **computable with $H$ heads** if there exist:

- a model dimension $d_{\mathrm{model}}$,
- a head dimension $d_{\mathrm{head}}$,
- token and positional embeddings,
- attention parameters $\lbrace W_Q^{(h)}, W_K^{(h)}, W_V^{(h)}, W_O^{(h)}\rbrace_{h=1}^{H}$,
- a readout vector $w$ and threshold $\tau$,

such that the resulting classifier agrees with $f$ on every input in $\lbrace 0,1\rbrace^n$.

We then define

$$H^{\ast}(f) := \min \left\lbrace H : f \text{ is computable with } H \text{ heads in the above model} \right\rbrace.$$

## Masking Convention

The formulas above sum over all input positions and the query position itself.

For the current project, this is equivalent to the usual causal-mask convention, because:

1. the query token `=` is placed last in the sequence,
2. only the residual stream at that final token is ever read out.

So a standard causal mask would still allow the query token to attend to every input bit and to itself. None of the current results depend on choosing between these two conventions.

## Deliberate Simplifications

The model in this project deliberately excludes several features of a full transformer block:

- no MLP,
- no layer normalization,
- no dropout,
- no multi-layer stacking,
- no extra nonlinearity after the attention update.

The only nonlinearity in the model is the softmax inside each attention head, followed by the final thresholding in the readout.

## Notes On Conventions

1. Any constant scaling factor in the logits, such as $1 / \sqrt{d_{\mathrm{head}}}$, can be absorbed into the choice of $W_Q^{(h)}$ or $W_K^{(h)}$, so it is omitted from the specification.
2. Although $W_O$ is now part of the formal model, many lower-bound arguments can compose the final linear readout with $W_O^{(h)}$ and thereby reduce each head again to a scalar contribution.
3. Because $u_=(x)$ is constant in $x$, any contribution from the query token's skip connection can always be absorbed into the readout threshold when proving lower or upper bounds.
