---
mode: agent
description: Walk the user through pairing settings.json rules with a pre-tool-use hook for the app they're reverse-engineering.
---

# /draft-rules-hooks — Component 4 breakout

You are coaching the user through pairing **declarative rules** (`.claude/settings.json`) with **deterministic enforcement** (`.claude/hooks/pre-tool-use.sh`). Rules say what's allowed; hooks make sure it actually holds.

## Step 1 — Pick the app + the risky surface

Ask:
> "Which app are we drafting rules for? And what's the one action you most need the agent to never do without checking — production deploys? Secret reads? Writes outside a folder?"

## Step 2 — Triad: allow / deny / ask

Walk through each list. For each, the user names 2–3 entries.

| List | Prompt | Example pattern |
|------|--------|-----------------|
| **allow** | "What 2–3 read-only or low-risk actions can always run?" | `Bash(npm test:*)`, `Read(./src/**)` |
| **deny** | "What 2–3 actions must NEVER fire? State them as patterns." | `Bash(rm -rf:*)`, `Read(./.env*)` |
| **ask** | "What 2–3 actions need a human nod each time?" | `Bash(gh pr merge:*)`, `Write(./infra/**)` |

Reinforce: **strong vs weak** — rules that name tools and paths beat vague "be careful."

## Step 3 — Assemble settings.json

Write `.claude/settings.json`:

```json
{
  "permissions": {
    "allow": [ "{step2 allow entries}" ],
    "deny":  [ "{step2 deny  entries}" ],
    "ask":   [ "{step2 ask   entries}" ]
  },
  "hooks": {
    "PreToolUse": ".claude/hooks/pre-tool-use.sh"
  }
}
```

## Step 4 — The hook predicate

Now ask:
> "For the deny list, what's the ONE check we want a hook to enforce mechanically? (e.g. block any Write outside /specs.)"

Write `.claude/hooks/pre-tool-use.sh`:

```bash
#!/usr/bin/env bash
set -euo pipefail
input=$(cat)
tool=$(jq -r '.tool_name' <<<"$input")
path=$(jq -r '.tool_input.file_path // empty' <<<"$input")

if [[ "$tool" == "Write" || "$tool" == "Edit" ]]; then
  if [[ -n "$path" && "$path" != {user-named-prefix}/* ]]; then
    echo '{"decision":"block","reason":"Writes restricted to {user-named-prefix}."}'
    exit 0
  fi
fi

echo '{"decision":"approve"}'
```

`chmod +x` the hook. Substitute `{user-named-prefix}` with the path the user gave.

## Step 5 — Self-check

> "Read the deny list as if you were the model trying to argue your way past. Where's the wiggle room?"

Stop after both files are saved.
