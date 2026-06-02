#!/usr/bin/env bash
# pre-tool-use — Granola attendee gate.
# Hard rule #1: never export/send notes to anyone outside the meeting's
# attendee list. Enforced here so the model cannot argue its way past it.
#
# Expects a JSON tool-call event on stdin, e.g.:
#   {"tool_name":"export_notes",
#    "tool_input":{"recipient":"x@acme","attendees":["x@acme","y@northstar"]}}
set -euo pipefail

input="$(cat)"
tool="$(printf '%s' "$input" | jq -r '.tool_name // empty')"

if [[ "$tool" == "export_notes" ]]; then
  recipient="$(printf '%s' "$input" | jq -r '.tool_input.recipient // empty')"
  # Is the recipient in the attendees array?
  in_list="$(printf '%s' "$input" \
    | jq -r --arg r "$recipient" '.tool_input.attendees // [] | index($r) != null')"
  if [[ "$in_list" != "true" ]]; then
    printf '{"decision":"block","reason":"%s is not an attendee of this meeting — notes can only go to attendees."}\n' "$recipient"
    exit 0
  fi
fi

printf '{"decision":"approve"}\n'
