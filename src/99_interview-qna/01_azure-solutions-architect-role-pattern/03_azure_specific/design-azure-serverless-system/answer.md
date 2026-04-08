---
learning_level: "Advanced"
estimated_time: "30 minutes"
topic: "Serverless system on Azure"
---

# Design a serverless system on Azure (Functions-first)

## Clarify

- Triggers: HTTP, queue, timer, Event Hub, blob; **latency** SLO (avoid consumption cold start if strict).
- **VNET** integration and private resources?
- **Stateful** needs (Durable Functions?) vs pure stateless.

## Estimate

- Invocations/day, concurrent executions, payload sizes, downstream DB RPS.

## Architecture

- **API:** HTTP Functions or **API Management** in front of Functions.
- **Async:** Service Bus or Storage queues → **Functions** consumers; **Durable Functions** for orchestration sagas.
- **Data:** Cosmos or SQL with connection pooling via **Elastic** patterns; **Blob** for large payloads.
- **Identity:** managed identities to SQL, Service Bus, Key Vault.

## Deep dives

- **Plan choice:** Consumption vs Premium vs Dedicated (cold start, VNET, min instances).
- **Scaling limits** and partition count for queues/Event Hubs.
- **Retry** and **idempotency** on every consumer.

## Failures

- DLQ; poison handling; **dead letter** alerts; backoff policies.

## Trade-offs / evolution

- MVP: single Function app + queue + SQL.
- Scale: split apps by blast radius; Premium plan; Durable for workflows; APIM for governance.

See `diagram.md`, `tradeoffs.md`, `followups.md`.
