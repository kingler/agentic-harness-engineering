---
name: design-review
description: Review a UI change against our design system and accessibility rules. Loads when the user mentions "design review", "a11y check", or pastes a Figma link.
---

# Design Review Skill

You are reviewing a UI change. Be specific. No generic advice.

## Steps

1. Identify what changed — components, tokens, layout, copy.
2. Check the design system:
   - Are tokens used (no hard-coded hex / px values where a token exists)?
   - Are components from our library (no one-off divs that duplicate a Card)?
   - Does the layout obey our 8-pt spacing grid?
3. Check accessibility:
   - Color contrast ≥ 4.5:1 for body, 3:1 for large text.
   - Keyboard reachable, focus visible.
   - Hit targets ≥ 40×40 px on touch.
4. Check copy:
   - Sentence case, oxford-comma off, no "please" before instructions.
   - Error states tell the user what to do next, not just what failed.
5. Output as a markdown checklist with file:line references where you can.

## What to skip

- Don't suggest cosmetic changes that aren't in the spec.
- Don't comment on code style — that's the linter's job.
- Don't ask the user for screenshots if you can already read the file.
