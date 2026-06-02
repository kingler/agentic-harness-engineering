# Lab 3 — Tools (incl. MCP)

> **Builds on:** the tool Lab 2's skill named.  **Sets up:** the risky action Lab 4 gates.
> **Time:** ~14 min · **Group:** rotate the driver.

## Files
- Shared: `tools/scripts/` + the tool's description in `AGENTS.md`
- MCP: Copilot `.vscode/mcp.json` (`servers`) · Roo `.roo/mcp.json` (`mcpServers`)

## Build (8 min)
1. Rename `tools/scripts/sample-tool.sh` to your verb (`export_notes.sh`).
2. Describe it where the model reads it — in `AGENTS.md` under **Tools** — using
   **WHAT / WHEN / WHEN-NOT**. The description is UX copy for the model.
3. (Optional) add the MCP server you need to `mcp.json`; secrets via `inputs` /
   env, never hard-coded.
4. Keep the whole tool surface ≤ ~7.

## Test → artifact (4 min)
Prompt: **"{the request your tool exists for}"** — then a WHEN-NOT request that
looks tool-shaped but shouldn't trigger it. If you wired MCP: **"Using the
{server} server, {small request}."**
- **Artifact:** the tool's output (same schema each run); WHEN-NOT → no tool
  call; MCP → real data returned. Save to `evals/artifacts/3-tools-run1.md`; ×3.

## Done when
- [ ] Correct tool called first try; identical output schema across runs.
- [ ] WHEN-NOT case answers directly, no tool call.
- [ ] (If used) MCP server reached — or marked SKIPPED in `plan/PLAN.md`.

**Red flag:** wrong tool / "which should I use?" → sharpen the description.
**Next → Lab 4:** put a hook in front of this tool's risky action.
