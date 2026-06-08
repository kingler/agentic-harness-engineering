# Workflows Review — "6 patterns for Claude Code dynamic workflows" → deck

Source: YouTube walkthrough of Anthropic's **dynamic workflows** guide for
Claude Code (reviewed 2026-06-08).
Goal: review the deck's existing Workflows section against the transcript and
identify how to **incorporate workflows as a harness component** in
`Agentic Harness Engineering.html`.

**Verified.** The feature and taxonomy are real and citable from Anthropic's
own posts — and the framing the user wants is literally their title:

- *Introducing dynamic workflows in Claude Code* —
  `claude.com/blog/introducing-dynamic-workflows-in-claude-code`
- *A harness for every task: dynamic workflows in Claude Code* —
  `claude.com/blog/a-harness-for-every-task-dynamic-workflows-in-claude-code`

The six patterns — classify-and-act, fan-out-and-synthesize, adversarial
verification, generate-and-filter, tournament, loop-until-done — are Anthropic's
own composable set.

---

## 1. The reframe that makes this a *harness* topic

The transcript's core claim is exactly the bridge we want: **a dynamic
workflow is Claude Code designing and building a harness on the fly — a small
machine custom-built for the task.** Anthropic titled the post "a harness for
every task." That lets us stop treating workflows as a loosely-related "bonus"
and position them as the **orchestration layer of the harness**: the thing that
*assembles the other six components per task* and can itself be packaged and
shared like a skill.

This also closes a loop the deck already opens:

- Rings slide (`07`) already puts **orchestration** in the outer harness ring.
- "What models can't do" (`08`) lists **coordinate with others → orchestration**
  and **verify their own output → self-evaluation loops**.
- The anatomy treats skills/tools/hooks as packaged files.

Workflows are where all three land at once. They deserve to be named as the
**orchestration component**, not a side topic.

---

## 2. What the deck has today vs. what the transcript adds

**Today (slides 29–33 / labels `39`–`41`):** one *shape* of workflow — a long,
linear, multi-day pipeline (SPEC→ship), plus swimlanes/guards and the
meta-vs-template prompt distinction. Good for "long-running governance," but:

- It shows **one** hand-built pipeline, not a **vocabulary** of reusable shapes.
- It never names **why a single context window fails** on long tasks.
- It doesn't treat a workflow as a **shareable file artifact**.
- Workflows are framed as "Bonus," not as a harness component.

**The transcript adds four things we lack:**

1. **The "why" — three failure modes of one long context window:**
   - **Agent laziness** — give it 15 tasks, it does 7.
   - **Self-preference** — a session grading its own output is biased upward.
   - **Goal drift** — after many compactions/tool calls, the original intent
     erodes.
   Workflows fix these by giving **each subproblem its own fresh, isolated
   context** (Sonnet 4.6 by default). This maps directly onto our existing
   "context rot" / compaction material and the self-verification gap.

2. **A pattern vocabulary (the six shapes)** — the missing catalog.

3. **Composition** — patterns *stack* (fan-out → adversarial-verify →
   loop-until-done), and you steer them with keywords rather than hand-wiring.

4. **Workflows are shareable like skills** — a workflow ships as a folder:
   a **`.js` workflow file + `SKILL.md` + supporting markdown (e.g. `rubric.md`)**.
   `/workflows` lists/saves a running one. This makes "the harness is mostly
   files" extend cleanly to orchestration.

---

## 3. The six patterns, each mapped to the harness components it leans on

This mapping is the heart of "workflows as a harness component" — every pattern
is just a way of wiring the six components we already teach.

| Pattern | What it does | Harness components it uses |
|---|---|---|
| **Classify & act** | A classifier routes each item to the right handler (inbox triage: bug / refund / spam / dup). | A classifier **skill** + **system-prompt** scope per handler; quarantines input before a trusted agent acts. |
| **Fan out & synthesize** | Split into mutually-exclusive subtasks, one **isolated** agent each, then a barrier merge (deep research, due-diligence red-flag memo). | **Subagents / orchestration** + structured **tool** outputs + **knowledge** citations (every claim links to its source file). |
| **Adversarial verification** | A separate skeptic agent challenges each result against a rubric — kills **self-preference**. | **Rubric in `knowledge/`** + verifier **subagents** + **hooks/evals**; isolation removes the self-grading bias. |
| **Generate & filter** | Over-generate many candidates, then a **judge** (different agent) filters by rubric (title/name/idea ideation). | Generator vs. judge **subagents** + **rubric**; "generator ≠ judge" is separation-of-concerns. |
| **Tournament** | Pairwise brackets, a **fresh context** per match, rubric can change per round (rank 5,000 résumés without bias/bloat). | A deterministic **loop** holds the bracket; per-round **rubric (knowledge)**; isolation per match. |
| **Loop until done** | No fixed count — keep spawning agents until a stop predicate holds (reproduce a flaky 1-in-50 bug). | A **hook/loop** with an **outcome predicate** (like `/goal`); the "every-time / until-true" discipline we teach for hooks. |

Two patterns are direct answers to gaps the deck already names:
**adversarial verification** ↔ the "verify their own output" gap on slide 08;
**fan-out isolation / fresh context** ↔ the context-rot + goal-drift material on
the knowledge/memory notes.

---

## 4. How to incorporate it — concrete deck changes

Ordered by leverage. All additive; respects the existing structure.

1. **Reframe the Workflows overview (`39`) with the one-liner + the three
   failure modes.** Add to the slide/lede or speaker note: "A workflow is a
   harness Claude builds on the fly — a machine for one task. It exists because
   a single long context window drifts: laziness, self-preference, goal drift.
   Each stage gets a fresh, isolated context instead." This is the strongest
   single upgrade and needs no new slide.

2. **New slide: "Six workflow patterns" (a 2×3 catalog)** placed in the bonus
   section right after the overview (`39`), before the SPEC example (`39b`).
   Each card = pattern name · one-line use · the components it wires (column 3
   of the table above). This turns our single pipeline into a vocabulary.

3. **Position workflows as the orchestration component** on the anatomy framing.
   Don't renumber the six core components — instead add a line on `10 Six Core
   Components` / `9b Anatomy in Files`: "A **workflow** is the seventh thing —
   the orchestration layer that sequences the other six, and a packaged harness
   in its own right." Reinforces the rings slide's outer "orchestration" ring.

4. **Workflow as a shareable file artifact.** On `9b Anatomy in Files`, add a
   workflow folder to the tree (`workflows/verify-claims/` → `SKILL.md`,
   `verify-claims.workflow.js`, `rubric.md`) and note `/workflows` save/share.
   Extends "the harness is mostly files" to orchestration, and mirrors how we
   already teach skills/tools as files.

5. **"When NOT to use" + token budget → anti-patterns slide (`42b`).** Add one
   anti-pattern: "Workflow overkill — spinning up an agent swarm to recolor a
   button. Workflows are token-heavy; reserve them for large or multi-layer
   tasks, and tell the agent its budget." Pairs with our existing "cap tools at
   ~7" restraint message.

6. **Tie it back in Takeaways (optional).** A half-line under the orchestration
   idea: "Workflows = a harness per task, assembled from the same six parts."

7. **Resources slide.** Add the two Anthropic posts (introducing + "a harness
   for every task") — primary, on-brand citations.

---

## 5. Slide / note mapping at a glance

| Transcript content | Target | Use |
|---|---|---|
| "A workflow is a harness built on the fly" + 3 failure modes | `39` overview + note | Reframe; the *why* |
| The six patterns | **new catalog slide** after `39` | Pattern vocabulary |
| Each pattern → components | new slide col 3 + speaker note | The "as a component" bridge |
| Fresh isolated context per subproblem | `39` note; ties to context-rot note | Mechanism |
| Stacking patterns with keywords | new slide footnote / `39c` note | Composition |
| Share as folder (JS + SKILL.md + rubric.md), `/workflows` | `9b Anatomy in Files` | Shareable artifact |
| When NOT to use + token budget | `42b` anti-patterns | Restraint |
| Anthropic posts | `44 Resources` | Citations |

---

## 6. Recommendation

Incorporate workflows as the **orchestration component** of the harness: keep
the six core components intact, but name the workflow as the layer that
sequences them and as a packaged, shareable harness in its own right. The single
new slide (the six-pattern catalog, with the components-used column) plus the
overview reframe and the file-tree/anti-pattern touches are enough to make the
point without bloating the bonus section. Everything here is verified against
Anthropic's own posts, so it can go on-slide, not just in notes.
