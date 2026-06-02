# The Anatomy of an Agent Harness

> "If you're not the model, you're the harness."  
> — Vivek Trivedy, LangChain

---

## The Core Formula

```
AGENT = MODEL + HARNESS
```

The **model** (Claude, GPT-4o, Gemini, etc.) takes in text and images, outputs text. That's all it does. The **harness** is everything else — the code, configuration, tools, constraints, memory, and feedback loops that make the model useful for a specific purpose.

As designers, we don't train models. But we absolutely design harnesses.

---

## Three Levels of Engineering

```
┌──────────────────────────────────────┐
│        HARNESS ENGINEERING           │  ← Full system: tools, infra, orchestration
│  ┌────────────────────────────────┐  │
│  │     CONTEXT ENGINEERING        │  │  ← What the model sees and when
│  │  ┌──────────────────────────┐  │  │
│  │  │   PROMPT ENGINEERING     │  │  │  ← The instructions on each turn
│  │  │    [   the model   ]     │  │  │
│  │  └──────────────────────────┘  │  │
│  └────────────────────────────────┘  │
└──────────────────────────────────────┘
```

Designers influence all three levels. Harness engineering is where product-level decisions live and where you have the most leverage.

---

## The 6 Core Harness Components

### 1. System Prompt & Instructions

**What it is:** The persona, rules, and constraints you give the model before the conversation starts.

**What it includes:**
- Agent identity and tone of voice
- What it should always do and never do
- Knowledge it needs to do its job (design system facts, team conventions)
- Instructions for failure modes

**In practice:**
- RooCode reads `AGENTS.md` in your workspace root
- GitHub Copilot reads your instructions file (configurable in settings)
- ChatGPT / Claude.ai project settings — chat UIs let you set the system prompt per project
- The `AGENTS.md` pattern — project-level rules that persist

**Designer leverage: HIGH**

Key insight: The system prompt is the "UX copy" for your agent's behavior. Vague instructions produce vague behavior. Specific, concrete rules produce reliable agents.

What you can design:
- The agent's personality and communication style
- Which capabilities are surfaced prominently vs. hidden
- How the agent handles uncertainty and failure
- Progressive disclosure of advanced features

---

### 2. Tools, Skills & MCPs

**What it is:** The actions the agent can take in the world. Without tools, the model can only output text.

**What it includes:**
- File operations (read, write, create, delete)
- API calls (GitHub API, Teams API, internal HTTP services, browser automation, etc.)
- Code execution
- Web search and browsing
- Data retrieval and search
- MCP servers (Model Context Protocol — a standard for tool connectivity)

**In practice:**
- Each tool is defined by: name, description, parameters, return value, and errors
- The model reads tool descriptions to decide which tool to use and how
- Too many tools = confused agent (research suggests quality degrades sharply above ~10 tools)
- RooCode has built-in tools + supports custom MCP servers

**Designer leverage: VERY HIGH**

Key insight: Tool descriptions are the most underappreciated high-leverage activity for designers. They are the interface between the model and its capabilities — poorly written descriptions cause wrong tool choices.

What you can design:
- Which actions the agent can take (and which it can't)
- The wording of tool descriptions (UX copy for AI)
- Whether tools require user confirmation before running
- Permission boundaries and trust levels

---

### 3. Infrastructure & Sandbox

**What it is:** The workspace the agent operates in — the environment it can see and interact with.

**What it includes:**
- Filesystem access (local files, cloud storage)
- Browser / web access
- Code execution environments
- Database connections
- The sandbox boundary (what can the agent access?)

**In practice:**
- Local agents (Cursor, Cline, RooCode, Copilot CLI): filesystem access scoped to the workspace
- Browser-based agents (Bolt.new): WebContainer or cloud sandbox
- Plugin-based agents (editor extensions, third-party plugins): host-controlled sandbox with restricted permissions
- The sandbox is the primary safety mechanism for autonomous agents

**Designer leverage: MEDIUM**

Key insight: The sandbox boundary is a product-defining decision. It determines what's possible and what risks users accept. Tighter sandbox = safer but less capable. Open sandbox = more capable but requires more trust.

What you can design:
- What data the agent can access (and what it can't)
- The isolation level (none, workspace, browser, full cloud)
- How sensitive operations are handled (logs, audits, approvals)
- What data stays local vs. what is sent to the cloud

---

### 4. Orchestration Logic

**What it is:** How the agent coordinates and sequences complex, multi-step tasks.

**What it includes:**
- Single-agent vs. multi-agent (subagents for parallel or specialized work)
- Handoff protocols between agents
- Model routing (cheap/fast model for simple tasks, expensive/slow model for complex ones)
- Context management (how to handle tasks that exceed the context window)
- Planning passes (does the agent plan before executing?)

**In practice:**
- Single-agent: one model, one context window. Works for most tasks.
- Multi-agent: "orchestrator" agent spawns specialist "worker" agents for parallel work
- Anthropic's recommendation: subagents keep context separated, preventing degradation in long tasks
- Copilot's coding agent uses task hand-off conventions between orchestrator and subagents

**Designer leverage: HIGH**

Key insight: Orchestration is where you design the "intelligence" of the overall system. A single model call is a feature. A multi-step plan with self-correction and specialist agents is a product.

What you can design:
- When to decompose a task into subtasks
- Which agents handle which types of work
- How agents communicate with each other (and with the user during long tasks)
- Fallback behavior when a subagent fails

---

### 5. Hooks & Middleware

**What it is:** Deterministic logic that runs around the agent — before and after tool calls, at context limits, on errors.

**What it includes:**
- Pre-tool hooks (run before a tool executes: validation, permission check, logging)
- Post-tool hooks (run after a tool executes: formatting, notification, undo-wrapping)
- Context compaction hooks (run when approaching context window limits)
- Error hooks (run when something goes wrong)
- Rate limiting and abuse prevention

**In practice:**
- Hooks are code, not prompts — they run deterministically, every time
- If you want something to happen always, enforce it with a hook, not with the system prompt
- The model can forget rules. Hooks cannot.
- Copilot's cloud agent supports hooks for auto-lint, auto-test, context compaction

**Designer leverage: HIGH**

Key insight: "When something should happen every time, don't rely on the model to remember — enforce it with code." Hooks are the boundary between what you trust the AI to decide and what must always happen regardless.

What you can design:
- Which behaviors are enforced by code (hooks) vs. requested via prompt (rules)
- What gets logged for observability
- What actions require user confirmation before proceeding
- How the agent recovers from errors

---

### 6. Feedback Loops

**What it is:** The mechanisms by which the harness improves over time, and how users and developers learn from agent behavior.

**What it includes:**
- User feedback signals (explicit: thumbs/ratings; implicit: behavioral signals like copy, iterate, abandon)
- Traces and logs (every tool call, input, output — for debugging)
- Evaluations ("evals") — automated tests that measure harness quality
- Self-verification (agent checking its own work)
- Hill-climbing — iterative harness improvement based on eval signal

**In practice:**
- LangChain's "hill-climbing" model: run evals → identify failures → improve the harness → repeat
- Anthropic calls evals "the training data for harness engineering"
- Most agent failures are reproducible — a good trace lets you find and fix the root cause
- Simple feedback: accept/reject diffs (Cursor), accept/reject inline suggestions (GitHub Copilot), share (Claude Artifacts)

**Designer leverage: MEDIUM**

Key insight: You can't improve what you can't measure. The design of your feedback loop determines the rate at which your harness can get better. Most products under-invest here.

What you can design:
- How users provide feedback (explicit, implicit, or both)
- What data you capture from every agent interaction
- How you review and act on feedback
- The eval suite that defines "harness quality"

---

## The OS Analogy

| Hardware | Agent Equivalent | Description |
|----------|-----------------|-------------|
| CPU | LLM Model | Raw intelligence — brilliant but useless alone |
| RAM | Context Window | Fast but limited working memory |
| Disk | External DBs & Files | Large but slower persistent knowledge |
| Drivers | Tool Integrations | Interfaces to the outside world |
| OS | **The Harness** | Orchestrates everything — this is what we design |

---

## Where Designers Have the Most Leverage

Most agent failures aren't intelligence failures — they're input failures.

1. **Tool descriptions** — the UX copy for AI agents. Bad descriptions = wrong tool choices.
2. **Permission & trust UX** — when to ask, when to act, what to explain to users.
3. **State & progress visibility** — users need to understand what agents are doing and why.
4. **Error recovery flows** — what happens when the agent fails? Most products do this badly.
5. **Agent coordination rules** — which agents work together, handoff protocols, escalation paths.
6. **Input data architecture** — Agent Time: what the agent knows about Past, Present, Future.
