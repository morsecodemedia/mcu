# ADR-0009 — Intent Over Implementations

**Status**

**Reaffirmed**

---

## Context

Modern software systems frequently expose implementation details directly to users.

Users are often expected to choose technologies, language models, runtimes, frameworks, or tools before accomplishing useful work.

This places implementation concerns ahead of user intent.

As the MCU evolved into a digital consulting organization, it became clear that users naturally think in terms of outcomes rather than implementations.

The organization should determine how work is performed.

The user should determine what they want to accomplish.

---

## Decision

The MCU exposes intent rather than implementations.

Users express the outcome they wish to achieve.

The organization determines the appropriate discipline, repository, capability, workflow, worker, implementation, and technology required to fulfill that intent.

Implementations remain replaceable.

Intent remains stable.

---

## Rationale

Users naturally think in terms of problems rather than implementations.

Examples include:

- Engineer a solution.
- Review my code.
- Generate creative assets.
- Write documentation.
- Develop a strategy.

rather than:

- GPT-5
- Qwen
- Claude
- ComfyUI
- Go
- Python
- Whatever comes next

Intent evolves slowly.

Implementations evolve rapidly.

Separating intent from implementation creates a stable experience while allowing the ecosystem to evolve.

---

## Consequences

### Positive

- Stable user experience.
- Replaceable implementations.
- Reduced cognitive overhead.
- Consistent organizational behavior.
- Simplified future evolution.

### Tradeoffs

- Implementation orchestration becomes more sophisticated.
- The organization assumes responsibility for selecting appropriate implementations.
- Capabilities require well-defined interfaces.

---

## Relationship to the Constitution

This Architectural Decision supports the following constitutional principles:

- Responsibilities outlive implementations.
- Stable interfaces enable replaceable implementations.
- Human-led governance.
- Recommendations over authority.
- Every repository has a single constitutional responsibility.

---

## Examples

### Engineering Lab

User Intent:

> Review this repository.

Engineering Lab determines:

- Discovery workflow
- Review methodology
- Appropriate workers
- Supporting technologies

The user does not choose implementation details.

---

### Image Lab

User Intent:

> Create marketing artwork.

Image Lab determines:

- Creative workflow
- Asset pipeline
- Generation technology
- Validation process

Creative tooling remains an implementation detail.

---

### Workstation

User Intent:

> Install Engineering Lab.

Workstation determines:

- Platform compatibility
- Ecosystem Package Manager
- Installation workflow
- Repository sources

The installation mechanism is hidden behind a stable interface.

---

## Consequences for Future Architecture

Every new capability should expose user intent rather than implementation choices.

Implementation technologies may evolve independently without changing the user experience.

Users interact with organizational capabilities.

Capabilities determine implementations.

---

## Related Decisions

- ADR-0006 — Deterministic Before Probabilistic
- ADR-0007 — Responsibilities Outlive Implementations
- ADR-0002 — Layered Platform Architecture
