---
learning_level: "Advanced"
estimated_time: "40 minutes"
topic: "AI-powered architecture on Azure"
---

# Design an AI-powered architecture on Azure (RAG + APIs)

## Based on Template v1.1

Companion: `failures.md`, `../../01_templates/service-selection-guide.md`. Cross-link: `../../interview-execution/03_cross-domain-prompt-bank.md`.

## 1. Clarify requirements

- **Use case:** **RAG** over internal docs, **agents** with tools, batch inference, or **mixed**.
- **Latency** and **cost per request**; acceptable **degradation** (smaller model, async answer).
- **PII**, **data residency**, retention, and **human-in-the-loop** for sensitive actions.
- **Model hosting:** **Azure OpenAI** / **AI Foundry** vs **BYO container on AKS** (compliance, control).

## 2. Scale estimation (back-of-envelope)

- **QPS**, tokens in/out per request, embedding dimension, **vector index** size, **cache hit** target.
- Ingestion: docs/day, chunk count, re-embed frequency.

## 3. High-level architecture

- **Edge:** **Front Door** → **API Management** (auth, **per-tenant quota**, request size limits).
- **Orchestration:** **App Service** or **AKS** service coordinating retrieval + model calls; **semantic cache** (**Redis**) for near-duplicate queries.
- **Retrieval:** **Azure AI Search** (hybrid + vector) or **Cosmos DB** vector index—pick on ops maturity and query patterns.
- **Storage:** **Blob** for raw docs; **metadata** in SQL/Cosmos; **Key Vault** for keys; **optional** private networking for index and storage.
- **Safety:** content filters, **allow-listed tools**, audit log of tool invocations.

### 3.1 Decision: Azure OpenAI vs self-hosted on AKS

- **Chosen: Azure OpenAI / Foundry** for default enterprise path—**compliance**, **SLA**, **capacity** management via platform.
- **Chosen: AKS + container** when **custom weights**, **air-gapped**, or **fine-tuned** runtime needs full control.
- **Rejected: “Always AKS”** without staffing story—ops and security surface explode in interview cross-exam.

### 3.2 Decision: AI Search vs Cosmos vector

- **Chosen: AI Search** when **full-text + vector + ranking** and search UX matter.
- **Chosen: Cosmos** when data already lives there and **low-latency colocation** wins.
- **Rejected: Redis as primary vector store** for large corpora—wrong durability/index story unless interviewer narrows scope.

## 4. Deep dives (pick 2–3 in the room)

- **Grounding failures** — explicit “I don’t know,” **citations**, confidence gating.
- **Tool calling security** — allow-lists, argument validation, **human approval** for destructive tools.
- **Offline eval** — golden sets, regression on prompts/models before **canary** release.

## 5. Failure scenarios and mitigations

1. Model **429 / timeout** — exponential backoff, **queue async** completion, **fallback model**.
2. **Retriever returns empty/wrong** — hybrid search, **metadata filters**, user-visible uncertainty.
3. **Index stale** — doc **versioning**, **TTL** refresh jobs, invalidation on publish.
4. **Prompt injection / data exfil** — system prompts, **tool** sandbox, **output** filtering.
5. **Cost runaway** — per-tenant **budgets**, **max tokens**, **cache**, abuse detection at APIM.

(See `failures.md`.)

## 6. What breaks first?

1. **Azure OpenAI TPM/RPM** ceiling — whole product slows before your **App Service** CPU moves.
2. **Retriever p95** — embedding + index latency dominates **TTFB**.
3. **Redis/cache** miss storm on viral query — downstream **duplicate** expensive calls.
4. **Ingestion pipeline** — backlog of unembedded docs → user sees **stale** answers.
5. **Observability gap** — you cannot attribute **cost** or **latency** to retrieval vs completion vs tools.

## 7. Key design decisions

| Area | Chosen | Rejected | Because |
|------|--------|----------|---------|
| Model access | **Azure OpenAI** | random public API | Enterprise compliance + capacity |
| Retrieval | **AI Search** | naive SQL LIKE | Hybrid + vector at scale |
| Edge governance | **APIM** | naked HTTP | Quotas, OAuth, policies |
| Cache | **Redis semantic cache** | none | Cost + latency on duplicates |

## 8. Trade-offs summary

- **More grounding (extra retrieval hops)** vs **latency** — tune **top-K** and **rerank** cost.
- **Strongest model** vs **cost** — route **tier** by task complexity.
- **Sync answer** vs **async job** for long reports — product + SLO trade-off.

## 9. Evolution strategy (MVP → scale → global)

- **MVP:** single region, AI Search + Azure OpenAI + APIM + basic eval + logging.
- **10×:** semantic cache, **dedicated** capacity / PTU story, **canary** deploys, **multi-index** per domain.
- **Global:** **region-pinned** data and models; **read** replicas where supported; **egress**-aware routing.

## 10. Security architecture

**Entra ID** for users; **managed identities** to Key Vault, Search, storage; **private endpoints** as required; **tenant isolation** in index partitions; **tool** sandbox and **audit**.

## 11. Observability and operations

Trace **`request_id`**, **retrieval** latency, **token** usage, **tool** calls; SLOs on **answer** latency and **grounding** error rate; **content** safety alerts.

## 12. Cost considerations

**Token** spend (in/out), **Search** SU, **Redis** tier, **Blob** storage, **egress**; **per-tenant** chargeback metrics; **batch** off-peak embedding jobs.
