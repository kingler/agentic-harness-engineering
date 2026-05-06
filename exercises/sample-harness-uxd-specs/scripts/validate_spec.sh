#!/usr/bin/env bash
# validate_spec.sh — validate a spec against the schema in
# knowledge/spec-schema.md. Emits JSON to stdout. Exit code 0 if no errors.
#
# Usage:
#   validate_spec.sh --spec-id SPEC-YYYY-NNN [--strict]
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SPECS_DIR="${SPECS_DIR:-$ROOT/specs}"
DS_INDEX="${DS_INDEX:-$ROOT/knowledge/design-system-index.md}"

spec_id=""
strict="false"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --spec-id) spec_id="$2"; shift 2 ;;
    --strict)  strict="true"; shift ;;
    *) echo "unknown arg: $1" >&2; exit 2 ;;
  esac
done

[[ -z "$spec_id" ]] && { echo "missing --spec-id" >&2; exit 2; }
file="$SPECS_DIR/${spec_id}.md"
[[ ! -f "$file" ]] && { echo "{\"ok\":false,\"errors\":[{\"rule\":\"file_exists\",\"line\":0,\"message\":\"spec not found: $spec_id\"}]}"; exit 1; }

errors=()
warnings=()

# Required frontmatter fields.
required_fields=(id title type status owner created updated version)
for f in "${required_fields[@]}"; do
  if ! grep -qE "^${f}: " "$file"; then
    errors+=("{\"rule\":\"frontmatter.required\",\"line\":0,\"message\":\"missing field: ${f}\"}")
  fi
done

# Frontmatter field order — the first five fields must appear as
# id, title, type, status, owner. Subsequent fields may be in any order.
canonical_prefix=(id title type status owner)
actual_order=()
while IFS= read -r key; do
  [[ -n "$key" ]] && actual_order+=("$key")
done < <(awk '
  /^---$/ { fm = !fm; next }
  fm && match($0, /^[a-zA-Z_][a-zA-Z0-9_]*:/) {
    print substr($0, RSTART, RLENGTH - 1)
  }
' "$file")
for i in 0 1 2 3 4; do
  expected="${canonical_prefix[$i]}"
  actual="${actual_order[$i]:-}"
  if [[ -n "$actual" && "$actual" != "$expected" ]]; then
    warnings+=("{\"rule\":\"frontmatter.field_order\",\"line\":0,\"message\":\"expected '${expected}' at position $((i+1)), got '${actual}'\"}")
    break
  fi
done

# Required sections in order.
required_sections=("# " "## Problem" "## Users" "## Goals & Non-goals" "## Flow" "## Acceptance criteria" "## Accessibility" "## Open questions")
prev_line=0
for s in "${required_sections[@]}"; do
  hit=$(grep -nF "$s" "$file" | head -1 | cut -d: -f1 || true)
  if [[ -z "$hit" ]]; then
    errors+=("{\"rule\":\"section.required\",\"line\":0,\"message\":\"missing section: ${s}\"}")
  elif [[ "$hit" -lt "$prev_line" ]]; then
    errors+=("{\"rule\":\"section.order\",\"line\":${hit},\"message\":\"section out of order: ${s}\"}")
  else
    prev_line=$hit
  fi
done

# Internal SPEC IDs referenced — must resolve to a real file.
while read -r ref; do
  [[ -z "$ref" ]] && continue
  if [[ ! -f "$SPECS_DIR/${ref}.md" ]]; then
    errors+=("{\"rule\":\"link.spec_id\",\"line\":0,\"message\":\"unresolved SPEC ID: ${ref}\"}")
  fi
done < <(grep -oE "SPEC-[0-9]{4}-[0-9]{3}" "$file" | grep -v "^${spec_id}$" | sort -u)

# Figma URLs must look like a Figma file/proto/design URL.
while read -r url; do
  if [[ ! "$url" =~ ^https://(www\.)?figma\.com/(file|proto|design)/ ]]; then
    warnings+=("{\"rule\":\"link.figma\",\"line\":0,\"message\":\"suspect Figma URL: ${url}\"}")
  fi
done < <(grep -oE "https://[^[:space:])]*figma\\.com[^[:space:])]*" "$file" || true)

# Design system component names — must match the index exactly.
if [[ -f "$DS_INDEX" ]]; then
  known=$(grep -oE "^- \`[A-Z][A-Za-z0-9]+\`" "$DS_INDEX" | tr -d '`' | sed 's/^- //' || true)
  while read -r comp; do
    [[ -z "$comp" ]] && continue
    if ! grep -qx "$comp" <(echo "$known"); then
      warnings+=("{\"rule\":\"design_system.unknown_component\",\"line\":0,\"message\":\"unknown component: ${comp}\"}")
    fi
  done < <(grep -oE "\`[A-Z][A-Za-z0-9]+\`" "$file" | tr -d '`' | sort -u)
fi

ok="true"
if [[ ${#errors[@]} -gt 0 ]]; then ok="false"; fi
if [[ "$strict" == "true" && ${#warnings[@]} -gt 0 ]]; then ok="false"; fi

joined_errors=$(IFS=,; echo "${errors[*]:-}")
joined_warnings=$(IFS=,; echo "${warnings[*]:-}")

cat <<EOF
{"ok":$ok,"errors":[$joined_errors],"warnings":[$joined_warnings]}
EOF

[[ "$ok" == "true" ]] || exit 1
