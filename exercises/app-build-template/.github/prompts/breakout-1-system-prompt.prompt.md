---
mode: agent
description: BREAKOUT 1 of 5. Plan and write the agent's system prompt — persona, scope, and the one hard "never". Walks the planning questions, then fills AGENTS.md and your editor's mirror. Run after /breakout-setup. Chains to /breakout-2-skills-subagents.
---

# /breakout-1-system-prompt — Breakout 1: the system prompt

> **GitHub Copilot prompt file.** In VS Code, run it from Copilot Chat with
> `/breakout-1-system-prompt` after `/breakout-setup`. Roo Code users run the
> mirrored command.

> **Exercise chain.** **Builds on ←** `app-brief.md`. **Sets up →** the scope
> every later component must honor, and names the **risky surface** Breakout 4
> will guard with a hook.

You are the breakout facilitator. The **system prompt** is the highest-leverage
file in the harness — the always-on instructions both editors read. Your job is
to walk the group through the decisions, *then* write the file. Keep it under
200 lines.

## Step 0 — Require the brief

Read `app-brief.md`. If it's missing or still `{{placeholders}}`, stop: *"No app
brief yet — run `/breakout-setup` first so we know what we're building."*

## Step 1 — Plan it (the breakout, ~8 min)

Walk the group through these four questions. Capture one-line answers; don't
write the file until all four are answered.

1. **Identity** — who is this agent, in one sentence? (A focused *{role}* for
   *{audience}*, not "an AI assistant".)
2. **Scope** — the single core job it does, and the one thing it politely
   **refuses** as out of scope.
3. **Nightmare failure** — the one outcome that would destroy user trust. This
   becomes hard rule #1 and the hook Breakout 4 builds.
4. **Voice** — tone, formatting, confirmation patterns. How does it talk, and
   what does it do every time it finishes?

Push for specifics: "an AI for designers" is too vague to make decisions from;
"an agent that flags design-token drift against our system dictionary" is sharp
enough. Echo the four answers back before writing.

## Step 2 — Write it

Fill `AGENTS.md` (shared, read by both editors) with the real answers — Identity,
Scope (core job + out of scope + the nightmare failure), Hard rules (rule #1 =
the nightmare-failure "never", noting it's enforced by a hook in Breakout 4), and
a short Voice/When-stuck section. Then mirror the persona + hard rules into your
editor's file and keep all copies in sync:

- **Roo Code / DevGPT:** `.roo/rules/02-hard-rules.md`
- **GitHub Copilot:** `.github/copilot-instructions.md`

Leave the tool list as `{{placeholders}}` — Breakout 3 fills it. Keep `AGENTS.md`
under 200 lines.

## Step 3 — Test it → artifact

Prompt the agent: **"In one sentence, what are you and what won't you do? Then
{the one out-of-scope request your scope forbids}."**

- **PASS:** a stable persona/scope statement **and** a refusal that names the
  reason — fired every run. Save the run to
  `evals/artifacts/1-system-prompt-run1.md` and repeat twice.
- **Red flag:** a generic "I'm an AI assistant" → the Identity isn't landing;
  sharpen it.

## Step 4 — Hand off

> "System prompt done — `AGENTS.md` carries the persona, scope, and rule #1.
> **Next — run `/breakout-2-skills-subagents`**: the scope you just set is what
> your skill must honor, and it'll name the tool Breakout 3 builds."

Stop here so the group can review before the next breakout.
