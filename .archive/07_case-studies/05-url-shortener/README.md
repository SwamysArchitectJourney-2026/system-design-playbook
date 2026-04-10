# URL Shortener Case Study

A comprehensive system design case study for building a scalable URL shortening service (similar to TinyURL, bit.ly).

## Overview

This case study covers the complete design of a URL shortening service that can handle millions of requests per second, with high availability, low latency, and global scale.

## Case Study Structure

### Core Documentation

1. **[Requirements](./01_requirements.md)** - Functional and non-functional requirements, scale considerations
2. **[Back-of-Envelope](./02_back-of-envelope.md)** - Capacity planning calculations (storage, bandwidth, servers)
3. **[High-Level Design](./03_high-level-design.md)** - System architecture, components, and design decisions
4. **[Low-Level Design](./04_low-level-design.md)** - Detailed implementation: token generation, database schemas, service logic
5. **[Scalability](./05_scalability.md)** - Scaling strategies, analytics architecture, geographic distribution
6. **[Observability](./06_observability.md)** - Monitoring, logging, distributed tracing, SLIs/SLOs
7. **[Security](./07_security.md)** - Authentication, rate limiting, URL validation, DDoS protection
8. **[Trade-offs](./08_trade-offs.md)** - Design decisions, alternatives, and accepted trade-offs

### Diagrams

All diagrams are located in the [`diagrams/`](./diagrams/) folder:

- **C4 Model Diagrams**:
  - [Context Diagram](./diagrams/01_context-diagram.md) - System context and external relationships
  - [Container Diagram](./diagrams/02_container-diagram.md) - High-level technical building blocks
  - [Component Diagram](./diagrams/03_component-diagram.md) - Internal service components

- **Sequence Diagrams**:
  - [Shortening Flow](./diagrams/sequence-diagrams/01_shortening-flow.md) - URL creation flow
  - [Redirection Flow](./diagrams/sequence-diagrams/02_redirection-flow.md) - URL access and redirect flow
  - [Token Range Assignment](./diagrams/sequence-diagrams/03_token-range-assignment.md) - Token service interaction

## Key Design Highlights

### Architecture

- **Token Range Assignment**: Distributed unique ID generation without single point of failure
- **Horizontal Scaling**: All components scale horizontally
- **Multi-Layer Caching**: CDN + Redis for optimal performance
- **Read-Heavy Optimization**: 100:1 read-to-write ratio handled efficiently

### Technology Stack

- **Application**: Stateless service instances (Java/Python/.NET)
- **Database**: Cassandra for URL mappings, MySQL for token ranges
- **Cache**: Redis for frequently accessed URLs
- **Analytics**: Kafka + Spark Streaming for event processing
- **CDN**: Global edge caching for low latency

### Scale

- **Capacity**: 3.5 trillion unique URLs (7-character short URLs)
- **Traffic**: 100 million writes/day, 10 billion reads/day
- **Storage**: 300 TB over 10 years
- **Performance**: <50ms p95 latency for redirects

## Learning Objectives

After studying this case study, you should be able to:

- Design a scalable URL shortening service
- Choose appropriate databases for different use cases
- Implement distributed unique ID generation
- Design for read-heavy workloads
- Plan capacity and infrastructure requirements
- Implement comprehensive observability
- Design security and abuse prevention mechanisms

## Related Topics

- [Database Selection](../../05_building-blocks/03_databases-part1.md) - Understanding database choices
- [Key-Value Stores](../../05_building-blocks/04_key-value-store.md) - Caching strategies
- [Load Balancers](../../05_building-blocks/02_load-balancers.md) - Request distribution
- [CDN](../../05_building-blocks/05_cdn.md) - Content delivery networks

---

*This case study demonstrates real-world system design patterns and trade-offs commonly discussed in system design evaluations.*
