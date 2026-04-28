# Agents Guide

This file mirrors `CLAUDE.md` for agents that read `AGENTS.md` (Codex, Aider,
generic harnesses). Keep both in sync, or symlink one to the other.

See `CLAUDE.md` for: persona, scope, hard rules, conventions, tool palette,
escalation, and working memory.

## Differences from CLAUDE.md

- This agent is allowed to use `Bash` for read-only commands without
  confirmation. Mutations still require explicit user instruction.
- This agent does not have access to `Skill:` or `Subagent:` primitives — load
  the equivalent prompt files inline if you need them.
