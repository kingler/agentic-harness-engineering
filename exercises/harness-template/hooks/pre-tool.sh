#!/bin/bash
# pre-tool.sh — Runs BEFORE the agent executes any tool call
#
# PURPOSE: This script is your harness's "safety layer" — deterministic logic
# that runs every single time, regardless of what the model decides.
# The model can't skip this. The model can't override this.
#
# HOW IT WORKS:
# - Receives the tool name as $1 and tool input as JSON via stdin
# - Exit code 0 = allow the tool to proceed
# - Exit code 1 = block the tool and return the error message to the agent
#
# WORKSHOP: Uncomment and customize the checks that apply to your harness.
#           You don't need to use all of them.

set -euo pipefail

TOOL_NAME="${1:-unknown}"
TOOL_INPUT=$(cat)  # JSON from stdin

# ──────────────────────────────────────────────
# LOG: Record every tool call for observability
# ──────────────────────────────────────────────
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
LOG_DIR="./logs"
mkdir -p "$LOG_DIR"

echo "{\"timestamp\": \"$TIMESTAMP\", \"tool\": \"$TOOL_NAME\", \"input\": $TOOL_INPUT}" \
  >> "$LOG_DIR/tool-calls.jsonl"

echo "[$TIMESTAMP] PRE-TOOL: $TOOL_NAME" >&2


# ──────────────────────────────────────────────
# CHECK: Block destructive file operations
# ──────────────────────────────────────────────
# Uncomment to prevent the agent from deleting files
#
# if [ "$TOOL_NAME" = "delete_file" ] || [ "$TOOL_NAME" = "remove_file" ]; then
#   echo "ERROR: File deletion is blocked. Move files to _archive/ instead." >&2
#   exit 1
# fi


# ──────────────────────────────────────────────
# CHECK: Restrict file access to allowed directories
# ──────────────────────────────────────────────
# Uncomment and set ALLOWED_DIR to enforce workspace boundaries
#
# ALLOWED_DIR="./data"
# if [ "$TOOL_NAME" = "read_file" ] || [ "$TOOL_NAME" = "write_file" ]; then
#   FILE_PATH=$(echo "$TOOL_INPUT" | python3 -c "import sys, json; print(json.load(sys.stdin).get('file_path', ''))" 2>/dev/null || echo "")
#   if [[ ! "$FILE_PATH" == "$ALLOWED_DIR"* ]]; then
#     echo "ERROR: Access denied. Agent can only access files in $ALLOWED_DIR" >&2
#     exit 1
#   fi
# fi


# ──────────────────────────────────────────────
# CHECK: Rate limit tool calls
# ──────────────────────────────────────────────
# Uncomment to prevent runaway agent loops
#
# CALL_COUNT_FILE="/tmp/harness-call-count-$$"
# if [ -f "$CALL_COUNT_FILE" ]; then
#   COUNT=$(cat "$CALL_COUNT_FILE")
#   if [ "$COUNT" -ge 20 ]; then
#     echo "ERROR: Tool call limit reached (20 per session). Ask the user to confirm before continuing." >&2
#     exit 1
#   fi
#   echo $((COUNT + 1)) > "$CALL_COUNT_FILE"
# else
#   echo "1" > "$CALL_COUNT_FILE"
# fi


# ──────────────────────────────────────────────
# CHECK: Block specific external services
# ──────────────────────────────────────────────
# Uncomment to block calls to services not on the allowlist
#
# BLOCKED_SERVICES=("analytics.example.com" "tracker.example.com")
# if [ "$TOOL_NAME" = "http_request" ]; then
#   URL=$(echo "$TOOL_INPUT" | python3 -c "import sys, json; print(json.load(sys.stdin).get('url', ''))" 2>/dev/null || echo "")
#   for SERVICE in "${BLOCKED_SERVICES[@]}"; do
#     if [[ "$URL" == *"$SERVICE"* ]]; then
#       echo "ERROR: Calls to $SERVICE are not permitted." >&2
#       exit 1
#     fi
#   done
# fi


# ──────────────────────────────────────────────
# ADD YOUR OWN CHECKS HERE
# ──────────────────────────────────────────────
# What should ALWAYS happen before a tool runs in your harness?
# Think about:
# - What data should never leave your system?
# - What files should the agent never touch?
# - What actions should always require extra verification?
# - What should always be logged?


# ──────────────────────────────────────────────
# ALLOW: Tool call passed all checks
# ──────────────────────────────────────────────
echo "[$TIMESTAMP] PRE-TOOL: $TOOL_NAME — ALLOWED" >&2
exit 0
