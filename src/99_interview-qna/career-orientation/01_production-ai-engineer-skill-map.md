---
learning_level: "Intermediate"
prerequisites: ["Basic ML vocabulary"]
estimated_time: "15 minutes"
learning_objectives:
  - "Contrast research-oriented ML study with production AI engineering work"
  - "Prioritize orchestration, RAG, MCP, and LLMOps for interview and role alignment"
---

# Production AI engineer: skill map (not the research-only path)

Many engineers start with **model training from scratch**, heavy math drills, Kaggle rankings, and paper stacks. Those can be useful, but **most production AI roles** center on **orchestrating** models others built, integrating them safely into software, and operating them economically.

## What shifts in production

- **Less** — Training foundational models from zero; competing purely on novel architecture math.
- **More** — **Agents and workflows**, **RAG**, **tool and MCP integrations**, **evaluation**, **cost and latency**, **guardrails**, **versioned prompts**, **routing across models** (quality vs speed vs price).

## Skill areas that show up repeatedly

1. **Agent orchestration** — Multi-step plans, subagents, handoffs, stopping conditions, human escalation.
2. **RAG** — Chunking, embeddings, hybrid retrieval, re-ranking, index lifecycle, GraphRAG where relevant.
3. **MCP and tools** — Standardized tool exposure, auth, auditing, least privilege.
4. **Prompting as engineering** — System prompts under review, test cases, regression checks—not only ad hoc tuning.
5. **Model routing** — Picking the right model tier per task; caching and deduplication.
6. **Safety and compliance** — Input validation, PII handling, abuse detection, human-in-the-loop for risky actions.
7. **LLMOps** — Metrics dashboards, eval harnesses, spend alerts, deployment pipelines.

## How to study efficiently

- Build **one** serious RAG app with evaluation (even a small corpus).
- Build **one** agent with **two or more tools** and explicit failure handling.
- Instrument **token usage and latency**; set a fake SLO and optimize toward it.

## Mindset

Treat AI features like **distributed systems**: idempotency, retries, timeouts, observability, and clear user-visible states matter as much as model choice.

## Executable drill pack

For a full **question pack** aligned with this skill map (IC scope), use `../08_ai-engineer-role-pattern/README.md`.
