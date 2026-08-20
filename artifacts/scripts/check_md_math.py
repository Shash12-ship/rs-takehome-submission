#!/usr/bin/env python3
"""Lint Markdown math so it renders on GitHub, GitLab, and KaTeX previews.

Static implementation of the rules in .claude/skills/gh-markdown-math/SKILL.md.
Zero dependencies for the default lint. Optional modes:

  --katex           validate every math span with katex.renderToString via node
                    (needs `npm install katex` in the repo root)
  --render-github   faithful render audit through `gh api markdown` (needs gh auth)
  --render-gitlab   faithful render audit through `glab api markdown` (needs glab auth)
  --context X/Y     repo context for the render APIs (default: pevogam/xorformer)

Exit status: 0 = clean, 1 = findings, 2 = usage/tooling error.
"""

import argparse
import html as html_lib
import json
import os
import re
import subprocess
import sys
import tempfile
from pathlib import Path

DEFAULT_CONTEXT = "pevogam/xorformer"


def is_word(ch):
    """Unicode-aware word character (cmark treats letters/digits as words)."""
    return ch.isalnum()


# (rule-id, regex, message) applied to the raw TeX of every $-delimited span.
# ```math fences bypass the Markdown inline layer, so only renderer-level
# rules apply there (see FENCE_RULES).
IN_MATH_RULES = [
    ("brace", re.compile(r"\\[{}]"),
     r"\{ \} get unescaped by GitHub; use \lbrace \rbrace"),
    ("spacing", re.compile(r"\\[,;!]"),
     r"\, \; \! get unescaped to literal punctuation; delete them"),
    ("star", re.compile(r"\*"),
     r"literal * is Markdown emphasis; use \ast"),
    ("operatorname", re.compile(r"\\operatorname\b"),
     r"\operatorname is unreliable on GitHub; use \mathrm"),
    ("hash", re.compile(r"\\#"),
     r"\# unescapes to a TeX error; use \lvert\lbrace...\rbrace\rvert"),
    ("angle", re.compile(r"(?<!\\)[<>]"),
     r"bare < > double-escape into KaTeX errors; use \lt \gt"),
    ("rowsep", re.compile(r"\\\\"),
     r"\\ row separators lose a backslash on GitHub; use \cr"),
    ("entity", re.compile(r"&#\w+;|&[A-Za-z]+;"),
     "HTML entity inside math breaks KaTeX previews; use the character or a TeX macro"),
]

FENCE_RULES = [
    ("operatorname", re.compile(r"\\operatorname\b"),
     r"\operatorname is unreliable on GitHub; use \mathrm"),
]


class Finding:
    def __init__(self, path, line, col, rule, message, excerpt=""):
        self.path, self.line, self.col = path, line, col
        self.rule, self.message, self.excerpt = rule, message, excerpt

    def __str__(self):
        loc = f"{self.path}:{self.line}:{self.col}"
        tail = f"  [{self.excerpt}]" if self.excerpt else ""
        return f"{loc}: {self.rule}: {self.message}{tail}"


class Span:
    """One math span. line is 1-based (first content line for fences).

    start0 / after0 are 0-based indexes of the opening delimiter and one past
    the closing delimiter on `line` (single-line spans only; multi-line $$
    blocks and fences cover their whole lines). content_off is the offset of
    content[0] from start0 (1 for $, 2 for $$, 0 for fences).
    """

    def __init__(self, line, start0, after0, content, display,
                 standalone=False, fence=False):
        self.line, self.start0, self.after0 = line, start0, after0
        self.content, self.display, self.standalone = content, display, standalone
        self.fence = fence
        self.content_off = 0 if fence else (2 if display else 1)
        self.own_block = False  # set by assign_blocks
        self.fence_opener_idx = None  # 0-based ``` line (fences only)
        self.fence_indent = 0

    @property
    def col(self):
        return self.start0 + 1

    def content_col(self, k):
        return self.start0 + self.content_off + k + 1


def mask_fenced_blocks(lines):
    """Blank out fenced blocks; return (masked, fence_spans) where the
    fence_spans are the contents of ```math fences (linted as display math).

    CommonMark guard: a backtick fence's info string may not contain a
    backtick; '```code $x$``` prose' is an inline code span, not a fence.
    """
    out, fence, fences = [], None, []
    math_open = None  # (opener_idx, indent, [content lines])

    def close_math():
        opener, indent, content = math_open
        s = Span(opener + 2, 0, 0, " ".join(l.strip() for l in content),
                 True, standalone=True, fence=True)
        s.fence_opener_idx, s.fence_indent = opener, indent
        fences.append(s)

    for idx, raw in enumerate(lines):
        stripped = raw.lstrip()
        if fence is None:
            m = re.match(r"(`{3,}|~{3,})(.*)$", stripped)
            if m and not (m.group(1)[0] == "`" and "`" in m.group(2)):
                fence = m.group(1)
                if m.group(2).strip().split()[:1] == ["math"]:
                    math_open = (idx, len(raw) - len(stripped), [])
                out.append("")
                continue
            out.append(raw)
        else:
            if stripped.startswith(fence) and stripped.rstrip("`~ ") == "":
                if math_open is not None:
                    close_math()
                    math_open = None
                fence = None
            elif math_open is not None:
                math_open[2].append(raw)
            out.append("")
    if math_open is not None:
        close_math()
    return out, fences


def is_escaped(line, i):
    """True when line[i] is escaped: preceded by an ODD run of backslashes
    (in '\\\\$' the first backslash escapes the second, so $ is live)."""
    n, j = 0, i - 1
    while j >= 0 and line[j] == "\\":
        n += 1
        j -= 1
    return n % 2 == 1


CODE_SPAN = re.compile(r"(`+)(?!`)[\s\S]*?(?<!`)\1(?!`)")


def mask_inline_code_lines(lines):
    """Blank out `code` spans, keeping line structure.

    CommonMark code spans may cross line breaks within a paragraph, so the
    masking runs on blank-line-separated chunks, not single lines.
    """
    out, start, n = list(lines), 0, len(lines)
    for i in range(n + 1):
        if i < n and lines[i].strip() != "":
            continue
        if i > start:
            chunk = "\n".join(lines[start:i])
            masked = CODE_SPAN.sub(
                lambda m: re.sub(r"[^\n]", " ", m.group(0)), chunk)
            if masked != chunk:
                for k, l in enumerate(masked.split("\n")):
                    out[start + k] = l
        start = i + 1
    return out


def mask_link_destinations(line):
    """Blank the URL part of [text](url): cmark never parses inlines there."""
    return re.sub(r"(\]\()([^()\s]*)(\))",
                  lambda m: m.group(1) + " " * len(m.group(2)) + m.group(3),
                  line)


def blank_region(line, start, end):
    return line[:start] + " " * (end - start) + line[end:]


def extract_spans(masked, path, findings):
    """Return (spans, prose): math spans, and lines with math blanked.

    Left-to-right scan per line: `$$` opens/closes display math (may cross
    lines); a single `$` opens inline math only when followed directly by a
    non-space and closes at the next unescaped `$` preceded by a non-space
    (GitHub does not recognize loosely-delimited spans, so a literal $ in
    prose - "costs $5" - is not a delimiter).
    """
    spans, prose = [], list(masked)
    leftovers = {}  # line idx -> list of 0-based cols of unpaired $
    open_display = None  # (line_idx, col)

    for i, line in enumerate(masked):
        pos, n = 0, len(line)
        while pos < n:
            if line[pos] != "$" or is_escaped(line, pos):
                pos += 1
                continue
            run = 1
            while pos + run < n and line[pos + run] == "$":
                run += 1
            if open_display is not None:
                if run >= 2:
                    oi, oj = open_display
                    if oi == i:
                        content = line[oj + 2:pos]
                        standalone = (line[:oj].strip() == ""
                                      and line[pos + 2:].strip() == "")
                        spans.append(Span(i + 1, oj, pos + 2, content, True,
                                          standalone))
                        prose[i] = blank_region(prose[i], oj, pos + 2)
                    else:
                        findings.append(Finding(
                            path, oi + 1, oj + 1, "multiline-display",
                            "multi-line $$ block; collapse it onto a single "
                            "line (GitHub leaks headings/bullets into it)"))
                        content = " ".join(
                            [masked[oi][oj + 2:]] + masked[oi + 1:i]
                            + [line[:pos]])
                        spans.append(Span(oi + 1, oj, oj + 2, content, True,
                                          True))
                        for k in range(oi, i + 1):
                            lo = oj if k == oi else 0
                            hi = pos + 2 if k == i else len(prose[k])
                            prose[k] = blank_region(prose[k], lo, hi)
                    open_display = None
                    pos += 2
                else:
                    pos += run  # single $ inside an open display block
                continue
            if run >= 2:
                open_display = (i, pos)
                pos += 2
                continue
            # Single $: a tight opener needs a non-space right after it.
            nxt = line[pos + 1] if pos + 1 < n else ""
            if nxt and not nxt.isspace():
                close = -1
                for j in range(pos + 1, n):
                    if (line[j] == "$" and not is_escaped(line, j)
                            and not line[j - 1].isspace()):
                        close = j
                        break
                if close > 0:
                    spans.append(Span(i + 1, pos, close + 1,
                                      line[pos + 1:close], False))
                    prose[i] = blank_region(prose[i], pos, close + 1)
                    pos = close + 1
                    continue
            leftovers.setdefault(i, []).append(pos)
            pos += 1

    if open_display is not None:
        oi, oj = open_display
        findings.append(Finding(path, oi + 1, oj + 1, "unclosed-display",
                                "unclosed $$ delimiter"))

    # Wrapped inline span: unpaired $ on two consecutive lines is the shape
    # of a $...$ span broken across a source line break.
    for i in sorted(leftovers):
        if i + 1 in leftovers:
            findings.append(Finding(
                path, i + 1, leftovers[i][-1] + 1, "wrapped-span",
                "unpaired $ here and on the next line; an inline span wrapped "
                "across a line break does not render - join it onto one line"))
    return spans, prose


class Block:
    def __init__(self, line_idxs, kind):
        self.line_idxs, self.kind = line_idxs, kind


BLOCKQUOTE = re.compile(r"^(?:\s{0,3}>\s?)+")


def build_blocks(masked):
    """Group line indices into blocks with kinds.

    Kinds: heading, table (one row each), list (item incl. continuation
    lines, and indented blocks continuing a list item across blank lines),
    footnote ([^label]: definition incl. continuation), para. Blockquote
    markers are stripped before classifying, so '> # H' is a heading and a
    list or display block inside a blockquote is still recognized.
    """
    blocks, cur, cur_kind = [], [], "para"
    last_kind = None

    def flush():
        nonlocal cur, cur_kind, last_kind
        if cur:
            blocks.append(Block(list(cur), cur_kind))
            last_kind = cur_kind
        cur, cur_kind = [], "para"

    for i, raw in enumerate(masked):
        line = BLOCKQUOTE.sub("", raw)
        stripped = line.strip()
        indent = len(line) - len(line.lstrip())
        if stripped == "":
            flush()
        elif re.match(r"#{1,6}\s", stripped):
            flush()
            blocks.append(Block([i], "heading"))
            last_kind = "heading"
        elif stripped.startswith("|"):
            flush()
            blocks.append(Block([i], "table"))
            last_kind = "table"
        elif re.match(r"[-*+]\s|\d+[.)]\s", stripped):
            flush()
            cur, cur_kind = [i], "list"
        elif re.match(r"\[\^[^\]]+\]:", stripped):
            flush()
            cur, cur_kind = [i], "footnote"
        else:
            if not cur and indent >= 2 and last_kind in ("list", "footnote"):
                cur_kind = last_kind  # continuation block after a blank line
            cur.append(i)
    flush()
    return blocks


def assign_blocks(spans, blocks):
    """Return spans indexed by 0-based line; mark block-level display math.

    A display span is block-level for GitHub (exempt from emphasis pairing)
    only when its line is a whole block by itself; a $$ line directly
    attached to prose is a paragraph continuation line and is NOT exempt.
    """
    by_line = {}
    for s in spans:
        by_line.setdefault(s.line - 1, []).append(s)
    for b in blocks:
        if len(b.line_idxs) == 1:
            for s in by_line.get(b.line_idxs[0], []):
                if s.display and s.standalone:
                    s.own_block = True
    for s in spans:
        if s.fence:
            s.own_block = True
    return by_line


def check_span_contents(spans, path, findings):
    for s in spans:
        for rule, rx, msg in (FENCE_RULES if s.fence else IN_MATH_RULES):
            for m in rx.finditer(s.content):
                findings.append(Finding(path, s.line, s.content_col(m.start()),
                                        rule, msg, excerpt=m.group(0)))
        if not s.display:
            m = re.search(r"\\begin\{(\w+)", s.content)
            if m:
                findings.append(Finding(
                    path, s.line, s.content_col(m.start()), "inline-env",
                    f"\\begin{{{m.group(1)}}} does not render in inline $...$ "
                    "on GitHub; use a standalone $$...$$ line (not in a list) "
                    "or rewrite as prose"))


def check_delimiters(spans, masked, path, findings):
    for s in spans:
        if s.display:
            continue
        line = masked[s.line - 1]
        before = line[s.start0 - 1] if s.start0 > 0 else ""
        after = line[s.after0] if s.after0 < len(line) else ""
        if before and (is_word(before) or before == "-"):
            findings.append(Finding(
                path, s.line, s.col, "open-delim",
                f"opening $ abuts '{before}'; it must be preceded by whitespace "
                "(reword, e.g. 'degree-$d$' -> 'degree $d$')"))
        if after and is_word(after):
            findings.append(Finding(
                path, s.line, s.after0 + 1, "close-delim",
                f"'{after}' immediately after closing $ kills the span; "
                "add a hyphen ('$b$-th') or space"))
        if s.content.rstrip().endswith(")") and after == ")":
            findings.append(Finding(
                path, s.line, s.after0 + 1, "close-delim-paren",
                "')$)' pattern: closing $ with punctuation on both sides fails; "
                "reword so the span is followed by a space or word"))


def underscore_flanks(prev, nxt):
    """(can_open, can_close) for a _ between prev and nxt, per cmark flanking.

    Unicode-aware: cmark treats any letter/digit as a word character, so
    intraword underscores next to non-ASCII letters (ε_1) are inert. A _
    with punctuation on BOTH sides can open AND close (verified on GitHub:
    two }_{ in one paragraph pair with each other). Line boundaries count
    as whitespace (soft break).
    """
    if prev == "\\":
        return False, False
    prev_ws = prev == "" or prev.isspace()
    nxt_ws = nxt == "" or nxt.isspace()
    prev_punct = not prev_ws and not is_word(prev)
    nxt_punct = not nxt_ws and not is_word(nxt)
    left = not nxt_ws and (not nxt_punct or prev_ws or prev_punct)
    right = not prev_ws and (not prev_punct or nxt_ws or nxt_punct)
    return (left and (not right or prev_punct),
            right and (not left or nxt_punct))


def split_table_cells(line):
    """(start, end) ranges of table cells, split on unescaped | (GFM parses
    each cell's inlines independently, so emphasis cannot pair across |)."""
    cells, start = [], 0
    for m in re.finditer(r"(?<!\\)\|", line):
        cells.append((start, m.start()))
        start = m.end()
    cells.append((start, len(line)))
    return [(a, b) for a, b in cells if line[a:b].strip()]


def check_emphasis(masked, blocks, by_line, path, findings):
    """Underscore emphasis pairing across a whole block, prose AND math.

    GitHub pairs an openable _ with a later closable _ anywhere in the same
    paragraph; when either end sits inside $-math, the math corrupts into
    <em>. A prose-opener/prose-closer pair is legitimate italics (the
    italic-math check flags math trapped inside it) and consumes the
    delimiters. Block-level display math, fences, and code are excluded;
    table cells pair independently.
    """
    for b in blocks:
        if b.kind in ("heading",):
            continue
        if b.kind == "table":
            i = b.line_idxs[0]
            scopes = [[(i, a, z)] for a, z in split_table_cells(masked[i])]
        else:
            scopes = [[(i, 0, len(masked[i])) for i in b.line_idxs]]
        for scope in scopes:
            opener = None  # (line_1based, col_1based, in_math)
            for i, lo, hi in scope:
                line = mask_link_destinations(masked[i])
                span_ranges = [(s.start0, s.after0)
                               for s in by_line.get(i, []) if not s.own_block]
                own_ranges = [(s.start0, s.after0)
                              for s in by_line.get(i, []) if s.own_block]
                for m in re.finditer("_", line[lo:hi]):
                    c = lo + m.start()
                    if any(a <= c < z for a, z in own_ranges):
                        continue  # inside block-level math: not inline text
                    if is_escaped(line, c):
                        continue
                    prev = line[c - 1] if c > lo else ""
                    nxt = line[c + 1] if c + 1 < hi else ""
                    can_open, can_close = underscore_flanks(prev, nxt)
                    in_math = any(a <= c < z for a, z in span_ranges)
                    if can_close and opener is not None:
                        if in_math or opener[2]:
                            findings.append(Finding(
                                path, i + 1, c + 1, "underscore-pair",
                                "this _ can close emphasis opened by the _ at "
                                f"line {opener[0]}:{opener[1]}, corrupting the "
                                "math into <em>. Insert a space before this _ "
                                "(e.g. '$T _{n,1}$')"))
                        opener = None  # the pair is consumed either way
                    elif can_open and opener is None:
                        opener = (i + 1, c + 1, in_math)


def check_structure(masked, prose, blocks, by_line, path, findings):
    kind_of = {}
    for b in blocks:
        for i in b.line_idxs:
            kind_of[i] = b.kind

    # ```math fence inside a list item: fence lines are blanked (no block),
    # so detect via the opener's indentation and the preceding list content.
    for ss in by_line.values():
        for s in ss:
            if not s.fence or s.fence_indent < 2:
                continue
            p = s.fence_opener_idx - 1
            while p >= 0 and masked[p].strip() == "":
                p -= 1
            if p >= 0 and kind_of.get(p) == "list":
                findings.append(Finding(
                    path, s.fence_opener_idx + 1, 1, "list-display",
                    "```math fences do not render inside list items; "
                    "use inline $...$"))

    for b in blocks:
        if b.kind == "heading":
            i = b.line_idxs[0]
            if by_line.get(i):
                findings.append(Finding(
                    path, i + 1, 1, "heading-math",
                    "math in a heading is unreliable on GitHub; "
                    "use plain text/Unicode"))
        elif b.kind == "list":
            for i in b.line_idxs:
                for s in by_line.get(i, []):
                    if s.display:
                        what = ("```math fences do" if s.fence
                                else "display $$ does")
                        findings.append(Finding(
                            path, s.line, s.col, "list-display",
                            f"{what} not render inside list items (including "
                            "continuation lines); use inline $...$"))
        elif b.kind == "footnote":
            for i in b.line_idxs:
                if by_line.get(i):
                    findings.append(Finding(
                        path, i + 1, 1, "footnote-math",
                        "math inside a footnote definition never renders on "
                        "GitHub (verified July 2026); use plain text/Unicode "
                        "or move the math to the body"))
                    break

        # \( \) / \[ \] delimiters are not math on GitHub, GitLab, or VS Code.
        for i in b.line_idxs:
            for m in re.finditer(r"\\[()\[\]]", prose[i]):
                findings.append(Finding(
                    path, i + 1, m.start() + 1, "paren-delim",
                    r"\( \) / \[ \] delimiters do not render as math on "
                    "GitHub/GitLab; use $...$ or $$...$$", excerpt=m.group(0)))

        # Math inside *italic* / _italic_ (bold ** is fine). Emphasis pairs
        # across soft line breaks, so scan the block's joined prose text.
        if b.kind == "table":
            continue
        joined, offsets = "", []
        for i in b.line_idxs:
            offsets.append((i, len(joined)))
            joined += prose[i] + " "
        italics = list(re.finditer(
            r"(?<![*\\])\*(?!\*)[^*]+?(?<![*\\])\*(?!\*)", joined))
        italics += list(re.finditer(
            r"(?<![\w\\])_(?!_)[^_]+?(?<!\\)_(?![\w])", joined))
        if not italics:
            continue
        for i, base in offsets:
            for s in by_line.get(i, []):
                if s.own_block:
                    continue
                a, z = base + s.start0, base + s.after0
                if any(m.start() < a and z <= m.end() - 1 for m in italics):
                    findings.append(Finding(
                        path, s.line, s.col, "italic-math",
                        "math inside single-* or _ italics is left raw on "
                        "GitHub; move it outside the emphasis "
                        "(bold ** is fine)"))


def lint_file(path):
    findings = []
    text = Path(path).read_text(encoding="utf-8")
    lines = text.split("\n")
    masked, fence_spans = mask_fenced_blocks(lines)
    masked = mask_inline_code_lines(masked)
    spans, prose = extract_spans(masked, path, findings)
    spans += fence_spans
    spans.sort(key=lambda s: (s.line, s.start0))
    blocks = build_blocks(masked)
    by_line = assign_blocks(spans, blocks)
    check_span_contents(spans, path, findings)
    check_delimiters(spans, masked, path, findings)
    check_emphasis(masked, blocks, by_line, path, findings)
    check_structure(masked, prose, blocks, by_line, path, findings)
    return findings, spans


KATEX_JS = r"""
const fs = require('fs');
let katex;
try { katex = require('katex'); }
catch (e) { console.error('NOKATEX'); process.exit(3); }
const spans = JSON.parse(fs.readFileSync(process.argv[2], 'utf8'));
let bad = 0;
for (const s of spans) {
  try {
    katex.renderToString(s.tex, {throwOnError: true, displayMode: s.display});
  } catch (e) {
    console.log(`${s.file}:${s.line}:${s.col}: katex: ` +
                String(e.message).split('\n')[0]);
    bad = 1;
  }
}
process.exit(bad);
"""


def run_katex(all_spans, repo_root):
    payload = [
        {"file": p, "line": s.line, "col": s.col, "tex": s.content,
         "display": s.display}
        for p, spans in all_spans for s in spans
    ]
    with tempfile.TemporaryDirectory() as td:
        js = Path(td) / "kcheck.js"
        data = Path(td) / "spans.json"
        js.write_text(KATEX_JS)
        data.write_text(json.dumps(payload))
        env = dict(os.environ)
        env["NODE_PATH"] = str(Path(repo_root) / "node_modules")
        try:
            proc = subprocess.run(["node", str(js), str(data)],
                                  capture_output=True, text=True, env=env)
        except FileNotFoundError:
            print("katex: node not found on PATH; install node or skip --katex",
                  file=sys.stderr)
            return 2
    if proc.returncode == 3:
        print("katex: node module 'katex' not found; run `npm install katex` "
              "in the repo root (or skip --katex)", file=sys.stderr)
        return 2
    sys.stdout.write(proc.stdout)
    if proc.stderr.strip():
        sys.stderr.write(proc.stderr)
    return 1 if proc.returncode else 0


MATH_PAYLOAD_GH = re.compile(
    r"<math-renderer[^>]*>(?P<tex>.*?)</math-renderer>", re.S)
MATH_PAYLOAD_GL = re.compile(
    r"<(span|code|pre)[^>]*data-math-style=\"(?:inline|display)\"[^>]*>"
    r"(?P<tex>.*?)</\1>", re.S)
CODEBLOCK = re.compile(r"<pre[^>]*>.*?</pre>|<code[^>]*>.*?</code>", re.S)
STRUCTURE = re.compile(r"<(h[1-6]|li)\b[^>]*>(?P<seg>.*?)</\1>", re.S)


def render_audit(path, html, payload_rx):
    """Skill audit: residual $, double-escaped payloads, structure leaks,
    plus advisory notes for possible eaten row breaks.

    A healthy alignment & appears as &amp; in the raw HTML (normal escaping,
    decoded by the browser before the math engine sees it) on both GitHub
    and GitLab. Genuine double-escaping is an entity that SURVIVES one
    decode, e.g. raw &amp;lt; -> decoded &lt; -> KaTeX parse error.

    A lone '\\ ' in a payload is only a NOTE, not a finding: '\\ ' is also
    the legitimate TeX control space, so it needs a source comparison to
    tell an eaten \\\\ from intentional spacing. Likewise <em> inside <li>
    is normal prose italics; it is a finding only with TeX inside it.
    """
    findings, notes = [], []
    payloads = [m.group("tex") for m in payload_rx.finditer(html)]
    stripped = payload_rx.sub(" ", html)
    stripped = CODEBLOCK.sub(" ", stripped)
    # A residual $ counts only when a tight $...$ pair survived outside the
    # recognized math, mirroring the static delimiter rule: literal currency
    # in prose ("The fee is $5.") is fine, an unrecognized span is not.
    residual = re.findall(r"\$(?!\s)[^$\n]*?(?<!\s)\$", stripped)
    if residual:
        findings.append(f"{path}: render: {len(residual)} unrecognized "
                        "math-shaped $...$ pair(s) outside math, e.g. "
                        f"{residual[0][:80]!r}")
    for p in payloads:
        decoded = html_lib.unescape(p)
        m = re.search(r"&(?:[A-Za-z]+|#\w+);", decoded)
        if m:
            findings.append(f"{path}: render: double-escaped entity "
                            f"{m.group(0)!r} inside math payload: {p[:80]!r}")
        if re.search(r"(?<!\\)\\ ", decoded):
            notes.append(f"{path}: note: lone '\\ ' inside math payload "
                         "(eaten \\\\ row break, or intentional control "
                         f"space - compare with the source): {p[:80]!r}")
    for m in STRUCTURE.finditer(stripped):
        seg = m.group("seg")
        leaked = bool(re.search(r"\\(?:sum|frac|begin)\b", seg))
        if not leaked:
            leaked = any(re.search(r"\\[A-Za-z]+|\$", em.group(1))
                         for em in re.finditer(r"<em>(.*?)</em>", seg, re.S))
        if leaked:
            findings.append(f"{path}: render: raw TeX/emphasis leaked into "
                            f"<{m.group(1)}>: {seg.strip()[:80]!r}")
    return findings, notes, len(payloads)


def render_github(path, context):
    body = json.dumps({"text": Path(path).read_text(encoding="utf-8"),
                       "mode": "gfm", "context": context})
    try:
        proc = subprocess.run(["gh", "api", "markdown", "--input", "-"],
                              input=body, capture_output=True, text=True)
    except FileNotFoundError:
        raise RuntimeError("gh CLI not found on PATH (needed for --render-github)")
    if proc.returncode:
        raise RuntimeError(f"gh api markdown failed for {path}: "
                           f"{proc.stderr.strip()}")
    return render_audit(path, proc.stdout, MATH_PAYLOAD_GH)


def render_gitlab(path, context):
    body = json.dumps({"text": Path(path).read_text(encoding="utf-8"),
                       "gfm": True, "project": context})
    try:
        proc = subprocess.run(
            ["glab", "api", "markdown", "--method", "POST", "--input", "-",
             "-H", "Content-Type: application/json"],
            input=body, capture_output=True, text=True)
    except FileNotFoundError:
        raise RuntimeError("glab CLI not found on PATH (needed for --render-gitlab)")
    if proc.returncode:
        raise RuntimeError(f"glab api markdown failed for {path}: "
                           f"{proc.stderr.strip()}")
    try:
        html = json.loads(proc.stdout).get("html", "")
    except json.JSONDecodeError:
        raise RuntimeError(f"glab api markdown returned non-JSON for {path}")
    return render_audit(path, html, MATH_PAYLOAD_GL)


def main():
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("files", nargs="+")
    ap.add_argument("--katex", action="store_true",
                    help="also validate spans with KaTeX via node")
    ap.add_argument("--render-github", action="store_true",
                    help="faithful GitHub render audit via `gh api markdown`")
    ap.add_argument("--render-gitlab", action="store_true",
                    help="faithful GitLab render audit via `glab api markdown`")
    ap.add_argument("--context", default=DEFAULT_CONTEXT,
                    help=f"repo context for render APIs (default {DEFAULT_CONTEXT})")
    args = ap.parse_args()

    status = 0
    all_spans = []
    for f in args.files:
        try:
            findings, spans = lint_file(f)
        except (OSError, UnicodeError) as e:
            print(f"error: cannot read {f}: {e}", file=sys.stderr)
            status = max(status, 2)
            continue
        all_spans.append((f, spans))
        for fd in sorted(findings, key=lambda x: (x.line, x.col)):
            print(fd)
        if findings:
            status = max(status, 1)

    n_files = len(args.files)
    n_spans = sum(len(s) for _, s in all_spans)

    if args.katex:
        status = max(status, run_katex(all_spans,
                                       Path(__file__).resolve().parents[2]))

    for flag, renderer, name in (
            (args.render_github, render_github, "github"),
            (args.render_gitlab, render_gitlab, "gitlab")):
        if not flag:
            continue
        total_math = 0
        for f, _ in all_spans:
            try:
                probs, notes, n_math = renderer(f, args.context)
            except (RuntimeError, OSError) as e:
                print(e, file=sys.stderr)
                status = max(status, 2)
                continue
            total_math += n_math
            for note in notes:
                print(note, file=sys.stderr)
            for p in probs:
                print(p)
            if probs:
                status = max(status, 1)
        print(f"[{name}] {n_files} files, {total_math} rendered math spans",
              file=sys.stderr)

    print(f"[lint] {n_files} files, {n_spans} math spans, "
          f"{'FINDINGS' if status else 'clean'}", file=sys.stderr)
    return status


if __name__ == "__main__":
    sys.exit(main())
