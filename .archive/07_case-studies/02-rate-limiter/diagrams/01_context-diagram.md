# Rate Limiter - System Context Diagram

## System Context (C4 Level 1)

This diagram shows the Rate Limiter system and its interactions with users and external systems.

```mermaid
C4Context
    title System Context Diagram - Rate Limiter

    Person(developer, "Developer", "Uses rate limiter API to enforce rate limits")
    System(rateLimiter, "Rate Limiter", "Provides distributed rate limiting services")
    System_Ext(application, "Application Services", "Services that use rate limiter")
    System_Ext(redis, "Redis Cluster", "Distributed counter storage")
    System_Ext(database, "Configuration Database", "Stores rate limit rules and policies")
    System_Ext(monitoring, "Monitoring System", "Metrics and logging infrastructure")

    Rel(developer, rateLimiter, "Configures rate limits", "HTTPS/API")
    Rel(application, rateLimiter, "Checks rate limits", "HTTP/gRPC")
    Rel(rateLimiter, redis, "Stores/retrieves counters", "Redis Protocol")
    Rel(rateLimiter, database, "Reads configuration", "SQL")
    Rel(rateLimiter, monitoring, "Sends metrics and logs", "HTTP")
```

## ASCII Fallback

```text
┌──────────┐
│ Developer│
└────┬─────┘
     │ Configures
     │
     ▼
┌─────────────────┐
│  Rate Limiter   │
│     System       │
└───┬─────────┬───┘
    │         │
    │         │
    ▼         ▼
┌─────────┐ ┌──────────────┐
│  Redis  │ │ Configuration│
│ Cluster │ │   Database   │
└─────────┘ └──────────────┘
    │
    │
    ▼
┌─────────────────┐
│   Application   │
│    Services     │
└─────────────────┘
```

## Key Relationships

- **Developers** configure rate limits via API
- **Application Services** check rate limits for incoming requests
- **Rate Limiter** uses Redis for distributed counter storage
- **Rate Limiter** reads configuration from database
- **Rate Limiter** sends metrics and logs to monitoring system

## External Systems

- **Application Services**: Services that need rate limiting (APIs, microservices)
- **Redis Cluster**: Distributed storage for rate limit counters
- **Configuration Database**: Stores rate limit rules and policies
- **Monitoring System**: Collects metrics, logs, and traces
