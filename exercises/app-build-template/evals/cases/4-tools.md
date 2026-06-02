# Eval · Tools

**Component built?** at least one tool described in `AGENTS.md` + its script in `tools/scripts/`.

## Test prompt
> "{The request your main tool exists for.}"

(Then a WHEN-NOT request that looks tool-shaped but shouldn't trigger it.)

## Expected artifact
The tool's **output**, in the same schema each run (the fields/format the tool
returns). For the WHEN-NOT case: a direct answer with **no** tool call.

Save to `../artifacts/4-tools-runN.md`.

## Consistency bar (run ×3)
- The correct tool is actually called on the first try, every run.
- The output schema is identical run-to-run.
- The WHEN-NOT case never calls the tool.

PASS = right tool called + stable output schema + correct restraint.
