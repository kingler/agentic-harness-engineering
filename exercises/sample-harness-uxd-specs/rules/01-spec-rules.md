# Project Rules — Spec Steward

These rules are loaded by RooCode/Cline-style harnesses from `.roo/rules/` and
mirrored here. The same rules appear, condensed, in `AGENTS.md` and
`prompts/system-prompt.md`. When two rules conflict, the **more specific**
rule wins. When a rule says "never," there is a hook in `hooks/` that
enforces it — do not rely on the model to remember.

## Ownership and IDs

- **R-01.** A SPEC ID (`SPEC-YYYY-NNN`) is allocated **once** by
  `scripts/create_spec.sh` and is **immutable**. Never reassign, never
  rename a file to change the ID.
- **R-02.** Every spec has exactly one `owner:` (a single username). For
  multi-author specs, list collaborators in `designers:`.
- **R-03.** When a spec is revised (`create_spec --revise <id>`), the new
  spec gets a fresh ID and a `revises: <old-id>` frontmatter field. The old
  spec stays in place; do not delete it.

## Workflow

- **R-10.** Status changes go through `scripts/transition_status.sh`.
  Hand-editing the `status:` frontmatter field is blocked by
  `hooks/pre-tool-use.sh`.
- **R-11.** Allowed transitions: `draft → in-review`, `in-review → approved`,
  `in-review → draft` (rejected back), `approved → implemented`, and
  `* → archived`. No other path is legal.
- **R-12.** Transition to `approved`, `implemented`, or `archived` requires
  a `--reason` string. The reason is appended to the spec as an HTML comment
  history line.
- **R-13.** Before any transition to `in-review` or `approved`, run
  `validate_spec --strict`. The transition script does this automatically; do
  not skip the check by editing in place.

## Edits and locking

- **R-20.** A spec with `status: approved` or `status: implemented` is
  locked. Use `create_spec --revise` to propose changes. The pre-tool-use
  hook blocks direct edits.
- **R-21.** Writes are restricted to `specs/`, `knowledge/`, and `notes/`.
  The pre-tool-use hook enforces this with `realpath -m`.
- **R-22.** Frontmatter field order is fixed: `id`, `title`, `type`,
  `status`, `owner`, then everything else. The validator warns on order
  drift.

## Cross-references

- **R-30.** Every internal SPEC ID referenced in a spec must resolve to an
  existing file. Broken references are validation errors, not warnings.
- **R-31.** Bidirectional links: when spec A references spec B, and the
  reference is structural (`linked_specs:` or "blocks", "blocked-by",
  "supersedes"), spec B should reference spec A back. The validator warns
  when the back-link is missing; the agent should offer to add it.
- **R-32.** Component names referenced in a spec (in backticks) must match
  `knowledge/design-system-index.md` exactly. Case-sensitive. Unknown
  components are warnings; the validator reports them.

## External integrations

- **R-40.** Calls to the Linear MCP server that mutate state
  (`save_issue`, `save_comment`, `create_attachment`) require explicit user
  confirmation in the same turn. The agent does not auto-link tickets.
- **R-41.** The Figma MCP server is read-only from this harness. No mutating
  Figma endpoints are called, ever.
- **R-42.** The GitHub MCP server is enabled only when the user invokes
  `/publish-spec`. Do not call it otherwise.

## Communication

- **R-50.** End every turn with one sentence: what changed and what's next.
- **R-51.** If a tool call fails twice for the same reason, stop. Surface
  the failure to the user with the failing rule and ask before retrying.
- **R-52.** Refuse politely when asked to write code, generate Figma
  frames, or send messages — point the user to the right tool.

## Memory

- **R-60.** Cross-turn working notes live in `notes/SESSION.md`. Never put
  secrets, tokens, or PII in notes. The post-tool-use hook also writes a
  one-line audit to `notes/SESSION.log` on every tool invocation.
