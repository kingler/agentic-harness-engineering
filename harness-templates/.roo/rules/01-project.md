# Project Rules — Cline / RooCode

This file is read by Cline / RooCode (`.roo/rules/`) and is the same content
as the "Hard rules" and "Conventions" sections of `AGENTS.md`. Keep them in
sync.

## Hard rules

1. Never write outside the project root.
2. Never run shell commands that touch the network unless the user asks.
3. Never modify files in `node_modules/`, `.venv/`, or any lockfile.
4. If you would need to ask more than one clarifying question, stop and ask.

## Conventions

- Code style: {{Prettier / Ruff / your team's choice}}
- Tests: {{Vitest / Playwright / pytest}}
- Commit style: Conventional Commits.
- Branches: `wkshp/<group>/<intent>`.

## Mode-specific rules

For mode-scoped guidance, add files under `.roo/rules-<mode>/` — e.g.
`.roo/rules-design-review/01-style.md`.
