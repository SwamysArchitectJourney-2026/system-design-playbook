# Contributing to System Design in Practice

Thank you for your interest in contributing to System Design in Practice! This document provides guidelines and instructions for contributing.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [How to Contribute](#how-to-contribute)
- [Development Workflow](#development-workflow)
- [Coding Standards](#coding-standards)
- [Pull Request Process](#pull-request-process)

## Code of Conduct

This project adheres to a Code of Conduct that all contributors are expected to follow. Please read [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) before contributing.

## Getting Started

1. **Fork the repository** on GitHub
2. **Clone your fork** locally:

   ```bash
   git clone git@github.com:YOUR_USERNAME/system-design-in-practice.git
   cd system-design-in-practice
   ```

3. **Set up the development environment**:
   - For diagrams: Install diagramming tools (Mermaid, PlantUML, or draw.io)
   - For documentation: Use a Markdown editor with preview support
   - For code examples: Set up appropriate language environments if contributing code samples

## How to Contribute

### Reporting Issues

- Use GitHub Issues to report bugs or suggest enhancements
- Include clear descriptions, steps to reproduce, and expected vs. actual behavior
- Use appropriate issue templates when available

### Contributing Code

1. **Create a feature branch** from `main`:

   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes** following our coding standards

3. **Test your changes**:
   - Run existing tests
   - Add new tests for new functionality
   - Ensure all tests pass

4. **Commit your changes** with clear, descriptive commit messages

5. **Push to your fork** and create a Pull Request

## Development Workflow

### Branch Strategy

- `main` - Stable, production-ready code
- `feature/*` - New features or enhancements
- `bugfix/*` - Bug fixes
- `docs/*` - Documentation updates

### Task Branches

As per the project structure, create branches for specific tasks:

```bash
git checkout -b task/design-playbook-day1
git checkout -b task/design-playbook-day2
git checkout -b task/implement-python-postman
git checkout -b task/implement-csharp
```

## Coding Standards

### Diagrams

- Use Mermaid, PlantUML, or draw.io for architecture diagrams
- Follow C4 model conventions for system context and container diagrams
- Include sequence diagrams for complex interactions
- Ensure diagrams are clear and well-labeled

### Code Examples

- Include code examples in multiple languages when relevant (Python, Java, Go, etc.)
- Follow language-specific style guidelines
- Include comments explaining design decisions
- Keep examples simple and focused on the concept being demonstrated

### Markdown Documentation

- Follow markdownlint standards
- `src/99_interview-qna/.markdownlint.json` applies to files under that tree (relaxed rules for YAML front matter, repeated interview headings, list markers, and spacing). Root `.markdownlint.json` and `.markdownlint-cli2.yaml` apply to the rest of the repo.
- Use clear headings and structure
- Include code examples where relevant
- Keep line length reasonable (~120 characters)

## Pull Request Process

1. **Update documentation** if you've changed functionality
2. **Ensure all tests pass** and CI checks succeed
3. **Update CHANGELOG.md** if applicable
4. **Request review** from maintainers
5. **Address feedback** and make requested changes
6. **Wait for approval** before merging

### PR Checklist

- [ ] Code follows style guidelines
- [ ] Tests added/updated and passing
- [ ] Documentation updated
- [ ] No breaking changes (or documented if necessary)
- [ ] CI checks passing
- [ ] Reviewed by at least one maintainer

## Security

- **Never commit secrets** (API keys, passwords, etc.)
- Use environment variables or secure configuration
- Report security vulnerabilities privately to maintainers

## Questions?

If you have questions, please:

- Open an issue for discussion
- Check existing documentation
- Contact maintainers

Thank you for contributing to System Design in Practice!
