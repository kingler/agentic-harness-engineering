# Build workflow — plan before you build

This project is built in a fixed order. Do not skip ahead.

1. **Plan first.** The first step is always to write the plan. It is derived
   from the app brief (`app-brief.md`) — the chosen app's **core features**,
   its **value proposition**, and the **problem it solves**. Run `/plan-app`
   to produce `plan/PLAN.md`, `plan/wireframes.md`, and `plan/tech-spec.md`.
2. **Bootstrap from the plan.** Run `/bootstrap-harness` to scaffold the
   project tree (system prompt, skills, rules, hooks, tools, MCPs).
3. **Build the frontend** from `plan/wireframes.md`.
4. **Wire** the agent surfaces to the harness tools and hooks.
5. **Test** the golden path end-to-end.

If asked to build the app before a plan exists in `plan/`, stop and run
`/plan-app` first. Never generate UI or tool logic without the plan and the
scaffolded tree in place.
