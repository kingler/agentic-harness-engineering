# RooCode Tips for Harness Engineering

RooCode is a VS Code extension that turns your editor into an agentic coding environment. Unlike GitHub Copilot (which primarily autocompletes), RooCode runs full agentic loops — it can read files, write files, run terminal commands, and chain multiple steps together to complete complex tasks.

For harness engineering, RooCode is your primary testing environment. Here's how to get the most out of it.

---

## Setup

### Install RooCode
1. Open VS Code
2. Open the Extensions panel (`Cmd/Ctrl + Shift + X`)
3. Search for "RooCode"
4. Install → Restart VS Code

### Connect to a Model
RooCode supports multiple model providers. For this workshop, use Anthropic:

1. Open RooCode panel (robot icon in the sidebar)
2. Click the settings gear
3. Select "Anthropic" as provider
4. Enter your API key
5. Select `claude-sonnet-4-6` as your model

### Point RooCode to Your Harness
RooCode automatically reads `AGENTS.md` from the workspace root. Open your harness folder in VS Code:

```
File → Open Folder → select your my-harness-[group-name]/ directory
```

Once the folder is open and contains `AGENTS.md`, RooCode will load it automatically.

---

## How RooCode Reads Your Harness

RooCode uses your AGENTS.md in a specific way:

| File | How RooCode uses it |
|------|---------------------|
| `AGENTS.md` | Injected as persistent instructions at the start of every conversation |
| `prompts/system-prompt.md` | You can reference this file in AGENTS.md for the system prompt |
| `tools/` | RooCode has its own built-in tools; you configure which ones are available per mode |
| `memory/knowledge-base.md` | You can instruct RooCode to load this file via AGENTS.md |

RooCode won't automatically load every file — you tell it what to load in AGENTS.md.

To auto-load your knowledge base, add this to AGENTS.md:

```markdown
## Context to Load at Session Start
Always begin by reading `memory/knowledge-base.md` for project context.
```

---

## RooCode Modes

RooCode has built-in "modes" that change the agent's behavior. Understanding these helps you design harnesses that work well with each.

| Mode | Best for | Key behaviors |
|------|---------|---------------|
| **Code** | Writing and editing code | Full file access, runs terminal commands, auto-applies edits |
| **Architect** | Planning and design | Read-only by default, focused on analysis and structure |
| **Ask** | Questions and explanations | Conversational, no file writes |
| **Debug** | Diagnosing problems | Reads logs, traces errors, suggests fixes |
| **Custom** | Your harness | Define your own mode behavior |

For most workshop harnesses, start with the default "Code" mode. Create a custom mode once you have a clear picture of what your agent should and shouldn't do.

### Creating a Custom Mode

In RooCode settings (`.roo/config.json` in your workspace):

```json
{
  "customModes": [
    {
      "slug": "design-auditor",
      "name": "Design Auditor",
      "roleDefinition": "You are a design token auditor. Your job is to review exported design manifests and flag naming inconsistencies.",
      "customInstructions": "Always load memory/knowledge-base.md at session start. Generate reports in /output directory only.",
      "tools": ["read_file", "write_file", "list_files"],
      "restrictedTools": ["run_command"]
    }
  ]
}
```

---

## Testing Your Harness in RooCode

### The Basic Test Sequence

1. Open RooCode panel
2. Select your mode (or default)
3. Type a test prompt that exercises your harness's primary use case
4. Watch what happens — specifically:
   - Does it use the right tool?
   - Does it ask for confirmation when it should?
   - Does it produce the right output format?
   - Does it refuse out-of-scope requests?

### Test Prompts to Try

For a design audit agent:
```
"Review the file at exports/components.csv and tell me which component names don't follow our naming convention."
```

For a system that should refuse out-of-scope requests:
```
"Can you write me a Python script to rename all my files?"
```

For a system with confirmation required:
```
"Flag the Button component as non-compliant in the tracker."
```

### Reading the Tool Call Log

RooCode shows every tool call it makes in the conversation panel. This is your harness's observability window. Look for:

- **Wrong tool chosen:** Revise the tool description to be more specific
- **Tool called with wrong parameters:** Revise the parameter descriptions + add examples
- **Tool called when it shouldn't be:** Add a negative condition to the description ("Do NOT use this for...")
- **No tool call when there should be:** Make the tool description more obvious about when to invoke it

---

## Common RooCode Issues and Fixes

### "RooCode isn't following my AGENTS.md rules"

**Possible causes:**
1. AGENTS.md isn't in the workspace root — check with `ls` in the terminal
2. The rule is too vague — rewrite it more specifically
3. The rule conflicts with a tool behavior — tools take precedence over instructions for some behaviors
4. Context window is getting full — long sessions degrade instruction-following

**Fixes:**
- Keep AGENTS.md concise (under 700 words)
- For hard rules, write a pre-tool hook to enforce them in code
- Start a fresh conversation if the session has been running for a long time

---

### "RooCode keeps asking for confirmation even when it shouldn't"

RooCode has built-in confirmation prompts for some actions (file writes, terminal commands). To reduce confirmation friction:

1. In RooCode settings, find "Auto-approve" options
2. Enable auto-approval for low-risk actions (read-only operations)
3. Keep confirmation for high-risk actions (file writes, terminal commands)

Or add to your AGENTS.md:
```markdown
## Permission Model
- You may read files without asking for confirmation.
- You may write to /output without asking for confirmation.
- Always confirm before writing to any other directory.
- Always confirm before running terminal commands.
```

---

### "The agent is using tools I didn't define"

RooCode has built-in tools that are always available (read_file, write_file, run_command, etc.). Your harness doesn't replace these — it adds context for when and how to use them.

To restrict which tools the agent uses:
- In custom mode config, use `restrictedTools` to block specific tools
- In AGENTS.md, add explicit "do not use X tool for Y purpose" instructions
- Use a pre-tool hook to block specific tool calls

---

### "My pre-tool hook isn't running"

RooCode hooks require configuration. Add to your workspace settings (`.roo/config.json`):

```json
{
  "hooks": {
    "preToolUse": "hooks/pre-tool.sh"
  }
}
```

Make sure the hook script is executable:
```bash
chmod +x hooks/pre-tool.sh
```

Test that the hook runs:
```bash
echo '{"file_path": "test.txt"}' | bash hooks/pre-tool.sh read_file
```

---

## GitHub Copilot Integration

If your group is also testing with GitHub Copilot:

1. Open Command Palette (`Cmd/Ctrl + Shift + P`)
2. Search "GitHub Copilot: Open Instructions File"
3. Add your system prompt content from `prompts/system-prompt.md`

Copilot reads the instructions file as a persistent context injection — similar to how RooCode reads AGENTS.md. The key difference: Copilot's instructions file is focused on code generation behaviors; RooCode's AGENTS.md supports full agentic tool use.

**Use Copilot for:** Autocomplete, inline edits, chat completions  
**Use RooCode for:** Multi-step agent tasks, file operations, testing harness behavior

---

## Keyboard Shortcuts

| Action | Shortcut |
|--------|---------|
| Open RooCode panel | `Cmd/Ctrl + Shift + A` (default) |
| New task | Click "+" in the RooCode panel |
| Accept agent suggestion | `Tab` or click "Apply" |
| Reject agent suggestion | `Esc` or click "Reject" |
| Open settings | Gear icon in RooCode panel |
| Toggle auto-approve | In RooCode settings |

---

## What RooCode Can and Can't Do

**RooCode can:**
- Read and write files in your workspace
- Run terminal commands (with your permission)
- Search for files and content
- Chain multiple steps together autonomously
- Remember context within a conversation
- Load and follow instructions from AGENTS.md

**RooCode can't (by default):**
- Access files outside your workspace
- Connect to external APIs (unless you've set up MCP servers)
- Remember context across separate conversations
- Run without your model API key
- Execute code in a sandboxed environment (it uses your real terminal)

For the workshop, the real terminal access is fine — you're working in a controlled folder. In production, you'd want to consider sandboxing for untrusted inputs.
