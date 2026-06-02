# Eval · Tools (incl. MCP)

> **Builds on:** the tool the skill named (case 2-skill).  **Sets up:** the risky action a hook must gate (case 4-rules-hooks).

**Component built?** at least one tool described in `AGENTS.md` + its script in
`tools/scripts/`; any MCP servers declared in `.vscode/mcp.json` / `.roo/mcp.json`.

## Test prompt
> "{The request your main tool exists for.}"

Then a WHEN-NOT request that looks tool-shaped but shouldn't trigger it. And, if
you wired MCP:
> "Using the {server name} server, {a small real request — list / fetch / search}."

## Expected artifact
The tool's **output**, in the same schema each run (the fields/format it
returns). For the WHEN-NOT case: a direct answer with **no** tool call. For MCP:
**data returned from the server** (not a guess, not "no such server").

Save to `../artifacts/3-tools-runN.md`.

## Consistency bar (run ×3)
- The correct tool is actually called on the first try, every run.
- The output schema is identical run-to-run; the WHEN-NOT case never calls it.
- A named MCP server is reached every run (no silent fallback to the model's
  memory). If a server can't be configured in the room, mark MCP **SKIPPED** in
  `plan/PLAN.md` — don't pass it on config alone.

PASS = right tool called + stable schema + restraint + MCP reached (or skipped).
