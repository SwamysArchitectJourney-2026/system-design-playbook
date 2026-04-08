---
learning_level: "Advanced"
estimated_time: "15 minutes"
---

# Decision justification cheat sheet (L6/L7)

Use this when you pick **any** Azure (or cloud) component in an answer. If you cannot fill all four lines, you are not ready to defend the choice.

## The four-line rule

For each decision:

1. **Choose:** name the option (specific SKU/tier only if it matters).
2. **Requirement:** which NFR or functional constraint forces this.
3. **Vs:** the best alternative you rejected.
4. **Breaks when:** the failure or scale point where you would revisit.

## Pattern examples (fill with your system’s numbers)

**Edge**

- Choose **Front Door** vs Traffic Manager-only → need L7 routing / WAF / TLS offload; TM only if DNS-level is enough; breaks when you need complex routing Front Door cannot express cheaply.

**Compute**

- **App Service** vs **AKS** → time-to-market and ops depth vs control; breaks when you need custom networking sidecars or daemon sets at scale.

**Data**

- **Cosmos** vs **Azure SQL** → global write footprint vs relational transactions; breaks when cross-partition queries dominate cost or you need heavy joins.

**Messaging**

- **Event Hubs** vs **Service Bus** → streaming throughput + replay vs brokered queues/DLQ/sessions; breaks when you misuse EH as a task queue.

**Cache**

- **Redis** vs no cache → read latency vs staleness/invalidation tax; breaks when hot keys or memory pressure causes eviction storms.

## Anti-pattern (automatic rewrite)

❌ “We use Redis for performance.”

✅ “We use Redis because read-heavy P99 target; SQL cannot hold hot read path; trade-off is staleness—we invalidate on write for user profile keys; breaks when memory is exhausted—use tiering and TTL + single-flight.”
