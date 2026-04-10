---
learning_level: "Intermediate"
prerequisites: ["C4 Model for System Design (Part 1)"]
estimated_time: "25 minutes"
learning_objectives:
  - "Understand Level 3 (Component) and Level 4 (Code) diagrams"
  - "Learn evaluation strategies for using C4 diagrams"
  - "Apply best practices for creating and maintaining C4 diagrams"
related_topics:
  prerequisites:
    - ./06_c4-diagrams-part1.md
  builds_upon:
    - ./06_c4-diagrams-part1.md
  enables:
    - ../07_case-studies/05-url-shortener/diagrams/01_context-diagram.md
    - ../07_case-studies/05-url-shortener/diagrams/02_container-diagram.md
    - ../07_case-studies/05-url-shortener/diagrams/03_component-diagram.md
  cross_refs: []
---

# C4 Model for System Design (Part 2)

## Level 3: Component Diagram

**Purpose**: Zoom into one container to show its internal structure.

**Shows**:

- Internal components (controllers, services, repositories)
- Component responsibilities
- Dependencies between components
- Data flow within the container

**Example Component Diagram (Short URL Service)**:

```mermaid
graph TB
    Controller[API Controller] -->|Delegates| Handler[URL Handler]
    Handler -->|Gets token| TokenMgr[Token Manager]
    Handler -->|Encodes| Encoder[Base62 Encoder]
    Handler -->|Reads/writes| Cache[Cache Client]
    Handler -->|Queries| DBClient[Database Client]
    Handler -->|Publishes| Analytics[Analytics Client]
```

**When to Use**: Detailed design discussions, code organization, component-level architecture.

## Level 4: Code Diagram (Optional)

**Purpose**: Show classes, interfaces, and implementation details.

**Note**: This level is **rarely used** in system design evaluations because:

- Code is the source of truth
- UML already covers this level
- Too detailed for high-level discussions

**When to Use**: Code reviews, detailed implementation documentation (seldom in system design).

## Why C4 for System Design Evaluations?

### Advantages Over Traditional Approaches

| Aspect | C4 Model | Traditional UML |
| ------ | -------- | --------------- |
| **Learning Curve** | Low - intuitive hierarchy | High - many diagram types |
| **Evaluation Suitability** | Excellent - structured approach | Poor - too detailed |
| **Scalability** | Excellent - zoom in/out easily | Limited - fixed granularity |
| **Focus** | Structure and intent | Implementation details |
| **Real-world Adoption** | High - widely used | Medium - less common |

### Evaluation Strategy

1. **Start with Context**: Always begin with Level 1 to establish boundaries
2. **Zoom to Containers**: Break down into major components (Level 2)
3. **Detail Key Containers**: Deep dive into important containers (Level 3)
4. **Skip Code Level**: Avoid Level 4 unless specifically asked

## Creating C4 Diagrams

### Tools and Formats

**Recommended for This Repository**:

- **Mermaid**: Native support, version-controlled, renders in GitHub
- **PlantUML with C4-PlantUML**: Text-based, good for complex diagrams

**Other Options**:

- Draw.io / diagrams.net (visual editor)
- Structurizr (dedicated C4 tooling)
- Lucidchart / Miro (collaborative)

### Best Practices

1. **Always Start with Context**: Never jump to databases or APIs without context
2. **Use Consistent Notation**: Follow C4 conventions for shapes and relationships
3. **Document Decisions**: Include notes on technology choices and trade-offs
4. **Keep It Current**: Update diagrams as the system evolves
5. **Focus on Structure**: Emphasize relationships over implementation details

## Integration with Case Studies

Each case study in this repository includes C4 diagrams in the `diagrams/` folder:

- `01_context-diagram.md` - System context (Level 1)
- `02_container-diagram.md` - Container architecture (Level 2)
- `03_component-diagram.md` - Component details (Level 3)

See the [URL Shortener case study](../07_case-studies/05-url-shortener/diagrams/) for complete examples.

## Key Takeaways

1. **C4 provides a structured, hierarchical approach** to visualizing architecture
2. **Start broad, zoom in progressively** - Context → Container → Component
3. **Focus on structure and intent**, not implementation details
4. **Ideal for evaluations** - clear, scalable, technology-agnostic
5. **Widely adopted** in industry for architectural documentation

---

*Previous: [C4 Model for System Design (Part 1)](./06_c4-diagrams-part1.md)*  
*Next: Apply C4 diagrams in [URL Shortener case study](../07_case-studies/05-url-shortener/diagrams/01_context-diagram.md) or explore [other foundations](./README.md).*
