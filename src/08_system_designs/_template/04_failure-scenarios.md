---
learning_level: "Intermediate"
estimated_time: "15 minutes"
learning_objectives:
  - "Walk failure modes with user-visible behavior and recovery"
---

# Failure scenarios — [system name]

## Invariants (must never break)

- e.g. no double charge, no lost acknowledged write, …

## Scenario table

| Failure | Symptom | Detection | Mitigation | User sees |
|---------|---------|-----------|------------|-----------|

## Deep dives (pick two for rehearsal)

### 1. Dependency timeout / ambiguous result

### 2. Partition or replica lag

### 3. Poison messages / DLQ

## Reconciliation

- What job or process realigns truth with external systems?
- How often, and what alerts fire?
