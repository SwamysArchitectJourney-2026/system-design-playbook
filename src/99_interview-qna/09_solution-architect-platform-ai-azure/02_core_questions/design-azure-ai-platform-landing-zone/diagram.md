# Diagram: Azure AI platform landing zone

Use these on the whiteboard in order **1 → 2** for topology, then **pick 2–3** deep dives (3–6) by interview focus.

## 1. Hub–spoke and AI spoke (topology)

```mermaid
flowchart TB
  subgraph mgmt [Management groups]
    M[Policies and budgets]
  end
  subgraph hub [Hub subscription]
    FW[Azure Firewall / DNS]
    APIM[API Management]
  end
  subgraph spoke [Spoke subscription — AI workload]
    AKS[AKS optional]
    AOAI[Azure OpenAI]
    AIS[Azure AI Search]
    AML[Azure Machine Learning]
    FP[AI Foundry project boundary]
    ST[Storage private endpoints]
  end
  subgraph data [Data plane optional]
    DB[Databricks / Lake]
  end
  M --> hub
  FW --> spoke
  APIM --> AKS
  APIM --> AOAI
  AKS --> AIS
  FP --> AOAI
  FP --> AIS
  AML --> ST
  ST --> DB
```

## 2. Edge request path (OAuth + façade)

```mermaid
sequenceDiagram
  participant U as Client / LOB app
  participant E as Entra ID
  participant FD as Front Door optional
  participant A as API Management
  participant O as Azure OpenAI / Foundry endpoint
  U->>E: OAuth 2.0 / OIDC token
  E-->>U: JWT access token
  U->>FD: HTTPS API call plus Bearer
  FD->>A: Forward with WAF / routing rules
  A->>A: Validate JWT, rate limit, rewrite backend URL
  A->>O: Authorized inference or chat completion
  O-->>A: Model response
  A-->>U: Response plus correlation id
```

**Narration:** Front Door is optional when you need global edge and WAF in front of APIM; small shops sometimes terminate at APIM with network rules.

## 3. Workload identity and secrets (no keys in repos)

```mermaid
flowchart LR
  subgraph entra [Entra ID]
    MI[User-assigned or system MI]
    PIM[PIM for human admins]
  end
  subgraph workloads [Spoke workloads]
    POD[AKS pods / AML jobs / Functions]
  end
  subgraph secrets [Secret plane]
    KV[Key Vault]
  end
  subgraph targets [Azure RBAC targets]
    AOAI[Azure OpenAI]
    SRCH[AI Search]
    STG[Storage]
  end
  POD --> MI
  MI --> KV
  MI --> AOAI
  MI --> SRCH
  MI --> STG
  PIM -.->|just-in-time| KV
```

## 4. Private Link path (why “works in portal, fails from AKS”)

```mermaid
flowchart TB
  subgraph spoke [Spoke VNet]
    AKS[AKS nodes / pod network]
    PE_AOAI[Private endpoint — OpenAI]
    PE_SRCH[Private endpoint — Search]
    DNS[Private DNS zone links]
  end
  subgraph backbone [Microsoft backbone]
    PLS_AOAI[Private Link service — PaaS]
    PLS_SRCH[Private Link service — PaaS]
  end
  AKS --> PE_AOAI
  AKS --> PE_SRCH
  PE_AOAI --> PLS_AOAI
  PE_SRCH --> PLS_SRCH
  DNS -.->|resolve FQDN to private IP| AKS
```

**Narration:** Mis-linked **private DNS zones** or **split-horizon** mistakes are the usual production break; call out **DNS** explicitly in interviews.

## 5. RAG retrieval path (platform view)

```mermaid
flowchart LR
  subgraph ingest [Ingestion optional batch]
    SRC[LOB / lake / files]
    IDX[Indexer / pipeline]
    STG[Blob / ADLS]
    SRC --> IDX
    IDX --> STG
  end
  subgraph search [Azure AI Search]
    AIS[Search index]
    STG --> AIS
  end
  subgraph infer [Inference]
    APIM[APIM]
    EMB[Embeddings deployment]
    LLM[Chat completion deployment]
    APIM --> EMB
    APIM --> LLM
  end
  AIS -->|hybrid / vector query| APIM
  EMB -->|query vector| APIM
```

**Narration:** Chargeback and throttling split across **Search SU**, **embedding** volume, and **completion** TPM; platform teams often own APIM policies and per-app keys.

## 6. Multi-region inference (active–active story)

```mermaid
flowchart TB
  FD[Front Door — health probes]
  subgraph primary [Region A — primary]
    APIM_A[APIM / gateway]
    OAI_A[Azure OpenAI deployment A]
    APIM_A --> OAI_A
  end
  subgraph secondary [Region B — secondary]
    APIM_B[APIM / gateway]
    OAI_B[Azure OpenAI deployment B]
    APIM_B --> OAI_B
  end
  FD --> APIM_A
  FD --> APIM_B
```

**Narration:** Pair with **quota** and **data residency** caveats—second region only helps if **capacity** exists and **compliance** allows dual processing.

## 7. IaC and policy loop (drift and guardrails)

```mermaid
flowchart TB
  GIT[Git main plus protected branches]
  PR[Pull request]
  SCAN[IaC scan — Checkov tfsec]
  CICD[Pipeline — OIDC to Azure]
  TF[Terraform / Bicep apply]
  POL[Azure Policy assignments]
  DEF[Defender for Cloud]
  GIT --> PR
  PR --> SCAN
  SCAN --> CICD
  CICD --> TF
  POL -.->|deny noncompliant| TF
  TF --> spoke[Spoke subscriptions]
  DEF -.->|recommendations| PR
```

## Narration walkthrough

1. **Management groups** push **Azure Policy**, tags, and **Defender** baselines.
2. **Hub** provides **shared** egress, **DNS**, and optional **APIM** / **Front Door** entry.
3. **Spoke** hosts **AI** resources in a **project** or **RG** boundary with **Private Link** to PaaS where required.
4. **AML** and **storage** feed **training**; **optional Databricks** extends **lakehouse** and **Spark** analytics with governance story.
5. **GitOps / IaC** owns drift; **identity** is **workload-based** into **Key Vault** and **Azure RBAC**.
6. Use **diagram 2** when the interviewer asks how **OAuth** meets the **API**; **diagram 4** when debugging **connectivity**; **diagram 5** for **RAG** cost and ownership; **diagram 6** for **resilience**; **diagram 7** for **platform engineering** maturity.
