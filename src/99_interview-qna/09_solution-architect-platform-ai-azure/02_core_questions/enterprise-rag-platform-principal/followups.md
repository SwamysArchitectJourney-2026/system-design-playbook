# Follow-up questions — Enterprise RAG platform (principal)

Attack questions grouped by category. Use these to stress-test a candidate who nailed the baseline architecture.

---

## Category 1: Retrieval quality

| Question | What strong looks like |
|----------|------------------------|
| "How do you evaluate retrieval quality — not just answer quality?" | RAGAS metrics: context precision, context recall, faithfulness. Separate eval from generation eval. Golden Q&A dataset. |
| "The top-k=5 chunks returned are semantically relevant but the LLM still hallucinates. What's happening?" | Context window stuffing (chunks are noisy or too long), low faithfulness score. Solution: reranker (Cohere, Azure AI Search semantic ranker) before LLM. |
| "Why would hybrid retrieval (vector + keyword BM25) outperform pure vector search for enterprise documents?" | Exact entity match (product IDs, legal terms, codes) fails in embedding space. BM25 keyword search handles exact-match better. Hybrid with RRF fusion gives best of both. |
| "How do you handle multi-hop queries that require reasoning over two documents to produce an answer?" | Step-back prompting, multi-step retrieval (retrieve-then-refine), or graph-based RAG for entity relationships. Acknowledge that flat RAG fails for multi-hop. |

---

## Category 2: Security and authorization

| Question | What strong looks like |
|----------|------------------------|
| "A user's security group changed. How quickly does that propagate to which documents they can retrieve?" | Depends on security trimming model: if groups are in JWT, it's real-time. If groups are a cached lookup in AI Search filter fields, it's only as fresh as the indexer run / cache TTL. Be explicit about the lag. |
| "Can you prove that a specific user never retrieved a document they shouldn't have?" | Log Analytics: APIM access log with JWT sub, AI Search index log with filter applied, document chunk IDs returned. Tie these together with a correlation ID. |
| "We require data never leaves EU. Walk me through every point where a token or chunk could cross a region boundary." | APIM → AOAI: both in EU. AI Search: single region. Redis: in EU. Log Analytics workspace: region-pinned. ADF: control plane vs data plane distinction — control plane global, data plane EU. |
| "How do you prevent a prompt injection attack via a document the user uploaded themselves?" | Content Safety scan on upload, sandbox the user-supplied document in a separate index with stricter filtering, never mix user-uploaded with enterprise knowledge index. |

---

## Category 3: Scale and cost

| Question | What strong looks like |
|----------|------------------------|
| "Token costs tripled after launch. What's your triage checklist?" | 1. Unbounded context window (chunks too long). 2. No semantic cache (same questions re-hitting AOAI). 3. Wrong model tier (GPT-4o for queries that GPT-4o-mini handles). 4. Re-embedding on every query (should be query-only embedding). |
| "The CFO asks for per-BU AI cost attribution. How do you deliver it?" | APIM logs JWT `tid` or BU claim → Log Analytics → KQL join with AOAI token usage → Power BI / Cost Management summary. No custom billing code needed. |
| "At what point do you flip from PAYG OpenAI to PTU?" | When sustained utilization consistently >65–70% of PAYG quota. PTU breaks even around that threshold. Also consider for latency predictability (PTU gives lower jitter). |
| "Your AI Search index is 500GB. Storage costs are spiking. What levers do you use?" | Delete obsolete document versions (maintain only latest). Reduce vector dimensions (3072 → 1536 with `text-embedding-3-small`). Use compression profiles (scalar quantization in AI Search). Archive cold documents to storage tier. |

---

## Category 4: Reliability and change management

| Question | What strong looks like |
|----------|------------------------|
| "LLM model is deprecated by OpenAI on 90 days' notice. What's your remediation plan?" | Model version catalog in config, not hardcoded. APIM routes to model alias (e.g., `gpt4-current`) that Ops updates. Blue/green deploy: test new model against eval harness before traffic cut. |
| "Explain your zero-downtime index rebuild strategy." | Index aliases: build new index (`idx-v2`) in parallel, run eval, flip the alias (`alias → idx-v2`), decommission old. AI Search alias support is GA as of 2024. |
| "The semantic ranker changed behavior after an Azure service update — your eval scores dropped. How do you catch this?" | Scheduled regression run against golden Q&A set. Monitor `context_precision` and `faithfulness` as SLOs in monitoring. Alert on >5-point degradation. |
| "How do you do canary deployment for a new prompt template?" | Feature flag or APIM routing by header/user segment to new prompt template. Compare RAGAS metrics between cohorts. Roll forward or back based on eval result, not intuition. |

---

## Category 5: Governance and platform maturity

| Question | What strong looks like |
|----------|------------------------|
| "A BU wants to use their own embedding model, not the platform standard. How do you handle it?" | Platform API contract stays stable (input/output). BU can register a custom embedding endpoint behind the APIM AI façade, subject to security review. Index is isolated per BU. Governance: SBOM, model card, eval pass required before onboarding. |
| "How do you enforce that no PII enters the AI Search index?" | Content pipeline: Azure AI Language PII detection on chunks before indexing. Redact or reject. Audit log of all redaction events. Policy: no unredacted chunks written to the production index. |
| "Five teams now want their own RAG platform. How do you template the provisioning?" | IaC template (Terraform module or Bicep) for: AOAI deployment, AI Search service, APIM product, managed identity with RBAC, Log Analytics workspace link. Self-service onboarding via ADO pipeline or GitHub Actions with required review. |
| "The legal team wants a record of which documents influenced every AI response for e-discovery purposes." | Log the retrieved chunk IDs (and their source document hash/version) alongside the APIM request correlation ID and user identity in Log Analytics. Immutable storage (Azure Storage with WORM policy) for e-discovery retention. |

---

## Category 6: Stakeholder and trade-off framing

| Question | What strong looks like |
|----------|------------------------|
| "CTO says: 'Just use OpenAI's hosted retrieval. Why are we building this?'" | Enterprise RAG is about document security trimming, data residency, chargeback, index freshness, and model lifecycle governance — none of which hosted retrieval provides. The platform is the governance wrapper, not the retrieval algorithm. |
| "A team says RAG is too slow (>3s P95). What do you trade off to hit <1s?" | 1. Aggressive semantic cache (95% of repeated queries). 2. Reduce top-k (5→3). 3. Disable semantic ranker for low-sensitivity queries (fast lexical only). 4. GPT-4o-mini instead of GPT-4o. Each has a quality cost — document it. |
| "Six months in, business stakeholders say the AI 'doesn't know about X'. What's your structured response?" | Retrieval quality investigation: Is X in the index? Is X chunked and embedded correctly? Is X returned in top-k? Does the LLM use it faithfully? Instrument each step — don't guess. |
