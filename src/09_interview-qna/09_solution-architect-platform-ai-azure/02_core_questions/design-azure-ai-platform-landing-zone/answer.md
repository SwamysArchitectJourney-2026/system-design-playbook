---
learning_level: "Advanced"
estimated_time: "50 minutes"
topic: "Azure platform landing zone for enterprise AI workloads"
---

# Design an Azure platform landing zone for enterprise AI

## Based on Template v1.1 (Azure-aligned)

Companion: `failures.md`, `tradeoffs.md`, `followups.md`, `../../../01_azure-solutions-architect-role-pattern/01_templates/service-selection-guide.md`. **Prep:** run **`../../01_templates/whiteboard-exercises-platform-ai.md`** before memorizing this spine.

## 1. Clarify requirements

- **Builders:** central AI platform team vs federated app teams; **self-service** vs ticketed provisioning.
- **Workloads:** chat/copilot APIs, **RAG** (AI Search), **batch ML** (AML), **custom** training vs API-only.
- **Compliance:** residency, **PII**, model **audit** trail, allowed **egress** to public OpenAI vs **Azure OpenAI only**.
- **Existing estate:** Databricks / data lake already? **SAP** or line-of-business data boundaries?
- **Roadmap:** MVP connectivity vs full **private-only** AI in phase 2.

## 2. Scale estimation (back-of-envelope)

- Number of **subscriptions**, **projects** (Foundry or logical), **AKS** clusters, **AML** workspaces.
- Peak **inference** TPM/RPM, **embedding** QPS, **Search** SU; **Databricks** DBU if unified analytics path exists.

## 3. High-level architecture

- **Management:** management groups → **platform** subscription(s) (hub, shared services) + **spoke** subscriptions per business unit or environment (dev/test/prod).
- **Hub:** **Firewall**, **DNS** private resolver, optional **App Gateway** / **Front Door** for published APIs, **Bastion** for break-glass.
- **Identity:** **Entra ID**; **managed identities** for workloads; **PIM** for privileged roles; **conditional access** for AI admin portals.
- **AI control plane:** **Azure AI Foundry** resources (projects, model deployments) or structured **resource groups** per product line; **Azure OpenAI** accounts with **regional** pinning; **Azure AI Search** per domain or shared tier with **network rules**; **Azure Machine Learning** workspace(s) for training pipelines.
- **Data path:** **Storage** accounts with **private endpoints**; optional **Microsoft Fabric** or **Databricks** workspace **peer-linked** for lakehouse + **Unity Catalog**-style governance narrative (or Azure-native Purview for catalog).
- **Compute:** **AKS** for custom inference gateways, **AML** compute, or **App Service** for simpler API façades—pick based on team skill and traffic.
- **IaC & delivery:** **Terraform** or **Bicep** modules versioned in Git; **CI/CD** (GitHub Actions / Azure DevOps); **GitOps** (Flux/Argo) for **AKS** desired state.
- **Security:** **Defender for Cloud**, **Azure Policy** deny rules (no public OpenAI keys in Key Vault without approval), **Private Link** to OpenAI/Search where mandated.

### 3.1 Decision: Terraform vs Bicep

- **Chosen:** align to org standard—**Bicep** for Azure-native teams; **Terraform** for multi-cloud policy teams.
- **Rejected:** click-ops for production subscriptions.

### 3.2 Decision: Databricks vs AML-only

- **Chosen: both narratives** — **AML** for Azure-native MLOps; **Databricks** when lakehouse, Spark-heavy ETL, or existing **enterprise** investment.
- **Rejected:** forcing one without **data gravity** and **team** reality.

## 4. Deep dives (pick 2–3)

- **Private Azure OpenAI** end-to-end: DNS, Private Link, **APIM** as façade with **OAuth**.
- **Quota and capacity:** regional **OpenAI** limits; **throttling** and **multi-region** fallback story.
- **Policy-as-code:** sample **deny** policies for unapproved SKUs or public AI endpoints.

## 5. Failure scenarios and mitigations

- **Regional OpenAI outage** — secondary region **active** deployments; **graceful degrade** messaging.
- **Credential sprawl** — **workload identity** only; **no** long-lived keys in repos.
- **Shadow AI** — **policy** + **network** egress deny + **chargeback** visibility.

(See `failures.md`.)

## 6. What breaks first?

1. **Quota / TPM** before network is “wrong.”
2. **DNS and Private Link** misconfiguration — “works in portal, fails from AKS.”
3. **RBAC** complexity — teams blocked from shipping.
4. **Cost** surprise — unbounded **embedding** jobs or **Databricks** autoscale.
5. **Change velocity** — platform **too strict**, teams route around you.

## 7. Key design decisions

| Area | Chosen | Rejected | Because |
|------|--------|----------|---------|
| Edge API | **APIM + Front Door** | naked PaaS URLs | OAuth, rate limits, WAF |
| Secrets | **Key Vault + MI** | keys in CI vars | Rotation + audit |
| Infra as code | **Modules + PR** | manual | Compliance + drift |
| AI project boundary | **Foundry project / RG** | one giant subscription | Blast radius + chargeback |

## 8. Trade-offs summary

- **Centralized vs federated** subscriptions—flip when LOBs need autonomy and you have strong **policy** guardrails.
- **Private-only AI** vs **time-to-market**—phase **public** dev, **private** prod.

## 9. Evolution strategy (MVP → scale → global)

- **MVP:** one spoke, **Azure OpenAI** + **AI Search**, **APIM**, **IaC** baseline, **Policy** essentials.
- **10×:** **AKS** inference pools, **AML** pipelines, **Databricks** integration, **GitOps** mature.
- **Global:** multi-region **inference**, **data** residency per country, **federated** catalogs.

## 10. Security architecture

**Entra ID**, **MI**, **Private Link**, **Defender**, **encryption** at rest, **network** segmentation, **audit** for model access and **prompt** logging policy (redacted).

## 11. Observability and operations

Central **Log Analytics**, **metrics** on OpenAI/Search/AML, **cost management** budgets, **alerts** on quota and **anomaly** spend.

## 12. Cost considerations

**PTU vs PAYG** for OpenAI; **Search** SU; **AKS** node pools; **Databricks** DBU; **egress**; **reserved** where steady.

## Stakeholder narrative

Translate **business outcomes** (“faster compliant copilots”) into **phased** platform capabilities and **risks** you mitigate each quarter—not a single big-bang diagram.
