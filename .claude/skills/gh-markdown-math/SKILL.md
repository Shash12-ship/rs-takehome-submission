---
name: gh-markdown-math
description: Write and verify LaTeX math in Markdown that renders correctly on GitHub AND in local KaTeX previews (VS Code's built-in Markdown preview). Use whenever authoring or editing .md files containing $...$ or $$...$$ math that will be viewed on github.com (READMEs, docs, notes, proofs). GitHub's pipeline mangles backslash-punctuation, emphasis-pairs * and _, mis-parses multi-line $$ as headings/lists, and drops math in headings/lists/italics. This skill lists every failure mode, a fix that works on both platforms, and a faithful audit method for each.
---

# GitHub-safe Markdown math

GitHub renders `$...$` (inline) and `$$...$$` (display) math, but its Markdown
parser runs **before/around** the math step, so Markdown tokens inside math get
mangled and some placements silently fail. Every rule below was verified against
GitHub's real renderer (see **Auditing**). KaTeX/MathJax validity is **not enough** —
it must survive GitHub's Markdown layer too.

**Dual target.** The same file is usually also read in VS Code's built-in Markdown
preview, which feeds the raw text between `$` delimiters straight to KaTeX (entities
NOT decoded, Markdown emphasis not applied inside math). Every fix in this skill is
KaTeX-safe and works on both platforms, with one flagged exception: the `&#95;`
entity trick (see *Underscores*), which is GitHub-only and shows as a KaTeX parse
error in VS Code. Prefer the dual-safe fixes.

## The rules (left = breaks on GitHub → right = fix)

### Inside any `$…$` / `$$…$$`
- `\{` `\}` → `\lbrace` `\rbrace` — GitHub unescapes backslash-punctuation; `\left\{` becomes `\left{` (a hard error that kills the whole block); `\{0,1\}` loses its braces.
- `\,` `\;` `\!` → **delete them** (use a normal space or nothing). They get unescaped to literal `, ; !`. Their named forms `\thinspace`/`\thickspace`/`\negthinspace` are **not supported** by GitHub's renderer, so don't substitute those.
- `*` → `\ast` — a literal `*` is Markdown emphasis. Two `*` on a line/block (e.g. `H^{*}` twice) pair into `<em>` and corrupt the math ("missing open brace"). `\ast` renders identically and isn't a Markdown char.
- `\operatorname{X}` → `\mathrm{X}` — `\operatorname` is unreliable on GitHub.
- `\#` (literal hash, e.g. `\#\{set\}`) → cardinality bars `\lvert\lbrace…\rbrace\rvert`. `\#` unescapes to `#`, a TeX error.
- `<` `>` (bare comparison signs) → `\lt` `\gt` : when the math is embedded in a
  paragraph (any `$…$`, or a `$$…$$` sharing a line with prose), GitHub double-escapes
  angle brackets and KaTeX receives a literal `&lt;`/`&gt;` (parse error on `&`).
  Standalone `$$` lines escape correctly, but use `\lt`/`\gt` uniformly; they render
  identically and are KaTeX-safe. (`\leq \geq \neq \langle \rangle` are macros and
  already safe.)
- `\\` (row separator in `aligned`/`cases`/`array`/`substack`) → `\cr` : on a
  single-line `$$…$$` the Markdown layer eats one backslash, so KaTeX receives `\ `
  (an escaped space) and the row break vanishes. `\cr` survives and renders identically
  on GitHub, KaTeX, and MathJax. This supersedes the earlier claim below that `\\`
  survives (re-verified broken via the render API, July 2026).
- After substituting a **letter-command** (`\lbrace`, `\rbrace`, …) that is immediately followed by a letter, insert a space: `\{f` → `\lbrace f`, never `\lbracef` (one undefined token).

### Underscores (subscripts)
- Intraword `_` (`a_i`, `x_i` — alnum on both sides) is always inert; any number of them is fine. The hazard comes from three shapes (classified by the characters adjacent to the `_`):
  - **opener-shaped**: punctuation before, letter/digit after — `}_n`, `)_n` (e.g. `$\mathrm{OR}_n$`); can only open.
  - **closer-shaped**: letter/digit before, punctuation after — `T_{`, `g_{` (e.g. `$T_{n,1}$`, `$\deg_{\pm}$`); can only close.
  - **both-shaped**: punctuation on BOTH sides — `}_{`, `}_=` (e.g. `$\underbrace{…}_{a\text{-only}}$`, `$\text{pos}_=$`); can open AND close. Verified July 2026: two `}_{` in one paragraph pair with each other and corrupt the math.
- Math breaks **iff a `_` that can open is followed later by a `_` that can close in the same paragraph** — they emphasis-pair into `<em>` across everything in between. This crosses source lines (a wrapped list item is one paragraph), crosses `$…$` span boundaries, and even happens inside `**bold**`. Verified: `$\mathrm{OR}_n$ … $T_{n,1}$` breaks (opener→closer, even on different lines); `$T_{n,1}$ … $\mathrm{OR}_n$` is fine (closer first); `$\deg_{\pm}(\mathrm{XOR}_n)$` alone is fine (closer before opener); any number of opener-shaped `_` alone is fine.
- **Fix (dual-safe, use this): put a space before every `_` that can close** (closer-shaped AND both-shaped) in any paragraph that also contains an earlier openable `_` — `$T _{n,1}$`, `$\underbrace{…} _{a\text{-only}}$`. A `_` preceded by whitespace can never close emphasis, and TeX ignores the space, so GitHub, KaTeX, and MathJax all render a normal subscript. Caution: the spaced `_` can still OPEN emphasis, so the fix only holds if every closable `_` later in the paragraph is spaced too — space them all, not just the first offender. Alternatively move the subscript inside the argument (`\mathrm{XOR_n}` — intraword, inert) if the upright subscript style is acceptable.
- GitHub-only fallback: the HTML entity `&#95;` (e.g. `\mathrm{OR}&#95;n`) also works because GitHub decodes it after Markdown — but it **breaks VS Code / any KaTeX preview**, which passes the entity raw into KaTeX (parse error on `&`). Avoid unless the file is GitHub-only.

### Delimiter placement
- **Opening `$` must be preceded by whitespace/start.** `degree-$d$` fails (hyphen abuts `$`). Fix: `degree $d$` (drop the hyphen) or reword. `$d$-degree` (hyphen *after* the closing `$`) is fine.
- **Closing `$` must not be followed by a letter.** `$b$th` fails. Fix: `$b$-th`.
- **Closing `$` with punctuation on both sides fails**, e.g. `…(a)$)` in `(respectively $\alpha(a)$)` (pattern `)$)`). Fix: reword so the span is followed by a space/word, or pull the formula out of the parenthetical.
- **Inline math must stay on one line.** A `$…$` span that wraps across a source line break does not render. Join it onto one line. (Detect: a line whose single-`$` count, after masking `$$…$$`, is odd.)

### Block / placement structure
- **Multi-line `$$` blocks are fragile** — GitHub leaks block-level Markdown into them. A line that is bare `=`/`-` becomes a Setext heading (the equation renders as a big `<h1>`); a line starting with `+`/`-`/`*` becomes a bullet. **Collapse every `$$…$$` onto a single line** (newlines in math are just whitespace; `\\` and `&` for `aligned`/`cases` are preserved).
- **Display `$$` does not render inside list items.** Use inline `$…$` instead (inline renders on a list-continuation line). ` ```math ` fenced blocks also fail inside lists.
- **No math in headings.** `# … $n$` is unreliable; use plain text / Unicode (`ₙ`, `…`, `≤`).
- **Math inside `*italic*` / `_italic_` does NOT render** — the `$…$` is left raw (`*foo $H$ bar*` renders a literal `$H$`). Move the math outside the italic: `*foo* $H$ *bar*`. **Math inside `**bold**` DOES render** (`**foo $H$ bar**` is fine) — with one exception: an opener→closer underscore pair (e.g. `**…$\mathrm{OR}_n$…$T_{n,1}$…**`) still emphasis-pairs inside bold and breaks it; apply the space-before-closer fix from *Underscores* (`$T _{n,1}$`), which is verified to work inside bold. (Verified on GitHub: `**$H$**`→math, `*$H$*`→raw.)
- **No `\begin{…}` environment renders inline.** `cases`, `aligned`, `array`, … inside `$…$` all leave the span unrecognized (raw `$`), verified July 2026. Use a standalone display `$$` line (not inside a list) or rewrite as prose: `$f(x)=1$ if …, and $2$ otherwise.`
- **Math inside footnote definitions (`[^label]: …`) never renders on GitHub** — the span is left raw even when the same span renders in the body (verified July 2026 via the render API; GitLab renders footnote math fine). Use plain text/Unicode in footnotes (`z₌`, `⊕`, `≤`) or move the math into the body.
- **`\(...\)` / `\[...\]` delimiters are not math on GitHub** (or in VS Code's preview); only `$`, `$$`, and ` ```math ` are. Convert them to `$…$` / `$$…$$`.

### Generally safe (do not "fix" these)
`\lbrace \rbrace \lvert \rvert \lVert \rVert`, `\mathrm \mathbf \mathbb \mathcal \mathfrak`,
`\bigl \bigr \left \right`, `\frac \sum \prod \binom \sqrt`, `\langle \rangle`,
`\widehat \widetilde \overline`, `\ldots \cdots`, `\leq \geq \neq \pm \in \to \subseteq`,
`\begin{aligned}` / `\begin{cases}` / `\begin{array}` (as single-line `$$`, with `\cr` and `&`),
`\substack{a\cr b}`, `\blacksquare \varnothing \subsetneq`, `\qquad \quad`. `&` alignment survives; use `\cr` for row breaks (see the rule above).

## Auditing (do this, don't guess)

GitHub renders math client-side, so a passing KaTeX check alone proves nothing. Get the
**faithful** render via the Markdown render API — no commit, push, or branch needed
(needs auth: `gh auth status`):

```bash
jq -n --rawfile t FILE.md '{text:$t, mode:"gfm", context:"OWNER/REPO"}' \
  | gh api markdown --input -
```

This is the same pipeline GitHub uses for README rendering. (Alternative, for auditing
exactly what a pushed branch shows: `gh api "repos/OWNER/REPO/contents/PATH?ref=BRANCH"
-H "Accept: application/vnd.github.html+json"`.)

The returned HTML wraps recognized math in `<math-renderer>…</math-renderer>` holding
the exact LaTeX fed to the engine. Two checks:

1. **Residual `$`** — strip `<math-renderer>…</math-renderer>`, `<code>`, `<pre>`, then
   look for a literal `$`. Any leftover `$` = a delimiter GitHub did **not** recognize =
   broken math. This single check catches almost every failure above.
2. **Double-escape inside math** — decode each `<math-renderer>` payload **once**
   (`html.unescape`), then flag any entity that survives (`&lt;` `&gt;` `&amp;` `&#…;`):
   a surviving entity is what KaTeX receives — broken math the residual-`$` check
   cannot see. A plain `&amp;` in the *raw* payload is NOT an error: a healthy
   alignment `&` is normally HTML-escaped there (verified July 2026 on both GitHub
   and GitLab; the marker of the real bug is `&amp;lt;`-style double escapes). Also
   scan payloads for a lone `\` where a row break was intended (an eaten `\\`) —
   but treat that as a pointer to compare against the source, not an automatic
   failure: `\ ` is also the legitimate TeX control space, widely used for
   spacing (`,\ K_{+}`, `\ell\ \mathrm{even}`), and KaTeX renders it fine.
3. **Leak into structure** — a `<h1-6>` or `<li>` whose text contains raw `\sum`/`\frac`/
   `\begin`/`<em>` where math should be = the block was mis-parsed.

The render API also makes candidate fixes cheap to test: put the variants in a small
throwaway .md, render it, and compare which shapes survive — no scratch branch required.

**VS Code / KaTeX side.** After the GitHub audit passes, verify the KaTeX side by
extracting every math span (mask code fences and inline code first; `$$…$$` before
`$…$`) and running each through `katex.renderToString(tex, {throwOnError: true})`
(`npm install katex`, then a short node script). 0 failures = the file renders in
VS Code's preview. If katex isn't installable, a static scan for the one known
divergence — `&#…;` entities inside math — is usually sufficient, since every other
fix in this skill is KaTeX-safe.

## Quick fix recipe (mechanical, in order)

1. Collapse every `$$…$$` to one line.
2. In all math: `\{`→`\lbrace`, `\}`→`\rbrace`, `*`→`\ast`, `<`→`\lt`, `>`→`\gt`, `\\` (row separator)→`\cr`, `\operatorname`→`\mathrm`; delete `\,` `\;` `\!`; add a space where a letter-command abuts a letter.
3. In each paragraph where a `_` that can open (opener-shaped `}_n`, or both-shaped `}_{`) precedes a `_` that can close (closer-shaped `T_{`, or both-shaped `}_{`), insert a space before EVERY closable `_` in the paragraph: `$T _{n,1}$`, `$\underbrace{…} _{a}$`. Remember prose underscores count too (an unbackticked `_foo` can open emphasis that a later math `_` closes). (Do NOT use `&#95;` — it breaks KaTeX previews.)
4. Fix delimiter placement: `word-$x$`→`word $x$`; `$x$y`→`$x$-y`; reword `)$)`; join wrapped inline spans.
5. Move math out of headings, list-item display blocks, and `*italic*`/`_italic_` (bold `**…**` is fine).
6. Re-run the residual-`$` audit until it reports 0, then run the KaTeX check.

Pitfall: never "fix" delimiter spacing with a regex like `\$[^$]+?\$([A-Za-z])` — its
non-greedy `[^$]+?` mis-pairs the **gap between** two spans and corrupts text. Operate
per-span with explicit positions, or do exact string replaces for known cases.
