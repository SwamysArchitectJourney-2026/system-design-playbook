# Case Study Template

**Version**: 1.0  
**Last Updated**: December 19, 2025  
**Purpose**: Standardized template for all case studies in this repository

---

## Case Study Structure

Each case study should follow this structure:

```text
case-study-name/
├── README.md                    # Overview and navigation
├── 01_requirements.md           # Functional and non-functional requirements
├── 02_back-of-envelope.md        # Capacity planning calculations
├── 03_high-level-design.md       # System architecture (HLD)
├── 04_low-level-design.md        # Detailed design (LLD)
├── 05_scalability.md             # Scaling strategies
├── 06_observability.md           # Monitoring, logging, SLIs/SLOs
├── 07_security.md                # Security considerations
├── 08_trade-offs.md              # Design decisions and alternatives
└── diagrams/                     # Case study specific diagrams
    ├── 01_context-diagram.md     # C4 Level 1
    ├── 02_container-diagram.md    # C4 Level 2
    ├── 03_component-diagram.md   # C4 Level 3
    └── sequence-diagrams/        # Interaction flows
        ├── 01_primary-flow.md
        ├── 02_secondary-flow.md
        └── ...
```

---

## README.md Template

```markdown
# [System Name] Case Study

A comprehensive system design case study for [system description].

## Overview

[2-3 sentence overview of what this system does and why it's important]

## Case Study Structure

### Core Documentation

1. **[Requirements](./01_requirements.md)** - Functional and non-functional requirements
2. **[Back-of-Envelope](./02_back-of-envelope.md)** - Capacity planning
3. **[High-Level Design](./03_high-level-design.md)** - System architecture
4. **[Low-Level Design](./04_low-level-design.md)** - Detailed implementation
5. **[Scalability](./05_scalability.md)** - Scaling strategies
6. **[Observability](./06_observability.md)** - Monitoring and SLIs/SLOs
7. **[Security](./07_security.md)** - Security considerations
8. **[Trade-offs](./08_trade-offs.md)** - Design decisions

### Diagrams

[Link to diagrams folder with descriptions]

## Key Design Highlights

### Architecture
- [Key architectural decisions]
- [Notable patterns used]

### Technology Stack
- [Primary technologies]

### Scale
- [Capacity numbers]
- [Performance targets]

## Learning Objectives

After studying this case study, you should be able to:
- [Objective 1]
- [Objective 2]
- [Objective 3]

## Related Topics

- [Links to related building blocks, patterns, principles]
```

---

## 01_requirements.md Template

```markdown
# [System Name] - Requirements

## Functional Requirements

1. **[Core Feature 1]**: [Description]
2. **[Core Feature 2]**: [Description]
3. **[Core Feature 3]**: [Description]

## Non-Functional Requirements

### Performance
- **Response Time**: [Target latency]
- **Throughput**: [Target QPS/RPS]
- **Availability**: [Target uptime]

### Scalability
- **User Scale**: [Target user count]
- **Data Scale**: [Target data volume]
- **Geographic Distribution**: [Regions/requirements]

### Reliability
- **Error Rate**: [Target error percentage]
- **Data Durability**: [Requirements]
- **Consistency**: [Consistency requirements]

## Constraints

- **Budget**: [Constraints]
- **Time to Market**: [Timeline]
- **Team Size**: [Constraints]
- **Technical Constraints**: [Any limitations]
```

---

## 02_back-of-envelope.md Template

````markdown
# [System Name] - Back-of-Envelope Calculations

## Assumptions

- [Assumption 1]
- [Assumption 2]
- [Assumption 3]

## Capacity Planning

### Storage Requirements

**Calculation**:
```text
[Show calculation steps]
```

**Result**: [Total storage needed]

### Bandwidth Requirements

**Calculation**:
```text
[Show calculation steps]
```

**Result**: [Total bandwidth needed]

### Compute Requirements

**Calculation**:
```text
[Show calculation steps]
```

**Result**: [Servers/instances needed]

## Key Metrics Summary

| Metric | Value |
|--------|-------|
| Storage | [Value] |
| Bandwidth | [Value] |
| QPS | [Value] |
| Servers | [Value] |
````

---

## 03_high-level-design.md Template

```markdown
# [System Name] - High-Level Design

## System Architecture

[Architecture diagram - Mermaid or ASCII]

## Core Components

### Component 1: [Name]
- **Purpose**: [What it does]
- **Technology**: [Tech stack]
- **Responsibilities**: [Key responsibilities]

### Component 2: [Name]
[Same structure]

## Data Flow

[Describe how data flows through the system]

## Key Design Decisions

1. **[Decision 1]**: [Rationale]
2. **[Decision 2]**: [Rationale]
3. **[Decision 3]**: [Rationale]

## Evaluator Lens

This design demonstrates:
- [Signal 1]: [Why it matters]
- [Signal 2]: [Why it matters]
- [Signal 3]: [Why it matters]

**What evaluators look for**:
- ✅ [Positive signal]
- ❌ [Common mistake to avoid]
```

---

## 04_low-level-design.md Template

````markdown
# [System Name] - Low-Level Design

## Data Models

### [Entity 1]

```json
{
  "field1": "type",
  "field2": "type"
}
```

## API Design

### Endpoint 1: [Name]

**Request**:
```text
[Method] /api/path
[Headers]
[Body]
```

**Response**:
```text
[Status Code]
[Body]
```

## Database Schema

```sql
CREATE TABLE [table_name] (
  [columns]
);
```

## Service Logic

[Describe key algorithms, workflows, business logic]

## Evaluator Lens

This LLD demonstrates:
- [Signal 1]
- [Signal 2]

**Common candidate mistakes**:

- ❌ [Mistake 1]
- ❌ [Mistake 2]

````

---

## 05_scalability.md Template

```markdown
# [System Name] - Scalability

## Scaling Strategies

### Horizontal Scaling
- [How to scale horizontally]
- [Components that scale]

### Vertical Scaling
- [When vertical scaling is used]
- [Limitations]

### Database Scaling
- [Database scaling approach]
- [Sharding/replication strategy]

## Bottlenecks and Solutions

| Bottleneck | Solution |
|------------|----------|
| [Bottleneck 1] | [Solution] |
| [Bottleneck 2] | [Solution] |

## Performance Optimization

- [Optimization 1]
- [Optimization 2]
- [Optimization 3]
```

---

## 06_observability.md Template

```markdown
# [System Name] - Observability

## SLIs and SLOs

### Service Level Indicators (SLIs)

- **Availability**: [Metric definition]
- **Latency**: [Metric definition]
- **Error Rate**: [Metric definition]
- **Throughput**: [Metric definition]

### Service Level Objectives (SLOs)

- **Availability**: [Target, e.g., 99.9%]
- **Latency p95**: [Target, e.g., <200ms]
- **Error Rate**: [Target, e.g., <0.1%]

## Monitoring Strategy

### Key Metrics
- [Metric 1]
- [Metric 2]
- [Metric 3]

### Alerting
- **Critical**: [When to alert]
- **Warning**: [When to warn]

## Logging Strategy

- [What to log]
- [Log levels]
- [Log retention]

## Distributed Tracing

- [Tracing strategy]
- [Key spans to track]
```

---

## 07_security.md Template

```markdown
# [System Name] - Security

## Authentication

- [Authentication method]
- [Token management]
- [Session handling]

## Authorization

- [Authorization model]
- [Access control]
- [Permission model]

## Data Protection

- **Encryption at Rest**: [Approach]
- **Encryption in Transit**: [Approach]
- **Key Management**: [Approach]

## Threat Mitigation

| Threat | Mitigation |
|--------|------------|
| [Threat 1] | [Mitigation] |
| [Threat 2] | [Mitigation] |

## Security Best Practices

- [Practice 1]
- [Practice 2]
- [Practice 3]
```

---

## 08_trade-offs.md Template

```markdown
# [System Name] - Trade-offs

## Architecture Trade-offs

### [Decision 1]

**Option A**: [Description]
- ✅ [Pros]
- ❌ [Cons]

**Option B**: [Description]
- ✅ [Pros]
- ❌ [Cons]

**Chosen**: [Option] because [Rationale]

## Performance Trade-offs

### [Trade-off 1]

[Description of trade-off and decision]

## Cost Trade-offs

### [Trade-off 1]

[Description of trade-off and decision]

## Consistency vs Availability

[How consistency and availability are balanced]

## Evaluator Lens

This demonstrates:
- [Signal 1]: [Why it matters]
- [Signal 2]: [Why it matters]

**What evaluators look for**:
- ✅ Understanding trade-offs explicitly
- ✅ Clear rationale for decisions
- ❌ Ignoring trade-offs
- ❌ Over-optimizing one dimension
```

---

## Diagram Templates

### Context Diagram (C4 Level 1)

```markdown
# [System Name] - C4 Level 1: System Context

## System Context Diagram

[Mermaid C4Context diagram]

## Description

**Users**: [Who uses the system]

**System**: [What the system does]

**External Systems**: [External dependencies]
```

### Container Diagram (C4 Level 2)

```markdown
# [System Name] - C4 Level 2: Container Architecture

## Container Diagram

[Mermaid C4Container diagram]

## Trust Boundaries

**Public Edge**: [Public-facing components]

**Private Network**: [Internal components]

## Container Descriptions

[Describe each container]
```

### Component Diagram (C4 Level 3)

```markdown
# [System Name] - C4 Level 3: Component Details

## Component Diagram

[Mermaid C4Component diagram]

> **LLD Scope Note**:  
> In evaluations, only one service is decomposed to this level.

## Component Responsibilities

[Describe each component]
```

### Sequence Diagrams

```markdown
# [Flow Name] - Sequence Diagram

## [Flow Description]

[Mermaid sequence diagram]

## Flow Description

[Step-by-step description]

## Error Scenarios

- [Error 1]: [How handled]
- [Error 2]: [How handled]

## Evaluator Lens

This flow demonstrates:
- [Signal 1]
- [Signal 2]

**Common candidate mistakes**:
- ❌ [Mistake 1]
- ❌ [Mistake 2]
```

---

## Evaluator Lens Section (Required)

Every case study should include an **"Interviewer Lens"** section that explicitly answers:

1. **What problem does this system optimize for?**
   - [Answer]

2. **What is intentionally NOT optimized?**
   - [Answer]

3. **What breaks first at scale?**
   - [Answer]

4. **What signals senior-level thinking?**
   - [List of signals]

5. **Common candidate mistakes?**
   - [List of mistakes]

---

## Failure Scenario Analysis (Required)

Each case study should include at least one realistic failure scenario:

### Failure Scenario: [Name]

**What fails**: [Component/service]

**Blast radius**: [What's affected]

**Detection**: [How detected]

**Recovery**: [How to recover]

**Prevention**: [How to prevent]

**SLI Impact**: [Impact on SLIs/SLOs]

---

## Cross-Linking Requirements

Each case study should cross-link to:

- **Observability**: Reference SLIs/SLOs from `06_observability.md`
- **Failures**: Link to relevant failure scenarios in `src/08_failures/`
- **Building Blocks**: Reference relevant building blocks used
- **Patterns**: Reference architectural patterns applied

---

## Quality Checklist

Before finalizing a case study, verify:

- [ ] All 8 core files present
- [ ] C4 diagrams (context, container, component) included
- [ ] At least 2-3 sequence diagrams
- [ ] Evaluator Lens section in each relevant file
- [ ] Failure scenario analysis included
- [ ] SLIs/SLOs defined in observability section
- [ ] Cross-links to related topics
- [ ] Back-of-envelope calculations shown
- [ ] Trade-offs explicitly discussed
- [ ] Security considerations addressed

---

**Last Updated**: December 19, 2025
