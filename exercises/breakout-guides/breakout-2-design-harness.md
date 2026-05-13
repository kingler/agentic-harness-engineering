# Breakout Session 2: Design Your Harness Architecture

**Duration:** 25 minutes  
**Day:** Day 1  
**Format:** Same groups as Breakout 1

---

## Your Goal

Take what you learned reverse-engineering someone else's harness and apply it to your own. By the end of this session, your group will have a **harness blueprint** — a set of deliberate design decisions for each of the 6 components, tailored to your chosen app concept.

You're not building code yet. You're making decisions. The best 25 minutes you'll spend is thinking hard about constraints and tradeoffs before you touch a single file.

---

## Before You Start

From Breakout 1, you have:
- A map of how an existing AI app works
- The most interesting decision they made and why

Now flip the direction:

> "If we were building [a version of this app / a new app inspired by what we learned], what harness decisions would WE make?"

Your app concept: **[from your group's Breakout 1 choice + any pivots]**

If you want to design a completely different app, that's fine — but pick something specific. "An AI assistant for designers" is too vague. "An AI assistant that reviews Figma exports against our design token system and flags inconsistencies" is specific enough to make real decisions.

---

## Step 1 — Define the Core Intent (5 min)

Before designing the harness, align on what you're building.

Write one-sentence answers to each:

**What is the primary user intent?**  
(The single most important thing users will ask your agent to do)

**Who are the users?**  
(Be specific — "product designers at a 50-person SaaS company," not just "designers")

**What's the golden path?**  
(Walk through the ideal interaction in 3–5 steps. User does X, agent does Y, user gets Z.)

**What's the nightmare failure mode?**  
(What's the worst thing that could go wrong? This shapes your hooks and permissions.)

---

## Step 2 — Make the 6 Harness Decisions (15 min)

For each component, your group makes one key decision. Record it as: **Decision → Rationale → Tradeoff accepted**.

---

### Decision 1: System Prompt & Instructions

**The question:** What persona, rules, and constraints will define this agent's behavior?

Think about:
- What should the agent *always* do (tone, formatting, confirmation patterns)?
- What should it *never* do (access certain data, take certain actions)?
- Should there be one global system prompt or multiple (one per feature/mode)?
- What's the "character" of this agent? How does it talk?

**Example decisions:**
- "We'll use a single concise system prompt (under 500 words) because we want predictable, fast responses"
- "We'll use separate prompts for 'analysis mode' vs. 'generation mode' because they have very different behaviors"

**Our decision:**

---

### Decision 2: Tools, Skills & MCPs

**The question:** What can this agent do in the world?

List 3–5 tools maximum. For each tool, decide:
- What does it do?
- What parameters does it take?
- Does it require user confirmation before running?

**Tool naming tip:** Name tools as verbs: `read_design_file`, `generate_component`, `flag_inconsistency`, `send_notification`. Noun tools (`file_reader`) are harder for agents to use correctly.

| Tool name | What it does | Confirmation required? |
|-----------|-------------|----------------------|
| | | |
| | | |
| | | |

**Tradeoff question:** Did you cut any tools that would have been useful? Why?

**Our decision:**

---

### Decision 3: Infrastructure & Sandbox

**The question:** Where does this agent live and what can it access?

Think about:
- Does it run locally (VS Code extension) or in the cloud (web app)?
- What files, databases, or APIs can it access?
- What's the sandbox boundary — what can it *not* touch?
- How sensitive is the data it handles? (Low = fewer restrictions. High = tight sandboxing.)

**The trust spectrum:**
- **No sandbox:** Agent can access everything the user can (developer tools running locally)
- **Filesystem sandbox:** Agent limited to a specific directory (Cline, RooCode, Copilot CLI)
- **Plugin / API sandbox:** Agent runs inside a host app's permissioned API surface (in-product AI features)
- **Tenant / data-plane sandbox:** Agent runs cloud-side but can only see one customer's data (Harvey per-matter, Claude Financial Services per-firm)
- **Full cloud isolation:** Agent runs in a managed cloud environment with whitelisted egress only

**Our decision:**

---

### Decision 4: Orchestration Logic

**The question:** How does this agent handle complex, multi-step tasks?

Think about:
- For your primary use case, is one model call enough, or does it need to chain steps?
- Should complex tasks involve a "planning" pass before execution?
- Will you ever need to spawn subagents for parallel work?
- How will you handle tasks that exceed the context window?

**Simple rule:** If your agent's primary task takes more than 3 steps to complete, you need an orchestration strategy.

**Our decision:**

---

### Decision 5: Hooks & Middleware

**The question:** What should happen automatically — every time, no exceptions?

This is where you encode your "never" rules in code, not in the system prompt.

Think about:
- What should always happen *before* a tool runs? (Validation, permission check, logging?)
- What should always happen *after* a tool runs? (Formatting, notification, undo-wrapping?)
- What actions should be blocked entirely, regardless of what the agent or user wants?

**The hook test:** Ask "Should this happen even if the model forgets to do it?" If yes, it's a hook.

**Our hooks:**

| Hook type | What it does | Why it must be deterministic |
|-----------|-------------|------------------------------|
| Pre-tool | | |
| Post-tool | | |
| On error | | |

---

### Decision 6: Feedback Loops

**The question:** How will this harness improve over time?

Think about:
- How will you know when the agent gave a good answer? When it failed?
- Explicit feedback (thumbs, rating) or implicit (usage patterns, manual corrections)?
- What's the minimum feedback signal you need to make this harness better?
- Who reviews the feedback data and how often?

**Common options:**
- **Explicit:** "Was this helpful?" button (low friction for users, clean signal)
- **Behavioral:** Did they copy it? Did they immediately ask for a change? Did they abandon the session?
- **Downstream:** Did the output actually get used in production? (Highest quality signal, hardest to capture)

**Our decision:**

---

## Step 3 — Identify Your Key Tradeoff (5 min)

Every harness involves tradeoffs. Name yours explicitly.

Complete this sentence:

> "We chose [DECISION A] over [DECISION B], which means our harness is better at [BENEFIT] but worse at [COST]. We accept this because [REASON]."

**Example:**
> "We chose implicit behavioral feedback over explicit ratings, which means our harness is better at capturing natural usage signals but worse at getting clear quality labels. We accept this because our users (designers) are too busy to rate every output, and behavioral signals are good enough for our improvement cadence."

**Your tradeoff:**

---

## Deliverable

At the end of this session, your group should have:

- [ ] One-sentence definition of the agent's primary intent
- [ ] Decisions filled in for all 6 components
- [ ] A clearly stated key tradeoff

Keep your notes — you'll use this blueprint directly in Breakout 3 to start building.

---

## Facilitation Notes (for the room facilitator)

**If groups are stuck on tool design:** Ask "What's the one action the agent needs to take to fulfill the primary user intent? Start there."

**If groups are adding too many tools:** "Anthropic's research shows agent quality degrades sharply above 7–10 tools. What would you cut?"

**If groups skip the tradeoff step:** This is the most important part. Push them: "What did you give up to get what you got?"

**Common sticking points:**
- Sandbox decision: Groups often want "everything" — help them articulate what risk that creates
- Feedback loops: Groups often say "we'd do both explicit and implicit" — push them to rank which matters more and why
- Hooks: Groups often conflate "rules" (soft, in the system prompt) with "hooks" (hard, enforced by code) — clarify the distinction
