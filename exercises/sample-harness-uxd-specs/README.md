# Sample Harness — UXD Spec Manager

A reference harness for the workshop. The agent helps a UX design team
**author, validate, and shepherd spec documents** through a review workflow.

Use this folder as a worked example. Read it, copy from it, argue with the
choices made here. It is intentionally opinionated so that participants have
something concrete to react to during breakouts.

## Domain in 60 seconds

UXD teams keep a library of spec documents under `specs/` — one Markdown file
per spec, with YAML frontmatter. Specs move through five states:

```
draft → in-review → approved → implemented → archived
```

Each spec has a stable ID (`SPEC-YYYY-NNN`), an owner, optional `design_reference` links,
links to related specs, and a fixed set of required sections. The spec library
is the single source of truth for what the team is building.

## What this harness covers

| Bucket          | Files                                                |
| --------------- | ---------------------------------------------------- |
| System prompt   | `prompts/system-prompt.md`, `AGENTS.md`              |
| Tools (JSON)    | `tools/*.json`                                       |
| Scripts         | `scripts/*.sh`                                       |
| MCP             | `mcp/mcp.json`                                       |
| Hooks           | `hooks/pre-tool-use.sh`, `hooks/post-tool-use.sh`    |
| Rules           | `rules/01-spec-rules.md`                             |
| Knowledge base  | `knowledge/*.md`                                     |
| Sample data     | `specs/templates/*.md`, `specs/SPEC-2026-001.md`     |

## How the pieces fit together

```
        ┌────────────────────┐
        │  system-prompt.md  │  identity, workflow, escalation
        └─────────┬──────────┘
                  │ reads
                  ▼
        ┌────────────────────┐
        │     AGENTS.md      │  capabilities, tool palette, never/always
        └─────────┬──────────┘
                  │ references
        ┌─────────┴──────────┐
        ▼                    ▼
  tools/*.json         knowledge/*.md
  (interface)          (domain context)
        │
        │ calls
        ▼
  scripts/*.sh ◄── pre-tool-use.sh (gates)
        │
        ▼
  filesystem (specs/) ──► post-tool-use.sh (auto-bumps version, updated:)
```

The **rules** file (`rules/01-spec-rules.md`) is loaded by RooCode/Cline-style
harnesses. The same rules also appear, condensed, in `AGENTS.md` so that any
harness reading either file gets a consistent picture.

## Reading order for participants

1. `prompts/system-prompt.md` — what the agent is
2. `AGENTS.md` — what the agent can do
3. `tools/validate_spec.json` + `scripts/validate_spec.sh` — one tool end to end
4. `hooks/pre-tool-use.sh` — how a "never" rule is enforced in code
5. `rules/01-spec-rules.md` — the policy layer
6. `mcp/mcp.json` — external integrations

## Out of scope on purpose

- No live Jira API calls — MCP entries point to public servers but the
  workshop scripts mock most side effects.
- No model wiring (`config.json`, model selection) — covered in the main
  template.
- No evals — covered in `harness-templates/evals/`.
