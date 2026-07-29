
# ADR-0010 — Engineering Organization Model

Status

**Accepted**

---

## Context

Traditional AI systems are typically presented as individual assistants.

As workstation capabilities expanded, it became apparent that different engineering activities required fundamentally different responsibilities.

No single collaborator should own every capability.

---

## Decision

The Local Intelligence Platform is organized as an engineering organization.

Collaborators are defined by responsibilities rather than prompts.

Departments own related collaborators.

Collaborators may work independently or as councils.

---

## Rationale

Organizations naturally divide responsibility.

Examples include:

Engineering

* Engineer
* Architect
* Auditor

Business

* Analyst
* Writer

Creative

* Artist
* Director

Operations

* Researcher
* Librarian

This mirrors real engineering organizations while providing clear ownership boundaries.

---

## Consequences

### Positive

* Clear collaborator responsibilities.
* Reduced overlap.
* Easier long-term growth.
* Natural multi-collaborator workflows.

### Tradeoffs

* Organizational design becomes part of platform architecture.
* Collaboration requires orchestration.

---

## Related Decisions

* ADR-0007 — Responsibilities Outlive Implementations
* ADR-0008 — Local Intelligence Platform as a Sibling Platform
* ADR-0009 — Intent Over Models
