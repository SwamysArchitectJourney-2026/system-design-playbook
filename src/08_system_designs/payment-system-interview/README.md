# Payment system — interview track

This folder is a **small course**: **foundation** modules at the **root** (`01`–`04` concepts, plus `05`–`06` mock debrief and opening drill), then one **end-to-end pack** under `02_core_questions/` that ties it together. A parallel **Azure-shaped** narrative lives in the broad Azure track (linked below)—use it when the interviewer wants subscription-level services (Front Door, APIM, Service Bus, SQL/Cosmos) spelled out.

---

## How to learn (order)

1. **Read `01` → `04` in order** — they build concepts: requirements → components/flow → idempotency/ledger/failures → follow-ups and grill. After a weak mock, read **`05`** (after-action / failure debrief) and rehearse **`06`** (first-five-minutes checklist) before the next attempt.
2. **Run the payment execution spine** — [`interview-execution/01_golden-answer-template.md`](interview-execution/01_golden-answer-template.md) then [`interview-execution/02_follow-up-grill-layer.md`](interview-execution/02_follow-up-grill-layer.md); optional prompts: [`interview-execution/03_cross-domain-prompt-bank.md`](interview-execution/03_cross-domain-prompt-bank.md). Index: [`interview-execution/README.md`](interview-execution/README.md). (Domain-neutral originals live in [`../../09_interview-qna/interview-execution/`](../../09_interview-qna/interview-execution/).)
3. **Open `01_templates/system-design-template.md`** — checklist wired to this folder’s `interview-execution/` copy.
4. **Run the executable pack** — read `02_core_questions/design-payment-azure-e2e/answer.md` out loud once, then walk `diagram.md`, `failures.md`, `tradeoffs.md`, `followups.md` in any depth the interview needs.
5. **Optional Azure depth** — if the loop is Azure SA-style, read the cross-domain pack (link below); paths inside `design-payment-azure-e2e/*.md` point there with **three** `../` segments from that subfolder (up to `09_interview-qna/`, then into `01_azure-solutions-architect-role-pattern/...`).

---

## Modular foundations (drill these first)

- [01 — Clarifying requirements](01_clarifying-requirements-for-payment-systems.md)
- [02 — Component model and data flow](02_component-model-and-data-flow.md)
- [03 — Idempotency, ledger, failure handling](03_idempotency-ledger-and-failure-handling.md)
- [04 — Follow-ups and grill](04_follow-ups-and-grill-payment-system.md)
- [05 — Mock round after-action (what to fix next session)](05_mock-round-after-action.md)
- [06 — First five minutes: clarifying checklist](06_first-five-minutes-clarifying-checklist.md)

## Executable pack (single narrative)

Entry point: [design-payment-azure-e2e — answer.md](02_core_questions/design-payment-azure-e2e/answer.md)

Same pack also includes: `diagram.md`, `failures.md`, `tradeoffs.md`, `followups.md`.

## Templates

- [01_templates/system-design-template.md](01_templates/system-design-template.md)

## Azure-specific cross-reference

Parallel payment narrative in the Azure SA track: [payment-processing-on-azure — answer.md](../../09_interview-qna/01_azure-solutions-architect-role-pattern/04_cross_domain/payment-processing-on-azure/answer.md) (same file set: diagram, failures, tradeoffs, followups).
