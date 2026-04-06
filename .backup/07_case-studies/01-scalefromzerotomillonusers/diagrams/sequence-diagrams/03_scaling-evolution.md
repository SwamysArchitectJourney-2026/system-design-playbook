# Scaling Evolution - Sequence Diagram

## Infrastructure Evolution Across Phases

This diagram shows how the system architecture evolves as user base grows.

```mermaid
sequenceDiagram
    participant Users
    participant Phase1 as Phase 1: Single Server
    participant Phase2 as Phase 2: + Replicas
    participant Phase3 as Phase 3: + Load Balancer
    participant Phase4 as Phase 4: Microservices

    Note over Users,Phase1: 0-1K Users: Monolithic
    Users->>Phase1: All requests
    Phase1->>Phase1: Single server handles everything
    
    Note over Users,Phase2: 1K-100K Users: + Read Replicas
    Users->>Phase2: All requests
    Phase2->>Phase2: Primary DB (writes)
    Phase2->>Phase2: Read Replicas (reads)
    
    Note over Users,Phase3: 100K-1M Users: Horizontal Scaling
    Users->>Phase3: Requests distributed
    Phase3->>Phase3: Load Balancer
    Phase3->>Phase3: Multiple App Servers
    Phase3->>Phase3: Cache Layer
    Phase3->>Phase3: Database Cluster
    
    Note over Users,Phase4: 1M+ Users: Distributed
    Users->>Phase4: Global requests
    Phase4->>Phase4: API Gateway
    Phase4->>Phase4: Microservices
    Phase4->>Phase4: Service Mesh
    Phase4->>Phase4: Distributed DBs
    Phase4->>Phase4: Global CDN
```

## ASCII Fallback

```text
Phase 1 (0-1K Users): Monolithic
┌─────────────────────────────────┐
│  Users                          │
│     │                           │
│     ▼                           │
│  ┌──────────────┐               │
│  │ Single Server│               │
│  │ (App + DB)   │               │
│  └──────────────┘               │
└─────────────────────────────────┘

Phase 2 (1K-100K Users): + Read Replicas
┌─────────────────────────────────┐
│  Users                          │
│     │                           │
│     ▼                           │
│  ┌──────────────┐               │
│  │ App Server   │               │
│  └──────┬───────┘               │
│         │                       │
│    ┌────▼────┐  ┌──────────┐   │
│    │Primary  │  │  Read    │   │
│    │   DB    │  │ Replicas │   │
│    └─────────┘  └──────────┘   │
└─────────────────────────────────┘

Phase 3 (100K-1M Users): Horizontal Scaling
┌─────────────────────────────────┐
│  Users                          │
│     │                           │
│     ▼                           │
│  ┌──────────────┐               │
│  │Load Balancer │               │
│  └──────┬───────┘               │
│         │                       │
│    ┌────▼────┐  ┌──────────┐   │
│    │ App     │  │  App     │   │
│    │Server 1 │  │Server 2  │   │
│    └────┬────┘  └────┬─────┘   │
│         │            │          │
│    ┌────▼────────────▼────┐   │
│    │   Cache (Redis)       │   │
│    └────┬──────────────────┘   │
│         │                       │
│    ┌────▼──────────────┐       │
│    │  Database Cluster │       │
│    └───────────────────┘       │
└─────────────────────────────────┘

Phase 4 (1M+ Users): Microservices
┌─────────────────────────────────┐
│  Users                          │
│     │                           │
│     ▼                           │
│  ┌──────────────┐               │
│  │ API Gateway  │               │
│  └──────┬───────┘               │
│         │                       │
│    ┌────▼────┐  ┌──────────┐   │
│    │ User    │  │  Data    │   │
│    │ Service │  │ Service  │   │
│    └─────────┘  └──────────┘   │
│         │            │          │
│    ┌────▼────────────▼────┐   │
│    │  Service Mesh        │   │
│    └────┬─────────────────┘   │
│         │                       │
│    ┌────▼──────────────┐       │
│    │ Distributed DBs   │       │
│    └───────────────────┘       │
└─────────────────────────────────┘
```

## Evolution Timeline

### Phase 1 → Phase 2

**Trigger**: Database becomes bottleneck
**Changes**:

- Add read replicas
- Separate read and write operations
- Basic caching

### Phase 2 → Phase 3

**Trigger**: Single server can't handle load
**Changes**:

- Add load balancer
- Multiple application servers
- Distributed cache
- Database sharding or clustering

### Phase 3 → Phase 4

**Trigger**: Monolith limits independent scaling
**Changes**:

- Break into microservices
- API Gateway
- Service mesh
- Event-driven architecture
- Global distribution

## Key Metrics at Each Phase

| Phase | Users | QPS | Latency | Availability | Cost/Month |
| ----- | ----- | --- | ------- | ------------ | ---------- |
| 1 | 1K | 100 | <200ms | 99% | $50-100 |
| 2 | 100K | 1K | <150ms | 99.5% | $300-500 |
| 3 | 1M | 10K | <100ms | 99.9% | $2K-5K |
| 4 | 10M+ | 100K+ | <50ms | 99.99% | $20K-50K+ |

## Migration Strategy

- **Gradual Migration**: Don't jump phases, evolve gradually
- **Feature Flags**: Use feature flags to test new architecture
- **Canary Deployments**: Roll out changes incrementally
- **Monitoring**: Monitor metrics during transitions
- **Rollback Plan**: Always have a rollback strategy

> **Evaluation Note**:  
> Skipping phases is a common mistake. Each phase exists to solve a specific bottleneck, not to follow trends. Jumping straight to microservices (Phase 4) without solving Phase 2-3 bottlenecks shows lack of practical engineering judgment.

## Evaluator Lens

This evolution demonstrates:

- **Gradual scaling approach**: Solve one bottleneck at a time
- **Metrics-driven decisions**: Each phase triggered by specific metrics (QPS, latency, cost)
- **Cost optimization**: Start simple, scale as needed
- **Realistic migration**: Acknowledges that systems evolve, don't start at scale
- **Production thinking**: Considers operational complexity at each phase

**What evaluators look for**:
- ✅ Understanding that Phase 1 is valid for small scale
- ✅ Clear triggers for each phase transition
- ✅ Cost awareness (not over-engineering)
- ✅ Migration strategy (not just final architecture)
- ❌ Jumping to microservices too early
- ❌ Ignoring cost implications
- ❌ No migration plan