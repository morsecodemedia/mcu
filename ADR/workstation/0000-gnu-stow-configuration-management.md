
# ADR-0000 — GNU Stow Configuration Management

Status

**Accepted**

---

## Context

The workstation required a reproducible method for managing configuration across multiple machines without manually copying files or maintaining custom installation logic for every configuration file.

Configuration needed to remain modular, transparent, and easy to evolve over time.

---

## Decision

Adopt GNU Stow as the workstation configuration management layer.

Individual workstation capabilities are organized into logical packages.

The installer is responsible for orchestrating package installation rather than managing individual symbolic links.

---

## Rationale

GNU Stow provides:

* Declarative configuration management.
* Modular package organization.
* Idempotent installation.
* Simple rollback through symbolic links.
* Clear ownership boundaries.

The resulting repository structure scales naturally as new workstation capabilities are introduced.

---

## Consequences

### Positive

* Configuration becomes reproducible.
* Installation remains predictable.
* Packages remain independently evolvable.
* Ownership boundaries are explicit.

### Tradeoffs

* Developers must understand symbolic links.
* Repository organization requires discipline.

---

## Related Decisions

* ADR-0001 — Homebrew-first Runtime
* ADR-0002 — Layered Platform Architecture
