# Content Ingestion Architecture Research

## Purpose

This research investigates how heterogeneous source material can become
trustworthy, navigable input to MCU Evidence without coupling MCU to a
particular parser, source format, rendering format, or document system.

The first reference architecture studied is MinerU.

MinerU was selected because it explicitly separates:

- source file identity
- content identity
- parse attempts
- canonical parse representation
- consumer-oriented structured representation
- human-readable rendering
- stable source locators
- progressive reading
- parsing quality
- parsing implementation

The objective is not to integrate MinerU.

The objective is to determine which responsibilities, if any, MCU requires
between arbitrary source artifacts and Evidence.

---

## Research Question

> What responsibilities are required to transform heterogeneous source
> material into trustworthy, provenance-preserving material suitable for MCU
> Evidence, and which responsibilities belong to MCU versus a replaceable
> ingestion provider?

A secondary question emerged during the study:

> Does MCU need a program-level Source Correspondence contract, or can Domain
> Artifact and Evidence provenance already represent stable source-region
> references without another architectural responsibility?

---

# Existing MCU Constraints

This research begins with architecture MCU already owns.

## Responsibilities Outlive Implementations

MCU architecture is organized around durable responsibilities rather than
current frameworks, parsers, models, formats, or tools.

MinerU is therefore treated as:

- a research source
- a reference implementation
- a possible future provider

MinerU does not define MCU's content-ingestion ontology.

---

## Domain Artifacts Already Exist

Capabilities produce and own Domain Artifacts.

Orchestration composes capability-owned artifacts rather than requiring every
capability to share one implementation or persistence mechanism.

This creates a high bar for introducing a new `Document Representation`,
`Content Representation`, or similar program-level primitive.

A parser-specific structured representation may already fit naturally as a
capability-owned Domain Artifact.

---

## Evidence Already Exists

ADR-0019 establishes Evidence as implementation-independent reasoning
material.

The content-ingestion layer therefore does not automatically own Evidence.

A parsing capability may produce a structured interpretation of source
material.

An Evidence Provider may then decide what material from that interpretation
is appropriate to expose as Evidence.

Conceptually:

```text
Source Artifact
      |
      v
Parsing Capability
      |
      v
Domain Artifact
(structured interpretation)
      |
      v
Evidence Provider
      |
      v
Evidence
```

---

# MinerU Domain Model

MinerU distinguishes several responsibilities that are often collapsed into
"document parsing."

## Source Location

A file path represents a location at which content is currently visible.

The same content may exist at multiple paths.

Path availability has its own lifecycle independent from content identity.

Conceptually:

```text
Path
  |
  v
Content Identity
```

A path is not the document content itself.

---

## Content Identity

MinerU identifies document content using SHA256.

Multiple path instances may resolve to the same content identity.

This lets file availability and content identity evolve independently.

Conceptually:

```text
/path/a/report.pdf ----+
                       |
                       v
                    SHA256
                       ^
                       |
/backup/report.pdf ----+
```

This is useful because:

- moving a file does not necessarily create new content
- losing one path does not necessarily destroy the content identity
- cached interpretations can belong to content rather than path

---

## Parse Attempt

MinerU models parsing separately from source identity.

A parse records concerns such as:

- source content identity
- quality tier
- page range
- execution route
- status
- error

Therefore:

```text
Source
   !=
Parse
```

The same source may have multiple valid interpretations produced under
different parsing conditions.

---

# Canonical Parse Representation

MinerU persists a structured intermediate representation called Middle JSON.

Middle JSON is the sole persisted parsed-content representation in doclib.

It preserves sufficient information to derive multiple downstream views.

Conceptually:

```text
Source
   |
   v
Parsing
   |
   v
Middle JSON
   |
   +---- Markdown
   +---- Structured Content
   +---- Content List
   +---- Images
```

This establishes an important architectural distinction:

> The durable representation of interpreted content does not need to be the
> same representation used for presentation or ordinary consumption.

---

# Fidelity Representation and Consumption Representation

MinerU exposes two materially different structured representations.

## Middle JSON

Middle JSON is fidelity-oriented.

It preserves the canonical parsed structure needed for:

- re-rendering
- incremental parsing
- batch merging
- schema migration
- advanced SDK use

It is not the default representation intended for Agent consumption.

## Structured Content

Structured Content is derived from Middle JSON.

It is normalized for:

- Agents
- new clients
- downstream software

It preserves useful structure including:

- pages
- semantic item types
- spans
- bounding boxes
- locators
- source metadata
- parse metadata

while hiding backend-specific implementation differences.

## Architectural Finding

The study therefore distinguishes:

```text
Fidelity Representation
        !=
Consumption Representation
        !=
Presentation
```

A consumer-friendly projection does not need to become canonical persistence.

---

# Presentation Is Projection

MinerU derives human-readable outputs from its persisted structured
representation.

Examples include:

- Markdown
- HTML
- plain text

These are output semantics, not canonical source state.

MinerU explicitly avoids treating `json` as a semantic output name because
JSON describes encoding rather than artifact meaning.

## Candidate General Principle

> Serialization format is not artifact semantics.

For example:

```text
JSON
```

does not answer whether the payload represents:

- source structure
- parsed content
- Evidence
- Insight
- configuration
- an event
- or another artifact

MCU should name artifacts according to responsibility rather than encoding.

---

# Derivation Provenance

MinerU preserves information about how an interpretation was produced.

Structured Content can identify:

- source content hash
- filename
- MIME type
- actual parsing tier
- parsing backend
- parser version

This demonstrates that source identity alone may be insufficient provenance.

Conceptually:

```text
Source Artifact
      |
      +---- source identity
      |
      +---- parse tier
      |
      +---- parser/backend
      |
      +---- parser version
      |
      v
Interpretation
```

When derivation conditions can materially change an artifact's meaning, those
conditions should remain available as provenance.

---

# Quality as Provenance

MinerU defines multiple parsing quality tiers:

```text
flash
basic
standard
advanced
```

These tiers have different quality, performance, compute, and intended-use
semantics.

The same source parsed at different tiers may produce materially different
interpretations.

MinerU therefore includes the actual tier in stable block references.

## Candidate General Principle

> When derivation conditions can materially alter an artifact's meaning,
> those conditions must not disappear from its identity or provenance.

This does not imply that MCU requires MinerU's tier model.

Quality semantics remain provider-specific.

The durable responsibility is preservation of relevant derivation context.

---

# Source Correspondence

The strongest cross-cutting finding from MinerU is the distinction between
derivation provenance and source correspondence.

## Derivation Provenance

Answers:

```text
How was this interpretation produced?
```

Examples:

- parser
- version
- tier
- source identity

## Source Correspondence

Answers:

```text
Where in the interpreted source did this material come from?
```

MinerU represents this through stable locators and block references.

Conceptually:

```text
Document
   |
   v
Page
   |
   v
Block
   |
   +---- bounding box
```

A globally useful block reference combines document identity, parsing
conditions, page, and block.

The important property is that the locator refers to canonical parsed
structure rather than to a particular rendered view.

---

# Render-Independent Locators

MinerU deliberately assigns block identity before rendering.

A block remains addressable even when a particular renderer hides it.

Therefore:

```text
canonical structure
        |
        +---- block 1
        +---- block 2
        +---- block 3
        |
        +----------> Markdown
        |
        +----------> Structured Content
        |
        +----------> HTML
```

Changing the renderer does not renumber the canonical blocks.

This prevents citations from becoming presentation-dependent.

## Candidate General Principle

> Source correspondence should bind to canonical structure rather than to a
> transient presentation.

---

# Source Correspondence Beyond Documents

The responsibility suggested by MinerU is broader than document parsing.

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

This suggests a possible cross-artifact responsibility:

> Derived material can retain a stable reference to the region of source
> material from which it originated.

`Source Correspondence` is the current research term.

It is not an accepted MCU primitive or contract.

---

# Citation and Provenance Chain

Source correspondence becomes especially useful when combined with MCU
Evidence and Insight.

Conceptually:

```text
Insight
   |
   v
Evidence
   |
   v
Capability Domain Artifact
   |
   v
Source Correspondence
   |
   v
Source Artifact / Region
```

This makes provenance operational rather than merely documentary.

A reviewer could potentially move from a derived Insight to supporting
Evidence and then to the precise source region represented by that Evidence.

---

# Progressive Access

MinerU treats large-content access as a bounded protocol rather than requiring
the entire artifact to be loaded into one consumer context.

Its content protocol exposes:

- normalized request scope
- actual returned content ranges
- truncation state
- an explicit next request

Conceptually:

```text
request
   |
   v
bounded response
   |
   +---- request scope
   +---- actual ranges
   +---- truncated?
   +---- next request
```

This lets consumers progressively inspect large artifacts.

---

# Stateless Continuation

MinerU explicitly rejects server-side reading sessions for its first
progressive-reading contract.

Instead, continuation state is represented by explicit request parameters and
locators.

Conceptually:

```text
read
  |
  v
next_request
  |
  v
read
```

The content provider does not need to remember how far a particular Worker has
read.

## MCU Relevance

This supports an important distinction:

```text
Worker continuity
    !=
content-reader session
```

A persistent Worker does not require every content provider to maintain
Worker-specific reading state.

Stateless continuation reduces:

- lifecycle state
- expiry behavior
- cleanup
- concurrency concerns
- hidden provider coupling

---

# Bounded Context Consumption

Progressive access also addresses execution-context limits.

A large source artifact should not need to enter Execution State in full merely
because some portion of it may be relevant.

Potential access patterns include:

```text
read(locator)

read(range)

search(query)

continue(cursor)
```

These are examples, not an MCU API proposal.

The architectural lesson is:

> Large durable artifacts should support bounded consumption without requiring
> their entire representation to become Execution State.

---

# Normalization

MinerU normalizes backend-specific structures into a public Structured Content
schema.

Normalization includes:

- explicit page identity
- stable item shape
- semantic item types
- normalized spans
- normalized bounding boxes
- removal of backend-specific private fields
- consistent captions and footnotes

This demonstrates the value of separating:

```text
provider-native representation
        |
        v
normalized consumer representation
```

---

# Normalization Must Not Silently Lose Semantics

MinerU's Structured Content validation explicitly treats unrecognized item
types as validation issues rather than silently dropping them.

This suggests a useful general transformation rule:

> Normalization may simplify representation, but must not silently discard
> semantics it cannot represent.

A projection may intentionally omit information.

That omission should be part of the projection contract rather than an
accidental consequence of implementation.

---

# Errors Follow Responsibility

MinerU assigns failures according to the object whose responsibility failed.

Examples:

```text
File error
    path instance is unavailable or unreadable

Document error
    content identity is corrupt, encrypted, or unrecognizable

Parse error
    a particular interpretation attempt failed
```

This is preferable to assigning error ownership according to whichever
function or process happened to throw the error.

The finding aligns with MCU's existing responsibility-oriented architecture.

It does not currently require a new MCU decision.

---

# Ingestion Is Not Evidence

MinerU produces structured interpretations of source material.

It does not establish the epistemic status MCU should assign to the extracted
content.

A parser may be wrong.

OCR may be wrong.

Layout reconstruction may be wrong.

A table interpretation may be incomplete.

Therefore the current MCU research model is:

```text
Source Artifact
      |
      v
Ingestion / Parsing Capability
      |
      v
Domain Artifact
(structured interpretation)
      |
      v
Evidence Provider
      |
      v
Evidence
```

The Evidence Provider remains responsible for exposing reasoning material
under MCU Evidence semantics.

---

# Why No Document Primitive Is Currently Justified

MinerU is document-focused, but the responsibilities discovered during the
study do not require MCU to introduce `Document` as a program-level primitive.

Documents can remain source artifacts handled by capabilities.

The useful architectural concerns generalize beyond documents:

- source identity
- interpretation
- derivation provenance
- source correspondence
- projection
- bounded consumption

Therefore the study does not currently justify a new MCU `Document`
responsibility.

---

# Why No Content Representation Primitive Is Currently Justified

MinerU's Middle JSON is important inside MinerU because MinerU owns document
parsing.

MCU already has Domain Artifact as the general abstraction for
capability-owned structured outputs.

A parsing capability can therefore own an artifact containing:

- normalized structure
- derivation provenance
- source correspondence
- media
- projection support

without requiring MCU to define one universal content schema.

Conceptually:

```text
Parsing Capability
      |
      v
Domain Artifact
      |
      +---- capability-specific canonical structure
      +---- provenance
      +---- source correspondence
      +---- projections
```

The current research therefore rejects `Document Representation` and
`Content Representation` as new program-level primitives.

---

# Why No Generic Ingestion Primitive Is Currently Justified

Different capabilities may ingest very different source material.

Examples include:

- documents
- images
- audio
- video
- repositories
- telemetry
- APIs

A universal ingestion abstraction may provide little architectural value if
the important durable boundary is the Domain Artifact produced by the owning
capability.

The current study therefore does not justify a generic program-level
`Ingestion` primitive.

This conclusion may be revisited if multiple capabilities later demonstrate a
shared responsibility that cannot be represented by existing architecture.

---

# Candidate Cross-Cutting Responsibility

The strongest unresolved concept is Source Correspondence.

Working definition:

> A stable relationship between derived material and the specific region of
> source material from which it originated.

Potential properties include:

- source identity
- source type
- locator
- region
- derivation context
- stability rules
- resolution semantics

This is a research candidate.

It is not yet an MCU architectural responsibility.

---

# Candidate Architecture Invariants

The MinerU study suggests several candidate invariants.

These require MCU reconciliation before acceptance.

## Source identity and interpretation remain distinct

A source artifact and a derived interpretation are not the same object.

## Presentation is not canonical state

Human-readable or consumer-friendly renderings may be projections over a
capability-owned Domain Artifact.

## Serialization is not semantics

Artifact names and contracts should describe responsibility rather than
encoding.

## Relevant derivation conditions remain available

Provider, version, quality, or other conditions that materially affect an
interpretation should remain available as provenance.

## Source correspondence is presentation-independent

References to source material should not become invalid merely because a
different presentation is selected.

## Large artifacts support bounded consumption

Consumers should be able to inspect relevant portions without loading the
entire artifact into Execution State.

## Continuation should avoid unnecessary hidden state

Where practical, continuation should be explicit and portable rather than
requiring provider-owned reader sessions.

## Normalization must not silently discard unknown semantics

Unrepresentable material should be surfaced as a validation or fidelity issue
rather than disappearing without notice.

---

# MinerU Concepts Deliberately Not Adopted

The study does not introduce the following MinerU concepts into MCU program
architecture:

- Middle JSON
- Structured Content
- Content List
- ParseResult
- Doclib
- parsing tier
- block reference syntax
- short document ID
- MinerU cursor syntax
- MinerU Bank-like storage concepts
- MinerU-specific file lifecycle

These remain provider or capability implementation concepts.

---

# Current Responsibility Mapping

| MinerU Concept | Responsibility | Current MCU Interpretation |
| --- | --- | --- |
| File path | source location | capability/provider concern |
| SHA256 document | content identity | source identity / provider concern |
| Parse | interpretation attempt | capability operation |
| Middle JSON | canonical parsed representation | Domain Artifact content |
| Structured Content | normalized consumer representation | Domain Artifact projection |
| Markdown | human-readable rendering | projection |
| Parse tier | derivation quality | provenance |
| Backend/version | derivation mechanism | provenance |
| Locator | source-region correspondence | candidate cross-cutting contract |
| Block reference | globally resolvable source reference | provider implementation |
| Progressive read | bounded artifact access | candidate access pattern |
| next_request | stateless continuation | provider operation |

---

# Current Conclusion

MinerU does not currently justify a new MCU Document, Content Representation,
or Ingestion primitive.

Existing Domain Artifact architecture can own capability-specific structured
interpretations of source material.

ADR-0019 Evidence remains the boundary for exposing reasoning material.

The strongest unresolved finding is Source Correspondence:

> Should MCU define a program-level contract for stable references from
> derived artifacts and Evidence back to the source regions they represent?

The next step is adversarial reconciliation against existing Domain Artifact
and Evidence provenance responsibilities.

No implementation should begin before that question is answered.
