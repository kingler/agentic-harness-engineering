#!/usr/bin/env bash
# PreToolUse hook — runs before every Bash tool call.
# Bound in .claude/settings.json under "PreToolUse" matcher "Bash".
#
# Goal: refuse a small set of obviously-destructive commands even if the user
# (or the model) asked for them. The deny list in settings.json catches the
# common ones; this hook adds a defense-in-depth layer for combinations.

set -euo pipefail

payload="$(cat || true)"
cmd="$(printf '%s' "$payload" | jq -r '.tool_input.command // empty' 2>/dev/null || true)"

if [[ -z "$cmd" ]]; then
  exit 0
fi

deny_patterns=(
  'rm[[:space:]]+-rf[[:space:]]+/'
  'rm[[:space:]]+-rf[[:space:]]+\$HOME'
  'mkfs\.'
  ':(){[[:space:]]*:|:&[[:space:]]*};:'
  'curl[[:space:]]+.*\|[[:space:]]*sh'
  'wget[[:space:]]+.*\|[[:space:]]*sh'
)

for p in "${deny_patterns[@]}"; do
  if printf '%s' "$cmd" | grep -Eq "$p"; then
    echo "pre-tool-use: refused dangerous command pattern: $p" >&2
    exit 2
  fi
done

exit 0
