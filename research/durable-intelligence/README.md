# Durable Intelligence Architecture Research

## Purpose

This research investigates how MCU should preserve durable project context,
cross-project knowledge, machine-derived learning, and human-accessible
knowledge without making any Worker runtime, conversation system, application,
or synchronization provider the canonical owner of truth.

The immediate trigger for this research was practical.

Long-running project conversations can exceed Runtime context limits. A fresh
Worker or conversation may not have complete access to the execution history
that produced the current project state.

This creates a continuity requirement:

> Durable work must remain continuable without access to the execution context
> that produced it.

The first human knowledge-workspace architecture studied for this question is
Obsidian.

Existing Hindsight research also informs the machine-learning boundary.

This document records current findings.

It is not an Architectural Decision Record.

---

# Research Question

The current research question is:

> How should project-local truth, cross-project durable knowledge,
> machine-derived learning, and human-facing knowledge surfaces relate without
> creating competing canonical stores?

A related continuity question is:

> What minimum provider-independent durable state allows a fresh Worker with
> zero conversation or Runtime session history to safely continue project
> work?

Checkpoint architecture is intentionally deferred until the broader durable
intelligence boundaries are understood.

---

# Existing MCU Constraints

## Responsibilities Outlive Implementations

MCU assigns architecture according to durable responsibilities rather than
current applications, models, runtimes, or storage products.

Therefore:

```text
Obsidian
Hindsight
ChatGPT
Codex
Claude
GitHub
```

may implement or consume MCU responsibilities.

They do not define those responsibilities.

---

## Project Repositories Already Own Project Truth

Project repositories contain durable project-specific material such as:

- architecture
- ADRs
- research
- implementation
- tests
- project documentation
- configuration
- validation artifacts

The current research strongly favors extending this principle to project
continuity.

A project should remain continuable from its repository without requiring the
conversation or Runtime that produced it.

---

## Insight Already Exists

ADR-0020 establishes Insight as durable understanding derived from Evidence.

Insight is distinct from:

- source Evidence
- transient Inference
- institutional Knowledge

This provides a useful boundary for determining which project-derived
understanding may eventually have value outside the project that produced it.

---

# Continuity Requirement

Conversation history and Runtime-native session persistence are useful
continuity mechanisms.

They are not sufficient as authoritative project continuity.

Examples include:

- ChatGPT conversation context
- Claude session resume
- Codex session state
- provider-native Agent sessions

These may disappear, become unavailable, exceed context limits, or be replaced
by another Runtime.

The project must not become uncontinuable when that occurs.

## Candidate Continuity Invariant

> Durable work must remain continuable without access to the execution context
> that produced it.

This is a research finding.

It is not yet accepted architecture.

---

# Runtime Continuity and Project Continuity

The current research distinguishes:

```text
Runtime Session
    provider-specific continuity optimization

Project Continuity
    durable provider-independent work state
```

A Runtime session may make continuation cheaper or richer.

It must not be the only place required project state exists.

Conceptually:

```text
Worker / Runtime
       |
       v
    Execution
       |
       v
durable project state
       |
       v
fresh Worker / Runtime
```

This distinction connects directly to the unresolved Session and Execution
questions identified during Agent Runtime research.

---

# Checkpoints

A practical requirement has emerged for semantic project checkpoints.

A checkpoint would preserve the state necessary to understand what changed
during a meaningful work segment.

Potential checkpoint content includes:

- objective
- starting state
- completed work
- decisions
- rejected approaches
- files changed
- architecture established
- validation completed
- unresolved questions
- deferred work
- current repository state
- next recommended action
- critical continuation context

## Automatic Checkpoints

Potential semantic triggers include:

- architectural decision accepted
- research reconciliation completed
- implementation phase completed
- validation gate passed
- significant commit landed
- Worker handoff
- Runtime transition
- work becomes blocked
- approval boundary reached
- execution context pressure
- graceful shutdown

Automatic policy should favor semantic gates rather than arbitrary message
counts.

## Manual Checkpoints

A human or Worker should also be able to explicitly request a checkpoint at an
important semantic moment.

Potential interaction language may include:

```text
checkpoint
checkpoint this
prepare handoff
save project state
```

These are interaction examples, not an accepted command API.

## Architecture Deferred

Checkpoint storage, composition, and ownership are intentionally not decided
yet.

The second-brain boundary must be understood first.

---

# Checkpoint and Current State Are Different

A checkpoint answers:

```text
What changed during this work segment?
```

Current project state answers:

```text
What is true now?
```

These should not be conflated.

A possible future model is:

```text
Checkpoint N-2 ---+
Checkpoint N-1 ---+--> State Composition --> Current State
Checkpoint N   ---+
```

Historical checkpoints should remain available.

Current State should reconcile changes rather than repeatedly summarize prior
summaries.

This avoids progressive information loss through recursive summarization.

---

# Obsidian Research

## Scope

The initial Obsidian study considered:

- Obsidian core
- official first-party capabilities
- official developer APIs
- official CLI
- official Sync architecture
- official Headless Sync
- Bases
- Properties
- links and backlinks
- filesystem behavior

Community plugins were deliberately excluded.

The objective was architectural evaluation rather than product evaluation.

---

# Obsidian Storage Model

An Obsidian vault is fundamentally a filesystem directory.

Notes are stored as Markdown files.

Attachments are ordinary files.

Structured note metadata can be represented through YAML properties stored
with the Markdown content.

The files can be accessed and modified by tools other than Obsidian.

This is a strong portability property.

## Failure Test

The important architectural test is:

```text
Remove the Obsidian application.
```

The underlying durable material remains:

- Markdown
- YAML properties
- attachments
- directories
- ordinary filesystem relationships

Application-provided behavior may disappear, including:

- graph visualization
- metadata cache
- backlinks UI
- Bases rendering
- workspace layout
- plugin behavior

The durable knowledge does not disappear with the application.

This strongly favors Obsidian as a replaceable human interface rather than a
canonical proprietary knowledge store.

---

# Canonical State and Derived Indexes

Obsidian derives useful indexes and views from filesystem content.

Examples include:

- backlinks
- graph relationships
- search indexes
- metadata cache
- Bases views

These can be reconstructed from durable files.

The emerging pattern is:

```text
Markdown / YAML
       |
       +---- links
       +---- properties
       +---- aliases
       |
       v
derived indexes
       |
       +---- backlinks
       +---- graph
       +---- search
       +---- Bases
```

## Research Finding

> Derived indexes should not become canonical knowledge merely because they
> make knowledge easier to navigate.

This aligns with findings from Hindsight and MinerU.

---

# Bases as Projection

Obsidian Bases provides database-like views over file-backed notes and their
properties.

The underlying durable data remains in Markdown and YAML.

Bases therefore reinforces the distinction:

```text
canonical durable data
        |
        v
projection / view
```

Potential views include:

- tables
- lists
- cards
- boards
- maps

The view does not need to own the underlying knowledge.

---

# Machine Access

The initial research identified several machine-access paths.

## Filesystem

Workers can operate directly on Markdown, YAML, and attachments.

This is the most provider-independent path.

## Obsidian API

Obsidian exposes official APIs for interacting with vault content from
extensions.

## Obsidian CLI

Obsidian provides official command-line capabilities for scripting and
automation.

## Headless Sync

Obsidian provides an official headless synchronization client intended for
automated and non-desktop environments.

This makes it possible for automated systems to participate in synchronized
vault workflows without requiring the desktop application as the only access
path.

---

# Sync Is Transport

The research does not currently justify making Obsidian Sync part of MCU
knowledge semantics.

The durable architectural boundary is the filesystem-backed knowledge
workspace.

Synchronization may be implemented by:

- Obsidian Sync
- Git
- filesystem synchronization
- another future provider

Conceptually:

```text
Knowledge Workspace
        |
        v
filesystem
        |
        v
Sync Provider
```

The synchronization provider should remain replaceable.

---

# Obsidian Identity Concern

Obsidian note relationships are substantially path- and filename-oriented.

Application behavior can maintain links when files are renamed through
Obsidian.

External Workers modifying filesystem paths cannot automatically assume those
application semantics occurred.

This suggests that durable MCU knowledge identity should not depend solely on:

- filesystem path
- note title
- Obsidian display name

A future durable knowledge model may require explicit stable identity.

For example:

```yaml
---
id: knowledge-accessibility-wcag
type: knowledge
---
```

This is illustrative only.

No identity schema has been accepted.

## Candidate Principle

```text
Knowledge identity
    !=
filesystem path
    !=
Obsidian note title
```

---

# Obsidian-Specific Markdown

Obsidian supports Markdown extensions and application-specific linking
features.

Some constructs are more portable than others.

This creates a potential boundary:

```text
Portable Knowledge Core
    Markdown
    YAML
    portable links where practical

Obsidian Enhancements
    application-specific navigation
    presentation
    convenience
```

MCU should avoid making application-specific presentation identifiers
fundamental knowledge identities.

This finding aligns with MinerU research showing the danger of binding durable
source identity to transient presentation.

---

# Repository and Knowledge Workspace

The Obsidian research strengthens the distinction between project-local truth
and cross-project knowledge.

## Project Repository

Candidate responsibility:

```text
What is true about this project?
```

Potential contents include:

- architecture
- ADRs
- implementation
- research
- project state
- checkpoints
- validation
- unresolved project work

A project should remain continuable from this material.

## Cross-Project Knowledge Workspace

Candidate responsibility:

```text
What durable information should remain useful across projects?
```

Potential contents include:

- curated notes
- relationships
- cross-project Insights
- institutional Knowledge projections
- references to project material
- human-authored context

The exact promotion boundary remains unresolved.

---

# Obsidian Is Not the Second Brain

The research currently rejects:

```text
Obsidian = second brain architecture
```

A better model is:

```text
Filesystem-backed durable knowledge workspace
        |
        +---- Worker access
        +---- CLI access
        +---- automation
        |
        v
Obsidian
human-facing interface
```

Obsidian is attractive precisely because the durable material can survive
without it.

---

# Hindsight and Obsidian

Hindsight and Obsidian currently appear complementary rather than competing.

## Hindsight

Potential responsibility:

- retention mechanics
- consolidation
- recall
- reconsideration
- machine-derived learning
- Insight production or support

## Filesystem Knowledge Workspace

Potential responsibility:

- explicit durable cross-project material
- curated relationships
- human-authored knowledge
- inspectable durable state

## Obsidian

Potential responsibility:

- human navigation
- editing
- visualization
- discovery
- projection over the knowledge workspace

These responsibilities should not silently share canonical ownership.

---

# Emerging Durable Intelligence Model

The current research model is:

```text
                    MCU DURABLE INTELLIGENCE

PROJECT TRUTH                    CROSS-PROJECT KNOWLEDGE
repository                       filesystem workspace
    |                                   |
    +---- architecture                  +---- notes
    +---- decisions                     +---- properties
    +---- research                      +---- relationships
    +---- current state                 +---- curated Insights
    +---- checkpoints                   +---- Knowledge projections
    +---- implementation                +---- project references
    |                                   |
    +----------------+------------------+
                     |
                     v
                Worker Context
                     ^
                     |
              Machine Learning
                 Hindsight


Human Interface
      |
      v
   Obsidian
```

This is a research model.

It is not accepted architecture.

---

# Project State, Insight, and Knowledge

The current research suggests at least four distinct kinds of durable
information.

## Project State

Answers:

```text
What is currently true about this project?
```

Examples:

- current branch
- completed phase
- active architecture
- unresolved blocker
- next action

## Checkpoint

Answers:

```text
What changed during a meaningful work segment?
```

A checkpoint is historical continuity material.

## Insight

Answers:

```text
What durable understanding was derived from Evidence?
```

Insight is already defined by ADR-0020.

## Knowledge

Answers:

```text
How should work be performed?
```

Knowledge Packages own institutional methodology.

These categories should not automatically share lifecycle or governance.

---

# Example Promotion Path

A project checkpoint may contain:

```text
Foxhole functional QC integration complete.
```

That statement is likely project-local.

Project experience may support an Insight such as:

```text
External QC ownership should not silently absorb specialized accessibility
responsibilities.
```

That Insight may later support institutional Knowledge such as:

```text
Accessibility ownership must be explicitly assigned in QA planning.
```

The exact promotion mechanism is not yet defined.

This example demonstrates why checkpoint architecture should not be finalized
before the durable-intelligence boundaries are understood.

---

# Current Open Question

The strongest unresolved question is now:

> What moves from a project repository into the cross-project knowledge
> workspace, who decides, and under what lifecycle and governance?

This question connects:

- project continuity
- checkpoints
- Insight
- Knowledge
- human curation
- machine learning
- cross-project discovery

Resolving this boundary should precede implementation of automatic
checkpointing or a second-brain connector.

---

# Concepts Not Yet Adopted

The research does not currently establish:

- Obsidian as a required MCU dependency
- Obsidian as canonical knowledge storage
- Obsidian Sync as required infrastructure
- Hindsight as the canonical learning provider
- a checkpoint schema
- a Current State schema
- a knowledge-workspace schema
- automatic project-to-vault synchronization
- automatic Insight promotion
- automatic Knowledge promotion
- a universal note identity format

These remain design questions.

---

# Current Conclusion

Obsidian survives the initial architectural evaluation well because its durable
material is filesystem-backed, inspectable, and usable independently from the
application.

The research currently favors:

```text
Project Repository
    authoritative project-local truth

Filesystem Knowledge Workspace
    explicit durable cross-project material

Obsidian
    replaceable human-facing interface

Hindsight
    replaceable machine-learning / retention provider
```

This model is promising but not yet accepted.

The next research question is the promotion and synchronization boundary
between project-local state and cross-project durable knowledge.

Checkpoint architecture remains intentionally deferred until that boundary is
better understood.
