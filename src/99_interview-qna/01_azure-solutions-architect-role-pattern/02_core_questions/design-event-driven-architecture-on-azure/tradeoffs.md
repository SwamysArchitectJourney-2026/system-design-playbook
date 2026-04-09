---
learning_level: "Advanced"
estimated_time: "8 minutes"
---

# Trade-offs: event-driven on Azure

## Event Hubs only vs Event Hubs + Service Bus

| EH-only | Add Service Bus |
|---------|-----------------|
| Simpler pipeline for pure streaming | Better task queue semantics, DLQ, sessions |
| Great for analytics ingest | Extra cost and operational surface |

## Functions vs AKS consumers

| Azure Functions | AKS |
|-----------------|-----|
| Fast to build, autoscale, per-event billing concerns | Long-running, custom networking, heavier ops |
| Cold start on consumption plan | Steady workers |

## At-least-once vs exactly-once

- **At-least-once + idempotency** is the pragmatic default.
- **Exactly-once** across boundaries is expensive; mention **outbox**, **dedupe**, and **effectively-once** user experience.

## Event-driven vs synchronous RPC

| Events | RPC |
|--------|-----|
| Resilience, burst absorption | Simpler mental model, easier debugging |
| Eventual consistency | Stronger immediate consistency |
