# GitHub Copilot — Project Instructions

This file is automatically loaded by GitHub Copilot for chat and the coding
agent (VS Code, JetBrains, GitHub.com, Copilot CLI). Keep it in sync with
`AGENTS.md`.

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

## How this harness is laid out

- `.github/copilot-instructions.md` (this file) — repo-wide guidance for
  every chat request.
- `.github/instructions/*.instructions.md` — path-scoped rules. Each file
  has an `applyTo:` glob in its YAML front-matter and is loaded only when a
  matching file is in context. See `frontend.instructions.md` for an
  example.
- `.github/prompts/*.prompt.md` — reusable prompts you can invoke with `/`
  in Copilot Chat (VS Code, Visual Studio, JetBrains). See `plan.prompt.md`
  for an example.
- `.github/agents/<name>.md` — custom agents (cloud + CLI). YAML
  front-matter declares `name`, `description`, and `tools`. See
  `researcher.md` for an example.

## Cross-surface sync

This same harness is mirrored to:

- `AGENTS.md` — read by Copilot's coding agent and Cline / RooCode.
- `.roo/rules/01-project.md` — RooCode / Cline workspace rule.

When you change one, change both. They are the same brief, two surfaces.

## References

- VS Code · Custom instructions — code.visualstudio.com/docs/copilot/customization/custom-instructions
- GitHub Docs · Repository custom instructions — docs.github.com/copilot/customizing-copilot/adding-custom-instructions-for-github-copilot
- Prompt files — docs.github.com/en/copilot/tutorials/customization-library/prompt-files
- Custom agents — docs.github.com/en/copilot/concepts/agents/cloud-agent/about-custom-agents
