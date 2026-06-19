# Copilot feature screenshots — capture & swap-in guide

The breakout pages (`breakouts/component-*.html`) and the main deck
(`Agentic Harness Engineering.html`) ship with **vector mockups** of the
GitHub Copilot UI for each harness component. They render crisply and need
no license to view. When you have time at a machine with Copilot enabled,
capture the real screens and swap them in — every slot is one line.

## How to swap a mockup for a real screenshot

Each figure is marked with a `SWAP-IN` HTML comment. Replace the
`<div class="vsc"> … </div>` block with an `<img>` pointing at the PNG:

```html
<!-- breakout pages -->
<img src="../assets/copilot-create-agent.png" alt="Creating a custom agent in GitHub Copilot">

<!-- main deck -->
<img class="vsc-img" src="assets/copilot-create-agent.png" alt="Creating a custom agent in GitHub Copilot">
```

Keep the surrounding `<figure>` / `<figcaption>` so the caption stays.

## Filenames the slides already reference

| File | Component | What to capture (VS Code + Copilot) |
|------|-----------|--------------------------------------|
| `copilot-create-agent.png`      | System prompt | `.github/agents/<name>.agent.md` open in the editor + the **agent picker dropdown** in Copilot Chat showing your custom agent. Reach it via **⚙ Configure Chat → Agents → New custom agent** (or `/create-agent`). |
| `copilot-create-skill.png`      | Skills | `.github/skills/<name>/SKILL.md` with its `scripts/ references/ assets/` siblings in the Explorer + a chat turn showing **“Used skill: <name>.”** |
| `copilot-tools-mcp.png`         | Tools | `.vscode/mcp.json` in the editor + the **🛠 Tools picker** in the chat input listing the MCP server's tools (some toggled on/off). |
| `copilot-rules-hooks.png`       | Rules & Hooks (breakout) | A `*.instructions.md` with an `applyTo:` glob + the `.github/hooks/` folder, and a chat turn where a denied call is **blocked by the hook**. |
| `copilot-instructions.png`      | Rules (deck) | `.github/instructions/<name>.instructions.md` with `applyTo:` + the always-on `copilot-instructions.md`. |
| `copilot-hooks.png`             | Hooks (deck) | `.github/hooks/pre-tool-use.sh` + `hooks.json`, and the chat showing **⛔ Blocked by hook**. |
| `copilot-knowledge-memory.png`  | Knowledge & Memory | A `knowledge/*.md` pulled into a turn with `#`, a gitignored `memory/SESSION.md`, and a **Copilot Memory** save notice. |

## Capture tips

- Use the **dark** VS Code theme so the screenshot matches the mockup tone.
- Crop tight to the relevant panels (Explorer + editor + Chat). ~1280–1600 px wide reads well at slide scale.
- Reference docs: VS Code → *Customize AI* (`code.visualstudio.com/docs/agent-customization/overview`);
  GitHub → *Copilot customization* (`docs.github.com/en/copilot`).
