#!/bin/bash
# build.sh — Validates and prepares the harness for use
#
# Run this script after making changes to your harness to verify
# that everything is configured correctly before testing with RooCode/Copilot.
#
# Usage: ./scripts/build.sh

set -euo pipefail

BOLD="\033[1m"
GREEN="\033[0;32m"
RED="\033[0;31m"
YELLOW="\033[0;33m"
RESET="\033[0m"

echo ""
echo -e "${BOLD}Agentic Harness — Build Check${RESET}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

ERRORS=0
WARNINGS=0

# ──────────────────────────────────────────────
# CHECK 1: Required files exist
# ──────────────────────────────────────────────
echo -e "${BOLD}Checking required files...${RESET}"

REQUIRED_FILES=(
  "AGENTS.md"
  "config.json"
  "prompts/system-prompt.md"
  "memory/knowledge-base.md"
)

for FILE in "${REQUIRED_FILES[@]}"; do
  if [ -f "$FILE" ]; then
    echo -e "  ${GREEN}✓${RESET} $FILE"
  else
    echo -e "  ${RED}✗${RESET} $FILE — MISSING"
    ERRORS=$((ERRORS + 1))
  fi
done

echo ""


# ──────────────────────────────────────────────
# CHECK 2: config.json is valid JSON
# ──────────────────────────────────────────────
echo -e "${BOLD}Validating config.json...${RESET}"

if command -v python3 &>/dev/null; then
  if python3 -c "import json; json.load(open('config.json'))" 2>/dev/null; then
    echo -e "  ${GREEN}✓${RESET} config.json is valid JSON"
  else
    echo -e "  ${RED}✗${RESET} config.json has JSON syntax errors"
    ERRORS=$((ERRORS + 1))
  fi
else
  echo -e "  ${YELLOW}⚠${RESET} Python3 not found — skipping JSON validation"
  WARNINGS=$((WARNINGS + 1))
fi

echo ""


# ──────────────────────────────────────────────
# CHECK 3: AGENTS.md has required sections
# ──────────────────────────────────────────────
echo -e "${BOLD}Checking AGENTS.md structure...${RESET}"

REQUIRED_SECTIONS=("Identity" "Capabilities" "Tools Available" "Behavior Rules")
for SECTION in "${REQUIRED_SECTIONS[@]}"; do
  if grep -q "## $SECTION" AGENTS.md 2>/dev/null; then
    echo -e "  ${GREEN}✓${RESET} Section: $SECTION"
  else
    echo -e "  ${YELLOW}⚠${RESET} Section '$SECTION' not found in AGENTS.md"
    WARNINGS=$((WARNINGS + 1))
  fi
done

# Check for TODO placeholders that weren't filled in
TODO_COUNT=$(grep -c "TODO:" AGENTS.md 2>/dev/null || echo "0")
if [ "$TODO_COUNT" -gt 0 ]; then
  echo -e "  ${YELLOW}⚠${RESET} Found $TODO_COUNT TODO placeholder(s) in AGENTS.md — fill these in before testing"
  WARNINGS=$((WARNINGS + 1))
else
  echo -e "  ${GREEN}✓${RESET} No TODO placeholders remaining"
fi

echo ""


# ──────────────────────────────────────────────
# CHECK 4: Tool definitions are valid
# ──────────────────────────────────────────────
echo -e "${BOLD}Checking tool definitions...${RESET}"

if [ -d "tools" ] && [ "$(ls tools/*.json 2>/dev/null | wc -l)" -gt 0 ]; then
  for TOOL_FILE in tools/*.json; do
    if command -v python3 &>/dev/null; then
      if python3 -c "import json; d = json.load(open('$TOOL_FILE')); assert 'name' in d and 'description' in d" 2>/dev/null; then
        TOOL_NAME=$(python3 -c "import json; print(json.load(open('$TOOL_FILE'))['name'])" 2>/dev/null)
        echo -e "  ${GREEN}✓${RESET} $TOOL_FILE ($TOOL_NAME)"
      else
        echo -e "  ${RED}✗${RESET} $TOOL_FILE — missing required fields (name, description)"
        ERRORS=$((ERRORS + 1))
      fi
    else
      echo -e "  ${YELLOW}⚠${RESET} $TOOL_FILE — skipping validation (Python3 not found)"
    fi
  done
else
  echo -e "  ${YELLOW}⚠${RESET} No tool definitions found in tools/"
  WARNINGS=$((WARNINGS + 1))
fi

echo ""


# ──────────────────────────────────────────────
# CHECK 5: Hooks are executable
# ──────────────────────────────────────────────
echo -e "${BOLD}Checking hooks...${RESET}"

if [ -f "hooks/pre-tool.sh" ]; then
  if [ -x "hooks/pre-tool.sh" ]; then
    echo -e "  ${GREEN}✓${RESET} hooks/pre-tool.sh (executable)"
  else
    echo -e "  ${YELLOW}⚠${RESET} hooks/pre-tool.sh exists but is not executable — run: chmod +x hooks/pre-tool.sh"
    WARNINGS=$((WARNINGS + 1))
  fi
else
  echo -e "  ${YELLOW}⚠${RESET} hooks/pre-tool.sh not found — no pre-tool hook configured"
fi

echo ""


# ──────────────────────────────────────────────
# CHECK 6: config.json TODO placeholders
# ──────────────────────────────────────────────
echo -e "${BOLD}Checking config.json for placeholders...${RESET}"

CONFIG_TODO_COUNT=$(grep -c '"TODO:' config.json 2>/dev/null || echo "0")
if [ "$CONFIG_TODO_COUNT" -gt 0 ]; then
  echo -e "  ${YELLOW}⚠${RESET} Found $CONFIG_TODO_COUNT TODO placeholder(s) in config.json"
  WARNINGS=$((WARNINGS + 1))
else
  echo -e "  ${GREEN}✓${RESET} No TODO placeholders in config.json"
fi

echo ""


# ──────────────────────────────────────────────
# RESULT
# ──────────────────────────────────────────────
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if [ "$ERRORS" -gt 0 ]; then
  echo -e "${RED}${BOLD}Build failed: $ERRORS error(s), $WARNINGS warning(s)${RESET}"
  echo ""
  echo "Fix the errors above before testing your harness."
  exit 1
elif [ "$WARNINGS" -gt 0 ]; then
  echo -e "${YELLOW}${BOLD}Build passed with $WARNINGS warning(s)${RESET}"
  echo ""
  echo "Your harness is ready to test, but review the warnings above."
  exit 0
else
  echo -e "${GREEN}${BOLD}Build passed — harness is ready! ✓${RESET}"
  echo ""
  echo "Run ./scripts/test.sh to test your harness with a sample scenario."
  exit 0
fi
