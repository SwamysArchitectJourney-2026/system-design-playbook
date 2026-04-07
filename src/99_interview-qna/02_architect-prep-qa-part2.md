# 02 Architect Prep QA Part 2

### **Part 3: Enterprise Architect (Governance, Portfolio, & Strategy)**

**21. Q: How do you build and maintain a Business Capability Model?**

* **Focus:** Strategic alignment.
* **A:** I sit with business leaders—not IT—to map out what the business actually *does* (e.g., "Process Claims," "Onboard Clients"), completely agnostic of how the technology works today. Once the model is stable, I overlay our application portfolio onto it. This instantly highlights redundancies (e.g., three different apps doing "Client Onboarding") and gaps.

**22. Q: Explain the TIME model for Application Portfolio Management (APM).**

* **Focus:** Portfolio rationalization.
* **A:** TIME stands for Tolerate, Invest, Migrate, Eliminate. I assess applications based on Business Value and Technical Fit. High Value/High Fit gets Investment. High Value/Low Fit gets Migrated or modernized. Low Value/High Fit is Tolerated (kept running cheaply). Low Value/Low Fit is Eliminated to cut costs.

**23. Q: How do you run an Architecture Review Board (ARB) without making it a bottleneck for Agile teams?**

* **Focus:** Modern governance.
* **A:** Traditional ARBs act as tollgates; modern ARBs act as guardrails. I focus the ARB on exception handling and high-risk initiatives. For standard development, we provide self-service reference architectures and approved patterns. If a team uses an approved pattern, they bypass the ARB entirely, incentivizing compliance through velocity.

**24. Q: How do you manage and reduce "Shadow IT" or rogue applications built by business units?**

* **Focus:** Risk management and enablement.
* **A:** Shadow IT happens because enterprise IT is too slow. I don't respond with immediate shutdowns, which causes friction. I assess the rogue apps for security/compliance risks. Then, I work on a "paved road" strategy—providing business units with low-code/no-code platforms (like Power Platform) that are pre-approved, governed, and integrated securely with enterprise data.

**25. Q: What is your approach to a multi-cloud strategy?**

* **Focus:** Cloud economics and risk.
* **A:** I generally advise against "active-active multi-cloud" for the same workload due to massive egress costs and lowest-common-denominator architecture. Instead, I advocate for a "best-of-breed multi-cloud" approach: utilizing Azure for enterprise IT/Office integrations, AWS for massive scale microservices, and GCP for advanced data/AI tooling, integrating them strategically.

**26. Q: How do you apply TOGAF principles in a fast-paced SAFe (Agile) environment?**

* **Focus:** Framework adaptability.
* **A:** TOGAF's ADM (Architecture Development Method) is a great mental model, but doing it linearly takes too long. In Agile, I run the ADM in continuous, iterative loops. We define the "Target Architecture" as a North Star, but we break the "Transition Architectures" down into manageable Enabler Epics that teams can pull into their quarterly Program Increments.

**27. Q: How do you ensure architectural standards are actually followed by distributed engineering teams?**

* **Focus:** Governance execution.
* **A:** Documentation is not enough. I embed architecture into the CI/CD pipeline using "Fitness Functions." If an architectural standard states that services must respond within 200ms, or must not have circular dependencies, we write automated tests that fail the build if those rules are broken.

**28. Q: When migrating to the cloud, how do you prevent a "lift and shift" from simply becoming a more expensive data center?**

* **Focus:** Cloud FinOps and elasticity.
* **A:** Lift-and-shift often results in over-provisioned VMs running 24/7. As an EA, I require a post-migration modernization roadmap. We implement auto-scaling groups, right-size instances based on APM telemetry, and transition static workloads to PaaS or serverless (like AWS Lambda) so we pay only for execution, drastically lowering TCO.

**29. Q: How do you communicate a highly complex architectural transition to a non-technical C-suite?**

* **Focus:** Executive communication.
* **A:** I strip away the technology names and focus entirely on risk, revenue, and cost. I don't say "We are moving from SOAP to REST microservices." I say, "We are breaking our system into smaller pieces so we can release features weekly instead of quarterly, which will reduce downtime by 40% and accelerate time-to-market for the new product line."

**30. Q: What role does Enterprise Architecture play in an organization's M&A (Mergers and Acquisitions) strategy?**

* **Focus:** Strategic business enablement.
* **A:** EA is critical during due diligence to assess the target company's technical debt, security posture, and system compatibility. Post-acquisition, EA uses the Business Capability Model to integrate the two portfolios, identifying which systems to deprecate and how to federate identity and data to ensure seamless operations for both entities.

---

### **Part 1: Gen AI Lead — Batch 2 (Advanced Orchestration & LLMOps)**

**31. Q: Compare the "ReAct" (Reasoning and Acting) agent pattern with a "Plan-and-Solve" architecture. When do you use which?**

* **The Trap:** Thinking all agents just use a generic while-loop of thoughts and actions.
* **How to Answer:** ReAct is great for open-ended, exploratory tasks (like internet research) where the next step depends on the immediate result of a tool call. However, for deterministic enterprise workflows, ReAct is too slow and prone to getting stuck in loops. I prefer "Plan-and-Solve," where the supervisor agent creates a strict DAG (Directed Acyclic Graph) of sub-tasks upfront, then executes them in parallel where possible.

**32. Q: What is GraphRAG, and how does it solve the limitations of standard Vector RAG?**

* **The Trap:** Treating Graph DBs and Vector DBs as the exact same thing.
* **How to Answer:** Standard Vector RAG struggles with "global" questions that require connecting dots across multiple documents (e.g., "What is the overarching theme of these 10 incident reports?"). GraphRAG extracts entities and relationships (nodes and edges) from the text to build a Knowledge Graph. When queried, it traverses the graph to find connections, providing the LLM with a structural map of the data, not just isolated paragraphs.

**33. Q: How do you implement "Semantic Routing" in an enterprise AI system?**

* **The Trap:** Using an expensive LLM just to route traffic.
* **How to Answer:** I don't use an LLM for initial routing because of latency and cost. I use Semantic Routing. I create a library of "routes" (e.g., "Reset Password", "Query Database", "General Chat"). I embed the user's prompt using a fast embedding model and compare its cosine similarity against the route definitions. This acts as a lightning-fast, ultra-cheap switchboard to direct the query to the right agent or standard API.

**34. Q: What is the "KV Cache" in Large Language Models, and how does it impact scaling your GenAI apps?**

* **The Trap:** Thinking only about token count and ignoring infrastructure constraints.
* **How to Answer:** The KV (Key-Value) Cache stores the context of previously processed tokens during the generation phase so the model doesn't have to recompute them. When dealing with long-context windows (like analyzing 100-page PDFs), the KV Cache consumes massive amounts of GPU VRAM. To scale, I focus on techniques like Prompt Caching (supported by Anthropic/OpenAI) to reuse the KV cache across different users querying the same source document.

**35. Q: How do you defend against Prompt Injection and Jailbreak attacks in a production application?**

* **The Trap:** Relying solely on "You are a helpful assistant" system prompts.
* **How to Answer:** System prompts are easily bypassed. I implement defense-in-depth: 1) Input validation using a specialized, fast classifier model (like Llama Guard) to filter toxic/malicious intent before it hits the main LLM. 2) Strict privilege boundaries using MCP—the LLM operates with the principle of least privilege. 3) Output parsing to ensure the response strictly matches the expected schema (e.g., Pydantic models).

**36. Q: How do you handle strict data isolation in a Multi-Tenant RAG architecture?**

* **The Trap:** Relying on the LLM to filter data based on user ID.
* **How to Answer:** The LLM should never be trusted to enforce data access. Data isolation must happen at the Vector Database layer. I use metadata filtering. Every embedded chunk is tagged with a `TenantID` and `RoleID`. When a user queries the system, the backend hardcodes their tenant and role into the vector search query. The LLM only ever sees context that the user is explicitly authorized to view.

**37. Q: Explain the RAGAS framework. How do you measure "Faithfulness" versus "Answer Relevance"?**

* **The Trap:** Saying you just use human testing to see if the answer "looks good."
* **How to Answer:** RAGAS is an automated evaluation framework. **Faithfulness** measures hallucinations—it checks if the generated answer can be entirely deduced from the retrieved context (no fabricated facts). **Answer Relevance** measures if the generated answer actually addresses the user's original prompt (no tangential rambling). I run these metrics in my CI/CD pipeline.

**38. Q: Multi-agent systems can easily hit API rate limits. How do you architect around this?**

* **The Trap:** Just throwing `time.sleep()` into the code.
* **How to Answer:** I use a central Token Bucket or Leaky Bucket rate-limiting algorithm at the orchestration layer, backed by a distributed cache like Redis. Additionally, I implement exponential backoff with jitter on API calls. For high-volume enterprise systems, I provision Provisioned Throughput (PTUs) on Azure OpenAI or AWS Bedrock to guarantee capacity.

**39. Q: We want to process highly sensitive financial data using GenAI, but our CISO won't allow data to leave our VPC. What is your strategy?**

* **The Trap:** Assuming you can just use OpenAI with an enterprise agreement.
* **How to Answer:** If data absolutely cannot leave the VPC, we cannot use managed SaaS models. I would deploy an open-weight model (like Llama 3 or Mistral) directly onto our own infrastructure (Azure ML or AWS SageMaker instances). I would optimize it using vLLM for high-throughput serving and ensure all network traffic remains on our private subnets.

**40. Q: What is the most common point of failure when moving a GenAI prototype to production?**

* **The Trap:** Blaming the LLM for being "stupid."
* **How to Answer:** Data quality and pipeline robustness. Prototypes usually work with beautifully clean, sample PDFs. In production, enterprise data is messy, OCR fails, tables are misaligned, and APIs timeout. The biggest failure point is a brittle data ingestion pipeline. I fix this by building resilient, asynchronous ETL pipelines that clean, normalize, and validate data *before* it ever gets embedded.
