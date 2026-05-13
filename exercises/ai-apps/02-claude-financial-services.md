# App Profile: Claude for Financial Services

**Category:** Vertical AI for banking, insurance, asset management, and fintech
**Website:** anthropic.com/solutions/financial-services
**Difficulty to reverse-engineer:** ★★★★☆ (Hard — most deployments are behind firm SSO; the marketing site and product demos are your primary observable surface)

---

## What It Does

Claude for Financial Services is Anthropic's vertical packaging of Claude for regulated finance: banks, insurers, asset managers, and fintechs. It shows up where analysts already work — inside Excel and PowerPoint — backed by agent templates for modeling, diligence, and reporting; data connectors to market and identity providers (LSEG, FactSet, S&P Global, Morningstar, Moody's, Dun & Bradstreet); and a governance posture (SOC 2, FedRAMP, verifiable lineage) built for second-line review.

The interesting design move is that the "product" isn't a chat window — it's a *verification-first* harness wrapped around Claude. Every numeric output is expected to trace back to a trusted source, every workflow has a deterministic gate before it touches capital markets or client-facing actions, and the orchestration is opinionated about how analysts hand work between agents.

It's a strong example of how the same base model becomes a different product entirely when you change the persona, the tools, the data plane, and the hooks.

---

## Key Features to Notice

| Feature | What It Reveals |
|---------|----------------|
| **Native in Excel & PowerPoint** | The agent lives where work already happens — not in a separate chat app |
| **Agent templates** (modeling, diligence, reporting) | Pre-baked multi-step flows framed in analyst language |
| **Traceable numbers** | Every figure must cite the underlying data — no fluent prose without lineage |
| **Multi-agent flows** (AML, credit, fraud, portfolio ops) | Specialized agents that hand work between each other |
| **Pre-built data connectors** (LSEG, FactSet, S&P, Morningstar, Moody's, D&B) | Verifiable data integrations as a first-class part of the harness |
| **SOC 2 / FedRAMP posture** | Compliance promises encoded as infra commitments, not prompt language |

---

## Agent Behaviors to Map

When analyzing Claude for Financial Services, look for these specific behaviors:

### Intent Recognition
- How does the harness decide between "extend this model," "build this deck," "investigate this alert," and "answer this question"?
- Most likely the *template* the analyst picks (or the surface they're in — Excel vs. PowerPoint) is the primary intent signal
- What does it mean when intent is captured by *surface* rather than by parsing the user's text?

### Context Assembly
- For a modeling task: workbook contents + named ranges + connector data + the firm's house assumptions
- For a diligence task: documents in the deal room + market data + comparable transactions
- For an AML investigation: transaction history + counterparty data + previously flagged patterns
- Notice that each workflow has a *fixed-shape* context recipe — not freeform retrieval

### Tool Execution
- Read/write cells in the workbook
- Generate / restructure slides
- Pull from market data connectors (price, fundamentals, identifiers)
- Pull from identity/entity connectors (KYC, ownership)
- Generate audit-grade citations on every numeric claim
- Designer decision: *which tools are agent-callable vs. analyst-callable?*

### Error Recovery
- If a number doesn't tie back to a source, what happens — refusal, rewrite, or human escalation?
- If a connector returns stale data, does the agent flag the staleness or paper over it?
- The harness has to choose between "fail loudly" and "fail safely" on every numeric output

### Memory
- Per-firm: house style, approved sources, naming conventions, model templates
- Per-deal / per-portfolio: assumptions, comparables, prior committee feedback
- Per-analyst: shortcuts, preferred views
- Designer decision: *what's firm-wide policy vs. analyst-level preference, and how do you keep those from polluting each other?*

---

## The 6 Harness Components

### 1. System Prompt & Instructions
- A risk-aware, verification-first persona — cite sources, flag uncertainty, refuse to fabricate
- Per-workflow prompts on top of the base persona (a credit-memo prompt is not a diligence-deck prompt)
- The model is told it is *not* the source of truth for numbers — the connectors are
- Designer decision: *which guardrails belong in the prompt at all vs. in the tools or hooks?*

### 2. Tools, Skills & MCPs
- Excel: read/write cells, named ranges, sheets
- PowerPoint: create / restructure slides, charts, exec summaries
- Market data: pricing, fundamentals, identifiers (LSEG / FactSet / S&P / Morningstar / Moody's / D&B)
- Citation tool: every numeric output gets `{value, source, retrieved_at}`
- Designer decision: *which connectors are first-class tools vs. background retrieval?*

### 3. Infrastructure & Sandbox
- Cloud, behind firm SSO; per-tenant isolation; SOC 2 / FedRAMP-aligned controls
- No filesystem or shell agency — the "world" is the workbook, the deck, and the approved data plane
- Outbound network is *only* through whitelisted data connectors
- Designer decision: *the data plane is the sandbox — what would break if you got isolation wrong even once?*

### 4. Orchestration Logic
- End-to-end agents for workflows like AML investigation, credit decisioning, fraud prevention, portfolio ops
- Specialized agents hand work between each other (research → modeling → review)
- The user can step in at any handoff — these are not autonomous loops, they're paced flows
- Designer decision: *when do you spawn a sub-agent vs. just keep going in one context?*

### 5. Hooks & Middleware
- Deterministic gate before any capital-markets or client-facing action — human sign-off required
- Lineage check: every figure must resolve to a source row in the connector data
- Audit log of every prompt, retrieval, and tool call for compliance / second-line review
- Designer decision: *which checks are model-side (it might forget) vs. code-side (it can't)?*

### 6. Feedback Loops
- Analyst edits to the model output are the highest-signal feedback — capture every accept/reject of a generated cell or slide
- Committee feedback flows back into firm-wide templates and house assumptions
- Connector errors and staleness feed back into routing decisions
- Designer decision: *how do you turn one desk's hard-won corrections into the firm's next-week defaults without leaking deals?*

---

## Design Observations

**What Claude for Financial Services does exceptionally well:**
- **Verification-first as a product stance** — "the agent is not the source of truth for numbers" is encoded everywhere
- **Lives in the analyst's existing tools** — Excel and PowerPoint as the primary surface, not a chat window
- **Data partners as first-class harness components** — connectors are part of the product, not an afterthought

**What this harness has to fight against (true of any vertical AI in regulated finance):**
- **Off-template freeform chat** is where guardrails are weakest — easy to ask something the workflow wasn't designed for
- **Connector coverage limits the harness** — anything not connected is invisible, and analysts will notice
- **Audit/compliance latency** — the careful version is slower than the unsafe version

**The key design tradeoff:**
The harness chose **verification over fluency**. It would be technically possible to give analysts a faster, more "magical" experience by letting the model talk freely about numbers — but a single hallucinated figure in a committee deck is a career-ending event. The harness pays the speed/latency cost to make outputs defensible.

---

## Suggested Tools/APIs to Replicate This

If you were building a finance-grade harness on top of a general model:

- **Model:** Claude Sonnet 4.6 for analyst-facing reasoning; Claude Haiku 4.5 for high-volume extraction and per-row passes
- **Surface:** Excel and PowerPoint add-ins — meet the analyst where they already work
- **Citation:** Force every numeric tool result to return `{value, source, retrieved_at, confidence}`; refuse or rewrite outputs that lose lineage
- **Connectors:** Treat market/identity data providers as named tools, not generic search
- **Templates:** Encode the top 5–10 workflows (model, deck, memo, AML alert, credit memo) as named flows with their own prompts and tool sets
- **Hooks:** Lineage verification, PII scan, and human-approval gate as post-tool-use hooks before any client-facing or capital-markets action
- **Memory:** Per-firm house style and approved sources as durable memory; per-deal scratchpad as ephemeral

---

## Discussion Questions for Your Group

1. The harness *forbids* the model from being the source of truth for numbers. Is that a system-prompt rule, a tool design, or a hook — and why does the answer matter?
2. The product lives inside Excel and PowerPoint instead of a chat window. What did they gain and lose by that choice?
3. An analyst pastes a question that isn't covered by any template. Where in the harness should that be handled — and what's the *default* answer when verification can't be guaranteed?
4. If you were building "Claude for clinical trials" or "Claude for actuarial," which of these decisions transfer directly, and which break?
