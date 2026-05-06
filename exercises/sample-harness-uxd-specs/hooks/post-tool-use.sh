#!/usr/bin/env bash
# post-tool-use.sh — runs AFTER a tool call completes. Receives the tool
# invocation + result as JSON on stdin. Used here to:
#   1. Stamp `updated:` to today on any spec the model touched.
#   2. Bump the patch component of `version:` on content edits.
#   3. Emit a one-line audit record to notes/SESSION.log.
#
# The hook does not block; it cleans up after the model so the agent never has
# to remember to do this by hand.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SPECS_DIR="$ROOT/specs"
LOG="$ROOT/notes/SESSION.log"
mkdir -p "$ROOT/notes"

input=$(cat)
tool=$(echo "$input" | jq -r '.tool_name // .name // ""')
path=$(echo "$input" | jq -r '.tool_input.file_path // .input.file_path // ""')
status=$(echo "$input" | jq -r '.tool_response.exit_code // .result.exit_code // 0')

ts=$(date -Iseconds)
echo "$ts $tool $path exit=$status" >> "$LOG"

# Only post-process when a spec file was edited successfully.
[[ "$path" != "$SPECS_DIR/SPEC-"*.md ]] && exit 0
[[ ! -f "$path" ]] && exit 0
[[ "$tool" != "Edit" && "$tool" != "Write" && "$tool" != "MultiEdit" ]] && exit 0

today=$(date +%Y-%m-%d)
tmp=$(mktemp)

awk -v today="$today" '
  BEGIN { fm = 0; updated_seen = 0; version_seen = 0 }
  /^---$/ { fm = !fm; print; next }
  fm && /^updated: / {
    print "updated: " today
    updated_seen = 1
    next
  }
  fm && /^version: / {
    n = split($2, parts, ".")
    if (n == 3) {
      parts[3] = parts[3] + 1
      print "version: " parts[1] "." parts[2] "." parts[3]
    } else {
      print
    }
    version_seen = 1
    next
  }
  { print }
' "$path" > "$tmp"
mv "$tmp" "$path"

exit 0
