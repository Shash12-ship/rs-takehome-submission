# AGENTS.md

Conventions for writing theorem / writeup markdown in this repo so that it renders cleanly in GitHub, VS Code preview, and Obsidian.

## Math

Use LaTeX math delimiters, not backticks.

- **Inline math:** wrap in single dollar signs, e.g. `$f : \lbrace 0,1\rbrace^n \to \lbrace 0,1\rbrace$`.
- **Display math:** wrap in double dollar signs, with a blank line before and after the block. Keep the whole `$$...$$` on one source line; multi-line `$$` blocks are fragile (GitHub can mis-parse an equation line as a heading or list item).

  ```markdown
  Some lead-in text.

  $$ z(a,b) = \frac{N(a,b)}{D(a,b)} $$

  Continuation text.
  ```

- Use `\lbrace`, `\rbrace` for set braces (space before a following letter, e.g. `\lbrace f\rbrace`), `\to` for arrows, `\neq`, `\geq`, `\leq`, `\in`, `\cdot`, `\top` (for transpose), `\blacksquare` for Q.E.D.
- Use `\lt`, `\gt` for bare `<` and `>` inside math (space before a following letter/digit, e.g. `2 \lt 3`); `\leq`, `\geq`, `\neq`, `\langle`, `\rangle` are macros and already safe.
- Use `\ast` instead of a literal `*` inside math; `*` is Markdown emphasis and corrupts the block.
- Never use `\,`, `\;`, `\!` spacing commands inside math; delete them (a plain space or nothing is fine).
- No math inside headings, list-item display blocks, footnote definitions (GitHub never renders it there; use Unicode like `z₌`, `⊕`), or `*italic*`/`_italic_` (bold `**...**` is fine).
- No `\begin{...}` environment inside inline `$...$` (`cases`, `aligned`, `array` all fail on GitHub); put it on a standalone `$$` line.
- Never use `\(...\)` or `\[...\]` delimiters; GitHub and VS Code don't treat them as math. Only `$...$` and `$$...$$`.
- When a `_` that can open emphasis (punctuation before, letter/digit after, e.g. `}_n`) precedes a `_` that can close (letter/digit before punctuation, e.g. `T_{`, or punctuation on both sides, e.g. `}_{`) in the same paragraph, insert a space before every closable `_` (`$T _{n,1}$`, `$\underbrace{...} _{a}$`) so nothing can emphasis-pair.
- Never use the `&#95;` HTML entity for underscores; it renders on GitHub but breaks KaTeX previews (VS Code, GitLab).
- Multi-line derivations use `\begin{aligned} ... \end{aligned}` inside a `$$` block, with `&=` alignment (collapsed onto one line; `&` survives).
- Row separators in a single-line `$$...$$` block (`aligned`, `cases`, `array`, `substack`) are `\cr`, never `\\`; GitHub eats one backslash of `\\` on a single source line and the row break silently vanishes.
- Group short related equations with `\qquad` spacing on one display line rather than stacking many tiny blocks.
- Never use plain ASCII like `!=`, `>=`, `^T`, `sum`, `alpha` in math; always use the LaTeX command.
- Never wrap math in backticks. Backticks are reserved for code identifiers and file paths.

## Structure

- `#` for the theorem title, `##` for top-level sections (`Statement`, `Proof`, `Consequence`, etc.).
- Sub-theorems inside a proof use `###` with a period-separated title like `### Theorem 2. Antipode identities`. Never put an em dash in a heading.
- Inline mini-proofs use **bold run-in headers**: `**Proof.**`, `**Reason.**`, `**Claim.**`.
- Use blockquotes (`>`) for informal restatements or remarks that sit alongside the formal statement.
- Use ordered lists (`1.`, `2.`, ...) for enumerated cases and unordered lists (`-`) for bullet points.

## Prose

- No em dashes anywhere (user global rule). Use `,`, `;`, `:`, or `.` instead. No exceptions for headings, captions, or run-in labels.
- Italicize short emphases with `*...*`; bold with `**...**` for labels and run-in headers.
- Keep paragraphs short. Blank line between paragraphs, between display math and prose, and between list items that contain display math.

## Code and identifiers

- Use backticks only for: file names, directory paths, Lean identifiers, shell commands, and literal code snippets.
- Do **not** use backticks for mathematical variables or expressions. Those go in `$...$`.

## Example skeleton

```markdown
# Theorem Title

## Statement

Let $f : \lbrace 0,1\rbrace^n \to \lbrace 0,1\rbrace$. Suppose ...

$$ \text{main equation} $$

> **Equivalently.** Informal restatement.

## Proof

Prose lead-in.

### Theorem 1. Short name

**Claim.** Something.

**Proof.** Expand:

$$ \begin{aligned} X &= Y + Z \cr &= W. \end{aligned} $$

### Conclusion

Wrap up. $\blacksquare$

## Consequence

$$ H^{\ast}(f) \geq 2. $$
```

Apply this style to every file under `theorems/` and to
`artifacts/intro-materials/writeup.md`.

## Enforcement

These conventions are enforced by `artifacts/scripts/check_md_math.py`
(GitLab work item #2):

- **CI (merge gate):** `.gitlab-ci.yml` runs the static lint plus a KaTeX
  validation of every math span on each merge request and on pushes to the
  default branch. With "Merge checks: Pipelines must succeed" enabled in the
  project settings, a red check blocks the merge.
- **Local pre-commit hook (optional, offline):** enable once per clone with
  `git config core.hooksPath artifacts/hooks`; it lints staged `.md` files.
- **Faithful render audits (manual, needs `gh`/`glab` auth):**
  `check_md_math.py --render-github --render-gitlab FILE...` renders through
  the real GitHub/GitLab Markdown APIs and checks that every span is
  recognized (no residual `$`, no double-escaped payloads). Run this when
  touching math-heavy files or after changing the lint rules.
- **KaTeX locally:** `npm install --no-save katex`, then pass `--katex`.

The rule catalogue with verified failure modes lives in
`.claude/skills/gh-markdown-math/SKILL.md`; keep the script, the skill, and
this file in sync when a new renderer quirk is discovered.
