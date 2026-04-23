# Harness Engineering Best Practices

> Compiled from Anthropic's engineering guidelines, OpenAI's research on agentic systems, and Addy Osmani's work on AI-assisted development workflows.

---

## Principles from Anthropic

### 1. Start Simple, Escalate Deliberately

Don't start with a multi-agent system. Start with a single agent and a minimal tool set. Add complexity only when you've proven the simple version fails to meet your needs.

> "Many tasks that seem to require agentic behavior can actually be accomplished by a single model call with a well-designed context."

**In practice:** Build a working single-agent harness first. Identify specific failure modes. Add subagents or additional tools only to address those specific failures.

---

### 2. The Right Amount of Autonomy

Match agent autonomy to task risk level. Not every task should be fully automated.

| Task type | Risk level | Appropriate autonomy |
|-----------|-----------|---------------------|
| Read-only analysis | Low | Fully autonomous — show results, no confirmation needed |
| Reversible writes | Medium | Autonomous with transparency (show diff before applying) |
| Irreversible actions | High | Always confirm before executing |
| External system changes | Very high | Confirm + require explicit approval step |

**In practice:** Build a "confirmation required" flag into your tool definitions. Make it easy to add or remove confirmation per tool as you learn more about how users interact with the agent.

---

### 3. Context Is the Product

The quality of what you put in the context window determines the quality of what comes out. This is Context Engineering — the middle layer between prompt and harness.

Anthropic's rules for context quality:
- **Relevant:** Include only what the agent needs for this specific task
- **Recent:** Prioritize current information over historical information
- **Structured:** Use clear headers, labeled sections, and consistent formats
- **Bounded:** Never fill the context window completely — leave headroom for tool outputs

**In practice:** Audit your context regularly. What's in the context that isn't useful? What's missing that the agent keeps having to ask for?

---

### 4. Hooks Over Hope

When something must happen every time — log every tool call, refuse a category of request, format output a specific way — enforce it with code, not with prompt instructions.

The model might forget. The hook won't.

**In practice:** For every "always" or "never" rule in your AGENTS.md, ask yourself: "Is this enforced by a hook, or am I hoping the model follows it?" If the latter, and the rule is genuinely non-negotiable, write the hook.

---

### 5. Design the Failure State First

Before designing the happy path, design what happens when things go wrong:
- What does the user see when a tool fails?
- What does the agent do when it doesn't understand the request?
- What happens when the agent produces an incorrect result?
- What's the escape hatch when the agent gets stuck in a loop?

> "Most agent UX problems are really failure-state design problems."

**In practice:** For each tool in your harness, document at least 2 error scenarios and what the agent should do in each.

---

## Principles from OpenAI's Research

### 6. Agents Don't Need Their Own Screen

One of the biggest mistakes in agentic product design is building agents that have their own dedicated UI. In most cases, the right UX is embedding agent capabilities into existing workflows — not creating a separate "AI mode."

**In practice:** Ask "Does this agent need a new screen, or can it live as an action in an existing context?" Design System Agent reviewing PRs in GitHub → GitHub Action + comment thread, not a separate app.

---

### 7. Fewer Tools = Better Agents

OpenAI's research consistently shows that agent performance degrades as the number of available tools increases. This is counterintuitive — more tools should mean more capability. But what actually happens is the agent gets confused about which tool to use.

The sweet spot for most task-specific agents: 3–7 tools.

**In practice:** Be ruthless about tool scope. If you have more than 7 tools, ask: "Which tools are used less than 20% of the time? Can those be removed or combined?"

---

### 8. Minimal Footprint by Default

Agents should request only the permissions they need, retain information only as long as necessary, and prefer reversible actions over irreversible ones.

> "The goal is to accomplish the task, not to accumulate capabilities."

**In practice:** Design your permissions to be task-scoped, not role-scoped. An agent that reviews design files doesn't need write access to the production repository — even if the same person has that access.

---

### 9. Observability Is Not Optional

You cannot improve what you cannot see. Every production harness needs:
- A log of every tool call (input, output, timestamp)
- A way to replay a conversation to reproduce a failure
- Metrics that tell you if quality is improving or degrading

**In practice:** Add basic logging on day one. It takes 30 minutes to set up a tool call log file and will save you hours of debugging later.

---

## Principles from Addy Osmani

### 10. The 70% Threshold Rule

AI agents are reliable co-authors when task complexity is below the 70% threshold — tasks where the model gets it right most of the time. Above that threshold, you're spending more time reviewing and correcting than you would have spent doing the task yourself.

Design your harness for the 70%. Use deterministic code for the rest.

**In practice:** Run a simple evaluation: ask the agent to do its primary task 10 times. If it gets it right 7 or more times without correction, the harness is working. If not, narrow the scope.

---

### 11. Context Engineering Over Prompt Engineering

Spending 80% of your time on the system prompt and 20% on context is backwards. A well-structured context window with the right information at the right time outperforms a beautifully crafted prompt with poor context.

**In practice:** Before refining your system prompt further, check: Is the agent failing because of bad instructions, or because it's missing information? If it's missing information, fix the context — not the prompt.

---

### 12. Iterative Harness Development

Don't design your harness all at once. The best harnesses are built iteratively, based on real usage:

1. Build the simplest possible version
2. Use it for real tasks
3. Log what goes wrong
4. Fix the most common failure mode
5. Repeat

This is "hill-climbing" — each iteration gets you a little closer to the optimal harness for your specific use case.

**In practice:** Treat your harness like a product that ships incrementally. Version it (`config.json → version: "0.1.0"`), document changes, and A/B test significant changes.

---

## Anti-Patterns to Avoid

| Anti-pattern | What it looks like | What to do instead |
|-------------|-------------------|-------------------|
| **Over-prompting** | System prompt is 3,000+ words | Under 800 words + supplement with memory file |
| **Tool overload** | 15+ tools defined | Start with 3–5, add only when needed |
| **Hoping vs. hooking** | "Never delete files" in system prompt, no hook | Write the hook |
| **No failure state** | Agent silently fails or loops | Design explicit error messages + escalation |
| **No observability** | No logs, no traces, no evals | Log every tool call from day one |
| **Autonomy without trust** | Agent acts before user understands what it's doing | Show intent before action |
| **Scope creep** | "While I'm at it, can you also..." | Lock scope, log new requirements for v2 |
| **Memory overload** | Dumping everything into the context | Only load what's needed for this specific task |

---

## The Harness Quality Checklist

Before calling a harness "production-ready":

**Instructions & Identity**
- [ ] System prompt under 800 words
- [ ] Clear rules for the 3 most common failure modes
- [ ] Explicit "always" and "never" behaviors documented

**Tools**
- [ ] 3–7 tools maximum for task-specific agents
- [ ] Every tool description answers: what it does, when to use it, when NOT to use it
- [ ] High-risk tools require user confirmation

**Safety**
- [ ] File/data access scoped to what's needed (not what's available)
- [ ] Irreversible actions are flagged and confirmed
- [ ] At least one pre-tool hook running for logging or validation

**Observability**
- [ ] Tool calls are logged (input, output, timestamp)
- [ ] Error messages are user-friendly and actionable
- [ ] You can reproduce any failure from the logs

**Improvement**
- [ ] You have a defined way to receive feedback (explicit or implicit)
- [ ] You have a defined cadence for reviewing feedback and improving the harness
- [ ] The harness is versioned
