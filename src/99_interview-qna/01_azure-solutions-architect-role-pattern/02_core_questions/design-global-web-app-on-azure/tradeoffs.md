---
learning_level: "Advanced"
estimated_time: "8 minutes"
---

# Trade-offs: global HA web app on Azure

## Cosmos DB vs Azure SQL (as primary store)

| Cosmos DB | Azure SQL |
|-----------|-----------|
| Multi-region active-active with tunable consistency | Strong transactions, mature relational model |
| Partition key drives performance and cost | Vertical scale limits; multi-master story differs |
| Higher $ at scale for hot workloads | Often cheaper for classic OLTP in one region |

**Choose Cosmos** when low-latency global reads/writes and elastic scale dominate. **Choose SQL** when relational integrity, complex joins, and team SQL depth dominate and multi-region is passive or single-primary.

## Redis cache

| Pros | Cons |
|------|------|
| Large read latency win; rate limiting; session offload | Invalidation bugs; memory cost; cold-start after failover |

**Mitigation:** versioned cache entries; short TTL + event-driven invalidation for critical reads.

## Front Door vs Traffic Manager

| Front Door | Traffic Manager |
|------------|-----------------|
| WAF, TLS, path routing, closer to HTTP layer | DNS-level; simpler; less L7 control |

For public HTTP APIs at scale, **Front Door** is usually the default in modern designs.

## Active-active vs active-passive regions

- **Active-active:** better latency worldwide; harder data conflicts and operations.
- **Active-passive:** simpler RTO story; wasted standby capacity.

For many apps, **start passive** second region, evolve to active when revenue and latency justify complexity.
