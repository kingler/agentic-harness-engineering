# Harness Templates

Starter scaffold for the Agentic Harness Engineering workshop (Day 1 · Breakout 3).
Copy this folder into a new repo, rename it to `harness/`, and edit every file
to match the app your group is reverse-engineering.

## What's here

```
harness-templates/
├── CLAUDE.md                       # project-level system prompt for Claude Code
├── AGENTS.md                       # same idea, for Codex / generic agents
├── mcp.json                        # external tool servers (Figma, GitHub, etc.)
├── .claude/
│   ├── settings.json               # permissions + hook bindings
│   ├── skills/design-review.md     # progressive-disclosure prompt
│   ├── commands/plan.md            # /plan slash command
│   ├── agents/researcher.md        # subagent definition
│   └── hooks/post-tool-use.sh      # deterministic guardrail
├── .roo/
│   └── rules/01-project.md         # RooCode workspace rule
└── .github/
    └── copilot-instructions.md     # GitHub Copilot project guide
```

## How to use it in the workshop

**Breakout 3 — Develop (20 min)**

1. Copy this folder, rename it `harness/`, push to a branch.
2. Rewrite `CLAUDE.md` for your chosen app's persona, rules, and constraints.
3. Edit one skill, one command, one subagent, and one hook so they reflect a
   real workflow your harness will support.
4. Update `settings.json` to bind the hook and scope tool permissions.
5. Mirror the project-level rule into `.roo/rules/01-project.md` and
   `.github/copilot-instructions.md` so the same harness works in RooCode and
   Copilot too.

## Ground rules

- Keep `CLAUDE.md` under 200 lines — it is your highest-leverage file.
- Cap tools at 7. A bigger tool list usually makes the agent worse.
- Tool descriptions are UX copy for the model — write them like you'd write
  a button label, not like JSDoc.
- Anything that should happen "every time" belongs in a hook, not a prompt.
- Read 5 transcripts before changing a single tool description.

## References

- LangChain · "The Anatomy of an Agent Harness" — blog.langchain.com
- arXiv 2603.20075 · "Agentic Harness for Real-World Compilers"
- RooCode docs — docs.roocode.com
- GitHub Copilot · custom instructions — docs.github.com/copilot
- Claude Code docs — code.claude.com/docs
- Model Context Protocol — modelcontextprotocol.io
