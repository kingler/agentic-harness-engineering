# Harness test report — Granola (2026-06-02)

**Overall: FAIL — model not exercised this run.**   ·   Model exercised: **no**

This was a static dry run: no editor/LLM was driven, so no model-dependent
component was actually called. Per the test rule, a harness you didn't run is
**unverified, which is a fail** — config presence is not a pass. The only thing
proven here is the **hook's logic in isolation**, because it's a deterministic
script that runs without the model.

| # | Component | Result | Evidence (what fired this run) |
|---|-----------|--------|--------------------------------|
| 0 | Model access | **FAIL** | No model call was made in this dry run. This gates the rest. |
| 1 | System prompt | **FAIL** | Persona/refusal never exercised — the model wasn't asked anything. Config is in `AGENTS.md` but untested. |
| 2 | Skills | **FAIL** | `summarize-meeting` trigger never fired — no model turn to load it. |
| 3 | Tools (+ MCP) | **FAIL (integration)** · script PASS (unit) | `export_notes.sh` runs and errors on missing args (exit 2), but the model never *chose* to call it — tool selection untested. `.vscode/mcp.json` is valid JSON, but no server was reached. |
| 4 | Rules + hooks | **FAIL (integration)** · hook logic PASS (unit) | Hook executed directly → artifact `evals/artifacts/4-rules-hooks-block.md`: attendee `approve`, non-attendee `block`, "I'm the admin" retry still `block`. But the **model → tool-call → hook** path was never run, so the integrated rule is unverified. |
| 5 | Knowledge + memory | **FAIL** | `knowledge/meeting-types.md` exists, but no run grounded an answer in it and no session memory was exercised. |
| 6 | Golden path | **FAIL** | Needs the `app/` frontend (Step 3) and a model run; neither happened. Reference artifact shape is in `evals/artifacts/6-golden-path-recap.md` — but no run produced it, so unverified. |

## Loudest red flag

The harness has **never been driven by the model**, so nothing behavioral is
certified. A green sticker on file contents would be exactly the mistake this
test exists to prevent.

## Suggested one fix

Open the project in GitHub Copilot, run the six `TESTING.md` probes (start with
the attendee gate and the "I'm the admin" retry), and re-run `/test-harness` so
each row carries real evidence. Only then can Overall flip to PASS.

## What was mechanically verified (model-independent)

```
echo '{"tool_name":"export_notes","tool_input":{"recipient":"priya@acme","attendees":["priya@acme","sam@northstar"]}}' | .github/hooks/pre-tool-use.sh
# → {"decision":"approve"}
echo '{"tool_name":"export_notes","tool_input":{"recipient":"rivera@outside.com","attendees":["priya@acme","sam@northstar"]}}' | .github/hooks/pre-tool-use.sh
# → {"decision":"block", ...}   (unchanged under an "I'm the admin" note)
```

These prove the hook *predicate* is correct. They do **not** prove the harness
behaves — that requires the model, and the model was not exercised.
