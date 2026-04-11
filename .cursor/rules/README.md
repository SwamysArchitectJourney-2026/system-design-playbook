# Cursor AI Project Rules

**Version**: 1.0  
**Last Updated**: April 11, 2026

**Environment**: Windows 11, PowerShell  
**Note**: All commands and scripts should use PowerShell syntax. File paths use Windows format.

This directory contains modular rule files for Cursor AI, following the recommended Project Rules structure.

---

## 📋 Rule Files

### `01_educational-content-rules.mdc`

**Priority**: MANDATORY  
**Content**: Zero-Copy Policy, Transformative Workflow, 25-minute segments, metadata requirements, educational excellence standards  
**Applicability**: Rules apply differently to case study documentation vs. educational content (see rule file for details)

### `02_repository-structure.mdc`

**Content**: Repository context, structure overview, support resources

### `03_quality-assurance.mdc`

**Content**: Quality checklists (content, technical, documentation)

### `04_markdown-standards.mdc`

**Content**: Markdown authoring standards, encoding requirements, code fences, diagrams

### `05_primary-directives.mdc`

**Content**: Primary directives, automation-first approach, update verification protocol, Chain-of-Thought + ReAct methodology

### `06_cross-domain-integration.mdc`

**Content**: Cross-domain integration requirements, connection patterns

### `07_file-naming-conventions.mdc`

**Priority**: MANDATORY  
**Content**: File naming conventions, semantic naming patterns, splitting strategies, folder structure best practices  
**Applicability**: All new content must follow these conventions. Existing content may use `-part1`, `-part2` patterns (acceptable for mechanical splitting)

### `08_source_material_rules.mdc`

**Content**: Staging hygiene, zero-copy synthesis, where policy may name ignored input folders (assistant config only)

---

## Agent index (`../skills.md`)

[`.cursor/skills.md`](../skills.md) — short map to rules, `docs/02_repository-structure.md`, `CLAUDE.md`, `tools/psscripts/`, and CI scope (markdown-only).

---

## 🔄 Migration from `.cursorrules`

The root `.cursorrules` file has been split into these modular files for better:

- **Version Control**: Individual files easier to track
- **Modularity**: Update specific rules without affecting others
- **Maintainability**: Clear organization by topic
- **Scalability**: Easy to add new rule files

---

## 📝 Adding New Rules

1. Create new `.mdc` file in this directory
2. Use descriptive name with numeric prefix: `07_new-rule-name.mdc`
3. Follow existing file structure
4. Update this README with new rule description

---

## 🔗 Related Files

- **Root `.cursorrules`**: Kept for backward compatibility (can be removed after migration verified)
- **GitHub Copilot**: `.github/copilot-instructions.md` (similar rules for GitHub Copilot)

---

**Note**: Cursor AI automatically reads all `.mdc` files in `.cursor/rules/` directory. No additional configuration needed.
