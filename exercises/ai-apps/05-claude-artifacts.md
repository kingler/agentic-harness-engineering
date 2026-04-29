# App Profile: Claude Artifacts

**Category:** Interactive Content Generation  
**Website:** claude.ai  
**Difficulty to reverse-engineer:** ★★☆☆☆ (Easy — you interact with this directly)

---

## What It Does

Claude Artifacts is a feature within Claude.ai that generates self-contained, interactive content alongside the main conversation — React components, SVG diagrams, HTML tools, data visualizations, games, and more. When Artifacts detects that your request would benefit from a rendered output (not just text), it creates a separate "artifact" panel that renders the content live.

Artifacts is remarkable because it turns a chat interface into a design-and-build environment — without any setup, infrastructure, or code editor required.

---

## Key Features to Notice

| Feature | What It Reveals |
|---------|----------------|
| **Auto-detection** | Claude decides when to create an artifact vs. answer in plain text |
| **Live rendering** | Code runs immediately in a sandboxed iframe |
| **Iteration in conversation** | "Make the chart blue" updates the artifact in context |
| **Multiple artifact types** | React, HTML, SVG, Markdown, text — typed output system |
| **Copy to clipboard** | One-click export — no file system required |
| **Version history** | Previous versions of the artifact are accessible |
| **Sharing** | Artifacts can be published as public links |

---

## Agent Behaviors to Map

### Intent Detection: Artifact vs. Text
- When does Claude create an artifact instead of just writing code in the chat?
- The decision seems to be: *would the user benefit from seeing this rendered, not just reading the code?*
- This is a **harness heuristic** — a rule in the system prompt, not the model's innate judgment
- Look for the pattern: long code blocks → artifact; short code snippets → inline text

### Artifact Type Selection
- Claude doesn't always create a React component — it picks the right type:
  - Diagram → SVG
  - UI component → React
  - Data table → HTML
  - Document → Markdown
- How does Claude decide? The system prompt likely has type-selection rules

### In-Context Iteration
- When you ask to change an artifact, Claude updates it — not creates a new one
- This requires the harness to maintain a reference to the current artifact in context
- "Make the header larger" → Claude edits only the header, not the whole component

### Sandboxed Execution
- Artifacts run in an iframe with restricted permissions
- No access to parent page, no network requests, no localStorage
- The sandbox is the reason Artifacts can run untrusted generated code safely

### Progressive Disclosure
- Simple questions get text answers
- Complex visual requests get artifacts
- Very complex requests get artifacts + explanation
- The harness layers response complexity to match the request complexity

---

## The 6 Harness Components

### 1. System Prompt & Instructions
- The system prompt defines when to create an artifact (the detection heuristic)
- It defines the artifact types and when to use each
- It defines iteration behavior: "when the user asks to modify an artifact, update the existing one"
- It likely includes quality rules: "React components should be self-contained with no external imports"
- Designer decision: *how do you write rules for agent judgment calls, not just facts?*

### 2. Tools, Skills & MCPs
- `create_artifact(type, content)` — spawn a new artifact panel
- `update_artifact(id, content)` — update an existing artifact
- `get_artifact(id)` — retrieve current artifact content for context
- The artifact creation is a tool call, not just text output — it has side effects in the UI
- Designer decision: *when should AI actions have visible UI side effects?*

### 3. Infrastructure & Sandbox
- Artifacts run in a heavily sandboxed iframe — arguably the most restricted sandbox in this set of 5 apps
- No external network, no cookies, no file system, no access to Claude's own APIs
- This makes Artifacts safe for arbitrary generated code, but also limits what artifacts can do
- **CDN imports allowed:** artifacts can load external libraries (React, D3, Chart.js) via CDN, which is the one "escape hatch"
- Designer decision: *where's the right sandbox boundary for user-generated/AI-generated content?*

### 4. Orchestration Logic
- Single-agent, single-context: no subagents visible to the user
- But internally: likely a planning pass (what type of artifact? what should it contain?) before the generation pass
- Version history requires orchestration: previous artifact states are stored and retrievable
- Designer decision: *should versioning be automatic, or should users explicitly save versions?*

### 5. Hooks & Middleware
- **Post-generation validation:** if generated code has syntax errors, Claude is likely re-prompted to fix them before the artifact is rendered
- **Type enforcement:** artifact content is validated against the declared type (React can't be submitted as SVG)
- **Auto-update on conversation:** when the conversation references an artifact, the harness automatically brings it into context
- Designer decision: *what should happen if the generated artifact doesn't render? Retry silently or surface the error?*

### 6. Feedback Loops
- No explicit feedback UI (no thumbs up/down)
- Implicit signals: copy-to-clipboard, share, iterate vs. abandon
- Conversation continuation is a strong signal: "make the chart blue" after a good generation
- Public sharing is the strongest signal: if you share it, it was good enough
- Designer decision: *for a content generation tool, is engagement data sufficient, or do you need explicit quality ratings?*

---

## Design Observations

**What Claude Artifacts does exceptionally well:**
- **Zero to interactive in seconds** — no setup, no deployment, no environment to configure
- **Conversation-native iteration** — refinement feels like talking, not coding
- **Appropriate sandboxing** — aggressive enough to be safe, permissive enough (CDN) to be useful
- **Progressive complexity** — text for simple things, artifacts for complex things, automatically

**What Claude Artifacts could do better:**
- **No persistent memory** — starting a new conversation loses all artifact context
- **Limited artifact-to-artifact relationships** — you can't reference one artifact in another
- **No export to production** — great for prototyping, but no path to "real" deployment
- **CDN dependency is fragile** — artifacts break when CDN URLs change

**The key design tradeoff:**
Artifacts chose **broad capability over depth**. They can generate almost anything, but the sandbox prevents them from being production-ready. This is correct for a conversational design tool — the goal is exploration and communication, not deployment. A different harness choice (real network access) would make artifacts more powerful but much more dangerous.

---

## Suggested Tools/APIs to Replicate This

If you were building an Artifacts-like harness for a specialized domain (e.g., data visualization):

- **Model:** Claude Sonnet 4.6 with artifact-creation tool
- **Detection heuristic:** In system prompt — "When the user asks for a visualization, chart, or interactive element, always use create_artifact"
- **Tool:** `create_artifact(type, title, content)` → renders in sidebar panel
- **Tool:** `update_artifact(id, content)` → replaces the artifact content in-place
- **Sandbox:** iframe with `sandbox="allow-scripts"` (no network, no storage)
- **CDN allowlist:** pre-approve specific visualization libraries
- **RooCode equivalent:** RooCode with a custom panel renderer plugin

---

## Discussion Questions for Your Group

1. Claude decides when to create an artifact based on a heuristic in its system prompt. How would you write that rule for your product?
2. The sandbox prevents artifacts from doing network requests. Is that the right tradeoff for your users?
3. Artifacts don't persist across conversations. What would you store, and for how long?
4. The only feedback signal is behavioral (copy, share, iterate). Is that enough? What would you add?
