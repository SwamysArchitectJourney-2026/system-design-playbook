# Whiteboard exercises — Platform AI on Azure

**Use heavily.** Drawing reveals **ordering**, **omissions**, and **comfort with ambiguity** faster than verbal Q&A. Timebox each exercise; interviewer interrupts allowed.

**Principal / enterprise depth:** For **four** stricter scripted scenarios (central AI gateway, AKS SNAT, Cosmos CAP, OIDC pipelines) with **evaluator red/strong flags**, use **`principal-enterprise-architect-interview-pack.md`** alongside this file.

---

## Exercise 1 — Hub / spoke + private AI (25 min)

**Prompt:** *“Three business units each need Azure OpenAI and AI Search in their own subscription. Security mandates **no public** inference endpoints. Draw hub, spokes, DNS, and where **API Management** or **Front Door** might sit.”*

**Draw:**

- Management group → hub subscription (Firewall, DNS private resolver, optional shared APIM) → three spokes.
- **Private Endpoint** subnets for **Azure OpenAI** and **AI Search** per spoke (or centralized AI subscription—**defend** either).
- **Private DNS zones** attachment scope (hub vs spoke).
- Identity path: **user** / **workload** → **Entra ID** → **RBAC** on AI resources.

**Strong signals:** Says **what breaks** if DNS is wrong; mentions **conditional forwarders** or **linking** zones; separates **data plane** vs **control plane** access; calls out **quota** per region.

**Weak signals:** Only public endpoints “for now”; no **DNS** story; conflates **VNet** with **Private Link** security.

---

## Exercise 2 — AI platform standardization (20 min)

**Prompt:** *“Forty teams want **copilots**. You must **standardize** models, keys, logging, and cost—without a central bottleneck that stalls every team. Whiteboard the **platform** boundary.”*

**Draw:**

- **Project** or **resource group** pattern per product; **shared** vs **dedicated** OpenAI accounts.
- **Policy** and **guardrails** (deny public keys, enforce tags, allowed SKUs).
- **Self-service** path (template repo, pipeline, **golden** modules) vs **ticketed** exceptions.
- **Observability** and **chargeback** (subscription tags, cost allocation, **token** metrics).

**Strong signals:** **Tiered** landing (sandbox vs prod); **exception** workflow with **time limit**; **shadow AI** mitigation (egress control).

**Weak signals:** “Everyone gets Owner”; no **finops** or **audit** hook.

---

## Exercise 3 — AKS as AI gateway (25 min)

**Prompt:** *“Inference gateway on **AKS**: rate limiting, auth, routing to **Azure OpenAI**. Draw networking, identity, and how you’d **roll out** a new model version.”*

**Draw:**

- Ingress (**App Gateway** / **NGINX** / **AGIC**), **TLS**, **pod** → **user-assigned MI** or **OIDC** → **Azure RBAC** to OpenAI.
- **Network Policy** (egress allow-list to OpenAI PE only).
- **Namespaces** per team vs per env; **resource quotas**.
- **Deployment** strategy: **canary** at gateway + **backend** OpenAI deployment swap; **GitOps** (Flux/Argo) for manifests.

**Strong signals:** **Upgrade** channel (AKS); **CNI** implications; **CoreDNS** + private DNS for PE; **pod identity** failure modes.

**Weak signals:** Treats AKS as “just VMs”; no **egress** control; ignores **secret** rotation.

---

## Exercise 4 — IaC + GitOps + model promotion (20 min)

**Prompt:** *“**Terraform** provisions subscriptions and **Private Link**. **GitOps** owns **AKS** workloads. A new **OpenAI deployment** must go **dev → test → prod**. Draw repos, pipelines, and **who approves** what.”*

**Draw:**

- Split: **platform** IaC repo vs **app** GitOps repo; **module** versioning (semver, **signed** commits optional).
- **Pipeline** gates: plan/apply separation; **manual** approval prod; **policy** scan (Checkov/Sentinel).
- Model promotion: **separate** from cluster deploy or **same** release train—**justify**.

**Strong signals:** **Drift** detection; **state** backend security; **rollback** story for bad model.

**Weak signals:** Single repo “for everything”; no **separation of duties**.

---

## Exercise 5 — Multi-region + residency (20 min)

**Prompt:** *“EU data **must not** leave EU for **training** data; **inference** may have a **US** fallback for DR only. Sketch the minimum viable topology.”*

**Draw:**

- Regional **pairs** or active-passive; **storage** and **Search** pinned EU; **OpenAI** deployments in EU + optional US.
- **Front Door** / **Traffic Manager** routing rules; **RPO/RTO** language.
- **Global** resources (Entra, DNS) vs **data** residency.

**Strong signals:** **Legal** vs **technical** boundary clarity; **failover** **write** path (single writer).

**Weak signals:** “We replicate Cosmos everywhere” without **AI**-specific constraints.

---

## Exercise 6 — “It worked yesterday” (15 min whiteboard + 10 min talk)

**Prompt:** *“**OpenAI** calls succeed from **jump box**, **fail** from **AKS pods** after a **network change**. What do you verify **in order** on the board?”*

**Draw a numbered list** branching into: DNS resolution → PE IP → **NSG**/Firewall rules → **route table** → **egress** SNAT → **RBAC** / token audience → **private zone** linkage.

**Strong signals:** **tcpdump**/curl from pod; **CoreDNS** config; **correlation** with change ticket.

**Weak signals:** Randomly toggles public access; blames “Kubernetes” without **path** analysis.

---

## Facilitation tips (solo or pair)

- Draw **boxes and arrows** before bullets.
- State **assumptions** aloud; invite **one** constraint change mid-exercise.
- End each exercise with: **“What breaks first under load?”** and **“What would you not automate in v1?”**
