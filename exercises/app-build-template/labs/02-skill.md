# Lab 2 — Skill

> **Builds on:** Lab 1's persona + scope.  **Sets up:** names the tool you build in Lab 3.
> **Time:** ~14 min · **Group:** rotate the driver.

## Files
- Copilot: `.github/skills/<name>/SKILL.md`  ·  Roo: `.roo/commands/<name>.md`

## Build (8 min)
1. Rename the shipped `domain-check` skill to your app's core skill (a verb:
   `summarize-meeting`, `draft-nda`, `reconcile-month`).
2. Write the front matter — `name` + `description`. **The `description` IS the
   trigger**: phrase it the way a real user asks ("recap the … call").
3. Write the steps: what it reads, the output shape it produces, what to skip.
   Name the tool it will call (you build that in Lab 3).

## Test → artifact (4 min)
Prompt: **"{the trigger phrase, as a user would say it}"** — then, separately, an
**adjacent** request the skill should NOT handle.
- **Artifact:** the skill's structured output (its deliverable), same sections
  each run. Save to `evals/artifacts/2-skill-run1.md`; run ×3.

## Done when
- [ ] The trigger loads the skill; the adjacent ask does **not**.
- [ ] The output keeps the same section structure across 3 runs.

**Red flag:** it improvises and ignores the skill → the `description` is too
vague; rewrite it in the user's words.
**Next → Lab 3:** build the tool this skill names.
