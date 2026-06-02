# Setup & pre-flight — do this before the breakouts

Five minutes now saves you a broken breakout later. The harness tests fail by
design if the model never actually runs — so the #1 thing to confirm up front is
**model access**.

## 1 · Install

- [ ] **VS Code** (latest).
- [ ] **One** extension — pick your lane:
  - **GitHub Copilot** — sign in with a GitHub account that has Copilot enabled.
  - **Roo Code / DevGPT** — install from the marketplace and add a model API key
    in its settings.
- [ ] Unzip `app-build-template.zip` and open the folder as your **workspace
  root** (`code app-build-template`).

## 2 · Confirm the harness is seen

- [ ] Open the chat panel. Your extension should auto-load `AGENTS.md` plus its
  folder (`.github/` for Copilot, `.roo/` for Roo). Slash commands appear when
  you type `/` — you should see `plan-app`, `bootstrap-harness`, `test-harness`.

## 3 · Model-access smoke test (the important one)

Paste this into the chat and send it:

> **"Reply with exactly: HARNESS OK — then say which model you are."**

- [ ] You get a reply containing `HARNESS OK`. ✅ You're ready.

If you **don't** get a reply, fix it before the breakout — not during:

| Symptom | Editor | Fix |
|---|---|---|
| "Sign in to use Copilot" / no completions | Copilot | Re-auth: Command Palette → *GitHub Copilot: Sign In*; confirm your seat is active. |
| "No API key" / "model not configured" | Roo / DevGPT | Settings → add a provider API key (Anthropic/OpenAI/etc.); pick a model. |
| Chat replies but `/` shows no commands | both | You didn't open the folder as the **workspace root** — reopen `app-build-template/` directly. |
| Corporate network blocks the model | both | Try a personal network / hotspot, or ask the facilitator for the shared fallback key. |

## 4 · One quick tool check (optional but nice)

```bash
bash .github/hooks/pre-tool-use.sh <<< '{"tool_name":"noop","tool_input":{}}'
# → {"decision":"approve"}
```

If that prints a decision, your shell + `jq` are working, so the hook layer will
run. (`jq` not found? `brew install jq` / `apt-get install jq`.)

## 5 · Know your lane

Read [`EDITOR-PARITY.md`](./EDITOR-PARITY.md) — a one-screen matrix of what
Copilot vs Roo can demo natively (especially hooks), so nothing surprises you
mid-lab.

---

**Done with all checkboxes?** Open [`PROGRESS.md`](./PROGRESS.md) and start
Lab 1. The build order and what each step sets up is in
[`SEQUENCE.md`](./SEQUENCE.md).
