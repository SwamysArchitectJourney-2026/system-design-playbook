---
learning_level: "Advanced"
estimated_time: "40 minutes"
topic: "AI-powered architecture on Azure"
---

# Design an AI-powered architecture on Azure (RAG + APIs)

## Clarify

- Use case: **RAG** over internal docs, **agents** with tools, or batch inference?
- **Latency** and **cost per request** budgets; **PII** and **data residency**; model hosting (**Azure OpenAI**, **AI Foundry**, BYO container on AKS).

## Estimate

- Tokens per request, QPS, embedding dimension, index size, cache hit rate targets.

## Architecture

- **Edge:** Front Door → **API Management** (auth, rate limits, **quota per tenant**).
- **Orchestration:** App Service / AKS service calling **Azure OpenAI**; **semantic caching** (Redis) for repeated queries.
- **Retrieval:** **Azure AI Search** (vector + hybrid) or **Cosmos** vector index; ingestion pipeline (Functions) chunking + embedding writes.
- **Storage:** Blob for raw docs; metadata in SQL/Cosmos; **Key Vault** for keys.
- **Observability:** trace `request_id`, token usage, retrieval latency, model latency; content safety filters.

## Deep dives

- **Grounding** failures—fallback to “I don’t know”; citations returned to client.
- **Tool calling** security—allow-lists, human approval for destructive tools.
- **Evaluation** harness offline before prompt changes ship.

## Failures

- Model **429** / timeout—backoff, queue async answer, degrade to smaller model.
- Search index stale—**version** documents; TTL refresh jobs.

## Trade-offs / evolution

- Managed OpenAI vs self-hosted on AKS (cost, control, compliance).
- MVP: single region + AI Search + OpenAI; scale: multi-region read, caching, dedicated capacity units.

Cross-link: `../../interview-execution/03_cross-domain-prompt-bank.md`.
