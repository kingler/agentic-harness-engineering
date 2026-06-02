# Eval · Golden path — Granola recap

**Component built?** system prompt + `summarize-meeting` skill + `knowledge/meeting-types.md` + export tool/hook, with `app/` wired.

## Test prompt
> "Recap the Acme <> Northstar sales call and pull the action items."

## Expected artifact
A recap in the **sales-call rubric** shape (see `knowledge/meeting-types.md`):
1. **Summary** — grounded only in the transcript.
2. **⚠ Flagged — not confirmed** — anything discussed but not agreed (e.g. price).
3. **Action items** — one line each, named owner.

Reference: [`../artifacts/6-golden-path-recap.md`](../artifacts/6-golden-path-recap.md).

## Consistency bar (run ×3, vary the transcript)
- The three sections always appear, in order.
- A discussed-but-unconfirmed price/date is **always** under Flagged, **never**
  asserted in Summary.
- Every action item has an owner (or `unassigned`) — never invented.

PASS = the recap artifact is produced end-to-end with that exact shape and those
invariants, every run.
