# ADR-0001

## Title

NextGen Workstation is AI-agnostic.

## Decision

NextGen Workstation provides a complete developer workstation.

It does not install or require AI tooling.

AI capabilities are optional layers that can be installed after the workstation is complete.

## Consequences

- NextGen Workstation remains useful on constrained hardware.
- Raspberry Pi, cloud VMs, and older laptops remain supported.
- AI runtimes become independent installable capabilities.
- The workstation is valuable even for users who never use AI.

# ADR-0002

## Title

The ecosystem is composed of independent capabilities.

## Decision

Every major component of the ecosystem is a capability.

Capabilities:

- are independently installable
- are independently upgradeable
- are independently removable
- own their own repositories
- own their own lifecycle

The workstation manages capabilities.

Capabilities do not manage each other.

## Consequences

- Image Lab can exist without Engineering Agent.
- Engineering Agent can exist without Image Lab.
- Future capabilities follow the same model.
- The workstation becomes a capability manager rather than an application launcher.

# ADR-0003

## Title

Capabilities are installed from a registry.

## Decision

The workstation installs capabilities from a registry.

The registry is an abstraction.

Possible implementations include:

- local manifest
- git repository
- remote service

The installer never depends on a specific registry implementation.

## Version 1

Version 1 will use a local registry maintained by the ecosystem.

The registry format should remain compatible with future implementations.

# ADR-0004

## Title

Engineering Agent is renamed to Engineering Lab.

## Decision

The Technical Discipline capability will be known as Engineering Lab.

## Rationale

The capability represents an engineering discipline rather than an autonomous agent.

The ecosystem is organized around Labs that provide expertise within a discipline.

Workers (AI or human) perform work inside the lab.

The lab itself is the organizational capability.

## Consequences

- Engineering Agent → Engineering Lab
- Future references should use Engineering Lab.

# ADR-0005

## Title

NextGen Workstation is renamed to Workstation.

## Decision

The Platform capability will be known simply as Workstation.

## Rationale

Within the ecosystem, there is only one workstation.

The "NextGen" branding is useful externally but unnecessary internally.

Using "Workstation" keeps the organizational language concise and consistent.

## Consequences

- NextGen Workstation → Workstation
- Internal documentation should use Workstation.
