---
learning_level: "Advanced"
estimated_time: "45 minutes"
topic: "Enterprise MCP tool gateway"
---

# Design an enterprise MCP tool gateway (SDLC-aware)

## Clarify

- Internal vs external tools; **Entra ID** groups mapping to tool sets; **audit** requirements; **SLA** for tool latency.

## Estimate

- Concurrent sessions, tool calls per session, payload sizes.

## Architecture

- **MCP gateway** service: **discovers** tools from registered MCP servers; enforces **OAuth/OIDC** user context; **scopes** per tool; **rate limits**.
- **Registry:** catalog of tools with **owner team**, **risk tier**, **data classification**; **approval workflow** before production enablement.
- **Execution:** sandboxed calls to backends (APIs, databases) with **short-lived** tokens; **policy engine** (OPA) for args validation.
- **Observability:** structured logs + traces; **token** and **tool** metrics; **PII** redaction pipeline.
- **SDLC:** Git-based registration YAML; **CI** runs contract tests; **staging** MCP environment; **promotion** to prod registry.

## Deep dives

- **SSRF** prevention when tools hit URLs.
- **Argument** schema validation vs free-form JSON from model.
- **Idempotency** for tools with side effects.

## Failures

- Tool outage—degrade model behavior; **circuit breaker** per tool; user-visible **retry** guidance.

## Evolution

- MVP: few tools, manual registration.
- Scale: self-service onboarding with automated security review checklist.

See companion files.
