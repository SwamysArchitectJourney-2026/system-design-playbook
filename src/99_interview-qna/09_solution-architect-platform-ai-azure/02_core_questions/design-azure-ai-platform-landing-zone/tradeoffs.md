# Trade-offs — Azure AI platform landing zone

Each row: **choice → upside → downside → signal that tells you to flip**.

---

## Subscription and resource organization

| Choice | Upside | Downside | When to flip |
|--------|--------|----------|--------------|
| **Single AI subscription** | Simple billing, one RBAC table | Noisy neighbor per BU, AOAI quota contention, RBAC sprawl | Split by BU or workload type once >3 teams or quotas collide |
| **Per-environment subscriptions** (dev/staging/prod) | Blast-radius isolation, granular policy | 3× infra overhead, subscription limit planning | Default for regulated workloads; skip for small orgs with strong RBAC |
| **Management group hierarchy** (Platform / Landing Zones / Sandbox) | Policy inheritance, delegated administration | Initial setup cost, risk of policy blocking valid work | Mandatory once >1 BU; avoid flat for any production AI landing zone |

---

## Networking

| Choice | Upside | Downside | When to flip |
|--------|--------|----------|--------------|
| **Private Link everywhere** from day 1 | Clean security narrative, no data traverses public internet | Slower onboarding, DNS ops burden, firewall rule complexity | Start with regulated workloads first; add dev environments incrementally |
| **Service endpoints** instead of Private Link for data services | Lower DNS complexity, supports older SDK versions | Data can still traverse public Microsoft backbone, not fully RFC-1918 | Acceptable for non-sensitive dev; default to Private Link for prod AI |
| **Hub-spoke** vs **Virtual WAN** | Hub-spoke: full control, custom NVA / firewall | Virtual WAN: simpler spoke peering, managed routing | Choose Virtual WAN for large multi-region deployments with complex routing |
| **Azure Firewall** egress vs **NVA** (Palo Alto, Fortinet) | Azure Firewall: native, FQDN rules, simple Bicep/Terraform | NVA: richer threat features, familiar to Ops team | Use Azure Firewall unless existing enterprise NVA policy mandates otherwise |

---

## AI services and LLM deployment

| Choice | Upside | Downside | When to flip |
|--------|--------|----------|--------------|
| **PTU (Provisioned Throughput Units)** vs **PAYG** | PTU: predictable latency, reserved capacity, cost-efficient at sustained load | PTU: expensive if utilization <70%, requires capacity commitment | Flip to PTU when P95 token throughput is consistently >60% of PAYG quota |
| **Single AOAI endpoint** vs **multi-region / multi-deployment pool** | Single: simpler routing logic | Single: no HA, regional outage = total down | Always multi-deployment for prod; failover region is non-negotiable at enterprise bar |
| **Azure AI Foundry (project-based)** vs **raw AOAI resource groups** | Foundry: governance UX, built-in connections, model catalog | Foundry: learning curve, limited Terraform support at GA | Standardize on Foundry when >2 teams; raw AOAI RGs acceptable for first pilot |
| **APIM as AI gateway** vs **application-layer routing** | APIM: policy enforcement, logging, per-tenant quotas in one plane | APIM: operational overhead, quota config per product | Mandatory for multi-tenant or multi-BU — never skip APIM at enterprise bar |
| **Semantic caching (Redis)** vs **no caching** | Redis: 30–60% reduction in AOAI calls for repeated queries, cost saving | Redis: stale context risk, cache-key design complexity | Enable for customer-facing RAG with high query repetition; skip for unique analytics queries |

---

## Identity and secrets

| Choice | Upside | Downside | When to flip |
|--------|--------|----------|--------------|
| **Managed identity + RBAC** vs **client secret** | MI: no credential rotation, no secret sprawl | MI: limited to Azure resources, external apps need workaround | Always prefer MI for workloads running in Azure; use federated credential for GitHub Actions / external CI |
| **Federated credentials (OIDC)** vs **client secret for pipelines** | Federated: zero long-lived secret, no rotation risk | Federated: setup complexity, OIDC issuer trust configuration | Default for all production pipelines; client secret only as a last resort with short TTL |
| **Key Vault per workload** vs **centralized Key Vault** | Per workload: blast radius isolation | Centralized: simpler access policy, fewer vaults to rotate | Centralized acceptable for platform team secrets; per workload for BU-owned secrets |

---

## Compute and ML platform

| Choice | Upside | Downside | When to flip |
|--------|--------|----------|--------------|
| **AKS for inference** vs **Azure Container Apps** | AKS: full control, GPU scheduling, custom networking, KEDA | AKS: operational overhead (node pools, upgrades, SNAT) | Use Container Apps for stateless HTTP inference at low/medium load; AKS when GPU, advanced networking, or KEDA custom scalers needed |
| **Databricks + AML** (both) | Right tool per workload: Databricks for ELT/feature eng, AML for MLOps | Cost + skill split, two operational models | Pick the dominant platform if team <20 people or budget is tight |
| **AML managed compute** vs **AKS inference** | Managed: simpler deployment, auto-scale | Managed: limited customization, no private endpoint for managed online endpoints in all regions | Use AKS when latency SLA <200ms P99 or custom model serving needed |

---

## IaC and delivery

| Choice | Upside | Downside | When to flip |
|--------|--------|----------|--------------|
| **Terraform** vs **Bicep** | Terraform: multi-cloud, rich module ecosystem, state management | Bicep: native ARM, simpler loop syntax, no state file risk | Terraform for polycloud or existing Terraform estate; Bicep for Azure-only greenfield with DevOps team new to Terraform |
| **GitOps (Flux/ArgoCD)** vs **push CD** | GitOps: drift detection, full audit trail, declarative single source of truth | GitOps: complexity, reconciliation lag, harder secrets injection | Use GitOps for AKS workloads; push CD acceptable for initial bootstrapping or simple function deploys |
| **Monorepo IaC** vs **split repos** (platform vs app) | Monorepo: atomic changes, shared modules | Monorepo: blast radius on IaC PR, slow CI at scale | Split repos once platform team owns infra independently of app teams |
| **Protected main + required reviewers** vs **self-merge** | Protected: audit, prevents accidental prod apply | Protected: slows experimentation | Protected main is non-negotiable for prod IaC; dev branches can self-merge |

---

## Governance and cost

| Choice | Upside | Downside | When to flip |
|--------|--------|----------|--------------|
| **Policy-as-code (deny/audit)** vs **advisory guardrails** | Deny: hard enforcement, prevents drift | Deny: blocks valid work without exemption process | Start with audit; flip to deny once exemption process is mature and tested |
| **Token-based chargeback (per BU)** via APIM | Accurate FinOps signal, BU accountability | Log Analytics query cost, APIM product setup | Enable from day 1 for multi-BU platforms; hard to retrofit |
| **Centralized Azure Monitor** vs **per-spoke Log Analytics** | Centralized: unified query, single cost center | Centralized: data sovereignty issues (cross-region log shipping) | Centralized unless data residency regulation prohibits cross-region log export |

---

## Quick-recall: the five decisions that always come up

1. **PTU vs PAYG** — model throughput patterns drive this; PTU wins at >70% sustained load.
2. **Private Link vs service endpoints** — Private Link always for prod AI; service endpoints are a stepping stone.
3. **APIM mandatory** — no exceptions at multi-BU scale; it is your governance enforcement plane.
4. **Managed identity everywhere** — federated credentials for pipelines; no long-lived secrets.
5. **GitOps for AKS** — push CD is a code smell at staff+ level for AKS workloads.
