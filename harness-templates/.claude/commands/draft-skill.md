---
name: draft-skill
description: Walk the user through authoring a SKILL.md for the app they're reverse-engineering. Skill = directory, not a single file. Use when the user starts the Component 2 breakout.
---

# /draft-skill — Component 2 breakout

You are coaching the user through authoring an **Agent Skill** ([spec](https://agentskills.io)) for **Harvey**, **Claude for Financial Services**, or **Granola**.

A skill is a **directory** with `SKILL.md` as the required entrypoint. Bundled `scripts/`, `references/`, `assets/` are optional and loaded only when needed.

## Step 1 — Pick the app + name the skill

Ask:
> "Which app are we drafting a skill for? And what's the one specialized job this skill does? (one short noun-verb name, e.g. `review-disclosure`, `summarize-meeting`)"

The kebab-case answer becomes the directory name.

## Step 2 — Write the description (the trigger)

> "Finish this sentence in 1–2 lines: 'Use when the user asks to …'"

Reinforce: the `description` is what Claude reads to decide whether to load this skill. Treat it like UX microcopy for the loader.

## Step 3 — Write the body anatomy

For each section, ask one question and wait:

| Section | Question |
|---------|----------|
| **When to use** | "Three bullet points: who asks for this and when?" |
| **Steps** | "Numbered, mechanical steps the agent should follow." |
| **Bundled resources** | "Will this skill need a script (`scripts/`), reference doc (`references/`), or output template (`assets/`)?" |

## Step 4 — Assemble + save

Create the skill directory and write `SKILL.md`:

```
.claude/skills/{skill-name}/
├── SKILL.md
└── (any bundled resources the user named)
```

`SKILL.md` template:

```markdown
---
description: {step 2 answer — make it specific enough to trigger reliably}
allowed-tools: {only what's actually needed}
---

# {Skill name}

{One-line summary}

## When to use
- {bullet 1}
- {bullet 2}
- {bullet 3}

## Steps
1. {step 1}
2. {step 2}
3. {step 3}

## Additional resources
- {reference, script, or asset reference — or "none"}
```

Keep the body under 500 lines. Push detail into `references/`.

## Step 5 — Self-check

> "If you saw only the description, would you know when to load this skill? Tighten if not."

Stop after the file is saved.
