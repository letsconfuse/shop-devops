# 1. CI Validation Strategy

Date: 2026-07-16

## Status

Accepted

## Context

We need a way to ensure that any changes to Kubernetes manifests or Helm charts are syntactically valid and conform to the Kubernetes API schema before they are merged into the main branch. This validation must run on every pull request to catch errors early in the development lifecycle. The validation process should be fast, reliable, and easily maintainable.

## Decision

We will implement a validation pipeline using GitHub Actions (`validate.yml`). The pipeline will perform the following steps:

1.  **Helm Linting:** Use `helm lint` to verify that the Helm chart is well-formed.
2.  **Helm Templating:** Use `helm template` to render the Helm chart into raw Kubernetes manifests. This step uses the `values.yaml` specific to our deployment.
3.  **Schema Validation:** Use `kubeconform` to validate the rendered manifests against the Kubernetes API schema. We chose `kubeconform` over alternatives like `kubeval` because it is actively maintained and supports custom resource definitions (CRDs) if needed in the future.

To keep the workflow file clean and promote reusability, we will abstract the setup steps (Helm, kubeconform) and the rendering logic into GitHub Composite Actions.

## Consequences

*   **Positive:** Early detection of misconfigurations, preventing broken deployments.
*   **Positive:** Clean and readable main workflow file due to the use of composite actions.
*   **Positive:** `kubeconform` is fast and runs completely locally without requiring a running Kubernetes cluster.
*   **Negative:** Requires maintaining custom composite actions in the `.github/actions` directory.
