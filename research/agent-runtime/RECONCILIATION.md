# Agent Runtime Research — MCU Architecture Reconciliation

## Purpose

The initial Agent Runtime research compared OpenRig, Paperclip, and OpenDots
without assuming that their terminology should become MCU terminology.

That study identified candidate primitives and architectural invariants that
appeared across independently designed persistent-agent systems.

This document reconciles those findings against MCU's existing architecture.

The objective is to determine:

1. which responsibilities MCU already owns
2. which external concepts map to existing MCU concepts
3. which external concepts should be rejected
4. which execution-layer distinctions remain genuinely unresolved
5. whether the existing repository boundaries remain appropriate

This is a research synthesis.

It is not an Architectural Decision Record.

---

## Executive Finding

The comparative research does not justify replacing MCU's existing
architecture with a new Agent Runtime architecture.

Instead, the research independently validates several existing MCU decisions
and exposes a narrower architectural gap:

> MCU already defines the organization, work model, capability model,
> artifact model, knowledge model, evidence model, governance model, and
> orchestration ownership required to support persistent AI workers.

What remains underdefined is the execution layer beneath Worker:

```text
Worker
   |
   | performs work through
   v
Execution
   |
   +---- Runtime
   |
   +---- Session / continuity
   |
   +---- Execution Environment
```

Additional questions remain around:

- execution triggers
- event history
- workspace semantics
- runtime contracts
- continuity
- active authorization

The research therefore narrows the problem rather than expanding MCU's
ontology.

---

# Existing MCU Architecture

## Responsibilities Outlive Implementations

ADR-0007 establishes that MCU architecture is defined according to durable
responsibilities rather than current implementation technologies.

Repositories, disciplines, capabilities, and workers are defined by what they
own.

Frameworks, models, runtimes, languages, and tools remain replaceable
implementation details.

This strongly aligns with the comparative research.

OpenRig, Paperclip, and OpenDots each support multiple execution mechanisms
while preserving higher-level identities and responsibilities.

The external research therefore reinforces the existing MCU rule:

> Responsibility must be established before implementation.

This means MCU should not define architectural concepts named after Claude,
Codex, OpenRig, Paperclip, OpenDots, or any other current implementation.

---

## Orchestration Already Owns Execution Composition

ADR-0014 establishes that orchestrators compose Execution State.

Capabilities do not.

Each capability produces and owns its Domain Artifact.

Orchestration composes those immutable artifacts into transient Execution
State for downstream consumption.

This resolves an important question raised by the external research.

The comparative study initially described a generic "control plane" that owns
authoritative execution state.

Within MCU, that responsibility already has an owner:

> Orchestration owns execution composition.

A new competing Agent Control Plane should therefore not be introduced without
evidence that orchestration cannot satisfy the responsibility.

Current research provides no such evidence.

---

## MCU Already Owns the Work Model

The external research proposed distinctions between Goal, Project, and Work.

MCU already has a richer work taxonomy:

- Initiative
- Project
- Task
- Incident

These work types have explicit ownership, scope, review, and escalation paths.

Therefore the external Goal / Project / Work model should not replace MCU's
existing workflow terminology.

Where useful, external concepts should map into MCU work types rather than
introducing parallel concepts.

---

## MCU Already Owns the Worker Concept

External frameworks commonly use the term Agent.

MCU already defines Worker as the entity that performs work.

Governance establishes:

```text
High Council coordinates.
Disciplines advise.
Capabilities execute.
Workers perform work.
CEO decides.
```

Worker is broader and more durable than Agent.

A Worker may be:

- human
- AI-backed
- deterministic software
- another future implementation capable of performing delegated work

Therefore MCU should prefer Worker over Agent at program scope.

"Agent" may remain an implementation term inside a capability or Runtime
provider when appropriate.

---

## MCU Already Owns Artifact Semantics

ADR-0014 defines Domain Artifacts as canonical structured outputs produced by
capabilities.

Each Domain Artifact has exactly one owner.

ADR-0015 establishes a common lifecycle for managed artifacts:

```text
Metadata
   |
   v
Installation
   |
   v
Registration
   |
   v
Runtime Discovery
   |
   v
Capability Consumption
```

The Artifact primitive proposed during external research is therefore already
owned by MCU.

No new generic Artifact abstraction is required by the current research.

---

## MCU Already Owns Knowledge

ADR-0018 defines Knowledge Packages as version-controlled artifacts describing
how engineering work should be performed.

Knowledge Packages remain independent from execution implementations.

Knowledge therefore already has an architectural home in MCU.

The external research must not introduce a generic memory or knowledge system
that bypasses this ownership model.

Any future learning system must reconcile with Knowledge Packages rather than
silently replacing them.

---

## MCU Already Owns Evidence

ADR-0019 establishes Evidence as the implementation-independent material used
for engineering reasoning.

The existing separation is:

```text
Runtime
   |
   v
discovers facts
   |
   v
Evidence
   |
   +---- Knowledge Packages define methodology
   |
   +---- Composers combine knowledge and evidence
   |
   +---- Inference performs reasoning
```

Engineering tasks consume Evidence rather than Runtime providers.

This already implements a major provider-independence principle discovered in
the external research.

Runtime output should therefore not become an uncontrolled reasoning input.

It must cross the appropriate evidence boundary.

---

# Terminology Reconciliation

## Concepts Already Owned by MCU

| Research Concept | MCU Concept | Disposition |
| --- | --- | --- |
| Goal | Existing vision, goal, initiative, and governance model | Reuse MCU |
| Project | Project work type | Reuse MCU |
| Work | Initiative / Project / Task / Incident | Reuse MCU |
| Agent | Worker | Use Worker |
| Artifact | Domain Artifact | Reuse MCU |
| Evidence | Evidence | Reuse MCU |
| Knowledge | Knowledge Package architecture | Reuse MCU |
| Approval | Review and approval governance | Reuse MCU; refine semantics if needed |
| Context composition | Execution State plus knowledge/evidence composition | Reuse and refine MCU |

These concepts should not be reintroduced under framework-derived names.

---

## Concepts Rejected as Kernel Primitives

The comparative study encountered many useful product-specific concepts.

They remain rejected as MCU kernel primitives:

- Rig
- Pod
- Seat
- Node
- Company
- Employee
- CEO-as-agent
- Manager-as-agent
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

Some may be useful implementation or orchestration concepts in the future.

Their existence in external frameworks is not sufficient reason to make them
constitutional MCU concepts.

---

# Remaining Execution-Layer Questions

After reconciliation, most candidate primitives collapse into existing MCU
architecture.

The following concepts remain unresolved.

## Execution

MCU defines Execution State but does not yet appear to define the bounded
occurrence of a Worker performing delegated work.

The external research consistently distinguishes durable Worker identity from
individual execution occurrences.

A candidate distinction is:

```text
Worker
   |
   +---- Execution A
   |
   +---- Execution B
   |
   +---- Execution C
```

Whether `Execution` is the correct MCU term remains open.

The term `Run` should not be imported merely because external frameworks use
it.

---

## Session

Some Runtime providers support continuity across multiple bounded executions.

Examples include persistent conversation or native runtime session IDs.

A Session may therefore be distinct from both Worker and Execution:

```text
Worker
   |
   +---- Execution 1 ----+
   |                     |
   +---- Execution 2 ----+---- Session A
   |                     |
   +---- Execution 3 ----+
```

Not every Runtime must support Session continuity.

MCU must determine whether Session is:

- a program-level primitive
- Runtime-owned opaque state
- or merely an implementation detail

No decision has been made.

---

## Runtime Contract

Runtime already exists in Engineering Lab architecture as the responsibility
that discovers engineering facts.

The external research suggests a broader execution concern:

> How does a Worker actually execute delegated work through a replaceable
> implementation?

MCU must determine whether the existing Runtime concept already owns this
responsibility or whether multiple runtime responsibilities are currently
sharing one name.

Potential concerns include:

- execution
- readiness
- cancellation
- continuity
- fact discovery
- usage accounting
- health
- capability discovery

This requires clarification before introducing a program-level Runtime
contract.

---

## Execution Environment

OpenDots demonstrated a useful distinction between the runtime performing
reasoning and the environment in which effects occur.

Examples of execution environments may include:

- local workstation
- isolated container
- remote VM
- cloud sandbox
- browser computer
- repository workspace

A Runtime and an Execution Environment may vary independently.

Whether MCU needs a first-class Execution Environment abstraction remains
unresolved.

---

## Wakeup / Trigger

Paperclip and OpenDots demonstrate that persistent workers do not require
persistent processes.

Execution may begin because of:

- assignment
- schedule
- human request
- approval resolution
- automation
- external event

MCU must determine whether the triggering reason deserves a durable
program-level concept or belongs entirely to orchestration.

The framework-derived term `Wakeup` is not currently adopted.

---

## Event

OpenRig, Paperclip, and OpenDots maintain durable histories of execution and
state transitions.

MCU already has Evidence and Domain Artifacts, but neither is necessarily the
same thing as an immutable factual event.

Potential uses include:

- audit
- debugging
- lifecycle reconstruction
- metrics
- recovery
- learning

Further evidence is required before Event becomes a program-level primitive.

---

## Workspace

All three external systems contain a durable resource boundary associated with
work.

MCU already has repositories, capabilities, projects, and Execution State.

It remains unclear whether Workspace represents a genuinely missing
responsibility or whether existing concepts already provide the necessary
boundary.

Workspace must therefore be clarified rather than immediately introduced.

---

# Human Review and Approval

MCU already has explicit review and approval paths.

The external research contributes one potentially useful refinement:

> Approval should bind to a specific proposed effect or artifact revision.

If the target changes, previous approval should not silently authorize the new
target.

This refinement should be evaluated against existing Review Gate and Evidence
architecture before becoming a new decision.

No new Approval subsystem is currently justified.

---

# Active Authorization

OpenDots demonstrated that permission changes can invalidate an execution that
is already running.

This suggests a potential execution invariant:

> Authorization relevant to active execution may need to remain observable
> throughout the execution lifecycle.

MCU has not yet decided whether this belongs to:

- orchestration
- Runtime
- Execution Environment
- governance
- or another responsibility

The finding is preserved for later execution-layer design.

---

# Repository Boundary Reconciliation

## Finding

The existence of separate repositories for MCU, Workstation, Engineering Lab,
Image Lab, and future Labs is not currently an architectural defect.

Existing MCU decisions explicitly support independent capability repositories
and lifecycles.

The more important distinction is between:

```text
Program architecture
```

and:

```text
Capability implementation architecture
```

---

## Program Scope

The MCU repository should own durable ecosystem-wide truth such as:

- constitution
- vision
- organizational vocabulary
- governance
- work taxonomy
- cross-capability contracts
- program ADRs
- capability lifecycle rules
- shared artifact semantics
- orchestration semantics
- cross-cutting research

---

## Capability Scope

Individual capability repositories should own:

- implementation
- capability-local architecture
- capability-local ADRs
- tests
- release lifecycle
- provider implementations
- capability-specific knowledge where constitutionally appropriate

---

## Federation Rather Than Consolidation

The current research does not justify moving all Labs into a monorepo.

The preferred direction is federated ownership:

```text
MCU
 |
 +---- program semantics
 +---- contracts
 +---- governance
 +---- registry
 +---- cross-cutting research
 |
 +---- Workstation repository
 |
 +---- Engineering Lab repository
 |
 +---- Image Lab repository
 |
 +---- future capability repositories
```

The architectural risk is not repository separation.

The architectural risk is allowing program-level truth to become discoverable
only by reading multiple implementation repositories.

MCU should remain the authoritative location for program-level architecture.

Capability repositories should remain authoritative for their implementations.

---

# Impact on Hindsight Research

The next Hindsight study must respect existing MCU architecture.

The research question is therefore refined.

It is no longer:

> How should MCU implement memory?

Instead:

> How can learned experience influence future Worker execution without
> violating MCU's existing Knowledge Package, Evidence, Domain Artifact,
> governance, and orchestration boundaries?

The study must distinguish:

- Session continuity
- Preference
- Knowledge
- Learning
- Skill

It should also investigate:

- provenance of learned material
- review requirements
- confidence
- contradiction
- supersession
- temporal relevance
- scope
- deletion
- promotion into durable Knowledge

Hindsight should be treated as an evidence source and reference architecture,
not as the owner of MCU's knowledge model.

---

# Current Conclusion

The external research has not revealed a missing top-level Agent Runtime
architecture.

It has revealed a narrower execution-layer gap beneath Worker.

The existing MCU architecture already owns most of the surrounding concerns.

Current work should therefore continue as research.

No new program ADR is yet justified.

The next evidence source is Hindsight.
