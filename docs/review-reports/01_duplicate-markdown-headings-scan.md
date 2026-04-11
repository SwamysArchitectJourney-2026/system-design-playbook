---
learning_level: "Intermediate"
prerequisites: []
estimated_time: "10 minutes"
learning_objectives:
  - "Interpret duplicate-heading scan output for deduplication decisions"
---

<!-- markdownlint-disable MD012 -->

# Duplicate markdown headings — scan report

**Generated:** 2026-04-11 (local run). **Tool:** `tools/psscripts/Find-DuplicateContent.ps1` (default `MinOccurrences = 3`).

Headings are matched **case-insensitively**. Repeated titles are **not always harmful** (e.g. shared interview section names across packs); they signal where to consolidate if two docs claim to be the single source of truth for the same topic.

```text
## Scan: `src/` (markdown headings occurring in ≥3 files)


Heading                                      Occurrences Examples
-------                                      ----------- --------
✅ Answer                                              45 complete.md:452, complete.md:469, complete.md:496
Scenario                                              11 principal-enterprise-architect-interview-pack.md:19, principal…
1. Clarify requirements                               10 answer.md:14, answer.md:14, answer.md:14
Evolution                                              9 answer.md:34, answer.md:33, answer.md:35
Clarify                                                9 answer.md:9, answer.md:9, answer.md:9
5. Failure scenarios and mitigations                   8 answer.md:75, answer.md:99, answer.md:70
2. Scale estimation (back-of-envelope)                 8 answer.md:27, answer.md:34, answer.md:22
Based on Template v1.1                                 8 answer-format-enforcement.md:12, answer.md:10, answer.md:10
Evaluation                                             8 principal-enterprise-architect-interview-pack.md:38, principal…
9. Evolution strategy (MVP → scale → global)           8 answer.md:106, answer.md:134, answer.md:102
The Trap:                                              8 complete.md:20, complete.md:37, complete.md:54
11. Observability and operations                       8 answer.md:116, answer.md:144, answer.md:112
10. Security architecture                              8 answer.md:112, answer.md:140, answer.md:108
The Context:                                           8 complete.md:16, complete.md:33, complete.md:50
The Architect's Answer                                 8 complete.md:24, complete.md:41, complete.md:58
7. Key design decisions                                8 answer.md:91, answer.md:116, answer.md:86
8. Trade-offs summary                                  8 answer.md:100, answer.md:128, answer.md:96
12. Cost considerations                                8 answer.md:120, answer.md:148, answer.md:116
6. What breaks first?                                  8 answer.md:83, answer.md:108, answer.md:78
Architecture                                           7 answer.md:17, answer.md:17, answer.md:17
Estimate                                               7 answer.md:13, answer.md:13, answer.md:13
4. Deep dives (pick 2–3 in the room)                   7 answer.md:61, answer.md:82, answer.md:56
3. High-level architecture                             7 answer.md:32, answer.md:44, answer.md:26
Failures                                               6 answer.md:30, answer.md:29, answer.md:31
Deep dives                                             6 answer.md:24, answer.md:24, answer.md:25
Scalability attacks                                    5 followup-attack-bank.md:10, followups.md:5, followups.md:3
Narration walkthrough                                  4 diagram.md:19, diagram.md:32, diagram.md:19
Depth to expect                                        4 principal-enterprise-architect-interview-pack.md:101, principa…
What they should draw                                  4 principal-enterprise-architect-interview-pack.md:23, principal…
Messaging                                              4 failure-scenario-catalog.md:29, service-selection-guide.md:10,…
Caching                                                4 tradeoffs-cheatsheet.md:18, answer.md:84, tradeoffs.md:42
Cost                                                   4 followups-cheatsheet.md:43, followups.md:42, followups.md:58
Cost attacks                                           4 followup-attack-bank.md:44, followups.md:25, followups.md:23
Security                                               4 followups-cheatsheet.md:33, followups.md:36, followups.md:48
Idempotency                                            3 answer.md:67, answer.md:66, 03_idempotency-ledger-and-failure-…
How this differs from nearby folders                   3 README.md:5, README.md:5, README.md:28
Azure depth                                            3 followups.md:48, followups.md:64, followups.md:42
Failure and resilience                                 3 followups.md:20, followups.md:20, followups.md:20
Mindset                                                3 01_production-ai-engineer-skill-map.md:35, 02_gen-ai-lead-comp…
How to practice                                        3 README.md:39, 03_cross-domain-prompt-bank.md:38, 03_cross-doma…
Close                                                  3 gen-ai-lead-spoken-spine.md:26, ai-engineer-spoken-spine.md:29…
Data                                                   3 followups-cheatsheet.md:16, tradeoffs-cheatsheet.md:10, failur…
Scalability and load                                   3 followups.md:30, followups.md:10, followups.md:30
How to use this doc                                    3 06_enterprise-principal-genai-and-ea-themes.md:41, 02_follow-u…
Failure and resilience attacks                         3 followup-attack-bank.md:17, followups.md:10, followups.md:8



## Scan: `docs/`


Heading        Occurrences Examples
-------        ----------- --------
Evaluator Lens           4 03_case-study-template.md:210, 03_case-study-template.md:269, 03_case-study-template.md:438



## Scan: `.archive/` (historical corpus — expect many repeated lesson titles)


Heading                          Occurrences Examples
-------                          ----------- --------
ASCII Fallback                            22 07_request-flow-and-basic-architecture-part1.md:53, 07_scaling-fundamental…
Key Takeaways                             16 01_abstractions.md:119, 02_network-abstractions-part2.md:99, 03_consistenc…
Key Topics                                12 01_dns.md:5, 04_key-value-store.md:5, 05_cdn.md:5
Evaluator Lens                            11 01_modern-system-design.md:115, 02_dos-and-donts.md:77, 03_high-level-desi…
Key Takeaway                               9 01_modern-system-design.md:125, 02_why-learn-system-design.md:103, 03_lear…
Non-Functional Requirements                8 01_requirements.md:10, 01_requirements.md:23, 01_requirements.md:8
Functional Requirements                    8 01_requirements.md:3, 01_requirements.md:3, 01_requirements.md:3
Availability                               6 02_reliability-part1.md:34, 02_reliability.md:34, 06_observability.md:69
Summary                                    6 02_back-of-envelope.md:172, 05_scalability.md:339, 06_observability.md:296
Flow Description                           5 01_user-registration.md:68, 02_data-access.md:91, 01_rate-limit-check.md:98
Scalability                                5 03_scalability.md:20, 01_requirements.md:18, 01_requirements.md:37
Case Study Structure                       4 README.md:47, README.md:9, README.md:9
Architecture                               4 README.md:38, README.md:38, 02_Detailed-Design-Part1-G.md:74
Data Protection                            4 07_security-part2.md:122, 07_security.md:67, 07_security.md:111
Components                                 4 04_phase1-monolithic.md:39, 05_phase2-vertical-scaling.md:55, 06_phase3-ho…
Characteristics                            4 07_request-flow-and-basic-architecture-part1.md:110, 04_phase1-monolithic.…
Horizontal Scaling                         4 02_back-of-envelope.md:160, 03_high-level-design.md:263, 05_scalability.md…
Health Checks                              4 04_failure-models-part1.md:100, 05_fault-tolerance-part2.md:72, 06_observa…
Caching Strategy                           4 03_high-level-design.md:164, 04_low-level-design.md:77, 05_scalability.md:…
Performance Optimizations                  4 04_low-level-design.md:112, 04_low-level-design.md:314, 04_low-level-desig…
Incident Response                          4 07_security.md:144, 06_observability.md:266, 07_security.md:289
Security Monitoring                        4 07_security-part2.md:58, 07_security.md:128, 07_security.md:208
Performance                                4 01_requirements.md:12, 06_observability.md:75, 01_requirements.md:25
Dashboards                                 3 06_observability.md:127, 06_observability.md:175, 06_observability.md:199
Basic Formula                              3 05_back-of-envelope-part1.md:51, 05_back-of-envelope-part1.md:81, 05_back-…
Core Documentation                         3 README.md:11, README.md:11, README.md:11
Diagrams                                   3 README.md:22, README.md:22, README.md:22
Runbooks                                   3 06_maintainability-part2.md:93, 06_observability.md:268, 06_observability.…
Example                                    3 08_performance-metrics.md:183, 02_reliability-part1.md:44, 02_reliability.…
Performance Targets                        3 01_requirements.md:68, 02_back-of-envelope.md:142, 05_scalability.md:319
Related Topics                             3 README.md:62, README.md:73, README.md:72
Benefits                                   3 01_abstractions.md:82, 07_scaling-fundamentals-part1.md:104, 02_distribute…
Abuse Prevention                           3 03_high-level-design.md:299, 07_security.md:142, 07_security.md:191
Architecture Diagram                       3 07_request-flow-and-basic-architecture-part1.md:75, 03_high-level-design.m…
Capacity Planning                          3 02_back-of-envelope.md:3, 05_scalability.md:232, 05_scalability.md:135
Key Interactions                           3 01_shortening-flow.md:67, 02_redirection-flow.md:68, 03_token-range-assign…
Strategy 3: Graceful Degradation           3 04_failure-models-part2.md:58, 05_fault-tolerance-part1.md:85, 05_fault-to…
Availability vs Reliability                3 01_availability.md:127, 02_reliability-part1.md:32, 02_reliability.md:32
Compliance                                 3 07_security.md:112, 07_security.md:243, 07_security.md:251
Learning Objectives                        3 README.md:51, README.md:61, README.md:60
Architecture Overview                      3 04_phase1-monolithic.md:3, 05_phase2-vertical-scaling.md:3, 06_phase3-hori…
Overview                                   3 README.md:5, README.md:5, README.md:5
Distributed Rate Limiting                  3 03_high-level-design.md:147, 05_scalability.md:41, 07_security.md:71
Data Privacy                               3 07_security.md:75, 07_security.md:127, 07_security.md:253
Scale Considerations                       3 01_requirements.md:30, 01_requirements.md:53, 01_requirements.md:30
Reliability                                3 02_reliability-part1.md:39, 02_reliability.md:39, 06_observability.md:81
Key Design Highlights                      3 README.md:36, README.md:36, README.md:36
Analysis                                   3 02_facebook-outage.md:5, 03_aws-kinesis-outage.md:5, 04_aws-outage.md:5
```

