---
name: domain-check
description: Check a draft or output against the project's domain rules and knowledge base. Loads when the user asks to "check", "review for compliance", or "validate" work against the domain — e.g. "does this follow our rules?"
---

# Domain check (Copilot agent skill)

This is the **skill** component for Copilot. VS Code discovers it at
`.github/skills/domain-check/SKILL.md` (it also reads `.claude/skills/` and
`.agents/skills/`). The `description` above IS the trigger — phrase it the way a
real user would ask.

## When to use

Load this skill when the user wants their work checked against the domain — not
for general questions, and not for code style (that's the linter's job).

## Steps

1. Read the relevant `knowledge/` files and the hard rules in `AGENTS.md`.
2. Walk the draft/output item by item. For each, mark: **OK**, **Fix**, or
   **Ask**.
3. For every **Fix**, quote the rule or knowledge fact it violates.
4. End with the single highest-impact fix.

## What to skip

- Don't rewrite the user's work — flag and cite, let them decide.
- Don't invent rules that aren't in `knowledge/` or the hard rules.

## Files in this skill

Reference extra files with relative paths, e.g. a checklist at
`./checklist.md`, and Copilot loads them only when needed.
