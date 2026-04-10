---
learning_level: "Advanced"
estimated_time: "20 minutes"
---

# Azure service selection playbook (canonical)

**Use in answers:** State aloud *“Per our service selection: Event Hubs for streaming ingest, not Service Bus, because …”* — see `07_interview-decision-cheatsheet.md` for the four-line justification.

## Messaging

| Need | Choose | Not for | One-line |
|------|--------|---------|----------|
| High-throughput stream, partitions, replay | **Event Hubs** | Per-message task queue with DLQ sessions | Streaming analytics + fan-out consumers |
| Queues, topics, DLQ, sessions, competing consumers | **Service Bus** | Kafka-class firehose only | Reliable work distribution |
| Cheap simple queue, high volume, loose semantics | **Storage Queue** | Rich broker features | Cost + simplicity |
| Push fan-out to many handlers | **Event Grid** | Ordered processing | Event reaction, not command queue |

## Compute

| Need | Choose | Not for |
|------|--------|---------|
| Web APIs, slots, managed PaaS | **App Service** | Custom CNI, daemon sets |
| Full Kubernetes | **AKS** | Teams with no K8s ops |
| Short event-driven code | **Functions** | Long-running CPU-bound workers (without Durable) |
| Containers without operating control plane | **Container Apps** | Hard multi-tenant cluster sharing |

## Storage / data

| Need | Choose | Not for |
|------|--------|---------|
| Global distribution, partition key model | **Cosmos DB** | Heavy ad-hoc relational joins |
| Relational, transactions, T-SQL | **Azure SQL** | Cheap global multi-master |
| OSS Postgres | **Azure Database for PostgreSQL** | — |
| Object / media | **Blob Storage** | Transactional core state |
| Hot reads, rate limits, ephemeral | **Azure Cache for Redis** | Source of truth |

## Edge / integration

| Need | Choose |
|------|--------|
| L7, WAF, TLS, routing | **Front Door** (or Application Gateway regionally) |
| DNS-only failover | **Traffic Manager** |
| External/partner API governance | **API Management** |

## Identity / secrets

- **Entra ID** (workforce, B2B, B2C) for users and clients.
- **Managed identities** + **Key Vault** for service credentials (no secrets in code).
- **Private endpoints** when data plane must not traverse public internet.

## Interview phrase

> “Service Bus is wrong as the primary ingest at 100K ev/s—that’s Event Hubs. We still use Service Bus **after** normalization to assign work with DLQ.”
