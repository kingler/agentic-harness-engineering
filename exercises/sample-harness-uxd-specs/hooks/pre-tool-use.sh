#!/usr/bin/env bash
# pre-tool-use.sh — runs BEFORE the harness executes a tool call. The hook
# receives the pending tool invocation as JSON on stdin and returns:
#   exit 0   → allow the call
#   exit 2   → block the call; stderr is shown back to the model
#
# This hook enforces three "never" rules that must not depend on the model
# remembering them:
#   1. Never write outside specs/, knowledge/, or notes/.
#   2. Never edit a spec whose status is approved or implemented.
#   3. Never hand-edit the `status:` frontmatter field — must go through
#      transition_status.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SPECS_DIR="$ROOT/specs"

input=$(cat)
tool=$(echo "$input" | jq -r '.tool_name // .name // ""')
path=$(echo "$input" | jq -r '.tool_input.file_path // .input.file_path // ""')
new_text=$(echo "$input" | jq -r '.tool_input.new_string // .input.new_string // ""')

# Rule 1: write boundary.
case "$tool" in
  Edit|Write|MultiEdit|NotebookEdit)
    if [[ -n "$path" ]]; then
      abs=$(realpath -m "$path")
      if [[ "$abs" != "$ROOT/specs/"* && "$abs" != "$ROOT/knowledge/"* && "$abs" != "$ROOT/notes/"* ]]; then
        echo "BLOCKED: writes are restricted to specs/, knowledge/, notes/. Got: $abs" >&2
        exit 2
      fi
    fi
    ;;
esac

# Rules 2 + 3 only apply to spec files.
if [[ "$path" == "$SPECS_DIR/SPEC-"* ]]; then
  current_status=$(awk '/^---$/ { fm = !fm; next } fm && /^status: / { sub(/^status: /, ""); print; exit }' "$path" 2>/dev/null || echo "")

  # Rule 2: locked statuses.
  if [[ "$tool" == "Edit" || "$tool" == "Write" || "$tool" == "MultiEdit" ]]; then
    if [[ "$current_status" == "approved" || "$current_status" == "implemented" ]]; then
      echo "BLOCKED: $(basename "$path") is $current_status. Use create_spec --revise <id> to make a revision." >&2
      exit 2
    fi
  fi

  # Rule 3: no hand-editing of status: field.
  if [[ "$new_text" =~ status:\ (draft|in-review|approved|implemented|archived) ]]; then
    echo "BLOCKED: status changes must go through scripts/transition_status.sh, not direct edits." >&2
    exit 2
  fi
fi

exit 0
