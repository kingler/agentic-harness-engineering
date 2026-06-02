#!/usr/bin/env bash
# pre-tool-use — block the nightmare-failure action before any tool runs.
# Reads a JSON tool-call event on stdin and emits an approve/block decision.
# Replace the predicate below with YOUR app's one hard "never".
set -euo pipefail

input="$(cat)"

# Example: block writes outside the project root.
# Swap this for the action your AGENTS.md rule #1 forbids.
tool="$(printf '%s' "$input" | jq -r '.tool_name // empty')"
path="$(printf '%s' "$input" | jq -r '.tool_input.file_path // empty')"

if [[ "$tool" == "Write" || "$tool" == "Edit" ]]; then
  case "$path" in
    /*|*..*)
      printf '{"decision":"block","reason":"Writes are restricted to the project root."}\n'
      exit 0
      ;;
  esac
fi

printf '{"decision":"approve"}\n'
