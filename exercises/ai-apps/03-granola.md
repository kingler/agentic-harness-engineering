# App Profile: Granola

**Category:** AI meeting note-taker
**Website:** granola.ai
**Difficulty to reverse-engineer:** ★★☆☆☆ (Easy — almost everything happens on your machine and you can watch it)

---

## What It Does

Granola is a macOS app that sits next to your meeting (Zoom, Meet, in-person) and turns the raw audio into a *structured note* in your voice. While the meeting runs you jot rough bullets; afterward, Granola merges your bullets, the live transcript, and the calendar metadata into a polished note. You can then ask follow-up questions, generate emails, extract action items, and search across every meeting you've ever taken.

It's an unusually clean example of **harness as workflow**: the AI doesn't show up as a chatbot, it shows up as a step inside a habit you already have (taking notes during meetings).

---

## Key Features to Notice

| Feature | What It Reveals |
|---------|----------------|
| **Live transcript + your rough notes side-by-side** | Two streams of context, fused after the fact |
| **Templates** (1:1, sales call, interview, standup) | The template *is* the system prompt for the post-meeting pass |
| **Post-meeting "enhanced" note** | Heavy generation pass at a known moment (meeting end) — not chat-driven |
| **Ask Granola** (chat over a meeting or all meetings) | Retrieval grounded in your own transcripts |
| **Auto-generated follow-up email / action items** | Pre-baked secondary jobs the user expects every time |
| **Local audio capture, cloud processing** | A specific sandbox choice with real privacy implications |

---

## Agent Behaviors to Map

When analyzing Granola, look for these specific behaviors:

### Intent Recognition
- How does Granola decide what kind of meeting this was? (calendar title, attendees, template choice, user override)
- The "intent" is mostly set *before* the meeting starts — what does that tell you about when intent-capture should happen?

### Context Assembly
- Post-meeting pass: transcript + your rough notes + calendar metadata + template
- Ask Granola: retrieved chunks across meetings, ranked by recency and topic
- Action items: filtered passes over the transcript with a structured schema as the prompt
- Notice the recurring pattern — context is always *meeting-shaped*

### Tool Execution
- Almost no tools at runtime — most of Granola's "intelligence" is one big well-prompted generation pass per meeting
- Ask Granola adds retrieval as a tool
- Export to email, doc, CRM — these are tools the *user* invokes, not the agent
- Designer decision: *most "AI products" need fewer tools than they think — what's the minimum that still ships the value?*

### Error Recovery
- Bad transcript? The user can re-run with edited rough notes
- Bad enhanced note? Edit it like any doc — the substrate is a regular text editor
- Recovery is mostly "undo into a normal editing surface"

### Memory
- Every past meeting *is* the memory — searchable, citable, reusable
- Templates are durable per-user memory of "what kind of meetings do you take"
- No long-term persona memory beyond the templates
- Designer decision: *the artifact stream is the memory — what's that equivalent in your product?*

---

## The 6 Harness Components

### 1. System Prompt & Instructions
- A base "note-taker" persona — concise, neutral, your-voice-not-mine
- A *template* prompt layered on top for the specific meeting type
- Designer decision: *the template is a user-editable system prompt — how visible should that mechanism be?*

### 2. Tools, Skills & MCPs
- Audio capture (OS-level)
- Transcript retrieval (across the user's meeting history)
- Export: email draft, doc, CRM connector
- Designer decision: *which exports are first-class tools vs. just "copy this text"?*

### 3. Infrastructure & Sandbox
- Native macOS app with mic / system audio access
- Audio + transcript stored under the user's account; processed in the cloud
- No filesystem agency, no shell, no browser — the only "world" is the meeting and the user's account
- Designer decision: *what does it mean that the harness has access to your mic but not your filesystem?*

### 4. Orchestration Logic
- Single big generation pass at meeting end (the "enhanced note") — not a chat loop
- Ask Granola is the only persistent conversational surface
- Multi-meeting summaries are explicit jobs, not free-form agent runs
- Designer decision: *when is "one good prompt at the right moment" better than a multi-step agent?*

### 5. Hooks & Middleware
- Meeting-end detection triggers the enhanced-note pass deterministically
- Template selection is enforced before generation
- Transcript redaction / privacy passes
- Designer decision: *the trigger ("meeting ended") is the hook — what's the equivalent trigger in your product?*

### 6. Feedback Loops
- Users edit the enhanced note inline — strong implicit signal of "what would I have written"
- Template tweaks per user feed back into the next meeting
- Thumbs / corrections on Ask Granola answers
- Designer decision: *edits to AI output are the highest-quality feedback you can get — are you capturing them?*

---

## Design Observations

**What Granola does exceptionally well:**
- **The trigger is the product** — generation happens at meeting end, not on demand
- **Templates as user-editable prompts** — power-user customization without exposing "system prompt" terminology
- **Editing as feedback** — the harness gets corrected in the act of being used

**What Granola could do better:**
- **Cross-meeting reasoning is shallow** — Ask Granola is more search than synthesis
- **Limited proactive agency** — the agent never reaches out (e.g., "you said you'd follow up with X, you haven't")
- **Privacy posture is opinionated** — cloud-only processing is a tradeoff that won't suit every team

**The key design tradeoff:**
Granola chose **moments over conversations**. Instead of a chat where you have to ask, the AI runs at the natural seam in your workflow (meeting end). They gave up some "you can ask me anything" feel and gained a product that reliably ships value every single meeting without the user having to think about it.

---

## Suggested Tools/APIs to Replicate This

If you were building a Granola-like harness for a different recurring event (deals, support tickets, shifts):

- **Model:** Claude Sonnet 4.6 for the post-event enhanced summary; Claude Haiku 4.5 for cheap recurring extractions (action items, names, dates)
- **Trigger:** Event-end detection is the deterministic hook that fires the heavy generation
- **Templates:** Surface a small, user-editable set of templates instead of one mega-prompt
- **Retrieval:** Per-user index over past artifacts for "ask across history"
- **Hooks:** Redaction / PII scan as a post-generation hook; export-connector adapters as tools
- **Feedback:** Treat every user edit of the AI's draft as labeled training signal

---

## Discussion Questions for Your Group

1. Granola's AI runs at "meeting end" — a deterministic trigger, not a user request. What in your product has an equivalent natural trigger?
2. Templates expose what is effectively a system-prompt slot to end users. How would you decide what to expose vs. hide in your harness?
3. The harness has zero file/shell agency but has your microphone. Is that more or less powerful than a coding agent, and why?
4. If you wanted Granola to *proactively* surface things ("you promised X two weeks ago, no follow-up yet"), where in the harness would that logic live — prompt, tool, or hook?
