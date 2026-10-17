# Durable Intelligence Architecture Research — MCU Reconciliation

## Purpose

The Durable Intelligence research investigated several candidate concepts
arising from practical continuity needs and the study of Obsidian, Hindsight,
and existing MCU architecture.

The candidates included:

- Project Continuity
- Checkpoint
- Current State
- Knowledge Workspace
- Reference
- Projection
- Promotion
- Second Brain

This document reconciles those candidates against accepted MCU architecture.

The objective is adversarial.

A new architectural responsibility should survive only when existing MCU
responsibilities cannot represent it honestly without weakening established
boundaries.

This is a research synthesis.

It is not an Architectural Decision Record.

---

# Reconciliation Result

## Verdict

Most candidate concepts collapse into responsibilities or relationships MCU
already owns.

One responsibility survives:

```text
Project Continuity
```

Working definition:

> Project Continuity owns the durable project-specific state required for a
> future Worker to safely resume work without access to the Execution or
> Runtime Session that produced that state.

The remaining candidates resolve as follows:

```text
Project Continuity
    missing responsibility

Checkpoint
    candidate continuity representation

Current State
    candidate continuity projection/state

Knowledge Workspace
    infrastructure

Reference
    relationship

Projection
    view / representation concern

Promotion
    existing lifecycle/governance concern with underspecified workflow

Second Brain
    human metaphor; no MCU architectural semantics
```

---

# Execution State Boundary

ADR-0014 establishes that Execution State is transient.

It exists only for the lifetime of an execution workflow.

This is intentionally different from Project Continuity.

Conceptually:

```text
Execution State
    transient
    one execution workflow

Project Continuity
    durable
    crosses executions
    crosses Runtime sessions
    crosses Runtime providers
    may cross Workers
```

Persisting Execution State does not automatically make it Project Continuity.

Execution State is composed for execution.

Project Continuity must preserve the minimum project-specific state required
for safe resumption.

---

# Runtime Session Boundary

Agent Runtime research identified Session as a possible provider-specific
continuity mechanism.

Some Runtime providers may preserve:

- conversation state
- native session IDs
- provider context
- resumable execution history

Other Runtime providers may not.

Project Continuity cannot depend on those mechanisms.

## Candidate Invariant

> Project Continuity must not depend on Runtime Session continuity.

Runtime-native Session continuity may improve resumption.

It must not be the only location of required project state.

---

# Worker Boundary

A persistent Worker identity does not guarantee persistent execution context.

A Worker may:

- begin a new Execution
- lose Runtime-native context
- change Runtime provider
- move to another environment
- be replaced by another Worker

Project Continuity therefore belongs outside Worker conversational state.

A fresh Worker with appropriate project access should be able to determine
enough durable state to continue work safely.

---

# Repository Boundary

The current research strongly favors the project repository as the durable
location for project-owned continuity state.

A project should remain continuable after:

```text
fresh clone
+
appropriate MCU tooling
+
no previous conversation
+
no previous Runtime Session
```

This does not mean every repository file belongs to Project Continuity.

The repository already contains authoritative project artifacts owned by other
responsibilities.

Project Continuity should reference and summarize the continuation-relevant
state of those artifacts without taking ownership of them.

---

# Domain Artifact Reconciliation

ADR-0013 establishes:

- each capability owns one constitutional responsibility
- each capability produces one canonical Domain Artifact
- orchestration composes artifacts
- capabilities do not absorb ownership of other artifacts

Project Continuity therefore requires one canonical Domain Artifact if it
becomes an MCU capability.

Working research term:

```text
Continuity Artifact
```

This term is provisional.

The exact structure has not yet been designed.

---

# Checkpoint Reconciliation

Checkpoint survives as a useful concept but not as an independent
constitutional responsibility.

A Checkpoint answers:

```text
What changed during a meaningful work segment?
```

Potential checkpoint information includes:

- objective
- starting state
- completed work
- decisions
- rejected approaches
- validation
- unresolved questions
- deferred work
- repository state
- next action
- critical continuation context

Checkpoint is therefore candidate historical continuity material.

It should not introduce:

- a separate capability
- a separate constitutional responsibility
- a competing canonical project state

---

# Automatic Checkpoints

The research supports automatic checkpoint creation at semantic gates rather
than arbitrary message counts.

Potential triggers include:

- accepted architectural decision
- completed research reconciliation
- completed implementation phase
- passed validation gate
- significant commit
- Worker handoff
- Runtime transition
- blocked work
- approval boundary
- context pressure
- graceful shutdown

These triggers are research inputs.

No automatic checkpoint policy has yet been accepted.

---

# Manual Checkpoints

Manual checkpoint creation remains a requirement.

A human or Worker should be able to identify an important semantic moment that
automatic policy may not recognize.

Potential interaction language includes:

```text
checkpoint
checkpoint this
prepare handoff
save project state
```

These phrases do not define an MCU command API.

They demonstrate the requirement for explicit checkpoint initiation.

---

# Current State Reconciliation

Current State answers a different question from Checkpoint.

```text
Checkpoint
    What changed?

Current State
    What is true now?
```

Current State does not currently justify another constitutional responsibility
or independently owned Domain Artifact.

It is more likely:

- a projection over continuity state
- a maintained section of the Continuity Artifact
- or a generated view derived from continuity history and authoritative
  repository state

The exact model remains unresolved.

## Candidate Principle

Current State should reconcile durable changes rather than recursively
summarizing prior summaries.

Historical checkpoint material should remain independently available when
needed.

---

# Continuity Artifact Candidate

The smallest current conceptual model is:

```text
Project Continuity
        |
        v
Continuity Artifact
        |
        +---- resumable current state
        +---- checkpoint history
        +---- unresolved work
        +---- critical references
        +---- next action
```

This is not a schema.

It exists only to expose the responsibility that survived reconciliation.

The contract must be designed before an ADR is considered.

---

# Continuity Does Not Own Project Truth

Project Continuity does not replace authoritative project artifacts.

It does not own:

- implementation
- architecture
- ADRs
- Evidence
- Insight
- Knowledge Packages
- test results
- repository history
- Runtime Sessions
- Execution State

It may reference those artifacts where necessary for continuation.

The original artifact remains authoritative for its own responsibility.

---

# Knowledge Workspace Reconciliation

The candidate Knowledge Workspace does not survive as a program-level
responsibility.

A filesystem-backed workspace may provide:

- storage
- navigation
- indexing
- cross-project references
- human-authored notes
- projections
- discovery

Those are infrastructure and presentation concerns unless another owned
artifact establishes their semantics.

Therefore:

```text
Knowledge Workspace
    !=
new MCU primitive
```

A workspace may host or project MCU-owned material without becoming its
canonical semantic owner.

---

# Obsidian Reconciliation

Obsidian remains a promising human-facing interface because its durable
material can remain ordinary filesystem-backed Markdown, YAML, and
attachments.

Current interpretation:

```text
durable filesystem knowledge workspace
        |
        v
Obsidian
human-facing interface
```

Obsidian does not need to own:

- Project Continuity
- Insight
- Knowledge
- project truth
- checkpoint semantics

Its replaceability is a positive architectural property.

No decision to adopt Obsidian has been made.

---

# Reference Reconciliation

Reference does not survive as an independent responsibility.

A reference is a relationship between owned artifacts or material.

Examples include:

```text
Checkpoint -> ADR

Evidence -> source artifact

Insight -> Evidence

Knowledge note -> repository artifact
```

MCU may eventually require portable reference semantics.

That does not imply a Reference capability or Reference Domain Artifact.

---

# Projection Reconciliation

Projection does not survive as an independent responsibility.

ADR-0020 already establishes that human-readable representations may project
canonical state without becoming canonical storage.

Examples may include:

- Markdown
- reports
- dashboards
- CLI views
- Obsidian notes
- generated indexes

Projection is a representation concern.

The canonical owner remains the underlying artifact.

---

# Promotion Reconciliation

Promotion does not survive as a new architectural responsibility.

ADR-0020 already establishes the lifecycle:

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

The promotion workflow remains underspecified.

Future design must still determine concerns such as:

- proposal authority
- review authority
- required Evidence
- rationale
- versioning
- automation policy

This is contract and governance work.

It is not evidence for a separate Promotion capability.

---

# Project-to-Knowledge Boundary

The research initially asked:

> What moves from project-local truth into the cross-project knowledge
> workspace?

Reconciliation suggests that `move` is usually the wrong model.

Authoritative artifacts should remain with their owners.

Cross-boundary behavior may instead include:

## Reference

A cross-project note points to an authoritative repository artifact.

## Projection

A human-readable or indexed representation is generated from canonical state.

## Derivation

Project Evidence contributes to a new Insight.

## Governed Knowledge Change

Insight supports a proposed Knowledge Package revision.

This avoids copying authoritative project state into a competing canonical
store.

---

# Copying Is Not Promotion

Copying project material into another workspace does not change its semantic
ownership.

For example:

```text
repository research artifact
        |
        | copied
        v
vault Markdown file
```

does not make the vault copy authoritative.

If duplication exists for convenience, authority must remain explicit.

The preferred architecture should favor:

- references
- projections
- derived artifacts

over uncontrolled duplication.

---

# Second Brain Reconciliation

`Second Brain` does not survive as an MCU architectural concept.

It remains a useful human metaphor for the combined experience of:

- project continuity
- Insight
- Knowledge
- references
- projections
- retrieval
- human navigation
- machine learning providers

Those responsibilities should not collapse into one owner.

Therefore MCU should not introduce:

```text
Second Brain capability

Second Brain artifact

Second Brain store
```

The phrase may remain useful in ordinary conversation.

---

# Hindsight Reconciliation

Hindsight remains a possible provider for machine-oriented learning mechanics.

Potential concerns include:

- retention
- consolidation
- recall
- reconsideration
- derived learning

ADR-0020 already owns Insight semantics.

Hindsight does not own Project Continuity.

A Hindsight memory store cannot be the only location required to resume a
project.

No Hindsight provider has been selected.

---

# Durable Intelligence Model After Reconciliation

The simplified model is:

```text
                     MCU

              Project Continuity
                     |
                     v
              Project Repository
                     |
              continuation state


Evidence ---> Inference ---> Insight
                           |
                           | governed proposal
                           v
                       Knowledge


filesystem knowledge workspace
        |
        +---- references
        +---- projections
        +---- human-authored material
        |
        v
     Obsidian
 human interface


Hindsight
    |
    v
provider mechanics supporting learning / Insight
```

The filesystem knowledge workspace is infrastructure rather than a new
constitutional owner.

---

# Surviving Architectural Gap

The reconciliation confirms one missing responsibility:

> MCU lacks an explicit owner for durable project-specific continuation state
> that survives the Execution and Runtime Session that produced it.

Working term:

```text
Project Continuity
```

This responsibility is sufficiently distinct to justify contract design.

It is not yet sufficiently defined for an ADR.

---

# Questions Required Before ADR Acceptance

## Responsibility Boundary

What is the minimum state Project Continuity owns?

## Artifact Model

What is the canonical Continuity Artifact?

## Checkpoint Model

How are historical semantic checkpoints represented?

## Current State

Is Current State:

- canonical state inside the Continuity Artifact
- a projection
- or derived from repository truth plus checkpoint history?

## References

How does Continuity reference authoritative artifacts without duplicating
their ownership?

## Freshness

How does a future Worker know whether continuity state is stale relative to the
repository?

## Triggers

Which automatic checkpoint triggers belong in the program contract versus
implementation policy?

## Manual Trigger

What provider-independent operation requests an explicit checkpoint?

## Composition

How does orchestration consume continuity state when beginning a new
Execution?

## Worker Independence

What minimum information allows a different Worker to resume safely?

## Runtime Independence

What information must remain independent from provider-native Session state?

## Security

What information must never be persisted into Continuity because it may
contain secrets, credentials, transient sensitive context, or inappropriate
execution data?

---

# Current Conclusion

The durable-intelligence reconciliation substantially simplifies the candidate
architecture.

No new architecture is justified for:

- Knowledge Workspace
- Reference
- Projection
- Promotion
- Second Brain

Checkpoint and Current State remain useful continuity concepts but do not
independently justify constitutional responsibilities.

One responsibility remains unowned:

```text
Project Continuity
```

The next step is to design the smallest viable Project Continuity contract.

No implementation should begin before that contract is reviewed.
