# Evaluations

Eval cases live here. Each case is a JSON file describing one input
the harness should handle and the criteria for "did it work".

`scripts/run-eval.sh` is the runner. It iterates the cases, runs the
harness against each, and prints one line of result per case so the
agent (or CI) can read it.

## Why evals exist

A harness that worked yesterday can silently regress today after a
prompt change, a model upgrade, or an MCP server update. Evals are
the regression test for prompts and tools — the same role unit tests
play for code.

## Case format

```json
{
  "id": "smoke-design-review",
  "prompt": "Review the diff in fixtures/diff-1.patch against the design system.",
  "expect": {
    "must_include": ["spacing", "contrast"],
    "must_not_include": ["please"],
    "max_tokens": 600
  },
  "tags": ["smoke", "design-review"]
}
```

Fields:

- `id` — stable, human-readable.
- `prompt` — the user turn the harness should handle.
- `expect.must_include` — substrings that must appear in the response.
- `expect.must_not_include` — substrings that must not.
- `expect.max_tokens` — soft cap on response length.
- `tags` — for filtering (`smoke`, `golden`, `slow`, etc.).

## How to add a case

1. Add a `.json` file under `evals/cases/`.
2. Run `scripts/run-eval.sh smoke` (or `golden`) and confirm it passes.
3. Commit. The case becomes part of the regression suite.

## What a passing run looks like

```
{"case":"smoke-design-review","status":"pass","duration_ms":820}
{"case":"smoke-error-copy","status":"pass","duration_ms":640}
{"case":"golden-refund-policy","status":"fail","reason":"missing_phrase: 'within 30 days'"}
```

One JSON object per line. Fail-fast off — run all cases, then summarise.
