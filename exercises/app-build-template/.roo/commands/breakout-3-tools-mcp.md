---
description: BREAKOUT 3 of 5. Plan and build the verb-named tool the skill calls, plus any MCP server it needs. Walks the planning questions, writes the tool script + its WHAT/WHEN/WHEN-NOT description in AGENTS.md, and adds MCP servers to mcp.json. Run after /breakout-2-skills-subagents. Chains to /breakout-4-hooks-rules.
argument-hint: "(none — reads AGENTS.md + the skill from Breakout 2)"
---

# /breakout-3-tools-mcp — Breakout 3: tools + MCP

> **Roo Code / DevGPT command.** Type `/breakout-3-tools-mcp` after Breakout 2.
> Copilot users run the mirrored prompt.

> **Exercise chain.** **Builds on ←** the tool Breakout 2's skill named.
> **Sets up →** the **risky action** Breakout 4 gates with a hook.

You are the breakout facilitator. **Tools** are the local actions the agent can
take (script-as-tool); **MCP** servers are external systems it reaches (GitHub, a
database, an API). The tool *description* is UX copy for the model — write it like
a button label. Cap the whole surface at ~7.

## Step 0 — Require the skill

Read `AGENTS.md` and the skill from Breakout 2. If no skill names a tool, stop:
*"Build the skill first — run `/breakout-2-skills-subagents`. It names the tool
we build here."*

## Step 1 — Plan it (the breakout, ~8 min)

**The tool:**
1. **Verb name** — `export_notes`, `flag_inconsistency`, not `file_handler`.
   Noun tools are harder for the agent to use correctly.
2. **WHAT / WHEN / WHEN-NOT** — one line each. WHEN-NOT is what stops the agent
   reaching for it on look-alike requests.
3. **Inputs + output schema** — the parameters it takes and the fixed shape it
   returns.
4. **The risky mode** — does any path mutate, send, or expose something? Name it
   now; that's exactly what Breakout 4 gates.

**MCP (only if you need an external system):**
5. **Which server** — name the server and the one small thing you'll ask it.
   Secrets come from `inputs` / env, **never** hard-coded. If you don't need one,
   say so and skip — don't add servers you won't call.

## Step 2 — Write it

**Tool (shared):**
- Rename `tools/scripts/sample-tool.sh` to your verb (e.g. `export_notes.sh`),
  make it `+x`, and have it emit the output schema you chose.
- Describe it where the model reads it — in `AGENTS.md` under **Tools** — using
  **WHAT / WHEN / WHEN-NOT**.

**MCP (your editor's lane):**
- **Roo Code / DevGPT:** `.roo/mcp.json` (`mcpServers`).
- **GitHub Copilot:** `.vscode/mcp.json` (`servers`).

Keep the tool surface ≤ ~7. If you cut a tool that seemed useful, note why in
`plan/PLAN.md`.

## Step 3 — Test it → artifact

Prompt with **the request your tool exists for** — then a WHEN-NOT request that
looks tool-shaped but shouldn't trigger it. If you wired MCP: **"Using the
{server} server, {small request}."**

- **PASS:** correct tool called first try with the same output schema each run;
  the WHEN-NOT case answers directly with **no** tool call; the MCP server
  returns real data (or is marked SKIPPED in `plan/PLAN.md`). Save to
  `evals/artifacts/3-tools-run1.md` and repeat ×3.
- **Red flag:** wrong tool, or "which should I use?" → sharpen the description.

## Step 4 — Hand off

> "Tool built and described; MCP {wired / skipped}. Its risky action is
> **{the mutating/sending path}**. **Next — run `/breakout-4-hooks-rules`** to put
> a deterministic gate in front of it."

Stop here.
