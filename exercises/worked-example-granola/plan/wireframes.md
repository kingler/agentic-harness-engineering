# Wireframes — Granola

## Screen 1 — Meeting workspace
+------------------------------------------------------------+
| Granola            Sales call · Acme <> Northstar   ● Done  |
+--------------------+---------------------------------------+
| Meetings           | Transcript            | Recap (agent) |
|  • Acme <> North…  |  [00:02] Priya: …     |  Summary…     |
|  • Standup 6/01    |  [00:14] Sam: …       |  [ generating ]|
|  • 1:1 w/ Dana     |  [00:31] Priya: …     |  ⚠ uncertain: |
|                    |                       |   price not   |
|                    |                       |   confirmed   |
+--------------------+-----------------------+---------------+
| Attendees: priya@acme, sam@northstar      [ Generate recap ]|
+------------------------------------------------------------+
- Agent surface: the right "Recap (agent)" pane; streams the summary.
- Primary action: "Generate recap" → runs the summarize-meeting skill.
- Empty state: "No recap yet — Generate recap to summarize this meeting."
- Error state: refusal/uncertainty banner ("Couldn't confirm X — flagged, not invented").

## Screen 2 — Recap & export
+------------------------------------------------------------+
| ← Back     Recap · Acme <> Northstar (sales call)          |
+------------------------------------------------------------+
| Summary                                                    |
|  • Northstar evaluating Pro tier; timeline ~Q3.            |
|  • ⚠ Pricing discussed but not agreed (flagged).           |
|                                                            |
| Action items                                               |
|  ☐ Send Pro pricing sheet — owner: Sam (northstar)         |
|  ☐ Schedule security review — owner: Priya (acme)          |
+------------------------------------------------------------+
| Export to:  [ Doc ▾ ]   Recipients: [ priya@acme  ✕ ]      |
|                                       [ + add ]  [ Export ]|
+------------------------------------------------------------+
- Agent surface: editable recap + action items the agent produced.
- Primary action: "Export" → export_notes tool (attendee-gated).
- Empty state: "No action items detected."
- Error state: "Blocked: rivera@outside.com is not an attendee of this meeting."
