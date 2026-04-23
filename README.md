# Agentic Harness Engineering Workshop

A hands-on, 2-day workshop for Product & UX Designers who want to go beyond prompting — and start engineering the systems that make AI agents actually work.

---

## What You'll Learn

By the end of this workshop, you will be able to:

- Explain the **Agent = Model + Harness** formula and why it matters for designers
- Map the **6 core harness components** of any AI-powered product
- Identify where **designer leverage** is highest in an agentic system
- Reverse-engineer a real AI application into its harness architecture
- Design a harness from scratch using **AGENTS.md**, tool definitions, hooks, and prompts
- Test your harness using **RooCode** and **GitHub Copilot** in VS Code
- Present your harness to peers and articulate its key design decisions

---

## Who This Is For

Product designers and UX designers who:

- Already use **RooCode** or **GitHub Copilot** in VS Code
- Build prototypes from **Figma** designs
- Have a **GitHub account** and are comfortable with VS Code
- Want to shape AI behavior — not just use AI tools

No coding background required. You will write configuration files, markdown, and JSON — not production code.

---

## Prerequisites

Before Day 1, make sure you have:

| Requirement | Notes |
|-------------|-------|
| **VS Code** | [code.visualstudio.com](https://code.visualstudio.com) |
| **RooCode extension** | Search "RooCode" in the VS Code Extensions panel |
| **GitHub Copilot extension** | Requires a GitHub Copilot subscription |
| **GitHub account** | [github.com](https://github.com) — needed to fork the starter repo |
| **Figma account** | [figma.com](https://figma.com) — used for reference design files |
| **Node.js 18+** | [nodejs.org](https://nodejs.org) — for running scripts |

---

## 2-Day Schedule

### Day 1 — Analyze, Plan & Design (2 hours)

| Time | Activity | Duration |
|------|----------|----------|
| 0:00 | **Intro & Foundations** — What is a harness? Agent = Model + Harness. The 6 components. | 20 min |
| 0:20 | **App Showcase** — Facilitator presents 5 AI apps for groups to choose from | 10 min |
| 0:30 | **Group Selection** — Groups of 3–4 choose their app | 5 min |
| 0:35 | **Breakout 1: Reverse-Engineer** — Analyze your chosen app. Map its agent behaviors, tools, and constraints against the 6 harness components | 25 min |
| 1:00 | *(5 min buffer / short break)* | 5 min |
| 1:05 | **Breakout 2: Design the Architecture** — Translate what you found into a harness blueprint. Map behaviors to harness components | 25 min |
| 1:30 | **Breakout 3: Start Building** — Create your AGENTS.md, first tool definition, and system prompt | 25 min |
| 1:55 | **Regroup & Share** — Each group shares progress, surprises, and one open question | 10 min |

**Day 1 Deliverable:** A harness blueprint document + skeleton file structure in the `harness-template/` starter

---

### Day 2 — Build, Test & Present (2 hours)

| Time | Activity | Duration |
|------|----------|----------|
| 0:00 | **Recap & Refine** — Review Day 1 harnesses. Facilitator shares common patterns seen | 15 min |
| 0:15 | **Extended Build Session** — Complete your harness: fill in all 6 components, write tool descriptions, finish prompts | 45 min |
| 1:00 | **Test with RooCode/Copilot** — Load your harness into VS Code and test it against a real scenario | 30 min |
| 1:30 | **Group Presentations** — Each group presents: what they built, key design decision, one thing they'd change | 20 min |
| 1:50 | **Wrap-Up & Takeaways** — Key principles, essential reading, what's next | 10 min |

**Day 2 Deliverable:** A working harness folder that RooCode/Copilot can use + a 3-minute presentation

---

## Repo Structure

```
agentic-harness-engineering/
│
├── Agentic Harness Engineering.html   # 22-slide presentation deck
├── deck-stage.js                      # Custom slide player
├── index.html                         # Deck launcher
│
├── exercises/
│   ├── ai-apps/                       # 5 AI app profiles for reverse-engineering
│   │   ├── 01-cursor.md
│   │   ├── 02-v0-vercel.md
│   │   ├── 03-bolt-new.md
│   │   ├── 04-figma-ai.md
│   │   └── 05-claude-artifacts.md
│   │
│   ├── harness-template/              # Starter harness — groups fork this
│   │   ├── AGENTS.md
│   │   ├── config.json
│   │   ├── tools/
│   │   │   └── sample-tool.json
│   │   ├── scripts/
│   │   │   ├── build.sh
│   │   │   └── test.sh
│   │   ├── prompts/
│   │   │   └── system-prompt.md
│   │   ├── hooks/
│   │   │   └── pre-tool.sh
│   │   └── memory/
│   │       └── knowledge-base.md
│   │
│   └── breakout-guides/               # Facilitator + participant guides
│       ├── breakout-1-reverse-engineer.md
│       ├── breakout-2-design-harness.md
│       └── breakout-3-build-harness.md
│
└── reference/                         # Reference materials
    ├── harness-anatomy.md
    ├── best-practices.md
    ├── agents-md-guide.md
    ├── roocode-tips.md
    └── glossary.md
```

---

## Setup Instructions

### 1. Fork & Clone

```bash
# Fork this repo on GitHub, then clone your fork
git clone https://github.com/YOUR_USERNAME/agentic-harness-engineering.git
cd agentic-harness-engineering
```

### 2. Open the Presentation

Open `index.html` in your browser. Use arrow keys or spacebar to advance slides.

### 3. Set Up Your Harness Workspace

Each group should copy the template into their own working folder:

```bash
cp -r exercises/harness-template/ my-harness/
cd my-harness/
```

### 4. Connect RooCode

1. Open the `my-harness/` folder in VS Code
2. RooCode reads your `AGENTS.md` automatically when it's in the workspace root
3. Test with: open RooCode panel → new task → describe what you want your agent to do

### 5. Connect GitHub Copilot

1. Open VS Code Command Palette (`Cmd/Ctrl + Shift + P`)
2. Search for "Copilot: Open Instructions File"
3. Point it to your `prompts/system-prompt.md`

---

## Key Concepts

**Agent = Model + Harness**
The model (Claude, GPT-4o, etc.) is just the intelligence. The harness is everything else: the instructions, tools, memory, orchestration, and feedback loops that make it actually useful.

**The 6 Harness Components**
1. System Prompt & Instructions
2. Tools, Skills & MCPs
3. Infrastructure & Sandbox
4. Orchestration Logic
5. Hooks & Middleware
6. Feedback Loops

See [reference/harness-anatomy.md](reference/harness-anatomy.md) for the full breakdown.

---

## Essential Reading

- `reference/harness-anatomy.md` — Full anatomy of a harness
- `reference/agents-md-guide.md` — How to write AGENTS.md files
- `reference/roocode-tips.md` — RooCode-specific tips
- `reference/best-practices.md` — Principles from Anthropic, OpenAI, and Addy Osmani
- `reference/glossary.md` — Key terms

---

## Facilitator Notes

- **Group size:** 3–4 people per group. Aim for 4–6 groups total.
- **App assignments:** Let groups self-select their app from the 5 profiles in `exercises/ai-apps/`
- **Whiteboards:** Encouraged for Breakout 2 (architecture design)
- **Common sticking point:** Groups often want to start with the tech. Redirect them: *"Start with the user intent, then ask: what should the harness enforce vs. what should the model decide?"*
- **Breakout timing:** The 25-minute breakouts are tight by design. Incomplete is fine — the goal is forcing decisions, not perfect execution.

---

*Workshop by Kingler Bercy · 2026*
