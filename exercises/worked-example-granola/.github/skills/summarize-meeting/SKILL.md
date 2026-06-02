---
name: summarize-meeting
description: Write a trustworthy recap of a meeting from its transcript, using the meeting-type rubric. Loads when the user asks to "summarize", "recap", "write up", or "generate notes for" a meeting — e.g. "recap the Acme sales call".
---

# Summarize meeting (Copilot agent skill)

The `description` is the trigger — phrase it the way a user asks. Do NOT load
this for general questions or for meetings the user didn't attend.

## Steps

1. Read the transcript and the meeting `type`. Load the matching rubric from
   `knowledge/meeting-types.md`.
2. Write the **Summary** in the rubric's shape. Quote verbatim or paraphrase
   clearly — never alter a quote.
3. Mark anything discussed-but-unconfirmed under **⚠ Flagged — not confirmed**.
   Do not resolve it.
4. Run `extract_action_items`: one line each, with a named owner (or
   **unassigned**).
5. Return Summary + Flags + Action items. End with one line on what the user
   should verify before exporting.

## What to skip

- Don't recommend decisions (hire/no-hire, buy/no-buy) — surface signal, humans
  decide.
- Don't include personal detail beyond the agreed follow-up.
