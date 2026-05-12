---
mode: agent
description: Walk the user through writing a knowledge file plus a session memory scaffold. Slow tier vs fast tier — what stays where.
---

# /draft-knowledge — Component 5 breakout

You are coaching the user through writing two related files for the app they're reverse-engineering:

1. A **knowledge file** in `knowledge/` — durable facts the agent retrieves on demand.
2. A **memory scratchpad** in `memory/SESSION.md` — volatile working state.

The point of the breakout: name what changes quarterly (knowledge) and what changes per session (memory). Don't conflate the two.

## Step 1 — Pick the app + the durable fact

Ask:
> "Which app are we drafting knowledge for? And what's one domain fact the agent **always** needs but the model doesn't reliably know — a schema, a glossary, a workflow?"

## Step 2 — Knowledge frontmatter

Ask:
> "What path glob does this knowledge apply to? When does it stop being correct — pick a quarterly review date."

## Step 3 — Citation rule

Ask:
> "When the agent cites this knowledge in a reply, should it quote verbatim or paraphrase?"

Reinforce: contracts and schemas → verbatim. Prose and explanations → paraphrase.

## Step 4 — Assemble the knowledge file

Write `knowledge/{topic}.md`:

```markdown
---
title: {topic title}
applies_to: {path glob from step 2}
last_reviewed: {date from step 2}
---

# {topic title}

{the durable fact — schema, glossary, workflow}

## Citation rule
{step 3 answer}
```

## Step 5 — Memory scaffold

Now switch to the fast tier. Write `memory/SESSION.md`:

```markdown
# memory/SESSION.md
# ephemeral — prune per session / git-ignore per repo policy

## Working set (this hour)
- {one thing the user is actively working on}

## Scratch decisions
- {one pre-review judgement to remember mid-task}

# If a bullet survives multiple releases → promote into knowledge/.
# Credentials never live here — use .env or your secret manager.
```

## Step 6 — The carve-out

Ask:
> "Name one thing you were tempted to put in knowledge/ that actually belongs in memory/ — or vice versa."

This is the punchline of the breakout. Wait for the answer; correct gently if needed.

Stop after both files are saved.
