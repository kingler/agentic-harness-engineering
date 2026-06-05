# Planning Phase · Step 1 — Reverse-Engineer an AI App

**Duration:** 25 minutes  
**Day:** Day 1 (planning phase)  
**Format:** Groups of 3–4

---

> **Exercise chain.** This is the start of the **planning phase**. **Sets up →**
> Step 2 (research the domain) and Step 3 (design *your* harness) — which then
> feed the component build breakouts and the Day 2 app build. Keep your notes;
> the next steps consume them. Phase overview: [`README.md`](./README.md).

## Your Goal

By the end of this session, your group will have a **harness map** — a structured breakdown of how your chosen AI application works under the hood, organized around the 6 harness components.

You're not guessing randomly. You're reasoning from observable behaviors to underlying architecture decisions. Think of it like a chef reverse-engineering a dish: you can't see the kitchen, but you can taste every ingredient.

---

## Step 0 — Choose Your App (5 min)

If your group hasn't already chosen an app, pick one from the three profiles in `exercises/ai-apps/`:

| Option | App | Best for |
|--------|-----|----------|
| A | **Harvey** — legal AI platform | Rich vertical harness — privilege, citations, multi-agent workflows |
| B | **Claude for Financial Services** | Regulated vertical — verification-first outputs, Excel/PPT surfaces |
| C | **Granola** — AI meeting notepad | Smallest surface area — fast map of all six components |

**Tip:** Pick the column you can observe most clearly as a user. You will copy **domain language** into your local **template harness project**, not proprietary vendor prompts.

---

## Step 1 — Observe the Surface (5 min)

Before mapping the internals, agree on what the app *does* from a user perspective.

Spend 5 minutes answering these questions as a group. One person takes notes.

**What is the app's primary user intent?**  
(e.g., "Generate a working React component from a text description")

**What are 3–5 things users can do with it?**  
List the features, not the technology.

**What's surprising or delightful about the experience?**  
What does it do that you wouldn't have expected? These are often the most interesting harness decisions.

**What's frustrating or inconsistent?**  
Failures often reveal the limits of the harness — where the designers ran out of control.

**What does the app's *domain* demand?**  
Your app is a **vertical** tool — its hardest harness decisions come from the domain, not the UI. Jot first impressions now (legal → privilege & citations; finance → auditability & disclosure; meetings → recording consent); you'll dig in next in **Step 2 — Research the Domain** ([`planning-domain-research.md`](./planning-domain-research.md)), which turns these into rules, hooks, and knowledge.

---

## Step 2 — Map the 6 Harness Components (12 min)

Use the mapping template below. For each component, write:
1. **What you observe** — the user-facing behavior
2. **What you infer** — the harness decision that produces it
3. **Designer leverage** — would you make the same decision? Why / why not?

Work through each component. You don't need to be right — you need to have a defensible hypothesis.

---

### Component 1: System Prompt & Instructions

**What you observe:**
- What persona does the app have? (friendly, technical, terse?)
- Are there things it consistently refuses to do?
- Does it have a consistent voice or style?

**What you infer:**
- What rules are likely in the system prompt?
- Does it probably have a single system prompt, or multiple (one per feature)?

**Your decision:**  
`[ ] Same  [ ] Different — because:`

---

### Component 2: Tools, Skills & MCPs

**What you observe:**
- What actions can the app take? (edit files, search web, call APIs, run code?)
- How does it signal that it's using a tool? (spinner? message? silent?)
- Does it ask permission before using tools, or just act?

**What you infer:**
- What tools are probably in the harness?
- How many? (Remember: fewer tools = more reliable agent)
- Which ones require user confirmation?

**Your decision:**  
`[ ] Same  [ ] Different — because:`

---

### Component 3: Infrastructure & Sandbox

**What you observe:**
- Where does the app run? (local app, web app, VS Code extension?)
- Can it access your local files? Your system? The internet?
- What happens when something goes wrong — does it affect your environment?

**What you infer:**
- What's the sandbox boundary? (browser, VM, local process, container?)
- What can the agent access vs. what is it blocked from?

**Your decision:**  
`[ ] Same  [ ] Different — because:`

---

### Component 4: Orchestration Logic

**What you observe:**
- Does the app ever seem to plan before executing?
- Does it break complex tasks into steps?
- Does it ever spawn "sub-tasks" or parallel threads of work?
- Does it change approach mid-way through?

**What you infer:**
- Single agent or multi-agent?
- Does it likely do a planning pass before execution?
- How does it handle long tasks that exceed the context window?

**Your decision:**  
`[ ] Same  [ ] Different — because:`

---

### Component 5: Hooks & Middleware

**What you observe:**
- What happens *automatically* after the agent acts? (auto-lint, auto-format, auto-test, auto-preview?)
- Are there things that *always* happen, regardless of what the agent was asked?
- Are there things that are *never* allowed, even if you ask?

**What you infer:**
- What deterministic hooks are running?
- What rules are enforced by code, not by the model?

**Your decision:**  
`[ ] Same  [ ] Different — because:`

---

### Component 6: Feedback Loops

**What you observe:**
- How do you tell the agent when it did a good job? A bad job?
- Does the app remember your preferences within a session? Across sessions?
- Does the app seem to improve over time based on how people use it?

**What you infer:**
- What signals does the harness capture? (accept/reject, thumbs, behavioral, none?)
- Is feedback explicit (you rate it) or implicit (it watches what you do)?

**Your decision:**  
`[ ] Same  [ ] Different — because:`

---

## Step 3 — Identify the Most Interesting Decision (5 min)

Look at your completed map. Find the **one harness decision** that is most surprising, most impactful, or most debatable.

Write it as a statement your group can defend:

> "The most important harness decision [App Name] made was _______.  
> We think they made this choice because _______.  
> We would [keep / change] it because _______."

This is what you'll share when the full group regroups.

---

## Deliverable

At the end of this session, your group should have:

- [ ] A completed 6-component harness map (doesn't need to be pretty — notes are fine)
- [ ] One "most interesting decision" statement ready to share
- [ ] At least one thing you'd do differently

---

## Facilitation Notes (for the room facilitator)

**If groups are stuck:** Ask "What does the app do *every single time*, no matter what?" — that's the hook/middleware answer. Then work backwards.

**If groups are going too deep:** Redirect with "You have 3 minutes per component — make a call and move on."

**If groups disagree:** That's great — capture both hypotheses and note what would need to be true for each one to be correct.

**When time is called:** Don't cut off mid-thought. Give a 2-minute warning and ask groups to finish their current component.

**Common answers worth surfacing:**
- Harvey's privilege protection & citation requirements → hard rules enforced as hooks, not system-prompt instructions
- Harvey's workflow agents (litigation, transactional, in-house) → orchestration as the unit of value, not chat
- Claude Financial Services living inside Excel and PowerPoint → tool surface as the product decision (don't build a chat tab)
- Claude FS's "no number without lineage" → verification gate enforced as middleware
- Granola's choice *not* to join meetings as a bot → sandbox / capture surface as a deliberate trust boundary
- Granola's fixed output schema (summary · decisions · actions) → schema enforcement as a post-generation hook
