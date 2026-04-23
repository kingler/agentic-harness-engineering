# App Profile: Figma AI

**Category:** AI Design Assistant  
**Website:** figma.com  
**Difficulty to reverse-engineer:** ★★☆☆☆ (Easy — closest to your daily work)

---

## What It Does

Figma AI is a suite of AI features embedded directly into the Figma design tool. Rather than being a standalone agent, Figma AI is a collection of AI-powered capabilities layered into the existing editor: text rewriting, image generation, prototype generation, design system suggestions, and more.

This is a great app to reverse-engineer because you use Figma already — you've experienced the harness as a user, which gives you a head start on understanding the design decisions behind it.

---

## Key Features to Notice

| Feature | What It Reveals |
|---------|----------------|
| **Rename layers** | Batch operation, structured output, context = entire frame |
| **Rewrite copy** | Tone/style constraints, selection-scoped context |
| **Make designs** | Text → Figma frames + components — structured output requirement |
| **Generate images** | Prompt → image asset within the canvas |
| **Prototype generation** | Selection → interactive prototype — multi-step tool use |
| **Component suggestions** | Current selection → recommended component library matches |
| **Fix contrast** | Automated accessibility check + correction — deterministic hook |

---

## Agent Behaviors to Map

### Selection-Scoped Context
- Every Figma AI feature operates on the current selection
- The harness injects the selected elements' structure (names, properties, nesting) into context
- When you "Rewrite copy," the model doesn't see the whole file — just the selected text layer and its parent context
- How does Figma decide *how much* parent context to include?

### Structured Output Requirements
- "Make designs" can't return free-form text — it must return valid Figma node structures
- The harness likely validates the model's output against the Figma data schema before applying it
- A bad output would corrupt your file — this is a high-stakes tool use decision

### Constraint Application
- "Rename layers" follows Figma's naming conventions (frame / group / component naming patterns)
- These conventions are likely injected into the system prompt as rules, not left to the model's judgment
- Designer decision: *what conventions should be enforced vs. let the model decide?*

### Non-Destructive Application
- Figma AI changes can always be undone (Cmd+Z)
- This is a harness infrastructure decision — every AI action is wrapped in an undo-able transaction
- This dramatically lowers the "risk" of using AI features — critical for adoption

### Privacy Boundary
- Figma AI only sees what's in your file — it doesn't access external systems
- Your design tokens, component library, and assets are the only "context"
- This is a deliberate trust decision — AI operates within the "walled garden" of your Figma workspace

---

## The 6 Harness Components

### 1. System Prompt & Instructions
- Each Figma AI feature has its own scoped system prompt
- "Rewrite copy" → system prompt about tone, brand voice, brevity
- "Rename layers" → system prompt about Figma naming conventions
- **Key insight:** Figma doesn't have one AI — it has many mini-AIs, each with a different harness
- Designer decision: *when should you build one general agent vs. many specialized agents?*

### 2. Tools, Skills & MCPs
- `read_selection()` — get properties of selected elements
- `write_nodes(nodes)` — apply changes back to the canvas
- `generate_image(prompt)` — create an image asset
- `match_component(description)` — find the best-fit component in the library
- `apply_style(style)` — apply a style token
- Designer decision: *how many tools is too many? (Figma AI keeps each feature minimal)*

### 3. Infrastructure & Sandbox
- Figma's Plugin API is the sandbox — AI features run as sandboxed plugins
- The plugin API controls what the model can and can't access (no external network calls from within the plugin, by default)
- All AI computation happens server-side; only the input/output crosses the boundary
- Designer decision: *what should AI have access to in your product's existing infrastructure?*

### 4. Orchestration Logic
- Most Figma AI features are single-shot (one model call → one action)
- "Make designs" is multi-step: parse intent → generate layout → apply components → render
- No visible subagents, but there are likely internal passes (e.g., layout pass + style pass)
- Designer decision: *is it better to show one result instantly or multiple steps in sequence?*

### 5. Hooks & Middleware
- **Pre-apply validation:** model output is validated against Figma's data schema before being applied
- **Undo-transaction wrapper:** every AI action is automatically wrapped in a reversible transaction
- **Progress indicator:** multi-step features show a spinner — prevents user interaction during execution
- **Fix contrast hook:** accessibility checks run automatically on color-related changes
- Designer decision: *what validations should run before every AI action in your product?*

### 6. Feedback Loops
- Accept/dismiss pattern — users explicitly accept or dismiss AI suggestions
- This is **explicit feedback** — much cleaner signal than implicit behavioral data
- Figma likely uses accept/dismiss rates to improve feature quality over time
- Component suggestion accuracy improves as the model learns your team's library
- Designer decision: *accept/dismiss vs. thumbs up/down vs. passive behavioral signal — which fits your context?*

---

## Design Observations

**What Figma AI does exceptionally well:**
- **Contextual scoping** — AI only acts on what you selected; it doesn't touch anything else
- **Always undoable** — zero fear of AI messing up your work
- **Separate tools for separate intents** — "rename" and "rewrite" are distinct features, not one "do stuff to my design" button
- **Matches existing mental models** — AI features live in the right-click menu, where designers already look for actions

**What Figma AI could do better:**
- **No cross-session learning** — Figma AI doesn't remember that you always prefer sentence case for layer names
- **No proactive suggestions** — AI only acts when invoked, never suggests improvements unprompted
- **Limited orchestration** — features don't chain together; you have to invoke each one manually

**The key design tradeoff:**
Figma AI chose **safety over autonomy**. Every feature is selection-scoped, undoable, and requires explicit invocation. This sacrifices the "wow, it just figured it out" feeling but builds deep trust. The right call for a creative tool where every pixel is intentional.

---

## Suggested Tools/APIs to Replicate This

If you were building a Figma AI-like harness for a different creative tool:

- **Model:** Claude Haiku 4.5 for fast, single-shot operations (rename, rewrite)
- **Model:** Claude Sonnet 4.6 for complex operations (generate designs, prototype)
- **Tool:** `read_current_state()` — read selected/current object properties
- **Tool:** `apply_changes(changes)` — write back structured changes with validation
- **Infrastructure:** Wrap every tool call in a reversible transaction
- **System prompt:** One per feature, not one global system prompt
- **RooCode equivalent:** RooCode with `read_file`/`edit_file` tools, scoped to the current file

---

## Discussion Questions for Your Group

1. Figma AI has many small AI features instead of one big AI. When is this the right architecture? When is it wrong?
2. The "always undoable" pattern dramatically changes the risk profile. What's the equivalent for your product?
3. Figma AI never makes suggestions unprompted. When should an agent be proactive vs. reactive?
4. The accept/dismiss pattern gives explicit feedback. How would you design feedback collection for your harness?
