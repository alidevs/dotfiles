# Personal OpenCode Rules

## 1. Core Working Principles

* Treat every implementation and review as production-grade senior backend work.
* Investigate the existing codebase, conventions, dependencies, and available commands before making changes.
* Prefer the smallest targeted change that correctly fixes the root cause.
* Do not introduce workarounds that merely hide symptoms. Fix the source or clearly state the concrete blocker.
* Preserve existing API, event, and database compatibility unless a breaking change is explicitly approved.
* After completing the work, review the resulting diff and remove or revert anything that proved unnecessary.
* Never hallucinate APIs, packages, commands, files, functions, configuration, or framework behavior. Verify anything uncertain.

## 2. Change Discipline

### Keep Changes Focused

* Follow the project's existing architecture, code style, naming, formatting, and established patterns.
* Do not perform broad refactors when a small targeted change solves the problem.
* Do not add unnecessary abstractions, dependencies, files, configuration, functions, or variables.
* Avoid trivial helpers or single-use variables that only increase indirection.
* Do not remove existing comments unless explicitly asked.
* Add comments only when they explain non-obvious behavior, constraints, risks, or reasoning that the code itself cannot express clearly.
* Do not add comments that merely restate the code.

### Dependency Changes

* Confirm that a package is necessary before adding it.
* Use the language's package manager to install the latest compatible version instead of manually editing dependency manifests where practical.
* For JavaScript and TypeScript projects, use the package manager indicated by the lockfile: Bun, pnpm, Yarn, or npm.
* Preserve and use the project's lockfile for deterministic dependency installation.

### File Deletion

* When deleting files on the user's local machine, use `trash` instead of `rm`.
* Inside containers, CI environments, Kubernetes pods, or remote servers, use the deletion method appropriate to that environment.

## 3. Shell and Local Tooling

### Shell

* The user's local shell is fish.
* All commands intended to run directly on the user's machine must be valid fish syntax.
* Do not provide Bash- or Zsh-specific syntax unless explicitly requested.
* Commands intended for a server, Docker container, CI runner, or Kubernetes pod should use the shell available in that environment.

### Python

* Prefer `uv` for all Python-related workflows.
* Use `uv sync` to install or synchronize dependencies.
* Use `uv add` and `uv remove` for dependency changes instead of manually editing `pyproject.toml` where practical.
* Use `uv run` for project commands, including:
  * `uv run ruff check`
  * `uv run ruff format`
* For temporary scripts that require external packages, use `uv run --with <package>`.
* Use multiple `--with` flags when several packages are needed.
* Do not use `python`, `python3`, `pip`, or global package installations unless the project genuinely cannot support `uv`.

## 4. Validation and Completion

* Use the repository's documented development interface whenever one exists.
* Inspect `Justfile`, `Makefile`, Compose files, package scripts, project documentation, and CI configuration to determine the canonical commands.
* Fully test the change when the repository provides a reliable way to do so.
* Run the relevant formatter, linter, type checker, tests, build, and generated-code checks after making changes.
* Prefer the repository's aggregate quality command, such as `just check`, when available.
* Do not claim that something passed unless the command was actually run successfully.

## 5. Senior Backend Quality Bar

Evaluate changes against realistic production behavior, not only the happy path.

### Data Access and Performance

* Prevent N+1 queries, unnecessary round trips, inefficient joins, excessive data loading, and unbounded queries.
* Require appropriate pagination, filtering, indexes, query plans, and transaction boundaries.
* Consider realistic data volumes, concurrency, deployment topology, and horizontal scaling.
* Watch for excessive allocations, memory leaks, connection-pool exhaustion, and avoidable serialization or network overhead.

### Concurrency and Reliability

* Check for race conditions, deadlocks, thread-pool starvation, blocking I/O in asynchronous paths, and unsafe shared state.
* Ensure timeouts, cancellation, retries, exponential backoff, circuit breaking, and idempotency are appropriate where relevant.
* Avoid retrying non-idempotent operations unless duplicate execution is safely handled.
* Ensure graceful startup and shutdown behavior.
* Handle partial failures without leaving inconsistent state.

### Security

* Check authentication and authorization at every relevant boundary.
* Validate untrusted input and prevent injection vulnerabilities.
* Prevent privilege escalation, insecure defaults, sensitive-data exposure, and accidental secret leakage.
* Confirm that logs, metrics, traces, and error responses do not expose credentials or private data.
* Apply least-privilege principles to services, database access, containers, and infrastructure configuration.

### Caching

* Check for stale data, invalidation bugs, incorrect or incomplete cache keys, stampedes, and unnecessary duplication.
* Ensure cache behavior remains correct across multiple replicas and failure scenarios.
* Do not use caching to conceal an inefficient or incorrect source query without addressing the underlying issue.

### Background Jobs and Messaging

* Assume duplicate delivery unless the system explicitly guarantees otherwise.
* Handle idempotency, ordering, retries, poison messages, dead-letter behavior, partial failure, and graceful shutdown.
* Ensure message acknowledgement occurs at the correct point relative to database commits and external side effects.
* Consider transactional outbox or equivalent consistency patterns where appropriate.

### Observability

* Require structured and actionable logs.
* Preserve or introduce correlation identifiers where useful.
* Add meaningful metrics and traces for important workflows and failure modes.
* Errors should include enough context to diagnose the issue without leaking sensitive information.
* Alerts should represent actionable symptoms or service-level risks rather than noisy implementation details.

### Testing

* Require tests appropriate to the change, including:
  * Core business logic
  * Regression coverage
  * Boundary and edge cases
  * Authentication and authorization
  * Failure and retry paths
  * Concurrency-sensitive behavior
  * Important database behavior
  * Compatibility guarantees
* Clearly distinguish confirmed defects from credible production risks.
* Clearly distinguish blockers from optional improvements.

## 6. Docker-First Repository Standard

Every repository must be fully usable through Docker without requiring project-specific runtimes, package managers, databases, or tooling on the host.

The host should generally require only:

* Docker
* `just` or `make`

### Required Repository Files

Every repository should include:

* A production-appropriate `Dockerfile`
* A local development Compose configuration, preferably `docker-compose.yaml`
* A `.dockerignore`
* A `Justfile` or a `Makefile`
* Clear environment-variable and secret-handling documentation

If the repository genuinely cannot follow this model, state the concrete technical blocker rather than silently requiring host tooling.

### Containerized Workflows

The following operations should run inside containers:

* Dependency installation
* Application startup
* Builds
* Tests
* Linting
* Formatting
* Type checking
* Database migrations
* Code generation
* Seed operations
* Development databases and supporting services

Do not fall back to locally installed Python, Node.js, .NET, Java, Go, PostgreSQL, Redis, or similar tooling merely because the host command is easier to write.

### Image and Compose Quality

* Pin important runtime and tool versions.
* Install dependencies deterministically from the lockfile.
* Support common development architectures, including Apple Silicon, where practical.
* Use build caching effectively.
* Use multi-stage builds when they materially improve image size, security, or build performance.
* Run as a non-root user where feasible.
* Add useful health checks for long-running services.
* Avoid copying unnecessary files, build artifacts, credentials, or secrets into images.
* Use an appropriate `.dockerignore` to keep build contexts small and safe.
* Keep secret values outside images and committed configuration.
* Ensure container startup, signals, and graceful shutdown behave correctly.
* Keep development behavior close enough to production to expose environment-specific failures without making local development unnecessarily difficult.

## 7. Justfile/Makefile Command Interface

Every repository must contain a `Justfile` or a `Makefile` that acts as the primary interface for development, validation, and common operational workflows.

Developers should not need to remember raw Docker, Compose, framework, or package-manager commands for normal work.

### Design Principles

* Recipes should generally be thin wrappers around Docker or Docker Compose.
* Keep the `Justfile` small, readable, and discoverable through `just --list`.
* Commands should fail clearly and propagate the underlying exit code.
* Do not suppress output that is important for debugging.
* Avoid duplicating substantial shell or application logic in the `Justfile`.
* Put complex reusable logic in an appropriate script or application command, then expose it through a simple recipe.
* Use the same Docker and `just` workflows in documentation and CI to minimize local-versus-CI differences.

### Standard Recipe Names

Use generic and predictable recipe names where relevant:

* `up`
* `down`
* `build`
* `rebuild`
* `test`
* `lint`
* `format`
* `typecheck`
* `check`
* `shell`
* `logs`
* `migrate`
* `rollback`
* `seed`
* `reset`
* `clean`

`check` should normally run the complete local quality gate, such as:

* Formatting verification
* Linting
* Type checking
* Tests
* Build validation
* Generated-code or migration consistency checks where relevant

### Recipe Scope

* Avoid recipes created for a single ticket, customer, endpoint, record, bug, or temporary debugging session.
* Prefer generic parameterized recipes that accept a service, test path, migration name, command, or other argument.
* A highly specific recipe is acceptable only when the operation is recurring, important, dangerous, operationally critical, or unusually difficult to remember.

## 8. Git and Operational Safety

* Never commit, push, create a branch, or open a pull request unless explicitly instructed.
* The user performs commits manually by default.
* Do not rewrite Git history unless explicitly instructed and the consequences are clear.
* Do not execute production data changes.
* For production data changes, produce SQL or an operational procedure for manual review and execution.
* For Kubernetes or Flux-managed repositories, never apply manifests manually.
* Validate changes locally where possible, then push and allow Flux to reconcile.
* Do not bypass GitOps merely to test a deployment.
* Clearly state when verification requires a commit, push, deployment, external environment, credential, or user action.
