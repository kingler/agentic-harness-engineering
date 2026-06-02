---
mode: agent
description: STEP 2 of the build. Read plan/tech-spec.md and fill the harness stubs for your chosen editor (.github/ for Copilot, .roo/ for Roo Code), seeded with the plan's real persona, tools, and hard rule. Then scaffold app/ and memory/. Run AFTER /plan-app.
---

# /bootstrap-harness — Step 2: Fill the harness from the plan

> **GitHub Copilot prompt file.** Run with `/bootstrap-harness` in Copilot Chat
> after `/plan-app`.

You are the scaffolding agent. The harness folders **already exist** in this
template — `.github/` (Copilot) and `.roo/` (Roo Code / DevGPT), plus shared
`AGENTS.md`, `knowledge/`, and `tools/`. Your job is to replace the `{{stubs}}`
with the real decisions from the plan, for the editor the participant is using.
You fill in structure and honest TODOs; you do **not** write the full app.

## Step 1 — Require the plan

Read `plan/tech-spec.md`, `plan/PLAN.md`, and `plan/domain-research.md`. If
`plan/tech-spec.md` is missing, stop: *"No tech spec found. Run `/plan-app`
first — bootstrap builds from the plan."*

## Step 2 — Confirm the editor

Ask once (skip if obvious from context): *"Are you building this in **GitHub
Copilot** (`.github/`) or **Roo Code / DevGPT** (`.roo/`)?"* Fill that editor's
files; leave the other editor's folder as shipped.

## Step 3 — Fill the harness from the tech spec

**Augment, don't overwrite.** Day 1's labs already built components into this
template. If a file no longer has `{{placeholders}}`, it carries the
participant's work — **keep it** and only reconcile it with the plan; never
clobber a built component. Fill the *remaining* `{{placeholder}}` files with the
plan's real values. Touch these files:

**Shared (both editors):**
- `AGENTS.md` — persona, scope, the hard rules (rule #1 = your nightmare-failure
  guard), tool names from the tech spec.
- `knowledge/domain-notes.md` — the domain vocab and policies from `plan/domain-research.md` (terms, real workflow, trust/compliance constraints).
- `tools/scripts/sample-tool.sh` → rename to your first verb-named tool; describe
  it (WHAT / WHEN / WHEN-NOT) in `AGENTS.md`.

**GitHub Copilot:**
- `.github/copilot-instructions.md` — mirror the persona + hard rules.
- `.github/instructions/domain.instructions.md` — the path-scoped rules.
- `.github/skills/domain-check/SKILL.md` — rename + retrigger for your real skill.
- `.github/hooks/pre-tool-use.sh` — make the predicate block YOUR hard "never".
- `.vscode/mcp.json` — the servers named in the tech spec.

**Roo Code / DevGPT:**
- `.roo/rules/02-hard-rules.md` — mirror the hard rules.
- `.roo/commands/domain-check.md` — your real skill-as-command.
- `.roo/mcp.json` — the servers named in the tech spec.

Keep the two editor copies of the rules in sync with `AGENTS.md`.

## Step 4 — Create the build surfaces

Create:
- `app/` with an `app/README.md` telling the editor AI to generate the screens
  in `plan/wireframes.md` using the stack in `plan/tech-spec.md`.
- `memory/SESSION.md` — a working-memory stub (no secrets/PII).

## Step 5 — Report + next step

List the files you filled and end with:

> "Harness filled for {Copilot|Roo}. Six components carry your plan: system
> prompt, skills, rules, hooks, tools, MCPs. **Next — build the frontend** from
> `plan/wireframes.md` (Step 3), then wire the agent surfaces. When it's wired,
> **run `/test-harness`** (or the `TESTING.md` prompts)."

Do not implement the frontend or real tool logic — leave clear TODOs.
