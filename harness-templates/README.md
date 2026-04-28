# Harness Templates

Starter scaffold for the Agentic Harness Engineering workshop (Day 1 · Breakout 3).
Copy this folder into a new repo, rename it to `harness/`, and edit every file
to match the app your group is reverse-engineering.

## What's here

```
harness-templates/
├── CLAUDE.md                                 # Claude Code project guide
├── AGENTS.md                                 # Codex / generic-agent guide
├── mcp.json                                  # external tool servers
├── .claude/
│   ├── settings.json                         # permissions + hook bindings
│   ├── skills/design-review.md               # progressive-disclosure prompt
│   ├── commands/plan.md                      # /plan slash command
│   ├── agents/researcher.md                  # subagent definition
│   ├── hooks/pre-tool-use.sh                 # deny dangerous Bash patterns
│   └── hooks/post-tool-use.sh                # scope check + auto-format + log
├── .roo/
│   └── rules/01-project.md                   # RooCode workspace rule
└── .github/
    ├── copilot-instructions.md               # repo-wide Copilot guidance
    ├── instructions/
    │   └── frontend.instructions.md          # path-scoped rules (applyTo)
    ├── prompts/
    │   └── plan.prompt.md                    # /plan reusable prompt
    └── agents/
        └── researcher.md                     # Copilot custom agent
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

## These templates work for non-coding domains too

The five apps you'll choose from on Day 1 (Harvey, Spellbook, Pilot, Notion
AI, Granola) are legal / accounting / productivity products — not coding
tools. The harness shape is the same; the contents change.

Concrete examples of what to put in each file by domain:

| File | Legal (Harvey-style) | Accounting (Pilot-style) | Productivity (Granola-style) |
|---|---|---|---|
| `CLAUDE.md` persona | Junior associate; never gives legal advice | Bookkeeper; flags, never finalizes | Meeting note-taker; never paraphrases quotes |
| Hard rules | Never reveal privileged content across matters | Never close a period without human approval | Never share notes outside the meeting's attendees |
| Skill | `clause-extraction.md` | `transaction-categorize.md` | `action-item-extract.md` |
| Slash command | `/draft-NDA` | `/reconcile-month` | `/post-meeting-brief` |
| Subagent | `case-law-researcher` | `anomaly-investigator` | `followup-drafter` |
| Hook (PreToolUse) | Block writes to other matters' folders | Block postings to closed accounting periods | Redact PII before any external send |
| Hook (PostToolUse) | Append matter ID to every saved file | Log every ledger change with user ID | Tag every note with attendee list |
| MCP server | iManage / NetDocuments | QuickBooks / Xero / Plaid | Google Calendar / Slack / Linear |

The included `design-review.md` skill and shell hooks are illustrative — keep
the structure, replace the body with your domain's logic.

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
