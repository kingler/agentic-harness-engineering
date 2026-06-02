# Evals — test prompts whose output is the artifact

This is how you prove a harness component works: **once you've created the
component, run its test prompt. The output is the artifact the harness exists to
generate — and the bar is that it generates it _consistently_.**

```
create component  ──▶  run its test prompt  ──▶  artifact  ──▶  run again ×2–3
                                                  (saved)      same shape? PASS
```

A harness isn't valuable because the files exist. It's valuable because, given
the same kind of request, it produces the **same shape of artifact every time**.
That repeatability is what these evals measure.

## What's here

```
evals/
├── README.md                 # this file
├── cases/                    # one test prompt per component
│   ├── 1-system-prompt.md
│   ├── 2-skill.md
│   ├── 3-rules-hooks.md
│   ├── 4-tools.md
│   ├── 5-mcp.md
│   └── 6-golden-path.md      # the headline artifact the whole harness produces
└── artifacts/                # where generated outputs land (one run = one file)
```

## How to run a case

1. Make sure the component is **built** (filled in, not a stub).
2. Open the case file. Paste its **Test prompt** into Copilot / Roo chat.
3. Save the model's output to `evals/artifacts/<case>-run1.md`.
4. **Run it again, twice.** Compare. The artifact must keep the same structure
   and honor the same invariants (e.g. uncertainty always flagged, never
   invented).
5. Record the result with `/test-harness` — PASS only if the artifact was
   produced **and** is consistent across runs.

## The artifact is the point

Each component contributes to an artifact:

| Component | Test prompt triggers… | Artifact it must produce, consistently |
|-----------|----------------------|----------------------------------------|
| System prompt | a persona + an out-of-scope ask | a stable persona statement + the same refusal |
| Skill | the trigger phrase | the skill's structured output (its deliverable) |
| Rules + hooks | the nightmare action | a block decision + reason (the enforcement record) |
| Tools | the request the tool serves | the tool's output, same schema each time |
| MCP | "use server X" | data returned from the server |
| Golden path | step 1 of the golden path | **the headline artifact** the harness was built to generate |

If the artifact's shape drifts run-to-run, the harness isn't done — that's the
signal to tighten the component (usually the system prompt, a rule, or a skill's
steps).
