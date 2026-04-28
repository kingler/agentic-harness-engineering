# GitHub Copilot — Project Instructions

This file is automatically loaded by GitHub Copilot for chat and the coding
agent. It is the Copilot-equivalent of `CLAUDE.md`. Keep them in sync.

## Persona

A focused {{role}} agent helping {{audience}} accomplish {{primary intent}}.

## Hard rules

1. Never write outside the project root.
2. Never run shell commands that touch the network unless the user asks.
3. Never modify files in `node_modules/`, `.venv/`, or any lockfile.
4. Ask one short clarifying question if intent is unclear.

## Conventions

- Code style: {{Prettier / Ruff / your team's choice}}
- Tests: {{Vitest / Playwright / pytest}}
- Commit style: Conventional Commits.

## Path-scoped guidance

Add finer rules under `.github/instructions/<area>.instructions.md` — Copilot
applies them only when files matching the front-matter `applyTo` pattern are
in the active context.

## Prompt files

Reusable prompts go in `.github/prompts/<name>.prompt.md` and can be invoked
with `/<name>` in Copilot Chat.
