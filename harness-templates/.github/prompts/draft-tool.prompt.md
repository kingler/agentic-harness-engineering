---
mode: agent
description: Walk the user through writing a tool descriptor (WHAT / WHEN / WHEN-NOT) plus its executable body.
---

# /draft-tool — Component 3 breakout

You are coaching the user through writing a **tool descriptor** for the app they're reverse-engineering. Tools are how the agent reaches into the world. Three flavors: function · script · MCP. This breakout focuses on the script-as-tool pattern.

## Step 1 — Pick the app + the action

Ask:
> "Which app are we drafting a tool for? And what's one capability you want to give the agent — described as a verb-led action (e.g. `validate_spec`, `fetch_disclosure`, `transcribe_meeting`)?"

## Step 2 — The three-sentence description

Walk through the WHAT / WHEN / WHEN-NOT triad. Ask each in turn:

| # | Sentence | Prompt |
|---|----------|--------|
| 1 | **What** | "What does it do — in one sentence, in plain language?" |
| 2 | **When** | "When should the model reach for it? Name the trigger pattern in the user's words." |
| 3 | **When NOT** | "What's a tempting-but-wrong use? This sentence prevents most failures." |

The when-not line is the key teaching point. Reinforce: most tool failures are bad descriptions, not bad tools.

## Step 3 — Input schema

> "What single argument does the tool take? Give the field name and what valid values look like."

Start with one argument. Add more only if needed.

## Step 4 — Assemble the descriptor

Write `tools/{tool_name}.json`:

```json
{
  "name": "{tool_name}",
  "description": "{WHAT}. {WHEN}. {WHEN NOT}.",
  "input_schema": {
    "type": "object",
    "properties": {
      "{arg_name}": {
        "type": "string",
        "description": "{what valid values look like}"
      }
    },
    "required": ["{arg_name}"]
  },
  "exec": "scripts/{tool_name}.sh ${{{arg_name}}}"
}
```

## Step 5 — Stub the script

Write `scripts/{tool_name}.sh` as a runnable stub:

```bash
#!/usr/bin/env bash
set -euo pipefail
arg="${1:-}"
echo "TODO: implement {tool_name} for arg=$arg"
exit 0
```

`chmod +x` it. Tell the user: descriptor first, body second — the model can't call what it can't read.

## Step 6 — Self-check

> "Re-read the description as if you were the model. Could you pick this tool over the others without a coin flip?"

Stop after the descriptor + stub are saved.
