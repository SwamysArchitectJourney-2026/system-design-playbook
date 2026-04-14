# Skill: Content Review

**Version**: 1.0
**Repository**: `system-design-in-practice`

---

## Description

Reviews educational content files against the System Design Playbook quality standards.
Validates zero-copy compliance, YAML frontmatter, file naming, diagram standards, and
reasoning quality. Returns a structured report with findings and recommended fixes.

---

## When to Use

- After writing or modifying any educational content file
- Before committing to verify quality gate compliance
- When auditing a folder of files for consistency
- When asked to "review", "audit", or "check quality" of content

---

## How to Invoke

```text
Review [path/to/file.md] against playbook standards
Audit all files in [path/to/folder/] for quality compliance
Check [file.md] for zero-copy violations and YAML frontmatter
```

---

## Checks Performed

| Check | Severity if failing |
|-------|-------------------|
| YAML frontmatter present | HIGH |
| All 5 required frontmatter fields | HIGH |
| `enables:` key in `related_topics` | CRITICAL |
| No placeholder patterns (`$10X_`) | CRITICAL |
| Zero-copy compliance | HIGH |
| File ≤ 1000 lines | HIGH |
| Filename uses `01_` prefix (not `00_`) | HIGH |
| Code fences have language | MEDIUM |
| Mermaid diagrams have ASCII fallback | MEDIUM |
| Reasoning chain present in design decisions | MEDIUM |
| Trade-offs analyzed (not just mentioned) | MEDIUM |

---

## Output Format

```text
CONTENT REVIEW REPORT
=====================

Files checked: N
Issues found: N (critical: N, high: N, medium: N)

[FILE 1]: path/to/file.md
  Status: compliant | needs-updates | critical
  YAML: pass | fail — [list issues]
  Zero-copy: pass | flag — [describe]
  Line count: N
  Issues: [numbered list]
  Fixes: [numbered list]
```

---

## References

- `.cursor/rules/01_educational-content-rules.mdc`
- `.cursor/rules/03_quality-assurance.mdc`
- `.cursor/rules/04_markdown-standards.mdc`
- `.github/agents/content-review.md`
