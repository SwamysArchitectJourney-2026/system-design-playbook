---
learning_level: "Intermediate"
prerequisites: ["Basic understanding of distributed systems", "System design fundamentals"]
estimated_time: "25 minutes"
learning_objectives:
  - "Understand different types of failures in distributed systems"
  - "Apply failure detection and recovery strategies"
  - "Design systems that gracefully handle failures"
related_topics:
  prerequisites:
    - ./01_abstractions.md
    - ./02_network-abstractions-part1.md
  builds_upon:
    - ./03_consistency-models-part1.md
  enables:
    - ./04_failure-models-part2.md
    - ../04_principles/05_fault-tolerance.md
    - ../08_failures/01_introduction.md
  cross_refs: []
---

# The Spectrum of Failure Models (Part 1)

## Why Failure Models Matter

In distributed systems, **failures are not exceptions—they are expected**. Understanding failure models helps you:

- Design systems that continue operating despite failures
- Choose appropriate fault tolerance strategies
- Set realistic expectations for system behavior
- Plan for recovery and mitigation

## Types of Failures

### 1. Crash Failures

**Definition**: A component stops responding completely.

**Characteristics**:
- Component stops processing requests
- No output, no response
- Easy to detect (timeout)

**Example**: Server process crashes, database connection lost.

**Detection**: Timeouts, health checks, heartbeat mechanisms.

### 2. Omission Failures

**Definition**: Component fails to send or receive messages.

**Types**:
- **Send omission**: Message not sent
- **Receive omission**: Message not received

**Example**: Network packet loss, message queue drops message.

**Detection**: Message acknowledgments, sequence numbers.

### 3. Timing Failures

**Definition**: Component responds, but outside expected time window.

**Characteristics**:
- Response arrives too late
- System appears slow or unresponsive
- May be mistaken for crash failure

**Example**: Database query takes 30 seconds instead of 100ms.

**Detection**: Timeouts, latency monitoring, SLAs.

### 4. Byzantine Failures

**Definition**: Component behaves arbitrarily or maliciously.

**Characteristics**:
- Sends incorrect data
- Lies about state
- Behaves inconsistently
- Hardest to detect and handle

**Example**: Compromised server sends wrong data, malicious node in consensus.

**Detection**: Cryptographic verification, consensus protocols, redundancy.

## Failure Detection

### Heartbeat Mechanism

**How it works**:
- Components send periodic "I'm alive" messages
- If heartbeat stops, component is considered failed

**Trade-offs**:
- ✅ Simple to implement
- ❌ Network issues can cause false positives
- ❌ Detection delay (must wait for timeout)

### Health Checks

**How it works**:
- External monitor periodically checks component health
- Component responds with status (healthy/unhealthy)

**Trade-offs**:
- ✅ Can check actual functionality, not just liveness
- ❌ Adds load to system
- ❌ May miss transient issues

### Timeout-Based Detection

**How it works**:
- If response doesn't arrive within timeout, assume failure

**Trade-offs**:
- ✅ Simple, built into most systems
- ❌ Must choose timeout carefully (too short = false positives, too long = slow detection)

---

*Next: Continue with [Failure Recovery Strategies and Design Patterns](./04_failure-models-part2.md).*
