---
learning_level: "Beginner"
prerequisites: ["Network Abstractions: RPC (Part 1)", "Basic understanding of distributed systems"]
estimated_time: "25 minutes"
learning_objectives:
  - "Understand RPC implementation patterns (synchronous, asynchronous, streaming)"
  - "Apply error handling strategies for RPC calls"
  - "Choose appropriate RPC patterns for different scenarios"
related_topics:
  prerequisites:
    - ./02_network-abstractions-part1.md
  builds_upon:
    - ./02_network-abstractions-part1.md
  enables:
    - ./07_request-flow-and-basic-architecture-part1.md
    - ../05_building-blocks/09_message-queues.md
  cross_refs: []
---

# Network Abstractions: RPC (Part 2) - Implementation Patterns and Error Handling

## RPC Implementation Patterns

### Pattern 1: Synchronous RPC

**Blocking call** - client waits for response:

```python
# Client blocks until response
result = payment_service.process_payment(amount=100, user_id=123)
print(f"Payment ID: {result.payment_id}")
```

**Use when**: Need immediate result, simple request/response.

**Trade-offs**:
- ✅ Simple to use and reason about
- ❌ Blocks thread while waiting
- ❌ Timeout handling required

### Pattern 2: Asynchronous RPC

**Non-blocking call** - client continues immediately:

```python
# Client doesn't wait
future = payment_service.process_payment_async(amount=100, user_id=123)
# Do other work...
result = future.get()  # Get result when ready
```

**Use when**: Long-running operations, don't need immediate response.

**Trade-offs**:
- ✅ Better resource utilization
- ✅ Can handle multiple calls concurrently
- ⚠️ More complex error handling

### Pattern 3: Streaming RPC

**Continuous data flow**:

```python
# Stream results as they arrive
for result in search_service.stream_results(query="system design"):
    process_result(result)
```

**Use when**: Large datasets, real-time updates, progressive results.

**Trade-offs**:
- ✅ Efficient for large data
- ✅ Real-time processing
- ⚠️ More complex to implement

## Error Handling in RPCs

### Error Types

1. **Network Errors**: Connection failures, timeouts
2. **Protocol Errors**: Invalid request format, version mismatch
3. **Application Errors**: Business logic failures, validation errors
4. **Service Errors**: Service unavailable, overloaded

### Error Handling Strategies

**Retry Logic**:
- Transient errors (network, timeouts) → retry with exponential backoff
- Permanent errors (validation, not found) → don't retry

**Circuit Breaker**:
- Stop calling failing service after threshold
- Fail fast instead of waiting for timeouts

**Fallback**:
- Return cached data or default values
- Graceful degradation

## Key Takeaways

1. **RPCs abstract network complexity** - make distributed calls look local
2. **Choose RPC for internal services** - better performance and type safety
3. **Use REST for public APIs** - universal, browser-friendly
4. **Handle errors gracefully** - retry, circuit break, fallback
5. **Consider streaming** - for large data or real-time updates

---

*Previous: [Network Abstractions: RPC (Part 1)](./02_network-abstractions-part1.md)*  
*Next: Learn about [Consistency Models](./03_consistency-models-part1.md) or explore [Request Flow](./07_request-flow-and-basic-architecture-part1.md).*

