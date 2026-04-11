---
learning_level: "Intermediate"
estimated_time: "35 minutes"
topic: "Shipping one LLM-backed product feature (IC scope)"
---

# Design shipping one LLM-backed product feature

Interview narrative for an **AI engineer** owning a **single** user-facing capability (e.g. “smart summary,” “support reply assist,” “internal Q&A over one corpus”).

## Clarify

- **Input/output:** free text vs structured; max length; streaming or not.
- **Grounding:** must answers cite sources / stay in corpus, or generative OK?
- **Latency and cost** budget per request; **PII** and data retention.
- **Failure UX:** silent degrade, explicit error, or human handoff?

## Estimate

- Requests/day, **p95** target, tokens in/out, **retrieval** QPS if RAG; storage for logs and optional cache.

## Architecture (feature-sized)

- **BFF or API** your team owns: authn/z, **validation**, rate limit per user.
- **Orchestration** (library or small service): build prompt from template + user input + optional **retrieved chunks**; call **model API** with timeouts; **parse** JSON or enforce output schema (tooling or constrained decoding if interviewer cares).
- **Retrieval (if RAG):** embed query → vector search over **scoped** index; **filter** by tenant/ACL; **top-K** + optional rerank.
- **Persistence:** minimal—**request id**, hashes of inputs (not raw if sensitive), model version, latency, token counts; **no** long chat history unless required.
- **Async path (optional):** queue for long jobs; **webhook** or poll for completion.

## Deep dives (pick 2)

- **Schema / structured output** vs free text—validation and repair loop.
- **Caching:** semantic or exact; **TTL** and staleness for policy-sensitive answers.
- **Evaluation:** 20–50 **golden** cases in CI or nightly; **regression** when prompt or model version changes.

## What breaks first?

1. **Model API** rate limits or latency spikes.
2. **No retrieval** or wrong tenant filter—**wrong or empty** context.
3. **Prompt bloat**—context window overflow or cost blow-up.
4. **Missing observability**—cannot tell if quality dropped after a deploy.
5. **Synchronous** design—thread pool exhaustion under slow LLM.

## Evolution

- **MVP:** single model, optional simple RAG, basic metrics.
- **Next:** routing to cheaper model for easy cases, better eval, cache.
- **Not automatic:** full **platform** LLMOps—that is `../07_gen-ai-lead-role-pattern/`.

See `diagram.md`, `tradeoffs.md`, `followups.md`, `failures.md`.
