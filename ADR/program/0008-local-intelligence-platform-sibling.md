# ADR-0008 — Independent Organizational Capabilities

**Status**

**Reaffirmed**

---

## Context

As the MCU evolved beyond a single engineering workstation, it became clear that different responsibilities solve fundamentally different problems.

Attempting to combine multiple responsibilities into a single repository or capability creates unnecessary coupling, unclear ownership, and reduced long-term flexibility.

Capabilities should collaborate.

They should not absorb each other's responsibilities.

---

## Decision

The MCU is composed of independent repositories and capabilities.

Each repository owns a single constitutional responsibility.

Repositories collaborate through explicit interfaces.

No repository owns the responsibilities of another repository.

Capabilities remain independently installable, independently evolvable, and independently replaceable.

---

## Rationale

Independent capabilities provide:

- Clear ownership.
- Stable repository boundaries.
- Independent evolution.
- Replaceable implementations.
- Simpler governance.
- Reduced coupling.

Repositories should communicate through defined interfaces rather than shared ownership.

This allows the organization to grow by adding new capabilities rather than expanding existing responsibilities.

---

## Consequences

### Positive

- Repository boundaries remain stable.
- Capabilities evolve independently.
- New Labs integrate without architectural redesign.
- Technology choices remain local to each repository.
- Cross-repository collaboration becomes explicit.

### Tradeoffs

- Collaboration requires well-defined interfaces.
- Some workflows span multiple repositories and require orchestration.
- Repository boundaries require ongoing architectural discipline.

---

## Relationship to the Constitution

This Architectural Decision supports the following constitutional principles:

- Every repository has a single constitutional responsibility.
- Responsibilities outlive implementations.
- Stable interfaces enable replaceable implementations.
- Recommendations over authority.
- Human-led governance.

---

## Examples

### Workstation

Owns:

- Developer workstation provisioning.

Does not own:

- Engineering workflows.
- Creative workflows.
- Capability implementations.

---

### Ecosystem

Owns:

- Capability lifecycle management.

Does not own:

- Workstation provisioning.
- Engineering excellence.
- Creative excellence.

---

### Engineering Lab

Owns:

- Engineering excellence.

Collaborates with:

- Image Lab
- Workstation
- Ecosystem

Engineering Lab never assumes ownership of another repository's responsibilities.

---

### Image Lab

Owns:

- Creative excellence.

Collaborates with:

- Engineering Lab
- Ecosystem

Creative responsibilities remain independent from technical responsibilities.

---

## Consequences for Future Architecture

Future repositories should be introduced by assigning new responsibilities rather than expanding existing ones.

When architectural questions arise, responsibility ownership should be established before implementation strategy.

Repositories collaborate through explicit interfaces while preserving independent ownership.

---

## Related Decisions

- ADR-0002 — Organizational Architecture
- ADR-0006 — Deterministic Before Probabilistic
- ADR-0007 — Responsibilities Outlive Implementations
- ADR-0009 — Intent Over Models
