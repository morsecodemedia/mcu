# Ecosystem Workflow

## Purpose

This document defines how work enters, moves through, and exits the ecosystem.

Every request entering the ecosystem must be classified into one of four work types.

The workflow is deterministic.

The organization adapts to the work.

The work never adapts to the organization.

---

# Work Types

## Initiative

Strategic work spanning multiple disciplines.

Characteristics:

- Cross-disciplinary
- Multiple milestones
- Long-lived
- High Council oversight

Examples:

- Build a new capability
- Support a new operating system
- Introduce a new discipline

Workflow:

CEO

↓

High Council

↓

Scope

↓

Roadmap

↓

Disciplines

↓

Capabilities

↓

Review

↓

CEO Approval

---

## Project

Work owned by a single discipline.

Characteristics:

- Single discipline
- Multiple capabilities
- Multiple tasks

Examples:

- Build the Audit Engine
- Create a comic issue
- Write a documentation site

Workflow:

CEO

↓

Discipline Council

↓

Capability Planning

↓

Execution

↓

Discipline Review

↓

CEO Approval

---

## Task

Small independently reviewable work.

Characteristics:

- Single capability
- Short duration
- Independently testable

Examples:

- Implement a function
- Generate an image
- Write documentation
- Create a benchmark

Workflow:

CEO

↓

Capability

↓

Worker

↓

Capability Review

↓

Complete

---

## Incident

Unplanned work requiring immediate attention.

Characteristics:

- Interrupt-driven
- Time-sensitive
- Existing work may pause

Examples:

- Broken build
- Security issue
- Regression
- Failed deployment

Workflow:

CEO

↓

Owning Discipline

↓

Capability

↓

Review

↓

Resolution

---

# Escalation

Capabilities never delegate work directly to another discipline.

If additional expertise is required, a Dependency Request is submitted.

The High Council determines whether:

- another discipline should participate
- scope should change
- priorities should change
- a new Initiative should be created

This preserves discipline independence.

---

# Review

Every completed work item moves upstream.

Capability Review

↓

Discipline Review (if applicable)

↓

High Council Review (if applicable)

↓

CEO Approval (if applicable)

The review path depends on the work type.
