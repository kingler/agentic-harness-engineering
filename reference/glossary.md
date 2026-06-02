# Glossary of Key Terms

A reference for the vocabulary used throughout this workshop. Terms are ordered from most fundamental to most specific.

---

## Core Concepts

### Agent
An AI system that perceives its environment, makes decisions, and takes actions to achieve a goal. Agents are goal-directed and can use tools, correct their own mistakes, and adapt to feedback. An agent = a model + a harness.

### Model
A large language model (LLM) — Claude, GPT-4o, Gemini, etc. — that takes text (and often images) as input and produces text as output. The model provides the intelligence; it doesn't provide memory, tools, infrastructure, or persistence. Those are all harness components.

### Harness
Everything wrapped around the model to make it useful for a specific purpose: the system prompt, tools, infrastructure, orchestration logic, hooks, and feedback mechanisms. If you're not the model, you're the harness.

*Formula: Agent = Model + Harness*

### Context Window
The amount of text the model can "see" and reason over at one time. Think of it as the model's working memory — fast and powerful, but limited. Modern models have context windows of 200,000+ tokens (roughly 150,000 words). When the context window fills up, older information is pushed out.

### Token
The basic unit of text a language model processes. Roughly 3/4 of a word, or 4 characters. "Hello world" = 2 tokens. Used to measure context window size, model costs, and generation limits.

---

## Harness Components

### System Prompt
The instructions given to the model before the conversation begins. Defines the agent's identity, rules, tone, and constraints. In GitHub Copilot, via `AGENTS.md` and `.github/copilot-instructions.md`. In Cline / RooCode, via `AGENTS.md` and `.roo/rules/`.

### AGENTS.md
A markdown file that lives in your project root and serves as the persistent system prompt for AI agents in your workspace. GitHub Copilot's coding agent, Cline, and RooCode all read it automatically. Format: human-readable instructions that travel with your project.

### Tool (in agentic context)
A specific action an agent can take that has side effects in the world: reading a file, writing to a database, calling an API, running code, sending a message. Tools are defined by: a name, a description (the most important part), parameters, return values, and error cases.

### Tool Description
The text that explains to the model what a tool does, when to use it, and when not to use it. Treated as "UX copy for AI agents" — the quality of tool descriptions directly affects how reliably the agent chooses and uses its tools correctly. Bad descriptions → wrong tool choices.

### MCP (Model Context Protocol)
An open standard (developed by Anthropic) for connecting AI models to external tools, data sources, and systems. MCP servers expose tools that models can use. RooCode supports MCP, allowing you to connect your harness to GitHub, Teams, browsers, databases, and internal APIs.

### Hook
A piece of deterministic code that runs automatically at a specific point in the agent's lifecycle — before a tool call, after a tool call, when the context window fills, or when an error occurs. Hooks enforce non-negotiable behaviors that the model cannot override or forget. Key principle: hooks > hoping.

### Middleware
A layer of code that sits between user input and model processing, or between model output and tool execution. Like web middleware (Express.js, Django middleware), agent middleware can transform, validate, log, or block requests and responses.

### Sandbox
An isolated execution environment that limits what an agent can access or affect. Examples: a browser iframe (no filesystem access), a Docker container (limited network/filesystem), a VS Code workspace (scoped filesystem). The sandbox boundary is a key design decision — it determines capability vs. safety.

---

## Context & Memory

### Context Engineering
The practice of deciding what information goes into the model's context window and when. Distinct from prompt engineering (which focuses on *how* to phrase instructions) and harness engineering (which focuses on the full system). Good context engineering means the model always has the right information at the right time.

### Prompt Engineering
Writing effective instructions for language models — crafting the exact text that elicits the desired behavior. The innermost layer of the three engineering levels. Important, but limited — a great prompt can't overcome missing context or a broken harness.

### Memory (agent memory)
A mechanism for agents to store and retrieve information across tool calls, conversation turns, or separate sessions. Types: in-context memory (just in the current conversation), external memory (a file or database the agent reads/writes), and embedded memory (information encoded into the agent itself via training).

### RAG (Retrieval-Augmented Generation)
A technique where relevant information is retrieved from a database or file system and injected into the context window before the model responds. Used to give agents access to large knowledge bases that don't fit in the context window. Example: looking up your design token dictionary before answering a naming question.

### Agent Time
A framework for thinking about what information an agent has access to across three time dimensions:
- **Past:** What the system has already captured (preferences, decisions, history)
- **Present:** What is happening right now (current state, constraints, signals)
- **Future:** How the agent adapts based on what it learns (predictions, proactive suggestions)

---

## Orchestration

### Orchestration
The coordination of multiple AI steps, tools, or agents to complete a complex task. Orchestration logic decides: what order to run steps in, when to spawn subagents, how to handle failures, and how to route different types of work to different models.

### Subagent
A specialized AI agent spawned by an "orchestrator" agent to handle a specific subtask in parallel or in sequence. Subagents keep context windows separated — critical for long tasks where a single context would become unwieldy. Example: an orchestrator that spawns a "planner" subagent and an "executor" subagent.

### Multi-agent System
A harness that uses more than one AI agent, each with a specific role. Can be: sequential (agent A does step 1, agent B does step 2), parallel (both run simultaneously), or hierarchical (orchestrator spawns workers as needed).

### Handoff
The transfer of context and control from one agent to another. Well-designed handoffs include: what was accomplished, what was decided, and what the receiving agent needs to continue. Poor handoffs are one of the main failure modes in multi-agent systems.

### Model Routing
Automatically selecting which model to use based on task complexity or requirements. Example: use Claude Haiku (fast, cheap) for simple autocomplete; use Claude Sonnet (balanced) for standard tasks; use Claude Opus (most powerful) for complex reasoning. Routing is a harness decision, not a model capability.

---

## Feedback & Improvement

### Eval (Evaluation)
An automated test that measures the quality of a harness's outputs. Like a unit test for AI behavior. A good eval suite: covers the most important use cases, is reproducible, has a clear pass/fail signal, and can catch regressions when the harness changes.

### Trace
A complete log of a single agent interaction: every tool call made, every input/output, and every decision point. Traces are essential for debugging — they let you reproduce failures and understand why the agent did what it did.

### Hill-climbing (harness improvement)
An iterative approach to improving a harness: run evals → find failures → make the smallest change that fixes the failure → run evals again. Named for the mathematical optimization technique. The standard approach to long-term harness quality improvement, per LangChain's research.

### Feedback Loop (agentic)
A mechanism for capturing signals about agent quality and feeding them back into harness improvement. Explicit feedback: user ratings, accept/reject decisions. Implicit feedback: behavioral signals like copy-to-clipboard, immediate follow-up edits, session abandonment.

---

## Tools & Platforms

### RooCode
A VS Code extension that enables full agentic tool use inside the code editor. Reads `AGENTS.md` for persistent instructions. Has built-in tools (read file, write file, run terminal command) and supports MCP for connecting to external services. Used in this workshop for harness testing.

### GitHub Copilot
Microsoft/GitHub's AI code assistant. Available as a VS Code extension. Reads `AGENTS.md` and `.github/copilot-instructions.md` for persistent context. Supports custom prompts (`.github/prompts/`), custom agents (`.github/agents/`), and hooks (`.github/hooks/`) for the cloud agent. Used in this workshop alongside Cline / RooCode.

### Cline
A VS Code extension for autonomous AI coding agents. Reads `AGENTS.md` and `.clinerules` for persistent instructions. Supports MCP servers for external tools. Sibling to RooCode in scope and shape.

---

## Model-Provider Concepts

> The Copilot, Cline, and RooCode extensions can each be configured to call
> Claude, GPT, or Gemini behind the scenes. The terms below describe
> model-side features participants may encounter when picking a provider.

### Prompt Caching
A model-provider feature that caches frequently-used portions of the system prompt (like a long AGENTS.md) to reduce latency and cost. When the same prompt prefix is used repeatedly, the provider serves it from cache rather than re-processing it. Particularly valuable for harnesses with large, stable system prompts.

### Extended Thinking
A model feature that lets the model reason through complex problems in a "scratchpad" before producing its final response. Useful for harness tasks that require multi-step planning or complex judgment calls. Enabled via the API — not visible to end users by default.
