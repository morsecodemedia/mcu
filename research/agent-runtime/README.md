# Agent Runtime Research

## Purpose

This research investigates how MCU should support persistent AI workers without
making the ecosystem dependent on a single external agent framework.

The goal is not to reproduce or integrate any one project.

The goal is to identify durable architectural primitives that appear across
independent implementations, determine which concepts MCU should own, and keep
external runtimes and frameworks behind replaceable boundaries.

## Research Question

> What are the smallest durable primitives MCU should own if Labs are allowed
> to employ persistent AI workers across multiple runtimes, environments, and
> workflows?

## Repositories Studied

The initial comparative study examined three independently designed systems:

- OpenRig
- Paperclip
- OpenDots

They were selected because they approach persistent agents from substantially
different product perspectives.

### OpenRig

OpenRig approaches the problem as a durable control plane for engineering
agents and workflows.

Relevant themes included:

- logical agent topology
- runtime adapters
- startup and readiness
- context projection
- session continuity
- durable workflow execution
- event history
- recovery
- human gates
- evidence

### Paperclip

Paperclip approaches the problem as an organizational control plane for
autonomous AI workers.

Relevant themes included:

- persistent agent identity
- runtime adapters
- bounded heartbeat executions
- session continuity
- goals
- projects
- tasks
- delegation
- approvals
- budgets
- organizational hierarchy
- run history

### OpenDots

OpenDots approaches the problem as a human-centered workspace containing
persistent specialist agents.

Relevant themes included:

- specialist identity
- bounded runs
- workspaces
- persistent execution environments
- conversations
- pages and artifacts
- human review
- tool permissions
- scheduled work
- preferences
- automatic learning
- skills

## Comparative Findings

### Persistent identity is separate from execution

All three systems distinguish the durable identity of an agent from the
execution mechanism currently performing work.

MCU should not model an Agent as a Claude, Codex, or other runtime process.

Conceptually:

```text
Agent
  |
  v
Run
  |
  +---- Runtime
  |
  +---- optional Session continuity
```

An Agent may survive many Runs.

A Session may survive multiple Runs.

A Runtime may be replaced without changing the logical Agent.

### Runtime-specific behavior belongs behind a provider boundary

OpenRig and Paperclip independently implement explicit runtime adapters.

The common architectural pressure is clear:

```text
MCU control plane
      |
      v
Agent Runtime contract
      |
      +---- Codex
      +---- Claude
      +---- local model
      +---- future runtime
```

MCU should own the runtime contract.

A particular runtime implementation should remain replaceable.

### Work exists independently of conversation

OpenRig models durable workflow state.

Paperclip models durable Issues.

OpenDots stores work and workspace state separately from conversation history.

The shared conclusion is:

> Conversation history must never be the authoritative representation of work.

Work requires its own identity, lifecycle, ownership, evidence, artifacts, and
history.

### Persistent agent does not mean persistent process

Paperclip wakes agents for bounded heartbeat executions.

OpenDots performs scheduled and background work as bounded runs.

OpenRig separates logical topology from live runtime sessions.

MCU should therefore treat persistent workers as durable logical identities
that may execute only when work requires execution.

### Context assembly is a first-class concern

All three systems assemble execution context independently from the runtime
itself.

Potential context inputs include:

- worker identity
- role instructions
- project context
- work context
- policies
- skills
- authorized resources
- preferences
- operator overrides
- runtime-specific startup material

MCU should eventually define a provider-neutral context projection contract
rather than construct runtime-specific prompts throughout the ecosystem.

### Workspaces are durable resources, not conversations

Paperclip associates workspaces with Projects.

OpenRig models workspace as a control-plane primitive.

OpenDots separates Spaces, pages, conversations, computers, and specialist
identity.

The common distinction is useful:

> A Workspace is a durable collection of resources available to work. It is
> not equivalent to conversation context or a runtime process.

### Execution environment is distinct from runtime

OpenDots provides each specialist with a persistent isolated computer.

That computer is not the agent runtime. The same agent can use its computer
from web chat, Slack, scheduled work, or voice-driven execution.

The more durable abstraction is therefore:

```text
Run
 |
 +---- Runtime
 |
 +---- Execution Environment
```

A containerized computer is one possible Execution Environment provider.

### Human decisions are durable state

OpenRig, Paperclip, and OpenDots independently externalize important human
decisions from ordinary conversation.

Approvals may govern:

- plans
- artifacts
- tool execution
- workflow transitions
- consequential actions

A particularly important invariant emerged:

> Approval applies to a specific proposed effect or artifact revision, not to
> an abstract intention.

Changing the target invalidates the previous approval.

### Effects require evidence

The systems repeatedly distinguish an attempted action from proof that the
intended effect occurred.

Examples include:

- process launch versus runtime readiness
- message delivery versus work consumption
- cancellation versus reversal of completed side effects
- workflow completion versus evidence of completion
- computer configuration versus successful provisioning

MCU should preserve this distinction.

### Capability revocation must affect active execution

OpenDots actively terminates or invalidates a run when relevant permissions or
configuration change during execution.

MCU should not assume that authorization captured at run start remains valid
for the lifetime of the run.

### Organizational hierarchy is not a kernel requirement

Paperclip models a strict company hierarchy.

OpenRig models engineering topology.

OpenDots supports useful persistent specialists without requiring hierarchy or
automatic delegation.

Therefore Team, Manager, Supervisor, CEO, Pod, Rig, and similar concepts should
not be part of the minimal worker execution kernel.

Higher-level orchestration may introduce organizational structures later.

### Memory is not one thing

OpenDots independently distinguishes:

- conversation continuity
- user-managed preferences
- workspace knowledge
- automatic learning
- learned skills

This suggests MCU should not introduce a single broad `Memory` abstraction
without further research.

The Hindsight research spike will investigate this boundary.

## Candidate Execution-Layer Primitives

The comparative study produced the following candidate concepts.

These are research findings, not yet accepted MCU architecture.

### Intent

- Goal
- Project
- Work

### Worker

- Agent
- Skill
- Context Bundle

### Execution

- Wakeup
- Run
- Session
- Runtime
- Execution Environment

### Resources

- Workspace
- Artifact

### Governance

- Approval

### Observability

- Event

## Concepts Deliberately Not Adopted

The following names describe useful product-specific concepts but are not
currently considered MCU kernel primitives:

- Rig
- Pod
- Seat
- Node
- Company
- Employee
- CEO
- Manager
- Team
- Supervisor
- Dot
- Space
- Computer
- Heartbeat
- Issue
- Queue
- Inbox
- Mission Control

Some may later exist as higher-level MCU concepts.

They should not be promoted merely because an external implementation uses
them.

## Candidate Architecture Invariants

The comparative research suggests the following invariants.

### Control plane owns truth

Runtime processes, terminals, containers, and interfaces are execution or
presentation mechanisms.

They are not authoritative control-plane state.

### Persistent identity is separate from execution

```text
Agent != Run != Session != Runtime
```

### Work is durable outside conversation

Loss or replacement of conversation history must not erase the definition or
state of work.

### Effects require evidence

An attempted operation is not proof of the intended effect.

### Human decisions are durable transitions

Approval and rejection should be explicit state, not conventions embedded in
conversation prose.

### Capability changes affect active work

Revocation of permissions or resources must be observable by active execution.

## Relationship to Existing MCU Architecture

This research intentionally does not replace existing MCU terminology.

MCU already defines concepts including:

- Labs
- capabilities
- workers
- workflow
- governance
- review gates
- checkpoints
- evidence
- tasks

The next architecture step is to reconcile the candidate primitives in this
document with MCU's existing ontology.

Equivalent concepts should reuse MCU terminology.

New concepts should be introduced only where the existing architecture lacks
the required distinction.

## Research Method

For each external system:

1. inspect its documented architecture and domain model
2. identify the capability that motivated the research
3. separate product terminology from durable responsibility
4. compare independently developed systems
5. promote concepts only when architectural pressure supports them
6. reject framework-specific nouns that do not generalize
7. preserve provider boundaries around replaceable implementations

The objective is not framework compatibility.

The objective is MCU architectural ownership.

## Next Research Question

The next focused study is Hindsight.

It will answer:

> What durable primitives are required for a worker to learn from experience
> across runs, and which responsibilities belong to MCU versus a replaceable
> memory or learning provider?

The study should distinguish at minimum:

- session continuity
- preferences
- knowledge
- learning
- skills

No Hindsight integration should be designed before that distinction is
understood.
