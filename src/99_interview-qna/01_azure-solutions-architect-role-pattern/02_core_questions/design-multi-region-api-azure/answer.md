---
learning_level: "Advanced"
estimated_time: "35 minutes"
topic: "Multi-region API on Azure"
answer_format: "01_templates/answer-format-enforcement.md"
---

# Design a multi-region API platform on Azure

## Based on Template v1.0

Companion: `failures.md`, `../../01_templates/service-selection-guide.md`.

## 1. Clarify requirements

- **Who calls the API** (internet, partners, internal)?
- **Latency** targets per geography; **data residency** constraints.
- **Consistency:** can reads lag after writes? Any **strong** requirements (payments, inventory)?
- **SLA** and **RTO/RPO** for region loss.
- **Multi-tenant** or single-tenant; **API keys** vs OAuth.

## 2. Scale estimation (back-of-envelope)

- RPS per region, payload sizes, error budgets; storage growth if API persists state; cross-region **egress** cost sensitivity.

## 3. High-level architecture

### 3.1 Edge — decision

- **Choose:** **Azure Front Door** + WAF for global entry.
- **Because:** latency-based routing, TLS, L7 health, path rules for `/api` vs static.
- **Vs:** Traffic Manager + regional App Gateway only — more moving parts at L7.
- **Breaks when:** origins asymmetrically healthy—users see flaky behavior; need consistent **health** semantics.

### 3.2 Gateway — decision

- **Choose:** **API Management** stamped **per region** (common pattern) or external tier with multi-region backend—state which and why.
- **Because:** OAuth validation, quotas, **per-tenant** throttling at edge of backend.
- **Vs:** no APIM — every service reimplements policy—rejected at enterprise scale.
- **Breaks when:** **policy CPU** hot; central APIM becomes SPOF if not regionalized.

### 3.3 Compute — decision

- **Choose:** **AKS** or **App Service** or **Container Apps** per region behind regional APIM.
- **Vs:** single global cluster — rejected for blast radius and data proximity.

### 3.4 Data — decision

- **Cosmos** for multi-region writes + tunable consistency **or** **SQL failover groups** for relational active-passive—pick based on consistency and query model.
- **Breaks when:** **split-brain** during failover if clients write to both regions without strategy.

**Observability:** regional **Application Insights** + central **Log Analytics**.

See `diagram.md`.

## 4. Deep dives (pick 2–3 in the room)

### Routing

- Health probes; weighted vs latency; avoid sticky sessions unless required—prefer stateless JWT.

### APIM model

- Stamps per region vs central—latency vs operational drift (GitOps mitigation).

### Idempotency

- **Idempotency-Key** on mutating APIs for retries across regions/clients.

## 5. Failure scenarios and mitigations

1. **Region down:** Front Door shifts; verify **data** failover (Cosmos automatic vs SQL failover group); state RPO.
2. **Backend healthy but errors:** synthetic **canaries** beyond TCP probe.
3. **Thundering herd after failover:** cache stampede—**single-flight**, pre-warm critical caches.
4. **Tenant abuse:** APIM **rate limit** + bulkhead pools; protect shared DB.
5. **Cross-region write conflict** (active-active): **etag** conflicts or home-region routing—must be explicit.

## 6. Trade-offs and decisions (why X over Y)

| Decision | Chosen | Rejected | Why | When rejected wins |
|----------|--------|----------|-----|-------------------|
| API GW | Regional APIM | Single global | Blast radius + latency | Tiny footprint, cost |
| Writes | Home-region / partition | True active-active everywhere | Conflict control | Strict global write latency need |
| Data | Cosmos vs SQL | (interviewer-driven) | See clarify | Relational joins vs global footprint |

Details: `tradeoffs.md`.

## 7. Evolution strategy (MVP → scale → global)

1. Single region + APIM + Front Door entry.
2. Second region passive or read-only; failover drills.
3. Multi-region writes only with explicit conflict and caching strategy.

## 8. Security, observability, and cost

**Security:** **Entra ID** (or B2B) for OAuth validation at **APIM**; **managed identities** from APIM/backend to data; **mTLS** or **private** origins where policy requires; **Key Vault** for client certs if mutual TLS to partners.

**Observability:** **Application Insights** per region + central **Log Analytics**; **distributed tracing** with correlation across regional hops; SLO per geography.

**Cost:** **Multi-region** APIM + compute footprint; **Cosmos multi-region RU** or **SQL geo** licensing; **cross-region egress**—minimize chatty east-west calls; **reserved** capacity for steady regional pools.
