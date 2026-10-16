# ADR 0020: Insight

## Status

Accepted

## Context

MCU already separates several responsibilities involved in engineering
reasoning.

ADR-0018 establishes Knowledge Packages as durable institutional methodology.

ADR-0019 establishes Evidence as implementation-independent reasoning material
and assigns reasoning itself to Inference.

Research into persistent Worker architectures and learning systems identified
a remaining responsibility between Evidence and Knowledge.

Some inference results have value beyond the Execution that produced them.

Examples include:

- recurring failure patterns
- stable relationships discovered across multiple Evidence sources
- project-specific understanding expected to remain useful
- repeated architectural constraints
- durable preferences relevant to future work

These conclusions are not source Evidence.

They are derived from Evidence.

They are also not automatically institutional Knowledge describing how work
should be performed.

Without an explicit responsibility, durable derived conclusions would need to
be stored as either Evidence or Knowledge, weakening the boundaries already
established by ADR-0018 and ADR-0019.

## Decision

MCU SHALL recognize **Insight** as the durable result of selected reasoning
over Evidence.

An Insight represents:

> Durable understanding derived from Evidence that has been intentionally
> persisted beyond the Inference that produced it.

Insight is a program-level architectural contract.

Capabilities MAY produce Insight while performing their owned
responsibilities.

The capability producing an Insight owns that Domain Artifact.

MCU owns the semantics of Insight.

Provider implementations own the mechanisms used to derive, persist,
retrieve, or reconsider it.

## Responsibilities

Insight owns:

- durable derived understanding
- provenance to supporting Evidence
- explicit scope
- temporal interpretation
- lifecycle state
- reconsideration when supporting Evidence changes
- eligibility for future Execution
- eligibility for Knowledge promotion

Insight does not own:

- Evidence collection
- general reasoning
- institutional methodology
- orchestration
- provider-specific memory
- retrieval algorithms
- presentation technology

## Architectural Relationship

The responsibility model is:

```text
Runtime
   |
   | discovers
   v
Evidence
   |
   | consumed by
   v
Inference
   |
   | may persist selected result as
   v
Insight
   |
   +---------------------+
   |                     |
   | composed into       | proposed for
   v                     v
Execution State      Knowledge promotion
                           |
                           v
                         Review
                           |
                           v
                    Knowledge Package
```

Inference results do not automatically become Insight.

Persistence is an explicit semantic boundary.

## Domain Artifact

Insight SHALL use the existing MCU Domain Artifact model.

A new parallel artifact or persistence architecture SHALL NOT be introduced
for Insight.

The capability that produces an Insight owns the artifact.

Insight artifacts remain implementation-independent and composable by
orchestration.

## Evidence Boundary

Insight SHALL remain distinguishable from the Evidence from which it was
derived.

A derived conclusion SHALL NOT silently become authoritative source Evidence.

Insight MAY be adapted into reasoning material for downstream work when
appropriate, but its derived provenance SHALL remain available.

This preserves the distinction between:

- observed facts
- externally asserted facts
- tool-produced facts
- Worker experience
- derived understanding

## Inference Boundary

Inference owns reasoning.

Insight owns selected durable results of reasoning.

Insight SHALL NOT introduce a second generic reasoning engine.

Implementations MAY use deterministic rules, statistical methods, local
models, hosted models, or other mechanisms to derive Insight.

## Persistence

An inference result becomes eligible for persistence as Insight only through
an explicit producer decision.

The result SHOULD have expected value beyond the current Execution.

Not every inference result should survive Execution.

Intermediate reasoning, transient mechanics, and other non-durable results
SHOULD NOT be persisted merely because they were produced.

## Provenance

Every Insight SHALL remain traceable to the Evidence supporting its
derivation.

The architecture MUST be capable of determining:

- what the Insight states
- which Evidence supports it
- who or what produced it
- when it was derived
- its applicable scope
- whether relevant supporting Evidence has changed

The portable Insight contract defines these semantics.

Provider-specific implementations MAY preserve additional provenance.

## Temporal Semantics

Insight SHALL preserve distinctions between source time and derivation time
where those distinctions affect meaning.

Relevant temporal concepts MAY include:

- when source events occurred
- when Evidence was observed or retained
- when Insight was derived
- when Insight was reconsidered
- whether Insight remains sufficiently fresh for active use

The exact storage representation is implementation-specific.

## Lifecycle

The minimum Insight lifecycle is:

```text
active
   |
   +----> stale
   |
   +----> invalidated
   |
   +----> superseded
```

### Active

The Insight is eligible for use according to policy.

### Stale

Relevant Evidence or time has changed sufficiently that the Insight requires
reconsideration.

Stale Insight SHALL NOT influence Execution State by default.

A policy MAY explicitly permit stale Insight where appropriate.

### Invalidated

The Insight is no longer eligible for active reasoning or Execution State.

Invalidation SHALL preserve historical and provenance information.

### Superseded

A newer Insight replaces the prior Insight as the preferred understanding.

The superseded Insight remains available for history and provenance.

## Reconsideration

Changes to supporting Evidence MUST be capable of identifying dependent
Insights that may require reconsideration.

Implementations MAY respond by:

- recomputing automatically
- marking Insight stale
- requesting review
- deferring reconsideration until next use

MCU does not require one universal reconsideration strategy.

The architectural invariant is:

> Correct sources; reconsider derived Insight.

## Scope

Every Insight SHALL have explicit MCU-owned scope.

Examples MAY include:

- Worker
- Task
- Project
- Capability
- Discipline
- Program

This list is illustrative, not exhaustive.

Provider-specific isolation constructs SHALL NOT define MCU scope.

Adapters are responsible for translating MCU scope into provider-specific
mechanisms.

## Execution State

Insight MAY influence future Execution only through explicit composition by
orchestration.

Providers SHALL NOT inject retained Insight directly into Worker context
outside the orchestration boundary.

Eligibility for composition MAY depend on:

- lifecycle state
- scope
- provenance
- capability policy
- Work type
- consequence
- review state

Orchestration remains responsible for composing Execution State.

## Knowledge Promotion

Insight SHALL NOT automatically become institutional Knowledge.

An Insight MAY support a proposed Knowledge Package change.

Promotion into Knowledge SHALL be explicit and subject to the governance
appropriate to that Knowledge change.

Conceptually:

```text
Insight
   |
   v
Knowledge change proposal
   |
   v
Review
   |
   v
Knowledge Package revision
```

Knowledge Packages remain authoritative for institutional methodology.

## Experience

Worker experience does not become a separate program-level primitive under
this decision.

Worker experience MAY be represented as Evidence with Worker-specific
provenance.

Future evidence may justify revisiting this decision.

## Provider Independence

MCU consumers SHALL NOT depend on provider-specific learning or memory
concepts.

Implementations may include systems such as Hindsight or future alternatives.

Provider-specific concepts such as:

- Memory Bank
- Observation
- Mental Model
- Retain
- Recall
- Reflect

remain behind provider boundaries.

MCU owns Insight semantics.

Providers own implementation mechanisms.

## Human Projection

Insight MAY be projected into human-readable forms including:

- Markdown
- reports
- dashboards
- CLI views
- knowledge tools

Projection SHALL NOT become canonical storage merely because it is
human-readable.

Presentation technology remains replaceable.

## Consequences

MCU gains an explicit responsibility for durable derived understanding without
weakening the boundaries between Evidence, Inference, and Knowledge.

Capabilities may preserve useful conclusions across Executions without making
those conclusions indistinguishable from source facts.

Derived understanding can evolve as Evidence changes.

Historical understanding can remain auditable after invalidation or
supersession.

Orchestration retains control over whether Insight influences Execution State.

Knowledge Packages remain protected from automatic mutation by learned state.

External learning and memory systems remain replaceable implementations.

The architecture introduces additional lifecycle and provenance obligations for
capabilities that choose to produce Insight.

## Non-Goals

This decision does not select:

- a memory database
- a vector store
- an embedding model
- a retrieval algorithm
- a knowledge graph
- an LLM
- Hindsight
- Obsidian
- a universal confidence score
- a universal persistence heuristic
- a universal review policy

This decision defines responsibility and boundaries.

Implementation remains separate.

## Related ADRs

- ADR 0007 — Responsibilities Outlive Implementations
- ADR 0013 — Capability Artifact Composition
- ADR 0014 — Orchestrators Compose Execution State
- ADR 0015 — Artifact Lifecycle
- ADR 0018 — Knowledge Packages
- ADR 0019 — Evidence
