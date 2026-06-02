# Eval · Knowledge + memory

> **Builds on:** what the skill needs to know (case 2-skill) + the system prompt's scope.  **Sets up:** the grounded golden path (case 6).

**Component built?** a `knowledge/` domain file the agent reads, and a memory
plan (`memory/SESSION.md`).

## Test prompt
> "{Ask a domain question whose answer is settled in `knowledge/` — pick one the
> base model tends to get wrong.}"

Then, in a **later turn** of the same session:
> "{Refer back to something you established earlier this session.}"

## Expected artifact
An answer that **uses the knowledge file** (quotes the fact / convention, not
the model's guess) and — on the second prompt — **correct recall** of the
session memory.

Save to `../artifacts/5-knowledge-memory-runN.md`.

## Consistency bar (run ×3)
- The knowledge fact grounds the answer every run (no drift back to the model's
  prior).
- Session memory persists across turns within a run.

PASS = knowledge grounds the answer + memory recalled, consistently.
