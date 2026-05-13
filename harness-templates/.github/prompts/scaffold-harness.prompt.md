---
mode: agent
description: Interview the participant and scaffold the initial harness (AGENTS.md, surface mirrors, first tool, smoke eval) from their Breakout 2 decisions.
---

# /scaffold-harness — Copilot prompt file

You are scaffolding the initial harness for a workshop group during
Breakout 3 (Day 1, 25 min). You will interview the user with **seven
short questions**, then generate **five files** in one pass. You do not
edit anything until every answer is collected.

The user is sitting in a freshly copied `harness-templates/` directory.
Treat the existing `{{placeholder}}` strings in this template as the
slots you must fill.

## Hard rules for this command

- **Ask one question per turn.** Wait for the user's answer before
  asking the next. Do not batch.
- **Quote the user back to themselves** in one short sentence before
  asking the next question, so they catch fuzzy answers fast.
- **No editing until all seven answers are in.** Then write all five
  files in a single pass and stop.
- **Stay under 200 words per generated file.** Tight is the point.
- **Refuse to invent decisions.** If an answer is `idk` or empty, ask
  the user to pick from 2–3 concrete options you propose. Never make
  the call for them.

## The seven questions (ask in this order)

1. **Agent name + one-sentence purpose.**
   "What is this agent called, and in one sentence — what does it do
   for whom?" Example shape: *"`design-review-bot` — reviews Figma
   exports against our token system for product designers."*

2. **Primary user intent (golden path).**
   "Walk me through the ideal interaction in 3 steps. User does X →
   agent does Y → user gets Z."

3. **Nightmare failure mode.**
   "What is the worst thing this agent could do? One sentence. This
   becomes a hard rule and, later, a hook."

4. **One absolute 'never'.**
   "Name the single action this agent must never take — even if the
   user asks. Be specific about the file path, command, or domain."

5. **Sandbox boundary.**
   "Where is this agent allowed to write? (Pick one: project root only
   / a specific subdir / read-only / cloud sandbox only.) And what is
   it blocked from?"

6. **First tool.**
   "Give me one verb-phrase tool name and a one-sentence description
   that says *what it does, when to use it, and when NOT to use it*."
   Example: *"`compare_token_names` — Compares component names in a
   Figma export against the approved token dictionary. Use when the
   user asks to audit naming. Do NOT use for general file reading."*

7. **Smoke test prompt.**
   "Give me the simplest user prompt you'd type to check this harness
   is alive. Then name one phrase that MUST appear in the answer, and
   one phrase that MUST NOT."

After question 7, restate all seven answers in a numbered list and ask
**"Generate the five files? (yes / edit N)"**. Only proceed on `yes`.

## Files to generate (in this order, one pass)

Replace every `{{placeholder}}` you find. Do not invent fields that
were not in the answers; leave a single-line `> TODO:` comment instead.

### 1. `AGENTS.md`

Use the existing template at the repo root. Fill:
- **Persona** → from Q1 + Q2 ("A focused {{role}} agent helping
  {{audience}} accomplish {{primary intent}}…").
- **What this harness is for** → primary intent (Q2), out of scope (a
  one-line inverse of Q4), failure mode (Q3).
- **Hard rules** → keep rules 1–4 unchanged, add rule 5 = the Q4
  "never" verbatim.
- **Tool palette** → append the Q6 tool to the existing list.

Keep the file under 200 lines. Do not delete existing sections —
`Cross-surface sync`, `Escalation`, `Working memory`, `When in doubt`
stay as-is.

### 2. `.github/copilot-instructions.md`

Mirror the same persona and hard rules from Q1–Q4 into this file.
Both files must agree word-for-word on the persona sentence and the
hard rules list. This is the cross-surface sync the template warns
about.

### 3. `.roo/rules/01-project.md`

Mirror the same hard rules (Q3 + Q4) into the RooCode / Cline rules
file. Persona is optional here; rules are mandatory.

### 4. `scripts/{{tool-name}}.sh`

Generate a tool stub script from Q6. Shape:

```bash
#!/usr/bin/env bash
# scripts/{{tool-name}}.sh — {{description from Q6}}
#
# Usage: scripts/{{tool-name}}.sh <arg1> [arg2]
# Output: one JSON object on stdout. Stderr is for diagnostics only.

set -euo pipefail

# TODO: implement. For now, echo a stub so the harness wiring works.
echo "{\"tool\":\"{{tool-name}}\",\"status\":\"stub\",\"args\":\"$*\"}"
```

After writing it, `chmod +x` it and add this line to the README under
"Tool palette":

```
- `scripts/{{tool-name}}.sh` — {{one-line description from Q6}}
```

### 5. `evals/cases/smoke-{{tool-name}}.json`

Generate one smoke eval case from Q7:

```json
{
  "id": "smoke-{{tool-name}}",
  "prompt": "{{Q7 prompt}}",
  "expect": {
    "must_include": ["{{Q7 must-include}}"],
    "must_not_include": ["{{Q7 must-not-include}}"],
    "max_tokens": 400
  },
  "tags": ["smoke", "{{tool-name}}"]
}
```

## After generating

End your turn with this exact 4-line summary so the user can verify in
under 30 seconds:

```
Scaffolded:
  AGENTS.md ............. persona + {{N}} hard rules
  copilot-instructions .. mirrored
  .roo/rules/01-project . mirrored
  scripts/{{tool}}.sh ... stub, chmod +x
  evals/cases/smoke ..... 1 case

Next: try the smoke prompt — "{{Q7 prompt}}"
```

Then stop. Do not run the eval, do not commit, do not push. The user
drives the next step.
