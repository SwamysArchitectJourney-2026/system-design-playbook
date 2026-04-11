---
learning_level: "Advanced"
estimated_time: "12 minutes"
---

# Trade-offs cheat sheet (Azure + distributed systems)

Use in section 6 of every answer. Pair **choice** with **what you give up**.

## Data

| Choice | Upside | Downside |
|--------|--------|----------|
| **Cosmos DB** | Global distribution, tunable consistency, low latency reads at edge | Cost, partition key rigidity, cross-partition query cost |
| **Azure SQL** | Strong consistency, familiar SQL, transactions | Vertical limits, multi-region active-active harder |
| **PostgreSQL (Flexible Server)** | OSS ecosystem, good for relational core | You own HA/failover design more explicitly |

## Caching

| Choice | Upside | Downside |
|--------|--------|----------|
| **Redis** | Speed, pub/sub, rate limiting | Invalidation complexity, staleness, memory cost |
| **CDN + edge cache** | Static and cacheable API offload | Freshness, purge semantics |

## Messaging

| Choice | Upside | Downside |
|--------|--------|----------|
| **Event Hubs** | Massive ingest, streaming, partitions | Ordering per partition only; not a task queue |
| **Service Bus** | Queues, topics, DLQ, sessions | Throughput limits vs Kafka-class systems; ops discipline |
| **Event Grid** | Push fan-out, serverless integration | Different semantics than durable queues |

## Multi-region

| Choice | Upside | Downside |
|--------|--------|----------|
| **Active-passive** | Simpler data story | Failover RTO/RPO; capacity in standby |
| **Active-active** | Latency, resilience | Conflict resolution, sticky sessions vs data, cost |

## Consistency vs availability (payment-adjacent)

- **Strong consistency** on financial writes vs **eventual** for analytics and read models—state which user-visible paths need which.

## Cost vs performance

- Reserved instances / savings plans vs **pay-as-you-go** burst; **autoscale** lag; **Cosmos RU** vs serverless options.
