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
  template (`exercises/app-build-template/`): an app brief plus three chained
  slash commands, `/plan-app` (plan + wireframes + tech spec) →
  `/bootstrap-harness` (scaffolds the six harness components) →
  `/test-harness` (behavior test + `plan/TEST-REPORT.md`), with `TESTING.md`
  holding copy-paste probes per component. Mirrored for Copilot, RooCode, and
  Claude; zipped to `exercises/app-build-template.zip`.
  Both agendas in `Agentic Harness Engineering.html` were reworked around the
  breakout cadence: facilitator explains the components + the plan step and
  illustrates the activity live, then participants break out to plan → build →
  test. Breakouts were lengthened (Day 1 ~9→13–14 min each) by trimming
  debriefs; Day 2 adds an illustrate step and a dedicated testing breakout.
- `claude/context-prime-setup-ZbGZO` — root README, `.context/`
  directory, and pinned MCP package versions for the workshop.

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
