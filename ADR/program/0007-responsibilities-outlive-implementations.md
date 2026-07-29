# ADR-0007 — Responsibilities Outlive Implementations

**Status**

**Reaffirmed**

---

## Context

Technologies evolve continuously.

Programming languages, frameworks, AI models, inference runtimes, package managers, and tooling all change over time.

Architectures built around implementation choices require continual redesign as technology evolves.

As the ecosystem matured, it became clear that long-term stability comes from defining systems according to the responsibilities they own rather than the technologies used to implement them.

---

## Decision

The MorseCodeUniverse (MCU) defines organizations, disciplines, repositories, capabilities, and workers according to the responsibilities they own.

Responsibilities are constitutional.

Implementations are evolutionary.

Technologies, frameworks, models, and tooling remain replaceable implementation details that may evolve independently without changing organizational ownership.

---

## Rationale

Responsibilities evolve slowly.

Implementations evolve rapidly.

Designing around responsibilities provides:

- Stable architecture.
- Replaceable implementations.
- Long-term maintainability.
- Clear ownership boundaries.
- Consistent governance.

This principle applies across the entire MCU.

Every repository, discipline, capability, and worker is defined by its constitutional responsibility rather than its current implementation.

---

## Consequences

### Positive

- Architecture remains stable as technologies evolve.
- Repository ownership remains clear.
- Implementations can be replaced without changing organizational structure.
- New capabilities integrate naturally into the existing architecture.
- Documentation remains focused on ownership rather than tooling.

### Tradeoffs

- Architectural discipline becomes increasingly important.
- Additional abstraction is required during design.
- Implementations must conform to constitutional responsibilities rather than define them.

---

## Relationship to the Constitution

This Architectural Decision supports the following constitutional principles:

- Repositories own responsibilities, not implementations.
- Every repository has a single constitutional responsibility.
- Stable interfaces enable replaceable implementations.
- Disciplines own standards.
- Capabilities execute standards.
- Human authority governs strategic decisions while implementations remain replaceable.

---

## Examples

The following examples demonstrate this principle in practice.

### Workstation

Owns:

- Developer workstation provisioning.

Does not own:

- Homebrew
- GNU Stow
- Bash
- Any specific operating system tooling

---

### Engineering Lab

Owns:

- Engineering excellence.

Does not own:

- Go
- Rust
- Python
- Any specific programming language

---

### Image Lab

Owns:

- Creative excellence.

Does not own:

- ComfyUI
- FLUX
- Stable Diffusion
- Any specific creative tooling

---

### Ecosystem

Owns:

- Capability lifecycle management.

Does not own:

- Any individual Lab implementation.

---

## Consequences for Future Architecture

New repositories, capabilities, and Labs should always be defined by the responsibilities they own.

Implementation technologies may change over time without requiring changes to repository ownership or organizational structure.

When evaluating architectural proposals, responsibility should always be established before implementation.

---

## Related Decisions

- ADR-0002 — Layered Platform Architecture
- ADR-0006 — Deterministic Before Probabilistic
- ADR-0008 — Local Intelligence Platform as a Sibling Platform
- ADR-0009 — Intent Over Models
