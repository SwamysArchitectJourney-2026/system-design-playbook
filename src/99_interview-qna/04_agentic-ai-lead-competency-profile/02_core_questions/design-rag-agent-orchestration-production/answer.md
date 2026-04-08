---
learning_level: "Advanced"
estimated_time: "45 minutes"
topic: "Production RAG + agent orchestration"
---

# Design production RAG with agent orchestration

## Clarify

- Domains (support, internal knowledge, actions on systems); **SLA** latency; **tools** (SQL, tickets, payments?); **compliance**.

## Estimate

- Queries/day, tokens in/out, embedding QPS, index size, tool call rate.

## Architecture

- **Gateway** with auth and **per-tenant** quotas; **orchestrator** service (Python/Node) running **LangGraph** or equivalent state machine.
- **Retrieval:** vector DB (**OpenSearch / Pinecone / pgvector**) + optional **BM25** hybrid; ingestion pipeline with chunking + embeddings (**batch + incremental**).
- **Model:** hosted LLM API with **routing** (small model for triage, large for reasoning).
- **Tools:** MCP servers or internal APIs with **scoped** credentials; **allow-list**; **audit log** of tool inputs/outputs (redacted).
- **Memory:** thread state in Redis; long-term memory with **summarization** + vector retrieval with **ACL** filters.

## Deep dives

- **Citation** requirement for enterprise answers.
- **Evaluation** offline (golden sets) + online (thumbs, task success rate).
- **Caching** semantic cache with **care** for stale policy answers.

## Failures

- Tool timeout—partial answer vs escalate; model **429**—queue or fallback model; index lag—**version** tags on answers.

## Evolution

- MVP: single agent + RAG + 2 tools.
- Scale: multi-agent handoff, batch inference for embeddings, dedicated model capacity.

See `diagram.md`, `tradeoffs.md`, `followups.md`.
