# App Build Template — reverse-engineer the harness, then build the app

Day 2 build lab for **Agentic Harness Engineering**. You picked an AI product
to reverse-engineer on Day 1 (Harvey, Claude for Financial Services, or
Granola — see [`../ai-apps/`](../ai-apps/)). Now you'll rebuild a working
slice of it — frontend *and* its agent harness — using **GitHub Copilot** or
**RooCode** in VS Code.

The whole lab runs on two chained slash commands. **The first step is to
plan.** You never start with code.

```
/plan-app  ──▶  /bootstrap-harness  ──▶  build in the editor
 (Step 1)         (Step 2)               (Step 3)
```

---

## What's in this template

```
app-build-template/
├── README.md                          # this file
├── app-brief.md                       # Step 0 — fill in: core features, value prop, problem
├── .github/prompts/                   # GitHub Copilot prompt files
│   ├── plan-app.prompt.md
│   └── bootstrap-harness.prompt.md
├── .roo/
│   ├── commands/                      # RooCode slash commands
│   │   ├── plan-app.md
│   │   └── bootstrap-harness.md
│   └── rules/
│       └── 01-build-workflow.md       # plan-before-build rule (RooCode reads this)
└── .claude/commands/                  # same two commands for Claude Code users
    ├── plan-app.md
    └── bootstrap-harness.md
```

The two commands are mirrored across all three editor surfaces, because the
harness contract is portable — the same plan and scaffold work whether you
drive it from Copilot, RooCode, or Claude Code.

---

## Download & unzip

Grab `exercises/app-build-template.zip` from the workshop page, then:

```bash
unzip app-build-template.zip
cd app-build-template
code .            # open the folder in VS Code
```

Open it as the VS Code **workspace root** so your editor's AI picks up the
commands automatically.

---

## Step 0 — Write the app brief (5 min)

Open [`app-brief.md`](./app-brief.md) and fill it in for the app your group
chose. Three things matter most, and the plan is built from them:

- **Core features** — what users can *do*, as verbs.
- **Value proposition** — why this beats doing it by hand or in a generic chat.
- **The problem it solves** — the painful, slow, or expensive job it removes.

Don't reproduce the vendor's secret prompts. Describe the *product* as a user
sees it. This brief is the input to the next step.

---

## Step 1 — Plan (run `/plan-app`)

> **The first step is always the plan.** No scaffolding, no code yet.

**GitHub Copilot:** open Copilot Chat in VS Code and type `/plan-app`.
Copilot finds the prompt file in `.github/prompts/`.

**RooCode:** open the RooCode chat and type `/plan-app`. RooCode finds the
command in `.roo/commands/`.

**Claude Code:** type `/plan-app` — it's in `.claude/commands/`.

The command reads `app-brief.md` (and asks you for features / value prop /
problem if the brief is still blank), then writes three artifacts:

| File | What it is |
|------|-----------|
| `plan/PLAN.md` | The build plan — goal, golden path, scope, build order, "done when" |
| `plan/wireframes.md` | Low-fi ASCII wireframes for each golden-path screen |
| `plan/tech-spec.md` | The stack **and** the map of all six harness components onto files |

Read the plan. Fix anything wrong *before* you bootstrap — everything
downstream is built from these three files.

---

## Step 2 — Bootstrap the tree (run `/bootstrap-harness`)

When the plan looks right, run `/bootstrap-harness` (same place in your
editor). It reads `plan/tech-spec.md` and scaffolds the project — one stub per
**harness component**:

| Component | Scaffolded into |
|-----------|-----------------|
| **System prompt** | `AGENTS.md` (persona · scope · hard rules) |
| **Skills** | `skills/<name>/SKILL.md` |
| **Rules** | `rules/01-hard-rules.md` (mirrored to `.roo/rules/` + Copilot instructions) |
| **Hooks** | `hooks/pre-tool-use.sh`, `hooks/post-tool-use.sh` |
| **Tools (functions)** | `tools/*.json` + `tools/scripts/*.sh` |
| **MCPs** | `mcp.json` |

It also drops an `app/` folder for the frontend and a `memory/` +
`knowledge/` pair. The stubs are seeded from your plan — your real persona,
tool names, and the "never" rule from your nightmare-failure line — not
generic placeholders.

If you run `/bootstrap-harness` before a plan exists, it stops and sends you
back to `/plan-app`. That's the chain enforced.

---

## Step 3 — Build in the editor (the rest of the lab)

Now you have a plan, wireframes, and a scaffolded harness. Drive Copilot or
RooCode to build:

1. **Frontend from the wireframes.** Point your editor AI at
   `plan/wireframes.md` and `plan/tech-spec.md`: *"Build Screen 1 from the
   wireframe using the stack in the tech spec, into `app/`."*
2. **Fill in one tool** end-to-end — descriptor (`tools/<name>.json`) first,
   then the script body. The description is UX copy for the model.
3. **Make one hook real** — turn your top "never" rule into
   `hooks/pre-tool-use.sh` so it's enforced by code, not by hope.
4. **Wire the agent surface** — connect the UI's agent panel to your tool(s).
5. **Test the golden path** end-to-end and watch the hook fire.

Stop wherever the clock runs out. A sharp `AGENTS.md`, one real tool, and one
working hook beats six half-stubbed components.

---

## Ground rules (carried from the workshop)

- Keep `AGENTS.md` under 200 lines — it's your highest-leverage file.
- Cap tools at ~7. A bigger tool list usually makes the agent worse.
- Tool descriptions are UX copy for the model — write them like a button
  label, not like JSDoc.
- Anything that should happen "every time" belongs in a **hook**, not a prompt.
- Plan before you build. The plan is the contract the build is measured against.

## See also

- App profiles to pick from: [`../ai-apps/`](../ai-apps/)
- Day 1 component breakouts: [`../breakout-guides/`](../breakout-guides/)
- Fuller harness scaffold (per-component reference): [`../../harness-templates/`](../../harness-templates/)
