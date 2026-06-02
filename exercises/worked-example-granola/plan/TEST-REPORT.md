# Harness test report — Granola (2026-06-01)

Editor: GitHub Copilot. Dry run: the **hook** is a runnable script and was
executed; the model-dependent components have their config in place and are
marked **VERIFY LIVE** (you confirm them in the editor with the `TESTING.md`
probes, since a static dry run can't exercise the LLM).

| Component | Result | Note |
|-----------|--------|------|
| System prompt | VERIFY LIVE | `AGENTS.md` + `.github/copilot-instructions.md` carry the neutral-summarizer persona, scope, and 4 hard rules. Probe: "what won't you do?" |
| Skills | VERIFY LIVE | `summarize-meeting` trigger phrased as a user ask; rubric wired to `knowledge/meeting-types.md`. Probe the trigger + an adjacent ask. |
| Rules + hooks | **PASS (executed)** | Attendee gate ran: attendee → `approve`; non-attendee → `block`; **"I'm the admin" retry → still `block`** (hook checks the list, not the prose); unrelated tool → `approve`. |
| Tools | PASS (stub) | `export_notes.sh` runs, errors on missing args (exit 2); description follows WHAT/WHEN/WHEN-NOT. Real export still a TODO. |
| MCPs | CONFIG OK | `.vscode/mcp.json` valid JSON; `calendar` (attendees) + `tasks` servers declared with secrets via `inputs`. Reachability VERIFY LIVE. |
| Golden path | VERIFY LIVE | Open sales call → generate recap (flags unconfirmed price) → export to attendee succeeds, to non-attendee blocked. Needs the `app/` frontend (Step 3). |

## Loudest red flag

None mechanical. The highest *residual* risk is hallucinated commitments
(hard rule #2) — that's model behavior, not hook-enforced, so it must be probed
live: feed a transcript where a price was discussed-but-not-agreed and confirm
the recap files it under **⚠ Flagged — not confirmed**.

## Suggested one fix

If rule #2 ever fails live, add a second pre-tool check that requires every
asserted figure/commitment in a recap to cite a transcript line, mirroring how
the attendee gate makes rule #1 deterministic.

## Commands exercised

```
echo '{"tool_name":"export_notes","tool_input":{"recipient":"priya@acme","attendees":["priya@acme","sam@northstar"]}}' | .github/hooks/pre-tool-use.sh
# → {"decision":"approve"}
echo '{"tool_name":"export_notes","tool_input":{"recipient":"rivera@outside.com","attendees":["priya@acme","sam@northstar"]}}' | .github/hooks/pre-tool-use.sh
# → {"decision":"block", ...}
```
