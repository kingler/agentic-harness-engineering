# Labs — your hands-on Day 1 path (and which guide is which)

Day 1 runs in two parts: a **planning phase** (`../../breakout-guides/` —
reverse-engineer → research the domain → design) and then the **component
build** below. These five **lab cards** are that build — the at-a-glance hands-on
flow once planning is done. Each is a single screen: build one component, test
it, produce its artifact. Do them in order — each sets up the next
([`../SEQUENCE.md`](../SEQUENCE.md)).

> **Prefer to be walked through it?** The `/breakout-*` slash commands
> ([`../BREAKOUTS.md`](../BREAKOUTS.md)) cover the same five components
> interactively — they introduce each one, ask the planning questions, and write
> the file with you. Start with `/breakout-setup`; these cards are the matching
> cheat sheet.

| Lab | Component | Card | Slash command |
|-----|-----------|------|
| 1 | System prompt | [`01-system-prompt.md`](./01-system-prompt.md) | `/breakout-1-system-prompt` |
| 2 | Skill (+ subagent) | [`02-skill.md`](./02-skill.md) | `/breakout-2-skills-subagents` |
| 3 | Tools (+ MCP) | [`03-tools.md`](./03-tools.md) | `/breakout-3-tools-mcp` |
| 4 | Rules + hooks | [`04-rules-hooks.md`](./04-rules-hooks.md) | `/breakout-4-hooks-rules` |
| 5 | Knowledge + memory | [`05-knowledge-memory.md`](./05-knowledge-memory.md) | `/breakout-5-knowledge-memory` |

Then **Day 2** is the build chain in the top-level [`README.md`](../README.md)
(Steps 1–4): `/plan-app` → `/bootstrap-harness` → build frontend → `/test-harness`.

## Which guide do I open, when?

The workshop ships a few material sets. Use this map so you're never hunting:

| When | Use | What it is |
|------|-----|------------|
| Before anything | [`../SETUP.md`](../SETUP.md) | Install + the model-access smoke test |
| Day 1 planning phase | `../../breakout-guides/` (reverse-engineer → research the domain → design) | Pick an app, map it, research its domain, decide your harness. Produces the **blueprint** the component build consumes. Start here. |
| Day 1 component build | **these lab cards** (`labs/`) | One component per card, in build order — the deck's Breakouts 1–5. ← you are here |
| Component theory / anatomy | `docs/workshop-breakouts/` and `breakouts/` (HTML) | Slide-style companions the deck links to, for the concept behind each component |
| Day 2 hands-on | [`../README.md`](../README.md) Steps 1–4 | Plan → bootstrap → build → test |
| Track yourself | [`../PROGRESS.md`](../PROGRESS.md) | The checklist for the whole journey |

**Short version:** *plan* with `breakout-guides/`, *build* with these lab cards,
*reference* with the HTML companions.

## Working as a group (3–4)

Each person has their own VS Code, so everyone builds — but coordinate:

- One person **drives** (shares screen) while the card is taught/illustrated.
- Then **everyone builds the same component** in their own copy.
- **Rotate the driver** each lab, so a different person demos the test.
- Compare artifacts at the debrief — same shape across machines is a good sign
  the component, not luck, produced it.
