---
description: STEP 1 of the build. Research the app's domain, then turn the app brief (core features, value proposition, the problem it solves) into a detailed plan, wireframes, and a technology + harness spec. Plan before you build. Chains to /bootstrap-harness.
argument-hint: "[app name] (optional — otherwise read app-brief.md)"
---

# /plan-app — Step 1: Plan before you build

> **RooCode command.** Type `/plan-app` in the RooCode chat (project commands
> live in `.roo/commands/`). It writes to `plan/` in your workspace.

You are the planning agent for the Agentic Harness Engineering build lab.
**Nothing gets scaffolded or coded until this plan exists.** Turn the
one-page app brief into four artifacts the build will run on:

- `plan/domain-research.md` — what the app's domain demands (terms, real workflow, trust/compliance constraints)
- `plan/PLAN.md` — the build plan
- `plan/wireframes.md` — low-fi screen wireframes
- `plan/tech-spec.md` — technology + harness component spec

## Step 1 — Read the brief

Read `app-brief.md` at the workspace root. If it is missing or still full of
`{{placeholders}}`, do **not** invent the product. Ask the user for the three
things the brief is built on, then continue:

> "Before I plan, tell me about the app you're reverse-engineering:
> **(1)** its core features, **(2)** its value proposition, and
> **(3)** the problem it solves."

Echo back a tight 3-bullet summary of features / value prop / problem and let
the user correct it before you plan.

## Step 2 — Research the domain (don't plan from intuition)

The reverse-engineered apps are **vertical** products — their hardest harness
decisions come straight from the domain, not from UI taste. Ground the plan in
the domain *before* you write it:

- **Harvey → legal:** privilege, citation/authority, jurisdiction, matter confidentiality.
- **Claude for Financial Services → finance:** auditability, "no number without lineage", disclosure rules, spreadsheet/deck surfaces.
- **Granola → meetings:** recording consent, on-device capture, the summary · decisions · actions schema.

Do this, in order:

1. **Start from the domain profile** for your app in `exercises/ai-apps/` (e.g.
   `01-harvey.md`) plus your group's Breakout 1 observations.
2. **Search for the rest.** If your editor has web search / browsing, look up
   the product's public docs and the domain's real terminology, workflows, and
   trust / regulatory constraints practitioners take for granted. If you have no
   web access, say so and lean on the profile + Breakout 1 notes.
3. **Write `plan/domain-research.md`** with these sections: *Domain terms*,
   *Real workflow (how a practitioner does this today)*, *Trust & compliance
   constraints*, *Sources*. Cite where each fact came from and mark anything you
   are **inferring** vs. **confirmed** — never present a guess as fact.

Carry the findings forward: domain constraints become **rules / hooks**, domain
terminology seeds **knowledge/**, and the real workflow shapes the **golden
path**. Do not start the plan until this file exists.

## Step 3 — Write `plan/PLAN.md`

Produce a one-page, skimmable plan with exactly these sections:

```markdown
# Build Plan — {App name}

**Goal.** One sentence — what a working demo looks like.

**Problem & value.** Two sentences pulled from the brief.

**Golden path.** The 3–5 step interaction we will make work end-to-end.

**Scope for the lab.** The ONE slice we build now. Everything else is "later".

**Out of scope.** What we are deliberately not building.

**Build order.** A numbered checklist:
  1. Plan (this file)
  2. Bootstrap the harness tree (/bootstrap-harness)
  3. Frontend prototype from the wireframes
  4. Wire agent ↔ harness ↔ frontend
  5. Test the golden path

**Risks.** Three things most likely to go wrong.

**Done when.** A checklist a human can verify in under a minute.
```

## Step 4 — Write `plan/wireframes.md`

Sketch the screens on the golden path as **ASCII wireframes** — no design
tools, no images. One box per screen. For each screen note: the agent
surface (where the model shows up), the primary action, and the empty/error
state.

```markdown
# Wireframes — {App name}

## Screen 1 — {name}
+--------------------------------------------------+
| {top bar / nav}                                  |
+------------------+-------------------------------+
| {sidebar / list} | {main work area}              |
|                  |   [ agent surface lives here ]|
|                  |                               |
+------------------+-------------------------------+
| {primary action button}                          |
+--------------------------------------------------+
- Agent surface: {chat panel / inline suggestion / generated doc}
- Primary action: {what the main button does}
- Empty state: {what shows before any data}
- Error state: {what shows when the agent fails or refuses}

## Screen 2 — {name}
{…repeat for each golden-path screen, 2–4 screens total…}
```

## Step 5 — Write `plan/tech-spec.md`

Specify the stack **and** map the six harness components onto files. This is
the bridge into `/bootstrap-harness`.

```markdown
# Tech Spec — {App name}

## Frontend
- Framework: {React + Vite / Next.js / plain HTML — pick the lightest thing
  that demos well}
- Screens: {list from wireframes}
- State: {where app state lives}

## Data
- Entities: {the 2–4 nouns the app is about}
- Storage: {in-memory / localStorage / mock JSON — keep it demo-grade}

## Agent surfaces
- Where the model is invoked from the UI, and what it returns each time.

## Harness component map
| Component | This app's instance | File it will live in |
|-----------|---------------------|----------------------|
| System prompt | {persona + scope in one line} | `AGENTS.md` |
| Skills | {1–2 named skills} | `skills/<name>/SKILL.md` |
| Rules | {the hard "never" rules} | `rules/*.md` |
| Hooks | {1 pre + 1 post, what they enforce} | `hooks/*.sh` |
| Tools (functions) | {3–5 verb-named tools} | `tools/*.json` + `tools/scripts/` |
| MCPs | {external servers, e.g. GitHub} | `mcp.json` |
| Knowledge | {domain terms + constraints from `plan/domain-research.md`} | `knowledge/*.md` |
```

## Step 6 — Hand off to bootstrap

Save all four files under `plan/`. Then end with this exact handoff so the
chain is obvious:

> "Plan complete. Four files are in `plan/` (including `domain-research.md`).
> **Next step — run
> `/bootstrap-harness`** and it will scaffold the project tree from this
> tech spec (system prompt, skills, rules, hooks, tools, MCPs)."

Do **not** start scaffolding or writing app code yourself. Stop here so the
user can review the plan and trigger the next command.
