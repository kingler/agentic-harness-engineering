---
mode: agent
description: BREAKOUT 2 of 5. Plan and write the agent's skill (the deliverable-maker) and a subagent (a read-only reviewer). Walks the planning questions, then writes the skill + agent files for your editor. Run after /breakout-1-system-prompt. Chains to /breakout-3-tools-mcp.
---

# /breakout-2-skills-subagents — Breakout 2: skills + subagents

> **GitHub Copilot prompt file.** In VS Code, run it from Copilot Chat with
> `/breakout-2-skills-subagents` after Breakout 1. Roo Code users run the mirrored
> command.

> **Exercise chain.** **Builds on ←** Breakout 1's persona + scope. **Sets up →**
> names the **tool** Breakout 3 builds.

You are the breakout facilitator. A **skill** is the packaged know-how that makes
the agent's headline deliverable; its `description` is the trigger that loads it.
A **subagent** is a second, narrower agent (here: a read-only reviewer) the main
agent can delegate to. Walk the decisions, then write the files.

## Step 0 — Require the system prompt

Read `AGENTS.md`. If it's still `{{placeholders}}`, stop: *"Write the system
prompt first — run `/breakout-1-system-prompt`. The skill has to honor that
scope."*

## Step 1 — Plan it (the breakout, ~8 min)

**The skill:**
1. **Name** — a verb for the core deliverable: `summarize-meeting`, `draft-nda`,
   `reconcile-month`.
2. **Trigger** — the `description`, phrased the way a *real user* asks ("recap
   the … call"). This IS what loads the skill, so use their words.
3. **Output shape** — the fixed sections the deliverable always has.
4. **The tool it needs** — name the one tool this skill will call. You *name* it
   now; Breakout 3 *builds* it.

**The subagent:**
5. **When to delegate** — what narrow, read-only job is worth a separate agent?
   The default is a **reviewer** that checks a draft against the rules + plan and
   never edits files. Decide its one job and the tools it may (and may not) use.

## Step 2 — Write it

**Skill** (your editor's lane — rename the shipped `domain-check` skill):
- **Roo Code / DevGPT:** `.roo/commands/<name>.md` (Roo has no `skills/` folder,
  so the skill is a command). Front matter `description` = the trigger.
- **GitHub Copilot:** `.github/skills/<name>/SKILL.md`. The `description` front
  matter is the trigger.

Write the steps: what it reads, the output shape, what to skip, and the tool it
calls (leave the tool as a named TODO for Breakout 3).

**Subagent:**
- **GitHub Copilot:** `.github/agents/reviewer.agent.md` — set `name`,
  `description`, and a minimal read-only `tools` list; keep it from editing.
- **Roo Code / DevGPT:** there's no native agents folder — capture the reviewer
  as a second command `.roo/commands/review.md`, or note in `AGENTS.md` that the
  review pass is a mode. Mark which you chose.

## Step 3 — Test it → artifact

Prompt with **the trigger phrase, as a user would say it** — then, separately, an
**adjacent** request the skill should NOT handle.

- **PASS:** the trigger loads the skill and the adjacent ask does **not**; the
  output keeps the same sections each run. Save to
  `evals/artifacts/2-skill-run1.md` and repeat ×3.
- **Red flag:** it improvises and ignores the skill → the `description` is too
  vague; rewrite it in the user's words.

## Step 4 — Hand off

> "Skill + subagent done. The skill names **{tool}** but can't call it yet.
> **Next — run `/breakout-3-tools-mcp`** to build that tool (and wire any MCP
> server it needs)."

Stop here.
