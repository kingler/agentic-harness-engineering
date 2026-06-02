# Build Plan — Granola (AI meeting notepad)

**Goal.** A working demo where a user opens a recorded meeting, the agent
produces a recap + action items grounded in the transcript, and the user
exports them to a doc — with the export blocked if a recipient isn't an
attendee.

**Problem & value.** People can't both participate in a meeting and take good
notes; manual notes are lossy and inconsistent. Granola writes the recap for
you and only claims what was actually said, so the output is trustworthy enough
to send.

**Golden path.**
1. User opens a finished meeting (transcript + attendee list loaded).
2. Agent writes a recap using the meeting-type rubric, flags anything
   uncertain, and extracts action items with owners.
3. User reviews, then clicks **Export to doc**.
4. The export is allowed only to attendees; any outside recipient is blocked.

**Scope for the lab.** The post-call recap + action-item + export slice for a
single meeting type (**sales call**). Live capture is out.

**Out of scope.** Real-time transcription, multi-meeting "episode" memory,
billing, auth, real CRM writes (mock the export).

**Build order.**
1. Plan (this file)
2. Bootstrap the harness (editor: Copilot)
3. Frontend prototype from the wireframes
4. Wire the recap/export surfaces to the skill + export tool
5. Test the golden path + the attendee gate

**Risks.**
- The model invents commitments not in the transcript (hallucinated decisions).
- Export leaks notes to a non-attendee.
- Recap ignores the meeting-type rubric and returns a generic summary.

**Done when.**
- [ ] Recap cites only transcript content; uncertainty is flagged.
- [ ] Action items have owners and appear in the recap view.
- [ ] Export to an attendee succeeds; export to a non-attendee is blocked.
