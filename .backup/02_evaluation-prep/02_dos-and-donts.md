---
learning_level: "Beginner"
prerequisites: []
estimated_time: "15 minutes"
learning_objectives:
	- "List high-signal behaviors that improve system design evaluation performance"
	- "Avoid common failure patterns that cause down-leveling"
	- "Frame the evaluation as collaborative problem-solving"
related_topics:
	prerequisites: []
	builds_upon:
		- "01_getting-ready.md"
	enables:
		- "04_mock-interviews.md"
	cross_refs:
		- "../07_case-studies/05-url-shortener/01_requirements.md"
---

# The Do's and Don'ts of System Design Evaluations

System design evaluations reward **clarity, humility, and reasoning**. Many candidates fail due to avoidable behavioral mistakes.

---

## ✅ Do’s

### Ask Clarifying Questions

- Understand scale, users, and constraints
- Avoid designing the wrong system

### Think Out Loud

- Make your reasoning visible
- Silence is interpreted as lack of clarity

### Start with High-Level Design

- Identify major components first
- Defer optimizations

### Explicitly Discuss Trade-offs

- Every decision has costs
- State what you are optimizing for

### Handle Failures Proactively

- Assume components will fail
- Describe degradation behavior

---

## ❌ Don’ts

### Don’t Jump into Implementation

- Avoid class diagrams and code
- Focus on architecture, not syntax

### Don’t Ignore Non-Functional Requirements

- Latency, availability, scalability matter

### Don’t Over-Engineer Early

- Solve today’s problem first
- Scale when justified by requirements

### Don’t Defend a Bad Design

- Accept feedback
- Adapt your design when challenged

---

## Evaluator Lens

Evaluators are **collaborators**, not adversaries.
They want to see how you respond to feedback and uncertainty.

---

## Key Takeaway

A good system design evaluation feels like a **technical discussion**, not a performance.
