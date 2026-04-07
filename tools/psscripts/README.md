# PowerShell Scripts

**Location**: `tools/psscripts/`

**Purpose**: Automation scripts for validation and repository maintenance (Windows 11 + PowerShell).

---

## 📋 Script Set (Standardized)

### Health Check & Validation

#### `RepoConfig.psd1`

Per-repo settings consumed by shared scripts (keeps behavior consistent across repos while allowing repo-specific structure/policy).

---

#### `Quick-HealthCheck.ps1`

Fast workspace health check. Reads expected folders from `RepoConfig.psd1`.

**Usage:**

```powershell
.\tools\psscripts\Quick-HealthCheck.ps1
```

---

#### `Validate-FileReferences.ps1`

Validates markdown file references point to existing files.

**Usage:**

```powershell
.\tools\psscripts\Validate-FileReferences.ps1
.\tools\psscripts\Validate-FileReferences.ps1 -Path "src"
```

---

#### `Test-ContentCompliance.ps1`

Repository content-policy checks (rules vary by repo via `RepoConfig.psd1`).

**Usage:**

```powershell
.\tools\psscripts\Test-ContentCompliance.ps1
```

---

#### `Verify-ZeroCopy.ps1`

Helps detect accidental verbatim copying from `source-material/` into `src/`.

**Usage:**

```powershell
.\tools\psscripts\Verify-ZeroCopy.ps1
.\tools\psscripts\Verify-ZeroCopy.ps1 -Strict
```

---

### Linting & Link Checking

#### `Run-MarkdownLintAndLychee.ps1`

Runs Markdown lint (`markdownlint-cli2`) and link checking (Lychee) using repo `lychee.toml`.

**Usage:**

```powershell
.\tools\psscripts\Run-MarkdownLintAndLychee.ps1
.\tools\psscripts\Run-MarkdownLintAndLychee.ps1 -IncludeSourceMaterials
```

---

### Repo Stats / Utilities

- `Get-RepoStats.ps1`
- `Get-FileStats.ps1`
- `Get-MarkdownSummary.ps1`
- `Compare-DocFiles.ps1`
- `Find-DuplicateContent.ps1`

---

### One-off Maintenance

---

## 🚀 Quick Start

```powershell
.\tools\psscripts\Quick-HealthCheck.ps1
.\tools\psscripts\Validate-FileReferences.ps1
.\tools\psscripts\Run-MarkdownLintAndLychee.ps1
```

---

## 🔗 Related Documentation

- [Educational Content Rules](../../.cursor/rules/01_educational-content-rules.mdc)
- [Repository Structure](../../.cursor/rules/02_repository-structure.mdc)
- [Quality Assurance](../../.cursor/rules/03_quality-assurance.mdc)
