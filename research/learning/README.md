# Learning Architecture Research

## Purpose

This research investigates how experience from completed or ongoing work can
influence future MCU Worker execution without collapsing Evidence, Knowledge,
runtime continuity, and learned state into a generic "memory" abstraction.

The first reference architecture studied is Hindsight.

Hindsight was selected because it explicitly models:

- retained facts
- Worker-like experiences
- observations derived from evidence
- temporal evolution
- provenance
- contradiction
- invalidation
- consolidation
- mental models
- projected knowledge pages

The objective is not to integrate Hindsight.

The objective is to determine whether MCU is missing a durable responsibility
between Evidence and Knowledge.

---

## Research Question

> How can learned experience influence future Worker execution without
> violating MCU's existing Knowledge Package, Evidence, Domain Artifact,
> governance, and orchestration boundaries?

The study must distinguish:

```text
Session continuity
Preference
Evidence
Experience
Learning
Knowledge
Skill
```

These terms are not assumed to represent separate MCU primitives.

---

# Existing MCU Constraints

This research begins with architectural constraints that already exist in MCU.

## Responsibilities Outlive Implementations

MCU assigns architecture according to durable responsibility rather than
current frameworks, models, runtimes, languages, or tools.

Hindsight is therefore treated as:

- an evidence source
- a reference architecture
- a possible future provider

It is not treated as the owner of MCU's learning architecture.

---

## Orchestration Owns Execution Composition

MCU already establishes that orchestrators compose Execution State from
capability-owned artifacts.

Any learned state that influences Worker execution must enter through
appropriate composition boundaries.

A learning provider should not become an independent competing control plane.

---

## Knowledge Packages Own Institutional Methodology

MCU Knowledge Packages describe durable engineering knowledge and methodology
independently from the execution engine.

Learning must therefore not silently mutate canonical Knowledge Packages.

Learned material may eventually:

- influence transient execution
- become supporting evidence
- become a proposed Knowledge change
- or remain provider-local derived state

The correct lifecycle remains under research.

---

## Evidence Is Implementation Independent

MCU already separates Runtime providers from Evidence.

Engineering reasoning consumes Evidence rather than depending directly on the
provider that discovered it.

Learning must preserve this boundary where applicable.

---

# Hindsight Domain Model

## Core Memory Types

Hindsight distinguishes four important categories:

### World Facts

Facts about the external world.

Example:

```text
The repository requires Node 20.
```

### Experiences

Facts describing actions, observations, or interactions performed by the
agent that owns the memory scope.

Example:

```text
I attempted the build using Node 18 and it failed.
```

Hindsight determines this distinction according to whose perspective the fact
captures, not merely whether the sentence uses first-person grammar.

### Observations

Observations are derived, evidence-grounded beliefs synthesized from multiple
source facts.

They are:

- deduplicated
- grounded in specific source memories
- associated with supporting evidence
- associated with proof counts
- refined as new evidence arrives
- freshness-aware
- regenerated when their source material changes

### Mental Models

Mental Models are maintained syntheses that answer standing questions over a
memory scope.

They are:

- explicitly defined around a question
- stored ahead of request time
- refreshed as underlying knowledge changes
- scope-aware
- provenance-preserving
- versioned through previous content
- usable as settled context when sufficiently fresh

---

# Knowledge Pages Are Projection, Not Another Knowledge Layer

Hindsight Knowledge Pages are Mental Models presented through a simpler,
document-oriented interface.

They add:

- folders
- wiki-like navigation
- search
- Markdown projection
- filesystem access

They do not introduce a fundamentally new epistemic layer.

The useful distinction is therefore:

```text
Raw Fact
   |
   v
Observation
   |
   v
Mental Model
```

with Knowledge Pages acting as a projection of Mental Models:

```text
Mental Model
     |
     v
Knowledge Page
     |
     +---- Markdown
     +---- filesystem
     +---- UI
     +---- search
```

This is relevant to future human-facing tools such as Obsidian.

The presentation mechanism should not become canonical storage merely because
it is convenient for humans.

---

# Evidence and Experience

## Experience Matters

Hindsight distinguishes external facts from the agent's own experiences.

That distinction appears useful to MCU.

Consider:

```text
External fact:
The repository declares Node >= 20.

Worker experience:
The Worker attempted the build under Node 18 and observed ERR_X.

External fact:
The same build succeeded under Node 20.
```

These statements have different provenance even when they contribute to the
same conclusion.

## Current MCU Interpretation

The current research does not justify introducing Experience as a new
top-level MCU primitive.

A more conservative interpretation is:

> Experience is Evidence with Worker-specific provenance.

Conceptually:

```text
Evidence
 |
 +---- external observation
 +---- tool result
 +---- human assertion
 +---- Worker experience
 +---- other evidence source
```

This interpretation must be tested against MCU's existing Evidence
architecture before it becomes a decision.

---

# Source State and Derived State

This is the strongest architectural lesson from Hindsight.

## Source Facts Remain Distinct

Hindsight retains raw world and experience facts as source material.

Derived observations do not replace those sources.

## Observations Are Recomputable

When source memories change or disappear, affected observations are removed
and regenerated from the remaining source material.

Observations are therefore derived state.

## Derived State Is Not Directly Curated

Hindsight does not allow an Observation to be corrected as though it were a
source fact.

Instead:

```text
correct source
      |
      v
invalidate affected derivation
      |
      v
recompute
```

This prevents a synthesized belief from becoming an untraceable replacement
for its own evidence.

## Candidate MCU Invariant

The Hindsight study suggests the following candidate invariant:

> Derived learning must not become the authoritative source for the Evidence
> from which it was inferred.

A related operational rule is:

> Correct sources; regenerate derivations.

These are research findings.

They are not yet accepted MCU architecture.

---

# Provenance

Hindsight preserves provenance through its derived layers.

## Observation Provenance

An Observation retains references to the source memories that support it.

Supporting evidence includes exact source material and a proof count.

## Mental Model Provenance

A Mental Model retains the facts and observations from which it was
constructed.

It also retains previous content when refreshed.

## Attachment Provenance

When a fact is extracted from an image or other attachment, Hindsight retains
the attachment relationship.

Derived observations can continue to expose those source attachments.

## MCU Implication

Any durable learned state in MCU should likely preserve sufficient provenance
to answer:

```text
What does the system currently believe?

Why does it believe that?

Which Evidence supports it?

When was that Evidence obtained?

How was the learned state derived?

What changed since the previous version?
```

The exact representation remains undecided.

---

# Temporal Semantics

Hindsight distinguishes multiple notions of time.

## Occurrence Time

When the represented event happened.

Example:

```text
The deployment failed on 2026-10-01.
```

## Retention Time

When the system learned or retained the fact.

The system may learn today about an event that occurred months ago.

Therefore:

```text
occurred_at != retained_at
```

## Derivation and Freshness

Observations and Mental Models introduce additional temporal concerns:

- when a synthesis was produced
- whether newer source material exists
- whether the synthesis is still fresh enough to trust directly
- when it was last refreshed

## Candidate MCU Requirement

If MCU introduces durable learned state, a single timestamp is unlikely to be
sufficient.

The architecture may need to distinguish concepts equivalent to:

```text
occurred_at
observed_or_retained_at
derived_at
freshness_or_validity
```

Exact field names and semantics remain undecided.

---

# Contradiction and Evolution

Hindsight does not treat contradiction as an automatic overwrite.

When newer facts conflict with an existing Observation, consolidation can
refine the Observation to preserve the evolution of understanding.

Example:

```text
Earlier:
User prefers React.

Later:
User has switched to Vue and no longer uses React.

Derived understanding:
User previously preferred React but has since moved to Vue.
```

This is materially different from last-write-wins storage.

The raw source facts remain available.

The derived state expresses the current reconciled understanding while
preserving provenance.

This suggests MCU learning may require explicit semantics for:

- contradiction
- supersession
- correction
- temporal evolution
- current validity

---

# Invalidation and Reversibility

Hindsight's curation model provides another strong architectural lesson.

## Invalidated Source Facts

A source fact can be retired from active use without destroying its audit
history.

An invalidated fact:

- disappears from active recall
- stops contributing to consolidation
- has affected derived observations recomputed
- remains recoverable
- remains visible for audit

## Corrected Source Facts

Editing a source fact causes Hindsight to rebuild the dependent derived state.

The architecture therefore preserves a distinction between:

```text
historical record
```

and:

```text
currently active truth
```

## Candidate MCU Invariant

Durable learning should be reversible without requiring historical evidence to
be destroyed.

This may imply lifecycle concepts such as:

```text
active
invalidated
superseded
```

but no MCU lifecycle has yet been selected.

---

# Scope

Hindsight isolates retained state through Banks and further scopes derived
Observations and Mental Models through tags.

Banks can represent a user, agent, or project.

MCU should not adopt Bank as a program-level concept.

MCU already has stronger identity and ownership concepts, including:

- program
- capability
- Worker
- Initiative
- Project
- Task

A future Hindsight provider should translate MCU scope into provider-specific
Banks and tags.

Conceptually:

```text
MCU scope
    |
    v
provider adapter
    |
    v
Hindsight Bank / tags
```

not:

```text
Hindsight Bank
    |
    v
new MCU ontology
```

---

# Recall Is Not Knowledge Ownership

Hindsight Recall combines:

- semantic search
- keyword search
- graph traversal
- temporal search
- rank fusion
- reranking
- token-budget selection

These mechanisms are valuable provider capabilities.

They do not need to become MCU architectural primitives.

From MCU's perspective, Recall is currently best understood as a provider
operation that may supply relevant retained or learned material to execution
composition.

The retrieval implementation remains replaceable.

---

# Reflect Is Not Automatically Knowledge

Hindsight Reflect reasons over retained state.

Its retrieval hierarchy can prefer:

1. Mental Models
2. Observations
3. Raw Facts

Reflect may therefore produce useful analysis from learned state.

However, a Reflect result is not automatically canonical MCU Knowledge.

It may instead represent:

- transient inference
- execution context
- Evidence
- a proposed learned insight
- or a candidate Knowledge change

The owning responsibility remains unresolved.

---

# Candidate MCU Learning Layer

The Hindsight study suggests a possible missing lifecycle between Evidence and
Knowledge.

This is currently a research model:

```text
                        Execution
                            |
                            v
                         Evidence
                            |
                            v
                   Learning / Synthesis
                            |
                            v
                    Learned Insight
                            |
               +------------+------------+
               |                         |
               v                         v
       execution context         promotion candidate
                                         |
                                         v
                                      Review
                                         |
                                         v
                                Knowledge Package
                                         |
                                         v
                                future execution
```

This model deliberately prevents derived learning from silently mutating
canonical Knowledge.

---

# Learned Insight

`Learned Insight` is a working research term.

It is not yet an accepted MCU primitive.

The term currently means:

> A durable, derived understanding synthesized from Evidence, with sufficient
> provenance and temporal information to explain and reconsider the
> derivation.

Potential characteristics include:

- derived rather than directly observed
- Evidence-backed
- scoped
- temporal
- freshness-aware
- reversible
- supersedable
- capable of influencing future execution
- potentially eligible for promotion into Knowledge

The next reconciliation step must determine whether this responsibility is
genuinely missing or whether existing Evidence and Knowledge architecture can
already represent it without another primitive.

---

# Learned Insight Is Not Knowledge Package

This distinction is currently important.

A Learned Insight answers something like:

```text
What does accumulated Evidence suggest is true?
```

A Knowledge Package can answer something like:

```text
How should engineering work be performed?
```

The former is primarily epistemic.

The latter may be normative and prescriptive.

Example:

```text
Learned Insight:

Projects using dependency pattern X have repeatedly failed under Node 18.


Knowledge Package:

Before dependency installation, verify the repository's declared Node
requirement and activate a compatible runtime.
```

The first may support the second.

It should not automatically become the second.

---

# Governance Boundary

Hindsight does not require human review before every derived Observation or
Mental Model refresh.

That is an important finding.

The external system therefore does not independently prove that all learned
state requires human approval.

MCU nevertheless has stronger governance requirements around canonical
Knowledge.

A possible distinction is:

```text
Evidence
   |
   v
Learned Insight
   |
   +---- may influence execution under policy
   |
   +---- may become Knowledge promotion candidate
                              |
                              v
                            Review
                              |
                              v
                      Knowledge Package
```

Whether learned state may influence execution before promotion is a policy
question that remains unresolved.

---

# Obsidian and Human-Facing Knowledge

The Hindsight study clarifies where a tool such as Obsidian could fit.

Hindsight Knowledge Pages are projected views over underlying learned state.

They can be exposed as ordinary Markdown without making Markdown files the
canonical storage model.

That suggests a useful future MCU pattern:

```text
canonical MCU knowledge / learned state
                |
                v
         Markdown projection
                |
        +-------+-------+
        |       |       |
        v       v       v
     Obsidian   CLI   Worker tools
```

Obsidian could therefore become an excellent human-facing interface.

It should not become a required canonical knowledge database merely because
it provides a convenient editing and navigation experience.

No decision to adopt Obsidian has been made.

---

# Concepts Deliberately Not Adopted

The Hindsight study does not currently justify adding these as MCU
program-level concepts:

- Memory
- Memory Bank
- Retain
- Recall
- Reflect
- Observation
- Mental Model
- Knowledge Page

These are useful Hindsight concepts and provider operations.

MCU should adopt responsibilities only when they survive reconciliation with
existing architecture.

---

# Hindsight Responsibility Mapping

| Hindsight Concept | Responsibility | Current MCU Interpretation |
| --- | --- | --- |
| World fact | retained external fact | Evidence |
| Experience | retained Worker-owned fact | Evidence with Worker provenance |
| Observation | derived evidence-grounded belief | Learned Insight candidate |
| Mental Model | maintained synthesis | Derived Knowledge View candidate |
| Knowledge Page | projected Mental Model | Presentation / projected artifact |
| Bank | isolation and scope | Provider implementation |
| Retain | ingestion and extraction | Evidence / learning provider operation |
| Recall | retrieval | Execution composition input |
| Reflect | reasoning over retained state | Inference capability |
| Curation | correction and invalidation | Evidence lifecycle concern |
| Consolidation | evidence-grounded derivation | Learning operation |

---

# Candidate Architecture Invariants

The Hindsight research suggests several candidate invariants.

These require reconciliation before acceptance.

## Source and derivation remain distinct

Derived learning must not replace the Evidence from which it was inferred.

## Correct sources; regenerate derivations

Corrections should flow from authoritative source material into recomputed
derived state.

## Durable learning preserves provenance

A durable learned conclusion should be traceable to the Evidence supporting
it.

## Durable learning is temporally aware

The architecture should distinguish when something happened from when it was
learned and when a synthesis was produced.

## Invalidation should preserve audit history

Removing information from active reasoning should not require destroying the
historical record.

## Knowledge promotion is explicit

Derived understanding should not silently mutate canonical institutional
Knowledge.

---

# Current Conclusion

Hindsight does not justify introducing a generic MCU Memory subsystem.

Instead, it provides strong evidence that MCU may be missing an explicit
learning lifecycle between Evidence and Knowledge.

The most important unresolved responsibility is represented in this research
by the working term:

```text
Learned Insight
```

The next step is to reconcile this candidate responsibility directly against
ADR-0018 Knowledge Packages and ADR-0019 Evidence.

The question is:

> Does MCU require a first-class durable Learned Insight responsibility, or
> can existing Evidence and Knowledge architecture represent this lifecycle
> without introducing another primitive?

No implementation should begin before that question is answered.
