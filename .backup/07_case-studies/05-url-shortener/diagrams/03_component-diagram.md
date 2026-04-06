# URL Shortener - C4 Level 3: Component Details

## Component Diagram - Short URL Service

This diagram shows the internal components of the Short URL Service container.

```mermaid
C4Component
    title Component Diagram - Short URL Service

    Container(shortUrlService, "Short URL Service", "Java/Python/.NET", "Core business logic")
    
    Component(apiController, "API Controller", "REST/gRPC", "Handles HTTP requests")
    Component(urlHandler, "URL Handler", "Business Logic", "URL shortening and redirection logic")
    Component(tokenManager, "Token Manager", "Business Logic", "Manages token ranges and generation")
    Component(cacheClient, "Cache Client", "Redis Client", "Cache operations")
    Component(dbClient, "Database Client", "Cassandra Driver", "Database operations")
    Component(analyticsClient, "Analytics Client", "Kafka Producer", "Publishes analytics events")
    Component(base62Encoder, "Base62 Encoder", "Utility", "Converts numeric tokens to base-62 strings")

    Rel(apiController, urlHandler, "Delegates to")
    Rel(urlHandler, tokenManager, "Gets next token")
    Rel(urlHandler, base62Encoder, "Encodes token")
    Rel(urlHandler, cacheClient, "Reads/writes cache")
    Rel(urlHandler, dbClient, "Stores/retrieves mappings")
    Rel(urlHandler, analyticsClient, "Publishes events")
    Rel(tokenManager, dbClient, "Queries token service")
```

## ASCII Fallback

```text
┌─────────────────────────────────────┐
│   Short URL Service Container       │
│                                     │
│  ┌──────────────┐                  │
│  │ API Controller│                  │
│  └──────┬───────┘                  │
│         │                           │
│         ▼                           │
│  ┌──────────────┐                  │
│  │ URL Handler  │                  │
│  └──┬───────┬───┘                  │
│     │       │                       │
│     ├───────┼───────┬───────────────┤
│     │       │       │               │
│     ▼       ▼       ▼               │
│  ┌─────┐ ┌─────┐ ┌──────────────┐ │
│  │Token│ │Base │ │   Analytics  │ │
│  │Mgr  │ │62   │ │   Client     │ │
│  └──┬──┘ │Enc  │ └──────────────┘ │
│     │    └─────┘                  │
│     │                              │
│     ├──────────┬───────────────────┤
│     │          │                   │
│     ▼          ▼                   │
│  ┌──────┐  ┌──────────┐           │
│  │Cache │  │Database  │           │
│  │Client│  │ Client   │           │
│  └──────┘  └──────────┘           │
└─────────────────────────────────────┘
```

## Component Descriptions

**API Controller**: Handles incoming HTTP/gRPC requests, validates input, and returns responses.

**URL Handler**: Core business logic component that:

- Processes URL shortening requests
- Handles URL redirection requests
- Coordinates with other components

**Token Manager**: Manages token ranges:

- Tracks current token range
- Requests new ranges from Token Service when needed
- Provides next available token

**Base62 Encoder**: Utility component that converts numeric tokens to base-62 encoded strings.

**Cache Client**: Wrapper around Redis client for cache operations (get, set, delete).

**Database Client**: Wrapper around Cassandra driver for database operations (insert, select).

**Analytics Client**: Kafka producer for publishing analytics events asynchronously.

---

*Previous: [Container Diagram](./02_container-diagram.md) | Next: [Sequence Diagrams](./sequence-diagrams/)*
