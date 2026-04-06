# Scale from Zero to Million Users - Component Diagram

## Component Diagram (Application Service)

This diagram shows the internal components of the Application Service container.

```mermaid
C4Component
    title Component Diagram - Application Service

    Container_Boundary(appService, "Application Service") {
        Component(apiController, "API Controller", "REST/gRPC", "Handles HTTP requests, validates input")
        Component(authService, "Auth Service", "Component", "Handles authentication and authorization")
        Component(businessLogic, "Business Logic", "Component", "Core business rules and workflows")
        Component(dataService, "Data Service", "Component", "Data access layer, handles database operations")
        Component(cacheService, "Cache Service", "Component", "Manages cache operations")
        Component(messageService, "Message Service", "Component", "Publishes and consumes messages")
    }
    
    ContainerDb(cache, "Cache", "Redis")
    ContainerDb(database, "Database", "MySQL/PostgreSQL")
    Container(messageQueue, "Message Queue", "Kafka/RabbitMQ")
    Container(monitoring, "Monitoring", "Prometheus")

    Rel(apiController, authService, "Validates", "Uses")
    Rel(apiController, businessLogic, "Delegates to", "Uses")
    Rel(businessLogic, dataService, "Reads/writes data", "Uses")
    Rel(businessLogic, cacheService, "Checks cache", "Uses")
    Rel(businessLogic, messageService, "Publishes events", "Uses")
    Rel(cacheService, cache, "Reads/writes", "Redis Protocol")
    Rel(dataService, database, "Queries", "SQL")
    Rel(messageService, messageQueue, "Publishes/consumes", "Kafka Protocol")
    Rel(apiController, monitoring, "Sends metrics", "HTTP")
```

## ASCII Fallback

```text
┌─────────────────────────────────┐
│     Application Service         │
│                                 │
│  ┌──────────────┐              │
│  │ API Controller│              │
│  └──────┬───────┘               │
│         │                       │
│    ┌────▼────┐                 │
│    │  Auth   │                 │
│    │ Service │                 │
│    └─────────┘                 │
│         │                       │
│  ┌──────▼──────────┐           │
│  │ Business Logic  │           │
│  └──────┬──────────┘           │
│         │                       │
│    ┌────▼────┐  ┌──────┐       │
│    │  Data  │  │Cache │       │
│    │ Service│  │Service│       │
│    └────┬───┘  └───┬──┘       │
│         │          │           │
│    ┌────▼──────────▼──┐       │
│    │ Message Service  │       │
│    └──────────────────┘       │
└────────┬───────────┬───────────┘
         │           │
    ┌────▼───┐  ┌───▼────┐
    │Database│  │ Cache  │
    └────────┘  └────────┘
         │
    ┌────▼────┐
    │ Message │
    │  Queue  │
    └─────────┘
```

## Component Responsibilities

### API Controller

- Receives HTTP/gRPC requests
- Validates input parameters
- Handles request/response serialization
- Returns appropriate HTTP status codes

### Auth Service

- Validates authentication tokens
- Checks user permissions
- Manages session state
- Integrates with external auth providers

### Business Logic

- Implements core business rules
- Orchestrates workflows
- Validates business constraints
- Coordinates between services

### Data Service

- Abstracts database access
- Implements data access patterns (Repository, DAO)
- Handles transactions
- Manages connection pooling

### Cache Service

- Manages cache operations (get, set, delete)
- Implements cache strategies (cache-aside, write-through)
- Handles cache invalidation
- Manages cache keys and TTLs

### Message Service

- Publishes events to message queue
- Consumes messages from queue
- Handles message serialization
- Implements retry logic

## Component Interactions

1. **Request Flow**: API Controller → Auth Service → Business Logic → Data/Cache Service
2. **Cache Flow**: Business Logic → Cache Service → Cache (if miss, then Data Service → Database)
3. **Event Flow**: Business Logic → Message Service → Message Queue
4. **Monitoring**: All components send metrics to Monitoring system

> **LLD Scope Note**:  
> In evaluations, only one service is decomposed to this level. You don't need to show component diagrams for every service—focus on the most critical or complex service.

## Evaluator Lens

This diagram demonstrates:

- **Clear separation of concerns**: Each component has a single responsibility
- **Layered architecture**: Controller → Business Logic → Data Access pattern
- **Infrastructure abstraction**: Cache and database access abstracted through services
- **Event-driven design**: Message service enables async processing
- **Observability**: Monitoring integrated at component level

**Common candidate mistakes to avoid**:
- ❌ Over-decomposing every service (only decompose critical ones)
- ❌ Mixing business logic with data access
- ❌ Direct database access from controllers
- ❌ Forgetting error handling at component boundaries