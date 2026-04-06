# Sequence Diagram - Token Range Assignment Flow

## Token Range Assignment Sequence

This diagram shows how service instances request and receive token ranges from the Token Service.

```mermaid
sequenceDiagram
    participant Service1 as Service Instance 1
    participant Service2 as Service Instance 2
    participant TokenSvc as Token Service
    participant MySQL as MySQL Database

    Note over Service1,Service2: Service instances start up or exhaust current range

    Service1->>TokenSvc: Request token range
    TokenSvc->>MySQL: BEGIN TRANSACTION
    TokenSvc->>MySQL: SELECT * FROM token_ranges<br/>WHERE is_assigned = false<br/>ORDER BY range_start LIMIT 1 FOR UPDATE
    MySQL-->>TokenSvc: Return unassigned range (1001-2000)
    TokenSvc->>MySQL: UPDATE token_ranges<br/>SET is_assigned = true,<br/>assigned_to = 'service-1',<br/>assigned_at = NOW()<br/>WHERE range_start = 1001
    TokenSvc->>MySQL: COMMIT
    MySQL-->>TokenSvc: Success
    TokenSvc-->>Service1: Return range (1001-2000)
    
    Service2->>TokenSvc: Request token range
    TokenSvc->>MySQL: BEGIN TRANSACTION
    TokenSvc->>MySQL: SELECT * FROM token_ranges<br/>WHERE is_assigned = false<br/>ORDER BY range_start LIMIT 1 FOR UPDATE
    MySQL-->>TokenSvc: Return unassigned range (2001-3000)
    TokenSvc->>MySQL: UPDATE token_ranges<br/>SET is_assigned = true,<br/>assigned_to = 'service-2',<br/>assigned_at = NOW()<br/>WHERE range_start = 2001
    TokenSvc->>MySQL: COMMIT
    MySQL-->>TokenSvc: Success
    TokenSvc-->>Service2: Return range (2001-3000)
    
    Note over Service1,Service2: Services use tokens sequentially from assigned ranges
    
    Service1->>Service1: Use tokens: 1001, 1002, 1003...
    Service2->>Service2: Use tokens: 2001, 2002, 2003...
    
    Note over Service1: When range nearly exhausted (e.g., 1990)
    
    Service1->>TokenSvc: Request next token range
    TokenSvc->>MySQL: Assign next available range (5001-6000)
    TokenSvc-->>Service1: Return range (5001-6000)
    Service1->>Service1: Continue with new range
```

## ASCII Fallback

```text
Service1 → TokenSvc → MySQL
Service2 → TokenSvc → MySQL

1. Service instances request token ranges
2. Token Service uses ACID transaction
3. SELECT FOR UPDATE ensures no duplicate assignment
4. UPDATE marks range as assigned
5. Return unique, non-overlapping ranges
6. Services use tokens sequentially
7. Request new range when current range exhausted
```

## Key Interactions

1. **ACID Transaction**: Ensures atomic range assignment
2. **SELECT FOR UPDATE**: Prevents concurrent assignment of same range
3. **Non-Overlapping Ranges**: Each service gets unique token range
4. **Sequential Usage**: Services use tokens in order from assigned range
5. **Proactive Request**: Services request new range before exhausting current range

## Concurrency Handling

- **Database Locking**: `SELECT FOR UPDATE` prevents race conditions
- **Transaction Isolation**: ACID guarantees ensure no duplicate assignments
- **Idempotent Requests**: Multiple requests from same service are safe

---

*Previous: [Redirection Flow](./02_redirection-flow.md)*
