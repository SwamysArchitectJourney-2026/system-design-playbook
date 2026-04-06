# URL Shortener - C4 Level 2: Container Architecture

## Container Diagram

The container diagram shows the high-level technical building blocks (containers) that make up the URL Shortener system.

```mermaid
C4Container
    title Container Diagram - URL Shortener

    Person(user, "User", "Wants to shorten URLs and access shortened URLs")
    
    System_Boundary(urlShortener, "URL Shortener System") {
        Container(webApp, "Web Application", "React/Next.js", "User interface for creating and managing short URLs")
        Container(apiGateway, "API Gateway", "Kong/Nginx", "Routes requests, handles rate limiting")
        Container(shortUrlService, "Short URL Service", "Java/Python/.NET", "Core business logic for URL shortening and redirection")
        Container(tokenService, "Token Service", "Java/Python/.NET", "Generates unique token ranges for short URLs")
        Container(cache, "Cache", "Redis", "Caches frequently accessed URL mappings")
        ContainerDb(cassandra, "URL Database", "Cassandra", "Stores URL mappings (short URL → long URL)")
        ContainerDb(mysql, "Token Database", "MySQL", "Stores token range assignments")
        Container(analytics, "Analytics Service", "Kafka/Spark", "Processes analytics events")
    }
    
    System_Ext(cdn, "CDN", "CloudFlare/AWS CloudFront")
    System_Ext(monitoring, "Monitoring", "Prometheus/Grafana")

    Rel(user, webApp, "Uses", "HTTPS")
    Rel(user, cdn, "Accesses short URLs", "HTTPS")
    Rel(webApp, apiGateway, "Makes API calls", "HTTPS")
    Rel(apiGateway, shortUrlService, "Routes requests", "HTTP/gRPC")
    Rel(shortUrlService, tokenService, "Requests token ranges", "HTTP/gRPC")
    Rel(shortUrlService, cache, "Reads/writes cache", "Redis Protocol")
    Rel(shortUrlService, cassandra, "Stores/retrieves URL mappings", "CQL")
    Rel(tokenService, mysql, "Stores token ranges", "SQL")
    Rel(shortUrlService, analytics, "Publishes events", "Kafka")
    Rel(cdn, shortUrlService, "Fetches redirects on cache miss", "HTTPS")
    Rel(shortUrlService, monitoring, "Sends metrics", "HTTP")
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
└────┬─────┘      └────┬────┘
     │                 │
     ▼                 │
┌──────────────┐       │
│ API Gateway  │       │
└──────┬───────┘       │
       │               │
       ▼               │
┌──────────────────────┴──────┐
│  Short URL Service           │
└──────┬───────────────────────┘
       │
       ├──────────┬──────────┬──────────┐
       │          │          │          │
       ▼          ▼          ▼          ▼
┌─────────┐ ┌──────────┐ ┌──────┐ ┌──────────┐
│  Cache  │ │Cassandra │ │Token │ │Analytics│
│ (Redis) │ │ Database │ │  Svc  │ │ Service │
└─────────┘ └──────────┘ └───┬──┘ └──────────┘
                             │
                             ▼
                        ┌─────────┐
                        │  MySQL  │
                        │Database │
                        └─────────┘
```

## Container Descriptions

**Web Application**: User-facing web interface for creating and managing short URLs.

**API Gateway**: Entry point that handles routing, rate limiting, authentication, and load balancing.

**Short URL Service**: Core service that:

- Generates short URLs from token ranges
- Stores URL mappings
- Retrieves long URLs for redirection
- Publishes analytics events

**Token Service**: Service that assigns unique token ranges to Short URL Service instances.

**Cache (Redis)**: In-memory cache for frequently accessed URL mappings to reduce database load.

**URL Database (Cassandra)**: Primary storage for URL mappings, optimized for high write throughput and horizontal scaling.

**Token Database (MySQL)**: Relational database for token range assignments, ensuring ACID guarantees.

**Analytics Service**: Processes analytics events from Kafka and generates reports.

---

*Previous: [Context Diagram](./01_context-diagram.md) | Next: [Component Diagram](./03_component-diagram.md)*
