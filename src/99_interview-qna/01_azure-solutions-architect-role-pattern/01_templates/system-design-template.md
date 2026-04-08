---
learning_level: "Advanced"
estimated_time: "10 minutes"
---

# System design template (Azure Solutions Architect track)

## Canonical flow (memorize the spine)

1. **Clarify** — Functional scope, NFRs (latency, availability, consistency, scale, compliance, cost).
2. **Estimate** — DAU/MAU, RPS, storage growth, bandwidth; state dominant cost driver.
3. **High-level design** — Named components, primary request path, APIs/events; keep v1 simple.
4. **Deep dives** — Pick 2–3: data, cache, async, multi-region, identity.
5. **Failures & bottlenecks** — SPOF, retries, idempotency, backoff, circuit breaking.
6. **Trade-offs** — At least two real options with why you chose one.
7. **Evolution** — MVP → 10× → global / multi-region.
8. **Optional** — Security boundaries, observability (Monitor / App Insights), cost (reserved capacity, autoscale).

**Opening line:** “Let me clarify requirements and assumptions before jumping into components.”

## Shared playbook

Repo-wide spine and grill layer:

- `../../interview-execution/01_golden-answer-template.md`
- `../../interview-execution/02_follow-up-grill-layer.md`

## Enforcement (this track)

- **Heading contract:** `answer-format-enforcement.md` (same section titles in every `answer.md`).
- **Decisions:** `../07_interview-decision-cheatsheet.md` (four-line rule).
- **Azure picks:** `../08_azure-service-selection-guide.md` (when to use EH vs SB, Cosmos vs SQL, etc.).

## Azure vocabulary (drop in when relevant)

- Edge: **Azure Front Door**, Traffic Manager, **CDN**
- Compute: **App Service**, **AKS**, **Functions**, Container Apps
- Data: **Azure SQL**, **Cosmos DB**, Cache for **Redis**
- Integration: **API Management**, **Event Hubs**, **Service Bus**, Event Grid
- Identity: **Microsoft Entra ID**, managed identities, private endpoints

Use **partition keys**, **RUs**, **geo-replication**, and **availability zones** when discussing data and regions.
