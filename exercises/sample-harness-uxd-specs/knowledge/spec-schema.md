# Spec Schema

Every file under `specs/` (except `templates/`) follows this schema. The
validator (`scripts/validate_spec.sh`) reports violations as either errors
(must fix) or warnings (should fix).

## Filename

`SPEC-YYYY-NNN.md` — year is the year the spec was created, NNN is a
zero-padded sequence allocated by `create_spec.sh`. Example:
`SPEC-2026-007.md`.

## Frontmatter (YAML)

Required fields, in this order:

| Field      | Type    | Notes                                                     |
| ---------- | ------- | --------------------------------------------------------- |
| `id`       | string  | Must equal the filename stem.                             |
| `title`    | string  | Human-readable. Becomes the H1.                           |
| `type`     | enum    | `ux-flow`, `component`, `research`, `prd`.                |
| `status`   | enum    | `draft`, `in-review`, `approved`, `implemented`, `archived`. |
| `owner`    | string  | Single username, e.g. `jane.doe`.                         |
| `created`  | date    | ISO 8601 (`YYYY-MM-DD`).                                  |
| `updated`  | date    | ISO 8601. Set by the post-tool-use hook on every edit.    |
| `version`  | semver  | `MAJOR.MINOR.PATCH`. Patch auto-bumps on edits.           |

Optional fields:

| Field             | Type     | Notes                                            |
| ----------------- | -------- | ------------------------------------------------ |
| `designers`       | list     | Collaborators beyond `owner`.                    |
| `design_reference` | url      | Optional link to sketches, PRD, wiki, or in-repo UX notes. |
| `linked_specs`    | list     | SPEC IDs of related specs.                       |
| `linked_components` | list   | Names from `design-system-index.md`.             |
| `revises`         | string   | Previous SPEC ID this revision supersedes.       |
| `tags`            | list     | Free-form labels.                                |

## Required sections

All eight sections must be present, in this order:

1. `# <Title>` — H1, must match `title:` frontmatter.
2. `## Problem` — what's broken or missing.
3. `## Users` — who feels this.
4. `## Goals & Non-goals` — explicit scope.
5. `## Flow` — the proposed solution as a sequence.
6. `## Acceptance criteria` — testable bullets.
7. `## Accessibility` — WCAG-relevant considerations.
8. `## Open questions` — known unknowns. May be empty but must exist.

## Validation rules

- **frontmatter.required** (error) — required field missing.
- **section.required** (error) — required section missing.
- **section.order** (error) — required section out of order.
- **link.spec_id** (error) — internal SPEC ID does not resolve.
- **design_system.unknown_component** (warning) — backticked CapitalCase
  identifier not in the design system index.
- **frontmatter.field_order** (warning) — fields present but out of canonical
  order.

`--strict` promotes all warnings to errors. The transition script uses
strict mode before moving a spec to `in-review` or `approved`.
