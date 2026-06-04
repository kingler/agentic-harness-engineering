# Build sequence — each exercise builds on the last

The breakouts are **one continuous build**, not six unrelated drills. Each
exercise consumes the artifact the previous one produced and sets up the next.
By the end you don't have six fragments — you have one harness that generates a
headline artifact end to end.

```
Day 1 — PLANNING PHASE first (breakout-guides/), then build the components:

 pick app ─▶ P1 Reverse-engineer ─▶ P2 Research the domain ─▶ P3 Design
                harness map              domain map              blueprint
                                                                     │
                                                                     ▼
 B1 System prompt ─▶ B2 Skills ─▶ B3 Tools ─▶ B4 Rules+Hooks ─▶ B5 Knowledge+Memory
   AGENTS.md          SKILL.md     tool+script   pre-tool hook     knowledge/ + memory/
        │                │             │              │                    │
        └─ scope/persona ┴─ names tool ┴─ risky action ┴─ safe to ground ──┘
                                                                            ▼
Day 2 — assemble & prove it:

  /plan-app ─▶ /bootstrap-harness ─▶ build frontend ─▶ /test-harness
    plan          components wired       app/             headline artifact, consistently
```

## The thread, exercise by exercise

| # | Exercise | Builds on (input) | You produce | Sets up (for next) |
|---|----------|-------------------|-------------|--------------------|
| P1 | **Reverse-engineer** (planning) | the app you picked | a **harness map** of a real app's six components | P2 — the behaviors whose *domain* you'll investigate |
| P2 | **Research the domain** (planning) | P1's map + the app's `ai-apps/` profile | a **domain map** — terms, real workflow, trust/compliance constraints | P3 — the non-negotiables your design must honor |
| P3 | **Design** (planning) | P1 + P2 | a **harness blueprint** — one decision per component | the brief + every component breakout below |
| 0 | **App brief** | the planning phase | `app-brief.md` — core features, value prop, problem | the material every exercise draws on |
| B1 | **System prompt** | the brief | `AGENTS.md` — persona, scope, the one hard "never" | the voice + scope every later component must honor; names the **risky surface** B4 will guard |
| B2 | **Skills** | B1's persona + scope | the core `SKILL.md` that makes the deliverable; it **names the tool it needs** | B3 — the tool the skill will call |
| B3 | **Tools** | the tool B2 named | the tool descriptor (WHAT/WHEN/WHEN-NOT) + script | B4 — the **risky action** that needs a deterministic gate |
| B4 | **Rules + hooks** | B3's risky action + B1's hard rule | the `pre-tool-use` hook that blocks the "never" | B5 — now that the dangerous path is gated, the agent can safely reach for data |
| B5 | **Knowledge + memory** | what B2's skill needs to know | `knowledge/` domain file + a memory plan | Day 2 — the golden path can now run *grounded* |
| D2 | **Plan ▸ Bootstrap ▸ Build ▸ Test** | every decision above | the wired app + the **headline artifact** | the demo — and proof it generates that artifact consistently |

## Why the order

- You can't write a good **skill** until you know the agent's **scope** (B1).
- A skill is useless without the **tool** it calls (B3) — so B2 names it and B3
  builds it.
- A tool with a dangerous mode needs a **hook** before you trust it (B4).
- Only once the risky path is gated do you hand the agent **knowledge** and let
  it run the **golden path** (B5 → Day 2).

## How testing chains too

Each exercise's test prompt (`evals/cases/`) reuses the previous artifact: the
skill test feeds the system prompt's persona; the tool test is invoked from the
skill; the golden-path test exercises all of them and emits the headline
artifact. A break early in the chain shows up as a failure later — which is the
point. Fix upstream first.
