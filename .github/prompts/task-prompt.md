# Prompt Engineering Playbook Repository Verification and Content Enhancement

## Context

You are working with **Prompt Engineering Playbook**, a comprehensive playbook repository that standardizes how prompts are designed, developed, tested, and integrated across C#, Python, and Postman workflows using Azure OpenAI. The repository provides prompt structures, reusable patterns, templates, governance guidelines, and code integration examples.

**Repository Structure:**

- `playbook/` - Core playbook framework and documentation
- `src/` - Code examples in Python, C#, and Postman
- `infra/` - Azure infrastructure guidance
- `docs/` - Additional documentation and architecture diagrams
- `.github/` - GitHub workflows and templates

**Primary Objective:**
Perform a COMPREHENSIVE audit of the repository using Prompt Engineering Playbook standards and quality criteria. Verify file contents, run structured checks, and produce actionable reports with suggestions and fixes.

---

## Prompt Engineering Playbook Verification Checks

### A. File Content Inspection

- Open and verify every file (no file skipped)
- Ensure markdown formatting compliance
- Check for completeness and consistency with playbook objectives

### A.1 Staging Hygiene

- No references or links to internal-only staging (source-material/, eference-material/) in public docs (see .cursor/rules/08_source_material_rules.mdc).

### B. Prompt Pattern Alignment

- Verify prompts follow established patterns (instruction-based, role-based, RAG, chain-of-thought, evaluation)
- Validate prompt structure follows template guidelines
- Check pattern documentation is complete and accurate
- Ensure examples demonstrate proper pattern usage

### C. Content Accuracy and Quality

- Verify technical correctness and Azure OpenAI alignment
- Ensure completeness for stated objectives
- Check alignment with prompt engineering best practices
- Validate code examples are current, relevant, and runnable

### D. Playbook Metadata Requirements

Check for presence of:

- Pattern type designation (instruction-based, role-based, RAG, etc.)
- Use case description
- Clear objectives (specific, measurable)
- Code examples in Python, C#, or Postman
- Related patterns and cross-references

### E. Naming Convention Compliance

- Use kebab-case for filenames
- Use consistent naming patterns within folders
- Verify folder structure follows repository standards
- Check proper organization by pattern type and language

### F. Broken Links and References

- Verify all internal cross-references work correctly
- Check README files and navigation structure
- Validate external resource links and references
- Ensure pattern navigation links are accurate

### G. Content Quality Standards

- Spellcheck and grammar verification
- Character encoding validation (UTF-8 only)
- Markdown formatting compliance (markdownlint standards)
- Code example correctness and completeness
- Proper code fence language specification

### H. Code Organization

- Verify proper placement in correct language folder (python, csharp, postman)
- Check cross-references are accurate
- Validate organization is clear and discoverable
- Ensure no content duplication

### I. Repository Structure Clarity

- Verify folder organization is intuitive
- Check navigability and discoverability
- Validate table of contents accuracy
- Ensure README files guide users through content

### J. Content Currency and Relevance

- Verify content reflects current Azure OpenAI APIs and practices
- Check for deprecated patterns or outdated information
- Validate relevance to stated objectives
- Assess alignment with industry trends in prompt engineering

### K. Practical Application

- Verify examples are runnable and technically correct
- Check code aligns with learning objectives
- Validate error handling coverage
- Ensure code examples follow best practices for their language/framework

### L. Template Effectiveness

- Assess clarity and usability for target audience
- Verify templates are complete with all required sections
- Check customization guidance is provided
- Validate examples demonstrate proper template usage

### M. Prompt Pattern Documentation

- Verify pattern intent and structure are clearly explained
- Check when/when-not-to-use guidance is present
- Validate trade-offs are discussed
- Ensure implementation examples are provided in multiple languages

### N. Diagram and Visual Quality

- Verify ASCII diagrams are provided as fallback
- Check Mermaid diagrams are well-structured
- Validate visual clarity and accuracy
- Ensure diagrams support understanding

### O. Cross-Language Integration

- Check proper references between language implementations
- Verify content consistency across Python, C#, and Postman
- Validate integration patterns are documented
- Ensure terminology consistency

---

## Prompt Engineering Playbook Content Standards

### Playbook Structure

- **Prompt Patterns**: Instruction-based, role-based, RAG, chain-of-thought, evaluation prompts
- **Templates**: Reusable templates for summarization, classification, extraction, transformation, code-generation
- **Governance**: Review workflows, storage strategy, safety considerations, quality guidelines
- **Code Integration**: Examples in Python, C#, and Postman for Azure OpenAI integration

### Content Organization

- **By Pattern Type**: Content organized by prompt pattern (instruction, role-based, RAG, etc.)
- **By Use Case**: Templates organized by task type (summarization, classification, extraction, etc.)
- **By Language**: Code examples organized by implementation language (Python, C#, Postman)
- **By Integration**: Examples show Azure OpenAI SDK and REST API patterns

### Quality Requirements

- **Accuracy**: Technically correct and aligned with Azure OpenAI best practices
- **Completeness**: Addresses stated objectives fully
- **Clarity**: Clear explanations with practical examples and runnable code
- **Relevance**: Directly applicable to prompt engineering practice
- **Currency**: Reflects current Azure OpenAI APIs and best practices
- **Practicality**: Includes actionable guidance, patterns, and examples
- **Security**: Follows security best practices (no hardcoded keys, proper configuration)

### File Standards

- **Naming**: kebab-case filenames, descriptive names indicating content focus
- **Structure**: Clear sections, logical flow, easy navigation
- **Metadata**: Pattern type, use case, objectives, examples
- **References**: Cross-references to related content with working links
- **Examples**: Runnable code with multiple language implementations
- **Visuals**: ASCII diagrams and Mermaid diagrams where helpful
- **Length**: Focused, modular content

---

## Output Requirements

### 1. SUMMARY (Top-level)

```json
{
  "repo_name": "prompt-engineering-playbook",
  "total_files_checked": 0,
  "total_issues_found": 0,
  "playbook_compliance_percentage": 0.0,
  "high_severity_count": 0,
  "medium_severity_count": 0,
  "low_severity_count": 0,
  "suggested_next_steps": ["step1", "step2", "step3"]
}
```

### 2. DETAILED_REPORT (array of file reports)

For each file:

```json
{
  "file_path": "string",
  "pattern_type": "string (e.g., instruction-based, role-based, RAG)",
  "language_category": "string (e.g., python, csharp, postman, documentation)",
  "checks_passed": ["list of check keys, e.g., A,B,C,F,G,I"],
  "metadata_present": true,
  "content_quality_score": "0-100",
  "practical_application_score": "0-100",
  "issues": [
    {
      "id": "string (unique, e.g., PEP-001)",
      "severity": "high|medium|low",
      "line_start": 0,
      "line_end": 0,
      "description": "string",
      "suggested_fix": "string",
      "fix_type": "replace|delete|add|rename|format|link-fix|metadata-add",
      "violation_type": "string (e.g., missing-pattern, broken-link, outdated-api)"
    }
  ],
  "overall_status": "compliant|needs_updates|remove",
  "quick_fix_patch": "string or null"
}
```

### 3. PATTERN_COVERAGE_ANALYSIS

```json
{
  "pattern_coverage": { "instruction-based": 0, "role-based": 0, "rag": 0, "chain-of-thought": 0, "evaluation": 0 },
  "template_coverage": { "summarization": 0, "classification": 0, "extraction": 0, "transformation": 0, "code-generation": 0 },
  "language_coverage": { "python": 0, "csharp": 0, "postman": 0 },
  "completeness_score": "0-100",
  "gap_analysis": ["missing patterns", "missing templates", "missing language examples"]
}
```

### 4. CONTENT_QUALITY_ANALYSIS

```json
{
  "technical_accuracy_score": "0-100",
  "clarity_and_readability_score": "0-100",
  "practical_application_score": "0-100",
  "code_quality_score": "0-100",
  "examples_quality_score": "0-100",
  "pattern_documentation_score": "0-100"
}
```

### 5. METADATA_COMPLIANCE_SUMMARY

```json
{
  "files_with_complete_metadata": 0,
  "files_missing_pattern_type": 0,
  "files_missing_use_case": 0,
  "files_missing_examples": 0,
  "files_with_incorrect_naming": 0,
  "metadata_compliance_percentage": "0-100"
}
```

### 6. CROSS_REFERENCE_VALIDATION

```json
{
  "internal_links_valid": 0,
  "broken_internal_links": 0,
  "pattern_cross_references": 0,
  "language_cross_references": 0,
  "external_link_validation": "needs_verification"
}
```

### 7. IMPROVEMENT_RECOMMENDATIONS

```json
{
  "structural_improvements": ["recommendation1"],
  "content_enhancements": ["recommendation2"],
  "metadata_additions": ["recommendation3"],
  "code_improvements": ["recommendation4"],
  "pattern_documentation": ["recommendation5"]
}
```

---

## Formatting Rules

- Output as JSON (no prose outside JSON blocks)
- Use 2-space indentation for readability
- Escape patches in unified diff format
- UTF-8 encoding only
- Quote all JSON keys and string values

---

## Deliverables

1. Complete JSON report following Prompt Engineering Playbook output requirements
2. Compliance scoring and prompt engineering quality assessment
3. Pattern and template coverage analysis with gap identification
4. Cross-reference validation results
5. Content quality analysis by pattern type and language
6. Three clear next steps to improve repository and prompt engineering effectiveness

---

## Behavioral Expectations

- **Prompt Engineering Focus**: Prioritize prompt quality, effectiveness, and alignment with Azure OpenAI best practices
- **Template Quality**: Flag content that doesn't meet prompt engineering excellence standards
- **Pattern Integrity**: Ensure prompt patterns are well-documented with clear use cases and examples
- **Practical Relevance**: Verify content provides actionable prompt engineering guidance and integration examples
- **Cross-Language Integration**: Validate proper examples across Python, C#, and Postman
- **Code Quality**: Validate examples follow best practices, are runnable, and demonstrate proper Azure OpenAI integration
- **Governance Compliance**: Ensure governance guidelines are clear and actionable
- **Template Completeness**: Verify templates include all necessary components (system prompts, user prompts, examples)
- **Testing Coverage**: Check that evaluation and testing approaches are documented
- **Documentation Quality**: Ensure all examples are well-documented with setup instructions

---

## Start Now

Open every file in the repository tree, run Prompt Engineering Playbook-specific checks, and produce the structured JSON report following these requirements. Focus on prompt quality, template completeness, code example correctness, and alignment with Azure OpenAI best practices.

