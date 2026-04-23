# App Profile: v0 by Vercel

**Category:** AI UI Generator  
**Website:** v0.dev  
**Difficulty to reverse-engineer:** ★★☆☆☆ (Easy–Medium)

---

## What It Does

v0 is Vercel's AI tool for generating React/Next.js UI components from natural language descriptions or screenshots. You describe what you want ("a pricing table with 3 tiers, dark mode, shadcn/ui style") and v0 generates fully functional, copy-pasteable component code — live-rendered in the browser.

It's a masterclass in a **narrowly scoped harness** — a general model constrained to produce one specific type of output, reliably, every time.

---

## Key Features to Notice

| Feature | What It Reveals |
|---------|----------------|
| **Prompt → component** | Highly constrained output format (React + Tailwind + shadcn/ui only) |
| **Live preview** | Feedback loop built into the product — you see the result immediately |
| **Iterative refinement** | "Make the button larger" — multi-turn with preserved context |
| **Fork & branch** | Version control for generations — non-destructive iteration |
| **Code tab** | Full transparency — the model shows its work |
| **Deploy to Vercel** | Harness extends beyond UI into deployment pipeline |
| **Image-to-UI** | Screenshot input → matching component — multimodal tool use |

---

## Agent Behaviors to Map

### Output Constraint
- v0 never outputs Python, SQL, or plain HTML
- Every generation is React + TypeScript + Tailwind + shadcn/ui
- This is a **harness constraint**, not a model capability — the model *could* output anything
- How is this enforced? (System prompt rules? Output parsing? Both?)

### Iterative Refinement
- Follow-up messages refine the existing component
- The harness must maintain state: what was generated, what the user asked to change
- Does v0 re-generate from scratch or apply a diff?

### Multi-modal Input
- Accepts text prompts, Figma screenshots, and uploaded images
- Each input type requires different context assembly in the harness
- How does the harness decide which rendering path to use?

### Live Preview
- Generated code is immediately executed in an iframe sandbox
- Errors in the generated code are caught and can trigger auto-correction
- This is a **feedback loop** built into the core product loop

### Version Management
- Generations can be forked — each fork preserves its lineage
- This requires harness infrastructure: storage, versioning, context retrieval

---

## The 6 Harness Components

### 1. System Prompt & Instructions
- The system prompt defines the design system (shadcn/ui), framework (React), and style conventions (Tailwind)
- It likely includes examples of "good" components and "bad" components
- **Key insight:** The system prompt *is* the product — swap it for Figma MUI rules and you'd have a different product entirely
- Designer decision: *how specific should the system prompt be about visual style?*

### 2. Tools, Skills & MCPs
- Code execution (iframe sandbox)
- Figma import (screenshot → code)
- Vercel deployment
- Component library awareness (shadcn/ui docs in context)
- Designer decision: *which tools are automatic vs. user-initiated?*

### 3. Infrastructure & Sandbox
- Generated code runs in a sandboxed iframe — no access to the host environment
- This is a critical safety decision: the model can generate anything, but it runs in isolation
- Vercel's infrastructure handles storage, versioning, and deployment
- Designer decision: *what's the right sandbox boundary for your use case?*

### 4. Orchestration Logic
- Single-agent: one model, one context window per session
- No subagents visible to the user
- But under the hood: likely separate passes for code generation vs. error correction
- Designer decision: *when does auto-correction happen vs. surfacing the error to the user?*

### 5. Hooks & Middleware
- **Auto-render hook:** after every generation, immediately run the code in the preview
- **Error detection hook:** if the preview errors, trigger a re-generation or surface the error
- **Format hook:** code is always formatted consistently before display
- Designer decision: *what should happen automatically after every generation?*

### 6. Feedback Loops
- The live preview is the primary feedback mechanism — visual, immediate
- Users can fork or refine — both are implicit feedback signals
- v0 likely uses copy/deploy events as signals of success
- No explicit thumbs up/down — the product is the feedback loop
- Designer decision: *is implicit behavioral feedback enough, or do you need explicit ratings?*

---

## Design Observations

**What v0 does exceptionally well:**
- **Radical constraint creates quality** — by only supporting one stack, every generation is usable
- **The preview IS the evaluation** — no need for a separate "is this good?" step; you can see it
- **Zero friction to useful output** — describe → see → copy. Three steps.

**What v0 could do better:**
- **Limited memory** — v0 doesn't remember your design system preferences across sessions
- **No error explanation** — when a component fails to render, the error messages aren't designer-friendly
- **No intent capture** — v0 doesn't ask clarifying questions; it guesses and renders

**The key design tradeoff:**
v0 chose **speed over accuracy**. It generates immediately without asking clarifying questions. This feels fast and magical, but often requires multiple refinement rounds. A more "careful" harness would ask 2–3 questions first — but that would feel slower and more friction-heavy for a tool that competes on "instant results."

---

## Suggested Tools/APIs to Replicate This

If you were building a v0-like harness for a different design system:

- **Model:** Claude Sonnet 4.6 (strong at following style constraints)
- **System prompt:** Define your component library, naming conventions, and "good component" examples
- **Tool:** `render_component` — execute code in a sandboxed iframe
- **Tool:** `validate_component` — check for errors before rendering
- **Memory:** Store user's preferred design tokens in session context
- **RooCode equivalent:** RooCode with a custom mode configured for your component library

---

## Discussion Questions for Your Group

1. v0 only supports one tech stack. How would you decide what constraints to put on your harness?
2. The live preview doubles as a test runner. What would the equivalent "built-in feedback loop" be for your product?
3. v0 generates without asking clarifying questions. When should an agent ask vs. act?
4. If you added a memory component to v0 (remembering your preferred style), what would you store and how long would you keep it?
