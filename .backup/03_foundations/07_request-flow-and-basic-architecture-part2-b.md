---
learning_level: "Beginner"
prerequisites: ["Request Flow and Basic Architecture (Part 2)"]
estimated_time: "25 minutes"
learning_objectives:
  - "Understand architectural evolution from simple to complex"
  - "Identify key decision points in system growth"
  - "Apply architectural evolution principles to system design"
related_topics:
  prerequisites:
    - ./07_request-flow-and-basic-architecture-part2.md
  builds_upon:
    - ./07_request-flow-and-basic-architecture-part2.md
  enables:
    - ../04_principles/03_scalability.md
    - ../05_building-blocks/02_load-balancers.md
    - ../07_case-studies/01-scalefromzerotomillonusers/README.md
  cross_refs: []
---

# Request Flow and Basic Architecture (Part 2-B)

## Architectural Evolution Path

### Phase 1: Single Server

Everything runs on one machine:

- Web application
- Database
- Static files

**Use Case**: Prototypes, MVPs, very small scale

### Phase 2: Separated Tiers

Web server and database on separate machines:

- Independent scaling
- Better performance
- Clear separation of concerns

**Use Case**: Growing applications, medium scale

### Phase 3: Multiple Servers

Multiple web servers with load balancer:

- Horizontal scaling
- High availability
- Distributed architecture

**Use Case**: Large-scale applications

## Key Takeaways

1. **Separate Concerns**: Split web and database as you grow
2. **DNS Matters**: Critical for routing and scaling
3. **JSON Standard**: Modern APIs use JSON for data exchange
4. **Plan Evolution**: Design with future separation in mind
5. **Independent Scaling**: Separation enables independent scaling of components
6. **Traffic Sources**: Web and mobile apps have different requirements

---

*Previous: [Request Flow and Basic Architecture (Part 2)](./07_request-flow-and-basic-architecture-part2.md)*  
*Next: Learn about [Scalability Principles](../04_principles/03_scalability.md) or explore [DNS](../05_building-blocks/01_dns.md) in detail.*
