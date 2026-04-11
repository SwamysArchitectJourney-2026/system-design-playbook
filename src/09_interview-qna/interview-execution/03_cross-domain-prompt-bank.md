---
learning_level: "Advanced"
prerequisites: ["Domain basics in payments and GenAI"]
estimated_time: "15 minutes"
learning_objectives:
  - "Practice integration-style prompts that span AI, cloud, and transactional systems"
---

# Cross-domain prompt bank

Use these to **stress-test** siloed prep. Each line is a potential **full** design or a **deep dive** on top of a simpler system.

## Payments + ML / AI

- Design **fraud scoring** in the payment path: latency budget, feature store, model serving, shadow mode vs blocking, explainability for analysts.
- Design **dispute prediction** or **merchant risk** tiers without blocking checkout.
- How do you **retrain and deploy** models without breaking idempotent payment APIs?

## GenAI + enterprise workflow

- Design **LLM-assisted case management** (tickets, loans, claims): human-in-the-loop, audit trail, PII redaction, tool access boundaries.
- Integrate **document RAG** with **workflow state machines** (who can see which chunk of which doc).

## GenAI + Azure (or any cloud) at scale

- **Multi-tenant** AI gateway: quotas, routing to models, logging, key management, per-tenant cost attribution.
- **Private connectivity** to models (VPC, private endpoints) vs managed APIs; DR story.

## Platform + governance

- Design a **shared API platform** that enforces auth, rate limits, and **architecture standards** without becoming a bottleneck.
- **Self-service** patterns for teams vs central review: guardrails, golden paths, exceptions process.

## Data + real time + AI

- **Feature pipeline** from OLTP to offline training and online serving; freshness SLAs; backfill and schema evolution.

## How to practice

1. Pick one prompt.
2. Run it through `interview-execution/01_golden-answer-template.md`.
3. Add **five** follow-ups from `02_follow-up-grill-layer.md` tailored to that prompt.
