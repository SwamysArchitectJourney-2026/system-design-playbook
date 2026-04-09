# Spoken spine — Gen AI lead rounds

Use as a **checklist** under interruption. Pair with `../02_core_questions/design-llmops-model-lifecycle-governance/`.

## Open (60–90 seconds)

- Restate the product: who consumes models, regulated or not, latency and cost sensitivity.
- Say you will cover **lifecycle** (data → train/adapt → evaluate → deploy → monitor), then **governance**, then **scale and cost**.

## Lifecycle story

- **Artifacts:** datasets, prompts, adapters/checkpoints, eval reports—**versioned** and traceable.
- **When to fine-tune / adapt vs RAG-only:** domain drift, privacy of data in context, cost of retraining vs index ops.
- **Gates:** no promotion without **offline** metrics + **shadow** or **canary** online checks.

## Governance and safety

- **Policy:** PII, toxicity, jailbreak handling; **human** review for high-risk actions.
- **Audit:** who approved which model version for which use case; **immutable** logs for regulated flows.

## Operations

- **SLOs:** latency, error rate, cost per request, **quality** proxies (eval regression).
- **What breaks first:** GPU quota, batch backlog, eval pipeline, or monitoring blind spots—name one for *their* scenario.

## Close

- One line **ROI** (quality, cost, time-to-ship) and one **risk** you still watch.
