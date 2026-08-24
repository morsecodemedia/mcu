# ADR 0019: Evidence

## Status

Accepted

---

## Context

As Engineering Lab evolved, Runtime providers became responsible for discovering engineering facts.

Knowledge Packages became responsible for teaching engineering reasoning.

An intermediate abstraction was required to decouple engineering reasoning from Runtime implementations.

Without this abstraction, engineering tasks became tightly coupled to Runtime providers and rendered representations.

---

## Decision

Engineering tasks SHALL consume Evidence rather than Runtime providers.

Evidence represents the information required to reason about an engineering problem.

Evidence is task-independent.

Evidence is produced by Evidence Providers.

Knowledge Packages consume Evidence through the Knowledge Composer.

The execution engine remains unaware of how Evidence is collected.

---

## Responsibilities

Runtime

- discovers engineering facts.

Renderers

- transform engineering facts into representations.

Evidence

- exposes reasoning material.

Knowledge Packages

- define engineering methodology.

Composers

- combine knowledge with evidence.

Inference

- performs reasoning.

Interpreters

- normalize responses.

Each subsystem owns one responsibility.

---

## Consequences

Engineering tasks no longer depend directly upon Runtime implementations.

New Runtime providers may be introduced without modifying Knowledge Packages.

Multiple tasks may consume identical Evidence.

Evidence becomes reusable across products and execution engines.

The execution engine becomes increasingly implementation-independent.

---

## Future Evolution

Evidence currently exposes rendered engineering representations.

Future revisions may expose structured engineering payloads while preserving the existing execution model.

Representation independence remains a long-term architectural objective.

---

## Related ADRs

- ADR 0013 — Capability Artifact Composition
- ADR 0014 — Orchestrators Compose Execution State
- ADR 0015 — Artifact Lifecycle
- ADR 0018 — Knowledge Packages