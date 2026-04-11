---
learning_level: "Advanced"
estimated_time: "40 minutes"
topic: "B2B APIs with Azure API Management and .NET"
---

# Design B2B partner APIs on Azure (.NET)

## Clarify

- Partners vs internal; **OAuth2 client credentials**; **per-partner** rate limits and SLAs; **webhooks** outbound?

## Estimate

- Partner count, RPS per partner, payload sizes, webhook fan-out.

## Architecture

- **APIM** external tier: **products** per partner, **subscription keys** or **JWT** validation, **policies** (rate limit, IP allowlist, request size).
- **.NET APIs** on App Service or AKS behind APIM; **Entra ID B2B** or custom client registry in SQL.
- **Service Bus** for async partner notifications; **idempotency** on inbound POST callbacks.
- **SQL** for contracts, entitlements, audit; **Redis** optional for token metadata cache.

## Deep dives

- **Policy** composition in APIM vs code in ASP.NET filters—separation of concerns.
- **Webhook signing** (HMAC) and replay protection.
- **Versioning** `/v1` vs header; deprecation policy.

## Failures

- APIM throttling—**429** with **Retry-After**; circuit break to backend; dead letter for undeliverable webhooks.

## Evolution

- MVP: single .NET API + APIM + SQL.
- Scale: shard partner traffic, dedicated deployment stamps for noisy neighbors, event-driven webhooks at scale.

See `diagram.md`, `tradeoffs.md`, `followups.md`.
