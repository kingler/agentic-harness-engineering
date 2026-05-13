# App Profile: Harvey

**Category:** Domain-specific AI assistant for lawyers
**Website:** harvey.ai
**Difficulty to reverse-engineer:** ★★★★☆ (Hard — most of it is behind enterprise SSO)

---

## What It Does

Harvey is an AI workspace built for law firms and in-house legal teams. It reads contracts, drafts memos, summarizes case files, runs structured diligence across folders of documents, and answers questions grounded in the firm's own precedent and the user's document set. The product looks like a chat UI on the surface, but the value is in everything *around* the model: ingestion of legal-grade documents, citation handling, confidentiality boundaries, and workflows that match how lawyers actually bill time.

It's a textbook example of a harness that *becomes* the product. The underlying model is general-purpose; Harvey's moat is the persona, the tools, the document infra, and the deterministic checks that make a model output safe to put in front of a partner.

---

## Key Features to Notice

| Feature | What It Reveals |
|---------|----------------|
| **Workflows** (diligence, drafting, summarize) | Pre-built prompts + tool chains framed as legal tasks, not "chat" |
| **Document upload + per-matter workspaces** | Hard data boundary — agent only sees this client's files |
| **Inline citations back to source PDFs** | Determinism layered on top of generation: each claim must point at a page |
| **Vault / Knowledge** | Long-lived firm memory — precedent, templates, house style |
| **Track changes output for drafts** | Output shape matched to how lawyers review work |
| **Confidentiality / no-training guarantees** | Enterprise-grade infra promises baked into the harness contract |

---

## Agent Behaviors to Map

When analyzing Harvey, look for these specific behaviors:

### Intent Recognition
- How does Harvey route a question between "answer from this document," "answer from firm precedent," and "answer from general legal knowledge"?
- What signals does it use? (workflow choice, document attachments, explicit prompt cues?)

### Context Assembly
- For a diligence task across 200 contracts, what does Harvey put in the context window per turn?
- Likely some combination of retrieval (RAG over the matter), structured chunking, and per-question scoping
- How does it avoid mixing one client's documents into another client's answer?

### Tool Execution
- Document search, citation lookup, redline generation, table extraction
- Tools are framed in lawyer language ("draft a closing checklist") not engineer language ("call_function")
- Does it ask permission before running a long workflow, or just start?

### Error Recovery
- What happens when a citation doesn't resolve, or a document is too long?
- Does it refuse, ask a clarifying question, or fabricate?

### Memory
- Per-matter memory (this deal), per-firm memory (house style, templates), per-user memory (your preferences)
- Which lives where, and which persists across sessions?

---

## The 6 Harness Components

### 1. System Prompt & Instructions
- A heavyweight legal persona: cautious, cite-everything, never give legal advice as "advice"
- Per-workflow prompts on top of the base persona (diligence prompt ≠ drafting prompt)
- Designer decision: *how much of the lawyering style is global vs. per-workflow?*

### 2. Tools, Skills & MCPs
- Document retrieval over the matter / vault
- Citation resolver (page + paragraph anchors)
- Redline / track-changes generator
- Table and clause extractors
- Export to Word
- Designer decision: *which tools are user-callable vs. only callable by the agent inside a workflow?*

### 3. Infrastructure & Sandbox
- Cloud-only, behind firm SSO
- Per-matter data isolation — agent literally cannot see other matters
- No-training / no-cross-tenant guarantees enforced at the infra layer, not the prompt
- Designer decision: *which guarantees do you encode in the harness vs. in the contract with the customer?*

### 4. Orchestration Logic
- Heavy use of pre-baked workflows (planning is mostly *designed*, not improvised)
- Long tasks (diligence over many docs) are decomposed by the workflow, then per-doc model calls run in parallel
- Designer decision: *when do you let the model plan vs. hand it a fixed plan?*

### 5. Hooks & Middleware
- Citation check: every cited claim must resolve to a real document span, or the answer is rewritten or blocked
- PII / confidentiality scanning on outputs
- Audit log of every prompt + retrieval for the firm's compliance team
- Designer decision: *what should be guaranteed by code regardless of what the model wants to do?*

### 6. Feedback Loops
- Lawyers accept/reject drafts and edit them — implicit signal
- Explicit thumbs / report on answers
- Firm-level feedback loops shape future templates and the vault
- Designer decision: *how do you turn one lawyer's edit into a firm-wide improvement without leaking matters?*

---

## Design Observations

**What Harvey does exceptionally well:**
- **Workflows as the primary surface** — "chat" is there but the real product is task-shaped
- **Citations as a first-class output** — the model can't "win" without grounding
- **Hard data boundaries** — the matter is the unit of isolation, not the user

**What Harvey could do better (from public reporting):**
- **Onboarding cost** — workflows are powerful but require firm-side setup
- **Generality leak** — when users go off-workflow into freeform chat, the harness's guardrails are weaker
- **Latency on big diligence runs** — the cost of doing this carefully

**The key design tradeoff:**
Harvey chose **structure over flexibility**. By making workflows the primary surface, they sacrificed some "ask anything, get magic" feel — but they gained outputs a partner can actually sign off on. The right call for a domain where a hallucinated citation is a career-ending event.

---

## Suggested Tools/APIs to Replicate This

If you were building a Harvey-like harness for a different domain expert:

- **Model:** Claude Sonnet 4.6 for reasoning, Claude Haiku 4.5 for per-document extraction passes
- **Retrieval:** Per-matter vector index + structured metadata (party, date, clause type)
- **Citation:** Force tool calls to return `{quote, doc_id, page, span}` and reject answers that cite nothing
- **Workflows:** Encode the top 5–10 recurring jobs as named flows with their own prompts and tool sets
- **Boundary:** Per-tenant key / per-matter key so the agent literally can't see across matters
- **Hooks:** Deterministic citation-resolution and confidentiality scan as post-tool-use hooks

---

## Discussion Questions for Your Group

1. Harvey makes "the workflow" the primary surface instead of chat. What did they gain and lose by that choice?
2. Every citation must resolve to a real document span. Is this a system prompt rule, a tool design, or a hook? Why does the answer matter?
3. A partner asks Harvey a question about Matter B while logged into Matter A. Where in the harness does that get stopped?
4. If you were building a "Harvey for accountants" or "Harvey for doctors," which Harvey decisions would you keep and which would you change?
