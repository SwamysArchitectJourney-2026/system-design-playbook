# Rate Limiter - Container Diagram

## Container Diagram (C4 Level 2)

This diagram shows the high-level technical building blocks (containers) that make up the Rate Limiter system.

```mermaid
C4Container
    title Container Diagram - Rate Limiter

    Person(developer, "Developer", "Configures rate limits")
    System_Ext(application, "Application Services", "Services using rate limiter")
    
    System_Boundary(rateLimiter, "Rate Limiter System") {
        Container(apiGateway, "API Gateway", "Kong/Nginx", "Routes requests, handles authentication")
        Container(rateLimiterService, "Rate Limiter Service", "Java/Python/.NET", "Core rate limiting logic")
        Container(configService, "Configuration Service", "Java/Python/.NET", "Manages rate limit rules")
        Container(cache, "Local Cache", "In-Memory", "Caches configurations and hot counters")
        ContainerDb(redis, "Redis Cluster", "Redis", "Stores rate limit counters")
        ContainerDb(database, "Configuration DB", "MySQL/PostgreSQL", "Stores rate limit rules")
    }
    
    System_Ext(monitoring, "Monitoring", "Prometheus/Grafana", "Metrics and monitoring")

    Rel(developer, apiGateway, "Configures rate limits", "HTTPS")
    Rel(application, apiGateway, "Checks rate limits", "HTTP/gRPC")
    Rel(apiGateway, rateLimiterService, "Routes requests", "HTTP/gRPC")
    Rel(rateLimiterService, configService, "Gets rate limit rules", "HTTP/gRPC")
    Rel(rateLimiterService, cache, "Reads cached data", "In-Memory")
    Rel(rateLimiterService, redis, "Stores/retrieves counters", "Redis Protocol")
    Rel(configService, database, "Reads/writes rules", "SQL")
    Rel(configService, cache, "Updates cache", "In-Memory")
    Rel(rateLimiterService, monitoring, "Sends metrics", "HTTP")
```

## ASCII Fallback

```text
┌──────────┐      ┌─────────────────┐
│Developer │      │   Application   │
│          │      │    Services     │
└────┬─────┘      └────────┬────────┘
     │                     │
     │                     │
     ▼                     ▼
┌─────────────────────────────┐
│      API Gateway            │
└────────────┬────────────────┘
             │
     ┌───────┴────────┐
     │                │
     ▼                ▼
┌──────────┐    ┌──────────────┐
│  Rate    │    │Configuration │
│ Limiter  │    │   Service    │
│ Service  │    └──────┬────────┘
└────┬─────┘           │
     │                 │
     ├────────┬────────┤
     │        │        │
     ▼        ▼        ▼
┌──────┐ ┌────────┐ ┌──────────┐
│Cache │ │ Redis  │ │Database  │
└──────┘ └────────┘ └──────────┘
```

## Key Containers

1. **API Gateway**: Entry point, routing, authentication
2. **Rate Limiter Service**: Core rate limiting logic
3. **Configuration Service**: Manages rate limit rules
4. **Local Cache**: In-memory cache for performance
5. **Redis Cluster**: Distributed counter storage
6. **Configuration Database**: Persistent rule storage

## Container Responsibilities

- **API Gateway**: Routes requests, handles authentication, load balancing
- **Rate Limiter Service**: Executes rate limiting algorithms, makes allow/deny decisions
- **Configuration Service**: Manages rate limit rules, provides configuration API
- **Local Cache**: Caches frequently accessed configurations and counters
- **Redis Cluster**: Stores rate limit counters with TTL, provides atomic operations
- **Configuration Database**: Persists rate limit rules, supports versioning
