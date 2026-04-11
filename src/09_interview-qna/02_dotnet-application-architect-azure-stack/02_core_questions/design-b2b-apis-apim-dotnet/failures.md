# Failure scenarios: B2B APIs with APIM and .NET

- **APIM throttling / 429** under partner burst — need **per-partner quotas** and **backpressure** contract.
- **Certificate or OAuth token** expiry — silent partner outages; **rotation** runbooks and **monitoring**.
- **Backend .NET pool exhaustion** — thread pool / Kestrel queue; **bulkhead** per partner where needed.
- **Idempotent webhook** delivery failures — partner retries; **dedupe** on message id.
- **Schema drift** on published API — versioned routes; **deprecation** policy; contract tests.
- **Regional APIM** misconfiguration — routing to **drained** backend; health probes must hit **deep** checks.
