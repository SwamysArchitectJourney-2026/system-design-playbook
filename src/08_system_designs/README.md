---
learning_level: "Intermediate"
estimated_time: "6 minutes"
learning_objectives:
  - "Choose between 07_case-studies and 08_system_designs when adding content"
  - "Start a new forward-design walkthrough from _template/"
---

# System designs (`08_system_designs/`)

**Forward construction** — interview-style, step-by-step designs you **build from a prompt**, not reverse-engineered writeups of famous products.

| Compare | `07_case-studies/` | `08_system_designs/` |
|--------|--------------------|----------------------|
| **Mode** | Learn how an existing or canonical system works | Practice designing a system from scratch |
| **Narrative** | Analysis / exploration | Construction / defense |
| **Shape** | Flexible depth; prioritize explanation | **Follow the scaffold** in [`_template/`](_template/README.md) |
| **Good fit** | YouTube-scale, Uber, WhatsApp-style studies | “Design payment”, “Design notifications”, multi-region API |

**Rule:** Do **not** duplicate a `07_` case study into `08_` with light edits. If the artifact is “how X company built Y,” it belongs in **`07_case-studies/`**. If it is “here is **my** design for problem Z, ready to defend in a loop,” it belongs here.

**Start:** copy [`_template/`](_template/README.md) into a new folder under this directory (hyphenated name, `01_`+ prefix for ordering if you keep multiple designs).

**Governance:** Full separation rules live in [`docs/02_repository-structure.md`](../../docs/02_repository-structure.md) (see *Case studies vs system designs*).
