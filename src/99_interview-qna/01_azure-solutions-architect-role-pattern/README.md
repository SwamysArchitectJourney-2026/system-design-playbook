# Azure Solutions Architect — interview track

This folder is a **high-pressure execution system**, not a topic browser: **one folder = one interview question** you can defend under interruption.

## Atomic question units (mandatory mental model)

Interviewers ask concrete prompts (“Design a globally distributed API on Azure”), not “discuss Azure patterns.”

Each **atomic question** lives here:

```text
02_core_questions/<question-slug>/
├── answer.md      # Spoken spine — MUST follow heading contract below
├── diagram.md
├── tradeoffs.md   # Expansion; must not contradict answer.md
└── followups.md   # Interviewer attack layer
```

**Examples:** `design-global-web-app-on-azure/`, `design-event-driven-architecture-on-azure/`, `design-multi-region-api-azure/`.

Azure-only compositions and cross-domain scenarios: `03_azure_specific/`, `04_cross_domain/` (same four-file shape).

## Format enforcement (L6 signal)

1. **`01_templates/answer-format-enforcement.md`** — required `## 1.` … `## 8.` headings and minimum **decision / failure / trade-off** content in every `answer.md`.
2. **`07_interview-decision-cheatsheet.md`** — four-line justification for every major choice (*choose / because / vs / breaks when*).
3. **`08_azure-service-selection-guide.md`** — **when** Event Hubs vs Service Bus vs Queue, Cosmos vs SQL, AKS vs App Service vs Functions—not a flat product list.

**Repo rule:** do not use a `00_` prefix; templates stay under `01_templates/`.

## Other paths

| Path | Purpose |
|------|---------|
| `01_templates/` | Spine, trade-off patterns, follow-up checklist, **answer format contract** |
| `03_azure_specific/` | Serverless, data platform, etc. |
| `04_cross_domain/` | AI on Azure, payments on Azure |

## How to practice

1. Read `01_templates/answer-format-enforcement.md` once.
2. Pick one `02_core_questions/*/answer.md` and **speak it out loud** without reading.
3. Drill `followups.md` until each answer is under two minutes cold.

Shared grill: `../interview-execution/`.

## One-page competency map

- [01_azure-solutions-architect-role-pattern.md](01_azure-solutions-architect-role-pattern.md) (posting-to-themes summary—not a substitute for question packs)
