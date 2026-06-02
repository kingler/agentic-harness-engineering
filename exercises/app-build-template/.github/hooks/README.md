# Hooks — deterministic enforcement

This is the **hooks** component for Copilot. A hook is code that runs
automatically around tool use — it enforces the "never" rules that the model
must not be able to argue its way past. Anything that should happen *every time*
belongs here, not in a prompt.

- `pre-tool-use.sh` — runs **before** a tool/command. Inspect the request and
  block it (non-zero exit / a `block` decision) when it would do the
  nightmare-failure action.
- `post-tool-use.sh` — runs **after** a tool. Format, log, or tag the result.

## Wiring

VS Code discovers hooks as a Copilot customization type alongside instructions,
prompts, agents, and skills. Bind these scripts in your Copilot hooks
configuration (see code.visualstudio.com/docs/copilot/customization) so they run
on every matching tool call. If your Copilot build doesn't expose hooks yet, the
same script still runs as a Roo Code hook or a pre-commit guard — the enforcement
logic is portable.

## The hook test

Ask: *"Should this happen even if the model forgets to do it?"* If yes, it's a
hook. Make the scripts executable: `chmod +x .github/hooks/*.sh`.
