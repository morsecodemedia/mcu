# ADR 0018: Knowledge Packages

## Status

Accepted

---

## Context

As the MCU platform evolved, Engineering Lab introduced
AI-assisted engineering capabilities.

Initially, engineering behavior was implemented directly
within shell scripts and prompt implementations.

This tightly coupled engineering expertise to executable
software, making new capabilities require software
changes rather than knowledge authoring.

The platform required a mechanism for representing
engineering expertise as version-controlled artifacts
that could evolve independently of execution behavior.

---

## Decision

Engineering expertise SHALL be represented as
Knowledge Packages.

A Knowledge Package is a collection of artifacts that
describe how a particular engineering task should be
performed.

Knowledge Packages are executed by the Knowledge
Execution Engine but remain independent of the execution
implementation.

Knowledge Packages SHALL contain independent artifacts
with clearly defined responsibilities.

Example:

knowledge/

    repository/

        review/

            definition.json
            instructions.md
            background.md
            assumptions.md
            principles.md
            calibration.md
            expectations.md
            README.md

---

## Responsibilities

Each artifact owns a single concern.

definition.json

: Execution metadata.

instructions.md

: Task objective.

background.md

: Institutional and architectural context.

assumptions.md

: Default execution assumptions.

principles.md

: Engineering philosophy.

calibration.md

: Engineering reasoning examples.

expectations.md

: Expected behavioral characteristics.

README.md

: Human-oriented documentation.

Knowledge Packages SHOULD avoid duplicating information
between artifacts.

---

## Consequences

Engineering capabilities become additive.

Adding a new engineering capability SHOULD primarily
require authoring knowledge rather than modifying
software.

Execution behavior becomes stable while engineering
expertise evolves through version-controlled knowledge.

Knowledge becomes reusable across multiple execution
engines, products, and future implementations.

Knowledge therefore outlives implementation.

---

## Related ADRs

- ADR 0013 — Capability Artifact Composition
- ADR 0014 — Orchestrators Compose Execution State
- ADR 0015 — Artifact Lifecycle