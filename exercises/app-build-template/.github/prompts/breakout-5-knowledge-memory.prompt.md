---
mode: agent
description: BREAKOUT 5 of 5. Plan and write the agent's grounding — durable domain knowledge plus the per-session memory plan. Walks the planning questions, then fills knowledge/domain-notes.md and memory/SESSION.md. Run after /breakout-4-hooks-rules. Chains to Day 2 (/plan-app).
---

# /breakout-5-knowledge-memory — Breakout 5: knowledge + memory

> **GitHub Copilot prompt file.** In VS Code, run it from Copilot Chat with
> `/breakout-5-knowledge-memory` after Breakout 4. Roo Code users run the mirrored
> command.

> **Exercise chain.** **Builds on ←** what Breakout 2's skill needs to know +
> Breakout 1's scope. **Sets up →** the grounded golden path you assemble on Day
> 2.

You are the breakout facilitator. **Knowledge** is the durable, stable facts the
agent should quote instead of guessing; **memory** is the per-session state that
carries across turns. Knowledge = forever; memory = this session. Now that the
risky path is gated (Breakout 4), it's safe to ground the agent and let it reach.

## Step 0 — Require the gated tool

Read `AGENTS.md`, the skill (Breakout 2), and the hook (Breakout 4). If the gate
isn't in place, stop: *"Gate the risky action first — run
`/breakout-4-hooks-rules`. Ground the agent only after the dangerous path is
blocked."*

## Step 1 — Plan it (the breakout, ~8 min)

**Knowledge:**
1. **What the base model gets wrong** — the domain vocabulary, policies, and
   facts the agent keeps fumbling without help. These are your knowledge bullets.
2. **What the skill needs to quote** — pull the facts Breakout 2's skill relies
   on so its deliverable is correct, not plausible.
3. **How it gets read** — wire it into the instructions, or reference it in chat
   with `@knowledge/...` (Roo) / `#knowledge/...` (Copilot).

**Memory:**
4. **What should carry across turns** — the per-session state worth remembering
   (the current matter, the meeting being recapped) — and, explicitly, what must
   **never** be stored (secrets, PII).

## Step 2 — Write it

- `knowledge/domain-notes.md` (shared) — the stable facts as bullets the agent
  can quote: vocabulary, policies, the things it keeps getting wrong. Carry over
  any domain terms captured in `plan/domain-research.md` if it exists.
- `memory/SESSION.md` (shared) — the memory plan: what state carries across
  turns this session, and the no-secrets/no-PII line.
- Reference `knowledge/` from your editor's instructions so the agent actually
  reads it (`.roo/rules/` / `.github/copilot-instructions.md`).

## Step 3 — Test it → artifact

Prompt: **"{a domain question settled in knowledge/ that the base model tends to
get wrong}"** — then, a later turn: **"{refer back to something established
earlier this session}."**

- **PASS:** the knowledge fact grounds the answer every run (no drift to the
  model's prior) **and** the session state is recalled on the second prompt. Save
  to `evals/artifacts/5-knowledge-memory-run1.md` and repeat ×3.
- **Red flag:** it answers from training and gets the fact wrong → wire the
  knowledge file into the instructions, or `@`/`#`-mention it.

## Step 4 — Hand off

> "All five components are built: system prompt, skill + subagent, tool + MCP,
> hook + rule, knowledge + memory. **Next — Day 2**: run `/plan-app` →
> `/bootstrap-harness` → build the frontend → `/test-harness` to assemble them
> into the app and prove the golden path generates your headline artifact
> consistently."

Stop here.
