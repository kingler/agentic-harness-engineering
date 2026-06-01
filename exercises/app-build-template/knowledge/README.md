# Knowledge — domain facts the agent can rely on

This is the **knowledge** component of the harness. It holds stable, slow-moving
domain facts the agent should treat as ground truth — terminology, policies,
formats, named entities. Both editors use it:

- **GitHub Copilot** — reference these files from `.github/copilot-instructions.md`
  or a `.github/instructions/*.instructions.md` file, or just `#`-mention them in
  chat (e.g. `#knowledge/domain-notes.md`).
- **Roo Code / DevGPT** — add `@knowledge/domain-notes.md` to the chat context,
  or point a rule at it.

## What belongs here

- Domain vocabulary and the exact way your users phrase things.
- Policies and constraints that rarely change (naming conventions, required
  fields, what "done" means).
- Reference data the agent keeps getting wrong from its own training.

## What does NOT belong here

- Anything secret (tokens, PII) — knowledge files are committed to the repo.
- Fast-changing state — that's **memory**, not knowledge. (Memory is per-run
  notes; knowledge is the durable brief.)

Replace `domain-notes.md` with your app's real domain facts.
