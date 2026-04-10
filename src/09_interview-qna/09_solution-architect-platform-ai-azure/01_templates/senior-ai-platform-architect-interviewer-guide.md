---
learning_level: "Advanced"
estimated_time: "25 minutes"
learning_objectives:
  - "Score a very senior Platform AI SA on enterprise judgment, not service recall"
  - "Use scenario prompts and live stressors aligned with the rest of this track"
---

# Senior AI platform architect — interviewer guide

**Audience:** interviewers mock-running a **Solution Architect / AI Platform Architect** loop for candidates with **~20+ years** experience.

**Why:** At this level, the signal is **reasoning under constraints**—subscriptions, governance, production scars—not **feature trivia** or **certification recall**.

**Pairs with:** `principal-enterprise-architect-interview-pack.md`, `whiteboard-exercises-platform-ai.md`, `troubleshooting-drills-platform-ai.md`, `architect-evaluation-rubric-platform-ai.md`, and `../02_core_questions/design-azure-ai-platform-landing-zone/`.

---

## 1. What you are really testing

| Lens | Strong signal | Weak signal |
|------|---------------|-------------|
| **Enterprise scope** | Multi-subscription landing zones, hub-spoke, shared platform, BU isolation, DR/regional models, platform SLAs | Single-app diagram only |
| **Trade-offs** | Justifies AKS vs Container Apps, Search vs bring-your-own vector store, Terraform vs Bicep, APIM vs naked endpoints, central vs federated governance—across **cost, ops, compliance, lock-in, team skills** | Names services without comparison |
| **Governance** | Model approval, prompt policy, RAI review, audit logging, RBAC boundaries, quotas, safety filters, policy enforcement, prod release gates | “We’ll use Azure Policy” with no story |
| **Platform standardization** | RAG templates, approved connectors, golden paths, default observability, reusable CI/CD modules, common auth—**platform as product** | Every team reinvents the stack |
| **AKS in production** | Node pools, autoscaling, GPU scheduling, ingress, workload identity, secrets story, rollouts (blue/green/canary), upgrades, PSS/netpol, observability | Treats Kubernetes as “just hosting” |
| **Security** | MI, Entra, Key Vault, Private Link, NSG/WAF, Defender, exfiltration thinking, Zero Trust, least privilege | Checkbox list without data paths |
| **IaC / delivery** | Modules, promotion, policy-as-code, drift, approvals, rollback, **OIDC**-style CI auth, GitOps | “We have pipelines” without guardrails |

---

## 2. Strong follow-ups (any whiteboard)

1. How do **multiple business units** share one AI platform **without** shared fate on every outage?
2. What is **centralized** vs **federated**—and where does **policy** draw the line?
3. How do you stop every team rebuilding the **same RAG + APIM + observability** stack?
4. How does this **scale globally** (residency, latency, quota)?
5. What happens in a **regional Azure incident**—degrade, failover, or pause?

---

## 3. Live stressors (interrupt the candidate)

Use **one** mid-exercise to test reframing, not defensiveness:

- Legal: **no enterprise data** on **public** endpoints for this workload.
- Traffic **10×** overnight—where does it break first?
- One BU demands **isolated billing** and **separate** failure domain.
- Security demands **full auditability** of model access and prompts (redaction policy still required).
- Chat **latency** SLA missed—trace **edge → gateway → retrieval → model**.
- **OpenAI token spend** doubled—**FinOps** triage, not “use a smaller model” only.

---

## 4. Scenario bank (whiteboard or deep dive)

Each block: **prompt**, **draw / discuss**, **strong answer themes** (not a script).

### S1 — Enterprise AI platform foundation

**Prompt:** Design an **enterprise-grade** Azure AI platform so multiple BUs ship copilots, RAG assistants, and ML-backed apps **safely**.

**Whiteboard:** Channels → gateway → auth → OpenAI / Search / AML → AKS (if any) → storage → monitoring → **governance boundaries** (RG/subscription/policy).

**Strong themes:** Layered architecture (experience, API, identity, AI services, compute, data, governance, observability); **hub-spoke** and **landing zone** alignment; **APIM + Front Door** for edge controls; **MI** and **Private Link** where mandated.

**Track links:** `../02_core_questions/design-azure-ai-platform-landing-zone/answer.md` + `diagram.md`; principal RAG lifecycle and narration: `../02_core_questions/enterprise-rag-platform-principal/architecture.md`.

### S2 — Production RAG platform

**Prompt:** **Production RAG** for enterprise knowledge—end to end.

**Whiteboard:** Ingestion → retrieval → generation; security and **cost** owners.

**Strong themes:** Parse/chunk/embed/index; **hybrid + metadata** filters; **rerank** optional; grounded prompts; **citations**; safety validation; **idempotent** ingestion and **PII** handling.

### S3 — AKS inference under spikes

**Prompt:** Inference on **AKS** faces **unpredictable** spikes—design for **resilience**.

**Strong themes:** **GPU** pools separate from control-plane-ish CPU pools; **HPA** + **cluster autoscaler**; ingress capacity; **queue** buffering; **caching**; **PDB**; canary; **SNAT/NAT** awareness if egress-heavy (see troubleshooting drills).

### S4 — Security review: RAG without public paths

**Prompt:** Security says RAG documents **must not** traverse the **public internet**. Redesign.

**Strong themes:** **Private Link** / private endpoints; **VNet integration**; **disable public** access where applicable; **private DNS**; **MI** to storage/Search/OpenAI; **WAF** at ingress; validate **indexer** and **batch** paths too—not only runtime chat.

### S5 — Cost explosion (OpenAI)

**Prompt:** **Azure OpenAI** bill **doubled** this month—what do you inspect **first**?

**Strong themes:** **Token** growth vs traffic; prompt **bloat**; **retries**; **history** window; **abuse**; **cache** misses; duplicate **embedding** jobs; inefficient **orchestration** (N+1 LLM calls). Tie to **metrics**, **APIM** analytics, and **chargeback** dimensions.

### S6 — Terraform failed mid-apply

**Prompt:** **Production** Terraform apply **failed halfway**—what now?

**Strong themes:** **State** truth; partial resources; **drift** vs intent; **permissions** and locks; **safe rollback** vs targeted **import**; controlled **reapply**; postmortem on **blast radius** and **module** boundaries.

### S7 — AML model to production

**Prompt:** Data scientists trained in **Azure ML**—how do you **operationalize** safely?

**Strong themes:** **Register** model; **validation** pipeline; **human** approval gate; **managed endpoint** (or approved pattern); **drift** and **monitoring**; feedback loop; **documented rollback**.

---

## 5. Executive scoring rubric (holistic)

| Dimension | Good looks like |
|-----------|-----------------|
| System design | Coherent layers, clear boundaries, scalable topology |
| Trade-offs | Explicit alternatives and **because** |
| Security | Data paths, identity, network, audit—not buzzwords only |
| Platform thinking | Reuse, standards, self-service without anarchy |
| Operations | Upgrades, incidents, quotas, runbooks implied |
| Governance | Safe AI scaling (policy, RAI, approvals) |
| Communication | Structured, interviewer-guided, no ramble |
| Leadership | Standards, influence, trade-off with stakeholders |

Map numeric detail to **`architect-evaluation-rubric-platform-ai.md`**.

---

## 6. Calibration — what to over- and under-index

**Do not** over-index on: syntax, exact SKU names, certification trivia, “list all Azure AI services.”

**Do** over-index on: **decision quality**, **production realism**, **governance maturity**, **organizational** influence, and **calm reframing** when you challenge their diagram.

---

## 7. Differentiator (one sentence)

**Very senior architects** are separated by **quality of reasoning under enterprise constraints**—not by how many services they can name in sixty seconds.
