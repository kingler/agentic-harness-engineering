---
description: STEP 2 of the build. Read plan/tech-spec.md and scaffold the project file & folder tree — stubs for all six harness components (system prompt, skills, rules, hooks, tools, MCPs) plus a frontend app skeleton. Run AFTER /plan-app.
argument-hint: "(none — reads plan/tech-spec.md)"
---

# /bootstrap-harness — Step 2: Scaffold the project tree

> **RooCode command.** Type `/bootstrap-harness` in the RooCode chat *after*
> `/plan-app`. It reads `plan/tech-spec.md` and writes the tree into your
> workspace.

You are the scaffolding agent. `/plan-app` ran first and left a plan in
`plan/`. Turn `plan/tech-spec.md` into a real folder tree with honest stubs —
one file per harness component, plus a place for the frontend. You create
structure and TODO stubs; you do **not** write the full app.

## Step 1 — Require the plan

Read `plan/tech-spec.md`. If it is missing, stop and say:

> "No tech spec found. Run `/plan-app` first — bootstrap builds from the plan."

If it exists, read it and `plan/PLAN.md` so the stubs you write carry the
app's real persona, tool names, and rules — not generic placeholders.

## Step 2 — Create the tree

Create exactly this structure at the workspace root. Use the app's real names
from the tech spec wherever a `<name>` appears.

```
.
├── AGENTS.md                     # System prompt — persona, scope, hard rules
├── mcp.json                      # MCPs — external tool servers
├── skills/
│   └── <skill-name>/
│       └── SKILL.md              # Skill — name, trigger, body
├── rules/
│   └── 01-hard-rules.md          # Rules — the numbered "never" list
├── hooks/
│   ├── pre-tool-use.sh           # Hook — enforce a rule before a tool runs
│   └── post-tool-use.sh          # Hook — format / log / tag after a tool runs
├── tools/
│   ├── <tool-name>.json          # Tool (function) — WHAT / WHEN / WHEN-NOT
│   └── scripts/
│       └── <tool-name>.sh        # Tool body — runnable stub
├── knowledge/
│   └── README.md                 # Domain knowledge the agent reads
├── memory/
│   └── SESSION.md                # Working memory — survives between runs
├── app/                          # Frontend prototype — built in Step 3
│   └── README.md                 # points the editor AI at the wireframes
└── plan/                         # already created by /plan-app
```

Also mirror the rules so RooCode and Copilot read the same contract:
`.roo/rules/01-hard-rules.md` and `.github/copilot-instructions.md` should
both point at `rules/01-hard-rules.md`.

## Step 3 — Write honest stubs

For each file, write a short stub seeded from the tech spec. Every stub must
name what it is and what the user fills in next. Examples of the *shape*:

**`AGENTS.md`** (the system prompt — keep under 200 lines):
```markdown
# {App} — system prompt
## Identity
{persona from tech spec}
## Scope
Core job: {…}. Out of scope: {…}.
## Hard rules
1. {the nightmare-failure guard from the brief}
2. TODO
3. TODO
## Tools
{tool names from tech spec, one per line}
## When stuck
Ask one clarifying question; never guess on {risky surface}.
```

**`tools/<tool-name>.json`** — use the WHAT / WHEN / WHEN-NOT description
pattern and a single required argument to start.

**`hooks/pre-tool-use.sh`** — a runnable stub that blocks the one action the
nightmare-failure rule forbids, then `exit 0`. `chmod +x` both hooks.

**`skills/<skill-name>/SKILL.md`** — front matter with `name` + `description`
(the description IS the trigger), then a short "when to use / steps" body.

**`mcp.json`** — the servers named in the tech spec, with a comment that
versions are illustrative until verified.

**`app/README.md`** — one paragraph telling Copilot / RooCode to generate the
screens in `plan/wireframes.md` using the stack in `plan/tech-spec.md`.

## Step 4 — Report the tree + next step

List the tree you created and end with the handoff:

> "Harness tree scaffolded. Six components stubbed: system prompt
> (`AGENTS.md`), skills, rules, hooks, tools, MCPs. **Next — open the project
> in Copilot or RooCode and build the frontend** from `plan/wireframes.md`
> (Step 3 in `plan/PLAN.md`), then wire the agent surfaces to your tools.
> When it's wired, **run `/test-harness`** (or the prompts in `TESTING.md`) to
> check it behaves."

Do not implement the frontend or fill in real tool logic — that's the build
step the participant drives in the editor. Leave clear TODOs.
