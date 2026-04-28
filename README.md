# Agentic Harness Engineering — Workshop

A 2-day, 2-hour-per-day workshop deck for product & UX designers who already
work in VS Code with the **RooCode** and **GitHub Copilot** extensions.

Participants reverse-engineer a real, non-coding AI product (Harvey,
Spellbook, Pilot, Notion AI, or Granola) and build a runnable agent harness
across three breakouts: **Plan → Design → Develop**. Day 2 covers hooks,
subagents, MCP, and evals, then groups wire the harness into VS Code and run
it live — the editor's AI is the runtime, since model API keys today live
inside the RooCode and Copilot extensions, not in participants' hands.

## Run locally

The deck is plain static HTML.

```bash
# any static server works
python3 -m http.server 8000
# then open http://localhost:8000/
```

Keyboard:
- `←` / `→` or `Space` — navigate
- `s` — speaker notes
- `r` — reset to first slide

## Deploy to Vercel

This repo is pre-configured for Vercel as a static site. To deploy:

1. Open https://vercel.com/new
2. **Import Git Repository** → pick `kingler/agentic-harness-engineering`.
3. Framework preset: **Other** (auto-detected).
4. Build & output: leave as defaults — there's no build step.
5. **Deploy.**

The included `vercel.json` sets clean URLs and sensible cache headers; no
other configuration is required.

## What's in the repo

```
.
├── index.html                      # the workshop deck (37 slides)
├── deck-stage.js                   # custom <deck-stage> web component
├── vercel.json                     # static-site deploy config
└── harness-templates/              # starter scaffold for Breakout 3
    ├── CLAUDE.md, AGENTS.md, mcp.json
    ├── .claude/{settings.json, skills, commands, agents, hooks}
    ├── .roo/rules/01-project.md
    └── .github/{copilot-instructions.md, instructions, prompts, agents}
```

`harness-templates/` is what participants copy into their own project as
their starting point during Day 1 · Breakout 3. It ships parallel
configurations for Claude Code, RooCode, and GitHub Copilot so the same
harness runs in any of those editor surfaces.

## Source material

- Vivek Trivedy · "The Anatomy of an Agent Harness" — blog.langchain.com
- arXiv 2603.20075 · "Agentic Harness for Real-World Compilers"
- RooCode docs — docs.roocode.com
- GitHub Copilot · custom instructions — code.visualstudio.com/docs/copilot
- Claude Code docs — code.claude.com/docs
- Model Context Protocol — modelcontextprotocol.io
