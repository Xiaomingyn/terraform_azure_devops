# Standards

- Core layer hosts foundational landing-zone style resources.
- Platform layer hosts shared runtime and data platform services.
- Application layer hosts workload-facing services.
- Secrets are injected through Azure DevOps variable group `subscripEnv`.
- Pipelines must support selective execution by action, environment, and layer.
