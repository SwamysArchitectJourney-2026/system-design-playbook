# Solution Architect — Platform AI (Azure)

Interview track for **Platform AI Solution Architect**–style roles: **Azure-first** landing zones and patterns for **AI workloads**—not only a single app, but **how teams safely build** on **Azure OpenAI**, **Azure AI Search**, **Azure Machine Learning**, **Azure AI Foundry** (projects, models, governance hooks), optional **Databricks** for analytics/ML scale, plus **AKS**, **network identity security**, **IaC** (Terraform/Bicep), **GitOps**, and **compliance-as-code**.

## Calibrated for deep experience

For **very senior** candidates (e.g. **20+ years**), the pack stresses **enterprise judgment**, **trade-offs**, **governance maturity**, **AI platform standardization**, **AKS operations**, **Azure security**, and **IaC/GitOps rigor**—**not** basic service trivia.

**Principal-style evaluation:** Give them a **broken or risky enterprise** and ask them to **fix it on the whiteboard**—not “what does service X do?” The expanded scenarios live in **`01_templates/principal-enterprise-architect-interview-pack.md`**.

**Use whiteboards first.** See **`whiteboard-exercises-platform-ai.md`** (six general labs), **`principal-enterprise-architect-interview-pack.md`** (four strict enterprise scenarios + posture matrix), and **`troubleshooting-drills-platform-ai.md`**. **`staff-plus-interview-bar.md`** explains the bar; **`architect-evaluation-rubric-platform-ai.md`** supports mock debriefs.

## Drill order (suggested)

**Path A — breadth**

1. **Whiteboard** — pick **2** exercises from `whiteboard-exercises-platform-ai.md`.
2. **Troubleshooting** — **2** drills from `troubleshooting-drills-platform-ai.md`.
3. **Design pack** — `02_core_questions/design-azure-ai-platform-landing-zone/` (`answer.md` + `failures.md` + `followups.md`).
4. **Rubric** — `architect-evaluation-rubric-platform-ai.md`.

**Path B — principal / enterprise (tighter narrative)**

1. **Principal pack** — run **2–4** exercises from `principal-enterprise-architect-interview-pack.md` on the whiteboard (30–40 min each if deep).
2. **Troubleshooting** — **Drill 1** (SNAT) from `troubleshooting-drills-platform-ai.md` if not already covered.
3. **Posture matrix** — debrief using the **Architectural posture** section in the principal pack + rubric.

## How this differs from nearby folders

| Track | Emphasis |
|-------|----------|
| **`01_azure-solutions-architect-role-pattern/`** | Broad **Azure SA** interview system (web, events, multi-region, cross-domain). |
| **`09_solution-architect-platform-ai-azure/`** (here) | **Platform** for **AI** on Azure: boundaries, networking/identity, **Foundry + OpenAI + Search + AML**, **Databricks** when relevant, **IaC/GitOps**, **DevSecOps**. **Whiteboard + incident** drills and **principal pack** first-class. |
| **`07_gen-ai-lead-role-pattern/`** | **LLMOps / model lifecycle** org-wide; less subscription topology. |
| **`03_azure-engineering-lead-platform-pattern/`** | **Engineering lead** on platform (e.g. AKS/GitOps); this track adds **AI service** depth. |

Shared spine: `../interview-execution/`. Azure picks: `../01_azure-solutions-architect-role-pattern/01_templates/service-selection-guide.md`. Orientation: `../career-orientation/04_solution-architect-platform-ai-azure-compass.md`.

## Template index

| File | Role |
|------|------|
| `01_templates/staff-plus-interview-bar.md` | Staff/principal signal vs trivia |
| `01_templates/principal-enterprise-architect-interview-pack.md` | **Four** enterprise whiteboard scenarios + **posture** matrix |
| `01_templates/whiteboard-exercises-platform-ai.md` | Six timed whiteboard labs |
| `01_templates/troubleshooting-drills-platform-ai.md` | Eight ordered diagnosis drills |
| `01_templates/architect-evaluation-rubric-platform-ai.md` | Dimension rubric (1–4) + fail triggers |
| `01_templates/platform-ai-sa-spoken-spine.md` | Verbal checklist (after whiteboard) |
