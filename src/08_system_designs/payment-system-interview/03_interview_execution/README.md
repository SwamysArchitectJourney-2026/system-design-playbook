# Interview execution layer — payment system track

**Payment-specific copy** of the shared execution spine and grill. Use **this folder first** when prepping `payment-system-interview/` so examples and prompts stay in **money-path** context (idempotency, ledger, PCI, processors, reconciliation).

The **canonical generic** versions (any domain) remain in [`../../../09_interview-qna/interview-execution/`](../../../09_interview-qna/interview-execution/) if you need domain-neutral wording.

| File | Role |
|------|------|
| [01_golden-answer-template.md](01_golden-answer-template.md) | Narrative arc for **payment** design rounds (clarify → BOE → HLD → deep dives → failures → trade-offs → evolution) |
| [02_follow-up-grill-layer.md](02_follow-up-grill-layer.md) | Interviewer attacks **biased to correctness, money, and compliance** |
| [03_cross-domain-prompt-bank.md](03_cross-domain-prompt-bank.md) | Integration prompts touching **payments + fraud, data, platform, cloud** |

**Track modules:** `../01_clarifying-requirements-for-payment-systems.md` through `../04_follow-ups-and-grill-payment-system.md`, plus `../02_core_questions/design-payment-azure-e2e/`.
