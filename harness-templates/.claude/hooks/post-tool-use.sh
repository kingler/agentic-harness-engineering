#!/usr/bin/env bash
# PostToolUse hook — runs after every Edit / Write tool call.
# Bound in .claude/settings.json under "PostToolUse" matcher "Edit|Write".
#
# Goals:
#   1. Block writes outside the project root.
#   2. Auto-format the touched file when a formatter is available.
#   3. Log the change to .claude/log/edits.log for the eval set.
#
# Hook input: Claude Code passes a JSON payload on stdin describing the tool
# call that just ran. We read tool_input.file_path; if it's missing we exit 0.

set -euo pipefail

PROJECT_ROOT="${CLAUDE_PROJECT_DIR:-$(pwd)}"
LOG_DIR="$PROJECT_ROOT/.claude/log"
mkdir -p "$LOG_DIR"

payload="$(cat || true)"
file_path="$(printf '%s' "$payload" | jq -r '.tool_input.file_path // empty' 2>/dev/null || true)"

if [[ -z "$file_path" ]]; then
  exit 0
fi

# 1. Scope check — refuse anything outside the project root.
abs="$(realpath "$file_path" 2>/dev/null || echo "$file_path")"
case "$abs" in
  "$PROJECT_ROOT"/*) ;;
  *)
    echo "post-tool-use: blocked write outside project root: $abs" >&2
    exit 2
    ;;
esac

# 2. Auto-format when we know how.
case "$file_path" in
  *.ts|*.tsx|*.js|*.jsx|*.json|*.md)
    if command -v prettier >/dev/null 2>&1; then
      prettier --write "$file_path" >/dev/null 2>&1 || true
    fi
    ;;
  *.py)
    if command -v ruff >/dev/null 2>&1; then
      ruff format "$file_path" >/dev/null 2>&1 || true
    fi
    ;;
esac

# 3. Log for the eval set.
ts="$(date -u +%Y-%m-%dT%H:%M:%SZ)"
printf '%s\t%s\n' "$ts" "$file_path" >> "$LOG_DIR/edits.log"

exit 0
