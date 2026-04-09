# User Registration Flow - Sequence Diagram

## User Registration Sequence

This diagram shows the flow when a new user registers in the system.

```mermaid
sequenceDiagram
    participant User
    participant WebApp
    participant APIGateway
    participant AppService
    participant AuthService
    participant Database
    participant Cache
    participant MessageQueue

    User->>WebApp: Submit registration form
    WebApp->>APIGateway: POST /api/users (email, password)
    APIGateway->>APIGateway: Rate limiting check
    APIGateway->>AppService: Forward request
    AppService->>AuthService: Validate email format
    AppService->>Database: Check if email exists
    Database-->>AppService: Email not found
    AppService->>AuthService: Hash password
    AuthService-->>AppService: Hashed password
    AppService->>Database: Create user record
    Database-->>AppService: User created (user_id)
    AppService->>Cache: Invalidate user cache
    AppService->>MessageQueue: Publish user.created event
    AppService-->>APIGateway: 201 Created (user_id)
    APIGateway-->>WebApp: 201 Created
    WebApp-->>User: Registration successful
```

## ASCII Fallback

```text
User          WebApp        API Gateway   App Service   Auth Service  Database    Cache    Message Queue
 │              │              │              │              │            │          │            │
 │ Submit form  │              │              │              │            │          │            │
 ├─────────────>│              │              │              │            │          │            │
 │              │ POST /api/users            │              │            │          │            │
 │              ├───────────────────────────>│              │            │          │            │
 │              │              │ Rate limit  │              │            │          │            │
 │              │              ├─────────────>│              │            │          │            │
 │              │              │             │ Validate email│            │          │            │
 │              │              │             ├──────────────>│            │          │            │
 │              │              │             │ Check email exists         │          │            │
 │              │              │             ├────────────────────────────>│          │            │
 │              │              │             │<────────────────────────────┤          │            │
 │              │              │             │ Hash password              │          │            │
 │              │              │             ├──────────────>│            │          │            │
 │              │              │             │<──────────────┤            │          │            │
 │              │              │             │ Create user                │          │            │
 │              │              │             ├────────────────────────────>│          │            │
 │              │              │             │<────────────────────────────┤          │            │
 │              │              │             │ Invalidate cache          │          │            │
 │              │              │             ├────────────────────────────>│          │            │
 │              │              │             │ Publish event              │          │            │
 │              │              │             ├───────────────────────────────────────────────────>│
 │              │              │             │ 201 Created               │          │            │
 │              │              │<─────────────┤                           │          │            │
 │              │<──────────────┤             │                           │          │            │
 │<─────────────┤              │             │                           │          │            │
```

## Flow Description

1. **User submits registration form** with email and password
2. **WebApp sends request** to API Gateway
3. **API Gateway** performs rate limiting check
4. **AppService** validates email format via AuthService
5. **Database** checks if email already exists
6. **AuthService** hashes the password
7. **Database** creates new user record
8. **Cache** is invalidated to ensure fresh data
9. **MessageQueue** receives user.created event for downstream processing
10. **Response** is returned to user with user_id

## Error Scenarios

- **Email already exists**: Return 409 Conflict
- **Invalid email format**: Return 400 Bad Request
- **Weak password**: Return 400 Bad Request
- **Rate limit exceeded**: Return 429 Too Many Requests
- **Database error**: Return 500 Internal Server Error

## Evaluator Lens

This flow demonstrates:

- **Stateless application design**: AppService doesn't store session state, enabling horizontal scaling
- **Defensive validation at multiple layers**: API Gateway (rate limiting) → AppService (business logic) → AuthService (security)
- **Event-driven extensibility**: `user.created` event allows adding features (email notifications, analytics) without modifying core flow
- **Cache invalidation strategy**: Proactive invalidation ensures fresh data after writes
- **Separation of concerns**: AuthService handles security, AppService handles business logic

**Common candidate mistakes to avoid**:
- ❌ Storing passwords in plain text
- ❌ Skipping rate limiting at gateway
- ❌ Synchronous email sending (blocks response)
- ❌ Forgetting cache invalidation after writes