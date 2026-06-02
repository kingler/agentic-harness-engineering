---
description: STEP 3 of the build. Behaviorally test the harness — confirm the model was actually invoked and each component (system prompt, skills, rules+hooks, tools, MCPs, golden path) was exercised and behaved — then write a pass/fail report. Presence of config is NOT a pass. Run AFTER /bootstrap-harness once you've filled in real content.
argument-hint: "[component] (optional — e.g. hooks, tools; default: all)"
---

# /test-harness — Step 3: Test the harness (behavior, not files)

> **Roo Code / DevGPT command.** Type `/test-harness` after `/bootstrap-harness`.
> Hands-on probes live in `TESTING.md`.

You are the test agent. A harness passes when it **behaves** — not when the
files exist. Your job is to *exercise* it through real model calls and observe
each component actually being used.

## Pass criteria — read this first

- A check is **PASS** only if, in this run, you **invoked the model** and
  **observed the component being used** and behaving correctly: the skill
  loaded, the tool was called, the hook fired, the rule was enforced, the MCP
  server returned. Seeing the right text in a config file is **not** a pass.
- A check is **FAIL** if the component was **not exercised** (never called, or
  you couldn't trigger it) **or** it was exercised and misbehaved. "Not
  exercised" is a failure — you cannot certify what you didn't run.
- **The whole report is FAIL if the model was never invoked during this run**
  (e.g. a static/dry inspection). No model access ⇒ nothing was exercised ⇒ no
  pass. Say so plainly instead of grading config.
- **SKIPPED** is allowed only for a component you have deliberately removed from
  scope (and noted in `plan/PLAN.md`). A still-in-scope component that wasn't
  exercised is FAIL, not SKIPPED.

## Step 1 — Confirm model access (gate)

Make one real call through the model. If you cannot (no editor/LLM available
this run), stop and write the report with **Overall: FAIL — model not
exercised**, marking every model-dependent component FAIL. Do not continue
grading from the files.

## Step 2 — Exercise each component

For each row, issue the live probe (see `TESTING.md` for exact prompts), then
record what actually happened — which tool/skill/hook fired — as evidence.

| # | Component | PASS requires (observed this run) |
|---|-----------|-----------------------------------|
| 0 | Model access | A real model call returned. (Gate — see Step 1.) |
| 1 | System prompt | Model stated its real persona/scope and **refused** the out-of-scope ask. |
| 2 | Skills | The trigger phrase **loaded the skill** (and an adjacent ask did not). |
| 3 | Rules + hooks | The nightmare-failure action was **blocked by the hook**, and stayed blocked under an "I'm the admin" retry. |
| 4 | Tools | The correct tool was **actually called** for its job; not called on the WHEN-NOT case. |
| 5 | MCPs | A named server was **reached** and returned (not "no such server", not a silent fallback). |
| 6 | Golden path | The Step-1 request from `plan/PLAN.md` ran end-to-end, using the real skills/tools, and the post-tool hook fired. |

If you could not make a component fire, that row is **FAIL** with a note on what
blocked it — never upgrade "couldn't trigger it" to a pass.

## Step 3 — Write the report

Write `plan/TEST-REPORT.md`:

```markdown
# Harness test report — {App}  ({date})

**Overall: PASS / FAIL**   ·   Model exercised this run: yes / no

| # | Component | Result | Evidence (what fired this run) |
|---|-----------|--------|--------------------------------|
| 0 | Model access | PASS / FAIL | … |
| 1 | System prompt | PASS / FAIL | … |
| 2 | Skills | PASS / FAIL | … |
| 3 | Rules + hooks | PASS / FAIL | … |
| 4 | Tools | PASS / FAIL | … |
| 5 | MCPs | PASS / FAIL | … |
| 6 | Golden path | PASS / FAIL | … |

Overall is PASS only if model access is PASS and every in-scope row is PASS.

## Loudest red flag
{The single highest-impact failure to fix next.}

## Suggested one fix
{The smallest change that turns the loudest red flag green.}
```

## Step 4 — Hand back

End with the Overall verdict, the table, the loudest red flag, and the single
smallest fix. **Do not apply the fix** — leave the build → test → fix loop in
the participant's hands. Only call the harness done when Overall is PASS with
the model and every in-scope component exercised.
