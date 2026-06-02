# Editor parity — what Copilot vs Roo can demo natively

Same harness anatomy, two wirings. This matrix tells you what each extension
reads and where the marquee "blocked by a hook" moment behaves differently, so
nothing surprises you mid-lab.

| Component | GitHub Copilot | Roo Code / DevGPT |
|-----------|----------------|-------------------|
| System prompt | `AGENTS.md` + `.github/copilot-instructions.md` (auto) | `AGENTS.md` + `.roo/rules/` (auto) |
| Rules | `.github/instructions/*.instructions.md` (`applyTo`) | `.roo/rules/*.md` |
| Skills | `.github/skills/<name>/SKILL.md` (native) | **no native skills** → expressed as a command in `.roo/commands/` |
| Hooks | `.github/hooks/` — newer/experimental; bind in Copilot hooks config | **no native hooks** → run the same `.github/hooks/*.sh` as a shell guard or pre-commit |
| Tools | MCP (`.vscode/mcp.json`) + scripts in `tools/scripts/` | MCP (`.roo/mcp.json`) + scripts |
| MCP | `.vscode/mcp.json` (`servers` key) | `.roo/mcp.json` (`mcpServers` key) |
| Knowledge | `knowledge/` via `#knowledge/...` | `knowledge/` via `@knowledge/...` |
| Slash commands | `.github/prompts/*.prompt.md` | `.roo/commands/*.md` |

## The one gap to plan around: hooks

The headline demo is "directly ask for the nightmare-failure action → it's
**blocked by the hook**, even under an 'I'm the admin' retry." How you show it:

- **Copilot:** if your build exposes hooks, bind `.github/hooks/pre-tool-use.sh`
  and let it fire on the tool call. If hooks aren't available in your build yet,
  use the fallback below.
- **Roo / DevGPT (and Copilot fallback):** run the hook as a **standalone
  guard** to prove the predicate, then show the rule in `.roo/rules/` /
  `AGENTS.md` that calls for it:

  ```bash
  echo '{"tool_name":"<your_tool>","tool_input":{ ... }}' | .github/hooks/pre-tool-use.sh
  ```

Either way the *enforcement logic is identical and portable* — the artifact is a
`{"decision":"block","reason":"…"}` record. What differs is only whether the
editor fires it automatically or you invoke it as a guard. Say which one you're
demoing so the room reads it correctly.

## Rule of thumb

If a component has "no native …" above, you keep the **file** (so the anatomy
reads the same) and wire the behavior the editor's way. The harness contract is
portable; the plumbing isn't.
