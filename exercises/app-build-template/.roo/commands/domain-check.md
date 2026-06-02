---
description: Check a draft or output against the project's domain rules and knowledge base. The Roo Code / DevGPT equivalent of the Copilot domain-check skill.
argument-hint: "[file or selection to check]"
---

# /domain-check — Roo Code / DevGPT

This is the **skill** component on the Roo side. Roo has no `skills/` folder, so
the skill is expressed as a command. It mirrors
`.github/skills/domain-check/SKILL.md`.

## When to use

When the user wants their work checked against the domain — "does this follow
our rules?", "review for compliance", "validate this". Not for general questions
or code style.

## Steps

1. Read the relevant `knowledge/` files and the hard rules in
   `.roo/rules/02-hard-rules.md` / `AGENTS.md`.
2. Walk the target item by item. Mark each **OK**, **Fix**, or **Ask**.
3. For every **Fix**, quote the rule or knowledge fact it violates.
4. End with the single highest-impact fix. Don't rewrite the work — flag and
   cite; let the user decide.
