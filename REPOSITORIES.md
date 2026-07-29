# Repositories
## Repository Principles

Every repository has:

- A single constitutional responsibility.
- Clear ownership boundaries.
- Stable public interfaces.
- Replaceable implementations.
- No authority outside its defined responsibilities.
## Purpose

This document defines the constitutional responsibilities and boundaries of each repository within the ecosystem.

Repositories own responsibilities, not implementations. Technologies, tools, and frameworks may change over time without changing repository ownership.

---

# Workstation

## Mission

Prepare a deterministic, productive development workstation and provide the entry point into the ecosystem.

## Owns

- Platform detection
- Operating system configuration
- Package managers
- Shell configuration
- Git configuration
- Symlink management
- Developer tooling
- Bootstrap process
- Bootstrapping the Ecosystem package manager
- Delegating ecosystem commands

## Never Owns

- Capability definitions
- Capability registry
- Capability lifecycle
- AI runtimes
- Model management
- Lab implementations
- Business workflows

---

# Ecosystem

## Mission

Manage the lifecycle of ecosystem capabilities.

## Owns

- Capability registry
- Capability manifests
- Capability discovery
- Installation
- Updates
- Removal
- Dependency resolution
- Version management
- Health checks

## Never Owns

- Operating system configuration
- Shell configuration
- Package managers
- Git configuration
- Individual Lab implementations

---

# Engineering Lab

## Mission

Deliver engineering excellence through deterministic engineering methodologies, standards, and evidence-based recommendations.

## Owns

- Engineering methodology
- Engineering workflows
- Engineering standards
- Software architecture guidance
- Code quality
- Technical reviews
- Engineering planning
- Benchmarking
- Engineering knowledge

## Never Owns

- Creative decisions
- Creative assets
- Workstation configuration
- AI runtimes
- Model management
- Product strategy
- Business operations

## Authority

Engineering Lab may recommend engineering decisions.

Engineering Lab does not make engineering decisions.

The CEO approves strategic technology choices.

---

# Image Lab

## Mission

Deliver creative excellence through deterministic creative workflows and consistent creative systems.

## Owns

- Creative workflows
- Prompt construction
- Creative assets
- Creative consistency
- Creative validation
- Asset metadata
- Creative project organization

## Never Owns

- Workstation configuration
- LLM installation
- Model downloads
- Technical engineering methodology
- Cross-discipline planning
- Ecosystem management
- General-purpose automation

## Interfaces

Defines the public commands, APIs, or services exposed by this repository.

## Dependencies

Defines the repositories this repository is permitted to depend upon.
