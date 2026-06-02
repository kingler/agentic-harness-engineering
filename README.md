# Agentic Harness Engineering

Workshop materials for a 2-day course on building agent harnesses — the
persona, rules, tool palette, hooks, and MCP servers that wrap a coding
agent and make it useful for a specific job.

## What's in this repo

```
.
├── start.html                       # landing page — links to the decks + hands-on materials
├── Agentic Harness Engineering.html # current workshop deck (the 2-day course)
├── index.html                       # earlier "Anatomy" deck (kept for reference)
├── deck-stage.js                    # presenter staging script
├── exercises/                       # setup, lab cards, app build template, worked example
├── harness-templates/               # starter scaffold attendees copy & edit
└── .context/                        # project status notes for agents
```

- **Presentation** — open `start.html` for the landing page. The current
  workshop deck is `Agentic Harness Engineering.html`; `index.html` is an
  earlier deck on harness anatomy, kept for reference.
- **`harness-templates/`** — copy this directory into a new repo, rename
  to `harness/`, and edit every file. See
  [`harness-templates/README.md`](./harness-templates/README.md) for the
  per-file walkthrough and the workshop instructions.

## Workshop structure

Day 1 covers the anatomy of a harness (persona, scope, rules, tools,
hooks, MCP). Day 2 is hands-on: groups reverse-engineer one of five
non-coding AI products (Harvey, Spellbook, Pilot, Notion AI, Granola)
and rebuild its harness using the templates here.

The same harness shape works across GitHub Copilot and
RooCode — the templates ship a mirrored configuration for all three so
attendees can see the contract is portable.

## Quick start

Open `start.html` in a browser for the landing page (or
`Agentic Harness Engineering.html` directly for the current deck), or copy
`harness-templates/` into a fresh repo to start a new harness:

```sh
cp -r harness-templates ../my-harness && cd ../my-harness
```

Then follow the steps in [`harness-templates/README.md`](./harness-templates/README.md).

For a local server (mermaid diagrams need module loading, which `file://`
blocks):

```sh
python3 -m http.server 8000
# open http://localhost:8000/
```

## Deploy to Vercel

The deck is plain static HTML and ships with a `vercel.json`, so it
deploys with no build step.

1. Open <https://vercel.com/new>.
2. **Import Git Repository** → pick `kingler/agentic-harness-engineering`.
3. Framework preset: **Other** (auto-detected).
4. Leave build command empty.
5. **Deploy.**

`vercel.json` sets `cleanUrls: true`, no-cache for HTML, and one-year
immutable cache for static assets.

## Ground rules (from the workshop)

- Keep `AGENTS.md` under 200 lines.
- Cap tools at 7.
- Tool descriptions are UX copy for the model.
- Anything that should happen "every time" belongs in a hook, not a
  prompt.
- Read 5 transcripts before changing a single tool description.
