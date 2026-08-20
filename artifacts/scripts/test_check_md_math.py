#!/usr/bin/env python3
"""Self-test for check_md_math.py: one regression fixture per code-review
finding plus the original rule shapes. Plain asserts; run with python3.
Wired as the first step of the markdown-math-check CI job."""

import importlib.util
import subprocess
import sys
import tempfile
from pathlib import Path

HERE = Path(__file__).resolve().parent
spec = importlib.util.spec_from_file_location("chk", HERE / "check_md_math.py")
chk = importlib.util.module_from_spec(spec)
spec.loader.exec_module(chk)

FAILURES = []


def rules_of(md_text):
    with tempfile.NamedTemporaryFile("w", suffix=".md", delete=False,
                                     encoding="utf-8") as f:
        f.write(md_text)
        p = f.name
    try:
        findings, _ = chk.lint_file(p)
    finally:
        Path(p).unlink()
    return sorted({fd.rule for fd in findings})


def expect(name, md_text, must_have=(), must_not_have=()):
    got = rules_of(md_text)
    missing = [r for r in must_have if r not in got]
    unwanted = [r for r in must_not_have if r in got]
    if missing or unwanted:
        FAILURES.append(f"{name}: got {got}, missing {missing}, "
                        f"unwanted {unwanted}")


# ---- original rule shapes (regression for the calibrated behavior) ----
expect("brace", r"Bad $\{0,1\}$ here.", ["brace"])
expect("spacing", r"Bad $a\,b$ here.", ["spacing"])
expect("star", r"Bad $x^*$ here.", ["star"])
expect("operatorname", r"Bad $\operatorname{OR}(x)$ here.", ["operatorname"])
expect("hash", r"Bad $\#\{S\}$ here.", ["hash"])
expect("angle", r"Bad $a \lt b$ and $c < d$.", ["angle"])
expect("rowsep", r"Bad $$\begin{cases} 1 & x \\ 2 & y \end{cases}$$ inline.",
       ["rowsep"])
expect("entity", r"Bad $\mathrm{OR}&#95;n$ here.", ["entity"])
expect("multiline-display", "Text\n\n$$\nx = 1\n$$\n", ["multiline-display"])
expect("heading-math", "# Heading with $n$ math\n", ["heading-math"])
expect("list-display", "- item $$E = mc^2$$ inline\n", ["list-display"])
expect("italic-line", "*italic $H$ math* but **bold $H$** is fine.\n",
       ["italic-math"])
expect("inline-env", r"Inline $\begin{cases} 1 \end{cases}$ fails.",
       ["inline-env"])
expect("footnote-math", "x[^a]\n\n[^a]: math $c+d$ here.\n", ["footnote-math"])
expect("open-delim", "degree-$d$ fails.\n", ["open-delim"])
expect("close-delim-letter", "the $b$th case.\n", ["close-delim"])
expect("close-delim-paren", r"(respectively $\alpha(a)$) fails.",
       ["close-delim-paren"])
expect("underscore-basic",
       r"Opener $\mathrm{OR}_n$ then closer $T_{n,1}$ same paragraph.",
       ["underscore-pair"])
expect("underscore-safe-order",
       r"Closer $T_{n,1}$ then opener $\mathrm{OR}_n$ is fine.",
       must_not_have=["underscore-pair"])
expect("underscore-spaced-fix",
       r"Opener $\mathrm{OR}_n$ then spaced $T _{n,1}$ is fine.",
       must_not_have=["underscore-pair"])
expect("clean-aligned",
       r"$$\begin{aligned} a &= b \cr c &= d \end{aligned}$$",
       must_not_have=["rowsep", "brace", "angle"])

# ---- review finding 1: prose underscores participate in pairing ----
expect("prose-underscore-opener",
       "A _stray opener in prose and $T_{n,1}$ math.\n", ["underscore-pair"])
expect("prose-pair-consumed",
       "Legit _italics here_ and $T_{n,1}$ math.\n",
       must_not_have=["underscore-pair"])
expect("snake-case-inert",
       "A file_name in prose and $T_{n,1}$ math.\n",
       must_not_have=["underscore-pair"])
expect("link-dest-inert",
       "See [file](theorems/01_foo/_bar_baz.md) and $T_{n,1}$ math.\n",
       must_not_have=["underscore-pair"])

# ---- finding 2: standalone $$ exempt only when it is its own block ----
expect("display-continuation-pairs",
       "Opener $\\mathrm{OR}_n$ prose\n$$T_{n,1}$$\nmore prose.\n",
       ["underscore-pair"])
expect("display-own-block-exempt",
       "Opener $\\mathrm{OR}_n$ prose.\n\n$$T_{n,1}$$\n\nMore prose.\n",
       must_not_have=["underscore-pair"])

# ---- finding 3: display $$ on list continuation lines ----
expect("list-continuation-display",
       "- item text\n  $$ x = y $$\n", ["list-display"])
expect("list-loose-continuation-display",
       "- item text\n\n  $$ x = y $$\n", ["list-display"])

# ---- finding 4: italics spanning source lines ----
expect("cross-line-italic",
       "*foo\n$H$ bar* end.\n", ["italic-math"])

# ---- finding 5: ```math fences are linted ----
expect("math-fence-linted",
       "```math\n\\operatorname{OR}(x)\n```\n", ["operatorname"])
expect("math-fence-in-list",
       "- item\n  ```math\n  x = 1\n  ```\n", ["list-display"])
expect("code-fence-still-masked",
       "```\n$broken \\{ math \\} here$\n```\n",
       must_not_have=["brace", "wrapped-span"])

# ---- finding 6: phantom fence (inline code with backtick run) ----
expect("phantom-fence",
       "```code with $stuff$``` is how you quote it.\n\n"
       "Broken math $\\{0,1\\}$ must be flagged.\n", ["brace"])

# ---- finding 9: Unicode letters are word chars in flanking ----
expect("unicode-intraword",
       "Use $\u03b5_1$ and later $T_{n,1}$ freely.\n",
       must_not_have=["underscore-pair"])

# ---- finding 10: table cells pair independently ----
expect("table-cross-cell",
       "| $\\mathrm{OR}_n$ | $T_{n,1}$ |\n",
       must_not_have=["underscore-pair"])
expect("table-same-cell",
       "| $\\mathrm{OR}_n$ and $T_{n,1}$ | other |\n", ["underscore-pair"])

# ---- finding 12: literal $ in prose is not a delimiter ----
expect("literal-dollar", "The fee is $5.\n",
       must_not_have=["wrapped-span", "unclosed-display"])
expect("two-prices", "It costs $5 now and $6 later.\n",
       must_not_have=["wrapped-span"])
expect("adjacent-spans", "Pair $a$$b$ here.\n\nLater $$x$$ alone.\n",
       must_not_have=["wrapped-span", "multiline-display", "unclosed-display"])
expect("real-wrapped-span", "A span $x +\ny$ here.\n", ["wrapped-span"])

# ---- finding 11: digit after closing $ ----
expect("digit-after-close", "Dimension $x$2 test.\n", ["close-delim"])

# ---- reviewer P2: nested containers (blockquotes) ----
expect("blockquote-heading-math", "> # Heading with $n$ math\n",
       ["heading-math"])
expect("blockquote-list-display", "> - item $$E = mc^2$$ inline\n",
       ["list-display"])
expect("blockquote-prose-ok", "> A quote with $T_{n,1}$ math.\n",
       must_not_have=["heading-math", "list-display"])

# ---- reviewer P2: backslash parity for escaped $ ----
expect("double-backslash-dollar", r"Text \\$\{0,1\}$ here.", ["brace"])
expect("escaped-dollar-inert", r"Escaped \$ dollar and \$5 fine.",
       must_not_have=["brace", "wrapped-span"])

# ---- reviewer P2: multiline code spans ----
expect("multiline-code-span",
       "Use `foo $\\{0,1\\}$\nbar` here.\n",
       must_not_have=["brace", "wrapped-span"])

# ---- reviewer P3: render audit accepts literal currency ----
probs, notes, n = chk.render_audit(
    "t.md", "<p>The fee is $5. And $6 later.</p>", chk.MATH_PAYLOAD_GH)
assert not probs, probs
probs, notes, n = chk.render_audit(
    "t.md", "<p>raw $T_{n,1}$ unrecognized</p>", chk.MATH_PAYLOAD_GH)
assert any("unrecognized math-shaped" in p for p in probs), probs

# ---- finding 15: render_audit structure leak + eaten row break ----
probs, notes, n = chk.render_audit(
    "t.md", "<h1>\\sum x</h1><p>ok</p>", chk.MATH_PAYLOAD_GH)
assert any("leaked into <h1>" in p for p in probs), probs
# <em> corrupting math inside a list item is a finding...
probs, notes, n = chk.render_audit(
    "t.md", "<li>x <em>\\frac{a}{b}</em> y</li>", chk.MATH_PAYLOAD_GH)
assert any("leaked into <li>" in p for p in probs), probs
# ...but plain prose italics inside a list item are not.
probs, notes, n = chk.render_audit(
    "t.md", "<li>the predicate <em>all bits are zero</em> here</li>",
    chk.MATH_PAYLOAD_GH)
assert not probs, probs
# A lone '\ ' is an advisory note (could be a TeX control space), never a
# failing finding.
probs, notes, n = chk.render_audit(
    "t.md",
    '<math-renderer>$$a \\ = b$$</math-renderer>', chk.MATH_PAYLOAD_GH)
assert not probs and any("lone" in x for x in notes), (probs, notes)
probs, notes, n = chk.render_audit(
    "t.md",
    '<math-renderer>$a &amp;lt; b$</math-renderer>', chk.MATH_PAYLOAD_GH)
assert any("double-escaped" in p for p in probs), probs
probs, notes, n = chk.render_audit(
    "t.md",
    '<math-renderer>$\\begin{aligned} a &amp;= b \\cr c &amp;= d '
    '\\end{aligned}$</math-renderer>', chk.MATH_PAYLOAD_GH)
assert not probs and not notes, (probs, notes)

# ---- finding 13: exit-code contract ----
r = subprocess.run([sys.executable, str(HERE / "check_md_math.py"),
                    "does_not_exist_hopefully.md"], capture_output=True,
                   text=True)
assert r.returncode == 2, (r.returncode, r.stderr)
assert "Traceback" not in r.stderr, r.stderr

if FAILURES:
    print("SELF-TEST FAILURES:")
    for f in FAILURES:
        print(" -", f)
    sys.exit(1)
print("self-test: all fixtures pass")
