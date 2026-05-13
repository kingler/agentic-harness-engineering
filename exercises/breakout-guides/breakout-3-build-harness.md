# Breakout Session 3: Start Building Your Harness

**Duration:** 25 minutes
**Day:** Day 1
**Format:** Same groups as Breakout 2 — now at keyboards

---

## Your Goal

Translate your Breakout 2 blueprint into actual harness files. You'll
use the `/scaffold-harness` slash command shipped in the workshop
template to interview your group and generate the first cut: an
`AGENTS.md`, the cross-surface mirrors, a first tool stub, and a smoke
eval case.

By the end of the session you should have a harness that loads in
GitHub Copilot **and** in RooCode / Cline, plus a single test prompt
you've actually run against it.

You will not finish everything — that's by design. Day 2 is for hooks,
memory, and the second tool. Today is about turning decisions into
files and getting one real signal back from the agent.

---

## Before You Start (2 min)

You need:
- [ ] Your Breakout 2 blueprint (decisions for all 6 components)
- [ ] VS Code open with GitHub Copilot Chat **or** RooCode / Cline
- [ ] One person at the keyboard; the other 2–3 dictating decisions
- [ ] A copy of `harness-templates/` in your own folder

**Copy the template:**

```bash
cp -r harness-templates/ my-harness-<group-name>/
cd my-harness-<group-name>/
git init && git checkout -b wkshp/<group-name>/scaffold
```

Open the folder in VS Code. You should see roughly this layout:

```
my-harness-<group-name>/
├── AGENTS.md                            # main brief — Copilot agent + RooCode read this
├── mcp.json                             # external tool servers
├── memory/SESSION.md                    # cross-session memory
├── knowledge/                           # domain knowledge (markdown)
├── evals/cases/smoke.json               # example eval case
├── scripts/run-eval.sh                  # eval runner tool
├── .github/
│   ├── copilot-instructions.md          # Copilot repo-wide brief
│   ├── instructions/                    # path-scoped rules
│   ├── prompts/                         # slash commands (incl. /scaffold-harness)
│   ├── agents/                          # custom subagents
│   └── hooks/                           # pre/post tool-use hooks
└── .roo/rules/01-project.md             # RooCode / Cline workspace rule
```

---

## Step 1 — Run `/scaffold-harness` (8–10 min)

The template ships a slash command that interviews your group and
generates the initial harness component in one pass. Use it **before**
hand-editing anything — that's the fastest path to a coherent first
draft.

**To invoke it:**

- **Copilot Chat (VS Code / JetBrains / GitHub.com):**
  type `/scaffold-harness` in the chat panel.
- **RooCode / Cline (VS Code):** open
  `.github/prompts/scaffold-harness.prompt.md`, then in chat say
  "Run this prompt." Cline and RooCode both read `.github/prompts/`.

The agent will ask **seven questions, one at a time**. Designate one
group member as the **typist** and one as the **scribe** (keeps notes
on which Breakout 2 decision each answer maps to). The other 1–2
people debate and propose answers.

### The seven questions you will be asked

| # | Question | Pull this from your Breakout 2 blueprint |
|---|---|---|
| 1 | Agent name + one-sentence purpose | Decision 1 (system prompt persona) |
| 2 | Golden path in 3 steps (X → Y → Z) | Step 1 of Breakout 2 |
| 3 | Nightmare failure mode (one sentence) | Step 1 of Breakout 2 |
| 4 | One absolute "never" (specific path / command / domain) | Decision 5 (hooks) |
| 5 | Sandbox boundary (where it can write, what's blocked) | Decision 3 (infrastructure) |
| 6 | First tool: verb name + what / when / when-NOT | Decision 2 (tools) |
| 7 | Smoke test prompt + one must-include + one must-not-include | Decision 6 (feedback) |

**Answer rules of thumb:**

- **Specific beats vague.** "Reviews Figma exports against our design
  token system for product designers" beats "helps designers".
- **No idk's.** If you don't know, the command will offer 2–3 concrete
  options. Pick one. You can change it on Day 2.
- **The 'never' must be testable.** "Never write to `/etc/`" is
  testable. "Always be helpful" is not.

After question 7, the command will replay all seven answers and ask
**"Generate the five files? (yes / edit N)"**. Edit any answer you got
wrong before you say `yes`.

### What gets generated

In one pass, the command writes (or rewrites the `{{placeholder}}`
slots in) these five files:

1. **`AGENTS.md`** — persona + scope + hard rules + tool palette.
2. **`.github/copilot-instructions.md`** — mirror of persona + hard
   rules. Loaded automatically by Copilot for every chat turn.
3. **`.roo/rules/01-project.md`** — mirror of hard rules for RooCode
   / Cline.
4. **`scripts/<tool-name>.sh`** — executable stub for your first tool
   (prints JSON on stdout, ready to wire up).
5. **`evals/cases/smoke-<tool-name>.json`** — one eval case derived
   from your Q7 answer.

The command stops after generating. It does **not** commit, push, or
run the eval. You drive the next step.

---

## Step 2 — Read every generated file (3 min)

Before you test anything, **read the five files the command wrote**.
This is the most important quality check in the session.

Open them in this order and check for one thing each:

| File | What to check for |
|---|---|
| `AGENTS.md` | The persona sentence reads like a real product, not a template. The "never" rule is specific enough to enforce. |
| `.github/copilot-instructions.md` | Persona and hard rules match `AGENTS.md` word-for-word. |
| `.roo/rules/01-project.md` | Hard rules match. |
| `scripts/<tool>.sh` | Tool name is a verb phrase. Description says when **not** to use it. |
| `evals/cases/smoke-<tool>.json` | `must_include` and `must_not_include` are real signals, not placeholders. |

If anything looks off, **fix it by hand** — the scaffold is the first
draft, not the final word. The two highest-leverage edits at this stage
are: (a) tightening the persona sentence in `AGENTS.md`, and (b)
making the tool description name a specific *trigger condition*.

---

## Step 3 — Test the harness with a simple prompt (5–7 min)

Now run the smoke prompt from Q7 against the live agent. This is the
first real signal you'll get back. Two things matter: did the agent
behave as scoped, and did it stay inside the rules?

**How to run it:**

- **Copilot Chat:** type or paste the Q7 prompt into chat with your
  repo open. The agent loads `.github/copilot-instructions.md` and any
  matching `instructions/*.instructions.md` automatically.
- **RooCode / Cline:** open the repo in VS Code, start a new task,
  paste the Q7 prompt.

### Example smoke prompts by app concept

If your group is stuck on what a good smoke prompt looks like, here are
five concrete examples — one per Breakout 1 app — that you can adapt:

| If your harness is inspired by… | Try this smoke prompt | Must include | Must not include |
|---|---|---|---|
| **Cursor** (AI code editor) | "Refactor the `formatDate` function in `src/utils/date.ts` to use `Intl.DateTimeFormat` instead of manual string concat. Keep the public signature." | `Intl.DateTimeFormat` | `// TODO` |
| **v0** (AI UI generator) | "Generate a pricing-table React component with 3 tiers using the design tokens in `knowledge/tokens.md`. One file, default export." | `export default` | `inline style` |
| **Bolt.new** (full-stack builder) | "Scaffold a new SvelteKit route at `/health` that returns `{ status: 'ok' }` as JSON. No new dependencies." | `+server` | `npm install` |
| **Figma AI** (design assistant) | "Review the diff: a Save button changed colour from #2A6 to #28A. Flag any contrast issues against WCAG AA." | `contrast` | `delight` |
| **Claude Artifacts** (interactive content) | "Make a single-file React Artifact that draws a sine wave on a `<canvas>`. No external libraries." | `requestAnimationFrame` | `npm install` |

Pick whichever is closest, swap in the file/domain names from your
own concept, and run it.

### What to look for in the response

Score the result against these five checks. Write a one-line note next
to each — Day 2 starts with these notes.

1. **Did it stay in scope?** (Did it try to do something outside your
   primary intent?)
2. **Did it honour the "never" rule?** (Did it try the forbidden
   action? Did it justify refusing one?)
3. **Did it use the right tool?** (Did it reach for `scripts/<tool>.sh`,
   or did it freelance with raw `Bash`?)
4. **Did the smoke eval pass?** Run:
   ```bash
   chmod +x scripts/run-eval.sh
   scripts/run-eval.sh smoke
   ```
   You should see one line of JSON with `"status":"pass"`. If not,
   read the `reason` and decide if it's a real fail or a too-strict
   `must_include`.
5. **Time-to-first-useful-output.** Was it under a minute? Over five?
   This number is your single best Day-2 baseline.

---

## Step 4 — Commit your scaffold (2 min)

Even if the harness is half-broken, commit what you have. Day 2 starts
from your committed state, and the diff between today and tomorrow is
the most useful artifact for the regroup.

```bash
git add AGENTS.md .github/ .roo/ scripts/ evals/
git commit -m "feat: scaffold initial harness for <agent-name>"
```

Do **not** push to a shared remote unless your facilitator told you
to. The scaffold is a working draft.

---

## Priority Order (if you run out of time)

You will not get through every step. Stop where you are at 25 minutes.

**Must-have (do this first):**
1. Run `/scaffold-harness` end to end (Step 1)
2. Read all five generated files (Step 2)
3. Run the smoke prompt at least once (Step 3)

**Important (do this second):**
4. Hand-edit `AGENTS.md` persona + the one "never" rule for specificity
5. Run `scripts/run-eval.sh smoke` and read the result

**Nice-to-have (Day 2 if time runs out):**
6. Fill in `knowledge/style-guide.md` with one real domain doc
7. Add a second tool stub to `scripts/`
8. Wire one hook in `.github/hooks/pre-tool-use.sh`

---

## Deliverable

At the end of this session, your group should have:

- [ ] All five generated files committed on `wkshp/<group>/scaffold`
- [ ] No `{{placeholder}}` strings left in `AGENTS.md`
- [ ] At least one smoke prompt actually run against the harness
- [ ] One line of notes per scoring check in Step 3

---

## When the Regroup Happens

When the facilitator calls time, be ready to share:

1. **Your agent's one-sentence persona** (verbatim from `AGENTS.md`)
2. **The smoke prompt you tried** and **what surprised you** about the
   response (good or bad)
3. **The one open question** you want to solve on Day 2

---

## Facilitation Notes (for the room facilitator)

**If groups skip `/scaffold-harness` and start hand-editing:**
"Run the scaffold first. You can edit anything afterwards. The
scaffold's job is to get all four surfaces consistent — it's much
faster than wiring them by hand."

**If groups can't agree on an answer mid-interview:**
The command supports `idk` — it will offer 2–3 options. Use that to
unblock; debating "the right answer" is a Day-2 problem.

**If groups write a vague "never" rule (Q4):**
Push for the path or command. "Never modify production data" is not
testable. "Never run `npm publish` or write to `dist/`" is.

**If groups skip the smoke prompt:**
This is the single most valuable 5 minutes of the session. The whole
point of Day 1 is to *get one signal back* from the live agent before
Day 2.

**If the smoke eval fails on first run:**
That's expected and good. Read the `reason` together — is the
`must_include` phrase the right signal, or did the agent give a
correct answer that didn't happen to contain the magic word? Edit the
eval case, not the agent. Evals are hypotheses, not ground truth.

**RooCode tip to share:**
Once `.roo/rules/01-project.md` is in place, RooCode picks it up
automatically. You don't need to restart the extension.

**Common mistake:** Groups treat the scaffolded files as final. Push
back: "What's the one sentence in `AGENTS.md` you'd defend to a new
hire on day one? Tighten that. Everything else can wait for Day 2."
