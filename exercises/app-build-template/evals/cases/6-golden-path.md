# Eval · Golden path (the headline artifact)

> **Builds on:** every component above (system prompt → skill → tool → hook → knowledge/MCP).  **Sets up:** the live demo and the consistency proof.

**Component built?** all of the above + the `app/` frontend wired to the agent surfaces.

## Test prompt
> "{Step 1 of your golden path from `plan/PLAN.md`, phrased as a user request.}"

Let it run end-to-end through the real skills, tools, and hooks.

## Expected artifact
**The deliverable the whole harness exists to produce** — the one named in
`plan/PLAN.md` (e.g. a finished recap with action items, a drafted document, a
validated export). This is the artifact you'll demo.

Save to `../artifacts/6-golden-path-runN.md`.

## Consistency bar (run ×3, vary the input slightly)
- The artifact is produced end-to-end without you steering.
- It keeps the same structure and honors every invariant (refusals hold, the
  hook fires, uncertainty is flagged) across runs and across different inputs.

PASS = the headline artifact is generated consistently, with every component
observed firing along the way. This is the bar for calling the harness done.
