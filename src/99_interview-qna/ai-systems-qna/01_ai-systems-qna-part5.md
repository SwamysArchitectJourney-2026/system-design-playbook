
# 🧩 SECTION 3 — RAG & LLM SYSTEM DESIGN

---

## ❓ What is RAG and when do you use it?

### ✅ Answer

**Level 1:**

> RAG augments LLMs with external knowledge via retrieval.

**Level 2:**

> I use it when:

* knowledge is dynamic
* domain-specific
* too large for prompt

**Level 3:**

> It shifts the problem from “model accuracy” → “retrieval quality”.

---

## ❓ When does RAG fail?

### ✅ Answer

**Level 1:**

> When retrieval is poor.

**Level 2:**

* irrelevant chunks
* noisy embeddings
* bad chunking

**Level 3:**

> Most failures are **retrieval failures, not model failures**.

---

## ❓ Prompting vs RAG vs Fine-tuning?

### ✅ Answer

**Level 1:**

> Prompting = fast, RAG = knowledge, fine-tuning = control.

**Level 2:**

* Prompt → behavior
* RAG → data grounding
* Fine-tuning → specialization

**Level 3:**

> I prefer **RAG + prompt engineering** before fine-tuning due to cost and flexibility.

---

# 🔧 SECTION 4 — MLOps / LLMOps

---

## ❓ What is LLMOps?

### ✅ Answer

**Level 1:**

> Managing the lifecycle of LLM-based systems in production.

**Level 2:**

* prompt versioning
* workflow versioning
* monitoring
* evaluation

**Level 3:**

> Unlike ML, we manage **behavioral systems, not just models**.

---

## ❓ What do you version in GenAI systems?

### ✅ Answer

**Level 1:**

> Everything that affects behavior.

**Level 2:**

* prompts
* models
* workflows
* retrieval configs
* tool interfaces

**Level 3:**

> Prompt versioning is as critical as model versioning.

---

## ❓ How do you deploy safely?

### ✅ Answer

**Level 1:**

> Progressive rollout strategies.

**Level 2:**

* shadow deployment
* canary
* A/B testing

**Level 3:**

> Rollback must be instant because behavior is non-deterministic.

---
