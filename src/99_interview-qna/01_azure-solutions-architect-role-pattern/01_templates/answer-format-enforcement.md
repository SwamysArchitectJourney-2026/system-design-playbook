---
learning_level: "Advanced"
estimated_time: "10 minutes"
template_version: "1.0"
---

# Mandatory answer format (every `answer.md` in this track)

**Template version:** **v1.0** — state in every `answer.md` immediately under the title:

```markdown
## Based on Template v1.0
```

**Repo note:** Do not use a `00_` prefix. Templates live in `01_templates/`.

## Canonical references (say aloud in interview)

- **Service picks:** `service-selection-guide.md` (state *why* EH vs SB, Cosmos vs SQL, etc.).
- **Failures (deep):** `failure-scenario-catalog.md` + companion **`failures.md`** in the same folder as `answer.md`.
- **Grill categories:** `followup-attack-bank.md` → mirrored in `followups.md`.

## Atomic question pack (required files)

Each `02_core_questions/<slug>/`, `03_azure_specific/<slug>/`, `04_cross_domain/<slug>/` must contain:

| File | Purpose |
|------|---------|
| `answer.md` | Spoken spine (headings below) |
| `diagram.md` | Mermaid + **narration steps** (see below) |
| `failures.md` | Failure-first detail (may overlap §5 but expanded) |
| `tradeoffs.md` | Extended trade-off defense |
| `followups.md` | Categorized interviewer attacks |

## Required section order in `answer.md`

1. `## Based on Template v1.0`
2. `## 1. Clarify requirements`
3. `## 2. Scale estimation (back-of-envelope)`
4. `## 3. High-level architecture` (include **3.x decision** subsections: choose / because / vs / breaks when)
5. `## 4. Deep dives (pick 2–3 in the room)`
6. `## 5. Failure scenarios and mitigations` (min **five** bullets; align with `failures.md`)
7. `## 6. Trade-offs and decisions (why X over Y)` — this is your **key design decisions** summary (table or explicit *chose X over Y because*)
8. `## 7. Evolution strategy (MVP → scale → global)` — **mandatory** three phases; label explicitly **MVP**, **10× or scale**, **global**
9. `## 8. Security, observability, and cost` — **not optional**; minimum: **Entra ID / MI / Key Vault / private endpoints** (as applicable), **App Insights + SLOs**, **RU/autoscale/reserved/egress** (as applicable)

## `diagram.md` — narration contract

Include a **numbered walkthrough** the interviewer can follow:

1. Entry (e.g. Front Door)
2. Routing / gateway
3. Compute
4. Data / cache
5. Async / side paths (if any)

## `followups.md` — category headers

Use at least these level-2 sections (trim if irrelevant):

- `## Scalability and load`
- `## Failure and resilience`
- `## Data consistency`
- `## Security`
- `## Cost`
- `## Azure depth` (service selection spot checks)

## Interviewer signal

If §6 reads like a SKU list, rewrite using `07_interview-decision-cheatsheet.md` four-line rule.
