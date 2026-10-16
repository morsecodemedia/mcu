# Learning Architecture Research — MCU Reconciliation

## Purpose

The Hindsight research identified a possible responsibility between MCU
Evidence and Knowledge.

The working research term for that responsibility was `Learned Insight`.

This document tests that candidate directly against the responsibilities
already assigned by:

- ADR-0018 — Knowledge Packages
- ADR-0019 — Evidence

The objective is adversarial.

A new architectural responsibility should be introduced only if the existing
architecture cannot represent the responsibility honestly without weakening
an established boundary.

This is a research synthesis.

It is not an Architectural Decision Record.

---

# Reconciliation Result

## Verdict

The candidate responsibility survives reconciliation.

MCU currently assigns responsibility for:

```text
Evidence
    reasoning material

Inference
    reasoning

Knowledge Package
    institutional engineering methodology
```

None of those responsibilities owns:

> Durable understanding derived from accumulated Evidence, including its
> provenance, temporal validity, evolution, invalidation, and eligibility to
> influence future execution or be promoted into institutional Knowledge.

This is a genuine architectural gap.

The working MCU term for the missing durable result is:

```text
Insight
```

`Insight` remains provisional until an ADR establishes its responsibility,
ownership, lifecycle, and relationship to existing MCU artifacts.

---

# Evidence Boundary

ADR-0019 establishes that:

```text
Runtime
    discovers engineering facts

Evidence
    exposes reasoning material

Knowledge Packages
    define engineering methodology

Composers
    combine knowledge with evidence

Inference
    performs reasoning
```

This separation is deliberate.

Evidence exists to decouple engineering reasoning from the Runtime providers
that discover facts.

## Why Insight Is Not Ordinary Evidence

Evidence is the material available for reasoning.

Insight is a conclusion produced by reasoning over Evidence.

For example:

```text
Evidence A:
Three inherited projects using dependency pattern X failed under Node 18.

Evidence B:
Those projects succeeded after moving to Node 20.

Insight:
Dependency pattern X appears incompatible with Node 18.
```

Treating the Insight as indistinguishable from its supporting Evidence would
erase an important epistemic distinction.

The architecture would no longer be able to tell whether a statement was:

- directly observed
- externally asserted
- produced by a tool
- experienced by a Worker
- or inferred from other Evidence

That distinction matters for:

- provenance
- confidence
- invalidation
- contradiction
- audit
- future inference
- Knowledge promotion

Therefore Insight should not be collapsed into ordinary Evidence.

---

# Knowledge Boundary

ADR-0018 establishes that Knowledge Packages represent engineering expertise
and describe how engineering tasks should be performed.

Knowledge Package artifacts own responsibilities including:

- execution metadata
- task objective
- institutional and architectural context
- default assumptions
- engineering philosophy
- reasoning examples
- behavioral expectations

Knowledge is therefore durable institutional methodology.

## Why Insight Is Not Knowledge Package

Insight answers a primarily epistemic question:

```text
What does accumulated Evidence suggest is true?
```

Knowledge Package content may answer a normative question:

```text
How should engineering work be performed?
```

Example:

```text
Insight:

Projects using dependency pattern X have repeatedly failed under Node 18.


Knowledge Package:

Before dependency installation, verify the repository's declared Node
requirement and activate a compatible runtime.
```

The Insight may provide Evidence for creating or changing the Knowledge
Package.

It should not silently become institutional methodology.

Therefore Insight should not be collapsed into Knowledge Package content.

---

# Inference Boundary

ADR-0019 already assigns reasoning to Inference.

This is important.

The Hindsight research does not justify creating a new generic Learning engine
that duplicates Inference.

The missing responsibility is not simply:

```text
perform reasoning
```

That responsibility already exists.

The missing responsibility is:

```text
persist selected reasoning outcomes
```

Conceptually:

```text
Evidence
   |
   v
Inference
   |
   v
transient reasoning result
   |
   | persistence boundary
   v
Insight
```

This suggests an important distinction:

> Learning may be a process involving Inference, but Insight is the durable
> result that survives execution.

Not every inference result should become Insight.

The criteria for persistence remain unresolved.

---

# Candidate Insight Responsibility

The working responsibility is:

> Insight owns durable understanding derived from accumulated Evidence.

To satisfy the architectural gap identified by the research, an Insight would
need enough information to support:

- provenance
- temporal interpretation
- reconsideration
- invalidation
- supersession
- scope
- future execution
- Knowledge promotion

A possible conceptual shape is:

```text
Insight
 |
 +---- statement
 +---- supporting Evidence
 +---- provenance
 +---- scope
 +---- derived time
 +---- relevant occurrence time
 +---- freshness / validity
 +---- lifecycle state
 +---- derivation information
```

This is not a schema.

The fields are listed only to expose the responsibilities discovered during
research.

No storage representation has been selected.

---

# Source and Derivation

The Hindsight study provides strong evidence for preserving a hard boundary
between source state and derived state.

Conceptually:

```text
Evidence
   |
   | inference
   v
Insight
```

The arrow does not reverse ownership.

An Insight must not become the authoritative source for the Evidence from
which it was inferred.

## Candidate Invariant

> Source Evidence and derived Insight remain distinguishable.

This prevents a derived conclusion from silently masquerading as an observed
fact during future reasoning.

---

# Correction and Recalculation

Hindsight demonstrates a useful lifecycle rule:

```text
correct source
      |
      v
invalidate affected derivation
      |
      v
recompute
```

MCU should preserve the responsibility behind this pattern even if the
implementation differs.

## Candidate Invariant

> Correct sources; regenerate derivations.

If supporting Evidence is corrected, invalidated, or removed, dependent
Insights must be eligible for reconsideration.

An implementation should not require operators to manually discover and edit
every derived conclusion affected by a source correction.

---

# Provenance

A durable derived conclusion is useful only if MCU can explain why it exists.

An Insight should therefore remain traceable to the Evidence that supported
its derivation.

At minimum, the architecture must eventually be able to answer:

```text
What does MCU currently believe?

Why does it believe that?

Which Evidence supports the belief?

When was that Evidence obtained?

When was the Insight derived?

What process produced the Insight?

Has relevant Evidence changed since derivation?
```

Exact provenance representation remains unresolved.

---

# Temporal Semantics

Hindsight demonstrates that learning has more than one meaningful time.

Potential distinctions include:

```text
occurred_at
    when the represented event happened

observed_or_retained_at
    when MCU learned about the source Evidence

derived_at
    when an Insight was produced

freshness_or_validity
    whether newer Evidence may require reconsideration
```

A future Insight contract should preserve these distinctions where relevant.

No exact timestamp model has been selected.

---

# Contradiction and Evolution

Insight must be capable of surviving a world in which Evidence changes.

Potential relationships include:

```text
Evidence reinforces Insight

Evidence contradicts Insight

Evidence corrects prior Evidence

Insight supersedes Insight

Insight becomes stale

Insight becomes invalid
```

The architecture should not assume last-write-wins semantics.

Historical understanding may remain important even after current understanding
changes.

---

# Invalidation and Audit

Removing an Insight from active reasoning should not necessarily destroy its
history.

The Hindsight study demonstrates the value of separating:

```text
historical record
```

from:

```text
currently active understanding
```

A future Insight lifecycle may therefore require states or relationships
equivalent to:

- active
- stale
- invalidated
- superseded

These names are provisional.

No lifecycle has yet been accepted.

---

# Execution Boundary

A major unresolved question is whether an Insight may influence future Worker
execution before it becomes institutional Knowledge.

Possible policies include:

```text
Policy A
Insight may influence Execution State immediately.

Policy B
Insight may influence Execution State only when confidence or provenance
requirements are satisfied.

Policy C
Insight requires review before influencing Execution State.

Policy D
The rule varies according to capability, Work type, scope, or consequence.
```

The Hindsight research does not answer this MCU policy question.

It must be decided through MCU governance.

---

# Knowledge Promotion

Insight and Knowledge should remain distinct even when one leads to the other.

A candidate lifecycle is:

```text
Evidence
   |
   v
Inference
   |
   v
Insight
   |
   +--------------------+
   |                    |
   v                    v
Execution State     Knowledge candidate
                         |
                         v
                       Review
                         |
                         v
                 Knowledge Package
```

Knowledge promotion should be explicit.

The mechanism for promotion remains unresolved.

Potential requirements include:

- supporting Evidence
- provenance
- scope
- confidence
- review
- rationale
- versioning

No promotion workflow has yet been accepted.

---

# Experience Reconciliation

Hindsight distinguishes external world facts from the owning agent's own
experiences.

The research finds this distinction useful but does not find sufficient reason
to introduce Experience as a separate top-level MCU primitive.

The current interpretation remains:

> Worker experience is Evidence with Worker-specific provenance.

For example:

```text
Evidence
 |
 +---- external fact
 +---- tool result
 +---- human assertion
 +---- Worker experience
```

If later research reveals lifecycle behavior unique to Experience, this
conclusion may be revisited.

---

# Mental Model Reconciliation

Hindsight Mental Models are maintained syntheses over retained and consolidated
state.

MCU should not import Mental Model as a program-level primitive.

A provider may expose an equivalent optimized representation.

From MCU's perspective, such a representation may be:

- a cached projection of Insights
- an execution-context optimization
- a provider-specific artifact
- or a generated view

Its existence does not change the ownership of Evidence, Insight, or Knowledge.

---

# Knowledge Page Reconciliation

Hindsight Knowledge Pages are projections of Mental Models.

This supports an MCU principle:

> Human-readable knowledge surfaces may be projections rather than canonical
> stores.

Potential consumers include:

- Obsidian
- CLI tools
- editors
- Worker filesystem tools
- documentation sites

This keeps presentation technology replaceable.

No decision to adopt Obsidian has been made.

---

# Scope Reconciliation

Hindsight uses Banks and tags to isolate and scope learned state.

MCU should not import Bank into program architecture.

MCU already owns identity and work scopes such as:

- Worker
- Task
- Project
- capability
- discipline
- program

A provider adapter should translate MCU scope into provider-specific isolation.

The correct MCU scope model for Insight remains unresolved.

---

# Responsibility Model

The current research model is:

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

This model preserves the responsibilities already established by ADR-0018 and
ADR-0019 while filling the identified gap.

---

# Working Terminology

## Insight

Preferred working term for the durable artifact or responsibility.

Reason:

- describes the result rather than the process
- does not collide with Evidence
- does not overload Knowledge
- remains implementation-independent
- does not import Hindsight terminology

## Learning

Useful term for the process by which Evidence may produce or evolve Insight.

Learning is not currently proposed as a separate architectural subsystem.

Inference already owns reasoning.

## Learned Insight

Retired as the preferred working term.

It was useful during research but unnecessarily couples the artifact to one
production mechanism.

`Insight` is more concise and leaves implementation open.

---

# Concepts Not Adopted

The reconciliation does not introduce these Hindsight concepts into MCU
program architecture:

- Memory
- Memory Bank
- Retain
- Recall
- Reflect
- Observation
- Mental Model
- Knowledge Page

It also does not introduce:

- generic Memory subsystem
- generic Learning engine
- Hindsight-specific storage
- Hindsight-specific retrieval
- Obsidian as canonical storage

---

# Architectural Gap

The research now considers the following gap confirmed:

> MCU lacks an explicit owner for durable understanding derived from Evidence
> that is neither source Evidence nor institutional Knowledge.

The working name for that responsibility is:

```text
Insight
```

This finding is strong enough to begin architectural decision work.

It is not yet strong enough to define the complete decision.

---

# Questions Required Before ADR Acceptance

Before an Insight ADR can be accepted, MCU must answer:

## Ownership

Who owns Insight?

Candidates include:

- a program-level shared responsibility
- a capability
- a discipline
- capability-local implementations behind a shared contract

## Artifact Model

Is Insight:

- a Domain Artifact
- a specialized Evidence representation
- another managed artifact type
- or something else?

## Persistence Threshold

Which inference results deserve durable persistence as Insight?

Not every inference result should survive execution.

## Lifecycle

What minimum lifecycle does Insight require?

Potential concerns include:

- active
- stale
- invalidated
- superseded
- recomputation

## Scope

What may own or consume an Insight?

Potential scopes include:

- Worker
- Task
- Project
- capability
- discipline
- program

## Execution Policy

When may Insight influence Execution State?

## Promotion Policy

How does Insight become eligible to influence or modify Knowledge Packages?

## Provider Boundary

What minimum contract would allow implementations such as Hindsight to provide
Insight capabilities without MCU depending on Hindsight's ontology?

---

# Current Conclusion

The adversarial reconciliation attempted to represent the candidate
responsibility using existing Evidence and Knowledge architecture.

That attempt failed cleanly.

Evidence owns reasoning material.

Inference owns reasoning.

Knowledge Packages own institutional methodology.

None owns the durable result of selected reasoning across accumulated Evidence.

A new responsibility is therefore justified for further architectural design.

The current working term is:

```text
Insight
```

The next step is not implementation.

The next step is to define the smallest viable Insight contract and answer the
decision questions required for an ADR.
