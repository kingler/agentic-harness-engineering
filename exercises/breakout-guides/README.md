# Planning Phase (Day 1) — before you build the components

Day 1 has two parts: a **planning phase** (these guides) and the **component
build** (five breakouts, one per harness component). This folder is the
*planning* half — the thinking you do **after you pick an app and before you
open the template**.

> **Naming, resolved.** The deck's **"Breakout 1–5"** are the *component build*
> breakouts (system prompt → skills → tools → hooks+rules → knowledge+memory).
> The **steps in this folder** are the *planning phase* that feeds them. Same
> workshop, two parts — not two competing numbering schemes.

## The planning phase, in order

| Step | Guide | You produce |
|------|-------|-------------|
| **1 · Reverse-engineer** | [`breakout-1-reverse-engineer.md`](./breakout-1-reverse-engineer.md) | a **harness map** of a real app's six components |
| **2 · Research the domain** | [`planning-domain-research.md`](./planning-domain-research.md) | a **domain map** — terms, real workflow, trust/compliance constraints |
| **3 · Design your harness** | [`breakout-2-design-harness.md`](./breakout-2-design-harness.md) | a **harness blueprint** — one decision per component |

Then planning hands off to the **component build** — five breakouts, one per
component — in [`../app-build-template/labs/`](../app-build-template/labs/)
(sequenced in [`../app-build-template/SEQUENCE.md`](../app-build-template/SEQUENCE.md)).
[`breakout-3-build-harness.md`](./breakout-3-build-harness.md) is the **on-ramp**:
it turns your blueprint into the first real files and points you into the five
component breakouts.

```
PLANNING PHASE                              COMPONENT BUILD (deck Breakouts 1–5)
pick app ─▶ 1 reverse-engineer ─▶           B1 system prompt ─▶ B2 skills ─▶
2 research the domain ─▶ 3 design  ──────▶  B3 tools ─▶ B4 hooks+rules ─▶
   (harness map + domain map + blueprint)   B5 knowledge+memory ─▶ Day 2
```

## Why a dedicated domain-research step

The reverse-engineered apps are **vertical** products — their hardest harness
decisions come from the domain, not the UI. Picking the app (Step 1) tells you
*what it does*; researching the domain (Step 2) tells you *what the domain
demands* — and those demands become your **hard rules, hooks, and knowledge**
when you build the components. Skipping it is how groups end up with a
plausible-looking harness that a real practitioner would never trust.
