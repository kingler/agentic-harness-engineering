# MABOS Desktop App Implementation Plan

Date: 2026-04-30

## 1. Product Scope From Figma

The MABOS design file defines a desktop-first AI business operating system with these product surfaces:

- Landing page: product positioning and conversion CTA.
- New business onboarding: 5-step flow covering welcome, business context, team/resources, AI generation, and review/launch.
- Existing business onboarding: 10-step flow covering business identity, credentials, description, SaaS stack, research summary, vision/mission, values, BMC auto-population, and completion.
- Workspace dashboard: high-level operating view.
- Goals: list, create dialog, delete confirmation, toast states, and empty state.
- Plans: planning workspace.
- Tasks: execution workspace.
- Actions: atomic next-action workspace.
- Chat: AI operating assistant.
- Design tokens: currently empty, so implementation should establish the token system.

The app should feel like a local-first desktop workspace: fast startup, responsive interactions, offline access to business models/goals/tasks, secure handling of credentials, and explicit AI-generated outputs that can be reviewed before they become operational records.

## 2. Recommended Tech Stack

### Primary Recommendation

Use **Tauri 2 + React + TypeScript + Vite + SQLite + Rust command layer**.

| Layer | Choice | Why |
|---|---|---|
| Desktop shell | Tauri 2 | Small, fast, secure cross-platform desktop shell using the OS webview, with Rust for privileged logic and a capability/permission model. |
| UI | React 19 + TypeScript + Vite | Best fit for the Figma web-style screens, broad component ecosystem, fast iteration, strong desktop-web compatibility. |
| Styling | Tailwind CSS v4 + CSS variables | Fast translation from Figma, scalable token system, easy dark UI implementation. |
| Component base | Radix UI primitives or shadcn-style local components | Accessible dialogs, selects, tabs, toasts, menus, and form controls without locking the app to a SaaS-heavy UI kit. |
| App state | Zustand for UI state, TanStack Query for async/server state | Simple local state plus robust async workflows, retries, cache invalidation, and mutation states. |
| Local database | SQLite | File-based, reliable, no server requirement, strong fit for local-first desktop data. |
| ORM/query layer | Drizzle ORM with SQLite/libSQL driver | TypeScript-native schema, explicit SQL-friendly model, lighter than Prisma for a desktop app. |
| Search | SQLite FTS5 | Built-in full-text search for goals, plans, tasks, chats, and business research notes. |
| AI integration | OpenAI Responses API with Structured Outputs | Schema-constrained generation for goals, plans, tasks, business model canvas fields, and onboarding extraction. |
| Background jobs | Rust sidecar commands plus JS queue state | Keep AI generation, file IO, imports, and secure credential workflows off the UI thread. |
| Packaging | Tauri bundler | Native installers for macOS, Windows, and Linux. |
| Testing | Vitest, React Testing Library, Playwright, Rust tests | Unit, component, workflow, and native command coverage. |

### Why Not Electron As The Default

Electron is mature and has excellent Node/Chromium compatibility, but it bundles Chromium and uses a multi-process architecture inherited from Chromium. That is useful when deep Node/Chromium compatibility is the main requirement, but MABOS is a controlled app with known UI surfaces, local data, and a need for a polished small desktop distribution. Tauri is a better default unless we discover a hard dependency on Node-native packages inside the renderer, complex browser extension behavior, or Electron-only ecosystem requirements.

### Why Not Flutter As The Default

Flutter desktop is viable for native-feeling cross-platform apps, but the MABOS design is a web-app-like productivity workspace with forms, tables, dialogs, chat, command surfaces, and a likely need for rapid AI workflow iteration. React/Tauri maps more directly to the Figma layout and to the TypeScript AI/data ecosystem. Flutter is a fallback if the priority shifts toward a fully custom native-rendered UI across desktop and mobile.

### Why Not Wails As The Default

Wails is strong if the backend is Go-first. MABOS benefits more from Rust's security posture in Tauri, Tauri's current cross-platform/mobile direction, and the larger Tauri plugin ecosystem for desktop permissions, updater, filesystem, windows, and shell capabilities.

## 3. Architecture

### Process Boundaries

MABOS should use a strict boundary between the UI and privileged operations:

- Renderer: React UI, local form state, optimistic state, route-level screens.
- Tauri Rust core: database access, filesystem access, credential storage, AI request proxying, import/export, background job orchestration.
- Remote APIs: OpenAI and optional SaaS connectors. API keys should never live in renderer code.

### Data Model

Core entities:

- `Workspace`: local business workspace.
- `BusinessProfile`: name, industry, stage, business type, description, audience, value proposition.
- `CredentialSource`: metadata for connected SaaS tools; secrets stored in OS keychain/secure store, not SQLite.
- `ResearchArtifact`: imported or AI-generated business context, citations, summaries.
- `VisionMission`: vision, mission, rationale, revision history.
- `CoreValue`: value, description, behavioral examples.
- `BusinessModelCanvas`: customer segments, value propositions, channels, relationships, revenue streams, resources, activities, partners, cost structure.
- `Goal`: strategic objective with status, owner, target date, confidence, source.
- `Plan`: decomposition of one or more goals.
- `Task`: executable unit assigned to a plan.
- `Action`: smallest next action, usually tied to a task and status.
- `ChatThread` and `ChatMessage`: AI assistant context and conversation history.
- `GenerationJob`: background AI job with status, prompt version, schema version, input hash, output, and review state.
- `AuditEvent`: local event log for AI-generated or user-approved changes.

### AI Contract

All AI generation should return typed records, not free-form text blobs.

Use Structured Outputs for:

- Onboarding extraction from business descriptions.
- Business model canvas auto-population.
- Goal generation.
- Goal-to-plan decomposition.
- Plan-to-task decomposition.
- Task-to-action decomposition.
- Research summary extraction.
- Chat assistant tool calls.

Each generated object should include:

- `title`
- `description`
- `rationale`
- `confidence`
- `assumptions`
- `sourceInputs`
- `requiresReview`

Generated records must be staged first, then accepted, edited, or discarded by the user.

## 4. Phased Plan

### Phase 0: Product And Technical Foundation

Outcome: repo is ready for desktop app development with a clear domain model and build pipeline.

Tasks:

- Create Tauri 2 app scaffold with React, TypeScript, Vite, and pnpm.
- Set up Tailwind CSS, design tokens, routing, linting, formatting, and test runners.
- Define app routes matching Figma pages.
- Establish token primitives: background, surface, border, text, muted text, primary blue, success, warning, danger, radius, spacing, type scale.
- Create base shell components: app window frame, navbar, sidebar, page header, command button, dialog, toast, form field, text input, textarea, segmented control, progress indicator, data card, empty state.
- Add CI checks: typecheck, lint, unit tests, build, Tauri build smoke check.

Validation gate:

- App launches locally as a desktop shell.
- Landing and empty workspace route render without data.
- Figma token mapping is documented in code.

### Phase 1: Local Data And Workspace Skeleton

Outcome: local-first workspace can persist and retrieve core records.

Tasks:

- Add SQLite database in app data directory.
- Add Drizzle schema and migrations.
- Implement Rust commands for database initialization, migrations, CRUD, and transactional writes.
- Add typed IPC bridge between React and Rust commands.
- Implement workspace creation and workspace selection.
- Implement audit events for create/update/delete operations.
- Add FTS5 virtual tables for searchable business profile, goals, plans, tasks, actions, and chat messages.

Validation gate:

- Create a workspace, restart the app, and recover all saved data.
- CRUD tests cover each core entity.
- Search returns expected local records.

### Phase 2: Landing And New Business Onboarding

Outcome: the 5-step new business onboarding flow works end to end.

Tasks:

- Build Landing route from Figma: navbar, hero, CTA row.
- Build New Business onboarding screens:
  - Step 1: welcome, business name, industry, stage.
  - Step 2: problem solved, target customers, value proposition.
  - Step 3: team size, monthly budget, key capabilities.
  - Step 4: AI generating state and progress events.
  - Step 5: generated goals review and launch.
- Add route guards for incomplete onboarding.
- Persist partial onboarding drafts locally.
- Add form validation with Zod.
- Add review model for generated goals.

Validation gate:

- User can complete onboarding offline up to generation.
- User can resume an interrupted onboarding session.
- Generated goal placeholders can be accepted, edited, or discarded.

### Phase 3: AI Generation Pipeline

Outcome: MABOS can reliably generate typed strategic records from onboarding input.

Tasks:

- Implement OpenAI client in Rust or secure backend command layer.
- Add prompt/version registry for each generation workflow.
- Add Structured Output schemas for goals, plans, tasks, actions, BMC, research summary, vision/mission, and values.
- Implement `GenerationJob` queue with statuses: queued, running, succeeded, failed, cancelled, requires_review, accepted.
- Add retry policy for transient API failures.
- Add user-visible error and refusal states.
- Add token/cost logging per job.
- Add deterministic test fixtures for AI outputs.

Validation gate:

- Generation produces schema-valid records.
- Invalid/refused outputs are handled without corrupting workspace data.
- Accepted records are audit logged.

### Phase 4: Existing Business Onboarding

Outcome: the 10-step existing business onboarding flow captures richer business context.

Tasks:

- Build screens:
  - Business type selection.
  - Business identity.
  - Business credentials.
  - Business description.
  - SaaS platform stack.
  - Research summary.
  - Vision and mission.
  - Core values.
  - BMC auto-populate.
  - Review and complete.
- Add credential-source metadata without storing secrets in SQLite.
- Add connector placeholders for tools that are not implemented yet.
- Add AI research summary workflow from user-provided descriptions and imported notes.
- Add BMC review/edit UI.

Validation gate:

- User can complete flow without external SaaS connections.
- BMC, vision, mission, and values are editable before final acceptance.
- Credentials are represented as secure connection states, not plain local text.

### Phase 5: Workspace Dashboard

Outcome: post-onboarding workspace gives an executive operating view.

Tasks:

- Build Dashboard route.
- Add summary cards: active goals, plans in progress, overdue tasks, actions due today, AI recommendations.
- Add recent activity from `AuditEvent`.
- Add generation status panel.
- Add local search entry point.
- Add empty and loading states.

Validation gate:

- Dashboard reflects local data changes immediately.
- No route requires remote network access to render.

### Phase 6: Goals Module

Outcome: users can manage strategic goals.

Tasks:

- Build goals list view, create dialog, delete dialog, success/error toasts, and empty state from Figma.
- Add filters by status, owner, timeframe, source, and confidence.
- Add goal detail drawer/page.
- Add goal acceptance workflow for AI-generated goals.
- Add goal revision history.
- Add goal-to-plan generation action.

Validation gate:

- Manual and AI-generated goals share one data model.
- Goal deletion is guarded and audit logged.
- Goal creation works offline.

### Phase 7: Plans, Tasks, And Actions

Outcome: MABOS can decompose strategy into execution.

Tasks:

- Build Plans route with plan list, plan detail, goal relationships, milestones, and progress.
- Build Tasks route with task list, status workflow, owner, due date, priority, dependencies.
- Build Actions route with daily action queue and completion workflow.
- Add AI decomposition commands:
  - Goal to plans.
  - Plan to tasks.
  - Task to actions.
- Add bulk review UI for generated plans/tasks/actions.

Validation gate:

- A user can move from goal to plan to task to action in one workspace.
- AI-decomposed items are never committed without review.
- Progress rolls up correctly from actions to tasks to plans to goals.

### Phase 8: Chat Assistant

Outcome: users can ask MABOS questions and trigger safe local actions.

Tasks:

- Build Chat route.
- Add chat threads scoped to workspace.
- Add retrieval context from local SQLite records and FTS5 search.
- Add tool schema for safe actions:
  - create draft goal
  - create draft plan
  - summarize workspace
  - search records
  - explain progress
- Require confirmation before mutating workspace data.
- Add citations to local records used in answers.

Validation gate:

- Chat answers can cite local workspace records.
- Tool calls are schema-constrained and require confirmation for writes.
- Chat history persists locally.

### Phase 9: Desktop-Native Features

Outcome: MABOS feels like a real desktop product.

Tasks:

- Add native menus and keyboard shortcuts.
- Add secure credential storage.
- Add import/export for JSON and Markdown.
- Add backup and restore.
- Add updater strategy.
- Add app settings: theme, AI provider key, data location, telemetry preference.
- Add file association or drag-and-drop imports if needed.

Validation gate:

- App can export a complete workspace backup and restore it.
- App can be packaged for at least macOS and Windows.
- Sensitive settings are not exposed in renderer logs or SQLite.

### Phase 10: Quality, Security, And Release

Outcome: app is ready for private beta.

Tasks:

- Threat model Tauri commands and capability files.
- Minimize Tauri permissions by window.
- Add error reporting with user consent.
- Add performance budgets:
  - cold launch target under 2 seconds on modern desktop hardware.
  - route transition under 150 ms for local data.
  - AI generation progress visible within 500 ms.
- Add Playwright route coverage for all Figma surfaces.
- Add migration rollback/recovery tests.
- Add signed builds and release checklist.

Validation gate:

- Private beta build is signed, installable, and smoke-tested.
- All core routes have automated coverage.
- Database migrations are tested from clean install and prior version.

## 5. Milestone Map

| Milestone | Scope | Target |
|---|---|---|
| M0 | Scaffold, tokens, shell, local DB | Developer alpha |
| M1 | New business onboarding + AI goal generation | First usable product loop |
| M2 | Dashboard + Goals | Strategy workspace usable |
| M3 | Plans + Tasks + Actions | Execution hierarchy usable |
| M4 | Existing business onboarding + BMC | Rich business import loop |
| M5 | Chat assistant + local retrieval | AI operating assistant usable |
| M6 | Desktop-native packaging, backup, security | Private beta |

## 6. Key Risks And Mitigations

| Risk | Impact | Mitigation |
|---|---|---|
| AI output quality is inconsistent | Bad strategic records | Use strict schemas, staged review, prompt versioning, and user-editable drafts. |
| Local-first sync is underestimated | Data conflicts later | Start local-only, design IDs/revision history now, add sync as a separate milestone. |
| Tauri permissions become too broad | Security exposure | Define minimal capability files per window and command. |
| Credentials are mishandled | High security risk | Store secrets only in OS secure storage; keep SQLite to metadata and connection states. |
| Figma design lacks tokens | Inconsistent UI | Create implementation tokens in Phase 0 and map every component to them. |
| Desktop packaging surprises | Release delay | Add Tauri build smoke checks early, not at the end. |

## 7. Research Notes

- Tauri 2 is a strong fit because it supports small, fast, secure cross-platform apps using a web frontend and Rust core, and it has a permissions/capabilities model for controlling frontend access to native operations.
- Electron remains the fallback if the product requires Chromium-specific behavior or deep Node compatibility in the app shell.
- Flutter remains the fallback if the product priority shifts to a custom native-rendered UI rather than fast TypeScript/web iteration.
- Wails remains the fallback if the backend becomes Go-first.
- SQLite is the best initial persistence layer because the app should be useful offline and local-first from the start.
- Structured Outputs are important because MABOS creates operational records, not just prose. AI responses must map into validated schemas.

## 8. Source Links

- Tauri 2 overview: https://tauri.app/
- Tauri prerequisites: https://v2.tauri.app/start/prerequisites/
- Tauri capabilities/security model: https://v2.tauri.app/fr/security/capabilities/
- Electron process model: https://www.electronjs.org/docs/latest/tutorial/process-model
- Flutter desktop support: https://docs.flutter.dev/platform-integration/desktop
- Wails introduction: https://wails.io/docs/next/introduction
- SQLite FTS5: https://www.sqlite.org/fts5.html
- Drizzle SQLite docs: https://orm.drizzle.team/docs/get-started/sqlite-new
- OpenAI Structured Outputs: https://platform.openai.com/docs/guides/structured-outputs
