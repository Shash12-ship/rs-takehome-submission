---
name: gh-markdown-math
description: Audit and fix LaTeX math in Markdown so it renders correctly on GitHub, GitLab, and KaTeX previews (VS Code). Use for any .md containing $...$ or $$...$$ that will be viewed on github.com or gitlab.com, such as READMEs, docs, proofs, and theorem notes. Verifies against the real render APIs instead of guessing.
metadata:
  short-description: Fix Markdown math that breaks on GitHub/GitLab
---

# Markdown math (GitHub / GitLab / KaTeX)

Fix LaTeX math in Markdown so it survives GitHub's Markdown layer, GitLab's, and
a local KaTeX preview. KaTeX validity alone is NOT enough: the failure modes come
from the Markdown parser running before and around the math step. Never certify a
file from static reasoning alone; always finish with a real render.

This skill is scoped to the `xorformer` repo and uses its checker. Run from the
repo root.

## 1. Read the rules

Read `.claude/skills/gh-markdown-math/SKILL.md` — the canonical rule source of
record, kept as a single copy so the two never drift. It has the full failure-mode
list and the ordered fix recipe. Do not work from memory; the rules get revised as
new failure modes are verified.

## 2. Run the checker

`artifacts/scripts/check_md_math.py` is the authority and the CI gate
(see `.gitlab-ci.yml`):

```bash
python3 artifacts/scripts/check_md_math.py --katex FILE.md
python3 artifacts/scripts/check_md_math.py --render-github FILE.md
python3 artifacts/scripts/check_md_math.py --render-gitlab FILE.md
```

Exit 0 is clean. Always run `--katex`; add the render audits when their tooling
is available.

## 3. Fix, then re-verify

Apply the fix recipe from the canonical SKILL.md in its stated order. Re-run the
full check until it reports zero findings; never report an unverified fix. Fix
only the math — do not reflow prose or restructure headings.

## 4. Report

Give each change as `file:line` with before and after. If the file is already
clean, say so plainly and make no edits.

## Gotchas

- **Compare the span counts yourself.** The checker prints the source span count
  and the rendered math count as separate lines but does *not* assert they are
  equal. Read both off each render audit and confirm they match.
- **`--katex` needs katex resolvable from the repo root.** Check
  `ls node_modules/katex` first; this repo normally has it (`node_modules/` is
  gitignored). If missing: `npm install --no-save katex` at the repo root. Never
  symlink an external `node_modules` in — `ln -sfn` silently nests the link
  *inside* an existing one. A missing module is not a silent pass: the script
  exits **2** with a stderr message, so a clean `--katex` run is real evidence.
- **`--render-github` needs `gh auth status`; `--render-gitlab` needs `glab` on
  PATH.** Skip either only with an explicit note in the report.
- **Untracked files are not CI-gated.** CI runs
  `git ls-files -z -- '*.md' ':!:.claude/**' | xargs -0 python3 artifacts/scripts/check_md_math.py --katex`,
  and `git ls-files` covers tracked files only. Say so when auditing an untracked
  `.md`.
