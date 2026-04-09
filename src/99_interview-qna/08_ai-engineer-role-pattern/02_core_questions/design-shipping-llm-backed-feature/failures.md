# Failure scenarios: LLM-backed feature

- **Retriever returns nothing** — fallback copy, “I don’t know,” or block action; never fabricate citations.
- **Model timeout mid-stream** — user sees partial output + **recoverable** state or clean error.
- **429 from provider** — backoff, queue, or **graceful** degrade; avoid **retry storm** from all replicas.
- **Schema validation fail** — bounded retries with **shorter** instruction; else surface error to client.
- **Deploy + prompt change** — **eval regression** in CI missed edge case; feature flag or **rollback** prompt version.
- **Logging mistake** — secrets in logs; **redact** and **alert** on patterns.
