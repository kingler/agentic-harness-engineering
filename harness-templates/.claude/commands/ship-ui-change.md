---
name: ship-ui-change
description: End-to-end workflow for shipping a UI change — plans, edits, reviews, and verifies before commit.
---

# /ship-ui-change

Concept demonstrated: a **workflow** (skill chain). A workflow is a
named, ordered sequence of skills, subagents, and tools that together
accomplish one user-visible outcome.

This workflow ships a UI change end-to-end. Each step has an explicit
hand-off: the *output* of one step is the *input* of the next.

## Steps

1. **Plan** — invoke `/plan`. Output: one-page plan. Stop. Wait for
   "go" from the user.
2. **Research (if the plan flagged unknowns)** — delegate to the
   `researcher` subagent. Output: a citation-backed brief, max 200
   words. Quote it in the next step.
3. **Edit** — make the changes in the plan, in the order listed.
   Read each file before editing it. Do not edit files outside the
   plan's "Files I'll touch" list.
4. **Design review** — load the `design-review` skill on the diff.
   Output: a markdown checklist with file:line references.
5. **Fix-until-green** — invoke `/fix-until-green`. Cap 3 iterations.
6. **Summarise** — emit the final report:

```
## Ship report
- plan: <link to plan section>
- files changed: <list>
- design-review issues: <count, severity>
- tests: <green | red>
- next: <commit message draft | blocker>
```

## Rules

- Never skip a step silently. If you skip one, say which and why.
- Never commit inside this workflow — leave the working tree dirty
  for the user to review and commit.
- If any step's output is empty or off-format, restart that step
  once. If it fails twice, stop and ask.
