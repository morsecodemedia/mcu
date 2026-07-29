
# ADR-0004 — Knowledge Owns Engineering Meaning

Status

**Accepted**

---

## Context

Engineering products require explanations, engineering domains, recommendations, and future enrichments.

Embedding engineering understanding directly into products would tightly couple implementation with knowledge and make future improvements increasingly difficult.

---

## Decision

Engineering knowledge is owned exclusively by the Knowledge Engine.

Products consume engineering knowledge.

Products do not own engineering understanding.

---

## Rationale

Separating knowledge from products allows:

* Reusable engineering understanding.
* Independent evolution of engineering knowledge.
* Simpler product implementations.
* Shared behavior across multiple products.

Knowledge becomes a reusable platform capability.

---

## Consequences

### Positive

* Products become thinner.
* Engineering knowledge becomes reusable.
* Future capabilities inherit engineering understanding automatically.

### Tradeoffs

* Products require explicit knowledge records.
* Knowledge becomes a critical platform dependency.

---

## Related Decisions

* ADR-0003 — Context as the Single Source of Engineering Context
* ADR-0005 — Engineering Review Prioritization
* ADR-0006 — Deterministic Before Probabilistic
