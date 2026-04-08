---
learning_level: "Advanced"
estimated_time: "40 minutes"
topic: "LLM serving with observability and cost controls"
---

# Design LLM serving for production (multi-tenant)

## Clarify

Models hosted vs API; **P99 latency**; **throughput**; **tenants**; **compliance** (no training on customer data).

## Estimate

Tokens/sec, concurrent requests, cache hit rate if using semantic cache.

## Architecture

- **Gateway** with auth, **quota**, **routing** (small vs large model).
- **Inference** workers on **AKS** with GPU node pools or **managed API** with **PTU**/capacity planning.
- **Queue** for async jobs; **streaming** responses via SSE/WebSocket.
- **Cache** (Redis) for repeated prompts where safe; **prompt** and **model version** in logs (hashed where needed).
- **Metrics:** tokens in/out, latency histograms, **$/request**, error taxonomy (429, timeout, validation).

## Deep dives

- **Autoscale** on queue depth and GPU utilization; **pre-warm** pools for predictable peaks.
- **Evaluation** pipeline blocking bad prompt/template releases.

## Failures

- **429** storm—backpressure to clients; priority lanes for premium tenants if product requires.

## Evolution

- Start single region + one model; add **routing**, **LoRA** adapters per tenant, **multi-region** read-only inference.

See `diagram.md`, `tradeoffs.md`, `followups.md`.
