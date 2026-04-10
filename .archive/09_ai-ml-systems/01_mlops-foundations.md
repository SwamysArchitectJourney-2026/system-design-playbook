---
learning_level: "Intermediate"
prerequisites: ["Basic ML concepts", "System design fundamentals"]
estimated_time: "25 minutes"
learning_objectives:
  - "Describe the end-to-end lifecycle of an ML system in production"
  - "Identify the core components of an MLOps platform"
  - "Explain how MLOps extends DevOps with data and model concerns"
related_topics:
  prerequisites:
    - ../03_foundations/01_abstractions.md
    - ../03_foundations/05_back-of-envelope-part1.md
  builds_upon:
    - ../05_building-blocks/03_databases-part1.md
    - ../05_building-blocks/09_message-queues.md
  enables:
    - ./02_llmops-foundations.md
    - ./03_promptops-patterns.md
  cross_refs: []
---

# MLOps Foundations

## What Is MLOps?

MLOps is the application of **DevOps principles to machine learning systems**, with extra focus on **data, models, and experiments**.
It covers how teams **build, train, deploy, and monitor** models reliably in production.

Key questions MLOps answers:

- How do we move from a notebook experiment to a reliable service?
- How do we keep models and data versions traceable?
- How do we monitor model quality over time?

## The ML System Lifecycle

At a high level, an ML system goes through these stages:

1. **Data Collection & Ingestion**: Gather raw data from logs, events, databases, or third-party sources.
2. **Data Processing & Feature Engineering**: Clean data, build features, and validate quality.
3. **Training & Validation**: Train models, run experiments, and select candidates.
4. **Model Packaging & Registry**: Package models for deployment and register versions with metadata.
5. **Deployment**:
   - Online inference (real-time APIs)
   - Batch inference (offline scoring)
6. **Monitoring & Feedback**:
   - Track performance, drift, and failures
   - Trigger retraining or rollback when needed.

## Core MLOps Components

- **Data Pipelines**:
  - Move data from sources to feature computation.
  - Often built on batch processing and/or streaming systems.

- **Feature Store**:
  - Central place to define, compute, and serve features.
  - Ensures **consistency** between training and inference.

- **Model Registry**:
  - Tracks model versions, metadata, and approval status.
  - Forms the source of truth for what can be deployed.

- **Serving Layer**:
  - Online services (low-latency APIs) or batch jobs.
  - Integrates with existing system design building blocks (load balancers, caches, queues).

## How MLOps Extends DevOps

Compared to classic DevOps, MLOps must handle:

- **Data versioning** (not just code)
- **Model versioning and lineage**
- **Experiment tracking** (hyperparameters, metrics, artifacts)
- **Model-specific monitoring**:
  - Data quality
  - Prediction quality
  - Drift in distributions over time.

In designs, call out:

- Where data flows and how you track versions.
- How models move from “candidate” to “production”.
- How you roll back or roll forward models safely.


