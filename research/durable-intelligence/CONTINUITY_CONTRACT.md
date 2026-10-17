# Candidate Project Continuity Contract

## Status

Research design.

Not accepted architecture.

Not an implementation specification.

## Purpose

This document defines the smallest viable contract for the responsibility
currently called Project Continuity.

It exists to test whether the responsibility identified by Durable
Intelligence research can be expressed coherently using existing MCU
architecture.

The contract should introduce no more machinery than required to ensure:

> Durable project work remains safely continuable without access to the
> Execution or Runtime Session that produced it.

---

# Responsibility

Project Continuity owns:

> The durable project-specific continuation state required for a future Worker
> to safely determine where work stands and how to resume it.

Project Continuity does not own:

- project implementation
- architecture
- Architectural Decision Records
- repository history
- Evidence
- Inference
- Insight
- Knowledge Packages
- Execution State
- Runtime Sessions
- Runtime-native conversation history
- source artifacts owned by other capabilities
- general project documentation

Project Continuity references authoritative project artifacts where necessary.

It does not replace their ownership.

---

# Continuity Boundary

Project Continuity exists across bounded Executions.

Conceptually:

```text
Execution A
    |
    | durable continuation update
    v
Project Continuity
    |
    | consumed during future composition
    v
Execution B
```

Execution A and Execution B may differ in:

- Worker
- Runtime
- Runtime Session
- Execution Environment
- machine
- conversation
- time

Project Continuity must remain meaningful across those changes.

---

# Runtime Independence

Project Continuity SHALL NOT depend on Runtime-native Session continuity.

A Runtime MAY provide useful continuity mechanisms such as:

- session identifiers
- conversation resume
- provider-native context
- execution history

These MAY improve continuation.

They SHALL NOT be required to determine the durable project state necessary
for safe resumption.

A project must remain continuable when provider-native Session state is
unavailable.

---

# Worker Independence

Project Continuity SHALL NOT assume that the Worker consuming continuity state
is the Worker that produced it.

A future Worker may have:

```text
zero prior conversation history
zero provider-native Session state
no memory of previous Executions
```

The Continuity Artifact must still provide enough project-specific context to
resume safely when combined with authoritative repository artifacts.

---

# Repository Locality

The canonical Continuity Artifact SHOULD live with the project it describes.

For repository-backed projects, the project repository is the preferred
durable location.

This supports the continuity test:

```text
fresh repository clone
        +
appropriate MCU tooling
        +
no prior conversation
        +
no prior Runtime Session
        =
continuable project
```

External systems MAY index, reference, synchronize, or project continuity
state.

They SHALL NOT become the only location required for project continuation.

---

# Domain Artifact

Project Continuity SHALL use the existing MCU Domain Artifact model.

Working artifact name:

```text
Continuity Artifact
```

Project Continuity owns exactly one Continuity Artifact for its project scope.

The artifact represents the complete canonical output of the Project
Continuity responsibility.

No parallel checkpoint artifact system SHALL be introduced.

No separate Current State capability SHALL be introduced.

---

# Continuity Artifact

The Continuity Artifact must support two complementary views of continuity:

```text
Continuity Artifact
        |
        +---- Current State
        |
        +---- Checkpoint History
```

These are not separate constitutional artifacts.

They represent different temporal views of the same Project Continuity
responsibility.

---

# Current State

Current State answers:

> What does a future Worker need to know about the project now in order to
> resume safely?

Current State SHOULD be optimized for immediate continuation rather than
historical completeness.

Candidate contents include:

- current objective
- current phase or workstream
- current repository state relevant to continuation
- completed work that changes the continuation boundary
- active decisions relevant to current work
- unresolved work
- blockers
- validation state
- critical artifact references
- deferred work relevant to continuation
- next recommended action
- known continuity risks

This list is provisional.

It does not define a storage schema.

---

# Current State Is Not Project Truth

Current State summarizes and references continuation-relevant project truth.

It does not become authoritative for responsibilities owned elsewhere.

For example:

```text
Current State
    "ADR-0020 establishes Insight."

Authoritative source
    ADR/program/0020-insight.md
```

If the summary and authoritative artifact disagree, the authoritative artifact
wins.

The continuity system must make such references discoverable when the
distinction matters.

---

# Checkpoint

A Checkpoint records:

> What materially changed in Project Continuity during a meaningful work
> segment?

A Checkpoint is historical continuity material contained by or represented
within the Continuity Artifact.

Candidate checkpoint contents include:

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
- critical context for the next Worker

A Checkpoint is not a transcript.

A Checkpoint is not a general conversation summary.

A Checkpoint should preserve only material relevant to durable continuation.

---

# Checkpoint History

Checkpoint history exists to preserve meaningful continuity transitions.

Conceptually:

```text
Checkpoint A
    |
    v
Checkpoint B
    |
    v
Checkpoint C
```

Historical checkpoints SHOULD remain independently inspectable.

A new Checkpoint SHOULD NOT replace historical checkpoints merely because
Current State has advanced.

Checkpoint history supports:

- handoff reconstruction
- decision archaeology
- debugging
- continuity recovery
- identifying when project state changed

It is not intended to duplicate Git history.

---

# Current State Composition

Current State SHOULD be reconciled from:

- previous continuity state
- the new semantic checkpoint
- authoritative repository state where required

Conceptually:

```text
Previous Current State
          |
          +---- New Checkpoint
          |
          +---- Authoritative Repository State
          |
          v
     State Reconciliation
          |
          v
     New Current State
```

This is intentionally different from:

```text
summary
   |
   v
summary of summary
   |
   v
summary of summary of summary
```

Recursive summarization risks progressive information loss and semantic drift.

---

# Authoritative References

Continuity SHOULD reference authoritative project artifacts rather than
duplicating their complete contents.

Potential references include:

- ADR paths
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

A Continuity Artifact MAY include enough contextual explanation to make a
reference useful.

It SHOULD NOT silently become a competing canonical copy.

---

# Reference Freshness

A Continuity Artifact may become stale relative to authoritative repository
state.

The contract therefore requires enough freshness information to detect when
continuity should be reconsidered.

Potential signals include:

- repository commit identity
- branch identity
- dirty working-tree state
- artifact versions
- timestamps
- referenced artifact identity
- checkpoint sequence

The exact mechanism is deferred.

## Candidate Invariant

> Continuity state must be capable of detecting when authoritative project
> state has advanced beyond the state it describes.

---

# Stale Continuity

Stale continuity is not necessarily invalid continuity.

A fresh Worker may still use stale continuity to understand historical
context.

However, stale continuity SHOULD NOT be treated as authoritative current
project state without reconciliation.

Conceptually:

```text
Continuity Artifact
        |
        | repository advanced
        v
      stale
        |
        v
reconcile against repository
        |
        v
     current
```

The exact lifecycle terminology remains provisional.

---

# Semantic Checkpoint Triggers

Automatic checkpoints SHOULD occur at meaningful continuation boundaries rather
than arbitrary message counts or elapsed time.

Candidate semantic triggers include:

- architectural decision accepted
- research reconciliation completed
- contract accepted
- implementation phase completed
- validation gate passed
- significant commit landed
- Worker handoff
- Runtime transition
- work becomes blocked
- approval boundary reached
- context pressure
- graceful shutdown

Not every implementation must use every trigger.

The program contract should define trigger semantics separately from provider
policy.

---

# Context Pressure

Execution context pressure is a legitimate checkpoint trigger.

A Worker or Runtime may determine that available conversational or execution
context is approaching a practical limit.

Before continuity becomes unsafe, the system SHOULD be able to persist a
semantic checkpoint.

The checkpoint should capture durable continuation state.

It SHOULD NOT attempt to preserve the entire conversation merely because
context is being exhausted.

---

# Manual Checkpoint

Project Continuity MUST support explicit checkpoint creation.

A human or Worker must be able to request:

> Preserve the current semantic continuation state now.

This requirement exists because humans and Workers may recognize meaningful
boundaries that automatic policy cannot reliably infer.

The exact command or interface is implementation-specific.

Examples such as:

```text
checkpoint
checkpoint this
prepare handoff
save project state
```

are interaction ideas, not contract syntax.

---

# Idempotence

Repeated checkpoint requests without meaningful continuity changes SHOULD NOT
produce unnecessary semantic duplication.

An implementation MAY:

- detect no meaningful change
- update metadata
- decline to create another historical checkpoint
- record that a checkpoint request occurred

The exact behavior is implementation-specific.

The contract should favor meaningful history over checkpoint noise.

---

# Handoff

A Worker handoff is a strong checkpoint boundary.

Before intentional handoff, continuity SHOULD preserve enough information for
another Worker to resume without requiring direct communication with the
previous Worker.

Conceptually:

```text
Worker A
   |
   v
Checkpoint
   |
   v
Continuity Artifact
   |
   v
Worker B
```

Worker B may be:

- another instance of the same Worker
- a different Worker
- a different model
- a different Runtime
- a human

---

# Execution Composition

Project Continuity does not inject itself directly into a Worker.

Orchestration remains responsible for composing Execution State.

Conceptually:

```text
Continuity Artifact
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

Orchestration decides which continuity material is relevant to the new
Execution.

Project Continuity owns durable state.

Orchestration owns execution composition.

---

# Bounded Continuity Consumption

The entire continuity history SHOULD NOT need to enter every Execution.

A fresh Worker normally needs:

```text
Current State
+
relevant authoritative references
```

Historical checkpoints should be retrievable when deeper context is required.

Conceptually:

```text
Continuity Artifact
      |
      +---- Current State --------> normal continuation
      |
      +---- Checkpoint History ---> deeper archaeology
```

This keeps Execution State bounded while preserving durable history.

---

# Runtime Session Hints

A Continuity Artifact MAY contain non-required hints to provider-native
continuity mechanisms.

Examples may include:

- Runtime Session identifier
- conversation identifier
- execution identifier

Such hints MUST be treated as optional accelerators.

The project must remain continuable if those identifiers:

- expire
- become inaccessible
- belong to another provider
- are deleted
- cannot be resumed

Provider-native identity must not become canonical project identity.

---

# Security Boundary

Project Continuity is durable.

Durability increases the consequence of persisting inappropriate execution
material.

The Continuity Artifact SHALL NOT intentionally persist:

- passwords
- access tokens
- API keys
- authentication cookies
- private keys
- temporary credentials
- secret environment values
- unrestricted environment dumps

Continuity SHOULD avoid persisting sensitive material that is unnecessary for
resumption.

Where a secret is required for future work, continuity should reference the
appropriate secret-management mechanism rather than record the secret value.

---

# Reasoning Privacy Boundary

Project Continuity SHALL NOT require persistence of private chain-of-thought or
other hidden model reasoning.

Continuity preserves durable work state, decisions, rationale appropriate for
project records, and continuation context.

It does not preserve hidden reasoning traces merely to recreate a previous
Worker's internal process.

A future Worker should resume from durable project state, not impersonate the
private cognition of the previous Worker.

---

# Conversation Boundary

Raw conversation history is not the Continuity Artifact.

Conversation transcripts MAY exist independently for audit, product, or human
reference purposes.

Project Continuity should extract only the durable semantic state required for
resumption.

Conceptually:

```text
Conversation
      |
      | semantic checkpoint
      v
Continuity Artifact
```

not:

```text
Conversation
      |
      | dump everything
      v
Continuity Artifact
```

---

# Repository History Boundary

Git history and Project Continuity serve different purposes.

Git answers questions such as:

```text
What changed in repository files?
Who committed it?
When did it change?
```

Project Continuity answers:

```text
Why does the current work stand where it does?
What remains unresolved?
What should happen next?
What context is required to resume safely?
```

Continuity MAY reference commits.

It SHOULD NOT duplicate Git's responsibility.

---

# Insight Boundary

Project Continuity may reference Insight relevant to current work.

It does not own Insight semantics.

For example:

```text
Current State
    Relevant Insight: INSIGHT-123
```

The Insight remains owned according to ADR-0020.

Continuity should not copy the Insight into a new competing canonical form.

---

# Knowledge Boundary

Project Continuity may reference Knowledge Packages required for current work.

It does not own institutional methodology.

For example:

```text
Current State
    Required Knowledge:
        accessibility/review
```

The Knowledge Package remains authoritative.

---

# External Knowledge Workspace Boundary

Project Continuity SHALL NOT require an external knowledge workspace for
project resumption.

A knowledge workspace MAY:

- reference continuity
- index continuity
- project continuity into human-readable views
- relate continuity to cross-project material

The project repository remains sufficient for project-owned continuation
state.

Obsidian or another knowledge interface must remain optional.

---

# Hindsight Boundary

Project Continuity SHALL NOT require Hindsight or another machine-memory
provider.

A learning provider MAY use continuity material as Evidence where appropriate.

A continuity implementation MAY consume relevant Insight through normal MCU
composition.

Machine memory does not become the canonical continuity store.

---

# Candidate Artifact Semantics

Without defining a storage schema, the Continuity Artifact currently appears
to require semantics equivalent to:

```text
Continuity Artifact
 |
 +---- project identity
 +---- continuity version
 +---- freshness / repository anchor
 +---- Current State
 +---- Checkpoint History
 +---- authoritative references
 +---- unresolved work
 +---- next action
 +---- optional Runtime hints
```

This list exists to test responsibility coverage.

It is not a schema commitment.

---

# Acceptance Test

The Project Continuity contract succeeds when the following scenario is
possible.

## Given

A Worker with:

```text
zero previous conversation history
zero Runtime Session state
zero memory of previous Executions
```

and access to:

```text
a fresh project repository clone
appropriate MCU tooling
```

## When

The Worker consumes Project Continuity.

## Then

The Worker can determine:

- the current objective
- the current continuation-relevant project state
- the active workstream
- important current decisions
- completed work affecting continuation
- unresolved work
- blockers
- validation state
- relevant authoritative artifacts
- relevant deferred work
- the next recommended action
- whether continuity may be stale

## And

The Worker can inspect deeper checkpoint history when required.

## Without

The Worker requiring:

- the previous conversation
- the previous Worker
- the previous Runtime
- the previous Runtime Session
- Obsidian
- Hindsight
- provider-specific memory

## And Without

The Continuity Artifact becoming authoritative for responsibilities owned by:

- architecture
- implementation
- Evidence
- Insight
- Knowledge
- repository history
- other Domain Artifacts

---

# Candidate Invariants

## Continuity is durable

Project Continuity survives individual Executions.

## Continuity is provider-independent

Runtime Session state may assist but cannot be required.

## Continuity is Worker-independent

A different Worker can resume from durable state.

## Continuity remains project-local

External knowledge systems are optional consumers.

## Continuity references authority

It does not silently replace authoritative project artifacts.

## Current State and history remain distinct

Immediate continuation does not require destroying historical transitions.

## Checkpoints are semantic

They preserve meaningful work-state transitions rather than arbitrary
conversation slices.

## Manual checkpointing exists

Humans and Workers can explicitly preserve an important continuation boundary.

## Automatic checkpointing uses semantic gates

Policy should prefer meaningful transitions over arbitrary cadence.

## Continuity can become stale

Repository advancement must be detectable and reconcilable.

## Continuity consumption is bounded

Normal continuation does not require loading all history.

## Secrets are excluded

Durability does not justify persisting sensitive execution material.

## Hidden reasoning is excluded

Project Continuity preserves durable work state, not private chain-of-thought.

## Orchestration controls execution composition

Continuity does not inject itself directly into Workers.

---

# Non-Goals

This contract does not define:

- a conversation database
- a transcript archive
- a Runtime Session store
- a memory database
- a vector database
- an embedding model
- a knowledge graph
- an Obsidian vault
- a Hindsight integration
- a Git replacement
- an issue tracker
- a universal project schema
- a universal checkpoint trigger policy
- a universal summarization model

---

# ADR Readiness Test

A Project Continuity ADR is justified if MCU accepts all of the following:

1. durable project resumability is distinct from transient Execution State
2. Project Continuity must survive loss of Runtime Session state
3. Project Continuity must support a different future Worker
4. Project Continuity should use the Domain Artifact model
5. the Continuity Artifact is canonical only for continuation state
6. authoritative project artifacts retain their existing ownership
7. Checkpoint and Current State are views of one continuity responsibility
8. semantic automatic checkpointing is required
9. explicit manual checkpointing is required
10. continuity freshness must be detectable
11. orchestration controls continuity composition into Execution State
12. sensitive secrets and hidden reasoning are excluded
13. external knowledge systems remain optional
14. provider-native Session state remains optional

If any of these fail, the contract should be revised before an ADR is written.

---

# Remaining Decision Questions

Even if this contract survives human review, an ADR must still decide:

- the organizational owner of Project Continuity
- the final name of the Continuity Artifact
- whether one Continuity Artifact exists per Project or another MCU scope
- minimum required Current State semantics
- minimum required Checkpoint semantics
- minimum freshness anchor
- whether Checkpoint history is append-only
- whether Current State is stored or generated
- which automatic triggers belong to program semantics
- what policy governs checkpoint suppression or deduplication
- how repository dirty state is represented
- how continuity references are resolved
- how continuity is initialized for an existing project
- how stale continuity is reconciled
- how continuity is retired when a project ends

These questions should be resolved architecturally before implementation
begins.
