# 🔗 SECTION 13 — INTEGRATION & APIs

---

## ❓ How do you design scalable APIs?

### ✅ Answer

**Level 1:**

> I design APIs to be stateless, versioned, and contract-driven.

**Level 2:**

* REST / GraphQL
* idempotency
* pagination
* rate limiting

**Level 3:**

> APIs should enable **independent evolution without breaking consumers**.

---

## ❓ Synchronous vs asynchronous communication?

### ✅ Answer

**Level 1:**

> Sync for immediate response, async for scalability and decoupling.

**Level 2:**

* sync → low latency
* async → resilience, retries

**Level 3:**

> I prefer async to **avoid tight coupling and cascading failures**.

---

## ❓ How do you design integrations in enterprise systems?

### ✅ Answer

**Level 1:**

> Event-driven, loosely coupled integrations.

**Level 2:**

* message queues
* pub/sub
* schema contracts

**Level 3:**

> Avoid point-to-point integrations → leads to **spaghetti architecture**.

---

# 🗄️ SECTION 14 — DATA ARCHITECTURE

---

## ❓ How do you design data architecture?

### ✅ Answer

**Level 1:**

> Based on access patterns and scalability needs.

**Level 2:**

* OLTP vs OLAP
* partitioning
* indexing

**Level 3:**

> Data architecture is driven by **read/write patterns, not technology preference**.

---

## ❓ SQL vs NoSQL?

### ✅ Answer

**Level 1:**

> SQL for consistency, NoSQL for scalability.

**Level 2:**

* SQL → strong consistency
* NoSQL → flexible schema

**Level 3:**

> Choose based on **consistency vs scale trade-offs**.

---

## ❓ How do you handle data consistency?

### ✅ Answer

**Level 1:**

> Choose consistency model based on business need.

**Level 2:**

* strong consistency
* eventual consistency

**Level 3:**

> Most large-scale systems use **eventual consistency with compensation logic**.

---
