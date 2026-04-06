# Scale from Zero to Million Users - Low-Level Design

## Data Models

### User Model

```json
{
  "id": "uuid",
  "email": "string",
  "username": "string",
  "created_at": "timestamp",
  "updated_at": "timestamp",
  "profile": {
    "name": "string",
    "avatar": "url"
  }
}
```

### Application Data Model

(Varies by application type - example for generic data storage)

```json
{
  "id": "uuid",
  "user_id": "uuid",
  "data": "json",
  "created_at": "timestamp",
  "updated_at": "timestamp"
}
```

## API Design

### RESTful APIs

**Phase 1-2**: Simple REST APIs

- `POST /api/users` - Create user
- `GET /api/users/{id}` - Get user
- `PUT /api/users/{id}` - Update user
- `DELETE /api/users/{id}` - Delete user

**Phase 3-4**: REST APIs with versioning

- `POST /api/v1/users` - Create user
- `GET /api/v1/users/{id}` - Get user
- Rate limiting and authentication required

## Database Schema Evolution

### Phase 1-2: Simple Schema

```sql
CREATE TABLE users (
  id VARCHAR(36) PRIMARY KEY,
  email VARCHAR(255) UNIQUE NOT NULL,
  username VARCHAR(100) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE INDEX idx_email ON users(email);
CREATE INDEX idx_username ON users(username);
```

### Phase 3-4: Optimized Schema

- Partitioning by user_id or date
- Separate read replicas for read-heavy queries
- Denormalization for performance
- Materialized views for analytics

## Caching Strategy

### Phase 2: Application Cache

- In-memory cache for frequently accessed data
- TTL: 5-15 minutes
- Cache-aside pattern

### Phase 3-4: Distributed Cache

- Redis cluster for shared cache
- Cache layers:
  - L1: Application cache (5 min TTL)
  - L2: Redis cache (15 min TTL)
  - L3: CDN cache (1 hour TTL)

## Service Logic

### Request Flow (Phase 3-4)

1. Request arrives at Load Balancer
2. Load Balancer routes to Application Server
3. Application checks cache
4. If cache miss, query database
5. Update cache
6. Return response

### Write Flow

1. Request arrives at Load Balancer
2. Application Server processes write
3. Write to primary database
4. Invalidate cache
5. Async replication to read replicas

## Performance Optimizations

- **Connection Pooling**: Reuse database connections
- **Query Optimization**: Indexes, query tuning
- **Batch Processing**: Batch database operations
- **Async Processing**: Offload heavy operations to queues
- **Compression**: Compress responses for large payloads
