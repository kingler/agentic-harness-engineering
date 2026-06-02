# Tech Spec — Granola

## Frontend
- Framework: React + Vite (lightest thing that demos two screens well).
- Screens: Meeting workspace (transcript + recap pane), Recap & export.
- State: React state + `localStorage`; no backend for the lab.

## Data
- Entities: **Meeting** (id, type, attendees[], transcript[]), **Recap**
  (summary, flags[], actionItems[]), **ActionItem** (text, owner).
- Storage: mock meetings in `app/mock/meetings.json`; recaps held in memory.

## Agent surfaces
- **Generate recap** (Screen 1) → invokes the `summarize-meeting` skill with the
  meeting's transcript + type; returns summary + flags + action items.
- **Export** (Screen 2) → calls the `export_notes` tool with a target + recipient
  list; the pre-tool hook gates it on the attendee list.

## Harness component map
| Component | This app's instance | File |
|-----------|---------------------|------|
| System prompt | Neutral summarizer; never invents commitments; flags uncertainty; never alters direct quotes | `AGENTS.md` |
| Skills | `summarize-meeting` (recap by meeting-type rubric) | `.github/skills/summarize-meeting/SKILL.md` |
| Rules | Never share notes outside attendees; never assert unconfirmed facts | `.github/instructions/notes.instructions.md` |
| Hooks | Pre-tool: block `export_notes` to a non-attendee. Post-tool: tag export with attendee list | `.github/hooks/pre-tool-use.sh` |
| Tools | `summarize_meeting`, `extract_action_items`, `export_notes` | `tools/scripts/export_notes.sh` + skill |
| MCPs | Calendar (attendees/schedule), task system (action-item sync) | `.vscode/mcp.json` |
| Knowledge | Meeting-type rubrics + org glossary/acronyms | `knowledge/meeting-types.md` |
