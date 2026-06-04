# Planning Phase · Step 2 — Research the Domain

**Duration:** ~10 minutes  
**Day:** Day 1 (planning phase)  
**Format:** Same groups as Step 1

---

> **Exercise chain.** **Builds on ←** Step 1's harness map (you've picked an app
> and mapped its features). **Sets up →** Step 3 (design), where the domain's
> demands become your hard rules, hooks, and knowledge. See the phase overview
> in [`README.md`](./README.md).

## Your Goal

You've picked an app and reverse-engineered *what it does*. Now find out what its
**domain** demands — the non-negotiables a real practitioner assumes. By the end
you'll have a **domain map**: the terms, the real workflow, and the
trust/compliance constraints that shape your harness components.

The reverse-engineered apps are **vertical** products. Their hardest harness
decisions come from the domain, not the UI:

- **Harvey → legal:** privilege, citation/authority, jurisdiction, matter confidentiality.
- **Claude for Financial Services → finance:** auditability, "no number without lineage", disclosure rules, spreadsheet/deck surfaces.
- **Granola → meetings:** recording consent, on-device capture, the summary · decisions · actions schema.

---

## Step 1 — Start from what you have (3 min)

- Open your app's profile in [`../ai-apps/`](../ai-apps/) (e.g. `01-harvey.md`).
- Re-read your Step 1 notes: which behaviors did you mark as **surprising**,
  **frustrating**, or **refused**? Those are usually domain constraints showing
  through.

## Step 2 — Search the domain (5 min, if you have a device)

Take ~5 minutes to look up what a practitioner takes for granted. Search for:

- **Real workflow** — how does a lawyer / analyst / meeting owner actually do
  this today, step by step?
- **Trust & compliance constraints** — what must never happen? (privilege,
  disclosure, consent, audit trails, data residency…)
- **Vocabulary** — the exact terms practitioners use (you'll reuse these in
  `knowledge/` and tool descriptions).

No web access? Lean on the profile + your group's own domain knowledge, and mark
those facts as **inferred**.

## Step 3 — Write your domain map (2 min)

Capture it in four short lists. **Mark each item `confirmed` or `inferred`** —
never present a guess as fact.

```
DOMAIN MAP — {app / domain}

Terms:            {5–8 domain words the agent must use correctly}
Real workflow:    {the 3–6 steps a practitioner actually follows}
Trust/compliance: {the non-negotiables — each is a candidate hard rule or hook}
Sources:          {where each fact came from; mark confirmed vs inferred}
```

---

## What this feeds

| This domain finding… | …becomes this harness component |
|----------------------|----------------------------------|
| A trust/compliance non-negotiable | a **hard rule** + a **hook** (component Breakout 4) |
| The domain vocabulary | **knowledge/** + tool descriptions (component Breakouts 3 & 5) |
| The real workflow | the **golden path** your skill follows (component Breakout 2) |

Carry the domain map into Step 3 (design) — every harness decision should be
**defensible against it**.

---

## Facilitation Notes

**If a group skips straight to design:** "You picked the app — but what does the
domain *require*? Name one thing a real lawyer / analyst would refuse to use this
without. That's your first hard rule."

**If a group can't search:** the app profile in `../ai-apps/` plus their own
observation is enough — just have them mark inferred vs confirmed honestly.

**Watch for generic constraints** ("be accurate"). Push for the domain-specific
one ("every figure must cite its source document").
