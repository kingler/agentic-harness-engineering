# Spec Workflow

```
                ┌────────┐
   create_spec  │ draft  │ ◄────────────┐ (rejected back from review)
   ───────────► │        │              │
                └───┬────┘              │
                    │ transition_status │
                    │   --to in-review  │
                    ▼                   │
                ┌──────────┐            │
                │in-review │ ───────────┘
                │          │
                └────┬─────┘
                     │ --to approved (requires --reason)
                     ▼
                ┌──────────┐
                │approved  │  (locked — pre-tool-use hook blocks edits)
                │          │
                └────┬─────┘
                     │ --to implemented (requires --reason)
                     ▼
                ┌────────────┐
                │implemented │
                │            │
                └────┬───────┘
                     │
                     │ any state ──► archived (requires --reason)
                     ▼
                ┌──────────┐
                │ archived │
                └──────────┘
```

## State semantics

- **draft** — author is iterating. No external review expected. Edits free.
- **in-review** — circulated for design review. Required sections complete.
  Validation must pass strictly. Edits allowed; substantive changes should
  bump `version` minor.
- **approved** — sign-off recorded. Edits **blocked** by the pre-tool-use
  hook. Use `create_spec --revise <id>` to propose changes.
- **implemented** — shipped. Edits blocked. Used by `find_orphans` to detect
  approved/implemented specs no other spec references.
- **archived** — withdrawn or superseded. Excluded from default
  `find_orphans` and from most `list_specs` queries unless explicitly
  requested.

## Preconditions

| Transition                 | Preconditions                                              |
| -------------------------- | ---------------------------------------------------------- |
| `draft → in-review`        | `validate_spec --strict` passes.                           |
| `in-review → approved`     | `validate_spec --strict` passes; `--reason` required.      |
| `in-review → draft`        | `--reason` recommended (not required).                     |
| `approved → implemented`   | `--reason` required.                                       |
| `* → archived`             | `--reason` required.                                       |

The transition script enforces all preconditions. Any other transition is a
hard error.
