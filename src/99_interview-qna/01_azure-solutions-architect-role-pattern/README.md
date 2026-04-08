# Azure Solutions Architect — interview track

This folder is a **high-pressure execution system**: **one folder = one interview question** you can defend under interruption.

## Atomic question packs

Each design folder contains:

```text
answer.md       # Spine — starts with "## Based on Template v1.1"
diagram.md      # Mermaid + numbered narration
failures.md     # Failure-first expansion (required)
tradeoffs.md
followups.md    # Categorized attacks (see followup-attack-bank)
```

Locations: `02_core_questions/*`, `03_azure_specific/*`, `04_cross_domain/*`.

## Template layer (`01_templates/`)

| File | Role |
|------|------|
| `answer-format-enforcement.md` | **Template v1.1** — heading contract, required files (incl. what breaks first, security/cost split) |
| `system-design-template.md` | Azure-flavored spine + links |
| `service-selection-guide.md` | **Canonical** EH vs SB vs Queue, Cosmos vs SQL, AKS vs App Service vs Functions |
| `failure-scenario-catalog.md` | Long catalog of failure modes |
| `followup-attack-bank.md` | Categorized grill questions |
| `tradeoffs-cheatsheet.md` | Pattern table |
| `followups-cheatsheet.md` | Azure interview checklist |

## Quick reference (track root)

| File | Role |
|------|------|
| `07_interview-decision-cheatsheet.md` | Four-line justification rule |
| `08_azure-service-selection-guide.md` | Redirect → `01_templates/service-selection-guide.md` |
| `09_interview-failure-playbook.md` | **If X then Y** instant recall |

## How to practice

1. Read `01_templates/answer-format-enforcement.md` once.
2. Pick `02_core_questions/design-global-web-app-on-azure/answer.md` and speak it cold.
3. Drill `failures.md` + `followups.md` for that folder.

Shared grill: `../interview-execution/`.

## One-page competency map

- [01_azure-solutions-architect-role-pattern.md](01_azure-solutions-architect-role-pattern.md)
