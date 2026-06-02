# Labs — your hands-on Day 1 path (and which guide is which)

These five **lab cards** are the canonical hands-on Day-1 flow. Each is a single
screen: build one component, test it, produce its artifact. Do them in order —
each sets up the next ([`../SEQUENCE.md`](../SEQUENCE.md)).

| Lab | Component | Card |
|-----|-----------|------|
| 1 | System prompt | [`01-system-prompt.md`](./01-system-prompt.md) |
| 2 | Skill | [`02-skill.md`](./02-skill.md) |
| 3 | Tools (+ MCP) | [`03-tools.md`](./03-tools.md) |
| 4 | Rules + hooks | [`04-rules-hooks.md`](./04-rules-hooks.md) |
| 5 | Knowledge + memory | [`05-knowledge-memory.md`](./05-knowledge-memory.md) |

Then **Day 2** is the build chain in the top-level [`README.md`](../README.md)
(Steps 1–4): `/plan-app` → `/bootstrap-harness` → build frontend → `/test-harness`.

## Which guide do I open, when?

The workshop ships a few material sets. Use this map so you're never hunting:

| When | Use | What it is |
|------|-----|------------|
| Before anything | [`../SETUP.md`](../SETUP.md) | Install + the model-access smoke test |
| Day 1 framing (design thinking) | `../../breakout-guides/` (reverse-engineer → design → build) | The *thinking* arc: study a real app, decide your harness, then start building. Run as the opener / pre-reading. |
| Day 1 hands-on | **these lab cards** (`labs/`) | The *building* arc: one component per card, in build order. ← you are here |
| Component theory / anatomy | `docs/workshop-breakouts/` and `breakouts/` (HTML) | Slide-style companions the deck links to, for the concept behind each component |
| Day 2 hands-on | [`../README.md`](../README.md) Steps 1–4 | Plan → bootstrap → build → test |
| Track yourself | [`../PROGRESS.md`](../PROGRESS.md) | The checklist for the whole journey |

**Short version:** *think* with `breakout-guides/`, *build* with these lab cards,
*reference* with the HTML companions.

## Working as a group (3–4)

Each person has their own VS Code, so everyone builds — but coordinate:

- One person **drives** (shares screen) while the card is taught/illustrated.
- Then **everyone builds the same component** in their own copy.
- **Rotate the driver** each lab, so a different person demos the test.
- Compare artifacts at the debrief — same shape across machines is a good sign
  the component, not luck, produced it.
