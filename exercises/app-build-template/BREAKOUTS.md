# Day 1 breakouts — the guided slash-command path

The Day 1 breakouts build your app's harness **one component per session**. You
can drive them two ways, on the same files:

- **Slash commands** (this guide) — interactive: a command introduces the
  component, walks your group through the planning questions, and writes the file
  with you. Start with `/breakout-setup`.
- **Lab cards** ([`labs/`](./labs/)) — the same five components as single-screen
  reference cards you fill in by hand.

Both produce the same harness. The commands are the facilitated path; the lab
cards are the at-a-glance version. Use whichever your group prefers — or run the
command and keep the matching lab card open as the cheat sheet.

## Start here

```
/breakout-setup
```

`/breakout-setup` introduces the arc, **scaffolds the harness-for-building-the-
harness** (the `.github/` and `.roo/` tree plus shared `AGENTS.md`, `knowledge/`,
`tools/`, `memory/`) if it isn't already present, and captures the app your group
chose into `app-brief.md`. Then it hands you to Breakout 1.

## The five sessions

Each command **builds on the last** ([`SEQUENCE.md`](./SEQUENCE.md)) — scope →
skill → tool → gate → grounding. Run them in order; a gap early shows up as a
failure later.

| # | Command | Component(s) | Writes | Builds on → sets up |
|---|---------|--------------|--------|---------------------|
| 0 | `/breakout-setup` | — | the harness tree + `app-brief.md` | the app pick → everything below |
| 1 | `/breakout-1-system-prompt` | System prompt | `AGENTS.md` + editor mirror | the brief → the scope every component honors |
| 2 | `/breakout-2-skills-subagents` | Skills + subagents | `SKILL.md` + `*.agent.md` | B1's scope → names the tool |
| 3 | `/breakout-3-tools-mcp` | Tools + MCP | `tools/` + `mcp.json` | B2's named tool → the risky action |
| 4 | `/breakout-4-hooks-rules` | Hooks + rules | `pre-tool-use.sh` + rules | B3's risky action → a gated path |
| 5 | `/breakout-5-knowledge-memory` | Knowledge + memory | `knowledge/` + `memory/` | B2's skill needs → grounded golden path |

Then **Day 2** assembles them: `/plan-app` → `/bootstrap-harness` → build the
frontend → `/test-harness` (top-level [`README.md`](./README.md), Steps 1–4).

## Which editor

Both editors read the shared `AGENTS.md`; everything else is mirrored:

- **GitHub Copilot** — commands live in `.github/prompts/*.prompt.md`; run them
  from Copilot Chat with `/breakout-…`.
- **Roo Code / DevGPT** — commands live in `.roo/commands/*.md`; run them from the
  Roo Code chat with `/breakout-…`.

Pick one lane and fill it; the other stays as shipped. See
[`EDITOR-PARITY.md`](./EDITOR-PARITY.md) for what each editor can demo natively
(notably how hooks fire in Breakout 4).

## How each breakout runs (~13–14 min)

1. **The facilitator** explains the component and illustrates it live in one
   editor.
2. **Your group** runs the command, answers its planning questions, and lets it
   write the file — then **tests** the component and saves the artifact under
   `evals/artifacts/`.
3. Quick debrief, then the command hands you to the next one.

Track progress in [`PROGRESS.md`](./PROGRESS.md).
