---
name: improve
description: Review recent transcripts and edits log, propose one prompt or skill change, evaluate it, and report.
---

# /improve

Concept demonstrated: **learning**. A harness improves not by training
the model but by refining its prompts, skills, hooks, and tools based
on what real sessions reveal. This command runs one cycle of that
loop.

## Procedure

1. **Gather signal.** Read:
   - The last 20 entries in `.claude/log/edits.log`.
   - Any failing cases in the most recent eval run (`scripts/run-eval.sh golden`).
   - Up to 5 recent session transcripts the user points you at.

2. **Find one pattern.** Pick *one* recurring issue. Don't fan out.
   Examples: "agent keeps editing the wrong file", "design-review skill
   misses contrast issues", "researcher cites blog posts when official
   docs exist".

3. **Propose one change.** Write a single, minimal edit to *one* file:
   `CLAUDE.md`, a skill, a subagent, or a hook. State:
   - The pattern (one sentence).
   - The change (a diff or a quoted before/after).
   - The hypothesis (why this should fix it, in one sentence).

4. **Evaluate.** Run `scripts/run-eval.sh golden`. Compare pass/fail
   counts to the previous run.

5. **Report.**

```
## Improve cycle
- pattern: <one sentence>
- change: <file>:<lines> — <before/after>
- evals before: <pass>/<total>
- evals after:  <pass>/<total>
- recommendation: <merge | discard | needs more data>
```

## Rules

- One change per cycle. Stacking changes hides which one helped.
- Never modify a test or eval case to make a failing run pass.
- If evals don't move, recommend `discard`. Don't argue.
- The user, not the agent, ships the change. Stop after the report.
