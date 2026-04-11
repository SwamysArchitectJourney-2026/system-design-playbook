# System design walkthrough — template

Copy this folder to `../<your-design-name>/` (use a clear slug, e.g. `01_notification-service-interview`).

## Required artifacts

| File | Purpose |
|------|---------|
| [`01_requirements.md`](01_requirements.md) | Functional + non-functional clarifications, assumptions, BOE sketch |
| [`02_high-level-design.md`](02_high-level-design.md) | Components, data flow, sync vs async boundaries |
| [`03_trade-offs.md`](03_trade-offs.md) | Alternatives considered and why you chose this shape |
| [`04_failure-scenarios.md`](04_failure-scenarios.md) | What breaks, detection, mitigation, user-visible behavior |
| `diagrams/` | C4-style or sequence flows (see [`diagrams/README.md`](diagrams/README.md)) |

## Optional

- Deeper LLD in extra files (`05_low-level-design.md`, …) if the design outgrows one file — keep each file ≤1000 lines per repo convention.

## Interview loop

Rehearse in order: requirements (out loud) → boxes on the board → one happy path → one failure path → trade-off drill. Cross-check with `src/09_interview-qna/interview-execution/`.
