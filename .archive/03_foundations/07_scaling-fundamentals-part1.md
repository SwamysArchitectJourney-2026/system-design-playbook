---
learning_level: "Beginner"
prerequisites: ["Basic understanding of web applications", "Familiarity with client-server architecture"]
estimated_time: "25 minutes"
learning_objectives:
  - "Explain why scaling is an iterative journey"
  - "Describe a single-server baseline and its request flow"
  - "Decide when to separate the web and data tiers"
related_topics:
  prerequisites: []
  builds_upon:
    - 01_abstractions.md
    - 02_network-abstractions-part1.md
  enables:
    - ./07_scaling-fundamentals-part2.md
    - ../04_principles/03_scalability.md
  cross_refs:
    - ../05_building-blocks/01_dns.md
    - ../05_building-blocks/02_load-balancers.md
---

# Scaling Fundamentals (Part 1): Start Simple, Then Split Tiers

Scaling to millions of users rarely happens in one leap. Most real systems start small, then evolve as bottlenecks show up in production.

## The mindset

- Start with the simplest architecture that meets today's requirements.
- Measure (latency, error rate, saturation), then change the design.
- Add complexity only when it buys you something: reliability, performance, or cost control.

## Baseline architecture: single server

In a minimal deployment, one machine runs the web app, API, and database.

```mermaid
graph TB
  C[Client: Browser/Mobile] -->|1. DNS lookup| D[DNS]
  C -->|2. HTTP/HTTPS| S[Single Server\nWeb + API + DB]

  style S fill:#e1f5ff
  style D fill:#f0f0f0
```

### ASCII fallback

```text
Client -> DNS (domain -> IP) -> Single Server
                              - Web / API
                              - Database
```

### Why it’s useful

- Fast to build and deploy (great for prototypes/MVPs).
- Easy mental model while you validate the product.

### What breaks first

- Single point of failure: one crash takes everything down.
- Resource contention: CPU, memory, disk I/O, and connections fight each other.
- Scaling ceiling: you can “scale up” only so far.

## Request flow (end to end)

1. User visits a domain like `api.example.com`.
2. DNS resolves it to an IP address.
3. Client sends an HTTP request to the server.
4. Server runs business logic and reads/writes the database.
5. Server returns HTML (web) or JSON (mobile/API clients).

DNS is typically a managed service; your app usually doesn’t host DNS servers.

## Traffic sources: web vs mobile

- Web: server may render HTML, while the browser runs JS.
- Mobile: client typically calls APIs and expects JSON responses.

Example endpoint:

```text
GET /users/12
```

Example response:

```json
{ "id": 12, "name": "Ada", "createdAt": "2025-01-15T10:30:00Z" }
```

## First evolution: split web tier and data tier

When load increases, your first big win is usually separating the application from the database.

```mermaid
graph LR
  C[Client] --> A[Web/API Tier]
  A --> DB[(Database Tier)]

  style A fill:#e1f5ff
  style DB fill:#fff3e0
```

### Benefits

- Independent scaling (add app servers without moving the database).
- Clearer operational boundaries (deploy app without touching data).
- Reduced contention (database gets stable CPU/disk).

### Signals it’s time

- App CPU is high but DB is mostly idle (or vice versa).
- DB latency spikes during traffic bursts.
- Deployments cause frequent downtime.

---

*Next: [Part 2: Database Choices and Scaling Strategies](./07_scaling-fundamentals-part2.md).*
