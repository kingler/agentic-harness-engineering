# App Profile: Cursor

**Category:** AI Code Editor  
**Website:** cursor.com  
**Difficulty to reverse-engineer:** ★★★☆☆ (Medium)

---

## What It Does

Cursor is a VS Code fork that layers AI deeply into the coding experience. Unlike Copilot (which bolt-on autocompletes), Cursor rebuilds the editor around AI — with multi-file edits, natural-language terminal commands, a conversational sidebar, and an agent mode that can autonomously make changes across your entire codebase.

It's one of the clearest examples of a harness built on top of a general model (Claude + GPT-4o) to create a specific, highly constrained product experience.

---

## Key Features to Notice

| Feature | What It Reveals |
|---------|----------------|
| **Tab completion** | Single-file, low-context, fast model routing |
| **Cmd+K inline edit** | Selection-scoped context injection |
| **Chat sidebar** | Multi-turn conversation with full file context |
| **Agent mode** | Autonomous tool use: file edits, terminal commands, web search |
| **@ mentions** (`@file`, `@docs`, `@web`) | Explicit context control — user decides what the model sees |
| **Cursor rules** (`.cursorrules`) | Persistent system prompt injection — their version of AGENTS.md |
| **Privacy mode toggle** | Trust & permission UX — user consent for data leaving the machine |

---

## Agent Behaviors to Map

When analyzing Cursor, look for these specific behaviors:

### Intent Recognition
- How does Cursor decide between autocomplete, inline edit, and full agent mode?
- What signals trigger each mode? (selection size, cursor position, explicit command?)

### Context Assembly
- What does Cursor put in the context window for each mode?
- Tab completion: just the current file + cursor position
- Agent mode: file tree, open files, terminal output, git diff?

### Tool Execution
- Agent mode can: edit files, run terminal commands, search the web, read docs
- How does Cursor signal to the user that a tool is about to run?
- Does it ask permission or just act?

### Error Recovery
- What happens when an agent edit breaks the build?
- Does Cursor try to fix it, or hand back to the user?

### Memory
- `.cursorrules` persists across sessions — but what else?
- Does Cursor remember your preferences within a session? Across sessions?

---

## The 6 Harness Components

### 1. System Prompt & Instructions
- **`.cursorrules` file** in your project root — acts as a persistent system prompt
- Cursor also injects context about the current file, language, and project structure
- Designer decision: *what rules should be global vs. project-specific?*

### 2. Tools, Skills & MCPs
- File read/write (scoped to workspace)
- Terminal command execution (sandboxed)
- Web search (via `@web`)
- Docs indexing (via `@docs`)
- Designer decision: *which tools require explicit user confirmation?*

### 3. Infrastructure & Sandbox
- Runs inside VS Code — filesystem access scoped to workspace
- Terminal access is real (not sandboxed) — this is a significant trust decision
- Privacy mode limits what leaves the machine
- Designer decision: *how do you balance capability with safety in a local dev tool?*

### 4. Orchestration Logic
- Tab mode → fast, cheap model
- Agent mode → slow, smart model
- **Model routing is automatic** — the user doesn't choose
- Designer decision: *when should the system decide vs. let the user decide?*

### 5. Hooks & Middleware
- Lint/format runs automatically after agent edits in some configurations
- No explicit pre/post-tool hooks visible to users, but they exist under the hood
- Designer decision: *what should happen deterministically after every agent action?*

### 6. Feedback Loops
- Users accept/reject diffs inline — implicit signal
- No explicit rating or feedback UI
- Cursor's model improves from accepted/rejected patterns (opt-in)
- Designer decision: *how do you capture feedback without interrupting the flow?*

---

## Design Observations

**What Cursor does exceptionally well:**
- **Progressive capability disclosure** — basic users never see agent mode; power users unlock it
- **In-context diff review** — agent changes are always reviewable before accepting
- **@ mentions as explicit context control** — puts the user in charge of what the AI sees

**What Cursor could do better:**
- **No clear state visibility** in agent mode — hard to know what the agent has decided to do before it does it
- **Error recovery UX** is weak — when agent edits fail, the feedback is often cryptic
- **Memory is fragile** — `.cursorrules` works, but cross-session learning is limited

**The key design tradeoff:**
Cursor chose **capability over safety** in local development (real terminal access, no sandboxing). This is a deliberate harness decision — the audience (developers) can tolerate the risk, and sandboxing would cripple usefulness.

---

## Suggested Tools/APIs to Replicate This

If you were building a Cursor-like harness for your own use case:

- **Model:** Claude Sonnet 4.6 (agent mode) + Claude Haiku 4.5 (autocomplete)
- **Context injection:** Read active file + workspace index on each turn
- **Tool definitions:** `read_file`, `write_file`, `run_command`, `search_web`
- **Persistent instructions:** `.cursorrules` pattern → your `AGENTS.md`
- **Diff review:** Always show proposed changes before applying
- **RooCode equivalent:** RooCode's "Architect" mode for planning, "Code" mode for execution

---

## Discussion Questions for Your Group

1. What was the single most important harness decision Cursor made? Why?
2. If you removed the `.cursorrules` feature, what would break?
3. Cursor lets the agent run terminal commands without asking. Would you keep this for your users? Why or why not?
4. How would you redesign the feedback loop to capture more useful signal?
