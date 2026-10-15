# Agent Runtime Research Status

## Status

Active research.

Comparative framework study: complete.

MCU architecture reconciliation: complete.

No production implementation has been approved.

No external framework has been selected as an MCU dependency.

No new program ADR has yet been justified.

## Completed Comparative Study

### OpenRig

Status: reviewed

Primary contribution:

- control-plane/runtime separation
- runtime adapters
- context projection
- honest resume semantics
- durable workflows
- event history
- evidence-backed lifecycle transitions

### Paperclip

Status: reviewed

Primary contribution:

- persistent Agent versus bounded Run
- runtime adapters
- trigger-driven execution
- durable Work ownership
- Goal / Project / Work distinction
- explicit approvals
- organizational model as a higher-level concern

### OpenDots

Status: reviewed

Primary contribution:

- Workspace as durable resource boundary
- Execution Environment distinct from Runtime
- persistent identity without required organizational hierarchy
- scheduled bounded execution
- active permission revocation
- human review against specific effects
- separation of conversation, preference, learning, knowledge, and skill

## MCU Reconciliation

The initial candidate model has been reconciled against existing MCU
architecture.

### Already owned by MCU

- Goal and strategic intent
- Initiative
- Project
- Task
- Incident
- Worker
- Domain Artifact
- Evidence
- Knowledge Packages
- Governance
- Review and approval
- Execution State composition

These concepts should use existing MCU terminology.

### Remaining execution-layer questions

The current unresolved concepts are:

```text
Execution
Session
Runtime Contract
Execution Environment
Trigger
Event
Workspace
```

These are research questions.

They are not yet accepted MCU primitives.

## Key Reconciliation Findings

### No competing control plane

ADR-0014 already establishes that orchestration composes Execution State.

Current research does not justify introducing a competing Agent Control Plane.

### Worker remains the program-level term

External `Agent` terminology maps to MCU Worker.

Worker remains implementation-independent.

### Work model remains unchanged

The external Goal / Project / Work model does not replace MCU's existing:

```text
Initiative
Project
Task
Incident
```

### Knowledge architecture remains authoritative

ADR-0018 already defines Knowledge Packages.

Learning research must reconcile with that architecture.

### Evidence boundary remains authoritative

ADR-0019 already decouples engineering reasoning from Runtime providers.

Future learning and execution systems must preserve that boundary where
applicable.

### Separate repositories remain appropriate

MCU, Workstation, Engineering Lab, Image Lab, and future capability
repositories remain separate.

The identified risk is distributed program-level architectural truth, not
repository separation itself.

MCU should own program architecture.

Capability repositories should own implementation architecture.

## Next Research Spike

### Hindsight

Repository:

```text
vectorize-io/hindsight
```

Research question:

> How can learned experience influence future Worker execution without
> violating MCU's existing Knowledge Package, Evidence, Domain Artifact,
> governance, and orchestration boundaries?

### Required distinctions

The study must distinguish:

```text
Session continuity
Preference
Knowledge
Learning
Skill
```

### Additional questions

Investigate:

- how experience is retained
- how information is represented
- how recall works
- whether reflection creates new durable state
- how contradictions are handled
- how temporal relevance is represented
- how scope and identity are modeled
- how learned information is deleted or superseded
- how provenance is preserved
- whether learned information can be reviewed before influencing future work

### Constraint

Do not integrate Hindsight.

Do not implement an MCU memory subsystem.

Do not modify Knowledge Package architecture.

Extract the problem domain first.

## Next Action

Begin the Hindsight research spike.

Use the established MCU research workflow:

```text
small inspection
    -> terminal

large inspection
    -> /tmp research packet
    -> upload
    -> analysis

durable research conclusion
    -> repository research artifact

accepted architecture
    -> ADR

implementation
    -> only after architecture earns it
```
