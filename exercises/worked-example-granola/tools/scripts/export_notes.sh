#!/usr/bin/env bash
# export_notes — send a meeting recap to a target (doc | crm | tasks).
# WHAT:  exports the recap for a meeting to an external target.
# WHEN:  the user clicks Export / asks to send or share the recap.
# WHEN NOT: do not use to "save a draft" — that's local, no recipients.
#
# The attendee gate is enforced deterministically in
# .github/hooks/pre-tool-use.sh, not here — this script trusts that it ran.
set -euo pipefail

target="${1:-}"      # doc | crm | tasks
recipient="${2:-}"   # email of the recipient

if [[ -z "$target" || -z "$recipient" ]]; then
  echo "usage: $(basename "$0") <doc|crm|tasks> <recipient-email>" >&2
  exit 2
fi

# TODO: implement the real export. For the lab, mock it.
echo "TODO: export recap to target=$target recipient=$recipient"
exit 0
