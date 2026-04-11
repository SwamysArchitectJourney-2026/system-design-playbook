# Failure scenarios: MCP gateway in enterprise SDLC

- **Unauthorized tool registration** — arbitrary **MCP servers** exfiltrating data; **allow-list** + **attestation**.
- **Token / secret leakage** through tool arguments — **redact** logs; **short-lived** credentials.
- **Gateway overload** — fan-out to many MCP backends; **bulkhead** and **per-team** quotas.
- **Schema / capability drift** — clients break; **versioned** tool manifests and **contract** tests.
- **Audit blind spot** — who invoked which tool on which data; **immutable** audit stream required for regulated workloads.
- **Dependency on external MCP** host — **outage** maps to product outage; **cache** read-only metadata, **degrade** gracefully.
