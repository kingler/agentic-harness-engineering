#!/usr/bin/env bash
# create_spec.sh — scaffolds a new spec from a template and allocates the next
# SPEC-YYYY-NNN ID. Prints JSON to stdout for the agent to consume.
#
# Usage:
#   create_spec.sh --type <ux-flow|component|research|prd> \
#                  --title "<title>" \
#                  --owner <username> \
#                  [--revise-of SPEC-YYYY-NNN]
set -euo pipefail

SPECS_DIR="${SPECS_DIR:-$(cd "$(dirname "$0")/.." && pwd)/specs}"
TEMPLATES_DIR="$SPECS_DIR/templates"
YEAR="$(date +%Y)"

type=""
title=""
owner=""
revise_of=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --type)       type="$2"; shift 2 ;;
    --title)      title="$2"; shift 2 ;;
    --owner)      owner="$2"; shift 2 ;;
    --revise-of)  revise_of="$2"; shift 2 ;;
    *) echo "unknown arg: $1" >&2; exit 2 ;;
  esac
done

if [[ -z "$type" || -z "$title" || -z "$owner" ]]; then
  echo "missing required args" >&2; exit 2
fi

template="$TEMPLATES_DIR/$type.md"
if [[ ! -f "$template" ]]; then
  echo "no template for type: $type" >&2; exit 2
fi

# Allocate the next NNN for this year.
last_num=$(ls "$SPECS_DIR" 2>/dev/null \
  | grep -oE "SPEC-${YEAR}-[0-9]{3}\.md" \
  | sed -E "s/SPEC-${YEAR}-([0-9]{3})\.md/\1/" \
  | sort -n | tail -1 || echo "")
next_num=$(printf "%03d" $(( 10#${last_num:-0} + 1 )))
new_id="SPEC-${YEAR}-${next_num}"
new_path="$SPECS_DIR/${new_id}.md"

today=$(date +%Y-%m-%d)
revises_field=""
if [[ -n "$revise_of" ]]; then
  revises_field="revises: $revise_of"
fi

# Render the template with simple sed substitution.
sed \
  -e "s|{{ID}}|$new_id|g" \
  -e "s|{{TITLE}}|$title|g" \
  -e "s|{{OWNER}}|$owner|g" \
  -e "s|{{TYPE}}|$type|g" \
  -e "s|{{TODAY}}|$today|g" \
  -e "s|{{REVISES}}|$revises_field|g" \
  "$template" > "$new_path"

cat <<EOF
{"id":"$new_id","path":"$new_path","warnings":[]}
EOF
