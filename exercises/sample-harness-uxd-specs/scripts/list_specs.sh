#!/usr/bin/env bash
# list_specs.sh — list specs filtered by status/type/owner/title.
# Emits a JSON array to stdout.
#
# Usage:
#   list_specs.sh [--status S] [--type T] [--owner U] [--title-match Q] [--limit N]
set -euo pipefail

SPECS_DIR="${SPECS_DIR:-$(cd "$(dirname "$0")/.." && pwd)/specs}"

f_status="any"
f_type="any"
f_owner=""
f_title=""
limit=50

while [[ $# -gt 0 ]]; do
  case "$1" in
    --status)      f_status="$2"; shift 2 ;;
    --type)        f_type="$2"; shift 2 ;;
    --owner)       f_owner="$2"; shift 2 ;;
    --title-match) f_title="$2"; shift 2 ;;
    --limit)       limit="$2"; shift 2 ;;
    *) echo "unknown arg: $1" >&2; exit 2 ;;
  esac
done

read_field() { awk -v key="$1" '
  /^---$/ { fm = !fm; next }
  fm && $0 ~ "^"key": " { sub("^"key": ", ""); print; exit }
' "$2"; }

results=()
count=0
for f in "$SPECS_DIR"/SPEC-*.md; do
  [[ -f "$f" ]] || continue
  id=$(read_field id "$f")
  title=$(read_field title "$f")
  status=$(read_field status "$f")
  owner=$(read_field owner "$f")
  type=$(read_field type "$f")
  updated=$(read_field updated "$f")

  [[ "$f_status" != "any" && "$status" != "$f_status" ]] && continue
  [[ "$f_type"   != "any" && "$type"   != "$f_type"   ]] && continue
  [[ -n "$f_owner" && "$owner" != "$f_owner" ]] && continue
  if [[ -n "$f_title" ]]; then
    shopt -s nocasematch
    [[ "$title" != *"$f_title"* ]] && { shopt -u nocasematch; continue; }
    shopt -u nocasematch
  fi

  results+=("{\"id\":\"$id\",\"title\":\"$title\",\"status\":\"$status\",\"owner\":\"$owner\",\"type\":\"$type\",\"updated\":\"$updated\"}")
  count=$((count + 1))
  [[ $count -ge $limit ]] && break
done

joined=$(IFS=,; echo "${results[*]:-}")
echo "[$joined]"
