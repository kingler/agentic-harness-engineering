# Harness Templates

Starter scaffold for the Agentic Harness Engineering workshop (Day 1 · Breakout 3).
Copy this folder into a new repo, rename it to `harness/`, and edit every file
to match the app your group is reverse-engineering.

## What's here

```
harness-templates/
├── AGENTS.md                                 # Project guide — read by Copilot's coding agent and Cline / RooCode
├── mcp.json                                  # external tool servers (MCPs)
├── memory/
│   └── SESSION.md                            # session memory — survives between runs
├── knowledge/
│   ├── README.md                             # how domain knowledge is used
│   └── style-guide.md                        # example domain doc (replace per workshop)
├── evals/
│   ├── README.md                             # eval format and runner contract
│   └── cases/smoke.json                      # one example eval case
├── scripts/
│   └── run-eval.sh                           # custom tool — invokable eval runner
├── .github/
│   ├── copilot-instructions.md               # repo-wide Copilot guidance
│   ├── instructions/
│   │   └── frontend.instructions.md          # path-scoped rules (applyTo)
│   ├── prompts/
│   │   ├── plan.prompt.md                    # /plan — single-step prompt
│   │   ├── fix-until-green.prompt.md         # loop pattern (capped iterations)
│   │   ├── ship-ui-change.prompt.md          # workflow / prompt chain
│   │   ├── review-team.prompt.md             # agent team (parallel fan-out)
│   │   └── improve.prompt.md                 # learning cycle (one change per pass)
│   ├── agents/
│   │   ├── researcher.md                     # read-only research agent
│   │   └── critic.md                         # read-only critic agent
│   └── hooks/
│       ├── pre-tool-use.sh                   # deny dangerous Bash patterns (cloud agent)
│       └── post-tool-use.sh                  # scope check + auto-format + log
└── .roo/
    └── rules/01-project.md                   # RooCode / Cline workspace rule
```

> **Note.** A legacy `.claude/` directory and a `CLAUDE.md` file are also
> shipped in this template for reference. Workshop participants don't use
> them — they're left in place for anyone running the same harness through
> Anthropic's Claude Code CLI separately.

## Anatomy mapped to files

For a visual reference (one diagram per concept), see [`ANATOMY.md`](./ANATOMY.md).

| Concept | Where it lives |
|---|---|
| System prompt | `AGENTS.md` (Persona + Scope) |
| Rules | `AGENTS.md` (Hard rules), `.roo/rules/`, `.github/copilot-instructions.md`  |
| Skills | `.github/prompts/` |
| Tools (scripts) | `scripts/` + `Bash(scripts/…:*)` allow entries |
| Hooks | `.github/hooks/` bound via Copilot hook config |
| MCPs | `mcp.json` |
| Loops | `.github/prompts/fix-until-green.md` (capped observe→act→re-observe) |
| Workflows | `.github/prompts/ship-ui-change.md` (named skill chain) |
| Subagents | `.github/agents/` (one per role) |
| Agent teams | `.github/prompts/review-team.md` (parallel fan-out + merge) |
| Memory | `memory/SESSION.md` |
| Domain knowledge | `knowledge/` (markdown today, vector store / retrieval MCP later) |
| Evaluation | `evals/` + `scripts/run-eval.sh` |
| Learning | `.github/prompts/improve.md` (transcripts → one change → eval) |

## How to use it in the workshop

**Breakout 3 — Develop (20 min)**

1. Copy this folder, rename it `harness/`, push to a branch.
2. Rewrite `AGENTS.md` for your chosen app's persona, rules, and constraints.
3. Edit one prompt file, one custom agent, and one hook so they reflect a
   real workflow your harness will support.
4. Update `.github/copilot-instructions.md` to scope what Copilot can do.
5. Mirror the project-level rule into `.roo/rules/01-project.md` so the same
   harness also works for participants using Cline / RooCode.

## These templates work for non-coding domains too

The five apps you'll choose from on Day 1 (Harvey, Spellbook, Pilot, Notion
AI, Granola) are legal / accounting / productivity products — not coding
tools. The harness shape is the same; the contents change.

Concrete examples of what to put in each file by domain:

| File | Legal (Harvey-style) | Accounting (Pilot-style) | Productivity (Granola-style) |
|---|---|---|---|
| `AGENTS.md` persona | Junior associate; never gives legal advice | Bookkeeper; flags, never finalizes | Meeting note-taker; never paraphrases quotes |
| Hard rules | Never reveal privileged content across matters | Never close a period without human approval | Never share notes outside the meeting's attendees |
| Prompt file | `clause-extraction.prompt.md` | `transaction-categorize.prompt.md` | `action-item-extract.prompt.md` |
| Slash command | `/draft-NDA` | `/reconcile-month` | `/post-meeting-brief` |
| Subagent | `case-law-researcher` | `anomaly-investigator` | `followup-drafter` |
| Hook (PreToolUse) | Block writes to other matters' folders | Block postings to closed accounting periods | Redact PII before any external send |
| Hook (PostToolUse) | Append matter ID to every saved file | Log every ledger change with user ID | Tag every note with attendee list |
| MCP server | iManage / NetDocuments | QuickBooks / Xero / Plaid | Google Calendar / Slack / Linear |

The included `design-review.md` skill and shell hooks are illustrative — keep
the structure, replace the body with your domain's logic.

## Ground rules

- Keep `AGENTS.md` under 200 lines — it is your highest-leverage file.
- Cap tools at 7. A bigger tool list usually makes the agent worse.
- Tool descriptions are UX copy for the model — write them like you'd write
  a button label, not like JSDoc.
- Anything that should happen "every time" belongs in a hook, not a prompt.
- Read 5 transcripts before changing a single tool description.

## References

- LangChain · "The Anatomy of an Agent Harness" — blog.langchain.com
- arXiv 2603.20075 · "Agentic Harness for Real-World Compilers"
- GitHub Copilot · custom instructions — docs.github.com/en/copilot
- RooCode docs — docs.roocode.com
- Cline docs — docs.cline.bot
- Model Context Protocol — modelcontextprotocol.io
