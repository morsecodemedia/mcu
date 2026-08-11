# ADR-0013: Capabilities Produce Domain Artifacts. Orchestrators Compose Them.

- **Status:** Accepted
- **Date:** 2026-08-11
- **Scope:** Program

---

# Context

The MCU is composed of independent capabilities.

Each capability owns exactly one constitutional responsibility.

As Workstation evolved, multiple capabilities began producing structured outputs.

Examples include:

- Platform Detection → Platform Description
- Prerequisite Validation → Validation Report
- Package Management → Package Plan

These artifacts are consumed by downstream capabilities.

As additional capabilities were introduced, an architectural question emerged:

> Should capabilities embed upstream artifacts in their own outputs, or should orchestration compose multiple artifacts into a shared execution context?

This decision affects every MCU product.

---

# Decision

Capabilities own exactly one domain artifact.

Capabilities produce artifacts.

Capabilities consume artifacts.

Capabilities do not modify, embed, or enrich another capability's artifact.

Artifact composition is the responsibility of orchestration.

---

# Rationale

Capabilities should remain independent.

A capability should not become responsible for preserving the outputs of upstream capabilities.

For example:

Platform Detection owns the Platform Description.

Prerequisite Validation owns the Validation Report.

Package Management owns the Package Plan.

Each artifact represents the complete output of its owning capability.

When downstream capabilities require multiple artifacts, those artifacts are composed by an orchestrator rather than merged by individual capabilities.

This preserves clear ownership boundaries and prevents unnecessary coupling.

---

# Consequences

## Positive

Capabilities remain independently testable.

Capabilities remain independently replaceable.

Artifacts remain stable contracts.

Ownership remains unambiguous.

Downstream capabilities can evolve without forcing upstream artifact changes.

Orchestrators remain responsible for workflow rather than capability implementation.

---

## Negative

Orchestrators become responsible for assembling execution context.

Multiple artifacts may need to be transported together between stages of a workflow.

This additional orchestration complexity is intentional and preferred over coupling capabilities together.

---

# Example

The following pipeline demonstrates independent capability ownership.

```text
Platform Detection
        │
        ▼
Platform Description

Prerequisite Validation
        │
        ▼
Validation Report

Package Management
        │
        ▼
Package Plan
```

Package Management does not consume a Validation Report that embeds a Platform Description.

Instead, an orchestrator composes an execution context containing both artifacts.

```text
Execution Context

├── Platform Description
└── Validation Report

        │
        ▼

Package Management
```

---

# Alternatives Considered

## Embed upstream artifacts

Rejected.

Embedding upstream artifacts causes downstream capabilities to inherit responsibilities they do not own.

This leads to tightly coupled artifact schemas and unnecessary duplication.

---

## Recompute upstream artifacts

Rejected.

Capabilities should never rediscover information already owned by another capability.

Doing so violates responsibility boundaries and introduces inconsistent behavior.

---

# Relationship to Other ADRs

Supports:

- ADR-0007: Responsibilities Outlive Implementations
- ADR-0009: Intent Over Models
- ADR-0012: Small Reversible Architecture

This ADR defines how independent capabilities communicate while preserving those principles.

---

# Status

Accepted.

This decision applies to all MCU products.

Future capabilities are expected to produce domain artifacts and rely upon orchestration for artifact composition rather than embedding upstream outputs.

---

# Terminology

## Domain Artifact

The canonical structured output produced by a capability.

A Domain Artifact is owned by exactly one capability.

Examples:

- Platform Description
- Validation Report
- Package Plan

---

## Execution Context

A collection of Domain Artifacts assembled by an orchestrator and provided to downstream capabilities.

Execution Contexts are transient.

They are composed rather than owned.