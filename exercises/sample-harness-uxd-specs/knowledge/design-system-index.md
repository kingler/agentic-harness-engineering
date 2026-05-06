# Design System Component Index

Authoritative list of component names. The validator
(`scripts/validate_spec.sh`) cross-references any backticked CapitalCase
identifier in a spec against this list. Mismatches are warnings.

When you add a component to the design system, add it here in the same
commit. When you rename one, update every spec that references it.

## Inputs

- `Button`
- `IconButton`
- `Checkbox`
- `Radio`
- `Switch`
- `TextField`
- `Textarea`
- `Select`
- `Combobox`
- `DatePicker`
- `Slider`

## Display

- `Avatar`
- `Badge`
- `Card`
- `Chip`
- `Divider`
- `Tag`
- `Tooltip`

## Feedback

- `Alert`
- `Banner`
- `Toast`
- `Modal`
- `Drawer`
- `Spinner`
- `ProgressBar`
- `Skeleton`

## Navigation

- `Breadcrumbs`
- `Tabs`
- `Pagination`
- `Stepper`
- `Sidebar`
- `Topbar`

## Layout

- `Grid`
- `Stack`
- `Container`

## Notes

- Names are case-sensitive.
- Compound components (e.g. `Tabs.Panel`) are referenced by the parent
  component name only (`Tabs`).
- Aliases are not supported. If the team has a colloquial name, file a PR
  to update the index.
