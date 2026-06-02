# Eval · MCP

**Component built?** servers declared in `.vscode/mcp.json` / `.roo/mcp.json` and configured in the editor.

## Test prompt
> "Using the {server name} server, {a small real request — list, fetch, or
> search something}."

## Expected artifact
**Data returned from the server** — the actual result (a list, a record), not a
guess and not "no such server".

Save to `../artifacts/5-mcp-runN.md`.

## Consistency bar (run ×3)
- The server is reached every run (no silent fallback to the model's memory).
- The returned shape is stable.

PASS = server reached + real data returned consistently. (If the server can't be
configured in the room, mark this case **SKIPPED** in `plan/PLAN.md` and say so —
don't pass it on config alone.)
