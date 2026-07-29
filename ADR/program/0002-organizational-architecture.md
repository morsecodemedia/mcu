# ADR-0002 — Organizational Architecture

**Status**

**Reaffirmed**

---

## Context

As the ecosystem expanded beyond a single workstation, it became clear that traditional layered software architectures were insufficient to describe the responsibilities of the organization.

The MCU is not a monolithic application.

It is a digital consulting organization composed of disciplines, repositories, capabilities, and workers that collaborate through defined governance and workflows.

Architectural decisions should therefore model organizational responsibilities before implementation details.

---

## Decision

The MCU is organized as a layered organization.

```text
CEO
    ↓
High Council
    ↓
Disciplines
    ↓
Repositories (Labs)
    ↓
Capabilities
    ↓
Workers
    ↓
Implementations
```

Each layer owns a single constitutional responsibility.

Each layer depends only on the layer immediately beneath it.

Authority flows downward.

Responsibility flows upward.

Implementations remain replaceable.

---

## Rationale

An organizational architecture provides:

- Clear ownership.
- Stable governance.
- Explicit responsibility boundaries.
- Replaceable implementations.
- Natural scalability.
- Independent evolution of repositories.

The organizational model mirrors successful consulting organizations while remaining implementation-agnostic.

---

## Consequences

### Positive

- Responsibilities are explicit.
- Governance becomes consistent.
- Repository boundaries become stable.
- New disciplines and Labs integrate without architectural redesign.
- Technology choices remain implementation details.

### Tradeoffs

- Organizational discipline becomes essential.
- Some workflows require coordination across multiple repositories.
- Cross-disciplinary work requires governance rather than direct ownership.

---

## Relationship to the Constitution

This Architectural Decision supports the following constitutional principles:

- Human-led governance.
- Every repository has a single constitutional responsibility.
- Responsibilities outlive implementations.
- Stable interfaces enable replaceable implementations.
- Recommendations over authority.

---

## Organizational Layers

### CEO

Owns strategic direction and final decision-making authority.

---

### High Council

Coordinates work across disciplines.

Provides organizational oversight.

Does not implement work.

---

### Disciplines

Own organizational standards and responsibilities.

Examples include:

- Technical
- Creative
- Writing
- Strategy
- Operations

---

### Repositories (Labs)

Implement the responsibilities of their parent discipline.

Examples include:

- Workstation
- Engineering Lab
- Image Lab

---

### Capabilities

Provide reusable services within a repository.

Capabilities may collaborate but never assume ownership outside their repository.

---

### Workers

Perform individual units of work.

Workers may be:

- AI
- Humans
- Scripts
- Services

Workers execute responsibilities delegated by capabilities.

---

### Implementations

Programming languages, frameworks, models, runtimes, and tooling remain replaceable implementation details.

---

## Consequences for Future Architecture

Future growth should introduce new disciplines, repositories, capabilities, or workers without requiring changes to the organizational architecture itself.

Architectural proposals should establish organizational ownership before implementation strategy.

---

## Related Decisions

- ADR-0006 — Deterministic Before Probabilistic
- ADR-0007 — Responsibilities Outlive Implementations
- ADR-0009 — Intent Over Models
