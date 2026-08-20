# Compact Threshold Determinant Certificates

## Statement

For every

$$ n \in \lbrace3,\ldots,12\rbrace, $$

every Boolean function

$$ f : \lbrace0,1\rbrace^n \to \lbrace0,1\rbrace $$

satisfies

$$ H^{\ast}(f) \leq \left\lceil \frac{2^n - 1}{n} \right\rceil. $$

Thus the determinant-span method reaches its own dimension lower bound for every $3 \leq n \leq 12$.

## Proof

Let

$$ H_n := \left\lceil \frac{2^n - 1}{n} \right\rceil. $$

For $h \in \lbrace1,\ldots,H_n\rbrace$ and $i \in \lbrace1,\ldots,n\rbrace$, let $r_{h,i}$ be the least nonnegative residue of

$$ (h + 2)^{i + 1} + 13i $$

modulo $997$, and let

$$ b_{h,i} := 1 + (r_{h,i} \bmod 99). $$

Define the positive affine denominators

$$ B_h(x) := 1 + \sum_{i=1}^{n} b_{h,i}x_i. $$

All coefficients are positive, so every $B_h$ is positive on the cube.

Let

$$ R_n := 2^n - \bigl(1 + n(H_n - 1)\bigr). $$

For the certificate matrix, take the following $2^n$ products:

$$ \prod_{j=1}^{H_n} B_j, $$

for each $h \in \lbrace1,\ldots,H_n - 1\rbrace$, the $n$ products

$$ M\prod_{j\neq h} B_j \qquad \text{for } M \in \lbrace1,x_1,\ldots,x_{n-1}\rbrace, $$

and for $h = H_n$, the $R_n$ products

$$ M\prod_{j\neq H_n} B_j \qquad \text{for } M \in \lbrace1,x_1,\ldots,x_{R_n-1}\rbrace. $$

Write their value vectors on $\lbrace0,1\rbrace^n$ in lexicographic input order. Computation modulo

$$ p := 1000003 $$

gives the following determinant residues:

$$ \begin{array}{c|r|r|r} n & H_n & R_n & \det \pmod p \cr \hline 3 & 3 & 1 & 517804 \cr 4 & 4 & 3 & 364478 \cr 5 & 7 & 1 & 833072 \cr 6 & 11 & 3 & 319656 \cr 7 & 19 & 1 & 831708 \cr 8 & 32 & 7 & 685472 \cr 9 & 57 & 7 & 46734 \cr 10 & 103 & 3 & 954493 \cr 11 & 187 & 1 & 163187 \cr 12 & 342 & 3 & 205507. \end{array} $$

Each residue is nonzero modulo $p$. Hence each displayed determinant is nonzero over the integers, so the selected denominator-cleared products form a basis for all real-valued functions on $\lbrace0,1\rbrace^n$.

The determinant-span schema from [021_determinant_span_schema.md](021_determinant_span_schema.md) then gives

$$ H^{\ast}(f) \leq H_n = \left\lceil \frac{2^n - 1}{n} \right\rceil $$

for every Boolean $f : \lbrace0,1\rbrace^n \to \lbrace0,1\rbrace$ and every $n \in \lbrace3,\ldots,12\rbrace$. $\blacksquare$

## Consequence

The current determinant-threshold universal upper bounds are:

$$ \begin{array}{c|rrrrrrrrrr} n & 3 & 4 & 5 & 6 & 7 & 8 & 9 & 10 & 11 & 12 \cr \hline \left\lceil (2^n - 1)/n \right\rceil & 3 & 4 & 7 & 11 & 19 & 32 & 57 & 103 & 187 & 342. \end{array} $$

This does not prove that the threshold formula holds for all $n$. It does give a compact reproducible certificate through $n=12$, and it replaces the need for separate large coefficient tables at $n=11$ and $n=12$.
