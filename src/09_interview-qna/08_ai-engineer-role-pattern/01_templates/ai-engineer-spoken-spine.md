# Spoken spine — AI engineer (IC) rounds

Use when the prompt is **“design this AI feature”** or **“how would you build X with an LLM?”** — not full platform. Pair with `../02_core_questions/design-shipping-llm-backed-feature/`.

## Open

- **User job-to-be-done** and **success metric** (task completion, latency, cost per task).
- **Non-goals** for v1 (e.g. no fine-tune until RAG + prompts exhausted).

## Scope box

- **Your service owns:** API contract, orchestration call order, retrieval (if any), prompt assembly, post-processing, persistence rules.
- **You depend on:** model provider, auth, maybe search index owned by another team—state **interfaces**, not their internals.

## Happy path (30 seconds)

- Request in → validate → retrieve (optional) → model call(s) → structured or text out → audit log / analytics event.

## Failure and degradation

- **Timeouts**, **rate limits**, **empty retrieval**—user-visible behavior and **retries** (idempotent where needed).
- **When not to call the model**—cheap guards, cache, canned responses.

## Quality and safety (proportionate)

- **Golden tests** or eval set size you can maintain; **red-team** basics for PII/toxic prompts if user-facing.
- **No** claiming “we solved hallucinations”—mitigations + disclosure.

## Close

- What you **instrument** day one: latency, token usage, error class, task success proxy.
