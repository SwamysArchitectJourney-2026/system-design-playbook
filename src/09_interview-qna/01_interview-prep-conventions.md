---
learning_level: "Intermediate"
estimated_time: "12 minutes"
topic: "Interview prep folder conventions and duplication policy"
---

# Interview prep — conventions and duplication policy

This document governs **published** content under `09_interview-qna/`. It keeps **navigation** predictable and limits **entropy** when the same idea appears in more than one place.

**Master index:** [README.md](README.md).

---

## Why these conventions exist

- Role tracks accumulate **templates**, **core questions**, and **drills** over time.
- Without rules, **links rot**, **copies drift**, and contributors duplicate the **golden answer spine** unnecessarily.

---

## Default track layout (contract)

Most **role** folders follow:

| Path | Purpose |
|------|---------|
| `README.md` | Entry point: how to study this role, links to spine and first drills |
| `01_templates/` | Checklists, rubrics, whiteboard packs, format enforcement |
| `02_core_questions/<slug>/` | `answer.md`, `diagram.md`, `tradeoffs.md`, `followups.md`, `failures.md` (subset per question) |
| `03_azure_specific/`, `04_cross_domain/` | Optional; used where Azure SA–style depth is split out |

**Exceptions** are intentional: for example **`payment-system-interview/`** uses numbered modules at the **track root** plus `interview-execution/` tuned for payments—document that pattern in the track README, not here in full.

---

## Shared spine: single source of truth

**Canonical (domain-neutral) spine and grill:**

- [`interview-execution/01_golden-answer-template.md`](interview-execution/01_golden-answer-template.md)
- [`interview-execution/02_follow-up-grill-layer.md`](interview-execution/02_follow-up-grill-layer.md)
- [`interview-execution/03_cross-domain-prompt-bank.md`](interview-execution/03_cross-domain-prompt-bank.md)

**Rule:** New role tracks should **link** to these files unless a **documented exception** applies (see below).

---

## Inheritance model for `interview-execution/`

Treat the global folder as the **default implementation** of the interview spine:

- **Canonical path:** `src/09_interview-qna/interview-execution/` (golden template, follow-up grill, cross-domain prompt bank).

**Do not** create a track-local `interview-execution/` **unless** at least one of the following is true:

- The domain needs **systematic rewrites** across those files (money path, compliance language, ledger semantics, etc.).
- The track is intentionally **offline-first** and a self-contained tree is worth the **sync tax**—and the track README states that trade-off explicitly.

Otherwise, **only link** to the global files from the track `README.md` (and from individual questions if useful). This prevents template and grill **drift** across many copies.

---

## Duplication policy (when to copy vs link)

### Prefer **linking** when

- The content is the **same narrative arc** with only **light** role wording tweaks.
- Maintenance should stay **centralized** (one edit fixes all tracks).

### Allow a **track-local copy** when

- The domain needs **systematic rewrites** in every section (e.g. **money path**, **PCI**, **ledger** vocabulary).
- The track is studied **offline** or **in isolation** and a self-contained folder measurably helps.

**Example in this repo:** `payment-system-interview/interview-execution/` is a **payment-tuned** derivative of the shared folder; it points back to the generic originals for drift control.

### If you add a new embedded copy

1. State in that track’s **README** that the copy is **intentional** and **which** shared file it replaces.
2. Add a **short “sync checklist”** line (e.g. when updating shared golden template, review embedded copy for the same section numbers).
3. Avoid **nested** copies (do not duplicate the duplicate).

### Do **not**

- Paste the **entire** shared `interview-execution/` tree into every role “for convenience.”
- Fork **core question** packs into two tracks without a **clear ownership** rule (prefer one slug, cross-link from the other README).

---

## Track taxonomy: role vs domain (contract for new folders)

**Primary axis — role:** how you position in interviews (e.g. solution architect, platform architect, AI architect, enterprise architect). Prefer this for **new** top-level folders under `09_interview-qna/`.

**Secondary axis — domain:** stack or vertical depth under that role (Azure, payments, GenAI, data platform, etc.)—usually a **subfolder** or a **clear prefix** in the track README, not a parallel naming scheme with no explanation.

**Current tree:** mixes numbered role tracks (`01_`–`09_`), a few unnumbered role-style folders, and domain-heavy tracks (e.g. payments). That is **acceptable**; full physical reshaping is optional.

**When adding a new track:** pick **one** primary axis in the folder name; if both role and domain matter, encode **role first**, then domain in a child path or in the README title so navigation stays predictable.

---

## Cross-link hygiene

- Prefer **relative** links from the file that contains them; run the repo’s markdown link checker when changing structure.
- Each **track README** should surface: **spine** (shared or local), **grill**, and **one** default drill or core question path.
- After **moving** folders, update **`docs/02_repository-structure.md` first** (repository single source of truth), then dependent indexes.

---

## Curriculum boundaries: `07_case-studies/` vs `08_system_designs/`

Interview prep (`09_interview-qna/`) **consumes** both analysis skills (from studying `07_`) and construction skills (from practicing `08_`). Keep the curriculum split clean:

- **`07_case-studies/`** — understanding **existing** systems; flexible narrative; not forced into the interview walkthrough scaffold.
- **`08_system_designs/`** — **your** forward designs from a prompt; **must** follow `src/08_system_designs/_template/` (requirements → HLD → trade-offs → failures + diagrams).

**Do not** duplicate a case study into `08_` with light edits. Authoritative wording: [`docs/02_repository-structure.md`](../../docs/02_repository-structure.md) (*Case studies vs system designs*).

---

## Content promotion (brief)

Ideas start as **drafts outside** the published `src/` narrative trees. **Promote** into these tracks by **synthesis** (your own structure and wording), not by dumping raw notes into README-visible paths. Tooling-specific policy lives in workspace rules for assistants.

---

## Revision trigger

Revisit this file when: a **second** track gains an embedded `interview-execution/`-style copy, or when **shared** and **embedded** spines **visibly diverge** on purpose (then document the divergence here in one sentence).
