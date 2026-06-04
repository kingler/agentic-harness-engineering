# Participant Journey

*A facilitator-facing map of what the room actually experiences across the two
days of **Agentic Harness Engineering for Product & UX Designers**.*

Use this to brief co-facilitators, set expectations with attendees, or sanity-check
that every exercise still earns its place. It is a companion to the hands-on
material in [`breakout-guides/`](./breakout-guides/) and the Day 2 lab in
[`app-build-template/`](./app-build-template/).

---

## Who is in the room

- **Audience:** product and UX designers — not engineers. Many arrive assuming
  this is an engineering topic they're only visiting.
- **Format:** 2 days × ~2 hours. Work happens in **groups of 3–4** that stay
  together across every breakout.
- **Pacing target:** ~**60% hands-on, 40% lecture.**

The first job of the workshop is a reframe: *"You already touch the harness every
day — you just call it 'rules' or 'instructions.'"* The thesis they carry out is
**Agent = Model + Harness**, and *"if you're not the model, you're the harness"* —
the part designers can actually shape.

---

## The journey, end to end

```mermaid
flowchart TD
    Start(["Designers arrive · groups of 3–4"]) --> Frame["Reframe: Agent = Model + Harness<br/>'you already do this — you just call it rules'"]
    Frame --> Teach["Foundations + anatomy<br/>the 6 harness components"]

    subgraph PLAN["DAY 1 · PLANNING PHASE (breakout-guides/)"]
      direction TB
      Teach --> P1["P1 · Reverse-engineer<br/>pick Harvey / Claude FS / Granola<br/>output: harness map"]
      P1 --> P2["P2 · Research the domain<br/>terms · workflow · trust/compliance<br/>output: domain map"]
      P2 --> P3["P3 · Design<br/>decisions, not code<br/>output: harness blueprint"]
    end

    subgraph BUILD["DAY 1 · COMPONENT BUILD (deck Breakouts 1–5)"]
      direction TB
      P3 --> CB["B1 system prompt → B2 skills → B3 tools<br/>→ B4 hooks+rules → B5 knowledge+memory<br/>build &amp; test each · output: running harness"]
    end

    CB --> Bridge["The editor is the runtime<br/>AGENTS.md = system prompt · hooks fire on real tool calls"]

    subgraph DAY2["DAY 2 · make it real & prove it"]
      direction TB
      Bridge --> Figma["Design the frontend in Figma"]
      Figma --> Gen["Generate the UI · Copilot / RooCode"]
      Gen --> Chain["/plan-app → /bootstrap-harness → build → /test-harness"]
      Chain --> Artifact["Headline artifact<br/>generated consistently"]
    end

    Artifact --> Demo["Demos · 5m + 1m Q&A each<br/>judged on the tradeoff you can defend"]
    Demo --> Done(["Leave with a runnable harness folder<br/>+ vocabulary for what they already did"])
```

---

## Day 1 — from *"I use these apps"* to *"I built one"*

After a foundations and anatomy teach (the six components: **system prompt,
skills, tools, rules + hooks, knowledge + memory, evals**), Day 1 runs in two
parts — a **planning phase** (three steps) and a **component build** (five
breakouts, one per component) — chained into one continuous build.

### Planning phase · Step 1 — Reverse-engineer
Groups pick a *real shipped product* — **Harvey** (legal), **Claude for Financial
Services**, or **Granola** (meeting notes) — and reason backward from what they can
observe *as users* to the architecture underneath. The deck's metaphor: a chef
tasting a dish to infer the kitchen. Delight and frustration both reveal where the
harness's control ends.
**Output:** a **harness map** across the six components.
→ [`breakout-guides/breakout-1-reverse-engineer.md`](./breakout-guides/breakout-1-reverse-engineer.md)

### Planning phase · Step 2 — Research the domain
Once the app is picked, groups research what its **domain** demands — the
non-negotiables a real practitioner assumes (legal → privilege & citations;
finance → auditability & disclosure; meetings → recording consent). They start
from the app's `ai-apps/` profile, optionally search public sources, and mark
**confirmed vs. inferred**.
**Output:** a **domain map** — terms, real workflow, trust/compliance constraints.
→ [`breakout-guides/planning-domain-research.md`](./breakout-guides/planning-domain-research.md)

### Planning phase · Step 3 — Design
They flip direction: *"If WE built this, what decisions would we make?"* No code
yet — the thinking step. They lock a core intent, a **golden path** (X → Y → Z),
and a **nightmare failure mode**, then record six decisions as **Decision →
Rationale → Tradeoff accepted** — each defensible against the domain map.
**Output:** a **harness blueprint.**
→ [`breakout-guides/breakout-2-design-harness.md`](./breakout-guides/breakout-2-design-harness.md)

### Component build · Breakouts 1–5
Now **at keyboards.** The build is **five component breakouts**, one per harness
component — system prompt → skills → tools → hooks+rules → knowledge+memory —
each *built and tested* so its output is the artifact the harness should generate.
The blueprint becomes real files Copilot and RooCode read. The explicit message:
*you won't finish everything, and that's by design — "scope lock is a feature."*
**Output:** a **running harness**, component by component.
→ on-ramp: [`breakout-guides/breakout-3-build-harness.md`](./breakout-guides/breakout-3-build-harness.md) · the five labs: [`app-build-template/labs/`](./app-build-template/labs/)

> **The Day 1 payoff is a flip:** from *consumer* of these AI tools to *author* of
> one.

---

## Day 2 — assemble, prove, defend

Day 2 changes shape from *"learn the parts"* to *"make it real and show it works."*
Participants design a frontend in **Figma**, generate the UI with **Copilot /
RooCode**, then run the build-lab slash-command chain:

`/plan-app → /bootstrap-harness → build frontend → /test-harness`

The goal is a **headline artifact the harness produces *consistently*** — not just
once. It closes with **demos: 5 minutes per group, 1 minute of Q&A**, scored on a
rubric. The tone set from the front: *"We're not judging finish — we're judging the
tradeoff you can defend."* A recurring lens makes it land for designers: **each
agent transcript is a usability test.**
→ [`app-build-template/`](./app-build-template/) · [`app-build-template/SEQUENCE.md`](./app-build-template/SEQUENCE.md)

---

## Why it *feels* like one build, not six drills

Every exercise **consumes the artifact the previous one produced** and sets up the
next. A break early in the chain surfaces as a failure *later* — which teaches
participants to fix upstream first.

```mermaid
flowchart LR
    P1["Planning · reverse-engineer<br/>harness map"] --> P2["Planning · research domain<br/>domain map"]
    P2 --> P3["Planning · design<br/>blueprint"]
    P3 --> B1A["B1 · System prompt<br/>AGENTS.md"]
    B1A --> B2A["B2 · Skills<br/>SKILL.md — names a tool"]
    B2A --> B3A["B3 · Tools<br/>descriptor + script"]
    B3A --> B4A["B4 · Rules + Hooks<br/>pre-tool-use gate"]
    B4A --> B5A["B5 · Knowledge + Memory<br/>knowledge/ + memory plan"]
    B5A --> D2A["Day 2 · plan ▸ bootstrap ▸ build ▸ test<br/>headline artifact, consistently"]
```

| Phase | Builds on (input) | Participant produces | The feeling |
|---|---|---|---|
| **Planning · Reverse-engineer** | the app they picked | harness map | curiosity — *"oh, that delight was a harness decision"* |
| **Planning · Research the domain** | the map + the app's profile | domain map | grounding — *"this is what the domain actually demands"* |
| **Planning · Design** | map + domain map | harness blueprint | ownership — decisions become *theirs* |
| **Build · Breakouts 1–5** | the blueprint | running harness, component by component | momentum — *intuition becomes files* |
| **Day 2 · Assemble** | every decision above | wired app + headline artifact | proof — *"it actually runs"* |
| **Day 2 · Demo** | the working slice | a defended tradeoff | confidence — judged on judgment, not polish |

---

## Design constraints that shape the experience

- **The editor is the runtime.** API keys live *inside* the Copilot / RooCode
  extensions, so participants never train a model or stand up a server. They author
  markdown, JSON, and scripts; the extension's AI plays the agent. Their
  `AGENTS.md` is its system prompt, their hooks fire on real tool calls, their
  prototype is what a user clicks.
- **Scope lock is a feature.** Breakouts are deliberately too short to finish —
  the point is real decisions in real files, not a polished harness.
- **Same groups throughout.** Continuity lets each breakout consume the last one's
  work instead of restarting.
- **Defendable over finished.** The demo rubric rewards the tradeoff a group can
  articulate, not the most complete build.

---

## What participants walk out with

- A **runnable harness folder** they can drop into any project.
- A shared **vocabulary** — system prompt, skills, tools, rules/hooks,
  knowledge/memory, evals — for work many of them were already doing by instinct.
- The core reframe, internalized: **they design harnesses; the harness is where
  the product decisions live.**
