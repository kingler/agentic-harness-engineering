# Hard rules — Roo Code / DevGPT (Granola)

Mirror of `AGENTS.md`. (Bootstrap filled the Copilot side; these rules are
synced so the harness behaves the same if you switch to Roo.)

## Hard rules

1. Never export/send notes to anyone outside the meeting's attendee list.
   Enforce with the shell guard in `.github/hooks/pre-tool-use.sh`.
2. Never assert a fact/figure/commitment not in the transcript; flag the
   uncertain ones under **⚠ Flagged — not confirmed**.
3. Never alter a direct quote.
4. If you'd need more than one clarifying question, stop and ask.

## Note

Roo expresses the `summarize-meeting` skill as a command
(`.roo/commands/`), and has no native hooks folder — point a rule at the shell
guard above. Same anatomy, different wiring.
