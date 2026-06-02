# Progress — where am I in the build?

Tick these as you go. The breakouts are a chain (see [`SEQUENCE.md`](./SEQUENCE.md));
each step's output feeds the next. If you fall behind, finish the *current*
component well rather than half-doing the next — a sharp `AGENTS.md` beats six
stubs.

## Day 0 — setup
- [ ] [`SETUP.md`](./SETUP.md) complete — extension installed, **smoke test passed**.
- [ ] App chosen and [`app-brief.md`](./app-brief.md) filled (core features ·
      value prop · problem).

## Day 1 — build the components (one lab card each, in `labs/`)
- [ ] **Lab 1 — System prompt** (`labs/01-system-prompt.md`) → `AGENTS.md` written; persona + refusal tested.
- [ ] **Lab 2 — Skill** (`labs/02-skill.md`) → one skill; trigger fires, doesn't over-fire.
- [ ] **Lab 3 — Tools (+ MCP)** (`labs/03-tools.md`) → one tool; right-tool-first + WHEN-NOT restraint.
- [ ] **Lab 4 — Rules + hooks** (`labs/04-rules-hooks.md`) → the "never" blocked by the hook, even under "I'm the admin".
- [ ] **Lab 5 — Knowledge + memory** (`labs/05-knowledge-memory.md`) → grounded answer + recall across a turn.

## Day 2 — assemble, build, prove (slash-command chain; README Steps 1–4)
- [ ] **Plan** — `/plan-app` → `plan/PLAN.md` + wireframes + tech-spec.
- [ ] **Bootstrap** — `/bootstrap-harness` (fills your Day-1 components into the chosen editor; **augments, doesn't overwrite**).
- [ ] **Build frontend** — generated from `plan/wireframes.md` into `app/`.
- [ ] **Test** — `/test-harness`; each component's test prompt emits its artifact, consistently.

## Done when
- [ ] `/test-harness` reports **Overall: PASS** — model invoked, every in-scope
      component fired, artifacts consistent across runs.
- [ ] You can run the golden path live and get the **headline artifact** every time.
- [ ] You have one demo task ready (5 min).
