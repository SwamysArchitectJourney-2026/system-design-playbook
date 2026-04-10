# Scale from Zero to Million Users - Container Diagram

## Container Diagram (Phase 3-4 Architecture)

This diagram shows the high-level technical building blocks (containers) that make up the system at scale.

```mermaid
C4Container
    title Container Diagram - Scale from Zero to Million Users (Phase 3-4)

    Person(user, "User", "End user accessing the application")
    
    System_Boundary(appSystem, "Application System") {
        Container(webApp, "Web Application", "React/Next.js", "User interface")
        Container(apiGateway, "API Gateway", "Kong/Nginx", "Routes requests, rate limiting, authentication")
        Container(appService, "Application Service", "Java/Python/.NET", "Core business logic")
        Container(cache, "Cache", "Redis", "Distributed cache for frequently accessed data")
        ContainerDb(primaryDb, "Primary Database", "MySQL/PostgreSQL", "Primary database for writes")
        ContainerDb(readReplica, "Read Replica", "MySQL/PostgreSQL", "Read replicas for scaling reads")
        Container(messageQueue, "Message Queue", "Kafka/RabbitMQ", "Async processing and event streaming")
    }
    
    System_Ext(cdn, "CDN", "CloudFlare/AWS CloudFront", "Serves static content")
    System_Ext(monitoring, "Monitoring", "Prometheus/Grafana", "Metrics and monitoring")
    System_Ext(authProvider, "Auth Provider", "OAuth/OIDC", "External authentication")

    Rel(user, webApp, "Uses", "HTTPS")
    Rel(user, cdn, "Accesses static content", "HTTPS")
    Rel(webApp, apiGateway, "Makes API calls", "HTTPS")
    Rel(apiGateway, authProvider, "Authenticates", "OAuth/OIDC")
    Rel(apiGateway, appService, "Routes requests", "HTTP/gRPC")
    Rel(appService, cache, "Reads/writes cache", "Redis Protocol")
    Rel(appService, primaryDb, "Writes data", "SQL")
    Rel(appService, readReplica, "Reads data", "SQL")
    Rel(appService, messageQueue, "Publishes events", "Kafka Protocol")
    Rel(cdn, appService, "Fetches dynamic content on cache miss", "HTTPS")
    Rel(appService, monitoring, "Sends metrics", "HTTP")
```

## ASCII Fallback

```text
┌─────────┐
│  User   │
└────┬────┘
     │
     ├─────────────────┐
     │                 │
     ▼                 ▼
┌──────────┐      ┌─────────┐
│ Web App  │      │   CDN   │
└────┬─────┘      └─────────┘
     │
     ▼
┌─────────────────┐
│  API Gateway    │
└────────┬────────┘
     │
     ├──► Auth Provider
     │
     ▼
┌─────────────────┐
│ Application     │
│ Service         │
└────┬────────────┘
     │
     ├──► Cache (Redis)
     ├──► Primary DB (writes)
     ├──► Read Replica (reads)
     └──► Message Queue
```

## Phase Evolution

### Phase 1: Single Container

- Application + Database on single server

### Phase 2: Basic Separation

- Application Server
- Database + Read Replicas
- Basic Cache

### Phase 3: Distributed Containers

- Multiple Application Servers
- Load Balancer
- Database Cluster
- Distributed Cache
- Message Queue

### Phase 4: Microservices

- Multiple Services
- API Gateway
- Service Mesh
- Distributed Databases
- Event Streaming

## Trust Boundaries

**Public Edge**:
- API Gateway (exposed to internet, handles authentication and rate limiting)

**Private Network**:
- Application Service (internal only, not directly accessible)
- Database (private subnet, no public access)
- Cache (internal network only)
- Message Queue (internal service-to-service communication)

**External Services**:
- CDN (edge network, public-facing)
- Auth Provider (third-party, public API)
- Monitoring (internal metrics, may use VPN)

## Key Containers

1. **Web Application**: User interface layer
2. **API Gateway**: Entry point, routing, rate limiting
3. **Application Service**: Core business logic
4. **Cache**: High-speed data access
5. **Database**: Persistent data storage
6. **Message Queue**: Async processing and events

## Evaluator Lens

This diagram demonstrates:

- **Clear separation of concerns**: Each container has a specific responsibility
- **Security boundaries**: Public edge (API Gateway) vs private internal services
- **Scalability patterns**: Read replicas for read scaling, cache for performance
- **Event-driven architecture**: Message queue enables async processing
- **Monitoring integration**: Observability built into the architecture

**Common candidate mistakes to avoid**:
- ❌ Exposing internal services directly to internet
- ❌ Missing rate limiting at gateway
- ❌ Not separating read and write paths
- ❌ Forgetting monitoring and observability
