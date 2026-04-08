---
learning_level: "Advanced"
estimated_time: "35 minutes"
topic: "Multi-region API on Azure"
---

# Design a multi-region API platform on Azure

## 1. Clarify requirements

- **Who calls the API** (internet, partners, internal)?
- **Latency** targets per geography; **data residency** constraints.
- **Consistency:** can reads lag after writes? Any **strong** requirements (payments, inventory)?
- **SLA** and **RTO/RPO** for region loss.
- **Multi-tenant** or single-tenant; **API keys** vs OAuth.

## 2. Scale estimation

- RPS per region, payload sizes, error budgets; storage growth if API persists state.

## 3. High-level design

**Edge:** **Azure Front Door** (or Traffic Manager + regional Application Gateway) for global routing, TLS termination, WAF.

**Gateway:** **Azure API Management** (often **per region** or **external** tier with multi-region backend) for policies, quotas, OAuth validation, caching at the edge where safe.

**Compute:** **AKS** or **App Service** or **Container Apps** in **multiple regions**, each talking to **regional** data endpoints where possible.

**Data patterns (choose explicitly):**

- **Global user home region:** route user to “home” region via Front Door + geo affinity cautiously; reduces conflicts.
- **Global replicated store:** **Cosmos DB** with multi-region accounts; tune consistency per operation.
- **Primary + secondary SQL:** active-passive with failover groups for relational cores.

**Observability:** regional **Application Insights** + central **Log Analytics**.

## 4. Deep dives

### Routing

- Health probes; **weighted** routing; **latency-based** routing; **sticky sessions** only when necessary (prefer stateless JWT).

### APIM deployment model

- Discuss **stamping** (one APIM per region) vs centralized gateway trade-offs (latency, blast radius, config drift).

### Idempotency at API layer

- **Idempotency-Key** header for mutating operations that may retry across regions or clients.

## 5. Failure handling

- Automatic failover at Front Door; **circuit breakers** to unhealthy regional backends; **bulkhead** quotas so one tenant cannot starve others.

## 6. Trade-offs

- **Active-active** APIs with **global writes** vs **partitioned** users by region—see `tradeoffs.md`.

## 7. Evolution

1. Single region + APIM + Front Door (preview global entry).
2. Second region read-only or passive.
3. Multi-region writes with clear conflict and caching rules.
