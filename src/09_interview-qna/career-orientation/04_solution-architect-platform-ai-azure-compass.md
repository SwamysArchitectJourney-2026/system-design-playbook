---
learning_level: "Advanced"
prerequisites: ["Azure fundamentals", "Basic GenAI service vocabulary"]
estimated_time: "14 minutes"
learning_objectives:
  - "Map Platform AI Solution Architect expectations to Azure platform + AI services"
  - "Prioritize landing zone, AI PaaS, data/analytics mesh, and IaC/GitOps in answers"
---

# Solution Architect — Platform AI (Azure): competency compass

This bar blends **cloud/platform architecture** with **Azure’s AI stack**: you are credible on **subscriptions, networking, identity, security**, and on **Azure OpenAI**, **Azure AI Search**, **Azure Machine Learning**, **Azure AI Foundry**, plus often **Databricks** for lakehouse/ML scale. **Python** literacy matters for credibility with engineering; **Terraform/Bicep**, **CI/CD**, **GitOps**, **DevSecOps**, and **compliance-as-code** show you can **land** designs, not only whiteboard them.

## What to prove in interview

- **Landing zone thinking** — management groups, hub/spoke or CAF-aligned patterns, **policy** and **cost** guardrails.
- **AI service boundaries** — who owns **models**, **indexes**, **keys**, **quotas**; **private** vs public access paths.
- **Data gravity** — how **training** and **RAG** data move between **storage**, **AML**, **Databricks**, and **Search** without **compliance** violations.
- **Delivery** — **IaC** modules, **GitOps** for **AKS**, **pipelines** with **security** gates.
- **Stakeholders** — translate **business** outcomes into a **phased** technical roadmap with **risks** named.

## Anti-patterns

- **Generic AI** slides with no **Azure** service names or **network** reality.
- **Only** prompt engineering with no **platform**, **identity**, or **cost** story.
- Ignoring **Foundry** / **project** boundaries when the role expects **governance** depth.

## Where to drill

- **Executable pack:** `../09_solution-architect-platform-ai-azure/README.md` — **`principal-enterprise-architect-interview-pack.md`** for principal-style **broken enterprise** whiteboards; plus **`whiteboard-exercises-platform-ai.md`**, **`troubleshooting-drills-platform-ai.md`**, **`architect-evaluation-rubric-platform-ai.md`**.
- **Broader Azure SA:** `../01_azure-solutions-architect-role-pattern/README.md`
- **AKS / GitOps lead angle:** `../03_azure-engineering-lead-platform-pattern/README.md`
