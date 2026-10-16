# Candidate Insight Contract

## Status

Research design.

Not accepted architecture.

Not an implementation specification.

## Purpose

This document defines the smallest viable contract for the responsibility
currently called Insight.

It exists to test whether the responsibility identified by Learning
Architecture Research can be expressed coherently using existing MCU
architecture.

The contract should introduce no more machinery than required to preserve the
distinction between:

```text
Evidence
    reasoning material

Inference
    reasoning

Insight
    selected durable result of reasoning

Knowledge Package
    institutional methodology
```

---

# Responsibility

Insight owns:

> Durable understanding derived from Evidence that has been intentionally
> persisted beyond the Inference that produced it.

Insight does not own:

- Evidence collection
- general reasoning
- institutional methodology
- execution orchestration
- provider-specific memory
- retrieval implementation
- human-readable knowledge presentation

---

# Ownership

## Program Contract

MCU should define the semantics of Insight at program scope.

This ensures that all capabilities agree on what an Insight means without
requiring them to share an implementation.

## Production

Capabilities may produce Insights when performing their owned responsibilities.

A capability that produces an Insight owns that Domain Artifact.

## Consumption

Other capabilities and orchestrators may consume Insights through explicit
contracts.

Consumers must not depend on the provider implementation that derived or
stores the Insight.

---

# Artifact Model

Insight should use the existing MCU Domain Artifact model.

It should not introduce a parallel persistence architecture.

Conceptually:

```text
Capability
    |
    | produces
    v
Insight Domain Artifact
    |
    +---- derived statement
    +---- supporting Evidence references
    +---- provenance
    +---- scope
    +---- temporal state
    +---- lifecycle state
```

The exact schema is intentionally deferred.

The important architectural decision is that Insight is:

- durable
- capability-owned
- implementation-independent
- composable by orchestration

---

# Derivation

An Insight must be derived from Evidence.

Conceptually:

```text
Evidence
   |
   v
Inference
   |
   v
candidate result
   |
   | explicit persistence decision
   v
Insight
```

Inference output does not automatically become Insight.

Persistence is a semantic boundary.

---

# Persistence Threshold

An inference result becomes eligible for persistence as Insight only when a
producer explicitly determines that the result has value beyond the current
Execution.

The minimum criterion is:

> The conclusion is expected to improve reasoning or decisions in a future
> Execution.

Examples that may qualify:

- a recurring failure pattern
- a stable relationship discovered across multiple Evidence sources
- a preference relevant to future work
- a repeated architectural constraint
- a project-specific understanding expected to remain useful

Examples that normally should not qualify:

- intermediate chain-of-thought
- temporary formatting decisions
- one-off conversational phrasing
- speculative conclusions with no durable relevance
- transient execution mechanics

The exact persistence policy may vary by capability.

MCU defines the contract, not a universal persistence heuristic.

---

# Provenance

Every Insight must remain traceable to the Evidence supporting its derivation.

The contract must preserve enough provenance to answer:

```text
What is the Insight?

Which Evidence supports it?

Who or what produced it?

When was it derived?

What scope does it apply to?

Has supporting Evidence changed?
```

Provider-specific provenance may contain additional information.

The MCU contract defines only the minimum portable semantics.

---

# Temporal Semantics

Insight must support the distinction between source time and derivation time
where relevant.

Conceptually:

```text
Evidence occurred
        |
Evidence observed
        |
Insight derived
        |
Insight reconsidered
```

A provider must not collapse these into one timestamp when doing so would
change meaning.

The exact timestamp schema is deferred.

---

# Lifecycle

The minimum candidate lifecycle is:

```text
active
   |
   +----> stale
   |
   +----> invalidated
   |
   +----> superseded
```

## Active

The Insight is eligible for use according to policy.

## Stale

Relevant Evidence has changed or sufficient time has passed such that the
Insight should be reconsidered before being trusted.

A stale Insight remains historically valid as a record of prior
understanding.

## Invalidated

The Insight is no longer eligible for active reasoning.

Invalidation does not destroy its historical record.

## Superseded

A newer Insight replaces the current Insight as the preferred understanding.

The superseded Insight remains available for provenance and history.

This lifecycle is intentionally minimal.

---

# Reconsideration

Changes to supporting Evidence must be able to trigger reconsideration of
dependent Insights.

The contract therefore requires dependency traceability:

```text
Evidence
   |
   +---- Insight A
   |
   +---- Insight B
```

If Evidence is corrected, invalidated, or materially changed, consumers must
be able to determine which Insights may be affected.

The implementation may:

- recompute automatically
- mark affected Insights stale
- request review
- defer reconsideration until next use

MCU does not require one universal strategy.

---

# Scope

Every Insight must have explicit scope.

Potential MCU scopes include:

- Worker
- Task
- Project
- capability
- discipline
- program

Not every implementation must support every scope.

Provider-specific isolation constructs do not define MCU scope.

For example:

```text
MCU Project scope
       |
       v
provider adapter
       |
       v
Hindsight Bank / tags
```

Scope translation is an adapter responsibility.

---

# Execution Policy

Insight may influence future Execution only through explicit composition.

Conceptually:

```text
Insight
   |
   | policy permits
   v
Orchestrator
   |
   v
Execution State
```

A provider must not inject retained Insight directly into Worker context
outside orchestration.

Whether a particular Insight is eligible for composition may depend on:

- lifecycle state
- scope
- provenance
- capability policy
- Work type
- consequence
- review state

The contract does not mandate one global eligibility policy.

---

# Knowledge Promotion

Insight does not automatically become Knowledge.

An Insight may become supporting material for a proposed Knowledge Package
change.

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

The Knowledge Package remains authoritative for institutional methodology.

Insight remains authoritative only for its own derived-understanding
responsibility.

---

# Evidence Relationship

Insight and Evidence remain distinct.

An Insight may be exposed to downstream reasoning through an Evidence
representation when appropriate, but doing so must preserve its derived
provenance.

Conceptually:

```text
Insight
   |
   | adapted as reasoning material
   v
Evidence representation
   |
   +---- source type: insight
   +---- Insight identity
   +---- supporting provenance
```

This prevents previous inference from masquerading as directly observed fact.

---

# Provider Boundary

MCU should define a provider-neutral Insight capability.

The smallest candidate provider operations are:

```text
derive
reconsider
```

## Derive

Input:

- Evidence references
- scope
- derivation intent

Output:

- zero or more candidate Insights
- provenance
- derivation metadata

`derive` does not require every candidate to be persisted.

## Reconsider

Input:

- existing Insight
- current supporting or relevant Evidence

Output:

- unchanged
- refreshed
- stale
- invalidated
- superseded
- replacement candidate

These operation names are provisional.

They describe responsibilities, not an API.

---

# Provider Independence

An implementation may use:

- Hindsight
- deterministic rules
- statistical analysis
- local models
- hosted models
- another future system

MCU consumers must not depend on provider-specific concepts such as:

- Memory Bank
- Observation
- Mental Model
- Retain
- Recall
- Reflect

Those concepts belong behind the provider boundary.

---

# Human Projection

Insight may be projected into human-readable forms.

Potential projections include:

- Markdown
- reports
- dashboards
- Obsidian vault content
- CLI views

Projection is not canonical storage.

Deleting a projection must not destroy the canonical Insight.

A projection should be reproducible from canonical state.

---

# Non-Goals

This contract does not define:

- a memory database
- a vector store
- an embedding model
- a retrieval algorithm
- a knowledge graph
- an LLM
- chain-of-thought persistence
- Hindsight integration
- Obsidian integration
- a universal confidence score
- a universal persistence heuristic
- a universal review policy

---

# Candidate Invariants

## Insight is derived

Every Insight originates from Evidence through reasoning or synthesis.

## Insight is durable by explicit choice

Inference results do not automatically become persistent architecture state.

## Insight preserves provenance

Supporting Evidence remains discoverable.

## Insight remains distinguishable from Evidence

Derived understanding cannot silently masquerade as source fact.

## Insight is reconsiderable

Changes in Evidence can affect dependent Insight.

## Invalidation preserves history

Historical understanding is not destroyed merely because it is no longer
active.

## Insight is scoped

Provider storage boundaries do not implicitly define MCU scope.

## Execution influence is composed

Insight enters Execution State through orchestration and policy.

## Knowledge promotion is explicit

Insight does not silently mutate Knowledge Packages.

## Providers remain replaceable

MCU owns semantics; implementations own mechanisms.

---

# ADR Readiness Test

An Insight ADR is justified if MCU accepts all of the following:

1. durable derived understanding is a responsibility distinct from Evidence
2. the responsibility is distinct from Knowledge Package ownership
3. selected inference results require an explicit persistence boundary
4. Insight should use the Domain Artifact model
5. Insight must preserve provenance to supporting Evidence
6. Insight requires a reconsiderable lifecycle
7. Insight requires explicit scope
8. orchestration controls whether Insight enters Execution State
9. Knowledge promotion remains explicit
10. provider implementations remain replaceable

If any of these fail, the contract should be revised before an ADR is written.

---

# Remaining Decision Questions

Even if the contract survives, an ADR must still decide:

- the organizational owner of the Insight contract
- whether all capabilities may produce Insight
- whether Insight is initially Engineering-specific or program-wide
- minimum required metadata
- minimum lifecycle transitions
- whether stale Insight may enter Execution State
- whether review is required for particular scopes
- whether Knowledge promotion requires a dedicated workflow

These questions should be answered at the architectural level before
implementation begins.
