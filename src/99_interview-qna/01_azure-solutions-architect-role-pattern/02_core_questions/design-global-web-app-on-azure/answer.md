---
learning_level: "Advanced"
estimated_time: "40 minutes"
topic: "Highly available global web application on Azure"
---

# Design a highly available global web application on Azure

## 1. Clarify requirements

**Functional**

- Public web and mobile clients; authenticated areas; CRUD on user-owned resources (adjust to interviewer).

**Non-functional (example assumptions)**

- Global users; **99.99%** availability for the serving path.
- API latency target **P99 under 200 ms** for cached reads; writes may be higher if strongly consistent.
- **Stateless** web/API tier behind load balancing.
- **Strong consistency** for writes to authoritative store (user says so for this variant).

**Explicit assumptions**

- Traffic is **read-heavy** with moderate write rate unless told otherwise.
- Compliance: standard commercial app (no special air-gap); PII encrypted at rest and in transit.

Opening line: *Let me clarify requirements and assumptions before drawing components.*

## 2. Scale estimation (back-of-envelope)

Illustrative orders of magnitude (confirm with interviewer):

- **10M** registered users, **1M DAU**.
- Peak **~10K RPS** at edge (mix of static + API); average lower.
- **~5 TB** user data over a few years excluding logs (order-of-magnitude).

**Dominant risks:** database hot partitions, cache stampede, cross-region consistency cost.

## 3. High-level architecture

**Edge:** DNS → **Azure Traffic Manager** or **Azure Front Door** (prefer Front Door for WAF, TLS, routing, and path-based rules).

**Static / BFF:** **Azure CDN** (or Front Door + origin) for static assets; optional **App Service** or **Container Apps** / **AKS** for web BFF.

**API:** Stateless services behind **App Service** (zones) or **AKS** with **Azure Load Balancer** / ingress; **API Management** at the inner edge for policies, throttling, and versioning.

**Cache:** **Azure Cache for Redis** for hot reads and session externalization (if sessions exist—prefer stateless JWT + short TTL).

**Primary data:** **Azure Cosmos DB** (multi-region writes if global low-latency reads + writes required) **or** **Azure SQL** with geo-secondary if workload is relational and multi-region active-active is not mandatory.

**Blob:** **Azure Blob Storage** for uploads, receipts, media.

**Primary path (read-heavy):** Client → Front Door → API → Redis (hit) → Cosmos/SQL (miss).

See `diagram.md` for a Mermaid view.

## 4. Deep dives (pick 2–3 in the room)

### Caching

- TTL-based cache for read models; **cache-aside**; consider **single-flight** for hot keys.
- For user-specific data, key by `tenant:user:id`; define **invalidation** on write (delete key or versioned payload).

### Multi-region

- **Phase A:** Single region + CDN.
- **Phase B:** Active-passive second region with **Cosmos geo-replication** or SQL **geo-secondary** + controlled failover.
- **Phase C:** Active-active with Cosmos multi-region + conflict policy (or partition users by home region to reduce conflicts).

### Database

- **Cosmos:** partition key choice (e.g. `userId`) to avoid cross-partition scans; consistency level per operation (strong for financial-style writes if this app ever holds money).
- **SQL:** connection pooling, read replicas for read scale, **hyperscale** if needed.

## 5. Failure handling

- **Region failure:** Front Door / Traffic Manager health probes route away; data RPO/RTO per product requirement.
- **Dependency failure:** **Timeouts**, **bounded retries**, **circuit breakers** to Redis and DB.
- **Thundering herd:** autoscale rules + cache warming cautiously; **jitter** on retries.

## 6. Trade-offs

- **Cosmos vs SQL:** global latency and elasticity vs SQL familiarity and transactional patterns—see `tradeoffs.md`.
- **Redis:** huge win on read latency; cost and **staleness** risk.

## 7. Evolution

1. **MVP:** Single region, App Service + SQL + Redis + Front Door.
2. **10× scale:** Partition data, APIM policies, read scaling, autoscale, heavier observability.
3. **Global:** Multi-region Front Door, Cosmos or geo SQL story, chaos testing for failover.

## 8. Security and observability (if time)

- **Entra ID** for users (or B2C); **managed identities** service-to-service; **private endpoints** for data plane where required.
- **Azure Monitor**, **Application Insights**, **Log Analytics**; SLOs on availability and P99 latency.

## 9. Cost

- **Reserved** capacity for baseline; **autoscale** for peaks; right-size Cosmos RUs or use **autoscale**; CDN offload.
