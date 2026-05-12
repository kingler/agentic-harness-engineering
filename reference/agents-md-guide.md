# How to Write Effective AGENTS.md Files

AGENTS.md is the primary way to give persistent, project-level instructions to an AI agent. It's the most important file in your harness — everything else is plumbing.

RooCode reads `AGENTS.md` automatically when it's in the workspace root. GitHub Copilot uses a similar concept with "instructions files." The principles apply to both.

---

## What AGENTS.md Is

**AGENTS.md is:** A persistent system prompt that travels with your project.

It tells the agent:
- WHO it is (identity, purpose, audience)
- WHAT it can do (capabilities, tools available)
- HOW it should behave (rules, tone, output format)
- WHAT it must never do (hard constraints)

It is not:
- Documentation for humans (though it can be read by humans too)
- A feature wishlist
- A place for nice-to-haves ("try to be helpful")

---

## The Golden Rule

**Write every rule as if you're instructing someone who will follow it exactly, literally, and without common sense filling in the gaps.**

The model is not going to infer intent. "Be helpful" means nothing. "When the user asks for a file analysis, always present findings as a numbered list with a severity label (High / Medium / Low) on each item" is a real instruction.

---

## Structure

A good AGENTS.md has these sections in this order:

### 1. Identity (required)

A short, specific description of what this agent is and does.

**Bad:**
```markdown
# My AI Assistant
This is an AI assistant that helps with design tasks.
```

**Good:**
```markdown
# Design Token Auditor

You are a Design Token Auditor — an AI assistant for the Acme design system team.

Your purpose is to review exported design component manifests and flag naming inconsistencies 
against the approved token dictionary in `memory/tokens.json`.

Primary users: Product designers who own components in the Acme design system.
```

---

### 2. Capabilities (required)

A specific list of what the agent can do. Not what you *want* it to do — what it is *actually configured* to do.

**Bad:**
```markdown
## Capabilities
- Helps with design tasks
- Can analyze files
- Generates reports
```

**Good:**
```markdown
## Capabilities
- Read and parse structured export JSON files from the `/exports` directory
- Compare component and token names against the approved naming dictionary
- Generate a Markdown inconsistency report with severity labels
- Suggest corrected names that comply with naming conventions
- Flag any component missing required token references (color, spacing, typography)
```

Each capability maps to one or more tools. If you've listed a capability but haven't defined the tool that enables it, the agent will try to improvise — usually badly.

---

### 3. Tools Available (required)

A table of the tools the agent can use, with key metadata.

```markdown
## Tools Available

| Tool | What it does | Confirmation required? |
|------|-------------|----------------------|
| `read_export_file` | Reads an export JSON bundle from /exports | No |
| `compare_tokens` | Compares names against the token dictionary | No |
| `generate_report` | Writes a Markdown report to /output | No |
| `flag_component` | Marks a component as non-compliant in the tracker | **Yes** |
```

The "Confirmation required?" column is critical. Use it for anything irreversible or externally visible.

---

### 4. Behavior Rules (required)

This is the heart of the file. Rules fall into three categories:

**Always do:** Behaviors the agent should exhibit in every interaction.
**Never do:** Hard constraints the agent must not violate.
**When uncertain:** What to do when the agent doesn't know what to do.

**Writing rules that actually work:**

| Don't write | Write instead |
|------------|---------------|
| "Be professional" | "Use plain language. No jargon unless the user uses it first." |
| "Be careful with files" | "Never write to any directory other than `/output`. If a path points elsewhere, refuse and explain." |
| "Ask if unclear" | "If the user's request could mean two different things, ask one clarifying question before proceeding. Never ask more than one question at a time." |
| "Don't do anything harmful" | "Never delete files. If cleanup is needed, move to `_archive/` and notify the user with the new path." |

**The specificity test:** Read each rule out loud. If you could interpret it two different ways, it's not specific enough.

---

### 5. Context & Memory (recommended)

Tell the agent what it has access to and what it should remember.

```markdown
## Context & Memory

### Available at the start of every session
- Token dictionary: `memory/tokens.json` (auto-loaded)
- Team conventions: `memory/knowledge-base.md` (auto-loaded)
- Design library exports: accessible via `read_export_file` tool

### Remembered within a session
- Files already analyzed (don't re-analyze unless asked)
- User's preferred report format (ask once, remember for session)

### Not retained between sessions
- Conversation history
- Temporary analysis notes
```

---

### 6. Output Format (recommended)

Define what the agent's responses should look like.

```markdown
## Output Format

For short answers: 2–3 sentences max. No headers.

For reports:
```
## Summary
[1–2 sentences: total issues found, severity distribution]

## Issues (sorted by severity)
### High — [count]
- **ComponentName:** [what's wrong] → Suggested fix: [corrected name]

### Medium — [count]
...

## Recommendations
[Numbered list, most impactful first]
```

Always use fenced code blocks for JSON or code output.
```

---

### 7. Escalation & Limits (recommended)

What does the agent do when it can't do what the user asked?

```markdown
## When I Can't Help

- "I can't access that file, but I can [nearest alternative]."
- "That's outside what I'm configured to do. Here's who can help: [specific escalation]."
- "I'm not confident enough in this result to act on it. Here's what I found and why I'm uncertain: [details]"
```

---

## Length Guidelines

| Section | Target length |
|---------|--------------|
| Identity | 3–5 sentences |
| Capabilities | 4–7 bullet points |
| Tools table | One row per tool |
| Behavior rules | 5–10 rules total across all categories |
| Context & memory | 5–10 lines |
| Output format | 5–15 lines |
| Escalation | 3–5 rules |

**Total AGENTS.md length:** 300–700 words. Longer files reduce model performance.

---

## Common Mistakes

### 1. Rules that require context the model doesn't have

```markdown
❌ "Always follow our design system guidelines."
```

The agent doesn't know what your design system guidelines are unless you tell it — either in the AGENTS.md, the system prompt, or the memory file.

```markdown
✓ "Always use the naming conventions in memory/tokens.json when suggesting fixes."
```

---

### 2. Soft rules for hard requirements

```markdown
❌ "Try not to write to files outside the /output directory."
```

"Try not to" means the agent will sometimes do it anyway. For hard requirements, use a hook — not a soft instruction.

```markdown
✓ "Never write to any directory other than /output."
  (And back this up with a pre-tool hook that checks file paths)
```

---

### 3. Capabilities without tools

```markdown
❌ Capabilities: "Can generate a PDF report of findings"
   Tools: [no PDF tool defined]
```

The agent will try to improvise PDF generation using available tools, usually poorly.

---

### 4. Omitting the negative space

Most AGENTS.md files define what the agent *can* do. The most important thing to define is what it *can't* or *won't* do. This is where you establish trust.

```markdown
✓ ## What I Won't Do
- Access files outside /exports and /output
- Send data to external services without explicit user request
- Delete or rename files — only generate reports about them
- Claim confidence I don't have — I'll always state my uncertainty level
```

---

## Testing Your AGENTS.md

After writing your AGENTS.md, test it by asking the agent:

1. **The golden path:** Does it handle the primary use case correctly?
2. **The edge case:** Does it handle an ambiguous request correctly?
3. **The boundary:** Does it refuse an out-of-scope request and explain why?
4. **The failure:** What does it do when a tool fails?

If any of these produce unexpected behavior, revise the relevant rule or capability description.

---

## Multi-File AGENTS.md (Advanced)

For complex harnesses, you can have multiple AGENTS.md files:

```
project/
├── AGENTS.md          # Global rules (applies everywhere)
├── analysis/
│   └── AGENTS.md      # Rules specific to the analysis workflow
└── reporting/
    └── AGENTS.md      # Rules specific to the reporting workflow
```

RooCode applies the most specific AGENTS.md for the current working directory, falling back to parent directories. Use this pattern when different parts of your harness have genuinely different behavior requirements.
