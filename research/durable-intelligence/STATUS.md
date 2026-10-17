# Durable Intelligence Architecture Research Status

## Status

Research synthesis: complete.

Continuity requirement: confirmed.

Obsidian first-party architecture study: complete.

MCU adversarial reconciliation: complete.

Candidate Project Continuity contract: human-reviewed and accepted as the
basis for architecture.

Architectural decision: promoted to ADR-0021 — Project Continuity.

Implementation: not started.

Obsidian: not yet installed as part of this work.

Hindsight: not selected as provider.

## Original Question

> How should project-local truth, cross-project durable knowledge,
> machine-derived learning, and human-facing knowledge surfaces relate without
> creating competing canonical stores?

## Decision Outcome

Most candidate concepts were absorbed by existing MCU architecture.

One missing responsibility survived reconciliation:

```text
Project Continuity
```

ADR-0021 establishes Project Continuity as the durable project-specific state
required for safe resumption across Executions, Runtime Sessions, Runtime
providers, and Workers.

## Responsibility Model

```text
Execution State
    transient execution composition

Runtime Session
    optional provider-specific continuity

Project Continuity
    durable provider-independent project resumability
```

## Canonical Artifact

Project Continuity produces one Domain Artifact per Project:

```text
Continuity Record
```

The Continuity Record contains:

```text
Current State
Checkpoint History
```

These are complementary views of one responsibility.

They are not independent constitutional artifacts.

## Current State

Current State answers:

```text
What does a future Worker need to know now to resume safely?
```

It is stored as part of the Continuity Record.

It remains subordinate to authoritative artifacts owned elsewhere.

## Checkpoint

Checkpoint answers:

```text
What materially changed during a meaningful work segment?
```

Checkpoints preserve semantic continuity transitions.

They are not transcripts or generic conversation summaries.

## Automatic Checkpointing

ADR-0021 recognizes semantic checkpoint trigger categories including:

- material decisions
- completed research/design reconciliation
- completed implementation phases
- validation gates
- durable project-state transitions
- Worker handoff
- Runtime transition
- blocked work
- approval boundaries
- context pressure
- graceful termination

Exact trigger policy remains implementation-specific.

## Manual Checkpointing

Explicit checkpoint creation is required.

Humans and Workers must be able to request preservation of the current
semantic continuation state.

The interaction syntax remains implementation-specific.

## Freshness

Continuity must be capable of detecting when authoritative Project state has
advanced beyond the Current State it describes.

For repository-backed Projects, the minimum model should support:

```text
repository identity
branch/ref
commit identity
dirty-state indication
```

The exact representation remains implementation-specific.

## Worker Independence

A different Worker must be able to resume from the Continuity Record without
requiring the previous Worker.

## Runtime Independence

Project Continuity does not depend on Runtime-native Session continuity.

Provider-native Session identifiers may exist only as optional hints.

## Repository Locality

For repository-backed Projects, the canonical Continuity Record should live
with the Project repository.

External systems may index, reference, synchronize, or project it.

They cannot be the only location required for continuation.

## Knowledge Workspace Status

Knowledge Workspace is not an MCU primitive.

A filesystem-backed workspace may provide:

- storage
- indexing
- references
- projections
- navigation
- human-authored notes

without becoming canonical semantic ownership.

## Obsidian Status

Current interpretation remains:

```text
filesystem knowledge workspace
        |
        v
Obsidian
human-facing interface
```

Obsidian remains optional and replaceable.

With the Project Continuity boundary now defined, Obsidian may be installed and
evaluated without allowing it to own Project Continuity.

## Hindsight Status

Hindsight remains a possible learning provider.

It does not own Project Continuity.

No Project may require Hindsight state merely to resume work.

## Cross-Project Boundary

Authoritative project artifacts generally remain with their owners.

Cross-boundary behavior should prefer:

```text
reference
projection
derivation
governed Knowledge change
```

over uncontrolled duplication.

## Promotion Status

Insight-to-Knowledge promotion is already established by ADR-0020.

Its operational workflow remains future design work.

No Promotion capability is required.

## Second Brain Status

`Second Brain` is not an MCU architectural concept.

It remains useful only as a human metaphor for the combined experience of:

- Project Continuity
- Insight
- Knowledge
- references
- projections
- retrieval
- human interfaces
- machine-learning providers

## Security Boundary

Continuity must exclude secret values and unnecessary sensitive execution
material.

Runtime credentials and secret values must remain under appropriate
secret-management responsibilities.

## Reasoning Privacy

Project Continuity does not require persistence of hidden model reasoning or
private chain-of-thought.

It preserves durable project state and project-appropriate rationale.

## Research Artifacts

The research chain is preserved in:

```text
research/durable-intelligence/README.md
research/durable-intelligence/RECONCILIATION.md
research/durable-intelligence/CONTINUITY_CONTRACT.md
research/durable-intelligence/STATUS.md
```

ADR-0021 remains the authoritative architectural decision.

## Future Implementation Work

Future Project Continuity implementation must still define:

- Continuity Record schema
- repository path/layout
- initialization
- Current State representation
- Checkpoint representation
- checkpoint sequence/identity
- automatic trigger policy
- manual checkpoint interface
- semantic-delta generation
- deduplication
- freshness reconciliation
- dirty working-tree representation
- reference representation
- bounded history retrieval
- security filtering
- terminal Project lifecycle
- tests and acceptance fixtures

These are implementation concerns.

They do not require reopening the responsibility decision.

## Next Action

Close and commit the Durable Intelligence research and ADR-0021.

After that, install and configure Obsidian as an experimental human-facing
interface over a filesystem-backed knowledge workspace.

Obsidian must remain optional and must not own Project Continuity.

Do not implement Project Continuity as part of the Obsidian installation.

Do not select Hindsight as part of the Obsidian installation.
