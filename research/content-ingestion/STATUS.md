# Content Ingestion Architecture Research Status

## Status

Research synthesis: complete.

MinerU architecture study: complete.

MCU reconciliation: complete.

Architectural gap: not found.

New ADR: not justified.

Implementation: not started.

Provider selection: not started.

## Research Question

The original question was:

> What responsibilities are required to transform heterogeneous source
> material into trustworthy, provenance-preserving material suitable for MCU
> Evidence, and which responsibilities belong to MCU versus a replaceable
> ingestion provider?

The narrowed reconciliation question was:

> Does MCU need a program-level Source Correspondence contract, or can Domain
> Artifact and Evidence provenance already represent stable source-region
> references without another architectural responsibility?

## Decision Outcome

Existing MCU architecture is sufficient.

### Domain Artifact owns

```text
canonical capability output
```

### Evidence owns

```text
reasoning material
```

### Insight owns

```text
durable derived understanding
with provenance to Evidence
```

### Source Correspondence

```text
provenance relationship between
derived material and addressable source region
```

Source Correspondence does not require an independent architectural owner.

## Reconciliation Verdict

```text
Document primitive:               rejected

Document Representation:          rejected

Content Representation:           rejected

Generic Ingestion primitive:      rejected

Source Correspondence primitive:  rejected

Universal locator:                rejected

New ADR:                          not justified
```

## Surviving Requirement

Future structured Evidence design should support:

> Provider-defined, source-identity-relative correspondence to addressable
> source regions.

This is conditional provenance.

It is not required for all Evidence.

## Responsibility Model

```text
Source Artifact
      |
      v
Capability
      |
      v
Domain Artifact
      |
      | source correspondence
      v
Evidence
      |
      | provenance
      v
Insight
```

The source capability owns source-specific representation and locator
resolution.

Evidence may preserve source correspondence.

Insight remains traceable to Evidence.

## Surviving Architectural Guidance

### Source identity and interpretation remain distinct

One source may have multiple interpretations.

### Presentation is not canonical state

Markdown, HTML, and other consumer views may remain projections.

### Serialization is not semantics

JSON or another encoding does not define artifact responsibility.

### Derivation provenance matters

Provider, version, quality, or other derivation conditions should remain
available when they materially affect interpretation.

### Source correspondence is presentation-independent where possible

References should bind to source or canonical capability structure rather than
transient render output when possible.

### Large artifacts benefit from bounded consumption

Consumers should not need to materialize an entire artifact into Execution
State merely to inspect a relevant portion.

### Explicit continuation is preferable to unnecessary hidden state

Stateless continuation is useful when provider-owned reader sessions are not
required.

### Normalization should expose fidelity loss

Material semantics that cannot be represented should not silently disappear.

## Source Correspondence Status

`Source Correspondence` is retired as a candidate MCU primitive.

The term remains useful descriptively for the provenance relationship:

```text
derived material
      |
      v
source region
```

No dedicated artifact, lifecycle, capability, or ADR is required.

## Locator Status

MCU does not define a universal locator syntax.

Source capabilities may use appropriate semantics such as:

```text
document
    page / block / bbox

image
    region

audio
    time range

video
    time / frame / region

source code
    file / symbol / line range

spreadsheet
    sheet / cell range
```

Portable provenance may identify the locator semantics and responsible
resolver without standardizing the coordinate system.

## Quality Status

Quality belongs to derivation provenance when it materially affects
interpretation.

Quality does not inherently belong to source correspondence.

Provider-specific quality models remain implementation details.

## Progressive Access Status

Bounded access and stateless continuation remain useful provider design
patterns.

They are not currently program-level MCU primitives or invariants.

## MinerU Status

MinerU is:

- studied
- unselected
- unintegrated
- not an MCU dependency

Its concepts remain behind any future provider boundary.

## Concepts Not Adopted

The following MinerU concepts remain provider-specific:

```text
Middle JSON
Structured Content
Content List
ParseResult
Doclib
parsing tiers
block reference syntax
short document IDs
MinerU cursor syntax
```

## Research Artifacts

The research chain is preserved in:

```text
research/content-ingestion/README.md
research/content-ingestion/RECONCILIATION.md
research/content-ingestion/STATUS.md
```

These documents preserve the findings and reconciliation.

No ADR promotion occurred because existing architecture absorbed the candidate
responsibility.

## Future Work

Future Evidence contract design should revisit:

- structured Evidence schema
- provenance representation
- source identity
- source versioning
- source correspondence
- provider-defined locator semantics
- resolver ownership
- derivation provenance
- fidelity metadata

Future content-provider design may revisit:

- bounded reads
- search
- progressive continuation
- projection fidelity
- normalization validation

These are future contract and implementation concerns.

They do not require reopening the current responsibility decision.

## Next Action

Close the content-ingestion research work.

Validate and commit the research artifacts.

Do not create ADR-0021 for Source Correspondence.

Do not modify ADR-0019 as part of this research.

Do not integrate MinerU.

Future structured Evidence design should use this research as input when its
contract is defined.
