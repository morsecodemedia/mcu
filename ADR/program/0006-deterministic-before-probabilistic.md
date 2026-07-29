# ADR-0006 — Deterministic Before Probabilistic

**Status**

**Reaffirmed**

---

## Context

Modern software engineering increasingly incorporates artificial intelligence and other probabilistic systems.

These systems excel at synthesis, creativity, exploration, and generating recommendations. However, their outputs are inherently probabilistic and may vary between executions.

The MCU is designed to be a durable engineering organization. Durable organizations require a deterministic foundation for knowledge, governance, and repeatable execution.

Without deterministic foundations, recommendations become difficult to explain, architecture becomes difficult to govern, and organizational knowledge becomes increasingly inconsistent over time.

---

## Decision

The MCU adopts deterministic reasoning as the foundation of organizational knowledge.

Probabilistic systems are permitted only to enrich deterministic understanding.

Artificial intelligence and other probabilistic systems must never replace explicit organizational knowledge where deterministic knowledge can reasonably exist.

Deterministic systems establish truth.

Probabilistic systems generate recommendations.

---

## Rationale

Deterministic systems provide:

- Repeatability
- Explainability
- Stability
- Predictability
- Governance

Probabilistic systems provide:

- Exploration
- Creativity
- Research
- Synthesis
- Recommendation

The MCU combines both approaches while preserving deterministic organizational behavior.

---

## Consequences

### Positive

- Organizational behavior remains explainable.
- Recommendations remain evidence-based.
- Knowledge remains explicit and reviewable.
- AI becomes an accelerator rather than an authority.
- Constitutional governance remains stable as AI technologies evolve.

### Tradeoffs

- Explicit knowledge requires ongoing stewardship.
- Some organizational knowledge must be authored rather than inferred.
- Probabilistic systems cannot become the authoritative source of organizational truth.

---

## Relationship to the Constitution

This Architectural Decision supports the following constitutional principles:

- Human-led governance.
- Recommendations over authority.
- Stable interfaces.
- Replaceable implementations.
- Repositories own responsibilities, not implementations.
- Disciplines own standards.
- Capabilities execute standards.

---

## Examples

The following examples demonstrate this principle in practice.

### Engineering Lab

Engineering audits are deterministic.

Recommendations may be generated through probabilistic analysis.

Final engineering guidance is grounded in deterministic standards and documented evidence.

---

### Image Lab

Creative workflows may use probabilistic generation.

Creative consistency, references, and asset organization remain deterministic.

---

### Strategy Lab

AI may propose strategies and alternatives.

Strategic recommendations are evaluated against deterministic organizational goals, metrics, and governance.

---

### Workstation

Installation procedures, configuration, and capability management remain deterministic.

AI may assist with troubleshooting and recommendations without becoming part of the installation process itself.

---

## Consequences for Future Architecture

Every new capability should identify:

- What knowledge must remain deterministic.
- Where probabilistic systems may provide value.
- How deterministic governance validates probabilistic recommendations.

Deterministic knowledge should always establish the foundation upon which probabilistic systems operate.

---

## Related Decisions

- ADR-0007 — Responsibilities Outlive Implementations
- ADR-0009 — Intent Over Models
- ADR-0002 — Layered Platform Architecture
