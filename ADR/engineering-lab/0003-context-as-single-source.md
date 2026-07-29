
# ADR-0003 — Context as the Single Source of Engineering Context

Status

**Accepted**

---

## Context

Multiple workstation products required access to repository state, runtime information, and engineering metadata.

Allowing each product to collect this information independently would duplicate implementation, increase maintenance, and eventually produce inconsistent engineering behavior.

---

## Decision

Introduce the Context Engine as the single source of engineering context.

All workstation products consume the Context Engine.

Products must never independently collect engineering context that already exists within the Context Engine.

---

## Rationale

Centralizing engineering context:

* Eliminates duplicate implementation.
* Produces consistent engineering behavior.
* Simplifies future products.
* Allows engineering context to evolve independently from consumers.

The Context Engine owns engineering state.

Consumers own engineering behavior.

---

## Consequences

### Positive

* One authoritative engineering context.
* Reduced implementation complexity.
* Consistent behavior across products.

### Tradeoffs

* New products depend on the Context Engine.
* Context becomes a foundational platform API.

---

## Related Decisions

* ADR-0002 — Layered Platform Architecture
* ADR-0004 — Knowledge Owns Engineering Meaning
