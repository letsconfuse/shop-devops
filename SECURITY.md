# Security Policy

Security is a primary gate in our DevOps lifecycle, not an afterthought. This document details our supported versions, vulnerability reporting process, and our automated security framework.

## Supported Versions

Only the latest release or branch-pinned versions of this repository receive active security maintenance and dependencies upgrades.

| Version | Supported | Notes |
|---|---|---|
| Main Branch |   Yes   | Tracks active development and pins upstream Helm chart. |
| Upstream Helm Chart |   Yes   | pinned in `platform/helm/versions.env` |

## Reporting a Vulnerability

If you discover a security vulnerability in this project (e.g., hardcoded credentials, insecure Kubernetes configurations, pipeline secrets exposure), please do **not** open a public issue. Instead, report it through the following channel:

-   Email the maintainer at: [jillworknow@gmail.com](mailto:jillworknow@gmail.com)
-   Or submit a draft security advisory directly via the GitHub Repository under **Security > Advisories**.

Please include:
1.  A detailed description of the vulnerability.
2.  Steps to reproduce the vulnerability.
3.  Potential impact of the vulnerability.

We will acknowledge your report within 48 hours and work on a patch as quickly as possible.

## Automated Security Gates

This platform automatically enforces security controls on every Pull Request and commit to the `main` branch via our [security.yml](.github/workflows/security.yml) workflow:

1.  **Secret Detection (Gitleaks):** Scans the git commit history to detect accidentally exposed API keys, passwords, and private tokens.
2.  **Infrastructure-as-Code (IaC) Scan (Trivy):** Analyzes Kubernetes manifests, Helm values, and Docker configurations for insecure default setups (e.g. running containers as root, privileged permissions, lack of resource limits).
3.  **Vulnerability Scan (Trivy Image mode):** Audits downstream third-party container images for known Common Vulnerabilities and Exposures (CVEs) and reports them.
4.  **Supply Chain Inventory (Syft SBOM):** Generates a Software Bill of Materials (SBOM) for container configurations and publishes it as a PR build artifact.
