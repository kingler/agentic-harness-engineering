# Breakout Session 3: Start Building Your Harness

**Duration:** 25 minutes  
**Day:** Day 1  
**Format:** Same groups — now at keyboards

---

## Your Goal

Translate your Breakout 2 blueprint into actual harness files. By the end of this session, you'll have a working starter harness: real files that RooCode and GitHub Copilot can read, with your actual design decisions in them — not just template placeholders.

You won't finish everything. That's by design. The goal is to make real decisions in real files, not to have a polished harness. Day 2 is for completing and testing.

---

## Before You Start

You need:
- [ ] Your Breakout 2 blueprint (decisions for all 6 components)
- [ ] A copy of the harness template in your own folder
- [ ] VS Code open with the folder in the workspace

**Copy the template now (pick one):**

```bash
# Option A — UXD spec harness (fully worked example)
cp -r exercises/sample-harness-uxd-specs/ my-harness-[group-name]/

# Option B — slimmer template folder in repo root
cp -r harness-templates/ my-harness-[group-name]/
cd my-harness-[group-name]/
```

Use the structure you see in that folder (see `README.md` inside the template). If you used **sample-harness-uxd-specs**, you already have `prompts/`, `tools/`, `hooks/`, and `knowledge/`.

---

## Priority Order

Work in this order. The top items have the highest impact. Stop wherever you are at 25 minutes — having a great AGENTS.md and system prompt is more valuable than rushing through all files at a shallow level.

**Must-have (do this first):**
1. Fill in `AGENTS.md`
2. Write `prompts/system-prompt.md`

**Important (do this second):**
3. Rename and fill in at least one tool in `tools/`
4. Update `config.json`

**Nice-to-have (do this if you have time):**
5. Set up one hook in `hooks/pre-tool.sh`
6. Fill in `memory/knowledge-base.md`

---

## Step 1 — Write AGENTS.md (8–10 min)

This is the most important file. Open `AGENTS.md` and fill in every section. Replace all `[TODO]` and `[bracket]` placeholders with your actual decisions from Breakout 2.

**AGENTS.md quick checklist:**
- [ ] Agent name and one-sentence purpose
- [ ] Capabilities list (3–5 specific things it can do)
- [ ] Tools table (from your Breakout 2 tool decisions)
- [ ] Always do / Never do rules (from your system prompt + hook decisions)
- [ ] Context & memory section (what it knows and remembers)
- [ ] Escalation rules (what to do when it hits its limits)

**Writing tip for rules:** Be specific.  
- Bad: "Always be helpful"  
- Good: "Always ask one clarifying question before analyzing a file over 5MB"

**Writing tip for capabilities:**  
- Bad: "Can analyze design files"  
- Good: "Can read design-token manifest JSON files and compare token names against our naming convention dictionary"

---

## Step 2 — Write the System Prompt (5–7 min)

Open `prompts/system-prompt.md`. This is what the model reads at the start of every conversation.

**Key sections to fill in:**
1. **Identity paragraph** — who is this agent, what is its purpose
2. **How it works** — the 3–5 step pattern it should follow
3. **Rules** — the 3–5 non-negotiable constraints
4. **When things go wrong** — specific instructions for each failure mode

**System prompt writing principles:**
- Write it like instructions for a brilliant contractor who doesn't know your project
- Specific beats vague. "When the file path is not in the `/data` directory, refuse and explain why" beats "only access allowed files"
- Rules that say "never" must be backed by a hook — or the model will eventually forget them
- Keep the whole prompt under 800 words. Long prompts reduce model performance.

**Quick template:**
```markdown
You are [Name], an AI assistant for [purpose].

You work with [user type] to [outcome].

## How you work
1. [Step 1]
2. [Step 2]
3. [Step 3]

## Rules
- Never [most important constraint]
- Always [most important behavior]
- When uncertain, [what to do]

## Background
[3–5 sentences of domain knowledge the agent needs]
```

---

## Step 3 — Define Your First Tool (5 min)

Open `tools/sample-tool.json`. Rename it to match your first tool. Fill it in.

The most important field is **`description`** — this is what the model reads when deciding whether to use this tool. Write it like you're explaining the tool to a smart person who has never seen it.

**Good description pattern:**
1. What the tool does (verb phrase)
2. When to use it (triggering condition)
3. When NOT to use it (boundary)

**Example:**
```json
{
  "name": "compare_token_names",
  "description": "Compares component names in a design-token export file against the approved design token dictionary. Use this when the user asks to audit, review, or validate design file naming. Do NOT use for general file reading — only for naming convention comparisons.",
  ...
}
```

**Fill in:**
- `name` — snake_case verb phrase
- `description` — see above
- `parameters` — what inputs does it need? (file path? search query? filter?)
- `returns` — what does it give back?

---

## Step 4 — Update config.json (2–3 min)

Open `config.json` and update the top section:

```json
"harness": {
  "name": "your-harness-name",
  "version": "0.1.0",
  "description": "One sentence",
  "author": "Your Name"
}
```

Update the `tools.definitions` array to point to your renamed tool file.

Set `model.primary` to the right model:
- Fast/cheap tasks → `claude-haiku-4-5-20251001`
- Smart/complex tasks → `claude-sonnet-4-6`
- Most powerful → `claude-opus-4-7`

---

## Step 5 — Run the Build Check (1 min)

```bash
chmod +x scripts/build.sh
./scripts/build.sh
```

Fix any errors. Warnings are okay for now.

---

## What to Save for Day 2

If you have time remaining, note these for tomorrow's build session:

- **Hook to implement:** Which of your "never" rules needs a code-enforced hook?
- **Memory to populate:** What domain knowledge should be in `memory/knowledge-base.md`?
- **Test scenario:** What's the simplest possible prompt you'd give this agent to test it?

---

## Deliverable

At the end of this session, your group should have:

- [ ] `AGENTS.md` — filled in with real decisions (no TODO placeholders in Identity, Capabilities, Rules)
- [ ] `prompts/system-prompt.md` — at minimum: identity, rules, and 1 failure mode
- [ ] At least 1 tool in `tools/` with a real name and description
- [ ] `./scripts/build.sh` passing (or warnings only)

---

## When the Regroup Happens

When the facilitator calls time, be ready to share:

1. **What your agent does** (1 sentence)
2. **The rule you're most proud of** in your AGENTS.md
3. **The one open question** you want to solve on Day 2

---

## Facilitation Notes (for the room facilitator)

**If groups are stuck on AGENTS.md:** "Start with 'Never do' — what is the one thing this agent must absolutely never do? Write that first."

**If groups are writing perfect prose:** "Don't polish — make decisions. You can refine the writing on Day 2."

**If groups are skipping to tools first:** "AGENTS.md and system prompt first — tools only work if the model has good instructions about when to use them."

**If groups want to add more features mid-session:** "Write it down for Day 2. Scope lock is a feature, not a limitation."

**The most common mistake:** Writing tool descriptions as "reads files" instead of "reads design token JSON files from the /data directory when the user asks to review or compare naming conventions." Push for specificity.

**RooCode tip to share:** Once your AGENTS.md is in the folder root, open RooCode in VS Code and it'll pick it up automatically. You don't need to configure anything else to start testing.
