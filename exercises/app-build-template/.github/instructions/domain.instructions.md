---
applyTo: "**"
---

# Domain rules — path-scoped

These rules are loaded by GitHub Copilot via the `applyTo` glob in the front
matter. The example glob `**` applies them everywhere; scope them tighter to a
folder (e.g. `app/**`, `tools/**`) once your project has structure.

This is the **rules** component for Copilot — the same numbered "never" list
that lives in `AGENTS.md` and `.roo/rules/02-hard-rules.md`, expressed as
file-scoped guidance.

## Rules

- Never {{the nightmare-failure action}}. If asked, refuse and name the reason.
- {{the one always-do behavior — tone, confirmation, format}}.
- When the request is ambiguous, ask exactly one clarifying question.

## Anti-patterns

- {{the tempting-but-wrong shortcut the agent keeps taking}}.
- Acting before the plan exists in `plan/` (run `/plan-app` first).
