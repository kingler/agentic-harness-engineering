# Worked example — Granola harness (Copilot)

> **What this is.** A dry run of the build chain in
> [`../app-build-template/`](../app-build-template/), executed against the
> **Granola** app profile ([`../ai-apps/03-granola.md`](../ai-apps/03-granola.md))
> with **GitHub Copilot** as the chosen editor. It shows what a participant's
> project looks like after the first three steps — it is a *reference*, not a
> download. Start your own from `app-build-template.zip`.

## How it was produced

| Step | Command | Output here |
|------|---------|-------------|
| 0 | filled `app-brief.md` | (brief folded into `plan/PLAN.md`) |
| 1 | `/plan-app` | `plan/PLAN.md` · `plan/wireframes.md` · `plan/tech-spec.md` |
| 2 | `/bootstrap-harness` (editor: Copilot) | filled `AGENTS.md`, `.github/**`, `.vscode/mcp.json`, `knowledge/`, `tools/`, `app/`, `memory/` |
| 3 | `/test-harness` | `plan/TEST-REPORT.md` |

> The `plan/TEST-REPORT.md` here comes back **FAIL on purpose.** This dry run
> never invoked a model, and the test rule is strict: a harness you didn't
> actually exercise is *unverified*, which is a fail — config presence is not a
> pass. Only the deterministic hook logic was unit-proven (it runs without the
> model). Open the project in Copilot, run the `TESTING.md` probes, and re-run
> `/test-harness` to turn the rows green with real evidence.

The Roo Code / DevGPT folder is left mostly as shipped — bootstrap fills one
editor; only the mirrored rules (`.roo/rules/02-hard-rules.md`) were synced.

## The app, in one line

Granola is an AI meeting notepad: it captures the conversation, writes a
trustworthy recap, extracts action items, and exports them to your docs / CRM /
task tools — **without inventing commitments nobody made** and **without
sharing notes outside the meeting's attendees**.

## Folder map

```
worked-example-granola/
├── AGENTS.md                         # system prompt — neutral summarizer
├── knowledge/meeting-types.md        # rubrics per meeting type + glossary
├── tools/scripts/export_notes.sh     # script-as-tool (export gate)
├── .vscode/mcp.json                  # calendar + task MCP servers
├── .github/
│   ├── copilot-instructions.md       # persona + hard rules
│   ├── instructions/notes.instructions.md
│   ├── skills/summarize-meeting/SKILL.md
│   └── hooks/pre-tool-use.sh         # consent/attendee export gate
├── .roo/rules/02-hard-rules.md       # mirrored rules
├── app/README.md                     # frontend brief for the editor AI
├── memory/SESSION.md                 # working memory
└── plan/                             # PLAN.md · wireframes.md · tech-spec.md · TEST-REPORT.md
```
