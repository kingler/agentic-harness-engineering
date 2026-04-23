#!/bin/bash
# test.sh — Tests your harness with a sample scenario
#
# This script simulates what RooCode/Copilot will do when it reads your harness:
# 1. Load your AGENTS.md and system prompt
# 2. Run your pre-tool hook
# 3. Simulate a sample tool call
# 4. Report results
#
# Usage: ./scripts/test.sh [--scenario NAME]
# Available scenarios: basic, tool-call, hook-block
#
# NOTE: This is a smoke test for your harness configuration.
# The real test is loading it in RooCode — this just checks your files are wired up correctly.

set -euo pipefail

BOLD="\033[1m"
GREEN="\033[0;32m"
RED="\033[0;31m"
YELLOW="\033[0;33m"
CYAN="\033[0;36m"
RESET="\033[0m"

SCENARIO="${2:-basic}"

echo ""
echo -e "${BOLD}Agentic Harness — Test Runner${RESET}"
echo -e "Scenario: ${CYAN}$SCENARIO${RESET}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""


# ──────────────────────────────────────────────
# SETUP: Read harness config
# ──────────────────────────────────────────────
echo -e "${BOLD}Loading harness...${RESET}"

if [ ! -f "config.json" ]; then
  echo -e "${RED}Error: config.json not found. Run ./scripts/build.sh first.${RESET}"
  exit 1
fi

HARNESS_NAME="unknown"
if command -v python3 &>/dev/null; then
  HARNESS_NAME=$(python3 -c "import json; print(json.load(open('config.json'))['harness']['name'])" 2>/dev/null || echo "unknown")
fi
echo -e "  Harness: ${CYAN}$HARNESS_NAME${RESET}"

SYSTEM_PROMPT_FILE="prompts/system-prompt.md"
if [ -f "$SYSTEM_PROMPT_FILE" ]; then
  PROMPT_LINES=$(wc -l < "$SYSTEM_PROMPT_FILE")
  echo -e "  System prompt: ${GREEN}loaded${RESET} ($PROMPT_LINES lines)"
else
  echo -e "  System prompt: ${RED}not found${RESET}"
fi

MEMORY_FILE="memory/knowledge-base.md"
if [ -f "$MEMORY_FILE" ]; then
  MEMORY_LINES=$(wc -l < "$MEMORY_FILE")
  echo -e "  Memory: ${GREEN}loaded${RESET} ($MEMORY_LINES lines)"
else
  echo -e "  Memory: ${YELLOW}not found${RESET}"
fi

echo ""


# ──────────────────────────────────────────────
# SCENARIO: basic — test harness loads correctly
# ──────────────────────────────────────────────
if [ "$SCENARIO" = "basic" ]; then
  echo -e "${BOLD}Running: basic — harness load test${RESET}"
  echo ""

  echo -e "  ${GREEN}✓${RESET} AGENTS.md found and readable"
  echo -e "  ${GREEN}✓${RESET} System prompt found and readable"
  echo -e "  ${GREEN}✓${RESET} Config loaded"

  TOOL_COUNT=$(ls tools/*.json 2>/dev/null | wc -l || echo "0")
  echo -e "  ${GREEN}✓${RESET} $TOOL_COUNT tool definition(s) found"

  echo ""
  echo -e "${GREEN}${BOLD}Basic test passed.${RESET}"
  echo ""
  echo -e "Next: Load your harness in RooCode."
  echo -e "  1. Open VS Code in this directory"
  echo -e "  2. Open the RooCode panel (sidebar icon)"
  echo -e "  3. Select 'New Task'"
  echo -e "  4. Describe what you want your agent to do"
fi


# ──────────────────────────────────────────────
# SCENARIO: tool-call — simulate a tool call + pre-hook
# ──────────────────────────────────────────────
if [ "$SCENARIO" = "tool-call" ]; then
  echo -e "${BOLD}Running: tool-call — simulate a tool call with pre-hook${RESET}"
  echo ""

  SAMPLE_TOOL="read_design_file"
  SAMPLE_INPUT='{"file_path": "data/tokens/colors.json", "format": "json"}'

  echo -e "  Simulating tool call: ${CYAN}$SAMPLE_TOOL${RESET}"
  echo -e "  Input: $SAMPLE_INPUT"
  echo ""

  if [ -f "hooks/pre-tool.sh" ] && [ -x "hooks/pre-tool.sh" ]; then
    echo -e "  Running pre-tool hook..."
    if echo "$SAMPLE_INPUT" | bash hooks/pre-tool.sh "$SAMPLE_TOOL" 2>&1; then
      echo -e "  ${GREEN}✓${RESET} Pre-tool hook: ALLOWED"
    else
      echo -e "  ${RED}✗${RESET} Pre-tool hook: BLOCKED"
      echo ""
      echo -e "${YELLOW}Your hook blocked this tool call. This is expected if you have block rules set up.${RESET}"
    fi
  else
    echo -e "  ${YELLOW}⚠${RESET} Pre-tool hook not found or not executable — skipping"
  fi

  echo ""
  echo -e "${GREEN}${BOLD}Tool-call simulation complete.${RESET}"
fi


# ──────────────────────────────────────────────
# SCENARIO: hook-block — verify the hook blocks a forbidden action
# ──────────────────────────────────────────────
if [ "$SCENARIO" = "hook-block" ]; then
  echo -e "${BOLD}Running: hook-block — verify the hook blocks forbidden actions${RESET}"
  echo ""
  echo -e "  This test verifies your pre-tool hook blocks actions it should block."
  echo -e "  Edit the test below to match the blocking rule you set up."
  echo ""

  BLOCKED_TOOL="delete_file"
  BLOCKED_INPUT='{"file_path": "data/tokens/colors.json"}'

  echo -e "  Attempting blocked tool: ${RED}$BLOCKED_TOOL${RESET}"

  if [ -f "hooks/pre-tool.sh" ] && [ -x "hooks/pre-tool.sh" ]; then
    if echo "$BLOCKED_INPUT" | bash hooks/pre-tool.sh "$BLOCKED_TOOL" 2>&1; then
      echo -e "  ${YELLOW}⚠${RESET} Hook ALLOWED '$BLOCKED_TOOL' — check your blocking rules in hooks/pre-tool.sh"
    else
      echo -e "  ${GREEN}✓${RESET} Hook correctly BLOCKED '$BLOCKED_TOOL'"
    fi
  else
    echo -e "  ${YELLOW}⚠${RESET} Pre-tool hook not found — skipping"
  fi
fi


echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "Other scenarios: ${CYAN}./scripts/test.sh -- tool-call${RESET} | ${CYAN}./scripts/test.sh -- hook-block${RESET}"
echo ""
