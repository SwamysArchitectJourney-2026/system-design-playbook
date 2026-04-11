# Spoken spine — Platform AI on Azure

**Prefer** `whiteboard-exercises-platform-ai.md` **first** in prep sessions; use this file to **tighten** narration after you can **draw** the topology.

Use when the prompt is **“design our Azure platform for AI”** or **“landing zone + AI services + governance.”** Pair with `../02_core_questions/design-azure-ai-platform-landing-zone/`.

## Open (stakeholder)

- **Who** builds models/apps (central platform team vs federated LOB)?
- **Regulatory** and **data residency**; **internet vs private** access to models.
- **Roadmap** tension: speed to first copilot vs **hard guardrails** day one.

## Platform pillars (say in order)

1. **Organization** — management group hierarchy, subscription pattern (hub/spoke or landing zone modules), cost allocation tags.
2. **Network** — private connectivity to PaaS, **Private Link** where required, egress control, **Firewall / App Gateway** patterns for AI APIs.
3. **Identity** — **Entra ID**, workload identity, **per-project** RBAC, **key vault** and secret rotation; break-glass.
4. **AI services** — **Azure AI Foundry** (or equivalent project boundary), **Azure OpenAI** deployments, **AI Search** SKUs, **AML workspace** for training/batch; **when to add Databricks** (lakehouse, governance, Spark scale).
5. **Delivery** — **IaC** (Terraform or Bicep), **CI/CD**, **GitOps** for AKS or cluster configs; **policy-as-code** (Azure Policy, Defender).
6. **Observability & FinOps** — logging, metrics, **token/cost** chargeback model, quotas.

## Close

- **MVP** vs **phase 2** (e.g. private endpoints everywhere, multi-region inference).
- One **risk** you still own: data exfiltration, quota blowout, or shadow AI projects.
