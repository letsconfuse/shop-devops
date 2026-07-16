# 2. Ephemeral Environments and Smoke Testing

Date: 2026-07-16

## Status

Accepted

## Context

We need to verify that changes to our platform configurations (Helm charts, Kubernetes manifests) result in a working, deployable application. Static validation (Phase 1) catches syntax errors, but it cannot guarantee that the application will actually start up, connect to its dependencies, and serve traffic.

## Decision

We will implement an Ephemeral Deployment and Smoke Testing pipeline in our CI process (`deploy-preview.yml`). 

1.  **Ephemeral Cluster:** For every Pull Request, we will spin up a fresh, short-lived Kubernetes cluster using **Kind (Kubernetes in Docker)**.
2.  **Deployment:** We will deploy the application into this cluster using Helm.
3.  **Smoke Testing:** Rather than running exhaustive end-to-end (E2E) tests which are brittle and time-consuming, we will run a targeted "smoke test". This test will port-forward the frontend service and issue a simple HTTP GET request to verify a `200 OK` response.

## Consequences

*   **Positive:** High confidence that merged PRs will not break the actual deployment process or the core application startup.
*   **Positive:** Isolated testing environments prevent conflicts between different PRs.
*   **Positive:** Using Kind in GitHub Actions is fast and incurs no external cloud infrastructure costs.
*   **Negative:** Adds a few minutes to the PR build time compared to just static linting.
*   **Negative:** Ephemeral CI clusters don't catch issues related to long-lived state (e.g., database schema migrations over time), which must be handled separately.
