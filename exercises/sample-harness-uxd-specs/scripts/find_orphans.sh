#!/usr/bin/env bash
# find_orphans.sh — find approved/implemented specs with no inbound links and
# stale drafts older than --stale-days. Emits JSON to stdout.
#
# Usage:
#   find_orphans.sh [--stale-days N] [--include-archived]
set -euo pipefail

SPECS_DIR="${SPECS_DIR:-$(cd "$(dirname "$0")/.." && pwd)/specs}"

stale_days=90
include_archived="false"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --stale-days)        stale_days="$2"; shift 2 ;;
    --include-archived)  include_archived="true"; shift ;;
    *) echo "unknown arg: $1" >&2; exit 2 ;;
  esac
done

read_field() { awk -v key="$1" '
  /^---$/ { fm = !fm; next }
  fm && $0 ~ "^"key": " { sub("^"key": ", ""); print; exit }
' "$2"; }

# Build the inbound link map by grepping all SPEC IDs across the library.
declare -A inbound
for f in "$SPECS_DIR"/SPEC-*.md; do
  [[ -f "$f" ]] || continue
  src_id=$(read_field id "$f")
  for ref in $(grep -oE "SPEC-[0-9]{4}-[0-9]{3}" "$f" | grep -v "^${src_id}$" | sort -u); do
    inbound[$ref]="${inbound[$ref]:-}${src_id} "
  done
done

no_inbound=()
stale=()
today_epoch=$(date +%s)
cutoff=$(( today_epoch - stale_days * 86400 ))

for f in "$SPECS_DIR"/SPEC-*.md; do
  [[ -f "$f" ]] || continue
  id=$(read_field id "$f")
  status=$(read_field status "$f")
  updated=$(read_field updated "$f")

  [[ "$status" == "archived" && "$include_archived" == "false" ]] && continue

  case "$status" in
    approved|implemented)
      if [[ -z "${inbound[$id]:-}" ]]; then
        no_inbound+=("\"$id\"")
      fi
      ;;
    draft)
      if [[ -n "$updated" ]]; then
        upd_epoch=$(date -d "$updated" +%s 2>/dev/null || echo 0)
        if [[ $upd_epoch -lt $cutoff ]]; then
          stale+=("\"$id\"")
        fi
      fi
      ;;
  esac
done

ni=$(IFS=,; echo "${no_inbound[*]:-}")
sd=$(IFS=,; echo "${stale[*]:-}")
echo "{\"no_inbound_links\":[$ni],\"stale_drafts\":[$sd]}"
