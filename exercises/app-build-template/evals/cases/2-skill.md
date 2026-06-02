# Eval · Skill

> **Builds on:** the system prompt's persona + scope.  **Sets up:** the tool the skill names (case 4-tools).

**Component built?** `.github/skills/<name>/SKILL.md` (or `.roo/commands/<name>.md`) filled.

## Test prompt
> "{Phrase the request the way a real user would — the trigger in the skill's
> description.}"

(Then, separately, an **adjacent** request the skill should NOT handle.)

## Expected artifact
The skill's **structured deliverable** — the output shape defined in its steps
(e.g. a summary with fixed sections, a checklist, a draft). Same sections, same
order, every run.

Save to `../artifacts/2-skill-runN.md`.

## Consistency bar (run ×3)
- The trigger phrase loads the skill every time; the adjacent ask never does.
- The artifact keeps the same section structure run-to-run.

PASS = skill fired on trigger (not on the adjacent ask) + artifact shape stable.
