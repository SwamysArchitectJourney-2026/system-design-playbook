---
learning_level: "Advanced"
estimated_time: "45 minutes"
topic: "LLMOps platform — model lifecycle and governance"
---

# Design an LLMOps platform for model lifecycle and governance

Spoken spine for **Gen AI lead**–style interviews: you own **how models move** from experiment to production safely.

## Clarify

- **Consumers:** internal APIs, batch, agents, customer-facing chat?
- **Model types:** hosted APIs only, **fine-tuned** adapters, open weights on **GPU** clusters?
- **Compliance:** regulated data, residency, audit requirements?
- **SLAs:** inference latency, max **cost per task**, acceptable **rollback** time.

## Estimate

- Training/adaptation **jobs per week**, **GPU-hours**, concurrent **inference** QPS, **embedding** throughput.
- Storage for **datasets**, **checkpoints**, **eval artifacts**; retention policy.

## Architecture

- **Model registry** — metadata: lineage (data + code + hyperparams), stage (dev → staging → prod), **approvers**, **risk tier**.
- **Data & features** — curated datasets, **PII** handling, access control; optional **feature store** for ML-style features if scope includes traditional ML.
- **Training / adaptation** — job runner (Kubernetes jobs, managed training, or notebook-to-pipeline); **LoRA/adapter**-class workflows for efficiency; **experiment tracking**.
- **Evaluation** — **offline** harness (golden sets, regression), **online** shadow and **canary** routing; **human** eval workflow for subjective quality.
- **Deployment** — **multi-model** routing; **A/B** or traffic split; **rollback** to last good version in minutes.
- **Serving** — autoscaling replicas or serverless GPU; **queue** for async; **rate limits** per tenant.
- **Observability** — latency, tokens, **cost**, error taxonomy; **data drift** and **quality** signals where measurable.
- **Governance** — policy engine for **disallowed use cases**, content filters, **audit log** of model version → endpoint mapping.

## Deep dives (pick 2–3)

- **Fine-tune vs RAG vs prompt:** decision tree and **maintenance** cost.
- **Canary and rollback:** how you detect **bad** quality before full traffic.
- **Responsible AI:** bias/hallucination **mitigation** vs **disclosure** to users; escalation paths.

## What breaks first?

1. **GPU / quota** ceiling during concurrent training and peak inference.
2. **Evaluation pipeline** backlog — models ship without fresh **regression** signal.
3. **Registry / metadata** chaos — teams cannot trace which data produced which endpoint.
4. **Cost runaway** on largest model for all traffic — missing **routing** to smaller models.
5. **Governance theater** — policies exist but are not enforced in **serving** path.

## Evolution

- **MVP:** registry + one serving pattern + offline eval + basic monitoring.
- **Scale:** multi-tenant quotas, adapter factory, automated canaries, cost chargeback.
- **Mature:** federated ownership per **domain model**, centralized **policy** and **audit**.

See `diagram.md`, `tradeoffs.md`, `followups.md`, `failures.md`.
