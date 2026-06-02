#!/usr/bin/env bash
# sample-tool — script-as-tool stub.
# Rename to a verb (e.g. validate_spec.sh) and describe it in AGENTS.md so the
# agent knows WHAT it does, WHEN to use it, and WHEN NOT to.
set -euo pipefail

arg="${1:-}"
if [[ -z "$arg" ]]; then
  echo "usage: $(basename "$0") <arg>" >&2
  exit 2
fi

echo "TODO: implement $(basename "$0") for arg=$arg"
exit 0
