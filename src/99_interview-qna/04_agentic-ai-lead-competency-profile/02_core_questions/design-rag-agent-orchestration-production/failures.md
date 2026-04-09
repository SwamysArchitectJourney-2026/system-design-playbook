# Failure scenarios: production RAG + agent orchestration

- **Retriever returns toxic / wrong chunks** — bad answers; **rerank**, **metadata filters**, **human** escalation path.
- **Tool call loops or runaway** — cost and latency; **max steps**, **timeouts**, **budget** per session.
- **Vector index stale** after doc update — user trust loss; **version** tags and **refresh** SLA.
- **Model rate limits** — degraded UX; **queue** long tasks, **smaller model** fallback.
- **Prompt injection** via retrieved text — **sandbox** tools, **output** policy, **no** silent exfil.
- **Evaluation gap** — shipping prompt change without **regression** suite → production incidents.
