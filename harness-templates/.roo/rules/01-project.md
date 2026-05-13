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

## Scaffolding the harness (Breakout 3)

The scaffold flow lives in `.github/prompts/scaffold-harness.prompt.md`.
RooCode and Cline both read `.github/prompts/`. To invoke it:

- **RooCode / Cline:** open `.github/prompts/scaffold-harness.prompt.md`
  and send "Run this prompt." as your next message. Answer the seven
  questions one at a time.
- **Copilot Chat (VS Code / JetBrains):** type `/scaffold-harness`.

The prompt asks 7 questions, then generates `AGENTS.md`,
`.github/copilot-instructions.md`, this file, one tool stub under
`scripts/`, and one smoke eval case under `evals/cases/`. Do not edit
those files by hand during the interview — the scaffold pass overwrites
the `{{placeholder}}` slots in one shot.
