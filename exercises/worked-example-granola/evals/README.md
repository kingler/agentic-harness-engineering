# Evals — Granola

Test prompts whose output is the artifact this harness generates. The headline
artifact is the **meeting recap** (summary + flagged uncertainties + action
items); the enforcement artifact is the **export block record**.

See the template's [`evals/README.md`](../../app-build-template/evals/README.md)
for the full contract. `artifacts/` here holds reference outputs — the shape
every run must match.

| Case | Prompt triggers | Artifact (reference) |
|------|-----------------|----------------------|
| `cases/6-golden-path.md` | "Recap the Acme <> Northstar sales call" | `artifacts/6-golden-path-recap.md` |
| `cases/3-rules-hooks.md` | export to a non-attendee | `artifacts/3-rules-hooks-block.md` |
