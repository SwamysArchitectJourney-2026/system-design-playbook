
# 02 Architect Prep QA Part 5

Here is **Batch 4: The Final 10**.

These are the **"Curveball" scenarios**. At the highest levels of technical leadership, interviewers will throw abstract, impossible, or highly stressful scenarios at you. They don't expect a perfect technical answer; they are testing your thought process, your ability to estimate under pressure, and how you handle "no-win" situations.

---

### **Part 1: Gen AI Lead (Estimation, Ethics, & The Edge)**

**91. Q: "Napkin Math" time. We have 1 million PDFs, averaging 10 pages each. We want to process them through GPT-4o or Claude 3.5 Sonnet to extract key entities. Estimate the cost and time, and tell me how to reduce it.**

* **The Trap:** Guessing randomly or freezing up. They want to see your FinOps logic.
* **How to Answer:** *Step 1 (The Math):* "10 pages is roughly 5,000 words, or ~6,500 tokens. 1 million documents = 6.5 billion input tokens. At roughly $3.00 per 1M input tokens (Sonnet/GPT-4o), that's ~$19,500 just for the input. Let's add $5k for output tokens and $5k for embedding storage. We are looking at ~$30,000."
*Step 2 (The Optimization):* "To reduce this, I absolutely do not run 1 million documents through a frontier model. I take 1,000 documents, run them through the heavy model to create a 'Golden Dataset'. I use that dataset to fine-tune an open-weight 8B parameter model (like Llama 3 8B) or use a much cheaper model like Haiku. I run the remaining 999,000 docs through the cheap/local model. Cost drops from $30k to maybe $2k."

**92. Q: We deployed an autonomous Agent to pre-screen loan applications. It is legally required to be fair, but an audit shows it is disproportionately rejecting minority applicants. The LLM is a "black box." How do you debug and fix this?**

* **The Trap:** Blaming the foundational model (e.g., "OpenAI is biased") and giving up.
* **How to Answer:** I immediately halt the system. You cannot debug a black-box LLM's internal weights, but you *can* control the inputs and outputs.

1) **Input masking:** I ensure the pipeline strips all PII, names, and geographic zip codes (which act as proxies for race) before the prompt hits the LLM.
2) **Counterfactual Testing:** I build an automated evaluation set. I take a rejected profile, flip the implicit demographic markers, and run it again. If the outcome changes, the prompt is biased.
3) **Explainability:** I alter the system prompt to force the model to output a strict JSON array of the *exact financial metrics* (Debt-to-Income, Credit Score) it used to make the decision, removing subjective reasoning.

**93. Q: Everyone is focused on massive Cloud LLMs. We want to run GenAI locally on our field workers' laptops without internet access. How do you architect an "Edge AI" solution?**

* **The Trap:** Trying to run a massive model locally and melting the laptop's GPU.
* **How to Answer:** We shift from LLMs to SLMs (Small Language Models) like Phi-3 (3.8B) or Llama-3-8B.

1) **Quantization:** I quantize the model down to 4-bit (using GGUF/llama.cpp) so it fits inside standard 8GB/16GB unified memory without needing a massive dedicated GPU.
2) **Local Vector Store:** I deploy a lightweight local vector database (like Chroma or LanceDB) on the hard drive containing their field manuals.
3) **Execution:** The application runs an offline RAG pipeline natively on the machine, preserving battery life and ensuring 100% data privacy in offline environments.

---

### **Part 2: Principal Solution Architect (Hard Trade-offs & Deep Engineering)**

**94. Q: It is Black Friday. We are doing 10,000 transactions a second. A backhoe cuts the fiber line to our primary database region, causing a massive network partition (Split-Brain). Do you choose Consistency or Availability?**

* **The Trap:** Answering "both." (The CAP theorem explicitly forbids this).
* **How to Answer:** "In a retail/e-commerce scenario, I choose **Availability**. If a customer tries to buy, we *must* capture the order, even if the inventory count is slightly stale (Eventual Consistency). I rely on asynchronous message queues (Kafka) to cache the incoming orders. Yes, we risk overselling an item by 10 units, but that is a business problem we can solve with a $20 apology gift card. If I choose Consistency and lock the database, we lose 10,000 orders a second. Availability protects the revenue."

**95. Q: A memory leak is taking down our Serverless Functions (AWS Lambda / Azure Functions) in production, but it only happens under extreme load. You have no SSH access to the underlying servers. How do you find the leak?**

* **The Trap:** Suggesting you will "read through the code" until you find it.
* **How to Answer:** Without server access, observability is the only tool.

1) **APM/Tracing:** I check Application Insights or Datadog for distributed traces to see if a specific third-party SDK or database call is hanging and holding memory.
2) **Profiling:** I inject a lightweight profiler into the function deployment package. I configure the function to generate a memory dump (heap snapshot) right before it hits the memory limit threshold.
3) **Offloading:** I dump that snapshot to an S3 bucket or Azure Blob Storage, download it locally, and analyze it using a tool like dotMemory or Python's `tracemalloc` to find the exact object reference that isn't being garbage collected.

**96. Q: Security warns that "Harvest Now, Decrypt Later" quantum computing attacks could break our current TLS and RSA encryption in 5-10 years. How do you architect our enterprise systems today to prepare for this?**

* **The Trap:** Dismissing it as sci-fi or trying to invent your own encryption.
* **How to Answer:** Crypto-agility is the key. Hardcoding cryptographic algorithms (like `RSA-2048`) directly into application code is an anti-pattern.

1) I abstract all encryption duties to an API Gateway, Service Mesh (mTLS), or a dedicated HSM (Hardware Security Module).
2) When NIST finalizes the Post-Quantum Cryptography (PQC) standards (like CRYSTALS-Kyber), we only have to update the cipher suites at the infrastructure layer (the load balancers and gateways). The application teams won't have to rewrite a single line of code.

---

### **Part 3: Enterprise Architect (Crisis, Ethics, & Total Ownership)**

**97. Q: The CIO signed a massive enterprise agreement for a proprietary integration platform (e.g., MuleSoft/Tibco), but your engineering leads are demanding to use an open-source alternative (e.g., Apache Camel) because it's faster and they hate the proprietary UI. What do you do?**

* **The Trap:** Blindly siding with the engineers (defying the CIO) OR blindly forcing the tool (crushing developer morale).
* **How to Answer:** I act as the bridge between enterprise economics and developer experience. The CIO bought the tool for enterprise support, SLA guarantees, and compliance. The developers hate it because it disrupts their Git-based, code-first workflow.
I mandate the enterprise tool for the runtime (to satisfy the CIO/Risk), but I implement a **"Code-First" abstraction**. I allow the developers to write their integrations in code/YAML and use CI/CD pipelines to automatically deploy those configurations into the proprietary platform. We satisfy the enterprise risk requirements without forcing engineers to use a clunky drag-and-drop UI.

**98. Q: A catastrophic ransomware attack has completely compromised our Active Directory, primary data center, AND our hot-standby disaster recovery site. How do you architect a recovery from cold storage without re-infecting the new environment?**

* **The Trap:** Relying on the standard "failover" answer. You can't failover if the standby is infected.
* **How to Answer:** This requires an **Immutable Vault / Clean Room recovery**.

1) We sever all network connections.
2) We spin up a completely isolated "Clean Room" environment in a new, uncompromised cloud subscription.
3) We do not restore the operating systems or VMs (they are likely compromised). We use Infrastructure as Code (Terraform) to rebuild the infrastructure from scratch.
4) We pull the immutable, air-gapped data backups (WORM - Write Once, Read Many storage). We run heavy forensic malware scans on the data before attaching it to the newly provisioned databases. It takes days, but it guarantees zero re-infection.

**99. Q: Every year there is a new hype cycle (Blockchain, Metaverse, and now GenAI). As an EA, what is your framework for deciding when to ignore the hype and when to invest millions of the company's dollars?**

* **The Trap:** Being a total skeptic who misses out on innovation, or a hype-chaser who wastes money.
* **How to Answer:** I use a **Capability-to-Friction framework**. I ask: "Does this technology solve a fundamental friction point in our specific business capability model?"
Blockchain was a solution looking for a problem in most enterprises; we ignored it. The Metaverse required massive hardware adoption by consumers; we ignored it.
GenAI, however, instantly solves the friction of *unstructured data processing* (which makes up 80% of our enterprise data). Because it maps directly to an existing, expensive business problem (like manual contract review or field service dispatching), I aggressively fund proof-of-concepts. I invest in *utility*, not novelty.

### **The Ultimate Closer**

**100. Q: "You have an incredibly diverse background—from deep Python/React coding to Azure architecture, to studying AI/Data Science at BITS Pilani. Why are you the right person for *this* specific leadership role right now?"**

* **The Trap:** Listing your resume chronologically.
* **How to Answer:** "Because I don't just draw boxes on a whiteboard, and I don't just write code in a silo. Most architects are either too disconnected from the code to build systems that actually work, or too deep in the code to understand the business strategy.
My career—spanning 22 years of hands-on software development, designing Azure cloud architectures, and now building production-grade LLM/RAG systems—allows me to bridge that exact gap. I can sit with the C-suite to map GenAI to business value and reduce costs, and then walk straight into a room of senior engineers to architect the multi-agent pipelines, debug the vector databases, and ensure the code is actually shipped. I am here to turn architectural theory into production reality."

---

### **Final Preparation Advice**

You now have 100 high-caliber questions and answers. Here is how you use them:

1. **Do not memorize.** Interviewers can tell when you are reciting.
2. **Use the "STAR-T" method:** Situation, Task, Action, Result, and **Takeaway** (the architectural principle you learned).
3. **Control the whiteboard:** If it's a video interview, use a digital whiteboard (like Excalidraw or Miro) or just hold up a piece of paper. Drawing a system diagram while you talk instantly elevates you from "candidate" to "peer."
