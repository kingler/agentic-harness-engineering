# App Profile: Bolt.new

**Category:** Full-Stack AI App Builder  
**Website:** bolt.new  
**Difficulty to reverse-engineer:** ★★★★☆ (Hard)

---

## What It Does

Bolt.new (by StackBlitz) is a browser-based AI tool that generates, runs, and deploys full-stack web applications from a single prompt. Unlike v0 (which generates components) or Cursor (which helps you edit existing code), Bolt builds an entire working application — with a backend, database, and frontend — entirely in-browser, with no local setup required.

It's one of the most ambitious harnesses in the market: a full development environment, file system, terminal, and AI agent all woven together inside a web app.

---

## Key Features to Notice

| Feature | What It Reveals |
|---------|----------------|
| **Prompt → running app** | Agent autonomously scaffolds, writes, and runs an entire app |
| **In-browser terminal** | Real command execution (npm install, etc.) in a WebContainer |
| **File explorer** | Full filesystem visible and editable — harness is transparent |
| **Live preview** | Running app rendered in an iframe alongside the code |
| **Iterative refinement** | Add features, fix bugs, change styles via follow-up prompts |
| **One-click deploy** | Harness extends from code to infrastructure (Netlify integration) |
| **Error auto-fix** | Terminal errors are fed back to the agent for automatic correction |

---

## Agent Behaviors to Map

### Autonomous Scaffolding
- Bolt doesn't just generate one file — it creates an entire project structure
- It installs dependencies, writes configuration files, and starts a dev server
- All of this happens without user intervention
- How does the agent decide *what* to scaffold? (Reading the prompt for clues? A fixed project template?)

### Tool Chaining
- Bolt executes a sequence: generate code → write files → install packages → start server → preview
- Each step depends on the previous one's output
- This is **orchestration** — the harness manages the sequence, not the model

### Error-to-Context Loop
- When `npm install` fails, the error output is automatically fed back to the model
- The model tries a corrective action (e.g., swapping a package version)
- This continues in a loop until the error resolves or the agent gives up
- Designer decision: *how many retry attempts before surfacing the error to the user?*

### Context Management
- A full Next.js app has dozens of files — more than fit in any context window
- Bolt must decide which files are "in context" at any moment
- When editing an existing app, how does the agent know which files are relevant to a change?

### Trust & Permission
- Bolt runs real terminal commands in a WebContainer (sandboxed in the browser)
- The sandbox is Bolt's key safety mechanism — commands can't escape to your real machine
- But within the sandbox, the agent has broad permissions — it can delete files, overwrite configs, etc.

---

## The 6 Harness Components

### 1. System Prompt & Instructions
- The system prompt defines what kind of apps Bolt builds (web apps, not desktop apps)
- It includes preferred tech stack defaults (React + Vite or Next.js) and quality rules
- Likely includes rules like: "always install dependencies before running," "always start with a working baseline"
- Designer decision: *what tech preferences should be in the system prompt vs. configurable by users?*

### 2. Tools, Skills & MCPs
- `write_file(path, content)` — create/overwrite files in the virtual filesystem
- `run_command(cmd)` — execute terminal commands in WebContainer
- `read_file(path)` — read existing files for context
- `list_files(path)` — inspect directory structure
- `open_preview()` — launch the live preview
- Designer decision: *should users see every tool call, or only the result?*

### 3. Infrastructure & Sandbox
- **WebContainer** is the core infrastructure innovation — a real Node.js environment in the browser
- Files persist in browser storage (IndexedDB) — not a real filesystem
- The sandbox boundary is the browser tab — total isolation from the user's machine
- This is a **product-defining harness decision** — without WebContainer, Bolt couldn't exist
- Designer decision: *what's the right isolation boundary for your users' trust level?*

### 4. Orchestration Logic
- Bolt uses a sequential orchestration pattern for initial generation:
  1. Plan the app structure (internal, not shown)
  2. Write all files
  3. Install dependencies
  4. Start the dev server
  5. Verify the app runs
- For follow-up edits, it uses a targeted edit pattern (fewer files touched)
- Designer decision: *when should the agent plan first vs. just start doing?*

### 5. Hooks & Middleware
- **Post-file-write hook:** trigger npm install if package.json changed
- **Post-command hook:** capture terminal output and feed to context
- **Error detection hook:** if terminal shows an error, automatically attempt correction
- **Preview auto-refresh:** restart preview after successful command execution
- Designer decision: *which hooks are always-on vs. user-configurable?*

### 6. Feedback Loops
- Terminal output is the primary feedback signal — errors and success messages
- Live preview gives visual confirmation the app works
- Users can manually edit files, which signals what the agent missed
- Bolt likely uses "did the user manually fix something?" as a harness improvement signal
- Designer decision: *what's the minimum feedback signal needed to improve your harness?*

---

## Design Observations

**What Bolt does exceptionally well:**
- **Zero setup** — no local environment, no npm global install, just open the browser
- **Transparent filesystem** — users can see every file the agent creates, building trust
- **Error recovery is automatic and visible** — the terminal is always in view

**What Bolt could do better:**
- **Context window exhaustion** — complex apps hit context limits and quality degrades mid-session
- **No project memory** — starting a new session loses all context about your app's conventions
- **Ambiguous intent handling** — Bolt starts building immediately, even on vague prompts

**The key design tradeoff:**
Bolt chose **immediacy over accuracy** at even greater scale than v0. It starts building a full app from a single sentence. This creates the "wow" moment but often requires substantial refinement. A more deliberate harness would ask: "Before I build, let me confirm: you want a Next.js app with auth and a PostgreSQL database, is that right?" — but that breaks the magic.

---

## Suggested Tools/APIs to Replicate This

If you were building a Bolt-like harness for a constrained domain (e.g., marketing pages only):

- **Model:** Claude Sonnet 4.6 with extended thinking for planning phase
- **Infrastructure:** WebContainer (StackBlitz SDK) or a cloud-based sandbox (E2B, Modal)
- **Tools:** `write_file`, `run_command`, `read_file`, `list_directory`
- **Orchestration:** Plan → scaffold → install → verify loop with error feedback
- **System prompt:** Constrain to your preferred stack + quality rules
- **RooCode equivalent:** RooCode's "Architect" mode for planning + "Code" mode for execution, both with your AGENTS.md

---

## Discussion Questions for Your Group

1. Bolt builds a whole app without asking clarifying questions. What would you ask upfront, and at what cost to the experience?
2. The WebContainer sandbox is the key to Bolt's safety model. What's the equivalent isolation mechanism for your product?
3. Bolt surfaces the terminal output to users. Is that the right call for a non-developer audience? What would you show instead?
4. When the error-correction loop runs 5+ times and fails, what should the harness do?
