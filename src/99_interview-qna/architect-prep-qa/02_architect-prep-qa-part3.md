# 02 Architect Prep QA Part 3

### **Part 2: Principal Solution Architect — Batch 2 (Distributed Systems & Scale)**

**41. Q: How do you maintain data consistency across microservices when you can't use traditional distributed transactions (2PC)?**

* **The Trap:** Using synchronous HTTP calls to update multiple databases.
* **How to Answer:** I use the **Saga Pattern**. Instead of locking databases, a business transaction is broken down into a sequence of local transactions. I typically prefer the **Choreography** approach for simple workflows (microservices publish events via an Event Bus) or the **Orchestration** approach for complex workflows (using a central coordinator like AWS Step Functions or Azure Durable Functions). Crucially, every step must have a defined **compensating transaction** to roll back changes if a subsequent step fails.

**42. Q: Explain CQRS and Event Sourcing. Should they always be used together?**

* **The Trap:** Implementing them for a simple CRUD application.
* **How to Answer:** CQRS separates the read and write models, allowing them to scale independently. Event Sourcing stores the state of an entity as a sequence of immutable events rather than just the current state. They pair well, but they are not mandatory together. I only use Event Sourcing for domains with high auditability requirements (like financial ledgers), as it introduces immense complexity. CQRS, however, is great on its own for heavy-read systems.

**43. Q: When do you advocate for an API Gateway versus a Service Mesh?**

* **The Trap:** Thinking they do the exact same thing.
* **How to Answer:** An **API Gateway** handles North-South traffic (external clients calling your internal services). It manages cross-cutting concerns like public authentication, rate limiting, and monetization. A **Service Mesh** (like Istio or Linkerd) handles East-West traffic (service-to-service communication within the cluster). It manages mTLS, retries, and distributed tracing. I use both: the Gateway at the edge, and the Mesh inside the cluster.

**44. Q: We are experiencing "Cache Stampedes" when a popular key expires. How do you solve this?**

* **The Trap:** Just increasing the TTL (Time to Live) of the cache.
* **How to Answer:** A cache stampede happens when a high-traffic key expires, and 1,000 threads simultaneously miss the cache and hit the database, crushing it. I mitigate this using **Mutex Locks** (only allowing one thread to query the DB while others wait for the cache to populate) or **Probabilistic Early Expiration** (where background workers refresh the cache *before* it actually expires).

**45. Q: What does "Zero Trust Architecture" actually mean when designing microservices?**

* **The Trap:** Thinking Zero Trust only applies to VPNs and user logins.
* **How to Answer:** Zero Trust in microservices means we do not trust network boundaries. Even if Service A and Service B are in the same private subnet, they must authenticate and authorize every single request. I implement this using mutual TLS (mTLS) via a Service Mesh, and by passing short-lived JWTs (JSON Web Tokens) that contain the user's context through the entire call chain.

**46. Q: How do you design a system to handle massive amounts of real-time WebSocket connections?**

* **The Trap:** Trying to hold millions of persistent connections on a single server.
* **How to Answer:** WebSockets are stateful, which breaks standard load balancing. I use a pub/sub backplane (like Redis Pub/Sub) or a managed service like Azure Web PubSub or AWS API Gateway WebSocket APIs. The load balancer distributes the connections across a fleet of stateless servers, and the backplane ensures that a message intended for a specific user is routed to the exact server holding their socket connection.

**47. Q: Compare Blue-Green deployments with Canary releases. When is Canary the wrong choice?**

* **The Trap:** Assuming Canary is always superior because it's "safer."
* **How to Answer:** Blue-Green spins up a full identical environment, routes traffic over instantly, and allows instant rollback. Canary slowly routes a percentage of traffic (1%, 10%, 100%) to the new version. Canary is the wrong choice if the deployment includes a non-backward compatible database schema change. In those cases, Blue-Green (combined with the Expand/Contract DB pattern) is required to ensure data integrity.

**48. Q: What is the "Distributed Monolith" anti-pattern, and how do you avoid it?**

* **The Trap:** Bragging about having 500 microservices without understanding their coupling.
* **How to Answer:** A distributed monolith occurs when you break an app into microservices, but they are tightly coupled via synchronous HTTP calls. If Service A goes down, Services B, C, and D crash too. I avoid this by defining proper Bounded Contexts (so services own their own data) and using asynchronous, event-driven communication to break the temporal coupling.

**49. Q: How do you design an API to guarantee Idempotency, especially for payment or order systems?**

* **The Trap:** Assuming GET requests are the only things that need to be idempotent.
* **How to Answer:** For POST requests (like creating an order), network drops can cause clients to retry, resulting in duplicate orders. I design the API to require an `Idempotency-Key` in the header. The backend checks this key against a fast distributed cache (like Redis). If the key exists, it means the request was already processed, and the API returns the cached successful response without re-executing the business logic.

**50. Q: In an event-driven architecture, how do you handle schema evolution when producers update their event structure?**

* **The Trap:** Just letting the consumers break and fixing them later.
* **How to Answer:** I enforce a **Schema Registry** (like Confluent Schema Registry for Kafka) using formats like Avro or Protobuf. Producers validate their payloads against the registry before publishing. I enforce strict compatibility rules (e.g., Forward/Backward compatibility) so that producers can add new fields without breaking older consumers, ensuring the pipeline remains stable.

---

### **Part 3: Enterprise Architect — Batch 2 (Strategy, Governance, & M&A)**

**51. Q: Walk me through your "Buy vs. Build vs. Rent" framework.**

* **The Trap:** Always favoring custom builds because it's more "fun" for engineering.
* **How to Answer:** It's driven by competitive advantage. If a capability provides a distinct competitive advantage in our market (e.g., our proprietary trading algorithm or custom GenAI routing), we **Build**. If it is a necessary, non-differentiating back-office function (e.g., HR payroll, CRM), we **Buy/Rent** via SaaS. Custom engineering is too expensive to waste on solved problems.

**52. Q: How do you manage Technical Debt at an enterprise scale?**

* **The Trap:** Treating tech debt purely as "bad code" that needs refactoring.
* **How to Answer:** Tech debt is a financial instrument. Some debt is acceptable if it accelerates time-to-market. The issue is unmanaged debt. I create a "Tech Debt Register" tied to business risk. If a legacy system slows feature delivery by 30% or poses a security risk, it gets prioritized. I negotiate with product owners to dedicate 20% of their backlog capacity specifically to retiring high-interest technical debt.

**53. Q: What is MACH Architecture, and why is it trending in enterprise digital transformations?**

* **The Trap:** Just listing the acronym without understanding the business value.
* **How to Answer:** MACH stands for Microservices based, API-first, Cloud-native SaaS, and Headless. It is trending because it allows enterprises to swap out vendors easily. Being "Headless" means decoupling the frontend UI from the backend logic. This allows the business to rapidly launch new digital experiences (mobile apps, IoT interfaces) without rebuilding the core backend commerce or content engines.

**54. Q: Explain API-Led Connectivity (the System, Process, Experience API model).**

* **The Trap:** Thinking it's just a MuleSoft sales pitch.
* **How to Answer:** It's a reusability framework. **System APIs** sit on top of core systems of record (like SAP or Oracle), shielding downstream apps from backend changes. **Process APIs** orchestrate data across multiple System APIs to execute business logic (e.g., "Onboard Employee"). **Experience APIs** format that processed data specifically for different UI clients (Mobile, Web, Kiosk). This drives massive reuse of components.

**55. Q: How do you differentiate between an Architectural "Guardrail" and a "Guideline"?**

* **The Trap:** Enforcing everything strictly, destroying developer velocity.
* **How to Answer:** A **Guardrail** is non-negotiable and usually tied to security, compliance, or catastrophic failure (e.g., "All data at rest must be encrypted via CMK", "No public IP addresses on DBs"). Guardrails are automated in CI/CD. A **Guideline** is a strong recommendation for standardization (e.g., "Prefer React for frontends"). Guidelines can be bypassed if a team has a valid, documented business reason.

**56. Q: What is the Enterprise Architect's role in FinOps (Cloud Cost Optimization)?**

* **The Trap:** Believing cost is only a Finance or DevOps problem.
* **How to Answer:** Architecture dictates cost. A poorly designed, chatty microservice architecture will generate massive inter-AZ network egress costs. My role is to bake cost-awareness into the design phase. I mandate tagging standards for chargebacks, review architectures for serverless vs. provisioned resource efficiency, and track the "Unit Cost" of transactions rather than just the total cloud bill.

**57. Q: How do you approach Master Data Management (MDM) across siloed business units?**

* **The Trap:** Trying to force everyone into one massive, central, unified database.
* **How to Answer:** The "golden record" monolithic database rarely works. I prefer a federated or registry model. We define a standard enterprise data dictionary. Each business unit can keep their operational databases, but they must publish state changes to a central Event Bus. An MDM hub consumes these events, resolves identities, and broadcasts the unified ID back to the edge systems.

**58. Q: How do you measure the success or ROI of the Enterprise Architecture practice itself?**

* **The Trap:** Measuring success by the number of diagrams created or meetings held.
* **How to Answer:** EA success is measured by business agility and cost avoidance. I track: 1) **Time-to-market** (are reference architectures speeding up delivery?). 2) **Application Rationalization savings** (how many redundant apps did we retire?). 3) **Reuse percentage** (how many projects leveraged existing APIs rather than building from scratch?). EA must prove it is an accelerator, not a tax.

**59. Q: When is it acceptable to intentionally accept "Vendor Lock-in" in the cloud?**

* **The Trap:** Claiming you must build everything cloud-agnostic using Kubernetes to avoid lock-in.
* **How to Answer:** Cloud-agnostic architectures (lowest common denominator) are incredibly expensive to build and maintain. I accept vendor lock-in when the speed-to-market and operational simplicity provided by a PaaS/SaaS service (like AWS DynamoDB or Azure Cosmos DB) vastly outweigh the hypothetical cost of switching providers in the future. You lock in to value, not just technology.

**60. Q: As an EA, how do you handle a severe disagreement between two Domain Architects regarding technology selection?**

* **The Trap:** Pulling rank and dictating the answer.
* **How to Answer:** I facilitate a structured "Trade-off Analysis." We remove ego by documenting the architectural characteristics that matter most to the specific business problem (e.g., Latency vs. Throughput, Consistency vs. Availability). We score both proposed solutions against those objective criteria. If the decision is still tied, I escalate to the business sponsor to decide based on risk tolerance, but usually, the matrix reveals the right answer.
