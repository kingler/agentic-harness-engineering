# Domain knowledge

Files in this directory are **facts the agent retrieves**, not behaviour
it follows. Skills tell the agent *how* to act; knowledge tells it
*what is true* in this domain.

## When to put something here

- A rule, policy, or spec the agent must cite verbatim.
- A glossary or naming convention specific to this product.
- Reference data that changes faster than the system prompt should.

## When NOT to put something here

- General programming knowledge — the model already has it.
- Long prose better suited to a wiki — link out instead.
- Anything that would belong in the system prompt because it applies
  to every turn.

## How the agent uses it

The harness retrieves knowledge files on demand:

1. The agent decides it needs a domain fact (e.g. "what's our refund
   policy?").
2. It reads the relevant `knowledge/*.md` file (or runs a retrieval
   step if you've wired one).
3. It quotes the file with a citation, e.g.
   `(knowledge/refund-policy.md §3)`.

For a workshop, plain markdown is enough. In production, replace this
with a vector store, a retrieval MCP, or a documented lookup script.

## Layout

```
knowledge/
├── README.md              # this file
└── style-guide.md         # example: product copy / tone rules
```

Add one file per coherent topic. Keep each under 300 lines.
