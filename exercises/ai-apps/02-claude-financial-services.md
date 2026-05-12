# Reverse-engineer option B — Claude for Financial Services

**Product:** [Claude for Financial Services](https://www.anthropic.com/solutions/financial-services) — Anthropic’s vertical for banking, insurance, asset management, and fintech (Excel / PowerPoint surfaces, finance agent templates, enterprise controls).  
**Best for:** Groups who want **regulated-industry** framing: verification-first outputs, committee-ready artifacts, and dense partner integrations.

---

## Quick profile

| Lens | What to look for |
|------|------------------|
| **System prompt / persona** | Risk-aware voice, explicit uncertainty, second-line review language. |
| **Tools & skills** | Spreadsheet / deck operations, agent templates for modeling or diligence. |
| **Knowledge** | Market and policy data surfaced with lineage (traceable numbers narrative). |
| **Hooks / governance** | Enterprise assurance postures (SOC 2, FedRAMP language) as productized gates. |
| **Memory** | What carries across quarters vs per analysis session? |
| **Integrations** | Data partners (LSEG, FactSet, etc.) as **tool access**, not raw prompt stuffing. |

---

## Workshop use

1. Cross-check the **Claude Financial Services** slide in `Agentic Harness Engineering.html` with this profile.  
2. When writing **tools** (Breakout 3), model a **script** that returns JSON with `{ metric, source, as_of }` to practice “traceable numbers.”  
3. In **Breakout 4**, express a **hard never** appropriate to finance (e.g. “no outbound trade instructions without human flag”) and block it in `pre-tool-use.sh`.

---

## Optional reading

- Anthropic financial services solution page (positioning and capability language only).
