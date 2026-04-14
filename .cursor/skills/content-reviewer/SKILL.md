---
name: content-reviewer
description: >-
  Reviews educational markdown under src/ and docs/ for zero-copy discipline, YAML frontmatter,
  file naming (01_ never 00_), diagram rules, and reasoning quality. Use when the user asks to
  review, audit, check quality, or validate playbook content before commit.
---

# Content reviewer (playbook)

## Instructions

1. Read [`.cursor/rules/01_educational-content-rules.mdc`](../../rules/01_educational-content-rules.mdc) and [`.cursor/rules/03_quality-assurance.mdc`](../../rules/03_quality-assurance.mdc) before judging content.
2. Follow the full operating rules in [`.cursor/agents/01_content-reviewer.md`](../../agents/01_content-reviewer.md) (severity rubric, zero-copy checks, YAML expectations).
3. Run or recommend checks:
   - `npx markdownlint-cli2` on paths the user changed (see [`.github/workflows/ci-documentation.yml`](../../../.github/workflows/ci-documentation.yml) for repo globs).
   - `.\tools\psscripts\Validate-FileReferences.ps1` when `prerequisites` or file links were edited.
4. **Never** suggest pasting ignored staging material into `src/` or `docs/` — synthesize per [`.cursor/rules/08_source_material_rules.mdc`](../../rules/08_source_material_rules.mdc).

## Output

Produce a short report: **PASS / ISSUES** with file paths, severity (CRITICAL / HIGH / MEDIUM), and concrete fixes.

## Related

- GitHub skill contract: [`.github/skills/content-review.md`](../../../.github/skills/content-review.md)
