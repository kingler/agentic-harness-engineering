# Session memory

The agent reads this file at the start of every session and may append
to it during the session. It survives between sessions; system prompts
do not.

## What belongs here

- Decisions made during a session that shouldn't be re-litigated next time.
- Names, IDs, paths, and conventions specific to this user's workspace.
- Open questions that need a human reply before the agent continues.

## What does NOT belong here

- Secrets, tokens, API keys, PII.
- Long verbatim transcripts — summarise.
- Per-task scratch (use the conversation, not memory).

## Conventions

- Newest entries at the top.
- Each entry: one-line header, optional bullets underneath.
- Date entries `YYYY-MM-DD`.
- Hard-cap this file at 200 lines. When it grows past that, the agent
  should summarise the oldest section and drop the originals.

## Entries

<!-- Example. Replace with real entries. -->
### 2026-04-29 — Workshop kickoff
- Stack: TypeScript + Vitest + Tailwind.
- Design tokens live in `design/tokens.json`; do not hard-code colour.
- Open question for user: which subagent runs the design-review step?
