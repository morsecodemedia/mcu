# Content Ingestion Architecture Research — MCU Reconciliation

## Purpose

The MinerU research identified a possible cross-cutting responsibility called
`Source Correspondence`.

The working definition was:

> A stable relationship between derived material and the specific region of
> source material from which it originated.

This document tests that candidate against existing MCU architecture,
primarily:

- ADR-0013 — Capability Artifact Composition
- ADR-0014 — Orchestrators Compose Execution State
- ADR-0019 — Evidence
- ADR-0020 — Insight

The objective is adversarial.

A new architectural responsibility should be introduced only when existing
architecture cannot represent the responsibility honestly without weakening an
established boundary.

This is a research synthesis.

It is not an Architectural Decision Record.

---

# Reconciliation Result

## Verdict

Source Correspondence does not justify a new MCU primitive, capability, Domain
Artifact type, or program ADR.

The underlying ownership chain already exists.

MCU currently establishes:

```text
Domain Artifact
    canonical structured capability output

Evidence
    reasoning material

Insight
    durable derived understanding with provenance to Evidence
```

Source Correspondence fits within that chain as provenance relating derived
material to addressable regions of source material.

The architectural gap is therefore not missing ownership.

The gap is underspecified portable provenance semantics.

This is a contract-design concern rather than a new constitutional
responsibility.

---

# Domain Artifact Reconciliation

ADR-0013 establishes that a Domain Artifact is the canonical structured output
produced by a capability.

Each Domain Artifact has exactly one owner.

This is sufficient to represent capability-specific interpretations of source
material.

For example:

```text
Document Parsing Capability
          |
          v
     Domain Artifact
          |
          +---- pages
          +---- blocks
          +---- tables
          +---- media
          +---- bounding regions
          +---- parse provenance
          +---- projections
```

MCU does not need to understand the internal schema of that artifact at program
scope.

## Result

The following candidate primitives are rejected:

```text
Document
Document Representation
Content Representation
Parsed Content
```

Their responsibilities are already representable through capability-owned
Domain Artifacts.

---

# Interpretation Remains Capability-Owned

MinerU demonstrates that source identity and interpretation are distinct.

The same source content may be interpreted:

- by different providers
- by different provider versions
- at different quality settings
- with different page ranges
- with different parsing strategies

Those interpretations remain capability concerns.

MCU does not require a universal parse model.

A capability may encode the interpretation conditions required to understand
its own Domain Artifact.

---

# Evidence Reconciliation

ADR-0019 establishes that Evidence exposes reasoning material.

A parsing capability producing a structured interpretation does not
automatically make that interpretation Evidence.

The responsibility chain remains:

```text
Source Artifact
      |
      v
Parsing / Interpretation Capability
      |
      v
Domain Artifact
      |
      v
Evidence Provider
      |
      v
Evidence
```

The Evidence Provider determines which material should be exposed under MCU
Evidence semantics.

## Source Correspondence in Evidence

When Evidence represents material derived from an addressable source region,
its provenance may preserve correspondence to that region.

Conceptually:

```text
Evidence
 |
 +---- reasoning material
 |
 +---- provenance
        |
        +---- producing provider
        +---- source artifact
        +---- source correspondence
```

Source Correspondence therefore does not need an independent artifact owner.

It is a provenance relationship.

---

# Insight Reconciliation

ADR-0020 requires Insight to remain traceable to supporting Evidence.

This means Insight does not need to understand source-specific location
semantics.

The provenance chain can remain layered:

```text
Insight
   |
   | provenance
   v
Evidence
   |
   | source correspondence
   v
Domain Artifact
   |
   v
Source Region
```

This preserves responsibility boundaries.

Insight owns provenance to Evidence.

Evidence provenance may preserve correspondence to its source.

The source capability owns the source-specific representation and resolution
semantics.

---

# Source Correspondence Is a Relationship

The most important reconciliation result is that Source Correspondence is not
another architectural object parallel to Evidence or Insight.

It is a relationship.

Conceptually:

```text
                 Domain Artifact
                       ^
                       |
              source correspondence
                       |
                    Evidence
                       ^
                       |
                   provenance
                       |
                    Insight
```

This avoids introducing a new lifecycle or persistence system merely to carry
source references.

---

# Source Identity

A source-region reference is meaningful only relative to source identity.

For example:

```text
page 14 / block 7
```

is insufficient without knowing which source and interpretation the locator
belongs to.

A future portable provenance contract should therefore be capable of
identifying the relevant source artifact or source version.

The exact identity mechanism remains capability-specific unless future
architecture establishes otherwise.

---

# Locator Semantics

MCU does not require one universal locator syntax.

Different source types have naturally different coordinate systems.

Examples include:

```text
Document
    page / block / bounding box

Image
    region / bounding box

Audio
    timestamp range

Video
    timestamp / frame / region

Source Code
    repository / file / symbol / line range

Spreadsheet
    workbook / sheet / cell range
```

The program-level semantic requirement is not:

```text
all sources use one locator syntax
```

It is:

> A source correspondence identifies a region using semantics understood by
> the capability responsible for that source representation.

---

# Resolution Ownership

MCU should not centralize knowledge of every source-specific locator.

The capability or provider responsible for the source representation should
own locator resolution.

Conceptually:

```text
portable provenance
      |
      +---- source identity
      +---- locator
      +---- locator type / semantics
      |
      v
source capability / provider
      |
      v
resolved source region
```

This preserves provider independence and avoids creating a program-level
resolver containing source-specific implementation logic.

---

# Stability

The term `stable locator` requires qualification.

MinerU demonstrates stability across presentation changes:

```text
canonical block
      |
      +---- Markdown
      +---- Structured Content
      +---- HTML
```

Changing presentation does not change canonical block identity.

That does not imply the same locator remains valid across:

- source revisions
- incompatible parser versions
- incompatible canonical schema changes
- unrelated interpretations

## Candidate Contract Requirement

A correspondence should define or imply the identity boundary within which its
locator is resolvable.

Conceptually:

```text
Source Correspondence
    |
    +---- source identity
    +---- interpretation identity when required
    +---- provider-defined locator
```

The architecture should not promise universal locator stability.

---

# Derivation Provenance and Source Correspondence

The research distinguishes two related but different concerns.

## Derivation Provenance

Answers:

```text
How was this artifact or Evidence produced?
```

Potential information includes:

- provider
- provider version
- quality mode
- derivation time
- transformation path

## Source Correspondence

Answers:

```text
Where in the source did this material originate?
```

Potential information includes:

- source identity
- source version
- locator
- region
- resolution semantics

Neither concern should silently substitute for the other.

---

# Quality Reconciliation

MinerU demonstrates that parsing quality can materially affect interpretation.

Quality therefore belongs to derivation provenance when it affects the meaning
or reliability of an artifact.

Quality does not inherently belong to the source locator.

Conceptually:

```text
Source Correspondence
    source X
    region Y

Derivation Provenance
    provider Z
    version V
    quality Q
```

A provider may combine these internally.

MCU should preserve the semantic distinction.

---

# Presentation Boundary

MinerU strongly validates an existing MCU-friendly pattern:

```text
canonical Domain Artifact
        |
        +---- projection A
        +---- projection B
        +---- projection C
```

Presentation should not become canonical state merely because it is convenient
for humans or Workers.

A source correspondence should therefore bind to source or canonical
capability structure rather than to transient presentation whenever the
capability can provide that guarantee.

---

# Serialization Is Not Semantics

MinerU explicitly distinguishes semantic output names from serialization
formats.

The research preserves the general principle:

> Serialization format does not define artifact responsibility.

For example:

```text
JSON
```

describes encoding.

It does not establish whether the payload is:

- Evidence
- Insight
- a Domain Artifact
- a projection
- configuration
- an event
- or another semantic object

MCU contracts should continue to use responsibility-oriented terminology.

---

# Projection Fidelity

A projection may intentionally simplify canonical capability state.

That is acceptable.

Silent semantic loss is not.

If a projection cannot represent material present in canonical state, the
projection contract should make that limitation observable when the omission
matters to consumers.

Potential mechanisms include:

- validation issues
- fidelity warnings
- unsupported-type markers
- explicit omission metadata

The exact mechanism remains capability-specific.

---

# Progressive Access

MinerU demonstrates that large durable artifacts can support bounded access
without requiring their complete contents to enter Execution State.

Potential provider operations include:

```text
read(locator)

read(range)

search(query)

continue(cursor)
```

These examples do not define an MCU API.

The durable architectural lesson is:

> Large artifacts should be consumable in bounded portions when full
> materialization would be unnecessary or harmful.

This is useful design guidance but does not currently justify a new program
primitive.

---

# Stateless Continuation

MinerU deliberately avoids provider-owned reader sessions for progressive
content access.

Instead, continuation state is expressed through explicit request parameters.

This validates a useful design preference:

> Avoid hidden provider state when continuation can be represented explicitly.

This is not an absolute MCU invariant.

Some future providers may legitimately require session state.

The finding should therefore remain guidance rather than constitutional
architecture.

---

# Normalization

MinerU separates provider-native structures from normalized consumer
representations.

The research supports the pattern:

```text
provider-native representation
        |
        v
normalization
        |
        v
consumer representation
```

Normalization may simplify provider-specific complexity.

It should not silently erase semantics it cannot represent.

---

# Error Ownership

MinerU assigns failures according to the responsibility that failed rather than
the process that happened to raise an exception.

Examples include:

```text
source-location failure

content-identity failure

interpretation failure
```

This aligns with MCU's responsibility-oriented architecture.

No new decision is required.

---

# Rejected Program-Level Concepts

The reconciliation rejects the following as new MCU program primitives:

- Document
- Document Representation
- Content Representation
- Parsed Content
- Ingestion
- Source Correspondence
- universal locator
- universal document schema
- universal parsing tier
- universal progressive-reading protocol

These may exist within capability implementations where appropriate.

---

# Accepted Research Findings

The following findings survive reconciliation as architectural guidance.

## Source identity and interpretation remain distinct

A source and an interpretation of that source are not necessarily the same
artifact.

## Presentation is not canonical state

Consumer-friendly and human-readable views may be projections over canonical
Domain Artifacts.

## Serialization is not semantics

Encoding does not define responsibility.

## Relevant derivation conditions remain available

Conditions that materially affect interpretation should remain available as
provenance.

## Source correspondence is presentation-independent where possible

Source references should bind to source or canonical structure rather than a
transient renderer when the capability can provide that guarantee.

## Large artifacts benefit from bounded consumption

Execution should not require unnecessary full-artifact materialization.

## Explicit continuation is preferable to unnecessary hidden state

Stateless continuation is useful when the problem permits it.

## Normalization should expose material fidelity loss

Unrepresentable semantics should not silently disappear.

---

# Future Evidence Contract Requirement

The study identifies one concrete requirement for future structured Evidence
design.

When MCU defines a portable structured Evidence contract, its provenance model
should support:

> Provider-defined, source-identity-relative correspondence to addressable
> source regions.

The contract should be capable of expressing, where applicable:

- source identity
- source version or interpretation identity
- provider-defined locator
- locator semantics
- resolver ownership
- derivation provenance

This does not require every Evidence item to have source correspondence.

Some Evidence may:

- be generated directly
- represent aggregate information
- come from a source without meaningful region semantics
- be asserted by a human
- be produced by computation rather than extraction

Source correspondence is therefore conditional provenance.

---

# Why No ADR Is Required

A new ADR is justified when research reveals a responsibility that existing
architecture cannot own without weakening established boundaries.

That did not occur here.

Domain Artifact already owns canonical capability output.

Evidence already owns reasoning material.

Insight already owns provenance to supporting Evidence.

Source Correspondence fits within Evidence provenance and capability-owned
source semantics.

The missing work is future contract design, not responsibility assignment.

Therefore:

```text
New primitive:       no
New capability:      no
New Domain Artifact: no
New ADR:             no

Future contract work:
    structured Evidence provenance
```

---

# MinerU Status

MinerU remains:

- a completed research source
- a possible future implementation/provider
- unselected
- unintegrated

No MinerU dependency is introduced by this research.

---

# Current Conclusion

MinerU provided strong evidence for separating:

```text
source
interpretation
canonical representation
projection
Evidence
```

It also demonstrated the value of stable source-region correspondence,
derivation provenance, bounded consumption, and stateless continuation.

Existing MCU architecture absorbs these responsibilities without introducing a
new program-level primitive.

The candidate `Source Correspondence` responsibility is therefore rejected as
an independent architectural concept.

Its useful semantics survive as a future Evidence provenance requirement.

The content-ingestion research is complete.
