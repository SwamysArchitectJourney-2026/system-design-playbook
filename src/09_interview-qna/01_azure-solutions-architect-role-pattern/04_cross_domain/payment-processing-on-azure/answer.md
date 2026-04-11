---
learning_level: "Advanced"
estimated_time: "45 minutes"
topic: "Payment processing on Azure"
---

# Design payment processing on Azure

## Based on Template v1.1

Companion: `failures.md`, `tradeoffs.md`, `followups.md`, `../../../payment-system-interview/`, `../../01_templates/service-selection-guide.md`.

## 1. Clarify requirements

- **Instruments:** cards, wallets, bank transfer, invoicing; **multi-currency** and FX source of truth.
- **Compliance:** **PCI DSS** scope (SAQ A vs full CDE); PAN storage policy (**tokenize by default**).
- **Semantics:** authorize / capture / void / refund; partial capture; chargebacks and disputes (read path vs money movement).
- **Correctness:** **idempotency** for user-visible operations; **exactly-once money effect** (no double capture).
- **SLAs:** p99 for authorize path; async acceptable for capture/settlement and notifications.
- **Regions:** single region MVP vs active-active; **split-brain** rules for money (explicit).

## 2. Scale estimation (back-of-envelope)

- Peak **payment TPS**, daily volume, settlement batch sizes.
- **Ledger** write rate + retention; **audit** and **reconciliation** log volume.
- Webhook ingress QPS from processor; notification fan-out.

## 3. High-level architecture

- **Edge:** **Azure Front Door** + **WAF** → **API Management** (OAuth/OIDC, quotas, **idempotency key** validation or delegation to orchestrator).
- **Core:** **Payment orchestration** (state machine) on **Azure App Service** or **AKS** if you need custom sidecars, multi-tenant isolation hardening, or very high pod density; start App Service for MVP.
- **Processor boundary:** **Stripe/Adyen/etc.** via **adapter**; **hosted fields** or mobile SDK; **no PAN** in your logs.
- **Data:** **Azure SQL** (strong transactions, familiar ops) or **Cosmos DB** (global distribution, tunable consistency) for **intent + ledger**; choose based on consistency model and geography (see §7).
- **Async:** **Azure Service Bus** (topics/queues) for capture, settlement, notifications, **outbox** consumers—not Event Hubs (streaming telemetry, not transactional work queues).
- **Secrets:** **Key Vault** + **managed identity**; **private endpoints**; **Entra ID** for human admin, workload identity for services.
- **Observability:** **Application Insights**; **distributed trace** per `payment_id`; reconciliation jobs comparing processor reports vs ledger.

### 3.1 Decision: Service Bus vs Event Hubs

- **Chosen: Service Bus** — durable queues/topics, dead-letter, sessions if you need ordered processing per merchant, fits **commands** and **workflow** steps (capture job, notify).
- **Rejected: Event Hub** — optimized for **high-volume event streaming** and analytics pipelines; weaker fit for per-message DLQ and business transaction choreography unless you add a lot of app-level complexity.

### 3.2 Decision: SQL vs Cosmos for ledger

- **Chosen: SQL** when you need **serializable/strong** ledger in one region, straightforward **JOIN** reporting, and team familiarity.
- **Chosen: Cosmos** when you need **multi-region** with explicit consistency policy (still treat **financial writer** as constrained—often single-region writer + global read).
- **Rejected: “Cosmos for everything because scale”** without a consistency story—interviewers will attack **money + partition**.

## 4. Deep dives (pick 2–3 in the room)

- **Outbox pattern:** DB commit and message publish **atomically** (outbox table + relay); avoids “paid in DB, never enqueued.”
- **Idempotency + dedupe store:** client key + server-generated operation id; **processor idempotency** where supported.
- **Unknown states:** processor timeout → mark **ambiguous**; **safe retry** + **reconciliation**; never second capture without proof.
- **PCI scope reduction:** tokenization, delegated vault, network segmentation, no card data in app telemetry.

## 5. Failure scenarios and mitigations

- **Processor timeout / unknown state** — treat as ambiguous; reconcile before user-visible success; idempotent retries.
- **Duplicate webhook delivery** — signature verification + **idempotent** consumer on event id.
- **Service Bus backlog / poison messages** — DLQ, alerts, replay with dedupe; cap retry storms.
- **Database throttling** — partition ledger by time/merchant, scale tier, queue overload paths; circuit break non-critical reads.
- **Regional failure** — runbook: freeze capture, failover **read** paths, promote **single writer** for ledger; forbid dual capture.

(Expanded: `failures.md`.)

## 6. What breaks first?

1. **API + orchestrator** under flash sale (rate limits, connection pools, CPU on state machine)—before the database if autoscale lags.
2. **SQL/Cosmos write path** and **contention** on hot merchants or monotonic sequences if modeled badly.
3. **Service Bus** consumer lag → growing backlog, delayed notifications, **SLA miss** on async paths.
4. **Downstream processor** rate limits → retries amplify into **retry storm** unless you backoff and shed load.
5. **Operational gaps:** reconciliation job delayed → **unknown-state backlog** and support load.

## 7. Key design decisions

| Area | Chosen | Rejected / alternative | Because |
|------|--------|------------------------|---------|
| Async transport | **Service Bus** | Event Hubs | Work queues + DLQ + sessions; not firehose analytics |
| Entry | **Front Door + WAF** | naked App Service | DDoS, TLS, geo routing |
| Gateway | **APIM** | only ingress controller | Policy, keys, OAuth, cross-cutting quotas |
| Compute (MVP) | **App Service** | AKS | Faster ops; sufficient for many payment APIs until isolation/complexity demands K8s |
| Money ledger | **SQL** (default) / **Cosmos** (global story) | Redis as source of truth | Durability and auditability first |
| PCI | **Tokenize + hosted fields** | store PAN | Scope and breach risk |

## 8. Trade-offs summary

- **Strong consistency vs global latency:** favor **clear single writer** for capture/settlement; expose **eventual** status to users where safe.
- **SQL vertical scale vs Cosmos distribution:** Cosmos adds **model + cost** complexity; SQL adds **multi-region** pain—pick for geography and team.
- **Sync UX vs reliability:** return **202 + poll/webhook** for long captures; do not fake instant success.

## 9. Evolution strategy (MVP → scale → global)

- **MVP:** single region, App Service, SQL, Service Bus, full observability + reconciliation from day one.
- **10× / scale:** read replicas, partition ledger, autoscale rules, DLQ playbooks, load test processor and SB.
- **Global:** Front Door routing, Cosmos or geo-SQL strategy, **explicit split-brain** and **freeze** procedures; compliance per region.

## 10. Security architecture

- **PCI:** minimize CDE; tokenization; no PAN in logs/metrics; penetration testing scope aligned to architecture.
- **Identity:** **Entra ID** for operators; **managed identities** service-to-service; avoid long-lived client secrets in config.
- **Network:** private endpoints to SQL, Service Bus, Key Vault where required; segment admin paths.
- **Webhooks:** HMAC/signature, timestamp skew, replay protection, idempotent handling.

## 11. Observability and operations

- **Trace:** `payment_id` end-to-end; correlate **outbox**, **SB**, and **processor** calls.
- **SLOs:** authorize path latency, SB lag, reconciliation freshness.
- **Runbooks:** unknown state, DLQ replay, processor outage, regional isolation.

## 12. Cost considerations

- **SQL:** tier vs DTU/vCore; storage growth; **geo-redundancy** pricing.
- **Cosmos:** RU model, autoscale vs provisioned; hot partition risk = **$$**.
- **Service Bus:** tier for messaging features; watch **operation count** and payload size.
- **Egress:** processor callbacks and file fetch—budget **egress** and **Front Door** charges.
- **FinOps:** env separation, non-prod scale-down, reserved capacity where steady load warrants it.

**Foundations in this repo:** `../../payment-system-interview/` (requirements, components, idempotency, grill).
