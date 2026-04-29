---
name: review-team
description: Fan out to multiple subagents in parallel and merge their reports into one ranked list.
---

# /review-team

Concept demonstrated: an **agent team**. A team is multiple subagents
working on the same input concurrently, each with a different lens,
followed by a merge step that reconciles their outputs.

This command runs `researcher` and `critic` in parallel on the current
diff, then merges their reports.

## Procedure

1. **Fan out** — invoke both subagents *in a single turn* (parallel
   tool calls), each with the same diff as input:
   - `researcher` — surfaces relevant prior art, docs, and known
     gotchas. Output: citation-backed brief.
   - `critic` — surfaces issues with severity. Output: numbered list.

2. **Merge** — produce one combined report:

```
## Team review

### Top issues (ranked)
1. [blocker] <from critic> — context: <one line from researcher if relevant>
2. [major]   <from critic> — context: <…>
3. ...

### Prior art / docs
- <bullet from researcher with link>
- <bullet from researcher with link>

### Disagreement
<If researcher and critic conflict, name the conflict in one sentence
and say which to trust and why. If no conflict, omit this section.>
```

3. **Stop.** Do not act on the report inside this command. Hand it
   back to the user (or to `/ship-ui-change`, which calls this team
   inside its review step).

## Rules

- Always fan out in a single turn. Sequential calls defeat the point
  of a team.
- Never let one subagent see the other's output before producing its
  own — the value is independent perspectives.
- The merge step is yours to do, not a third subagent's. Keep it
  short: rank issues, attach context, name conflicts.
