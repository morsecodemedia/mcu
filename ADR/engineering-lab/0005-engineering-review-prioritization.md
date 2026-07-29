
# ADR-0005 — Engineering Review Prioritization

Status

**Accepted**

---

## Context

Early versions of the Review Engine attempted to communicate engineering confidence through numeric scoring.

While technically functional, confidence scores provided limited guidance regarding where engineers should actually focus their attention.

Repository evidence alone was insufficient to improve engineering decision-making.

---

## Decision

The Engineering Review Engine prioritizes engineering attention rather than calculating engineering confidence.

Review transforms repository evidence into:

* Engineering Focus
* Engineering Context
* Recommendations

Engineering priorities replace confidence scores.

---

## Rationale

Experienced engineers naturally ask:

* What deserves my attention?
* Why does it matter?
* What should I do next?

Engineering prioritization answers these questions directly.

Confidence scores do not.

The purpose of Review is to improve engineering judgment rather than quantify engineering uncertainty.

---

## Consequences

### Positive

* Engineering output becomes actionable.
* Review aligns with real engineering workflows.
* Cognitive load decreases.
* Recommendations become naturally prioritized.

### Tradeoffs

* Engineering priorities require deterministic engineering knowledge.
* The Review Engine becomes dependent on the Knowledge Engine.

---

## Related Decisions

* ADR-0004 — Knowledge Owns Engineering Meaning
* ADR-0006 — Deterministic Before Probabilistic
* ADR-0007 — Responsibilities Outlive Implementations
