
# 02 Architect Prep QA Part 4

How would you like to proceed?

Here is **Batch 3: Questions 61 to 90**.

For this batch, we are blending high-stakes **Behavioral/Leadership** scenarios with advanced **System Design & Strategy**. At this level, interviewers assume you have the technical chops; they are testing your emotional intelligence, your ability to influence executives, and how you handle crises.

---

### **Part 1: Gen AI Lead (Leadership, Crisis Management, & Advanced Strategy)**

**61. Q: A business executive approaches you with an idea to build a "GenAI System" to count weekly sales, which you know could be solved with a simple SQL `GROUP BY` query. How do you handle this?**

* **Focus:** Managing AI Hype & Business Consulting.
* **A:** I never shoot down the enthusiasm. I validate their goal (e.g., "Getting faster sales insights is critical"). Then, I pivot the conversation to reliability and cost. I explain that LLMs are probabilistic—they guess the next word, meaning they can hallucinate math. I advise that we use traditional, deterministic BI tools for the *counting*, but we can use an LLM to generate the SQL query or write a natural language summary of the final report. You use AI to enhance the workflow, not to do basic arithmetic.

**62. Q: Your production GenAI customer support bot just confidently gave a user the wrong refund policy, costing the company money. Walk me through your immediate and long-term response.**

* **Focus:** Incident Response & Guardrails.
* **A:** **Immediately:** I trigger the kill switch or feature flag for the bot, routing all traffic to human agents. We honor the refund to protect brand trust.
**Long-term:** We conduct a root-cause analysis. Did the RAG pipeline pull an outdated PDF? Did the model hallucinate despite correct context? To fix it, I implement an "Output Guardrail" using a fast, deterministic rules engine or a secondary LLM strictly tasked with verifying that any refund amount mentioned in the output matches the explicitly retrieved policy document. If it fails, the bot outputs a canned fallback message.

**63. Q: How do you structure a GenAI squad? Who do you hire, and how do they collaborate?**

* **Focus:** Team Leadership & Organization.
* **A:** A modern GenAI team is cross-functional. I need:

1) **Data Engineers** to build the ETL pipelines that clean and chunk enterprise data.
2) **AI Engineers / Applied ML** to manage the orchestration (LangChain/LlamaIndex), prompt engineering, and model routing.
3) **Software/Backend Engineers** to build the APIs, handle state, and integrate the MCP servers.
4) **UX/UI Designers** who understand chat interfaces and streaming responses.
They operate in a pod, treating the LLM not as a magical brain, but as a component in a traditional software architecture.

**64. Q: When interviewing an AI Engineer, what is the red flag that tells you they aren't ready for production systems?**

* **Focus:** Talent Evaluation.
* **A:** The biggest red flag is if they only talk about training models from scratch, Kaggle competitions, or Jupyter notebooks. A production AI Engineer needs to talk about software engineering principles: version controlling prompts, unit testing RAG retrieval (Recall/Precision), managing API timeouts, and CI/CD. If they can't write a production-grade FastAPI wrapper around their LLM call, they aren't ready.

**65. Q: Legal and Compliance have blocked your GenAI deployment because they are terrified of PII (Personally Identifiable Information) leaking to the cloud. How do you unblock the project?**

* **Focus:** Stakeholder Management & Security Architecture.
* **A:** I bring them a technical solution, not an argument. I propose an architecture that includes an anonymization layer *before* the data hits the LLM. We use a local, deterministic NLP library (like Presidio) or a small local SLM to redact names, SSNs, and account numbers, replacing them with tokens (e.g., `[USER_1]`). The LLM processes the sanitized text, and the backend de-tokenizes the response before showing it to the user.

**66. Q: Your GenAI application's cloud bill spiked 400% in a single week. How do you triage and fix the bleeding?**

* **Focus:** FinOps & LLMOps.
* **A:** First, I set a hard API budget cap to stop the bleeding. Then, I look at the telemetry (using tools like LangSmith or Phoenix). Are we stuck in infinite agent loops? Are users pasting 50-page PDFs into the chat?
To fix it, I implement three layers: 1) **Semantic Caching** to intercept duplicate queries. 2) **Model Routing**, pushing 80% of routine queries to a cheaper model like Haiku/Flash, reserving the heavy model only for complex reasoning. 3) **Input truncation** to limit context window bloat.

**67. Q: A business unit wants to fine-tune a model on their proprietary codebase to act as an internal coding assistant. Why might you advise against fine-tuning and suggest RAG instead?**

* **Focus:** Architectural Trade-offs.
* **A:** Fine-tuning teaches a model *style* and *behavior*, not dynamic knowledge. Codebases change daily. If we fine-tune, the model's knowledge is frozen the day training stops, and retraining is astronomically expensive. Instead, I advise an Agentic RAG approach integrated with their IDE or Git repo. The agent searches the active codebase, retrieves the relevant modules, and passes them in the prompt, ensuring the LLM always reasons over the most up-to-date code.

**68. Q: How do you architect a system that won't be obsolete in 6 months given the insane pace of LLM releases?**

* **Focus:** Future-proofing & Modularity.
* **A:** I strictly enforce the **Adapter Pattern**. The core application logic must never call the OpenAI or Anthropic SDKs directly. We build an abstraction layer (an LLM Gateway). The application asks the gateway for "Text Generation" or "Embedding." If a revolutionary new model drops tomorrow, I only update the gateway adapter. The application code, RAG pipelines, and agent logic remain completely unchanged.

**69. Q: We are building an agent that can take actions in our Salesforce CRM. How do you implement "Human-in-the-loop" (HITL) without ruining the automation speed?**

* **Focus:** Autonomous Agent Safety.
* **A:** We categorize actions by risk. "Read" actions (summarizing a client account) are fully autonomous. "Write" actions (updating a phone number) proceed but flag an async audit log. "Destructive/High-Stakes" actions (deleting an account, sending a bulk email) trigger a pause. The agent generates the proposed payload, halts, and sends an alert (via Slack or Teams) with a simple "Approve/Reject" button for a human manager.

**70. Q: What is the most difficult technical challenge you've faced when building a multi-agent system, and how did you solve it?**

* **Focus:** Deep Technical Experience.
* **A:** *(Adapt this to your experience)* The hardest challenge is **state management and context overflow** across a long-running multi-agent workflow. If Agent A talks to Agent B for 20 turns, the context window fills up, the model forgets the original goal, and latency skyrockets. I solved this by implementing a **Supervisor Agent** with a rolling memory summary. Instead of passing the raw transcript between agents, the supervisor continually summarizes the conversation state and only passes the required variables to the next agent.

---

### **Part 2: Principal Solution Architect (Technical Leadership & Conflict)**

**71. Q: Two senior engineers on your team are violently disagreeing on a technical decision (e.g., GraphQL vs. REST). It is stalling the project. How do you resolve it?**

* **Focus:** Conflict Resolution & Technical Leadership.
* **A:** I take it out of the realm of opinion and into the realm of constraints. I schedule a time-boxed meeting and ask them to define the **Architectural Characteristics** that matter most for this specific service (e.g., Client flexibility? Caching? Payload size?). We create a weighted decision matrix (a Pugh matrix). We score both GraphQL and REST against *our* specific use case, not generic medium articles. If the matrix is a tie, I make the executive call based on our team's existing skill set to minimize cognitive load.

**72. Q: A development team wants to use a highly complex technology (like Kubernetes) for a very simple internal CRUD application. "Resume Driven Development." How do you steer them away without demotivating them?**

* **Focus:** Mentorship & Pragmatism.
* **A:** I sit down with the lead and validate their desire to learn. Then, I walk them through the Total Cost of Ownership (TCO). I explain that Kubernetes isn't just deployment; it's managing ingress, RBAC, node pools, and complex CI/CD. I ask, "Is the business value of this internal tool worth that operational overhead?" I guide them toward a PaaS solution (like Azure App Service or Container Apps) and promise to advocate for their K8s adoption on a future, high-scale, customer-facing project where it's actually justified.

**73. Q: Walk me through a time a critical system you designed went down. What happened, and how did you architect the fix?**

* **Focus:** Incident Management & Accountability.
* **A:** *(Adapt to your experience)* We had a microservice outage caused by a third-party API timeout. Our service didn't have proper timeouts configured, so the threads hung, the connection pool exhausted, and it cascaded, taking down the entire API Gateway.
**The Fix:** We implemented the **Circuit Breaker Pattern** (using Polly in .NET). If the third-party API fails consecutively, the circuit opens, failing fast to protect our resources. We also added a **Bulkhead Pattern** to isolate connection pools, ensuring that one failing downstream dependency couldn't consume threads needed for healthy endpoints.

**74. Q: The Product Owner is demanding 100% capacity for new features, leaving zero time for technical debt. How do you convince them otherwise?**

* **Focus:** Negotiation & Business Acumen.
* **A:** Product owners care about flow and predictability. I don't talk about "clean code"; I talk about friction. I show them data: "Last sprint, we spent 40% of our time fixing bugs in the legacy module, which delayed your new feature by a week. If we dedicate 20% of this sprint to refactoring that module, our velocity for your future features will increase." I frame tech debt reduction as an investment in feature speed.

**75. Q: Security mandates a 2-week manual code review for all deployments, which is destroying your Agile velocity. How do you architect a compromise?**

* **Focus:** DevSecOps & Influence.
* **A:** I invite Security to the table and ask about their specific concerns (e.g., SQL injection, exposed secrets). I propose a **Shift-Left** automated approach. We integrate SAST tools (SonarQube) and Secret Scanning directly into the PR pipeline. If the automated scan passes with zero critical/high vulnerabilities, the code auto-deploys. We agree to leave the 2-week manual review *only* for core identity/payment modules. Security gets better coverage; we get our velocity back.

**76. Q: We have a legacy application that relies heavily on in-memory session state. We need to scale it horizontally in the cloud. How do you handle this?**

* **Focus:** Cloud Migration Patterns.
* **A:** The easiest anti-pattern is enabling "Sticky Sessions" on the load balancer, but that creates uneven load distribution and fails if a node dies. The architectural fix is to externalize the state. I would refactor the application to use a distributed cache (like Redis). When a request hits any node, it pulls the session state from Redis, processes the request, and updates Redis. This makes all compute nodes completely stateless and horizontally scalable.

**77. Q: How do you ensure your architectural blueprints are actually adopted by the engineering teams, rather than just sitting in a Confluence wiki?**

* **Focus:** Enablement & Developer Experience (DevEx).
* **A:** Documentation is where architectures go to die. I focus on **Enablement via Automation**. If the standard is to use a specific logging framework, authentication pattern, and CI/CD pipeline, I build a parameterized Project Template (like a Yeoman generator or Backstage software catalog). When a team starts a new service, they push a button, and the repo is scaffolded with the architecture already baked in. You make doing the "right thing" the "easiest thing."

**78. Q: When designing an Event-Driven Architecture, how do you handle messages arriving out of order or duplicating?**

* **Focus:** Resilient Messaging Patterns.
* **A:** In distributed systems, exactly-once delivery is a myth; you aim for at-least-once delivery. To handle duplicates, the consumer *must* be designed for **Idempotency** (checking a transaction ID against a database before processing). To handle out-of-order messages, I include a timestamp or version number in the event payload. The consumer checks if the incoming event is older than the current state in the database; if so, it safely discards the stale event.

**79. Q: You have to design an API that spans three different business domains (e.g., Orders, Inventory, Billing). They all have competing priorities. How do you align them?**

* **Focus:** Cross-Domain Architecture.
* **A:** I use the **Backend-for-Frontend (BFF)** or **API Gateway orchestration** pattern. I do not force the three domains to change their internal data models to suit each other. Instead, each domain exposes its own bounded-context API. I build a top-level orchestration API that aggregates data from the three domains. I facilitate a contract negotiation (Swagger/OpenAPI) between the frontend consumers and the aggregator, shielding the individual domains from the messy integration logic.

**80. Q: What is your approach to handling breaking changes in a public-facing API?**

* **Focus:** API Lifecycle Management.
* **A:** Breaking changes should be avoided, but when necessary, strict versioning is required. I prefer URI versioning (`/v1/orders` to `/v2/orders`) or Header versioning. I never just flip the switch. I implement a deprecation strategy: return a `Warning` header in the v1 responses indicating the deprecation timeline. I monitor API Gateway logs to track which clients are still using v1, proactively contact them, and only sunset v1 when traffic drops to an acceptable threshold.

---

### **Part 3: Enterprise Architect (C-Suite, M&A, & Enterprise Inertia)**

**81. Q: The CFO is skeptical about a $5 million cloud migration, noting that the on-prem data centers are already paid for. Pitch the transformation to the board.**

* **Focus:** Executive Communication & ROI.
* **A:** I don't talk about containers or microservices; I talk about opportunity cost and risk. I explain that while the hardware is paid for, our current infrastructure requires 6 months to provision a server for a new product launch, costing us millions in lost market share to agile competitors. I frame the cloud not as an IT hosting cost, but as an **innovation engine** that shifts CAPEX to OPEX, improves our disaster recovery posture to protect revenue, and allows us to scale elastically during peak seasons without buying idle hardware.

**82. Q: You identify a legacy application for retirement to save $500k a year, but a powerful VP refuses to let it go because "his team is used to it." How do you proceed?**

* **Focus:** Navigating Enterprise Politics.
* **A:** I don't fight the VP directly; I use data and empathy. I meet with the VP to understand their real fear—which is usually a disruption to their team's workflow or a loss of a specific feature. I map the legacy app's features to the new enterprise standard system. I offer to fund a targeted training program for their team and promise a phased parallel rollout. If they still refuse, I move the $500k maintenance cost directly to their business unit's P&L (chargeback model). Usually, bearing the financial burden changes their mind.

**83. Q: Your company just acquired a competitor. As the EA, what is your 90-day plan for integrating their technology stack?**

* **Focus:** M&A Technology Strategy.
* **A:** **Days 1-30 (Discovery):** I do not touch anything. I map their application portfolio and infrastructure against our Business Capability Model. I assess critical security risks, licensing agreements, and identify key technical talent.
**Days 31-60 (Strategy):** I define the disposition for each system using the TIME model (Tolerate, Invest, Migrate, Eliminate). We decide what is the "System of Record" for HR, Finance, and CRM.
**Days 61-90 (Execution Blueprint):** I establish a federated Identity strategy (usually via Azure AD/Entra ID) to allow cross-company communication on day one. Then, we begin the phased data migration and application sunsetting plan.

**84. Q: How do you stop "Shadow IT" while keeping business units agile?**

* **Focus:** IT Governance & Enablement.
* **A:** You can't regulate Shadow IT away; you have to out-compete it. Business units build rogue apps because IT is too slow. I establish a "Paved Road" strategy. I create a governed Low-Code/No-Code environment (like Microsoft Power Platform). We provide pre-approved, secure API connectors to enterprise data. The business units get the agility to build their own tools, but EA and Security retain visibility and control over the data governance.

**85. Q: How does the role of Enterprise Architecture change when a company moves from traditional Waterfall to the SAFe (Scaled Agile) framework?**

* **Focus:** Agile Enterprise Architecture.
* **A:** In Waterfall, the EA is a gatekeeper who writes massive blueprint documents upfront. In SAFe, the EA is an enabler and visionary. We move from "Big Design Up Front" to "Intentional Architecture" combined with "Emergent Design." I focus on building the **Architectural Runway**—the underlying infrastructure, APIs, and pipelines that allow the Agile Release Trains (ARTs) to deliver business features continuously without hitting technical roadblocks.

**86. Q: We are heavily locked into an expensive legacy vendor (e.g., Oracle or IBM). How do you architect an exit strategy?**

* **Focus:** Vendor Management & De-coupling.
* **A:** I use the **Strangler Fig Pattern** applied at the enterprise level. We do not attempt a massive "rip and replace," which always fails. First, we stop all *new* development on the legacy system. We wrap the legacy system in an API layer. Then, we identify specific, high-value business capabilities (e.g., "Inventory Pricing") and extract them into modern cloud microservices. We slowly route traffic away from the vendor over 18-24 months until the legacy system is an empty shell that can be decommissioned.

**87. Q: The CEO asks you to establish a Cloud Center of Excellence (CCoE). How do you ensure it actually delivers value and doesn't just produce unread whitepapers?**

* **Focus:** Organizational Design & Change Management.
* **A:** A CCoE fails when it is composed entirely of ivory-tower architects. I build a cross-functional CoE consisting of Architecture, Security, FinOps, and, crucially, lead engineers from the delivery teams. Our output is not whitepapers; it is **executable code**. We deliver Terraform modules, CI/CD pipeline templates, and security-approved reference architectures that teams can clone and use immediately. Value is measured by adoption rate, not documentation volume.

**88. Q: The business needs a critical feature in 2 weeks. The engineering team says they can do it, but it will completely ruin the architecture. Doing it "right" takes 3 months. What is your recommendation?**

* **Focus:** Pragmatic Risk Management.
* **A:** EA cannot be the reason the company misses a critical market opportunity. If the 2-week deadline is a hard, revenue-generating requirement, I approve the tactical "hack." **However**, I treat it like a financial loan. I require the business sponsor to explicitly agree, in writing, to fund the 3-month refactor in the very next quarter to pay down the technical debt. We isolate the "hack" behind a strict API boundary so it doesn't contaminate the rest of the system.

**89. Q: A development team wants to introduce a completely new programming language (e.g., Rust) into the enterprise portfolio. How do you evaluate this request?**

* **Focus:** Technology Standardization.
* **A:** I evaluate it based on total lifecycle cost, not just performance. I ask: Does this solve a problem that our current stack (.NET/Python/Java) absolutely cannot solve? (e.g., ultra-low latency system programming). If yes, I evaluate the operational impact: Do our security tools scan Rust? Can our CI/CD pipelines build it? Do we have enough engineers to support it at 2 AM on a Sunday, or is it just one passionate developer? If it doesn't meet the enterprise supportability criteria, the request is denied.

**90. Q: At the end of the year, the CEO asks you: "What tangible value did the Enterprise Architecture team deliver this year?" How do you answer?**

* **Focus:** Measuring EA ROI.
* **A:** I present three hard metrics:

1) **Cost Avoidance/Savings:** "We retired 15 redundant applications through our portfolio rationalization, saving $1.2M in licensing and hosting."
2) **Speed to Market:** "By providing self-service architectural blueprints and automated infrastructure templates, we reduced the average project spin-up time from 4 weeks to 3 days."
3) **Risk Mitigation:** "We instituted a governed API strategy that eliminated 40 point-to-point shadow integrations, significantly reducing our vulnerability surface."

---

We have exactly **10 questions left** to hit your goal of 100!

For the final stretch (91-100), we can focus on **"Curveball" scenarios**—the incredibly difficult, abstract questions designed to test how you think on your feet (e.g., estimating cloud costs on a napkin, debating open-source vs. enterprise, or defining the ethics of an autonomous AI decision).

Shall we finish the final 10?
