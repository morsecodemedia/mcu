# ADR 0021: Project Continuity

## Status

Accepted

## Context

MCU distinguishes durable Domain Artifacts from transient Execution State.

ADR-0013 establishes that each capability owns one constitutional
responsibility and produces one canonical Domain Artifact.

ADR-0014 establishes that Execution State is a transient composition of Domain
Artifacts that exists only for the lifetime of an execution workflow.

Agent Runtime research also identified Runtime Session continuity as
provider-dependent. Some Runtime providers may preserve conversational or
session state across Executions. Others may not.

Practical use of long-running Worker workflows exposed an additional
requirement.

A project may outlive:

- an Execution
- a Runtime Session
- a conversation
- a Runtime provider
- an Execution Environment
- a Worker

Required continuation state must therefore not exist only inside those
ephemeral or provider-specific contexts.

Without an explicit owner, safe project resumption would depend on reconstructing
state from conversation history, Git history, Runtime-native memory, or human
recollection.

None of those responsibilities owns durable project resumability.

## Decision

MCU SHALL recognize **Project Continuity** as a program-level architectural
responsibility.

Project Continuity owns:

> The durable project-specific continuation state required for a future Worker
> to safely determine where work stands and how to resume it without access to
> the Execution or Runtime Session that produced that state.

Project Continuity SHALL use the existing Domain Artifact model.

The canonical Domain Artifact produced by Project Continuity SHALL be called
the:

```text
Continuity Record
```

A Project SHALL have one canonical Continuity Record.

## Responsibility Boundary

Project Continuity owns:

- durable resumable project state
- semantic checkpoint history
- continuation-relevant unresolved work
- continuation-relevant validation state
- critical authoritative references
- next recommended action
- freshness information sufficient to detect stale continuity
- optional non-required Runtime continuation hints

Project Continuity does not own:

- implementation
- architecture
- Architectural Decision Records
- repository history
- Evidence
- Inference
- Insight
- Knowledge Packages
- Execution State
- Runtime Sessions
- provider-native conversation history
- source artifacts owned by other capabilities
- general project documentation

Project Continuity references authoritative artifacts where necessary.

It does not replace their ownership.

## Continuity Record

The Continuity Record is the canonical structured output of Project
Continuity.

It contains two complementary continuity views:

```text
Continuity Record
        |
        +---- Current State
        |
        +---- Checkpoint History
```

These are not separate constitutional artifacts or capabilities.

They represent current and historical views of the same Project Continuity
responsibility.

## Current State

Current State answers:

> What does a future Worker need to know about the project now in order to
> resume safely?

Current State SHALL be stored as part of the Continuity Record.

It SHOULD be optimized for immediate continuation rather than historical
completeness.

Current State semantics SHALL support, where applicable:

- current objective
- current phase or workstream
- continuation-relevant repository state
- completed work affecting continuation
- active decisions relevant to current work
- unresolved work
- blockers
- validation state
- critical authoritative references
- relevant deferred work
- next recommended action
- known continuity risks

The exact storage schema is deferred.

## Current State Is Not Project Truth

Current State summarizes and references continuation-relevant project truth.

It SHALL NOT become authoritative for responsibilities owned elsewhere.

For example:

```text
Current State
    ADR-0020 establishes Insight.

Authoritative source
    ADR/program/0020-insight.md
```

If Current State conflicts with an authoritative artifact, the authoritative
artifact wins.

Project Continuity must preserve enough reference information for a future
Worker to locate authoritative material when required.

## Checkpoint

A Checkpoint records:

> What materially changed in Project Continuity during a meaningful work
> segment?

Checkpoints SHALL be historical entries within the Continuity Record.

They SHALL NOT introduce a parallel Domain Artifact system.

Checkpoint semantics SHOULD support, where applicable:

- trigger
- objective
- prior continuation state
- completed work
- decisions accepted
- approaches rejected
- artifacts created or changed
- validation performed
- unresolved questions
- blockers
- deferred work
- continuation-relevant repository state
- next recommended action
- critical continuation context

A Checkpoint is not a transcript.

A Checkpoint is not a generic conversation summary.

A Checkpoint preserves durable semantic changes relevant to continuation.

## Checkpoint History

Checkpoint History SHALL preserve meaningful continuity transitions.

Historical checkpoints SHOULD remain independently inspectable.

Creating a new checkpoint SHALL NOT require destroying previous checkpoints.

Checkpoint History supports:

- Worker handoff
- continuity reconstruction
- decision archaeology
- debugging
- recovery
- determining when continuation state changed

Checkpoint History SHALL NOT replace repository history.

## Current State Reconciliation

When continuity materially changes, Project Continuity SHALL be capable of
reconciling:

```text
Previous Current State
        +
Semantic Checkpoint
        +
Authoritative Repository State
        |
        v
New Current State
```

Current State SHOULD NOT be produced solely through recursive summarization of
previous summaries.

Implementations SHOULD consult authoritative project artifacts when necessary
to prevent semantic drift.

## Repository Locality

For repository-backed Projects, the canonical Continuity Record SHOULD reside
with the Project repository.

The target continuity property is:

```text
fresh repository clone
        +
appropriate MCU tooling
        +
no previous conversation
        +
no previous Runtime Session
        =
continuable Project
```

External systems MAY:

- index continuity
- reference continuity
- synchronize continuity
- project continuity into other views

They SHALL NOT become the only location required for Project continuation.

## Runtime Independence

Project Continuity SHALL NOT depend on Runtime-native Session continuity.

Runtime providers MAY expose useful continuity mechanisms including:

- session identifiers
- conversation resume
- provider-native context
- execution history

These MAY be referenced as optional hints.

They SHALL NOT be required to determine the durable Project state necessary
for safe resumption.

## Worker Independence

Project Continuity SHALL support continuation by a Worker other than the one
that produced the previous state.

A future Worker may begin with:

```text
zero prior conversation history
zero Runtime Session state
zero memory of previous Executions
```

The Continuity Record must still provide sufficient project-specific state for
safe continuation when combined with authoritative project artifacts.

## Semantic Checkpoints

Automatic checkpointing SHALL be based on meaningful continuation boundaries
rather than arbitrary conversation length or elapsed time alone.

Program-level semantic trigger categories include:

- accepted architectural or material project decision
- completed research or design reconciliation
- completed implementation phase
- passed validation or acceptance gate
- significant durable project-state transition
- Worker handoff
- Runtime transition
- blocked work
- approval boundary
- context pressure threatening safe continuation
- graceful termination when meaningful state has changed

Implementations MAY refine these categories.

Not every trigger occurrence requires a new historical entry when no meaningful
continuity change occurred.

## Context Pressure

Context pressure is a recognized checkpoint trigger category.

When an Execution environment can determine that loss of usable context
threatens safe continuation, Project Continuity SHOULD support checkpointing
before that loss occurs.

The program architecture does not define:

- token thresholds
- percentages
- provider-specific context limits
- heuristic algorithms

Those remain implementation policy.

The persisted checkpoint should preserve semantic continuation state rather
than dump the entire conversation.

## Manual Checkpoint

Project Continuity SHALL support explicit checkpoint creation.

A human or Worker MUST be able to request:

> Preserve the current semantic continuation state now.

Manual checkpointing SHALL use the same Project Continuity responsibility as
automatic checkpointing.

The exact command, API, or interaction syntax is implementation-specific.

## Checkpoint Deduplication

Repeated checkpoint requests without meaningful continuity changes SHOULD NOT
produce unnecessary semantic duplication.

Implementations MAY suppress redundant historical entries while preserving
appropriate operational metadata.

The exact deduplication policy is implementation-specific.

## Freshness

The Continuity Record SHALL preserve enough information to determine whether
its Current State may be stale relative to authoritative Project state.

For repository-backed Projects, the minimum freshness model SHOULD be capable
of representing:

- repository identity
- branch or equivalent reference
- commit identity
- dirty-state indication

Additional artifact versions or references MAY participate when required.

The exact representation is deferred.

## Stale Continuity

Stale continuity remains useful as historical context.

It SHALL NOT be treated as authoritative Current State without reconciliation.

Conceptually:

```text
Continuity Record
        |
        | authoritative Project state advances
        v
      stale
        |
        v
   reconciliation
        |
        v
     current
```

The exact lifecycle representation is implementation-specific.

## Authoritative References

The Continuity Record SHOULD reference authoritative Project artifacts rather
than duplicate their complete contents.

Potential references include:

- ADRs
- research artifacts
- source files
- commits
- branches
- tests
- plans
- issues
- Domain Artifacts
- Evidence
- Insight
- Knowledge Packages

Continuity MAY preserve enough contextual explanation to make a reference
useful.

Copying material for convenience does not transfer semantic authority.

## Execution Composition

Project Continuity SHALL NOT inject itself directly into a Worker.

Orchestration remains responsible for composing Execution State.

Conceptually:

```text
Continuity Record
        |
        |
Domain Artifacts
        |
        v
   Orchestrator
        |
        v
 Execution State
        |
        v
     Worker
```

Project Continuity owns durable continuation state.

Orchestration owns execution composition.

## Bounded Consumption

Normal continuation SHOULD NOT require loading the entire Checkpoint History
into Execution State.

A typical continuation should be possible using:

```text
Current State
+
relevant authoritative references
```

Historical checkpoints remain available for deeper reconstruction when
required.

This preserves durable history without unnecessarily consuming Execution
context.

## Repository History Boundary

Repository history and Project Continuity have different responsibilities.

Repository history answers questions such as:

```text
What files changed?
When?
By whom?
```

Project Continuity answers questions such as:

```text
Why does work stand where it does?
What remains unresolved?
What should happen next?
What context is required to resume safely?
```

Continuity MAY reference repository history.

It SHALL NOT replace it.

## Insight Boundary

Project Continuity MAY reference Insight relevant to current work.

Insight remains owned according to ADR-0020.

Project Continuity SHALL NOT create a competing canonical representation of
Insight.

## Knowledge Boundary

Project Continuity MAY reference Knowledge Packages relevant to current work.

Knowledge Packages remain authoritative for institutional methodology.

Project Continuity SHALL NOT absorb Knowledge ownership.

## External Knowledge Workspace Boundary

Project Continuity SHALL NOT require an external knowledge workspace for
Project resumption.

External workspaces MAY:

- reference continuity
- index continuity
- project continuity
- relate continuity to cross-project material

Obsidian or another human knowledge interface remains optional.

## Machine Memory Boundary

Project Continuity SHALL NOT require Hindsight or another machine-memory
provider.

Machine-learning or memory providers MAY consume continuity material where
appropriate.

They SHALL NOT become the canonical continuity store.

## Security Boundary

The Continuity Record SHALL NOT intentionally persist secret values including:

- passwords
- access tokens
- API keys
- authentication cookies
- private keys
- temporary credentials
- secret environment values
- unrestricted environment dumps

Where future work requires a secret, continuity SHOULD reference the
appropriate secret-management mechanism rather than persist the secret value.

Durable continuation state SHOULD contain only sensitive material necessary
and appropriate for project resumption.

## Reasoning Privacy Boundary

Project Continuity SHALL NOT require persistence of private chain-of-thought or
other hidden model reasoning.

Continuity preserves:

- durable work state
- project-appropriate rationale
- accepted decisions
- rejected approaches when continuation-relevant
- validation
- unresolved questions
- continuation context

It does not preserve hidden reasoning traces merely to recreate a previous
Worker's internal cognition.

## Conversation Boundary

Raw conversation history is not the Continuity Record.

Conversation transcripts MAY exist independently for other purposes.

Project Continuity extracts durable semantic state required for resumption.

Conceptually:

```text
Conversation / Execution
        |
        | semantic checkpoint
        v
Continuity Record
```

not:

```text
Conversation / Execution
        |
        | complete dump
        v
Continuity Record
```

## Project Completion

When a Project ends, its Continuity Record SHOULD become historical rather
than disappear.

Completed continuity may remain useful for:

- audit
- archaeology
- future reactivation
- learning
- provenance

A completed Project's Continuity Record SHOULD NOT continue generating active
checkpoints unless the Project is reactivated.

The exact terminal lifecycle is implementation-specific.

## Acceptance Test

Project Continuity succeeds when:

### Given

A Worker with:

```text
zero previous conversation history
zero Runtime Session state
zero memory of previous Executions
```

and access to:

```text
a fresh Project repository clone
appropriate MCU tooling
```

### When

The Worker consumes the Continuity Record.

### Then

The Worker can determine:

- current objective
- continuation-relevant Project state
- active workstream
- important current decisions
- completed work affecting continuation
- unresolved work
- blockers
- validation state
- relevant authoritative artifacts
- relevant deferred work
- next recommended action
- whether continuity may be stale

### And

The Worker can inspect deeper Checkpoint History when required.

### Without

requiring:

- previous conversation
- previous Worker
- previous Runtime
- previous Runtime Session
- Obsidian
- Hindsight
- provider-specific memory

### And Without

making the Continuity Record authoritative for responsibilities owned
elsewhere.

## Consequences

Project work becomes resumable independently from conversational and
provider-native session state.

Workers can hand work to other Workers without requiring direct transfer of
ephemeral context.

Context-window exhaustion becomes a recoverable execution concern rather than
a threat to project continuity.

Project repositories gain explicit continuation state beyond what Git history
alone provides.

Checkpointing introduces additional durable state that must be kept fresh and
protected from secrets or inappropriate execution material.

Implementations must reconcile continuity with authoritative repository state
rather than trusting stale summaries blindly.

External knowledge systems remain optional.

## Non-Goals

This decision does not define:

- a conversation database
- a transcript archive
- a Runtime Session implementation
- a memory database
- a vector store
- an embedding model
- a knowledge graph
- an Obsidian vault
- a Hindsight integration
- a Git replacement
- an issue tracker
- a universal project schema
- a universal token threshold
- a universal summarization model
- a universal checkpoint storage format

## Related ADRs

- ADR 0007 — Responsibilities Outlive Implementations
- ADR 0013 — Capability Artifact Composition
- ADR 0014 — Orchestrators Compose Execution State
- ADR 0015 — Artifact Lifecycle
- ADR 0018 — Knowledge Packages
- ADR 0019 — Evidence
- ADR 0020 — Insight
