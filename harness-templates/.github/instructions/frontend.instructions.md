---
applyTo: "**/*.{ts,tsx,js,jsx}"
---

# Frontend Code Style — Path-Scoped

These rules apply only to JavaScript / TypeScript files. They are loaded by
GitHub Copilot via the `applyTo` front-matter glob.

## Rules

- Prefer named exports. Default exports only for pages / route components.
- Use `function` declarations for components and `const` for hooks.
- Tailwind utility classes; never inline `style={{}}` unless animating.
- All async functions return `Promise<Result<T, Error>>` — no thrown errors
  across module boundaries.
- Tests live next to the file they test as `<name>.test.ts(x)`.

## Anti-patterns

- `any` — use `unknown` and narrow.
- `useEffect` for derived state — derive in render.
- Toast on success — only on failure or explicit user request.
