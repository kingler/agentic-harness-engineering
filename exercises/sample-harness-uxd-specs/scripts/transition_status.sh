#!/usr/bin/env bash
# transition_status.sh — move a spec between workflow states with
# preconditions enforced. Emits JSON to stdout.
#
# Allowed transitions (see knowledge/workflow.md):
#   draft       -> in-review
#   in-review   -> approved
#   in-review   -> draft
#   approved    -> implemented
#   *           -> archived
#
# Usage:
#   transition_status.sh --spec-id SPEC-YYYY-NNN --to STATE [--reason "text"]
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SPECS_DIR="${SPECS_DIR:-$ROOT/specs}"

spec_id=""; target=""; reason=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --spec-id) spec_id="$2"; shift 2 ;;
    --to)      target="$2"; shift 2 ;;
    --reason)  reason="$2"; shift 2 ;;
    *) echo "unknown arg: $1" >&2; exit 2 ;;
  esac
done

[[ -z "$spec_id" || -z "$target" ]] && { echo "missing args" >&2; exit 2; }
file="$SPECS_DIR/${spec_id}.md"
[[ ! -f "$file" ]] && { echo "{\"ok\":false,\"blocked_by\":[\"spec not found\"]}"; exit 1; }

current=$(awk '/^---$/ { fm = !fm; next } fm && /^status: / { sub(/^status: /, ""); print; exit }' "$file")

allowed=0
case "$current->$target" in
  "draft->in-review"|"in-review->approved"|"in-review->draft"|"approved->implemented") allowed=1 ;;
esac
[[ "$target" == "archived" ]] && allowed=1

blocked=()
if [[ $allowed -ne 1 ]]; then
  blocked+=("\"transition not allowed: $current -> $target\"")
fi

# Reason is required for terminal-ish transitions.
case "$target" in
  approved|implemented|archived)
    [[ -z "$reason" ]] && blocked+=("\"reason required for transition to $target\"")
    ;;
esac

# Strict validation gate before in-review or approved.
if [[ "$target" == "in-review" || "$target" == "approved" ]]; then
  if ! "$ROOT/scripts/validate_spec.sh" --spec-id "$spec_id" --strict >/dev/null 2>&1; then
    blocked+=("\"validate_spec --strict failed\"")
  fi
fi

if [[ ${#blocked[@]} -gt 0 ]]; then
  joined=$(IFS=,; echo "${blocked[*]}")
  echo "{\"ok\":false,\"from\":\"$current\",\"to\":\"$target\",\"blocked_by\":[$joined]}"
  exit 1
fi

# Apply: rewrite status: in frontmatter, append a history line.
tmp=$(mktemp)
awk -v new="$target" '
  /^---$/ { fm = !fm; print; next }
  fm && /^status: / { print "status: " new; next }
  { print }
' "$file" > "$tmp"
mv "$tmp" "$file"

today=$(date +%Y-%m-%d)
{
  echo ""
  echo "<!-- history: $today $current -> $target${reason:+ — }${reason} -->"
} >> "$file"

echo "{\"ok\":true,\"from\":\"$current\",\"to\":\"$target\",\"blocked_by\":[]}"
