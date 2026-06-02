# Tools — how the agent reaches into the world

This is the **tools (functions)** component of the harness. Neither Copilot nor
Roo Code has a dedicated `tools/` folder the way Claude Code does — in these
editors a "tool" is one of two things:

1. **An MCP server** — declared in `.vscode/mcp.json` (Copilot) and
   `.roo/mcp.json` (Roo). This is the primary way to give the agent typed,
   reusable actions. See those files for the GitHub + browser examples.
2. **A script the agent runs in the terminal** — a small executable in
   `tools/scripts/`, described to the model so it knows when to call it. This is
   the "script-as-tool" pattern and is the easiest to demo.

## Script-as-tool

`tools/scripts/sample-tool.sh` is a runnable stub. To turn it into a real tool:

1. Rename it to a **verb** (`validate_spec.sh`, `fetch_disclosure.sh`).
2. Describe it where the agent will read the description — in `AGENTS.md` under
   **Tools**, and (for Copilot) optionally in a prompt file. Use the
   WHAT / WHEN / WHEN-NOT pattern:
   > "Validates a spec file against the schema. Use when the user asks to check
   > or lint a spec. Do NOT use for general file reading."
3. Keep the arg surface to one required argument to start.

The description is UX copy for the model — most tool failures are bad
descriptions, not bad tools.

## Cap

Keep the total tool surface at ~7. A bigger tool list usually makes the agent
worse at choosing.
