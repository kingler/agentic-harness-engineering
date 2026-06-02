# App Brief — {{APP NAME}}

> **This is Step 0.** Fill this in *before* you run `/plan-app`. The plan,
> wireframes, and tech spec are only as good as this brief. Keep it to one
> page. Bullets beat paragraphs.
>
> You are reverse-engineering a real productized AI app (Harvey, Claude for
> Financial Services, or Granola — see `../ai-apps/`). Describe the *product*,
> not the vendor's secret prompts.

## The app in one line

> {{One sentence: what is this app and who is it for?}}

## The problem it solves

What painful, expensive, or slow job does this product remove?

- {{Who feels the pain today, and what do they do instead?}}
- {{What does "good" look like once the app exists?}}

## Value proposition

Why would someone pay for / switch to this instead of doing it by hand or
with a generic chatbot?

- {{The 10x claim — what is dramatically faster, cheaper, or safer?}}
- {{The trust claim — why can a user rely on the output?}}

## Core features (3–5)

List what users can *do*, as verbs — not the technology.

1. {{Feature — e.g. "Draft an NDA from a counterparty's term sheet"}}
2. {{Feature}}
3. {{Feature}}
4. {{Feature — optional}}
5. {{Feature — optional}}

## The golden path

Walk the single most important interaction, start to finish, in 3–5 steps.

1. User does {{X}}
2. The agent does {{Y}}
3. User reviews / approves {{Z}}
4. {{…}}

## The nightmare failure

The one outcome that would destroy user trust. (This shapes your rules and
hooks later.)

> {{e.g. "Leaks privileged content from one matter into another."}}

## Harness signals you can already observe

Jot anything you noticed as a user that hints at a harness decision —
refusals, confirmations, things that always happen, things it never does.

- {{observation → likely harness component}}
- {{observation → likely harness component}}

---

**Next:** run `/plan-app` in Copilot or RooCode. It reads this brief and
produces `plan/PLAN.md`, `plan/wireframes.md`, and `plan/tech-spec.md`.
