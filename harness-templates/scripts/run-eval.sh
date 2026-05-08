#!/usr/bin/env bash
# scripts/run-eval.sh — example custom tool the agent can invoke.
#
# Concept demonstrated: a "tool" in harness terms is just a script with a
# stable interface. Allow it from Copilot or RooCode/Cline so the agent can
# call it without prompting (e.g. an allow entry like):
#
#   "Bash(scripts/run-eval.sh:*)"
#
# Then the agent can run it like any other Bash command. Keep stdout
# machine-readable (one JSON object per line, or a short summary the model
# can quote) — the model is the consumer, not a human.

set -euo pipefail

cd "$(dirname "$0")/.."

case "${1:-help}" in
  help)
    cat <<'EOF'
Usage: scripts/run-eval.sh <command>

Commands:
  smoke    Run the smallest end-to-end check (replace with your own).
  golden   Re-run the golden-set transcripts and diff against expected.
  list     Print the names of available eval cases.
EOF
    ;;
  smoke)
    # Replace with the smallest signal that says "the harness still works".
    echo '{"case":"smoke","status":"pass","duration_ms":0}'
    ;;
  golden)
    # Replace with: iterate over evals/*.json, run, diff, print one line each.
    echo '{"case":"golden","status":"not-implemented"}'
    exit 1
    ;;
  list)
    # Replace with: ls evals/*.json | xargs -n1 basename .json
    echo "smoke"
    ;;
  *)
    echo "unknown command: $1" >&2
    exit 2
    ;;
esac
