# Failure scenarios: AI on Azure

- **Model 429 / quota** → Backoff; queue async response; route to smaller model.
- **Retrieval index stale** → Version answers; TTL refresh jobs; show “as of” date.
- **Prompt injection via RAG** → Sanitize chunks; trust boundaries on tools; human approval for risky tools.
- **PII in logs** → Redaction pipeline; sampling policies.
- **Cost runaway** → Per-tenant token budget; kill switch; cache semantically safe queries.
