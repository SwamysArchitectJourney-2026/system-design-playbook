# GitHub Copilot Instructions for System Design in Practice

**Version**: 2.0  
**Last Updated**: January 1, 2026  
**Repository**: `system-design-in-practice`

**Environment**: Windows 11, PowerShell  
**Note**: All commands and scripts should use PowerShell syntax. File paths use Windows format.

---

## 🎯 Repository Purpose

**System Design in Practice** is a comprehensive guide to system design, focusing on real-world architectural decisions, trade-offs, and scalability patterns.

### What This Repository Provides

- **System Design Principles**: Availability, reliability, scalability, consistency, fault tolerance, maintainability, security
- **Building Blocks**: DNS, load balancers, databases, caching, messaging, search, and more
- **Architectural Patterns**: Caching, rate limiting, circuit breaker, CQRS, event-driven
- **Case Studies**: End-to-end system designs (URL Shortener, YouTube, Twitter, Uber, WhatsApp, etc.)
- **Failure Analysis**: Real-world outage case studies and lessons learned
- **Interview Preparation**: Strategies, do's and don'ts, mock interviews

### Target Audience

- Software Engineers preparing for system design interviews
- Senior engineers transitioning to architect roles
- Engineers designing scalable systems in production
- Technical leads and architects

### Business Value

- Interview-ready preparation materials
- Practical system design knowledge
- Real-world case studies and patterns
- Scalable architecture guidance

---

## 📁 Repository Structure

> **📋 Single Source of Truth**: The complete and up-to-date repository structure is maintained in [`docs/02_repository-structure.md`](../docs/02_repository-structure.md). This file should be referenced for the authoritative structure. When the structure changes, update that file first, then update references here.

For the complete repository structure, see: **[docs/02_repository-structure.md](../docs/02_repository-structure.md)**

**Docs (meta):** [Learning path](../docs/01_road-map.md) · [Case study template](../docs/03_case-study-template.md) · [Target roles ↔ playbook alignment](../docs/04_target-role-playbook-alignment.md) · [Duplicate-heading scan report](../docs/review-reports/01_duplicate-markdown-headings-scan.md)

**Quick Overview**:

- `src/01_foundations/` - Design, tradeoff & failure frameworks
- `src/02_patterns/` - Caching, rate-limiting, retries, messaging
- `src/03_distributed-systems/` - Notification, chat, URL shortener
- `src/04_ai-ml-platforms/` - MLOps, observability, AI security
- `src/05_decision-frameworks/` - When-to-use-what decision guides
- `src/06_architecture-deep-dives/` - Consistency, partitioning, scaling
- `src/07_case-studies/` - End-to-end case studies
- `src/08_system_designs/` - Interview-style forward designs (`README.md`, `_template/` — see `docs/02_repository-structure.md`)
- `src/09_interview-qna/` - Interview prep (`README.md` workflow, `01_interview-prep-conventions.md`, role tracks `01_`–`09_`, `interview-execution/`, `career-orientation/`)

---

## 🔧 Development Guidelines

### When Working with System Design Content

1. **Follow Zero-Copy Policy**: All content must be transformative, not reformative
2. **Use Numbering**: Files must use `01_`, `02_`, etc. (never `00_`)
3. **Keep Modular**: Recommended ≤1000 lines per file (split, don't trim)
4. **Create Original Diagrams**: Use Mermaid-first with ASCII fallback
5. **Case Study Structure**: Follow standard structure (requirements, HLD, LLD, scalability, trade-offs)

### When Creating Educational Content

#### File Naming

- ✅ Use zero-padded numeric prefixes: `01_`, `02_`, etc.
- ❌ **NEVER** use `00_` prefix - **NO EXCEPTIONS**
- ✅ Use hyphens for multi-word names: `01_modern-system-design.md`

#### Naming Model (Decision Framework)

**Rule of thumb**: folders represent structure; files represent concepts; numbers represent ordering (sparingly).

- Prefer **semantic filenames** over editorial artifacts.
- Avoid encoding hierarchy/versioning in filenames (e.g., avoid `Part1-A`, `A/B/C`). If you feel you need `A/B/C`, you likely need a folder.
- Use `-part1`, `-part2` only for **mechanical splitting** (e.g., to respect the ~1000 line modularity guideline), not as a long-term hierarchy.

##### Recommended patterns in this repo

- In main learning folders (e.g., `src/01_foundations/`):
  - Use ordered files: `NN_topic-slug.md`.
  - If you must split: `NN_topic-slug-part1.md`, `NN_topic-slug-part2.md` (keep the same `NN_` prefix).
- In reference-style subfolders (e.g., a future `glossary/` folder):
  - Prefer `README.md` as the index + semantic topic files like `core-concepts.md`, `security.md`.
  - Add ordering numbers only if there is a deliberate reading sequence.

#### Applying Naming Conventions When Creating New Content

Before writing:

1. Choose the **right folder** based on learning progression (01 → 09). If the content is a new “cluster” (e.g., glossary), create a folder and put a `README.md` index inside it.
2. Choose a filename that matches the **concept boundary**:
    - Prefer `NN_concept-name.md` for sequence-based modules.
    - Prefer `concept-name.md` inside reference-style folders.
3. Keep names URL-friendly: lowercase, hyphen-separated words, avoid spaces.

When splitting a file:

- First try to split by concept (new file) instead of by “Part”.
- If you still need parts, use `-part1`, `-part2` (not `A/B/C`).
- Preserve the base slug so links remain predictable (e.g., `03_consistency-models-part1.md`).

After adding/renaming:

- Update the local `README.md` index (if present) and the global `src/CONTENT_INDEX.md` as needed.
- Run link checks (Lychee) if you renamed files.

#### Applying Naming Conventions When Reviewing/Editing Content

During review, treat naming as part of “maintainability”:

- **Does the filename match the scope?** If the file title/scope drifted, rename the file or split it.
- **Is hierarchy in the right place?** Move structure into folders + `README.md` indexes instead of growing filename suffixes.
- **Is ordering intentional?** If numbers exist, they should reflect a real learning sequence. Don’t renumber casually (it creates churn and breaks links).
- **Are split files clean?** Prefer `-partN` over letter suffixes; ensure parts are similarly sized and self-contained.
- **Are links updated?** If any rename happened, update all inbound links and re-run `lychee`.

#### Content Structure

- ✅ Recommended ≤1000 lines per file
- ✅ Split into multiple parts if content exceeds 1000 lines
- ✅ Never trim or condense content
- ✅ Each part should be self-contained

#### YAML Frontmatter (Recommended for content files)

```yaml
---
learning_level: "Beginner" | "Intermediate" | "Advanced"
prerequisites: ["required knowledge", "prior concepts"]
estimated_time: "25 minutes"
learning_objectives:
  - "Specific, measurable outcome 1"
  - "Specific, measurable outcome 2"
related_topics:
  prerequisites: []
  builds_upon: []
  enables: []
  cross_refs: []
---
```

### When Creating Case Studies

#### Standard Structure

Each case study should include:

- `requirements.md` - Functional and non-functional requirements
- `high-level-design.md` - System architecture and component interactions
- `low-level-design.md` - Detailed design of components
- `scalability.md` - Scaling strategies and considerations
- `trade-offs.md` - Design decisions and their trade-offs
- `diagrams/` - Case study specific diagrams
  - `context-diagram.md` - C4 Level 1: System context
  - `container-diagram.md` - C4 Level 2: Container architecture
  - `component-diagram.md` - C4 Level 3: Component details
  - `sequence-diagrams/` - Interaction flows and sequences

### Security Best Practices

- ❌ **NEVER** commit API keys or secrets
- ✅ **ALWAYS** use environment variables or secure configuration
- ✅ **ALWAYS** add sensitive files to `.gitignore`

### Staging folders (not in public docs)

- Do **not** mention **`source-material/`** or **`reference-material/`** in `README.md`, your public content directories, or **`docs/**/*.md`**.
- Synthesize into tracked documentation; assistants may name these paths only in agent config files to state this policy — see `.cursor/rules/08_source_material_rules.mdc`.

---

## 📋 Code Quality Standards

### Markdown Files

- Use proper heading hierarchy (H1 → H2 → H3)
- Include code fence language specifications
- Follow markdownlint rules
- Use UTF-8 encoding
- Line length ~120 chars (tables/URLs may exceed)

### Diagrams

- **Mermaid-first**: Primary visualization method
- **ASCII fallback**: Include ASCII fallback for compatibility
- **Never embed copyrighted figures**: Create original diagrams
- **Co-locate with content**: Diagrams in case study `diagrams/` folders

---

## 🚀 Content Creation Workflow

### Transformative Workflow

1. **Source Intake**: Skim for intent and big ideas; don't copy notes verbatim
2. **Concept Map**: Create fresh outline with different sectioning
3. **Teach Differently**: Use new analogies, scenarios, datasets, use-cases
4. **Produce Original Artifacts**: Explanations, Mermaid diagrams, minimal examples
5. **Cross-Link**: Add references across sections
6. **Similarity Audit**: Ensure no sentences/structures resemble source
7. **Optional References**: Add "References/Inspired by" links (no copied phrasing)

### Quality Gate Questions

Before publishing any content:

1. ✅ Is this explanation clearer than the source material?
2. ✅ Does this fit naturally in the learning progression?
3. ✅ Would a learner understand this without the original source?
4. ✅ Are the examples relevant and practical?
5. ✅ Does this content add educational value beyond the reference?
6. ✅ Is this content within 1000 lines for effective delivery?

---

## 🧠 Reasoning Frameworks for Content Development

Apply structured reasoning when creating and reviewing system design content.

### Chain-of-Thought (CoT) Process

When creating system design content, follow this explicit reasoning chain:

1. **UNDERSTAND**: What problem does this system solve?
   - Define the core user needs and business goals
   - Identify the scale and constraints

2. **DECOMPOSE**: What are the core components?
   - Break down into functional building blocks
   - Identify data flows and dependencies

3. **ANALYZE**: What are the trade-offs for each approach?
   - Consider consistency vs availability
   - Evaluate latency vs throughput
   - Assess cost vs performance

4. **SYNTHESIZE**: How do components work together?
   - Draw architecture diagrams
   - Document interaction patterns

5. **VALIDATE**: Does this meet requirements?
   - Check against functional requirements
   - Verify non-functional constraints

### ReAct (Reason + Act) Pattern

Use this iterative pattern for complex design decisions:

```text
THOUGHT: Why is this design decision optimal for the given constraints?
ACTION:  Document the decision with rationale and Mermaid diagram
OBSERVE: Does this align with quality standards and learning objectives?
REPEAT:  Until all requirements are covered with clear reasoning
```

**Example Application**:

```text
THOUGHT: Users need low-latency access to frequently requested data
ACTION:  Add distributed cache layer between API and database
OBSERVE: Cache hit ratio improves latency; need to address cache invalidation
THOUGHT: Cache invalidation is complex; what strategy fits this use case?
ACTION:  Document write-through vs write-behind trade-offs
OBSERVE: Write-through ensures consistency but adds write latency
```

### Reasoning in Educational Content

When writing case studies and explanations, make the thought process explicit:

#### ✅ DO: Show the "Why" Behind Decisions

```markdown
## Design Decision: Choosing a Database

**Context**: We need to store user profiles with flexible schema requirements.

**Reasoning Chain**:
1. User profiles have varying attributes across regions (flexible schema needed)
2. Read-heavy workload (80% reads, 20% writes)
3. Need horizontal scaling for millions of users
4. Strong consistency not required for profile data

**Decision**: Document database (e.g., MongoDB, Cosmos DB)
**Trade-off**: Eventual consistency acceptable for faster reads
```

#### ❌ AVOID: Stating Facts Without Reasoning

```markdown
## Design Decision: Choosing a Database
Use MongoDB for user profiles.  ← No reasoning provided
```

---

## 📋 Content Review with Reasoning

### Review Checklist (Reasoning-Based)

When reviewing content, apply structured reasoning:

#### Logical Flow Assessment (CoT)

- [ ] Does the content follow a logical progression from problem to solution?
- [ ] Are concepts introduced before they're used?
- [ ] Is each design decision backed by explicit reasoning?
- [ ] Are trade-offs clearly articulated (not just mentioned)?

#### Depth of Reasoning (ReAct)

- [ ] Can a reader understand WHY this approach was chosen?
- [ ] Are alternative approaches mentioned with reasons for rejection?
- [ ] Is the reasoning chain traceable from requirements to implementation?
- [ ] Would an interviewer accept this reasoning in a system design interview?

#### Educational Effectiveness

- [ ] Does the content teach HOW to think, not just WHAT to build?
- [ ] Are there explicit "Thought Process" sections for complex decisions?
- [ ] Can a learner apply this reasoning to similar problems?
- [ ] Are common misconceptions addressed with corrective reasoning?

### Review Questions by Content Type

| Content Type | Key Reasoning Questions |
| ------------ | ----------------------- |
| **Requirements** | Why these requirements? What drove the priorities? |
| **High-Level Design** | Why this architecture? What alternatives were considered? |
| **Low-Level Design** | Why these data structures/algorithms? What are the trade-offs? |
| **Scalability** | Why this scaling strategy? What are the bottlenecks and mitigations? |
| **Trade-offs** | Is the reasoning chain complete? Are edge cases covered? |

---

## 📝 Local Quality Checks

Before committing changes:

**Note**: The following commands work in PowerShell on Windows 11. Use PowerShell syntax for file paths.

### Markdown Linting

```powershell
npx markdownlint-cli2 "**/*.md"
```

### Link Checking (Lychee via Docker)

```powershell
docker run --rm -v "${PWD}:/input:ro" lycheeverse/lychee --config /input/lychee.toml "/input/**/*.md"
```

### Pre-Commit Checklist

- [ ] Run markdownlint and fix any issues
- [ ] Run Lychee link checker (if Docker available)
- [ ] Verify all file references point to existing files
- [ ] Check that code fences have language specifications
- [ ] Ensure proper blank lines around headings and lists
- [ ] Verify file naming (no `00_` prefixes)
- [ ] Check numbering consistency

---

## 🔗 Quick Links

- [Learning Path](../docs/01_road-map.md)
- [Content Index](../src/CONTENT_INDEX.md)
- [Foundations](../src/01_foundations/)
- [Patterns](../src/02_patterns/)
- [Case Studies](../src/07_case-studies/)
- [Interview Q&A](../src/09_interview-qna/)
- [Contributing](../CONTRIBUTING.md)

---

## 📞 Support

- **Issues**: Use GitHub Issues for bug reports and feature requests
- **Discussions**: Use GitHub Discussions for questions and ideas
- **Contributing**: See [CONTRIBUTING.md](../CONTRIBUTING.md) for guidelines

---

## 🔄 Update Verification Protocol

**After ANY structural change, IMMEDIATELY update**:

1. ✅ **`docs/02_repository-structure.md`** - **UPDATE THIS FIRST** (Single source of truth)
2. ✅ `.github/copilot-instructions.md` - Reference to the repository structure doc (THIS FILE)
3. ✅ `README.md` - Reference to the repository structure doc
4. ✅ `.cursor/rules/02_repository-structure.mdc` - Reference to the repository structure doc
5. ✅ Relevant documentation files

**Self-Check Question**: "Did I update `docs/02_repository-structure.md` first?" - If no, STOP and do it NOW.
