# Harness Anatomy — Visual Reference

Fourteen concepts make up an agent harness. Each diagram below shows
*behaviour*, not file layout — i.e. what happens at runtime when the
agent is working.

For the file-by-file layout and the concept→file mapping, see
[`README.md`](./README.md).

---

## 1. System prompt

The system prompt is **persistent context**. It is prepended to every
turn the agent takes, survives compaction, and sets the persona,
scope, and hard rules.

```mermaid
flowchart LR
    SP[System prompt<br/>AGENTS.md] -.->|prepended| T1[Turn 1]
    SP -.->|prepended| T2[Turn 2]
    SP -.->|prepended| Tn[Turn N...]
    T1 --> T2 --> Tn
```

File: `AGENTS.md` (and its mirrors in `AGENTS.md`, `.github/copilot-instructions.md`).

---

## 2. Rules

Rules are **predicates on agent actions**. The agent forms an intent;
the rules layer either lets it through or refuses it. Some rules are
soft (in the system prompt), some are hard (enforced by `settings.json`
allow/deny lists, or by hooks).

```mermaid
flowchart LR
    Intent[Agent intent<br/>e.g. rm -rf node_modules] --> Rules{Rules check}
    Rules -->|allow| Act[Action runs]
    Rules -->|deny| Refuse[Refuse + explain]
```

Files: `AGENTS.md` "Hard rules", `.roo/rules/01-project.md`, `.github/copilot-instructions.md` allow/deny.

---

## 3. Skills

A skill is a **prompt loaded on demand**. The agent doesn't carry every
specialist instruction in its base context — it loads the skill only
when a trigger phrase or condition matches. This is "progressive
disclosure" applied to prompts.

```mermaid
flowchart LR
    User[User input] --> Match{"Trigger match?<br/>e.g. 'design review'"}
    Match -->|yes| Load[Load skill prompt]
    Match -->|no| Plain[Continue without skill]
    Load --> Apply[Apply skill steps]
    Apply --> Reply[Reply to user]
    Plain --> Reply
```

File: `.github/prompts/design-review.md`.

---

## 4. Tools (scripts)

A tool is a **stable, named capability** the agent can invoke. In
practice, most custom tools are scripts with a known interface; the
agent calls them via `Bash` and reads their stdout. The script does
the work in the world (filesystem, network, APIs); the agent only
sees the output.

```mermaid
flowchart LR
    Agent -->|Bash call with args| Script[scripts/run-eval.sh]
    Script -->|read/write| World[(filesystem<br/>tests<br/>APIs)]
    Script -->|stdout JSON or text| Agent
```

Files: `scripts/run-eval.sh` + `Bash(scripts/run-eval.sh:*)` allow rule in `settings.json`.

---

## 5. Hooks

Hooks **bracket every tool call**. PreToolUse runs before the tool and
can refuse it; PostToolUse runs after and can validate, format, or
log. Hooks are deterministic — they always run, regardless of what the
model decided.

```mermaid
flowchart LR
    Agent -->|wants to call tool| Pre{PreToolUse hook}
    Pre -->|allow| Tool[Tool executes]
    Pre -->|deny exit 2| Block[Block + reason]
    Tool --> Post{PostToolUse hook}
    Post -->|scope/format/log| Agent
```

Files: `.github/hooks/pre-tool-use.sh`, `.github/hooks/post-tool-use.sh`, bound via Copilot hook config.

---

## 6. MCPs

An MCP server is a **typed bridge to an external system**. The agent
speaks one protocol (MCP) and gets a uniform tool surface; the server
handles auth, rate limits, and the system's actual API.

```mermaid
flowchart LR
    Agent <-->|MCP protocol<br/>list_tools / call_tool| Server[MCP server<br/>e.g. github, figma]
    Server <-->|native API + auth| External[(External system)]
```

File: `mcp.json`.

---

## 7. Loops

A loop is **observe → act → re-observe with a cap**. The cap is the
key part: a stuck agent shouldn't keep editing forever. Common shape:
run tests, fix one thing, re-run, stop on green or after N iterations.

```mermaid
flowchart LR
    Start --> Obs[Observe<br/>run tests]
    Obs --> Check{Green?}
    Check -->|yes| Done[Stop: green]
    Check -->|no, n &lt; 3| Act[Fix first failure]
    Act --> Obs
    Check -->|no, n = 3| Esc[Stop: escalate]
```

File: `.github/prompts/fix-until-green.md`.

---

## 8. Workflows (skill chains)

A workflow is a **named, ordered sequence of skills, subagents, and
tools** that ships one user-visible outcome. Each step's output is
the next step's input. Workflows are the unit of "we have done this
many times, let's bottle it".

```mermaid
flowchart LR
    Plan["/plan"] --> Research[researcher subagent]
    Research --> Edit[edit files]
    Edit --> Review[design-review skill]
    Review --> Fix["/fix-until-green"]
    Fix --> Report[ship report]
```

File: `.github/prompts/ship-ui-change.md`.

---

## 9. Subagents

A subagent is **a child agent with a narrower toolset and its own
output contract**. The main agent delegates a task and gets back a
structured result. Subagents are how you keep the main context
small — research, critique, and lookup happen in their own sessions.

```mermaid
flowchart LR
    Main[Main agent] -->|delegate task| Sub[Subagent<br/>e.g. researcher]
    Sub -->|narrow tools<br/>Read/WebSearch| Sources[(docs, code, web)]
    Sub -->|structured brief| Main
```

Files: `.github/agents/researcher.md`, `.github/agents/critic.md`.

---

## 10. Agent teams

A team is **multiple subagents on the same input, in parallel, then
merged**. The value is independent perspectives — researcher and
critic should *not* see each other's drafts before producing their
own. The main agent does the merge.

```mermaid
flowchart LR
    Input[diff or task] --> R[researcher subagent]
    Input --> C[critic subagent]
    R -->|brief| Merge[Main agent: merge]
    C -->|issues| Merge
    Merge --> Out[ranked report]
```

File: `.github/prompts/review-team.md`.

---

## 11. Memory

Memory is **state that survives between sessions**. The system prompt
is static; memory is read at session start and written during/after.
Useful for decisions, names, and conventions you don't want the user
to repeat.

```mermaid
flowchart LR
    Start[Session start] -->|read| Mem[("memory/SESSION.md")]
    Mem --> Agent[Agent works]
    Agent -->|append| Mem
    Mem -.persists.-> NextSession[Next session]
```

File: `memory/SESSION.md`.

---

## 12. Domain knowledge

Domain knowledge is **facts the agent retrieves on demand**, distinct
from skills (which describe *behaviour*). For workshop-scale harnesses
this is just markdown files; in production, swap in a vector store or
retrieval MCP.

```mermaid
flowchart LR
    Q[Agent question] --> Need{"Need a domain fact?"}
    Need -->|yes| KB[("knowledge/*.md")]
    KB -->|cite verbatim| Cited[Answer with citation]
    Need -->|no| Plain[Answer from prompt]
```

Files: `knowledge/README.md`, `knowledge/style-guide.md`.

---

## 13. Evaluation

Evals are **the regression test for prompts**. A change in AGENTS.md,
a new skill, or a model upgrade can silently break behaviour. Evals
catch that before it ships. One JSON case per behaviour you care
about; one runner script that prints pass/fail per case.

```mermaid
flowchart LR
    Cases[("evals/cases/*.json")] --> Run["scripts/run-eval.sh"]
    Run --> Per["per-case JSON: pass/fail"]
    Per --> Diff{"Regression vs. baseline?"}
    Diff -->|yes| Block[Block ship]
    Diff -->|no| Pass[Ship + log baseline]
```

Files: `evals/README.md`, `evals/cases/smoke.json`, `scripts/run-eval.sh`.

---

## 14. Learning

Learning is **how the harness improves between sessions**. You don't
train the model — you refine its prompts, skills, hooks, and tools
based on what real sessions reveal. One change per cycle, evaluated
against the eval set, kept or discarded based on the delta.

```mermaid
flowchart LR
    Logs[("transcripts +<br/>edits.log")] --> Find[Find one pattern]
    Find --> Propose[Propose one change]
    Propose --> Eval["Run evals"]
    Eval --> Better{"Score improves?"}
    Better -->|yes| Merge[Update AGENTS.md / skill]
    Better -->|no| Discard[Discard]
```

File: `.github/prompts/improve.md`.

---

## How they compose

The fourteen concepts aren't independent. A real harness layers them:

```mermaid
flowchart TB
    User[User turn] --> Main[Main agent]
    Main -.persistent.-> SP["System prompt + Rules"]
    Main -.session start.-> Mem[(Memory)]
    Main -->|may load| Skill[Skill]
    Main -->|may retrieve| KB[(Knowledge)]
    Main -->|may delegate| Team["Team / Subagents"]
    Main -->|may run| Workflow["Workflow / Loop"]
    Workflow --> Tool["Tool / MCP call"]
    Tool --> Hook{Hooks}
    Hook -->|allow| Exec[Execute]
    Hook -->|deny| Block[Block]
    Exec --> Main
    Main -.append.-> Mem
    Main -.transcripts.-> Eval[(Eval set)]
    Eval --> Learn[Learning loop]
    Learn -.updates.-> SP
    Learn -.updates.-> Skill
```
