# ADR-0014: Orchestrators Compose Execution State

- **Status:** Accepted
- **Date:** 2026-08-11
- **Scope:** Program

---

# Context

The MCU is composed of independent capabilities.

Each capability owns exactly one constitutional responsibility.

Each capability produces a single Domain Artifact.

Examples include:

- Platform Detection → Platform Description
- Prerequisite Validation → Validation Report
- Package Management → Package Plan

As multiple capabilities were composed into execution pipelines, downstream capabilities required access to multiple Domain Artifacts simultaneously.

An architectural decision was required:

> Should capabilities enrich upstream artifacts, or should orchestration compose multiple artifacts into a shared execution model?

---

# Decision

Orchestrators compose Execution State.

Capabilities do not.

Execution State is a transient composition of Domain Artifacts.

Each Domain Artifact remains owned by the capability that produced it.

Execution State itself is owned exclusively by orchestration.

Capabilities may consume Execution State.

Capabilities never modify Execution State directly.

Capabilities never modify or embed another capability's Domain Artifact.

---

# Rationale

Capability ownership remains explicit.

Each capability remains responsible for only one Domain Artifact.

Execution State provides downstream capabilities with the information required to perform their responsibilities without violating capability ownership boundaries.

This preserves:

- independent capability evolution
- stable artifact contracts
- deterministic orchestration
- minimal coupling

---

# Consequences

## Positive

Capabilities remain independently testable.

Capabilities remain independently replaceable.

Domain Artifacts remain immutable.

Execution workflows become deterministic.

Orchestration becomes responsible for workflow composition rather than capability implementation.

---

## Negative

Orchestrators become responsible for maintaining Execution State.

Additional orchestration logic is required to compose Domain Artifacts into Execution State.

This complexity is intentional and preferred over increasing coupling between capabilities.

---

# Example

A capability produces a Domain Artifact.

```text
Platform Detection
        │
        ▼
Platform Description
```

An orchestrator composes Execution State.

```text
Execution State

├── Platform Description
```

Another capability consumes Execution State.

```text
Execution State
        │
        ▼
Prerequisite Validation
        │
        ▼
Validation Report
```

Execution State is then updated by orchestration.

```text
Execution State

├── Platform Description
└── Validation Report
```

The process repeats for each subsequent capability.

---

# Alternatives Considered

## Embed upstream Domain Artifacts

Rejected.

Embedding upstream artifacts transfers ownership responsibilities to downstream capabilities and increases coupling between artifact schemas.

---

## Rediscover upstream information

Rejected.

Capabilities should never repeat work already performed by another capability.

Rediscovery violates constitutional ownership and creates inconsistent behavior.

---

# Relationship to Other ADRs

Supports:

- ADR-0007: Responsibilities Outlive Implementations
- ADR-0009: Intent Over Models
- ADR-0012: Small Reversible Architecture
- ADR-0013: Capabilities Produce Domain Artifacts. Orchestrators Compose Them.

ADR-0014 defines how Domain Artifacts are assembled into executable workflows.

---

# Terminology

## Domain Artifact

The canonical structured output produced by a capability.

Each Domain Artifact has exactly one owner.

Examples:

- Platform Description
- Validation Report
- Package Plan

---

## Execution State

A transient composition of Domain Artifacts assembled by an orchestrator.

Execution State is not owned by any capability.

Execution State exists only for the lifetime of an execution workflow.

---

# Status

Accepted.

This decision applies to all MCU products.

Future orchestrators are expected to compose Execution State from immutable Domain Artifacts rather than modifying capability outputs.