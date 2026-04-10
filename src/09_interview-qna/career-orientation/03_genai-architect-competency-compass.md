---
learning_level: "Advanced"
prerequisites: ["Production AI engineer skill map", "Basic RAG and API design"]
estimated_time: "16 minutes"
learning_objectives:
  - "Contrast GenAI architect loops with IC engineer, lead, and pure architect tracks"
  - "Name what interviewers reject as too shallow for this bar"
---

# GenAI architect: competency compass (hands-on architecture bar)

Some teams hire a **Generative AI architect** who is expected to **design and build**: not slide-only architecture, and not one-off demos. You own **concept → production** for copilots, RAG systems, and multi-step agent workflows, with explicit attention to **evaluation, observability, cost, and security**.

## What “good” looks like in the room

- **End-to-end story** — data and APIs, orchestration, serving, failure modes, and how you **measure** quality and cost.
- **Production evidence** — scaling, incidents, rollbacks, model or prompt changes under control—not only notebooks.
- **Balance** — you can **code** (e.g. Python services, async APIs) and **draw** boundaries between components and teams.

## What interviewers often filter out

- **Demo-only** or hackathon-only exposure without ownership of **SLOs**, **deployments**, or **on-call** reality.
- **Prompt-only** craft without **system** design (retrieval, auth, rate limits, evaluation, data lifecycle).
- No **trade-off** vocabulary: latency vs quality, fine-tune vs RAG vs routing, managed API vs self-host.

## Technical pillars to rehearse

1. **RAG and knowledge systems** — chunking, embeddings, hybrid search, freshness, permissions on chunks.
2. **Copilots and workflows** — multi-step flows, tools, human handoff, idempotency and timeouts.
3. **Backend and distributed habits** — APIs, queues, caching, scaling patterns, **observability** (traces, metrics, logs).
4. **Cloud** — one hyperscaler story told crisply (compute, networking, secrets, cost).
5. **LLMOps** — eval harnesses, versioning, canaries or flags, **regression** when models or prompts change.

## Where to drill in this repo

- **AI systems architect:** `../ai-systems-architect/README.md` — breadth + serving/observability pack.
- **Agentic AI lead:** `../04_agentic-ai-lead-competency-profile/README.md` — RAG + agent orchestration depth.
- **Gen AI lead (platform):** `../07_gen-ai-lead-role-pattern/README.md` — lifecycle and governance when the loop goes there.
- **AI engineer (IC feature):** `../08_ai-engineer-role-pattern/README.md` — single-feature shipping narrative.
- **Platform AI on Azure (SA):** `../09_solution-architect-platform-ai-azure/README.md` and `04_solution-architect-platform-ai-azure-compass.md` — landing zone + Foundry/OpenAI/Search/AML + IaC/GitOps.
- **Skill map:** `01_production-ai-engineer-skill-map.md` — production vs research-only study.

## Mindset

You are selling **trust**: that you can ship AI that stays **correct enough**, **safe enough**, and **affordable enough** after launch—not only on demo day.
