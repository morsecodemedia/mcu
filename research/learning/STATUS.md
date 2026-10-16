# Learning Architecture Research Status

## Status

Research synthesis: complete.

Hindsight architecture study: complete.

MCU reconciliation: complete.

Candidate Insight contract: human-reviewed and accepted as the basis for
architecture.

Architectural decision: promoted to ADR-0020 — Insight.

Implementation: not started.

Provider selection: not started.

## Research Question

The original question was:

> How can learned experience influence future Worker execution without
> violating MCU's existing Knowledge Package, Evidence, Domain Artifact,
> governance, and orchestration boundaries?

The research concluded that MCU was missing an explicit responsibility for:

> Durable understanding derived from Evidence that has been intentionally
> persisted beyond the Inference that produced it.

That responsibility is now named:

```text
Insight
```

## Decision Outcome

ADR-0020 establishes Insight as a program-level architectural contract.

### Evidence owns

```text
reasoning material
```

### Inference owns

```text
reasoning
```

### Insight owns

```text
selected durable results of reasoning
```

### Knowledge Package owns

```text
institutional engineering methodology
```

## Responsibility Model

```text
Runtime
   |
   v
Evidence
   |
   v
Inference
   |
   | selected durable result
   v
Insight
   |
   +---------------------+
   |                     |
   v                     v
Execution State      Knowledge candidate
                           |
                           v
                         Review
                           |
                           v
                    Knowledge Package
```

## Accepted Architectural Boundaries

### Insight is a Domain Artifact

Capabilities may produce Insight.

The producing capability owns the artifact.

MCU owns the program-level semantics.

### Persistence is explicit

Inference output does not automatically become Insight.

A producer explicitly chooses to persist a result expected to have value
beyond the current Execution.

### Source and derivation remain distinct

Insight remains distinguishable from supporting Evidence.

### Provenance survives derivation

Insight remains traceable to supporting Evidence.

### Insight is reconsiderable

Changes to Evidence can cause dependent Insight to become stale, invalidated,
superseded, or recomputed.

### Invalidation preserves history

Inactive Insight remains available for audit and provenance.

### Scope is explicit

MCU scope is not inferred from provider-specific storage boundaries.

### Execution influence is composed

Insight enters Execution State through orchestration and policy.

### Stale Insight is ineligible by default

Policy may explicitly permit stale Insight where appropriate.

### Knowledge promotion is explicit

Insight does not silently mutate Knowledge Packages.

### Providers remain replaceable

MCU owns Insight semantics.

Providers own derivation, persistence, retrieval, and reconsideration
mechanisms.

## Minimum Lifecycle

```text
active
stale
invalidated
superseded
```

These states establish portable semantics.

Implementations may use richer internal lifecycles.

## Experience Status

Experience remains:

```text
Evidence with Worker provenance
```

It is not currently a separate program-level primitive.

## Provider Concepts Not Adopted

The following remain provider-specific:

```text
Memory
Memory Bank
Retain
Recall
Reflect
Observation
Mental Model
Knowledge Page
```

## Hindsight Status

Hindsight remains:

- a completed research source
- a possible future provider
- unselected
- unintegrated

No Hindsight dependency has been approved.

## Obsidian Status

Obsidian remains unselected.

Research supports a future model in which Markdown may be projected from
canonical MCU state for consumption by tools such as Obsidian.

Obsidian is not canonical storage under ADR-0020.

## Research Artifacts

The research chain is preserved in:

```text
research/learning/README.md
research/learning/RECONCILIATION.md
research/learning/INSIGHT_CONTRACT.md
research/learning/STATUS.md
```

These documents preserve the evidence and reasoning that led to ADR-0020.

ADR-0020 remains the authoritative architectural decision.

## Future Design Work

Future implementation work must still define:

- the portable Insight artifact schema
- provider interface
- persistence mechanism
- dependency indexing
- reconsideration mechanics
- orchestration policy
- scope representation
- Knowledge promotion workflow
- authorization behavior
- test strategy

Those are implementation and follow-on architecture concerns.

They are not reasons to reopen the responsibility decision.

## Next Action

Close the current research work.

Validate and commit:

- Agent Runtime research
- Learning Architecture research
- ADR-0020

Do not begin another repository research spike as part of this change.

Future research should begin from a clean repository state and a new,
explicitly scoped question.
