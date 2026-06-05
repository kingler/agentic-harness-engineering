# Agentic Harness Engineering — Transcript & Slide Screenshots

**Source video:** https://youtube.com/watch?v=g9b9G8dcS8Y

> **How this was produced.** The YouTube video could not be reached from this
> environment (the sandbox network policy blocks all YouTube/Google hosts, so
> downloading the video, its captions, or video frames was not possible). This
> presentation is the *Agentic Harness Engineering* workshop deck, which lives in
> this repository as `Agentic-Harness-Engineering-with-notes.pdf`. The transcript
> below is the **verbatim speaker notes** for each of the 53 slides, and each
> screenshot is that slide rendered to a clean 16:9 PNG (1440×810).
>
> **About the timestamps.** There is no audio to time against, so the timecodes are
> **estimated** by allocating each slide a duration from its speaker-note word count
> at ~140 words/min (with a 4-second floor for visual-only slides). They show the
> *relative* shape of the talk and a plausible running time, not exact video offsets.

- **Slides / topics:** 53
- **Estimated total runtime:** 24:56 (~25 min)
- **Screenshots:** `output/screenshots/slide-01.png` … `slide-53.png`
- **Also generated:** `output/transcript.csv`, `output/chapters.txt`

## Chapter index (estimated timestamps)

| # | Est. start | Dur | Topic | Screenshot |
|---|-----------|-----|-------|------------|
| 01 | `00:00` | 38s | Title | [slide-01](output/screenshots/slide-01.png) |
| 02 | `00:38` | 16s | Workshop Overview & Takeaways | [slide-02](output/screenshots/slide-02.png) |
| 03 | `00:54` | 33s | Why This Workshop Matters | [slide-03](output/screenshots/slide-03.png) |
| 04 | `01:28` | 48s | Agenda | [slide-04](output/screenshots/slide-04.png) |
| 05 | `02:16` | 81s | Your Environment | [slide-05](output/screenshots/slide-05.png) |
| 06 | `03:37` | 7s | Section · Foundations | [slide-06](output/screenshots/slide-06.png) |
| 07 | `03:44` | 49s | Harness Concept · Saddle | [slide-07](output/screenshots/slide-07.png) |
| 08 | `04:33` | 26s | The Core Formula | [slide-08](output/screenshots/slide-08.png) |
| 09 | `04:59` | 16s | Three Levels Of Engineering | [slide-09](output/screenshots/slide-09.png) |
| 10 | `05:15` | 22s | What Models Can'T Do | [slide-10](output/screenshots/slide-10.png) |
| 11 | `05:37` | 61s | Section · The Anatomy | [slide-11](output/screenshots/slide-11.png) |
| 12 | `06:38` | 18s | Six Core Components | [slide-12](output/screenshots/slide-12.png) |
| 13 | `06:55` | 23s | System Prompt & Tools | [slide-13](output/screenshots/slide-13.png) |
| 14 | `07:18` | 15s | Infrastructure & Orchestration | [slide-14](output/screenshots/slide-14.png) |
| 15 | `07:33` | 16s | Hooks & Feedback Loops | [slide-15](output/screenshots/slide-15.png) |
| 16 | `07:50` | 11s | Where Designers Have Leverage | [slide-16](output/screenshots/slide-16.png) |
| 17 | `08:01` | 29s | Anatomy In Files | [slide-17](output/screenshots/slide-17.png) |
| 18 | `08:30` | 16s | Harness As Product · Harvey | [slide-18](output/screenshots/slide-18.png) |
| 19 | `08:46` | 17s | Harness As Product · Claude Financial Services | [slide-19](output/screenshots/slide-19.png) |
| 20 | `09:03` | 17s | Harness As Product · Granola | [slide-20](output/screenshots/slide-20.png) |
| 21 | `09:19` | 54s | Three Apps | [slide-21](output/screenshots/slide-21.png) |
| 22 | `10:14` | 14s | Section · Component Deep Dive | [slide-22](output/screenshots/slide-22.png) |
| 23 | `10:28` | 33s | System Prompt · Overview | [slide-23](output/screenshots/slide-23.png) |
| 24 | `11:01` | 33s | System Prompt · Anatomy | [slide-24](output/screenshots/slide-24.png) |
| 25 | `11:33` | 28s | Skills · What And When | [slide-25](output/screenshots/slide-25.png) |
| 26 | `12:01` | 30s | Skills · Anatomy | [slide-26](output/screenshots/slide-26.png) |
| 27 | `12:32` | 23s | Skills · Worked Example | [slide-27](output/screenshots/slide-27.png) |
| 28 | `12:54` | 27s | Tools · Three Flavors | [slide-28](output/screenshots/slide-28.png) |
| 29 | `13:22` | 30s | Tools · Description Craft | [slide-29](output/screenshots/slide-29.png) |
| 30 | `13:52` | 30s | Tools · Script As Tool | [slide-30](output/screenshots/slide-30.png) |
| 31 | `14:22` | 25s | Tools · Mcp Example | [slide-31](output/screenshots/slide-31.png) |
| 32 | `14:47` | 32s | Rules · Example | [slide-32](output/screenshots/slide-32.png) |
| 33 | `15:19` | 33s | Hooks · Overview | [slide-33](output/screenshots/slide-33.png) |
| 34 | `15:53` | 30s | Knowledge Base | [slide-34](output/screenshots/slide-34.png) |
| 35 | `16:23` | 29s | Memory | [slide-35](output/screenshots/slide-35.png) |
| 36 | `16:52` | 53s | Prompt Structures · Chains | [slide-36](output/screenshots/slide-36.png) |
| 37 | `17:45` | 59s | Prompt Structures · Meta Vs Template | [slide-37](output/screenshots/slide-37.png) |
| 38 | `18:44` | 44s | Prompt Structures · By Component | [slide-38](output/screenshots/slide-38.png) |
| 39 | `19:28` | 22s | Day 1 Wrap-Up | [slide-39](output/screenshots/slide-39.png) |
| 40 | `19:50` | 18s | Day 2 Opener | [slide-40](output/screenshots/slide-40.png) |
| 41 | `20:08` | 7s | Section · Agentic Ux Patterns | [slide-41](output/screenshots/slide-41.png) |
| 42 | `20:15` | 16s | How Our Work Is Changing | [slide-42](output/screenshots/slide-42.png) |
| 43 | `20:32` | 16s | Agent Time | [slide-43](output/screenshots/slide-43.png) |
| 44 | `20:48` | 26s | Hooks Deep Dive | [slide-44](output/screenshots/slide-44.png) |
| 45 | `21:13` | 24s | Subagents And Mcp | [slide-45](output/screenshots/slide-45.png) |
| 46 | `21:37` | 17s | Evals And Hill Climbing | [slide-46](output/screenshots/slide-46.png) |
| 47 | `21:54` | 45s | Live Wire-Up | [slide-47](output/screenshots/slide-47.png) |
| 48 | `22:39` | 20s | Section · Demo Session | [slide-48](output/screenshots/slide-48.png) |
| 49 | `22:59` | 21s | Demo Flow & Listening | [slide-49](output/screenshots/slide-49.png) |
| 50 | `23:20` | 15s | Demo Rubric | [slide-50](output/screenshots/slide-50.png) |
| 51 | `23:36` | 19s | Demo Practices & Anti-Patterns | [slide-51](output/screenshots/slide-51.png) |
| 52 | `23:54` | 18s | Takeaways | [slide-52](output/screenshots/slide-52.png) |
| 53 | `24:12` | 44s | Resources | [slide-53](output/screenshots/slide-53.png) |

---

## Full transcript with screenshots

### 01 · Title
`est 00:00 – 00:38`  ·  ~38s  ·  slide code `01`  ·  89 words

![Slide 01 — Title](output/screenshots/slide-01.png)

Welcome to Agentic Harness Engineering for Product & UX Designers. This is a 2-day, 2-hour-per-day workshop. Quick show of hands — who's been using RooCode? Copilot? Both? Great. You already touch the harness every day — you just call it 'rules' or 'instructions'. Today and tomorrow we name what you're already doing, give it a real anatomy, and you build one from scratch by reverse-engineering an AI app you actually use. By the end of Day 2 you'll have a runnable harness folder you can drop into any project.

### 02 · Workshop Overview & Takeaways
`est 00:38 – 00:54`  ·  ~16s  ·  slide code `01B`  ·  38 words

![Slide 02 — Workshop Overview & Takeaways](output/screenshots/slide-02.png)

Workshop overview & takeaways (slide 1b). Give ~30 seconds per card: fluent anatomy vocabulary, reverse- engineer before raw prompting, leave with artifacts in the template repo. Tie each takeaway to today's five breakouts without opening the facilitator manual.

### 03 · Why This Workshop Matters
`est 00:54 – 01:28`  ·  ~33s  ·  slide code `02`  ·  78 words

![Slide 03 — Why This Workshop Matters](output/screenshots/slide-03.png)

The role of design is shifting from crafting interfaces to orchestrating intelligent systems. CARD 1 — Paradigm shift: from static wireframes to dynamic orchestration rules. CARD 2 — Agent = Model + Harness. The model is the brain. The harness is the body, the workshop, and the rules of engagement. Designers shape the harness. CARD 3 — Design IS engineering. OpenAI shipped a million-line product where humans steered and Codex executed. The discipline is now in the scaffolding.

### 04 · Agenda
`est 01:28 – 02:16`  ·  ~48s  ·  slide code `03`  ·  112 words

![Slide 04 — Agenda](output/screenshots/slide-04.png)

Day 1 you build the harness for your product. Day 2 you write a short UX brief, then in one VS Code app project use GitHub Copilot or RooCode to refine the harness and build the UI before wiring agent, harness, and UX together. — Two days, one product. Day 1 you build the harness for your chosen app — six components, taught and worked in focused breakouts. Day 2 changes shape: you clarify the frontend in prose or light sketches, generate the code with Copilot or RooCode, then wire the agent + harness + frontend UX together into a productized demo. I want you 60% hands-on, 40% with me. Let's go.

### 05 · Your Environment
`est 02:16 – 03:37`  ·  ~81s  ·  slide code `3B`  ·  189 words

![Slide 05 — Your Environment](output/screenshots/slide-05.png)

We're not training models or running servers today. You'll author the harness and a frontend prototype, then let your editor's AI play the agent. GROUND RULES — read this slide carefully because it shapes everything. CRITICAL CONSTRAINT: API keys are only available INSIDE the RooCode and Copilot extensions today. You cannot build a standalone agent that calls a model directly. The extensions already have the key — you don't. So we don't pretend to ship a real backend. Instead, we work with what you DO have: VS Code + RooCode + Copilot. THE EDITOR IS THE RUNTIME. You author two things: (1) the harness — markdown, JSON, scripts in a folder — and (2) a frontend prototype built with Copilot or RooCode from your UX brief. Then you load both into VS Code and let the extension's AI play the harnessed agent. Your CLAUDE.md is its system prompt. Your hooks fire on real tool calls. Your prototype is what a user clicks. This is exactly what Day 2's wire-up exercise asks you to do. One sentence to remember: 'harness + frontend = product; the editor's AI is the runtime.'

### 06 · Section · Foundations
`est 03:37 – 03:44`  ·  ~7s  ·  slide code `04`  ·  16 words

![Slide 06 — Section · Foundations](output/screenshots/slide-06.png)

[Pause.] Foundations: name what sits between user and model—then we'll mirror it into files and products.

### 07 · Harness Concept · Saddle
`est 03:44 – 04:33`  ·  ~49s  ·  slide code `05`  ·  114 words

![Slide 07 — Harness Concept · Saddle](output/screenshots/slide-07.png)

A model is a brilliant mind with no body. The harness is the tack that lets it carry weight, take direction, and do useful work. — Plant the metaphor. The model is the horse — fast, strong, but it has no reins, no seat, no destination. The saddle isn't the power; it's the leverage. Three pieces map across: model = horse (raw capability), harness = saddle (tools, rules, memory, hooks — the tack that makes the horse ridable), user = rider (gives direction). This is the working metaphor for the rest of Day 1: every component you build is a piece of saddle. If a model alone could do it, you wouldn't be here.

### 08 · The Core Formula
`est 04:33 – 04:59`  ·  ~26s  ·  slide code `06`  ·  61 words

![Slide 08 — The Core Formula](output/screenshots/slide-08.png)

Most important idea in the workshop. Agent = Model + Harness. Vivek Trivedy at LangChain: 'If you're not the model, you're the harness.' The AGENT is what the user experiences. The MODEL takes text and images and emits text — that's all. The HARNESS is everything else: code, config, files, tools, constraints. Designers don't train models — they absolutely design harnesses.

### 09 · Three Levels Of Engineering
`est 04:59 – 05:15`  ·  ~16s  ·  slide code `07`  ·  37 words

![Slide 09 — Three Levels Of Engineering](output/screenshots/slide-09.png)

Three concentric levels. Prompt — what the model sees this turn. Context — what the model sees and when across turns. Harness — the entire system. We touch all three but harness is where product decisions live.

### 10 · What Models Can'T Do
`est 05:15 – 05:37`  ·  ~22s  ·  slide code `08`  ·  52 words

![Slide 10 — What Models Can'T Do](output/screenshots/slide-10.png)

Every limitation is solved by a harness feature. This is where your design decisions live. — Six things models can't do alone. Each one solved by a harness feature. Memory · tool execution · web · coordination · self- verification · enforcement. Every row is a design decision your team will make.

### 11 · Section · The Anatomy
`est 05:37 – 06:38`  ·  ~61s  ·  slide code `09`  ·  142 words

![Slide 11 — Section · The Anatomy](output/screenshots/slide-11.png)

SECTION divider · The Anatomy [Pause.] We're opening section two. Foundations ended with what models can't do alone—and how harness pieces answer each gap. Now everyone gets the same map before we go deep: shared vocabulary first, then the marathon teach-and- dive runs. I'll walk through what's coming. Say this slowly—the slide is the cheat sheet. First: the six-slot overview on one screen. Orient the room; don't ask anyone to memorize yet. Next: pairwise slides and the leverage map—we widen the picture. Then: the file-tree slide—where those slots land as real folders. Then: two shipped demos—Harvey and Claude for Financial Services. Same six labels; different products. Last in this block: you pick one breakout app from the matrix—Harvey, Claude Financial Services, or Granola. Close with this line: the slow, component-by-component pass starts in section three, right after you've committed to that pick.

### 12 · Six Core Components
`est 06:38 – 06:55`  ·  ~18s  ·  slide code `10`  ·  41 words

![Slide 12 — Six Core Components](output/screenshots/slide-12.png)

Six cards mirror Day 1 agenda breakouts after anatomy—not abstract buckets: system prompt, rules, skills, tools, hooks, knowledge base. Prompt-structure framing folds into card 01; memory is teach-only later (see agenda). Say explicitly each chip maps to a breakout you'll run.

### 13 · System Prompt & Tools
`est 06:55 – 07:18`  ·  ~23s  ·  slide code `11`  ·  53 words

![Slide 13 — System Prompt & Tools](output/screenshots/slide-13.png)

LEFT: System prompt = persona, rules, constraints. AGENTS.md and .github/copilot-instructions.md tell the agent how to behave. Prompt files are progressive disclosure. RIGHT: Tools are the actions in the world. Insight: too many MCP servers make agents dumb. Tool descriptions are UX copy for the model — fewer, sharper tools beat a kitchen sink.

### 14 · Infrastructure & Orchestration
`est 07:18 – 07:33`  ·  ~15s  ·  slide code `12`  ·  36 words

![Slide 14 — Infrastructure & Orchestration](output/screenshots/slide-14.png)

LEFT: Infrastructure — filesystem is the foundational primitive. Decide what's in-context vs on-disk. RIGHT: Orchestration — when to spawn a subagent, when to keep work in the main thread. These are product decisions, not engineering decisions.

### 15 · Hooks & Feedback Loops
`est 07:33 – 07:50`  ·  ~16s  ·  slide code `13`  ·  38 words

![Slide 15 — Hooks & Feedback Loops](output/screenshots/slide-15.png)

LEFT: Hooks. When something should happen EVERY time, enforce it with code, not with hope. RIGHT: Feedback loops. Evals are the training data for the harness. LangChain calls this hill-climbing — change one thing, measure, keep or revert.

### 16 · Where Designers Have Leverage
`est 07:50 – 08:01`  ·  ~11s  ·  slide code `14`  ·  26 words

![Slide 16 — Where Designers Have Leverage](output/screenshots/slide-16.png)

Where designer leverage is highest: tool descriptions, permission UX, state visibility, error recovery, agent coordination, input architecture. Most agent failures are input failures, not intelligence failures.

### 17 · Anatomy In Files
`est 08:01 – 08:30`  ·  ~29s  ·  slide code `15`  ·  68 words

![Slide 17 — Anatomy In Files](output/screenshots/slide-17.png)

NEW SLIDE — Anatomy in files. The six components live as concrete files: AGENTS.md, .github/copilot- instructions.md, .github/instructions/, .github/prompts/, .github/agents/, .github/hooks/, mcp.json, plus the RooCode/Cline shape under .roo/rules/. Walk through the tree. Highest-leverage files: AGENTS.md (the system prompt you own), tool descriptions inside prompt files (UX copy for the model), and hooks (deterministic enforcement). Tell the room: 'You're going to author every one of these in Day 1's breakouts.'

### 18 · Harness As Product · Harvey
`est 08:30 – 08:46`  ·  ~16s  ·  slide code `08B`  ·  37 words

![Slide 18 — Harness As Product · Harvey](output/screenshots/slide-18.png)

Harvey AFTER the scaffolding on purpose — each bullet NAMES a slot learners just saw on the grid + filesystem + editor columns. Tie line: polished vendor harness vs bare repo they'll assemble for their OWN app.

### 19 · Harness As Product · Claude Financial Services
`est 08:46 – 09:03`  ·  ~17s  ·  slide code `08C`  ·  39 words

![Slide 19 — Harness As Product · Claude Financial Services](output/screenshots/slide-19.png)

Claude Financial Services pairing — SAME six-bullet mapping in regulated finance (verification posture, workbook-native tools + agent templates, traceable numeric lineage, AML-style multi-agent stories, SOC 2/FedRAMP cues, MCP-like data integrations). Explicit ask: naming pattern should feel boringly familiar now.

### 20 · Harness As Product · Granola
`est 09:03 – 09:19`  ·  ~17s  ·  slide code `08D`  ·  39 words

![Slide 20 — Harness As Product · Granola](output/screenshots/slide-20.png)

Granola harness slide (08d). Meeting-native productivity — emphasize how a minimal UI still maps to all six slots, especially orchestration / skill chains. Optional energy line: 'Notes without stopping the meeting' is a harness problem, not a prettier textarea.

### 21 · Three Apps
`est 09:19 – 10:14`  ·  ~54s  ·  slide code `17`  ·  127 words

![Slide 21 — Three Apps](output/screenshots/slide-21.png)

ON-SCREEN (was slide lede — read aloud while they study the matrix): You just traced the same six slots through Harvey (legal platform) and Claude for Financial Services. Now commit to one product you'll unpack: three options on the matrix below — same anatomy exercise, scoped to software your group knows. ADDITIONAL FACILITATOR NOTES: You can also say we walked Granola on the previous slide using the same six labels. Commit to one column for reverse-engineering — then implement each breakout inside your downloaded template harness project (sample-harness-uxd-specs / harness-templates), swapping persona and domain language to match that product. PICK slide timing: ~5 minutes; diversify groups across A/B/C so they don't all pile on Harvey. Energy line option: 'Pick the harness you'd hate to embarrass users with.'

### 22 · Section · Component Deep Dive
`est 10:14 – 10:28`  ·  ~14s  ·  slide code `18`  ·  33 words

![Slide 22 — Section · Component Deep Dive](output/screenshots/slide-22.png)

SECTION divider · Component deep dive. Anatomy orient + demos + breakout choice are anchored — reset expectations: ninety minutes drilling each harness slot ON their chosen reverse-engineered app. Depth beats another overview.

### 23 · System Prompt · Overview
`est 10:28 – 11:01`  ·  ~33s  ·  slide code `19`  ·  77 words

![Slide 23 — System Prompt · Overview](output/screenshots/slide-23.png)

The system prompt is the agent's identity — prepended every turn, survives compaction. Most expensive real estate in the harness, so keep it short and load-bearing. Lives in CLAUDE.md, AGENTS.md, or .github/copilot- instructions.md depending on your editor. Failure mode if it's missing or vague: agent has no consistent persona, drifts in tone, forgets your hard rules between turns. The room mostly already has one — they just call it 'rules' or 'instructions'. Today we name the shape.

### 24 · System Prompt · Anatomy
`est 11:01 – 11:33`  ·  ~33s  ·  slide code `20`  ·  76 words

![Slide 24 — System Prompt · Anatomy](output/screenshots/slide-24.png)

Five sections, in order. IDENTITY — who you are. SCOPE — what you do and don't do. RULES — hard predicates. TOOLS — the roster. FAILURE MODES — what to do when stuck. Each section earns its place: if you can't name the failure mode it prevents, cut it. The mermaid diagram on screen IS the template — copy it for your harness in the breakout. Don't add a sixth section unless you can defend why.

### 25 · Skills · What And When
`est 11:33 – 12:01`  ·  ~28s  ·  slide code `22`  ·  65 words

![Slide 25 — Skills · What And When](output/screenshots/slide-25.png)

Strong vs weak rules. Weak: 'be helpful' — the model can't enforce that, no predicate to check. Strong: 'never write outside /specs without confirmation' — clear, checkable. Soft rules go in the system prompt; the model may forget them. Hard rules go in settings.json allow/deny lists or in hooks; the harness enforces them. Walk the room: which of YOUR rules are hard, which are soft?

### 26 · Skills · Anatomy
`est 12:01 – 12:32`  ·  ~30s  ·  slide code `23`  ·  71 words

![Slide 26 — Skills · Anatomy](output/screenshots/slide-26.png)

A skill is a specialist instruction set the agent loads ONLY when triggered. Base context stays small; expertise gets paged in. This is progressive disclosure for AI. Trigger by keyword, slash command, file pattern, or user intent. The trigger is the most important field — vague triggers mean the skill never loads, then the agent falls back to its base instinct. The whole reason skills exist: keep the system prompt short.

### 27 · Skills · Worked Example
`est 12:32 – 12:54`  ·  ~23s  ·  slide code `24`  ·  53 words

![Slide 27 — Skills · Worked Example](output/screenshots/slide-27.png)

A skill is just a markdown file with frontmatter. Frontmatter tells the harness WHEN to load it: name, description (used for trigger matching), trigger pattern. Body tells the model WHAT to do once loaded. Treat the description like UX copy — vague descriptions cause vague triggering. Same writing discipline as a tool description.

### 28 · Tools · Three Flavors
`est 12:54 – 13:22`  ·  ~27s  ·  slide code `25`  ·  64 words

![Slide 28 — Tools · Three Flavors](output/screenshots/slide-28.png)

Walk through a real flow. User says 'review my homepage'. The harness sees the trigger 'review', loads the design-review skill, agent now follows the skill's steps instead of its base instinct. Without the skill: a generic critique. With the skill: token violations, line numbers, fix suggestions — the shape you wanted. Point: skills aren't decorative, they CHANGE the agent's behavior on the matching turn.

### 29 · Tools · Description Craft
`est 13:22 – 13:52`  ·  ~30s  ·  slide code `26`  ·  70 words

![Slide 29 — Tools · Description Craft](output/screenshots/slide-29.png)

Three ways to give an agent hands. FUNCTIONS — code in the same process. SCRIPTS — anything you can run from a shell. MCP — borrow someone else's toolset over a server protocol. Same idea, different transport. Pick by where the capability already lives. Python lib you have? Function. Curl + jq pipeline? Script. Third-party ticketing API you don't want to shell-wrap? MCP. You don't have to invent the integration.

### 30 · Tools · Script As Tool
`est 13:52 – 14:22`  ·  ~30s  ·  slide code `27`  ·  71 words

![Slide 30 — Tools · Script As Tool](output/screenshots/slide-30.png)

The tool description is UX copy for the model. The model reads every tool description on every turn before deciding what to call. Bad descriptions = wrong tool picks more often than missing tools. Three sentences: WHAT it does, WHEN to use it, WHEN NOT to use it. The 'when not' line saves you most failures — it teaches the model to delegate or refuse instead of jamming the wrong tool.

### 31 · Tools · Mcp Example
`est 14:22 – 14:47`  ·  ~25s  ·  slide code `28`  ·  58 words

![Slide 31 — Tools · Mcp Example](output/screenshots/slide-31.png)

Script-as-tool: JSON declares the interface, the script does the work. The agent reads stdout. This is how you wrap existing CLI tools into the harness without writing new code — your validate.sh becomes a tool by adding a JSON descriptor next to it. Minimal commitment, big leverage. Use this when the capability already exists in your team's tooling.

### 32 · Rules · Example
`est 14:47 – 15:19`  ·  ~32s  ·  slide code `27B`  ·  75 words

![Slide 32 — Rules · Example](output/screenshots/slide-32.png)

MCP is how you mount someone else's tools. Register a server in mcp.json — the agent gets every tool that server exposes. Issue trackers, GitHub PRs, internal gateways — no integration code from you. Designer- relevant servers: GitHub, browser automation, ticketing, your design-system API. Caution: too many MCP servers make the agent dumb — too many tools to choose from. Start with one, add only when needed. The 'kitchen sink' is the failure mode here.

### 33 · Hooks · Overview
`est 15:19 – 15:53`  ·  ~33s  ·  slide code `29`  ·  78 words

![Slide 33 — Hooks · Overview](output/screenshots/slide-33.png)

Hooks: deterministic gates around tool calls. PreToolUse fires BEFORE — you can block it. PostToolUse fires AFTER — you can react. The model can forget its rules. The hook can't. Use a hook when 'every time' matters: every time the agent writes a file, every time a tool returns an error, every time the session starts. Hooks > hoping. Designers don't usually write the shell — but you decide WHICH rules deserve a hook vs. a soft prompt.

### 34 · Knowledge Base
`est 15:53 – 16:23`  ·  ~30s  ·  slide code `30`  ·  71 words

![Slide 34 — Knowledge Base](output/screenshots/slide-34.png)

Knowledge base = the domain context the agent reads on demand. Files in knowledge/ are referenced by the system prompt and loaded by skills. Stable info — schemas, dictionaries, workflows, design system facts — goes here. Volatile info — current session, secrets, what the user just said — does NOT. Breakout 6: capture one domain file your agent always needs. 12 minutes — schema, dictionary, or workflow, whichever unblocks more behavior.

### 35 · Memory
`est 16:23 – 16:52`  ·  ~29s  ·  slide code `31`  ·  68 words

![Slide 35 — Memory](output/screenshots/slide-35.png)

Memory is the working scratchpad. Different from the knowledge base (stable) and the system prompt (identity). Two types. SESSION — notes/SESSION.md cleared at session end. PERSISTENT — files reread on every SessionStart hook, survive restarts. The post-tool-use hook is often where memory gets WRITTEN. Memory is not a breakout — it's a concept to keep in your head while you build. The hook IS often where memory lives.

### 36 · Prompt Structures · Chains
`est 16:52 – 17:45`  ·  ~53s  ·  slide code `31C`  ·  123 words

![Slide 36 — Prompt Structures · Chains](output/screenshots/slide-36.png)

Two prompt shapes you'll see everywhere in the harness. META = persistent — the agent's frame. Lives in AGENTS.md / CLAUDE.md / system prompt. Loaded once per session, prepended every turn. Sets identity, scope, hard rules, tool roster. TEMPLATE = parameterized — the agent's task slot. Lives in skill bodies, slash commands, tool inputs, hook outputs. Filled in at runtime with task-specific values. Renders per-turn from a fixed shape. Drill the room: every harness component you build is one or the other — or both layered. The system prompt is meta. A skill body is template. A tool description is template. A hook injection is template referenced from a meta. Get them to call out which is which from their own breakout work.

### 37 · Prompt Structures · Meta Vs Template
`est 17:45 – 18:44`  ·  ~59s  ·  slide code `31B`  ·  137 words

![Slide 37 — Prompt Structures · Meta Vs Template](output/screenshots/slide-37.png)

This is how subagents and workflows work — without spending time on mechanics. A subagent is just a stage with its own meta + template, returning a result. A workflow is the chain. Each stage's output becomes the next stage's input. The black band across the top is the META — same identity and rules persist across all three stages. The three stage cards are TEMPLATES — each has its own input variables and produces a typed output. The chain isn't code, it's prompts. The harness's job is to route outputs to inputs. When someone asks 'how do I build a multi-step workflow?', point at this slide. You write three small templates, you let the meta carry across. We won't write orchestration today — but you'll recognize this shape when you read RooCode workflows or LangGraph chains.

### 38 · Prompt Structures · By Component
`est 18:44 – 19:28`  ·  ~44s  ·  slide code `31D`  ·  103 words

![Slide 38 — Prompt Structures · By Component](output/screenshots/slide-38.png)

Reference card. Every component is a shaped prompt. Same four ingredients — identity, rules, inputs, outputs — different surface, different lifecycle. AGENT (META, navy tag) is the long-lived shape in CLAUDE.md / AGENTS.md. SKILL (TEMPLATE, blue tag) is loaded on trigger from .claude/skills/*.md. TOOL (TEMPLATE, blue tag) is invoked when the agent picks it from tools/*.json. HOOK (CONTEXT, amber tag) injects fresh content before/after a step from .claude/hooks/*.sh. Use this slide as a mental cheat-sheet during the breakouts. When someone asks 'where does this rule go?' — the answer is on this card. Pin it open in a second tab if you can.

### 39 · Day 1 Wrap-Up
`est 19:28 – 19:50`  ·  ~22s  ·  slide code `32`  ·  52 words

![Slide 39 — Day 1 Wrap-Up](output/screenshots/slide-39.png)

DAY 1 CLOSE. 2 minutes per group. Show the file tree, name the design decision they fought about most, name what they couldn't decide. The undecided question becomes the first conversation tomorrow morning. Homework: push the branch, run the agent at home, save 2 transcripts where the harness misbehaves, bring 1 question.

### 40 · Day 2 Opener
`est 19:50 – 20:08`  ·  ~18s  ·  slide code `33`  ·  42 words

![Slide 40 — Day 2 Opener](output/screenshots/slide-40.png)

DAY 2 OPENER. 'Yesterday you built the bones. Today you wire it into a real editor, watch it fail, and harden it.' Quick recap — anyone bring back a transcript that surprised them? Get 1-2 stories from the room before moving on.

### 41 · Section · Agentic Ux Patterns
`est 20:08 – 20:15`  ·  ~7s  ·  slide code `34`  ·  17 words

![Slide 41 — Section · Agentic Ux Patterns](output/screenshots/slide-41.png)

Section divider — Agentic UX Patterns. Bridge from the morning recap to the lens shift designers need.

### 42 · How Our Work Is Changing
`est 20:15 – 20:32`  ·  ~16s  ·  slide code `35`  ·  38 words

![Slide 42 — How Our Work Is Changing](output/screenshots/slide-42.png)

Journey mapping → Intent-system mapping. Wireframes → Orchestration rules. Usability testing → Real system testing. Visual design → State modeling. Feature requests → Capability boundaries. The verb of design has changed. Read the row, give one example each.

### 43 · Agent Time
`est 20:32 – 20:48`  ·  ~16s  ·  slide code `36`  ·  37 words

![Slide 43 — Agent Time](output/screenshots/slide-43.png)

Past / Present / Future of agent input architecture. PAST: prefs, history — what should it remember and for how long? PRESENT: current state, signals. FUTURE: proactive suggestions — when helpful, when intrusive? Designers influence all three.

### 44 · Hooks Deep Dive
`est 20:48 – 21:13`  ·  ~26s  ·  slide code `37`  ·  60 words

![Slide 44 — Hooks Deep Dive](output/screenshots/slide-44.png)

HOOKS DEEP DIVE. Lifecycle: SessionStart, UserPromptSubmit, PreToolUse, PostToolUse, Stop / SessionEnd. Use a hook when: the rule must hold every time, the failure has hard cost, the check is mechanical, you want a human gate. DON'T use a hook when: the check needs nuance, only matters 1 in 100 turns, the model's verdict IS the logic, or you're flagging style.

### 45 · Subagents And Mcp
`est 21:13 – 21:37`  ·  ~24s  ·  slide code `38`  ·  55 words

![Slide 45 — Subagents And Mcp](output/screenshots/slide-45.png)

SUBAGENTS & MCP. Subagents = isolated context, different rules, returns a result. Use when work has a clean input → output contract. MCP = external tool servers your harness mounts. Designer-relevant servers: GitHub, Browser, ticketing, your design-system API. The minute they grok MCP, the question 'how does this reach my issue tracker?' has an answer.

### 46 · Evals And Hill Climbing
`est 21:37 – 21:54`  ·  ~17s  ·  slide code `39`  ·  39 words

![Slide 46 — Evals And Hill Climbing](output/screenshots/slide-46.png)

EVALS & HILL-CLIMBING. Capture failures → save as evals → replay after every harness change → score → keep what improves the set. For designers: each transcript is a usability test. Read 5 sessions before changing one tool description.

### 47 · Live Wire-Up
`est 21:54 – 22:39`  ·  ~45s  ·  slide code `40`  ·  106 words

![Slide 47 — Live Wire-Up](output/screenshots/slide-47.png)

LIVE WIRE-UP — 25 minutes. Same groups as Day 1. Reminder: the editor IS the runtime — RooCode and Copilot already have the API key, your harness configures HOW they behave. Drop the harness/ folder into a workspace, open it in VS Code, and let the extension's AI play the agent. Run a real task — preferably the one they reverse-engineered. The frontend prototype they built in Breakout 3 should be what they click while the agent works. Watch where the behavior diverges from the original product. Make ONE high-leverage change. Re-run. Capture before.txt, after.txt, diff.md, and the tradeoff. They'll demo this in the next session.

### 48 · Section · Demo Session
`est 22:39 – 22:59`  ·  ~20s  ·  slide code `41`  ·  47 words

![Slide 48 — Section · Demo Session](output/screenshots/slide-48.png)

DEMO SESSION DIVIDER. 5 minutes per group, 1 minute Q&A each. Live in their editor. Set the tone: 'We're not judging finish — we're judging the tradeoff you can defend.' Advance once — the next slide is the two checklists: demo flow and what we're listening for.

### 49 · Demo Flow & Listening
`est 22:59 – 23:20`  ·  ~21s  ·  slide code `41B`  ·  49 words

![Slide 49 — Demo Flow & Listening](output/screenshots/slide-49.png)

DEMO CHECKLISTS. Left card: 5-minute flow — app + intent + failure mode, file tree, live task, before/after diff, name the tradeoff. Right card: listening criteria — tool copy as UX, hooks doing real work, tight tool list, honest failure mode, defendable tradeoff. Leave this up while groups present.

### 50 · Demo Rubric
`est 23:20 – 23:36`  ·  ~15s  ·  slide code `42`  ·  36 words

![Slide 50 — Demo Rubric](output/screenshots/slide-50.png)

DEMO RUBRIC — score table only. Five categories, 5 points each. Score yourselves first, then we score each other. Next slide: best practices on the left, anti-patterns on the right — leave it up during debrief.

### 51 · Demo Practices & Anti-Patterns
`est 23:36 – 23:54`  ·  ~19s  ·  slide code `42B`  ·  44 words

![Slide 51 — Demo Practices & Anti-Patterns](output/screenshots/slide-51.png)

DEMO DO'S AND DON'TS. Left column: best practices — intent-first, cap tools at ~7, hooks for every-time rules, small files, evals. Right column: anti-patterns we call out in discussion — MCP sprawl, prompt doing hook work, no success signal, no user scoping, rehearsed-only demos.

### 52 · Takeaways
`est 23:54 – 24:12`  ·  ~18s  ·  slide code `43`  ·  41 words

![Slide 52 — Takeaways](output/screenshots/slide-52.png)

TAKEAWAYS. 01 Agent = Model + Harness. 02 The harness is mostly files. 03 Tool descriptions = UX copy. 04 Hooks > hoping. 05 Most agent failures are input failures. Thank the room. Keep the energy up — they earned it.

### 53 · Resources
`est 24:12 – 24:56`  ·  ~44s  ·  slide code `44`  ·  103 words

![Slide 53 — Resources](output/screenshots/slide-53.png)

RESOURCES. Three rows of links. TOP ROW — source material: LangChain's anatomy essay, arXiv 2603.20075, and the MCP spec. SECOND ROW (Copilot — orange stripe) is the priority for most of this room: VS Code custom instructions, the GitHub Docs reference for repo instructions, prompt files, custom agents, and the Customize-AI overview. Walk the room through these explicitly — these are the docs they'll re-open Monday morning. THIRD ROW — RooCode and Cline docs for the rest of the audience. Closing line: 'Keep editing your harness in the open. Push to a shared branch. The harness is a living artifact, not a deliverable.'

---
_Transcript and screenshots derived from the workshop deck speaker notes; timestamps are estimated, not measured from the video._