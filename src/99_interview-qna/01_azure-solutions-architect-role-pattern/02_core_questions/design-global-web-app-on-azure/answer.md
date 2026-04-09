---
learning_level: "Advanced"
estimated_time: "40 minutes"
topic: "Highly available global web application on Azure"
answer_format: "01_templates/answer-format-enforcement.md"
---

# Design a highly available global web application on Azure

## Based on Template v1.1

Companion files: `failures.md` (failure-first expansion), `diagram.md` (narrated flow), `tradeoffs.md`, `followups.md`. Service picks grounded in `../../01_templates/service-selection-guide.md`.

## 1. Clarify requirements

**Functional**

- Public web and mobile clients; authenticated areas; CRUD on user-owned resources (adjust to interviewer).

**Non-functional (example assumptions)**

- Global users; **99.99%** availability for the serving path.
- API latency target **P99 under 200 ms** for cached reads; writes may be higher if strongly consistent.
- **Stateless** web/API tier behind load balancing.
- **Strong consistency** for writes to authoritative store (stated for this variant).

**Explicit assumptions**

- Traffic is **read-heavy** with moderate write rate unless told otherwise.
- Compliance: standard commercial app; PII encrypted at rest and in transit.

**Opening line:** *Let me clarify requirements and assumptions before jumping into components.*

## 2. Scale estimation (back-of-envelope)

Illustrative (confirm with interviewer):

- **10M** registered users, **1M DAU**.
- Peak **~10K RPS** at edge (static + API blend).
- **~5 TB** user data over a few years (order-of-magnitude, excluding logs).

**Dominant risks:** DB hot partitions, cache stampede, cross-region consistency cost, APIM throttling under burst.

## 3. High-level architecture

### 3.1 Edge — decision

- **Choose:** **Azure Front Door** (Standard/Premium per WAF need) as primary entry.
- **Because:** L7 routing, TLS termination, **WAF**, health probes, and path-based routing in one place; aligns with global users + 99.99% story.
- **Vs:** **Traffic Manager** alone — rejected for this prompt because we need L7 controls, not only DNS failover.
- **Breaks when:** misconfigured health probes cause **false negatives** (flapping) or origin pools are not regionally symmetric—must validate probe path and host headers.

### 3.2 Compute — decision

- **Choose:** **App Service** (zone-redundant) or **AKS** for APIs; **API Management** internal to edge for governance.
- **Because:** stateless tier; App Service is faster to defend in a time-boxed round unless interviewer demands Kubernetes.
- **Vs:** **Functions-only** backend — rejected as default for sustained CRUD APIs with predictable latency (cold start and limits).
- **Breaks when:** connection pool exhaustion to SQL/Cosmos or **APIM** policy CPU under heavy transformation—watch backend latency SLO.

### 3.3 Cache — decision

- **Choose:** **Azure Cache for Redis** for hot reads / optional rate limiting.
- **Because:** read-heavy + P99 read target; offload DB.
- **Vs:** no cache — rejected given latency goal at scale.
- **Breaks when:** **memory pressure** evicts hot keys, or invalidation bugs cause stale UX—use TTL + versioned keys + single-flight for hottest keys.

### 3.4 Data — decision

- **Choose:** **Cosmos DB** if multi-region **read/write** latency dominates; **Azure SQL** with **geo-secondary** if relational model + mostly single-region writes.
- **Because:** interviewer asked strong consistency on writes—both can work; Cosmos buys global footprint; SQL buys transactions and familiar constraints.
- **Vs:** SQL-only single region — rejected if “global users” implies write latency from distant geographies.
- **Breaks when:** Cosmos **429 throttling** (hot partition / RU ceiling) or SQL **connection/CPU** ceiling—need partition key discipline or Hyperscale/read scale-out.

### 3.5 Object storage

- **Blob Storage** for media/uploads (lifecycle tiers for cost).

**Primary read path:** Client → Front Door → APIM → API → Redis (hit) → Cosmos/SQL (miss).

See `diagram.md`.

## 4. Deep dives (pick 2–3 in the room)

### Caching

- Cache-aside; TTL; **single-flight** on hot keys; invalidate or bump version on write for user profile.

### Multi-region

- Phase A: single region + CDN.
- Phase B: passive secondary + geo-replication / failover groups.
- Phase C: active-active only with explicit conflict story (Cosmos) or **home-region** routing for users.

### Database

- Cosmos: partition key (e.g. `userId`); consistency per operation.
- SQL: pooling, read replicas, Hyperscale when needed.

## 5. Failure scenarios and mitigations

1. **Region loss:** Front Door routes to healthy origins; RPO/RTO from Cosmos/SQL story; runbook for **sticky session** mistakes (prefer stateless).
2. **Cosmos throttling (429):** exponential backoff, **autoscale RU**, fix hot partition; temporary **degrade** read path (serve stale cache with banner if product allows).
3. **Redis failover / eviction:** treat cache as optional for correctness; guard thundering herd with single-flight; monitor **used memory** and **evicted keys**.
4. **APIM or origin overload:** **429** to clients with `Retry-After`; autoscale App Service; circuit break to protect DB.
5. **False healthy probe:** deep health checks that validate DB dependency lightly; alert on elevated error rate, not only probe bit.
6. **Deployment bad release:** App Service **deployment slots** swap; quick rollback.

## 6. What breaks first?

1. **Cache miss storm** (viral read) → Redis single-flight fails or origin **connection pool** saturates before DB autoscale reacts.
2. **Cosmos 429 / SQL CPU** on hot partition or lock contention → P99 read/write collapse.
3. **APIM** policy or gateway CPU under burst → **503/429** at edge despite healthy origins.
4. **False healthy probes** → traffic routed to **bad build** or DB-starved slot.
5. **Multi-region design debt** — active-active without conflict handling → **data correctness** incidents before pure “availability” fails.

## 7. Key design decisions

| Decision | Chosen | Rejected | Why chosen | When rejected choice wins |
|----------|--------|----------|------------|---------------------------|
| Edge | Front Door | TM only | L7 + WAF + routing | Pure DNS failover suffices, cost minimization |
| Data (global write pressure) | Cosmos | Single-region SQL | Latency + elastic scale | Heavy relational joins, team SQL depth, lower $ |
| Data (relational core) | Azure SQL | Cosmos | Transactions, constraints | Need multi-master geo writes at scale |
| Cache | Redis | None | P99 read target | Extreme consistency on every read—bypass cache selectively |
| Compute | App Service | AKS (default) | Speed to narrate, ops | Need service mesh, custom daemons, fine CNI |

**Expanded narrative:** see `tradeoffs.md` (must stay consistent with this table).

## 8. Trade-offs summary

- **Front Door vs TM-only:** flip to TM when L7/WAF not required and cost is primary.
- **Cosmos vs SQL:** flip to SQL when relational invariants dominate; flip to Cosmos when multi-region write latency dominates and model fits.
- **App Service vs AKS:** flip to AKS when you need mesh, daemonsets, or heavy customization.

## 9. Evolution strategy (MVP → scale → global)

1. **MVP (single region):** Front Door → App Service → SQL + Redis + Blob; APIM; baseline monitoring.
2. **Scale (~10× traffic):** read replicas or Cosmos RU autoscale; APIM caching where safe; partition tuning; autoscale rules with cooldowns.
3. **Global:** second region origins on Front Door; Cosmos multi-region **or** SQL geo-failover; chaos drills; SLO dashboards by geography.

## 10. Security architecture

**Entra ID** / B2C for users; **managed identities** app → data; **Key Vault** for any remaining secrets; **private endpoints** on data plane when policy requires; **WAF** at Front Door.

## 11. Observability and operations

**Application Insights** + Log Analytics; SLO on availability and P99; distributed tracing **APIM → App Service → Redis → Cosmos/SQL**; synthetic canaries for “healthy but broken.”

## 12. Cost considerations

**Reserved** capacity for steady App Service/APIM baseline; **Cosmos autoscale RU** vs mis-provisioned fixed RU; **CDN** offload; watch **cross-region egress** and multi-region Cosmos/SQL footprint.
