---
learning_level: "Advanced"
estimated_time: "40 minutes"
topic: "Zero-trust B2B integration fabric"
---

# Design a zero-trust B2B integration layer

## Clarify

Partners, protocols (REST, SFTP, EDI), **non-repudiation**, **latency**, **on-prem** legacy endpoints.

## Architecture

- **API gateway** with **mTLS** or **OAuth client credentials**; **WAF**; **IP allowlists** where still required.
- **Service mesh** or **API management** policies for internal east-west if traffic is large.
- **Event backbone** (Kafka/Service Bus) for decoupled flows; **schema registry**.
- **Secrets** in vault; **short-lived** certs; **break-glass** access audited.

## Deep dives

- **Contract testing** between teams; **versioning** and **deprecation** policy.
- **Idempotency** on partner callbacks.

## Failures

- Partner outage—**queue** and replay; **DLQ** with alerting; **manual** reconciliation playbooks.

## Evolution

- MVP: single gateway + a few golden integrations; scale: **self-service** partner onboarding with automated security checks.

See companion files.
