# Frontend — build this from the wireframes

Editor AI: build the two screens in `../plan/wireframes.md` using the stack in
`../plan/tech-spec.md` (React + Vite, `localStorage`, mock data).

- **Screen 1 — Meeting workspace:** meetings list, transcript pane, agent recap
  pane. "Generate recap" invokes the `summarize-meeting` skill.
- **Screen 2 — Recap & export:** editable recap + action items, recipient
  picker, "Export" → `export_notes` (attendee-gated by the pre-tool hook).

Seed `app/mock/meetings.json` with one **sales call** that has an attendee list
and a transcript, so the golden path and the attendee gate are testable.
