---
learning_level: "Beginner"
prerequisites: ["Back-of-the-Envelope Calculations (Part 1)", "Basic arithmetic"]
estimated_time: "25 minutes"
learning_objectives:
  - "Apply common calculation patterns to system design scenarios"
  - "Understand read-heavy vs write-heavy workload implications"
  - "Plan for data growth and capacity scaling"
related_topics:
  prerequisites:
    - ./05_back-of-envelope-part1.md
  builds_upon:
    - ./05_back-of-envelope-part1.md
  enables:
    - ../07_case-studies/01-scalefromzerotomillonusers/02_back-of-envelope-part1.md
    - ../07_case-studies/05-url-shortener/02_back-of-envelope.md
  cross_refs: []
---

# Back-of-the-Envelope Calculations (Part 2): Common Patterns

## Common Patterns

### Read-Heavy vs Write-Heavy

- **Read-heavy** (10:1 ratio): Focus on caching, read replicas
- **Write-heavy** (1:1 ratio): Focus on write throughput, sharding
- **Balanced**: Consider both read and write paths

### Cache Hit Ratio Impact

If 80% of reads hit cache:
- Cache handles: 80% of reads
- Database handles: 20% of reads + 100% of writes
- **Effective database load reduced by 4x** for reads

### Data Growth Projections

Plan for growth:
- **Year 1**: Baseline
- **Year 2**: 2-3x growth
- **Year 3**: 5-10x growth

Design for 3-5 years, not just current scale.

## Key Takeaways

1. **Round numbers** for quick mental math
2. **Focus on orders of magnitude** - exact numbers less important
3. **Account for growth** - design for 3-5 years
4. **Consider all factors** - storage, bandwidth, compute
5. **Validate assumptions** - check if numbers make sense

---

*Previous: [Back-of-the-Envelope Calculations (Part 1)](./05_back-of-envelope-part1.md)*  
*Next: Apply these calculations in [Scale from Zero to Million Users case study](../07_case-studies/01-scalefromzerotomillonusers/02_back-of-envelope-part1.md) or explore [C4 Diagrams](./06_c4-diagrams-part1.md).*

