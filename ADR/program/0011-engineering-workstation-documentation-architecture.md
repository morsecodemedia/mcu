# ADR-0011 — Documentation Mirrors Architecture

**Status**

**Reaffirmed**

---

## Context

As the MCU evolved into multiple repositories, disciplines, and capabilities, documentation became increasingly difficult to organize.

Documents naturally accumulated around topics rather than ownership, leading to duplication, inconsistent terminology, and unclear responsibility.

Without explicit ownership, documentation becomes difficult to maintain as the architecture evolves.

---

## Decision

Documentation is organized according to the architecture of the MCU.

The MCU owns ecosystem-wide documentation.

Each repository owns its own documentation.

Each capability owns its own design documentation.

Historical architectural decisions are maintained independently through Architectural Decision Records (ADRs).

Documentation ownership follows architectural ownership.

---

## Rationale

Documentation should mirror the architecture it describes.

Every document should answer exactly one question.

Every document should have exactly one owner.

Every owner should be responsible for maintaining the documentation that describes the responsibilities they own.

This creates documentation that evolves naturally alongside the architecture while minimizing duplication.

---

## Consequences

### Positive

- Clear documentation ownership.
- Consistent navigation.
- Reduced duplication.
- Easier long-term maintenance.
- Documentation evolves with the architecture.
- Repository documentation remains independently maintainable.

### Tradeoffs

- Architectural discipline is required.
- Documentation may need to move when responsibilities change.
- Cross-repository topics require references rather than duplication.

---

## Relationship to the Constitution

This Architectural Decision supports the following constitutional principles:

- Every repository has a single constitutional responsibility.
- Responsibilities outlive implementations.
- Stable organizational boundaries.
- Clear ownership.
- Independent repository evolution.

---

## Documentation Hierarchy

### MCU

Owns documentation that defines the organization itself.

Examples include:

- Vision
- Values
- Organization
- Governance
- Workflow
- Disciplines
- Repositories
- Version Definitions
- Architectural Decision Records
- Planning documentation

---

### Repositories

Each repository owns documentation describing its own mission, architecture, capabilities, and implementation.

Examples include:

- Architecture
- Design
- APIs
- Configuration
- Repository ADRs

Repositories should not duplicate documentation owned by the MCU or other repositories.

---

### Capabilities

Capabilities own documentation specific to the services they provide.

Capabilities document:

- Responsibilities
- Interfaces
- Configuration
- Operational behavior

Capability documentation should remain local to the owning repository.

---

## Consequences for Future Architecture

As new repositories and capabilities are introduced, documentation ownership should be determined by constitutional responsibility before documentation is created.

Cross-cutting concepts should be documented once by their owner and referenced elsewhere rather than duplicated.

---

## Related Decisions

- ADR-0002 — Organizational Architecture
- ADR-0007 — Responsibilities Outlive Implementations
- ADR-0008 — Independent Organizational Capabilities
