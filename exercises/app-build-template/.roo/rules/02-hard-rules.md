# Hard rules — Roo Code / DevGPT

Read by Roo Code / DevGPT from `.roo/rules/`. This is the **rules** component for
Roo — the same numbered "never" list as `AGENTS.md` and
`.github/copilot-instructions.md`. Keep all three in sync.

## Hard rules

1. Never {{the nightmare-failure action}}. Refuse and name the reason. (Enforce
   it deterministically with the script in `.github/hooks/pre-tool-use.sh` — Roo
   can run the same script as a guard.)
2. Never write outside the project root.
3. Never run shell commands that touch the network unless the user asks.
4. If you would need to ask more than one clarifying question, stop and ask.

## Conventions

- Code style: {{Prettier / Ruff / your team's choice}}
- Tests: {{Vitest / Playwright / pytest}}
- Commit style: Conventional Commits.

## Note on skills & hooks in Roo

Roo Code expresses **skills** as commands (`.roo/commands/`) or custom modes
(`.roomodes`, `.roo/rules-<mode>/`), and does not ship a native hooks folder —
enforce "every-time" behavior by pointing a rule at the shell guard in
`.github/hooks/`. The harness shape is the same; the wiring differs per editor.
