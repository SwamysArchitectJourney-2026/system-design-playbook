# Architect-level evaluation rubric — Platform AI (Azure)

Use for **mock debrief** or **hiring calibration**. Scale **1–4** per dimension (1 = junior gap, 4 = staff/principal signal). **Pass** for senior SA typically **≥3** on most rows; **staff+** needs **4** on **judgment**, **governance**, and **one** of **AKS** / **security** / **IaC** depth.

## Dimensions

### 1. Enterprise architecture judgment

- **4:** Clear **failure domains**, **phased** landing, **explicit** global and **residency** story; names **what not** to build in v1.
- **3:** Coherent landing zone; some **evolution** gaps.
- **2:** Valid boxes; **weak** sequencing and **blast radius** analysis.
- **1:** Service catalog **recital** without **system** story.

### 2. Trade-off reasoning

- **4:** **Chosen vs rejected** with **measurable** triggers to flip (cost, latency, risk); **no** false “only one way.”
- **3:** Identifies **main** trade-offs; shallow **when to flip**.
- **2:** Generic pros/cons.
- **1:** “Best practice” **without** context.

### 3. Governance maturity

- **4:** **Policy**, **exceptions**, **audit**, **chargeback**, **shadow** mitigation; **who** owns **standards**.
- **3:** Mentions Policy and RBAC; **thin** exception process.
- **2:** “We lock everything down” or **too** loose.
- **1:** Governance **absent** or **purely** tool names.

### 4. AI platform standardization

- **4:** **Self-service** with **guardrails**; **model** / **project** boundaries; **observability** and **cost** per consumer.
- **3:** Central vs federated **clear** but **operational** gaps.
- **2:** **One** shared key **anti-pattern** unchallenged.
- **1:** Treats AI as **single** app team problem.

### 5. AKS operational depth

- **4:** **Upgrades**, **node pools**, **network policy**, **identity** to Azure, **ingress**, **egress**; **incident** patterns.
- **3:** Solid **basics**; **weak** on **upgrade** or **DNS** edge cases.
- **2:** **Kubernetes** buzzwords only.
- **1:** Cannot **trace** a request **pod → Azure**.

### 6. Azure security patterns

- **4:** **Private Link** + **identity** + **segmentation** + **supply chain**; **break-glass**; **Defender** hooks.
- **3:** **PE** and **MI**; **gaps** on **keys** or **exfiltration**.
- **2:** **Checklist** without **threat** model.
- **1:** **Misunderstands** trust boundaries.

### 7. CI/CD + IaC rigor

- **4:** **Module** lifecycle, **env** promotion, **state** security, **drift**, **approval** gates, **policy-as-code** in **pipeline**.
- **3:** Terraform/Bicep **present**; **weak** **SoD** or **rollback**.
- **2:** “We have pipelines.”
- **1:** **ClickOps** admitted as **prod** norm.

### 8. Stakeholder / roadmap translation

- **4:** **Outcomes** → **phased** capabilities + **risks**; **handles** pushback with **options**.
- **3:** **Reasonable** roadmap; **thin** on **risk** communication.
- **2:** **Technical** only.
- **1:** **Dismissive** of constraints.

## Composite signals

- **Staff+ strong:** **Whiteboard** exercises **complete** with **failure** and **evolution**; troubleshooting **ordered** and **measurable**.
- **Concern:** Great **trivia**, **empty** under **“what breaks first?”** or **incident** stress.

## Architectural posture (principal / enterprise)

Use when calibrating **true senior leadership**—beyond checkbox technical facts. Full scripted scenarios: **`principal-enterprise-architect-interview-pack.md`** (overall matrix at end of that file). **Interviewer-facing** lenses and scenario bank: **`senior-ai-platform-architect-interviewer-guide.md`**.

1. **Business value default** — Do they **right-size** (e.g. simpler hosting until scale forces complexity) or lead with **fashion**?
2. **“I” vs “we”** — **Heroics** vs **standards**, **enablement**, and **platform** adoption across teams.
3. **Friction handling** — Under whiteboard challenge, **defensive** doubling-down vs **structured pivot** (“if cost drives, we can move to …”).

## Quick fail triggers

- Cannot draw **DNS + Private Link** path for **AI**.
- **No** **rollback** or **feature-flag** story for **model** change.
- **Owner** on **all** subscriptions for “velocity.”
