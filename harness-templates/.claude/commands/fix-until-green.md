---
name: fix-until-green
description: Run tests, fix the first failure, repeat until green or 3 iterations.
---

# /fix-until-green

Concept demonstrated: a **loop**. Most useful agent loops have the shape
*observe → act → re-observe*, with a hard cap so a stuck agent doesn't
burn the budget.

## Procedure

Repeat at most 3 times:

1. **Observe.** Run the test suite (`npm test`, `pytest`, etc. — pick the
   one in `CLAUDE.md` Conventions). Capture the first failing test's
   name, file, and assertion.
2. **Decide.** If zero failures, stop and report green.
   If the same failure repeats two iterations in a row with no progress,
   stop and escalate — do not keep editing.
3. **Act.** Make the smallest edit that addresses the first failing
   test. Do not refactor neighbouring code.
4. **Re-observe.** Re-run only the failing test file, not the whole
   suite, to confirm the fix.

After 3 iterations, regardless of outcome, stop and emit:

```
## Loop result
- iterations: <n>
- final state: <green | red | stuck>
- last failure: <test name>
- files changed: <list>
```

## Rules

- Never use `--no-verify`, `-x`, or any flag that hides failures.
- Never delete a test to make it pass.
- If the test itself looks wrong, stop and ask — do not edit the test.
