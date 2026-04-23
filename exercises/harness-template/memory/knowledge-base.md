# Knowledge Base — [Your Agent Name]

> This file is the agent's persistent memory. It contains facts, conventions, and accumulated knowledge
> that should be available at the start of every session.
>
> Unlike a database, this is a human-readable markdown file — you can edit it directly.
> Unlike the system prompt, this is meant to grow over time as the agent learns.
>
> Load this into your agent's context at the start of each session (see config.json → context.memory_file).

---

## About This Project

**Project name:** [TODO: Your project name]

**What we're building:** [TODO: Brief description of the product/feature this agent supports]

**Current phase:** [TODO: e.g., "Design system audit — Q2 2026"]

**Last updated:** [TODO: Date]

---

## Design System

**Name:** [TODO: e.g., "Acme Design System v3.2"]

**Component library:** [TODO: e.g., "Built on shadcn/ui + custom Tailwind tokens"]

**Token structure:**

```
tokens/
├── colors.json      # Color tokens (--color-primary, --color-secondary, etc.)
├── typography.json  # Font sizes, weights, line heights
├── spacing.json     # Spacing scale (4px base unit)
└── components.json  # Component-level overrides
```

**Naming conventions:**
- [TODO: e.g., "Component names use PascalCase: `ButtonPrimary`, not `button-primary`"]
- [TODO: e.g., "Tokens use kebab-case with namespace prefix: `--ds-color-brand-500`"]
- [TODO: e.g., "Layer names in Figma follow: `[type]/[variant]/[state]` — e.g., `button/primary/hover`"]

**Design system documentation:** [TODO: URL or file path]

---

## Team Conventions

**File naming:**
- [TODO: Your team's file naming rules]

**Review process:**
- [TODO: e.g., "All component changes require design review before handoff"]
- [TODO: e.g., "Use Figma branching for major design explorations"]

**Handoff format:**
- [TODO: e.g., "Developers receive Figma links + token exports + a Loom walkthrough for complex components"]

---

## Approved Exceptions & Known Overrides

> Things the agent should know about that are intentional departures from the standard rules.

| Rule | Exception | Reason | Approved by |
|------|-----------|--------|-------------|
| [TODO: rule] | [TODO: exception] | [TODO: why] | [TODO: who] |

---

## Frequently Asked Questions

> Add questions that come up repeatedly. The agent will use this to answer common queries faster.

**Q: [TODO: Common question]**
A: [TODO: Answer]

**Q: [TODO: Common question]**
A: [TODO: Answer]

---

## Accumulated Learnings

> Add notes here when the agent learns something that should persist across sessions.
> Date each entry so you can audit and remove stale knowledge.

- **[Date]:** [TODO: e.g., "Users often confuse 'component' and 'variant' — always clarify which they mean when the request is ambiguous"]
- **[Date]:** [TODO: e.g., "The `ButtonGroup` component was deprecated in v3.1 — suggest `Stack + Button` instead"]

---

## Resources

**Design files:**
- [TODO: Figma file URL or path]

**Documentation:**
- [TODO: Notion/Confluence/GitHub wiki URL]

**Storybook:**
- [TODO: Storybook URL]

**Slack channel for design system questions:**
- [TODO: #channel-name]

---

*This file is loaded into agent context at session start. Keep it concise — information not used frequently belongs in a separate reference file, not here.*
