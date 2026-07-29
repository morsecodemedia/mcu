
# ADR-0001 — Homebrew-first Runtime

Status

**Accepted**

---

## Context

Modern workstation tooling increasingly depends on features unavailable in the macOS system-provided utilities, particularly the legacy Bash 3.2 runtime.

Maintaining compatibility with outdated system tooling increased implementation complexity while limiting platform capabilities.

---

## Decision

The workstation standardizes on a Homebrew-managed runtime.

Homebrew-provided tools are considered the canonical execution environment.

The macOS system runtime is not a supported target.

---

## Rationale

A Homebrew-first runtime provides:

* Modern Bash features.
* Consistent tooling across machines.
* Faster access to updated utilities.
* Reduced compatibility work.
* Simpler engineering decisions.

---

## Consequences

### Positive

* Modern shell features become available.
* Implementation complexity decreases.
* Runtime behavior becomes predictable.

### Tradeoffs

* Homebrew becomes a required dependency.
* Initial workstation bootstrap becomes more opinionated.

---

## Related Decisions

* ADR-0000 — GNU Stow Configuration Management
* ADR-0012 — Small, Reversible Architecture
