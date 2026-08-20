# Raw-Mask Gate Endpoint Bounds

## Statement

Let

$$ T(y)=F(t(y)), \qquad t(y)=\sum_{i=1}^{m}\lambda_i y_i, \qquad \lambda_i\gt0, $$

and let $C$ be the sign-change count of $F$ along the image

$$ \tau_0\lt\tau_1\lt\cdots\lt\tau_{M-1}. $$

Put

$$ e_0:=F(\tau_0), \qquad e_1:=F(\tau_{M-1}). $$

Let $R:\lbrace0,1\rbrace^{k}\to\lbrace0,1\rbrace$ be a raw mask, and define

$$ r_1:=\left\lvert R^{-1}(1)\right\rvert, \qquad r_0:=\left\lvert R^{-1}(0)\right\rvert, \qquad C_R:=C_{+}(R). $$

For the conjunction

$$ A(z,y):=R(z)\wedge T(y), $$

we have

$$ H^{\ast}(A)\leq \begin{cases} r_1C, & e_0=e_1=0,\cr r_1C+C_R, & e_0=e_1=1,\cr r_1(C+1), & e_0\neq e_1. \end{cases} $$

For the disjunction

$$ O(z,y):=R(z)\vee T(y), $$

we have

$$ H^{\ast}(O)\leq \begin{cases} r_0C, & e_0=e_1=1,\cr r_0C+C_R, & e_0=e_1=0,\cr r_0(C+1), & e_0\neq e_1. \end{cases} $$

For the raw-mask XOR

$$ X(z,y):=R(z)\oplus T(y), $$

we have

$$ H^{\ast}(X)\leq \begin{cases} 2^k C+C_R, & e_0=e_1,\cr 2^k(C+1)+C_R, & e_0\neq e_1. \end{cases} $$

> **Interpretation.** Common raw-mask gates pay for the number of raw slices where the feature is active, and their boundary terms collapse to raw support size or raw positive-order variation.

## Proof

First consider $A=R\wedge T$. For the gate $G(a,u)=R(a)\wedge u$, the slice depends on $u$ exactly when $R(a)=1$, so

$$ N_G=r_1. $$

The endpoint raw functions are

$$ g_0(a)=0, \qquad g_1(a)=R(a). $$

If $e_0=e_1=0$, the equal-endpoint bound from Lemma 152 gives boundary cost $C_{+}(g_0)=0$. Hence

$$ H^{\ast}(A)\leq r_1C. $$

If $e_0=e_1=1$, the same lemma gives boundary cost $C_{+}(R)=C_R$, so

$$ H^{\ast}(A)\leq r_1C+C_R. $$

If $e_0\neq e_1$, Lemma 153 gives

$$ H^{\ast}(A)\leq r_1C+\min\lbrace C_{+}(0),C_{+}(R)\rbrace+D(0,R). $$

Here $C_{+}(0)=0$ and $D(0,R)=r_1$, so

$$ H^{\ast}(A)\leq r_1(C+1). $$

The disjunction case is identical after observing that for $G(a,u)=R(a)\vee u$, the slice depends on $u$ exactly when $R(a)=0$, and

$$ g_0(a)=R(a), \qquad g_1(a)=1. $$

Thus $N_G=r_0$, the equal endpoint $1$ case has zero boundary cost, the equal endpoint $0$ case has boundary cost $C_R$, and the opposite-endpoint case has distance $D(R,1)=r_0$.

For $X=R\oplus T$, every raw slice depends on $T$, so

$$ N_G=2^k. $$

The endpoint raw functions are

$$ g_0=R, \qquad g_1=1-R. $$

If $e_0=e_1$, Lemma 152 gives boundary cost

$$ C_{+}(R\oplus e_0)=C_R. $$

If $e_0\neq e_1$, Lemma 153 gives

$$ B_{+}(g_1,g_0) \leq \min\lbrace C_{+}(R),C_{+}(1-R)\rbrace+D(R,1-R). $$

Since

$$ C_{+}(1-R)=C_R \qquad \text{and} \qquad D(R,1-R)=2^k, $$

we get the bound

$$ H^{\ast}(X)\leq2^kC+C_R+2^k=2^k(C+1)+C_R. $$

$\blacksquare$

## Consequence

The crude multi-slice boundary term $2^k-1$ can often be replaced by the raw mask support size or by $C_{+}(R)$. This is especially useful when $R$ is sparse or has few runs under a positive raw order.
