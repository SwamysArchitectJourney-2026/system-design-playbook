# Trade-offs — Enterprise RAG platform (principal)

Each row: **choice → upside → downside → signal that tells you to flip**.

---

## Retrieval strategy

| Choice | Upside | Downside | When to flip |
|--------|--------|----------|--------------|
| **Pure vector search** | Simple index schema, fast semantic similarity | Fails on exact-match (IDs, legal codes, product names), embedding drift across model versions | Flip to **hybrid (vector + BM25 keyword)** for any enterprise corpus with structured identifiers |
| **Hybrid retrieval (BM25 + vector, RRF fusion)** | Best of both: semantic similarity + exact-match precision | Slightly higher complexity, latency +20–40ms, requires both keyword and vector index fields | Default for enterprise; drop keyword if corpus is purely narrative and no structured IDs |
| **Semantic ranker (AI Search)** | Re-ranks top-k with language model, significant precision boost | Adds ~200ms latency, consumes SU, costs more | Enable when users demand high answer precision; skip for low-latency or high-volume batch |
| **Top-k = 5 (default)** | Reasonable context coverage | Context window stuffing for long documents, noisy retrieval | Tune per query type: factual queries benefit from top-k = 3; summarization from top-k = 7–10 |
| **Flat single index** | Simple schema, single indexer | Poor security trimming granularity, re-index entire corpus on schema change | Split into per-tenant or per-classification indexes once security or schema requirements diverge |

---

## Chunking and ingestion

| Choice | Upside | Downside | When to flip |
|--------|--------|----------|--------------|
| **Fixed-size chunking (512 tokens)** | Simple, predictable token budget | Splits mid-sentence, misses document structure (headings, tables, lists) | Use **structural chunking** (paragraph / section aware) for formal documents (policies, legal, technical specs) |
| **Structural / semantic chunking** | Preserves document intent per chunk, better faithfulness scores | Complex pipeline (requires document parsing: Azure Document Intelligence), slower | Default for regulated enterprise content; fixed-size only for raw web content |
| **Full document ingestion (no chunking)** | No information loss | Exceeds context window for LLM, forces truncation, retrieval is impossible | Never for production RAG — always chunk |
| **ADF (Azure Data Factory) for ingestion** | Managed, scalable, connects to 90+ sources | Heavy for real-time needs, cost per activity run | Use for scheduled batch (SharePoint, Blob, SQL). Supplement with Event Grid / Azure Functions for near-real-time updates |
| **Full re-index vs delta crawl** | Full re-index: clean state | Full re-index: time-consuming, contends with query SUs | Delta crawl preferred; full re-index only on schema change or embedding model upgrade |

---

## Embedding and model selection

| Choice | Upside | Downside | When to flip |
|--------|--------|----------|--------------|
| **`text-embedding-3-large` (3072 dim)** | Highest accuracy, richest semantic space | Higher storage cost (3072 floats/chunk), slower indexing | Default for high-value enterprise corpus; compress with scalar quantization in AI Search to reduce storage |
| **`text-embedding-3-small` (1536 dim)** | 2× cheaper, faster, acceptable quality | 5–8% accuracy drop vs large on complex queries | Use for high-volume, lower-stakes retrieval or as a cache-warming model |
| **Versioned embedding model in config** | Easy model upgrade, no hardcoded dependency | Initial setup complexity | Mandatory — hardcoding an embedding model is a principal-bar red flag |
| **Single shared embedding model** | Simpler ops, consistent vector space across all BUs | BU cannot experiment independently; upgrade requires all BUs to re-index simultaneously | Acceptable for platforms <5 BUs; add per-BU model versioning once BUs have diverging needs |

---

## Caching

| Choice | Upside | Downside | When to flip |
|--------|--------|----------|--------------|
| **Semantic cache (Redis + embedding similarity)** | 30–60% AOAI token reduction for repeated queries, dramatic cost saving | Cache key design complexity, stale answer risk if source docs change | Enable for customer-facing RAG with query repetition; disable for unique analytical queries |
| **Cache at APIM (response cache)** | Simple, no Redis dependency | Only exact-match cache — misses paraphrased or slightly different queries | Use only as a supplement to semantic caching, not as the primary strategy |
| **No caching** | Zero stale risk, always fresh | Maximum AOAI cost, maximum latency | Acceptable for real-time, unique queries (e.g., per-user personalized analytics); wrong default for FAQ-style RAG |
| **TTL-based cache invalidation** | Simple to implement | Stale window proportional to TTL | Supplement with event-driven invalidation when source documents are updated |

---

## Authorization and data security

| Choice | Upside | Downside | When to flip |
|--------|--------|----------|--------------|
| **Pre-filter (OData filter before retrieval)** | Eliminates unauthorized chunks before semantic search — no leakage risk | Reduces effective search space, may miss relevant chunks in permitted scope | **Always use for multi-tenant RAG** — post-retrieval filtering is not safe |
| **Post-filter (filter after retrieval)** | Retrieves from full index, then filters | Leaks chunk metadata exposure before filtering, non-deterministic result count | Avoid for sensitive data — only acceptable if index contains non-sensitive content |
| **Document-level security (tenantId / groupId in index field)** | Coarse-grained, simple to implement | Cannot enforce page-level or paragraph-level access | Use document-level as baseline; add field-level if compliance requires paragraph-level control |
| **JWT claim injection at APIM (via policy)** | Enforced at platform layer — apps cannot bypass | Requires JWT issuer trust config in APIM | Mandatory at enterprise bar — never pass security context as application-layer parameter |

---

## Answer generation

| Choice | Upside | Downside | When to flip |
|--------|--------|----------|--------------|
| **GPT-4o** | Best reasoning, best faithfulness | Highest cost ($15/1M output tokens), highest latency | Use for complex multi-step reasoning or high-stakes answers (legal, compliance) |
| **GPT-4o-mini** | 15× cheaper, faster | Lower reasoning depth, some faithfulness drop on ambiguous context | Use for FAQ, summarization, low-stakes queries — evaluate first |
| **PTU (Provisioned Throughput)** for generation | Predictable latency, reserved capacity, cost-efficient at high load | Expensive if usage <70% PTU, requires capacity commitment | Flip from PAYG when P95 token throughput is consistently >65% of PAYG quota |
| **Streaming response** | Better UX for long answers | Harder to measure full latency, incremental risk if context cut short | Enable for user-facing chat; disable for batch/programmatic consumers |
| **Grounded system prompt (with `<context>` delimiters)** | Clear model instruction boundary, reduces hallucination | Verbose prompt increases token count | Always use — removing prompt grounding is a quality regression, not an optimization |

---

## Quick-recall: the five RAG decisions that always come up

1. **Hybrid vs pure vector** — always hybrid for enterprise; pure vector is a prototype smell.
2. **Security filter at APIM, not app** — pre-filter enforced at the platform layer, not application convention.
3. **Semantic cache first** — target 40%+ AOAI token reduction before any model tier change.
4. **Embedding model versioned in config** — upgrading the model requires full re-index; treat it like a DB migration.
5. **Evaluation harness before production** — RAGAS context precision and recall are SLOs, not nice-to-haves.
