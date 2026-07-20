# Contributing to Astronomy Shop DevSecOps Platform

We are excited that you want to contribute to this DevSecOps learning platform! Please review the guidelines below to ensure a smooth contribution process.

## Workflow Strategy

We use a standard Pull Request (PR) workflow:

1.  **Fork the Repository:** Create a personal fork of the repository on GitHub.
2.  **Create a Feature Branch:** Always work on a descriptive feature branch.
    ```bash
    git checkout -b feature/your-feature-name
    # Or for chores/docs:
    git checkout -b chore/update-documentation
    ```
3.  **Implement and Validate Locally:** Ensure your changes conform to the repository standards (see below).
4.  **Submit a Pull Request:** Target the `main` branch of the upstream repository. Explain your changes, the rationale behind your design decisions, and any testing performed.
5.  **Pass CI Checks:** Your PR must pass all static validation, security scans, and Kind-based integration smoke tests before it can be merged.

## Commit Message Guidelines

We enforce the **Conventional Commits** specification. Commit messages should have the following structure:

```text
<type>(<scope>): <description>

[optional body]
```

### Common Types:
-   `feat`: A new platform feature (e.g., adding Argo CD, Prometheus dashboards)
-   `fix`: A bug fix or pipeline correction (e.g., fixing a failing smoke test)
-   `docs`: Documentation-only changes (e.g., updating the roadmap or ADRs)
-   `style`: Code style changes (whitespace, formatting, etc.)
-   `chore`: Regular maintenance, dependency updates, or internal tooling changes

### Examples:
-   `feat(gitops): bootstrap Argo CD and configure Application manifests`
-   `fix(ci): update smoke test curl retry interval`
-   `docs(adr): document the security scanning strategy`

## Quality Gates and Local Validation

To prevent broken configurations or lint errors in CI, run the following checks locally before committing:

### 1. Pre-commit Hooks
Our hooks check formatting and syntax for YAML, markdown, shell scripts, and GitHub Actions workflows. If you have `pre-commit` installed:
```bash
pre-commit install
pre-commit run --all-files
```

### 2. Helm & Kubernetes Manifest Validation
Validate that your Helm value overrides generate syntactically correct and schema-valid Kubernetes manifests:
```bash
make validate
```
This renders the chart with overrides and runs `kubectl --dry-run=client` to catch errors.

### 3. Security Config Scans
Scan your changes for security vulnerabilities and secrets:
```bash
make scan
```
This runs a local Trivy scan on the `platform/` configurations.
Ensure no credentials, tokens, or passwords are committed. Gitleaks will scan and block commits containing suspected secrets.
