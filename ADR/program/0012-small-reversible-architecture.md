# ADR-0012 — Small, Reversible Architecture

**Status**

**Reaffirmed**

---

## Context

Large architectural rewrites introduce significant risk and reduce confidence during development.

As the MCU evolved from an engineering workstation into a digital consulting organization, the highest-quality architectural improvements consistently emerged through incremental discovery, validation, and refinement rather than large up-front redesigns.

Architectural understanding should evolve alongside implementation rather than precede it entirely.

---

## Decision

The MCU evolves through small, reversible architectural changes.

Architectural decisions should be validated through implementation before becoming permanent organizational standards.

Migration should favor:

- Introduce
- Validate
- Adopt
- Retire

rather than immediate replacement.

Large architectural changes should be decomposed into independently reviewable and reversible steps whenever practical.

---

## Rationale

Incremental architectural evolution:

- Reduces implementation risk.
- Simplifies validation.
- Improves confidence.
- Preserves organizational stability.
- Encourages continuous learning.
- Produces architecture grounded in real experience.

Architecture should be earned through working systems.

---

## Consequences

### Positive

- Safer architectural evolution.
- Easier rollback.
- Continuous validation.
- Higher implementation confidence.
- Better long-term maintainability.
- Organizational knowledge improves through experience rather than assumption.

### Tradeoffs

- Temporary duplication during migration.
- Longer transition periods for major architectural changes.
- Requires discipline to avoid prematurely optimizing the architecture.

---

## Relationship to the Constitution

This Architectural Decision supports the following constitutional principles:

- Human-led governance.
- Responsibilities outlive implementations.
- Stable interfaces enable replaceable implementations.
- Independent repository evolution.
- Recommendations over authority.

---

## Examples

### Repository Evolution

A repository should evolve through small, validated improvements rather than wholesale redesign.

Repository boundaries are refined through implementation experience.

---

### Organizational Growth

New disciplines, repositories, and capabilities should be introduced incrementally.

The organizational structure should expand through validated experience rather than speculative design.

---

### Documentation

Constitutional documents should stabilize before implementation guidance.

Implementation documentation should evolve as repositories mature.

---

### Architectural Decisions

Architectural Decision Records should be reviewed, reaffirmed, revised, or superseded as understanding improves.

Architectural history should be preserved rather than rewritten.

---

## Consequences for Future Architecture

Architectural proposals should favor incremental evolution over comprehensive redesign.

Questions that cannot yet be answered should be intentionally deferred until additional evidence is available.

Every architectural change should be small enough to understand, validate, and reverse if necessary.

---

## Related Decisions

- ADR-0002 — Organizational Architecture
- ADR-0006 — Deterministic Before Probabilistic
- ADR-0007 — Responsibilities Outlive Implementations
- ADR-0008 — Independent Organizational Capabilities
- ADR-0009 — Intent Over Models
