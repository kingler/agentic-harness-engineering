# Lab 1 — System prompt

> **Builds on:** your `app-brief.md`.  **Sets up:** the scope every later component honors; names the risky surface Lab 4 will guard.
> **Time:** ~14 min · **Group:** driver shares screen, everyone writes their own.

## Files (your editor's lane)
- Shared: `AGENTS.md`
- Copilot: `.github/copilot-instructions.md`  ·  Roo: `.roo/rules/`

## Build (8 min)
1. Open `AGENTS.md`. Replace the `{{placeholders}}` with your app's:
   - **Identity** — who the agent is, in one sentence.
   - **Scope** — the one core job + what's explicitly out of scope.
   - **Hard rules** — rule #1 = your nightmare-failure "never" (Lab 4 enforces it).
2. Mirror the persona + hard rules into your editor's file (Copilot
   `copilot-instructions.md` / Roo `.roo/rules/`). Keep all copies in sync.
3. Keep it under 200 lines.

## Test → artifact (4 min)
Prompt: **"In one sentence, what are you and what won't you do? Then {the one
out-of-scope request your scope forbids}."**
- **Artifact:** a stable persona/scope statement + a **refusal** naming the reason.
- Save to `evals/artifacts/1-system-prompt-run1.md`; run twice more — the
  refusal must fire **every** time.

## Done when
- [ ] No `{{placeholders}}` left in Identity / Scope / Hard rules.
- [ ] The out-of-scope ask is refused across 3 runs (not "okay, just once").

**Red flag:** a generic "I'm an AI assistant" → your Identity isn't landing.
**Next → Lab 2:** the scope you just set is what your skill must honor.
