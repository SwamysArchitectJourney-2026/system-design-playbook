# Content Index

This document provides a comprehensive index of all topics covered in this repository, organized by category.

---

## 📚 Table of Contents

1. [Introduction & Getting Started](#introduction--getting-started)
2. [Preparation](#preparation)
3. [Foundational Concepts](#foundational-concepts)
4. [System Design Principles](#system-design-principles)
5. [Building Blocks](#building-blocks)
6. [Architectural Patterns](#architectural-patterns)
7. [Case Studies](#case-studies)
8. [Failure Analysis](#failure-analysis)
9. [AI & ML Systems](#ai--ml-systems)
10. [References](#references)

---

## Introduction & Getting Started

- [Introduction to Modern System Design](01_introduction/01_modern-system-design.md)
- [Why Learn System Design](01_introduction/02_why-learn-system-design.md)
- [Learning Structure](01_introduction/03_learning-structure.md)

## Preparation

- [Getting Ready for System Design Evaluations](02_evaluation-prep/01_getting-ready.md)
- [High-Level vs Low-Level Design (HLD vs LLD)](02_evaluation-prep/06_hld-vs-lld.md)
- [Do's and Don'ts](02_evaluation-prep/02_dos-and-donts.md)
- [Preparation Timeline](02_evaluation-prep/03_preparation-timeline.md)
- [Mock Evaluation Strategies](02_evaluation-prep/04_mock-interviews.md)
- [AI Evaluation Tools](02_evaluation-prep/05_ai-evaluation.md)

## Foundational Concepts

- [Abstractions in System Design](03_foundations/01_abstractions.md)
- [Network Abstractions: RPC (Part 1)](03_foundations/02_network-abstractions-part1.md)
- [Consistency Models (Part 1)](03_foundations/03_consistency-models-part1.md)
- [Failure Models (Part 1)](03_foundations/04_failure-models-part1.md)
- [Back-of-the-Envelope Calculations (Part 1)](03_foundations/05_back-of-envelope-part1.md)
- [C4 Model for System Design (Part 1)](03_foundations/06_c4-diagrams-part1.md)
- [Request Flow and Basic Architecture (Part 1)](03_foundations/07_request-flow-and-basic-architecture-part1.md)
- [Request Flow and Basic Architecture (Part 2)](03_foundations/07_request-flow-and-basic-architecture-part2.md)

## System Design Principles

- [Availability](04_principles/01_availability.md)
- [Reliability](04_principles/02_reliability.md)
- [Scalability](04_principles/03_scalability.md) - Vertical vs Horizontal Scaling
- [Maintainability](04_principles/06_maintainability.md)
- [Fault Tolerance](04_principles/05_fault-tolerance.md)
- [Consistency](04_principles/04_consistency.md)
- [Security](04_principles/07_security.md)

## Building Blocks

### Core Infrastructure

- [Domain Name System (DNS)](05_building-blocks/01_dns.md)
- [Load Balancers](05_building-blocks/02_load-balancers.md)
- [Databases](05_building-blocks/03_databases-part1.md)

### Storage Systems

- [Key-Value Store](05_building-blocks/04_key-value-store.md)
- [Object/Blob Storage](05_building-blocks/11_object-storage.md)
- [Content Delivery Network (CDN)](05_building-blocks/05_cdn.md)

### Communication & Messaging

- [Message Queues](05_building-blocks/09_message-queues.md)
- [Pub-Sub Systems](05_building-blocks/10_pub-sub.md)

### Specialized Systems

- [Distributed Cache](05_building-blocks/08_distributed-cache.md)
- [Sequencer (Unique ID Generator)](05_building-blocks/06_sequencer.md)
- [Distributed Search](05_building-blocks/12_search.md)
- [Distributed Logging](05_building-blocks/13_distributed-logging.md)
- [Distributed Monitoring](05_building-blocks/07_monitoring.md)
- [Task Scheduler](05_building-blocks/14_task-scheduler.md)
- [Sharded Counters](05_building-blocks/15_sharded-counters.md)

## Architectural Patterns

- [Caching Patterns](06_patterns/01_caching.md)
- [Rate Limiting](06_patterns/02_rate-limiting.md)
- [Circuit Breaker](06_patterns/03_circuit-breaker.md)
- [CQRS](06_patterns/04_cqrs.md)
- [Event-Driven Architecture](06_patterns/05_event-driven.md)

## Case Studies

### Fundamentals

- [Scale from Zero to Million Users](07_case-studies/01-scalefromzerotomillonusers/)
- [Rate Limiter](07_case-studies/02-rate-limiter/)
- [Consistent Hashing](07_case-studies/03-consistenthashing/)
- [Unique ID Generator](07_case-studies/04-uniqueidgenerator/)
- [URL Shortener (TinyURL)](07_case-studies/05-url-shortener/)

### Communication & Social

- [WhatsApp](07_case-studies/whatsapp/)
- [Twitter](07_case-studies/twitter/)
- [Instagram](07_case-studies/instagram/)
- [Newsfeed System](07_case-studies/newsfeed/)

### Media & Content

- [YouTube](07_case-studies/youtube/)
- [Web Crawler](07_case-studies/web-crawler/)
- [Live Streaming](07_case-studies/livestreaming/)
- [Video Conferencing](07_case-studies/videoconferencing/)

### Services & Platforms

- [Uber](07_case-studies/uber/)
- [Google Maps](07_case-studies/google-maps/)
- [Yelp (Proximity Service)](07_case-studies/yelp/)
- [Quora](07_case-studies/quora/)

### Productivity & Tools

- [Google Docs (Collaborative Editing)](07_case-studies/google-docs/)
- [Typeahead Suggestion](07_case-studies/typeahead/)
- [Deployment System](07_case-studies/deployment/)

### Financial & AI

- [Payment System](07_case-studies/payment/)
- [ChatGPT System](07_case-studies/chatgpt/)

## Failure Analysis

- [Introduction to System Failures](08_failures/01_introduction.md)
- [Facebook/WhatsApp/Instagram Outage](08_failures/02_facebook-outage.md)
- [AWS Kinesis Outage](08_failures/03_aws-kinesis-outage.md)
- [AWS Outages](08_failures/04_aws-outage.md)
- [Lessons Learned](08_failures/05_lessons-learned.md)

## AI & ML Systems

- [AI & ML Systems in Practice](09_ai-ml-systems/README.md)
- [MLOps Foundations](09_ai-ml-systems/01_mlops-foundations.md)
- [LLMOps Foundations](09_ai-ml-systems/02_llmops-foundations.md)
- [PromptOps Patterns](09_ai-ml-systems/03_promptops-patterns.md)

## References

- [Recommended Books](references/books.md)
- [Research Papers](references/papers.md)
- [Tools & Resources](references/tools.md)

---

## Learning Path Recommendations

### Beginner Path

1. Introduction & Getting Started
2. Foundational Concepts
3. System Design Principles
4. Core Building Blocks (DNS, Load Balancers, Databases)
5. Simple Case Study (URL Shortener)

### Intermediate Path

1. All Building Blocks
2. Architectural Patterns
3. Medium Complexity Case Studies (Twitter, Instagram)
4. Failure Analysis

### Advanced Path

1. Complex Case Studies (YouTube, Uber, ChatGPT)
2. Advanced Patterns (CQRS, Event-Driven)
3. Real-world Failure Analysis
4. Preparation & Mock Evaluations

---

Last Updated: December 19, 2025
