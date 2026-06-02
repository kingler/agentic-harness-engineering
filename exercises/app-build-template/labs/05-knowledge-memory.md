# Lab 5 — Knowledge + memory

> **Builds on:** what Lab 2's skill needs to know + Lab 1's scope.  **Sets up:** the grounded golden path (Day 2).
> **Time:** ~14 min · **Group:** rotate the driver.

## Files
- `knowledge/domain-notes.md` (durable facts) + `memory/SESSION.md` (per-run state)

## Build (8 min)
1. Fill `knowledge/domain-notes.md` with your app's stable facts — vocabulary,
   policies, the things the base model keeps getting wrong. Bullets it can quote.
2. Reference it so the agent reads it: from your instructions, or by
   `#knowledge/...` (Copilot) / `@knowledge/...` (Roo) in chat.
3. Sketch the memory plan in `memory/SESSION.md` — what carries across turns
   (no secrets/PII). Knowledge = durable; memory = this session.

## Test → artifact (4 min)
Prompt: **"{a domain question settled in `knowledge/` that the base model tends
to get wrong}"** — then, a later turn: **"{refer back to something established
earlier this session}."**
- **Artifact:** an answer grounded in the knowledge file + correct recall on the
  second prompt. Save to `evals/artifacts/5-knowledge-memory-run1.md`; ×3.

## Done when
- [ ] The knowledge fact grounds the answer every run (no drift to the model's prior).
- [ ] Session memory is recalled across a turn.

**Red flag:** it answers from training and gets the fact wrong → wire the
knowledge file into the instructions, or `#`/`@`-mention it.
**Next → Day 2:** assemble everything and run the golden path (README Steps 1–4).
