---
learning_level: "Intermediate"
estimated_time: "20 minutes"
learning_objectives:
  - "Name components, boundaries, and data paths for a defensible HLD"
---

# High-level design — [system name]

## Verbal diagram (boxes and arrows)

List **every box** and the **direction of data/control** between them (as you would on a whiteboard).

Example pattern (replace with yours):

- Client → API gateway → service A → …

## Components (responsibility per box)

| Component | Responsibility | Critical dependencies |
|-----------|----------------|------------------------|

## Data stores

- Authoritative writes:
- Read-optimized paths (replicas, caches, search):
- What is **strongly consistent** vs **eventually** visible:

## Sync vs async

- What happens in the **request path**:
- What is **queued** or **outboxed** and why:
- Duplicate / retry story at the boundary:

## APIs / events (sketch)

- Key REST or RPC surfaces (names only):
- Key events or topics (if any):

## Diagrams

Link files under `diagrams/` (context, containers, one sequence for happy path).
