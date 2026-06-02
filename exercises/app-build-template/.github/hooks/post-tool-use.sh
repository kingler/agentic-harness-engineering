#!/usr/bin/env bash
# post-tool-use — runs after a tool. Format / log / tag the result.
# Keep it fast and non-interactive. Replace the body with your app's needs.
set -euo pipefail

input="$(cat)"
path="$(printf '%s' "$input" | jq -r '.tool_input.file_path // empty')"

# Example: log every file change with a timestamp.
if [[ -n "$path" ]]; then
  printf '%s\t%s\n' "$(date -u +%FT%TZ)" "$path" >> .harness-activity.log
fi

# Example hook for formatting (uncomment + point at your formatter):
# [[ "$path" == *.ts || "$path" == *.tsx ]] && npx prettier --write "$path" >/dev/null 2>&1 || true

exit 0
