# Project guidance for Claude Code

> **Read [`CODEX_WORKFLOW.md`](CODEX_WORKFLOW.md) and follow it.** It distills the
> hard-won, working pattern for driving Codex (and delegated subagents) on this
> project's Lean proofs — the non-negotiables (`</dev/null`; Codex can't run long
> builds; keep questions focused or it loops), what Codex is good/bad at, the
> consult→write→build→verify loop, and how to safely parallelize by delegating
> well-specified subtasks. Prefer this workflow by default for nontrivial Codex
> use. **And keep improving it:** when you learn something new about working with
> Codex/subagents (a failure mode, a sharper prompt shape, a better delegation
> contract), update `CODEX_WORKFLOW.md` so the next session inherits it.

## Consulting Codex (second opinion)

You have access to OpenAI's Codex CLI as a peer reviewer. Use it to get a
second opinion when you are genuinely uncertain — not for routine work.

**When to consult Codex:**
- You're stuck on a bug after one or two failed attempts.
- You're choosing between two non-obvious design/architecture approaches.
- You've written something tricky (concurrency, security-sensitive, perf-critical)
  and want an independent review before finalizing.
- The user explicitly asks for a cross-check.

**Do NOT consult Codex for:** trivial edits, formatting, things you're confident
about, or anything where a round-trip wastes time.

**How to consult it:**

Run Codex in non-interactive mode. It prints only its final answer to stdout.
**Always redirect stdin from `/dev/null`** (`codex exec "..." </dev/null`):
`codex exec` reads the prompt from its argument *and also drains stdin*, so
without a closed stdin it blocks forever on "Reading additional input from
stdin..." — this is guaranteed to hang when launched as a background job
(`run_in_background`), where stdin is an open pipe that never sends EOF. The
redirect makes it take only the argument prompt and return.

```bash
codex exec "Context: <concise summary of the problem, relevant code, and what
I've already tried>. Question: <the specific thing I'm unsure about>." </dev/null
```

For a review of an actual file or diff, pass the content in the prompt or point
Codex at the path:

```bash
codex exec "Review this function for correctness and edge cases, then list any
bugs you find:

$(cat path/to/file.py)" </dev/null
```

Tip: for a long prompt, write it to a file and pass it as
`codex exec "$(cat prompt.txt)" </dev/null` — easier to get the quoting right
than a giant inline heredoc.

Caveat — `</dev/null` vs long commands: the closed stdin also means Codex
cannot keep an interactive stdin for *long-running* sub-commands it spawns
(e.g. a 90 s `lake build`); it errors with "stdin is closed for this session;
rerun exec_command with tty=true". So for a background consult, keep Codex's
own command-running light: ask it to **reason from reading the code** and tell
it the build/verify results yourself, rather than having it run heavy builds.
Codex *can* run `lake`/`lean` (they're on its `PATH` via `~/.bashrc` →
`ELAN_HOME=/gpfs/work5/0/gusr0688/fair_stuff/.elan`), but a 90 s+ compile under
a closed stdin is what breaks — short commands (`grep`, `lake --version`) are
fine.

By default `codex exec` is read-only (it cannot edit files), which is what you
want for a consult. Do not give it write access unless explicitly asked.

**After consulting:**
- Treat Codex's answer as advice, not ground truth. Weigh it against your own
  reasoning and the actual code.
- If you act on its suggestion, briefly tell the user you consulted Codex and
  what it said, so the decision trail is visible.
- If Codex and you disagree, surface both views to the user rather than silently
  picking one.

## Brainstorm with Codex while waiting on long tasks

When you kick off a long-running task (a build, a compile, a test suite, a proof
check), run it in the **background** (`run_in_background`) rather than blocking on
it. Then use that idle window productively: if you have an open doubt about the
codebase — an unclear invariant, a design question, an edge case you're unsure
how the code handles — brainstorm it with Codex instead of just waiting.

This is a *use the dead time* habit, not a request for a final answer:
- Frame it as a brainstorm: share the relevant code/context and think out loud
  with Codex about the uncertainty, alternatives, or what could go wrong.
- Keep it bounded — one focused question per idle window, not a research project.

**Run the brainstorm in the background too.** A foreground `codex exec` blocks
you — so instead of waiting on the compile, you'd just be waiting on Codex, which
defeats the purpose. Launch the consult itself as a background job
(`run_in_background`) and let the harness monitor it the same way it monitors a
background build: you get re-invoked when it exits. That way the compile and the
Codex consult run concurrently, and you react to whichever finishes first instead
of blocking on either. **Remember the `</dev/null` redirect** (see above) — it is
mandatory for background consults, which otherwise hang on stdin and never return.

When a background job finishes — build or consult — fold any useful insight back
into the work and treat Codex's input as advice, per the consult guidance above.

Don't manufacture doubts to fill time, and don't let brainstorming delay reacting
to the task once it completes. The point is to convert otherwise-wasted waiting
into a second opinion on something you genuinely were unsure about.

## One-time setup (human, do this once)

1. Install Codex CLI (see https://developers.openai.com/codex/cli).
2. Run `codex` once and sign in with your ChatGPT account so usage draws from
   your existing plan.
3. Verify it works: `codex exec "say hello"` should print a reply.