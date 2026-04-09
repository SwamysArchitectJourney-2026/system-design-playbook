---
learning_level: "Advanced"
estimated_time: "90 minutes"
learning_objectives:
  - "Run principal-style interviews: broken enterprise on the whiteboard, not service definitions"
  - "Use strict red/strong signals for AI gateway, AKS outbound, Cosmos CAP, and OIDC pipelines"
---

# Principal / enterprise architect interview pack (expanded)

**Evaluation stance:** For a **deep veteran**, you rarely win signal by asking what a service *does*. You present a **broken or risky enterprise** and ask them to **fix or redesign it on the whiteboard**, then stress the drawing with constraints.

This pack complements **`whiteboard-exercises-platform-ai.md`** with **four end-to-end scenarios**: expected **diagram layers**, **technical depth** to listen for, and **strict** evaluator notes.

---

## Exercise 1 — Enterprise AI platform standardization (whiteboard)

### Scenario

Five BUs ship GenAI features by **calling public LLM APIs directly**, **embedding long-lived keys** in code, generating **unattributed** cloud spend, and worrying **security** about **PII** in prompts. You must design a **central, governed AI route** on **Azure** that every BU **must** use.

### What they should draw

1. **Client / BU layer** — VNet-integrated workloads (**App Service**, **AKS**, **Functions**) with **no** direct vendor keys.
2. **Gateway layer** — **Azure API Management** as the **single AI façade** (policies, auth, routing, quotas).
3. **Backend layer** — **Azure OpenAI** (often **multiple** deployments / regions); optional **controlled** egress to **approved** external models only if policy allows.
4. **Security / data plane** — **Key Vault** (prefer **secrets only where unavoidable**), **Entra ID**, **Log Analytics** / **Monitor**, **Redis** (or equivalent) for **cache** if they argue semantic deduplication.

### Depth to expect (architect answer)

- **Identity:** Prefer **managed identities** and **OAuth** end-to-end: workloads → **APIM**, APIM → **Azure OpenAI** (or federated pattern), **banning** static API keys in application repos for platform calls.
- **Networking:** **Private endpoints** for **Azure OpenAI** where mandated; **public access disabled** on the service; explain **DNS** resolution from workloads.
- **Governance on the gateway:** APIM **policies** tuned for LLMs—e.g. **token-aware** throttling and quotas **per BU** (FinOps), not only **HTTP request** counts.
- **PII risk:** A **policy** or **small intermediary** (function/container) for **detection/redaction** (e.g. Presidio-style or **Azure AI Language** PII categories) **before** the model sees text—trade **latency** vs **risk** explicitly.
- **Cost / latency:** **Semantic or near-duplicate caching** (Redis) with a clear **staleness** and **tenant isolation** story so BU-A does not leak answers to BU-B.

### Evaluation

- **Red flag:** One **disposable OpenAI resource per BU** with no **shared** governance story; **keys in env vars** as the main pattern; “we’ll monitor later” with **no** APIM.
- **Strong signal:** **APIM as AI gateway** is immediate; they separate **token** budgets from **request** counts; they name **identity + private path + policy** in one coherent flow.

---

## Exercise 2 — AKS operational depth (troubleshooting + architecture)

### Scenario

Large **AKS** cluster (**500+** services). During a **flash sale**, **CPU and memory** look healthy, but pods calling a **third-party payment** API see **502 / 504** and **connection timeouts** in app logs.

### Triage narrative to listen for

- **Hypothesis ordering:** Suspect **egress / SNAT** and **connection lifecycle** before “scale pods” theater.
- **Data:** **Load balancer** / **outbound** metrics—**SNAT port** pressure, **allocated** vs **used** ports, **connection** churn.
- **Validation:** Correlate spike with **outbound connection** count and **same destination** IP:port fan-out from many pods.

### Permanent fix (short vs long)

- **Short-term relief:** Increase **outbound SNAT** capacity (e.g. more **outbound IPs** on the LB path where applicable)—**explicitly** call it **mathematical** port headroom, not magic.
- **Long-term Azure pattern:** **NAT Gateway** on the **AKS** subnet (or approved outbound architecture) for **scalable** outbound SNAT; align with **Microsoft** guidance for heavy egress.
- **Application hygiene:** Mandate **HTTP connection pooling** and **HttpClient** lifetime discipline (e.g. **IHttpClientFactory** on .NET) so the cluster stops opening **ephemeral** sockets per call.

### Evaluation

- **Red flag:** “Restart pods,” “add RAM,” or “scale replicas” **without** **network** diagnosis when **CPU/RAM** are fine.
- **Strong signal:** **SNAT exhaustion** named early; **NAT Gateway** (or equivalent **documented** outbound design); **pools** and **client** reuse as part of the **system** fix.

---

## Exercise 3 — Enterprise trade-offs (Cosmos, global logistics)

### Scenario

Global logistics: writes from **North America** and **Europe**. **Cosmos DB**. Business asks for **zero data loss**, **instant global consistency**, and **zero latency**—all at once.

### How a principal responds

- **Reframe requirements** using **CAP** (and **physics**): you cannot promise **strong global consistency** and **local interactive latency** without **cost** the business may refuse.
- **Architecture direction:** **Multi-region writes** when **throughput** and **availability** need it; **session** or **bounded staleness** consistency for **read-your-writes** and predictable UX instead of pretending **planet-scale strong** everywhere.
- **Conflicts:** **Active-active** implies **conflicts**—state **LWW** with trustworthy **timestamps**, **custom** merge, or **domain-specific** resolution—**before** production, not “we’ll see.”

### Evaluation

- **Red flag:** “**Strong** consistency globally, no latency impact” with no **numbers** or **trade-off** discussion.
- **Strong signal:** **Pushes back** on the business with **clear** options; **conflict resolution** appears **unprompted** with multi-write.

---

## Exercise 4 — CI/CD and IaC rigor (whiteboard, zero standing secrets)

### Scenario

Auditors flag **client secrets** for a **service principal** in **GitHub Actions** deploying **Terraform**. A developer **logged** a secret last month. Redesign for **no long-lived** pipeline credentials.

### What they should draw

- **GitHub** workflow → **OIDC** trust boundary → **Entra** **federated credential** (workload identity federation) → **subscription** scope (least privilege).
- **Terraform state** in **Storage** with **network** hardening; runners that can reach state **without** public blast radius (**self-hosted** in VNet or **OIDC**-compatible pattern they can defend).
- **Governance:** **Azure Policy**, **Defender for DevOps** / PR scanning—**shift-left** on IaC.

### Depth to expect

- **Eliminate** SP **passwords**: **OIDC** JWT from GitHub → **Entra** validation (**issuer**, **audience**, **subject** claims tied to **repo** and **branch**—e.g. only **`main`** → **prod**).
- **State file** protection: **private** access, **RBAC**, **encryption**; **no** broad **storage keys** in CI.
- **Static analysis:** **Checkov**, **tfsec**, or similar **fails PR** on **critical** misconfigurations.

### Evaluation

- **Red flag:** “Move secrets to **Key Vault**” as the **whole** answer—**still** needs a **bootstrap** secret to reach Vault from CI.
- **Strong signal:** **OIDC / federation** articulated cleanly; **state** security and **IaC** scanning in the **same** story.

---

## Overall evaluation matrix — architectural posture

Score **how** they operate, not only **what** they name.

1. **Default to business value** — Do they **right-size** compute (e.g. **App Service** until **scale** forces **AKS**), or chase **fashion**?
2. **“I” vs “we”** — Do they describe **personal heroics** or **standards**, **enablement**, and **platform** adoption?
3. **Friction under challenge** — When you **invalidate** part of the whiteboard, do they **defend blindly** or **reframe**: *“If cost is the primary driver, we can pivot to …”*?

Pair this section with **`architect-evaluation-rubric-platform-ai.md`** for numeric dimension scoring.
