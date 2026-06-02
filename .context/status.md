# Project Status

## Stage

Workshop-ready scaffold. The deck and `harness-templates/` are both in
working shape; templates are deliberately stub-form (`{{PRODUCT NAME}}`,
`{{role}}` placeholders) because attendees fill them in.

## Last major change

Workshop redesign + harness templates merge (`a064931`):

- Restructured the workshop into a 2-day, 3-breakout format.
- Added the harness-templates scaffold mirrored across Claude Code,
  GitHub Copilot, and RooCode.
- Swapped the reverse-engineering targets to non-coding AI products
  (Harvey, Spellbook, Pilot, Notion AI, Granola).

## Active work

- `claude/agentic-harness-exercise-template-nw1Cx` — Day 2 app build
  template (`exercises/app-build-template/`): a downloadable VS Code project
  with the harness pre-wired into each extension's native folders —
  **GitHub Copilot** in `.github/` (`copilot-instructions.md`, `instructions/`,
  `prompts/`, `agents/`, `skills/`, `hooks/`) + `.vscode/mcp.json`, and
  **Roo Code / DevGPT** in `.roo/` (`rules/`, `commands/`, `mcp.json`); shared
  `AGENTS.md`, `knowledge/`, and `tools/` at root. Participants pick one
  extension. Three chained slash commands `/plan-app` → `/bootstrap-harness`
  → `/test-harness` plus `TESTING.md` probes drive plan → build → test.
  Folder locations follow the GitHub Copilot docs (docs.github.com/copilot).
  Zipped to `exercises/app-build-template.zip` (scripts keep exec bits).
  Both agendas in `Agentic Harness Engineering.html` were reworked around the
  breakout cadence: facilitator explains the components + the plan step and
  illustrates the activity live, then participants break out to plan → build →
  test. Breakouts were lengthened (Day 1 ~9→13–14 min each) by trimming
  debriefs; Day 2 adds an illustrate step and a dedicated testing breakout.
- `claude/context-prime-setup-ZbGZO` — root README, `.context/`
  directory, and pinned MCP package versions for the workshop.

## Participant-experience pass (app-build-template)

Added to smooth the end-to-end journey: `SETUP.md` (install + a one-prompt
model-access smoke test), `PROGRESS.md` (whole-journey checklist),
`EDITOR-PARITY.md` (Copilot vs Roo matrix + the hooks fallback), and `labs/`
(five consolidated component lab cards + a "which guide when" map and group
roles). `/bootstrap-harness` now augments Day-1 work instead of overwriting it.
Deck env slide points at the smoke test, labs, and PROGRESS.

**Deck entry point (resolved).** `index.html` is itself a ~20-section reveal.js
"Anatomy" deck (NOT an empty placeholder). Rather than overwrite it, added a
non-destructive landing page `start.html` linking to the current deck
(`Agentic Harness Engineering.html`), the Anatomy deck, presenter view, and the
hands-on materials. Root `README.md` updated to match. (Site root is still
`index.html` per vercel; point people at `/start` for the menu.)

## Known rough edges

- `index.html` is still a generic reveal.js placeholder; the actual
  slide content lives in `Agentic Harness Engineering.html`.
- `harness-templates/mcp.json` references MCP server packages that are
  illustrative — verify each package exists and is the one you want
  before running.
- `AGENTS.md` and `CLAUDE.md` are intentionally separate (AGENTS notes
  the differences); do not symlink them.

## Pointers for an agent reading this

- Workshop framing and per-file guide: `harness-templates/README.md`.
- Persona and hard rules template: `harness-templates/CLAUDE.md`.
- Permissions and hook bindings: `harness-templates/.claude/settings.json`.
- The same contract mirrored for other tools:
  `harness-templates/.github/`, `harness-templates/.roo/`.
