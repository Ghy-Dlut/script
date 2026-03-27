# Self-Improving Router Merge Design

**Date:** 2026-03-27
**Thread Type:** programming
**Status:** approved design

## Goal

Merge the newer `self-improving` capabilities into the local `self-improving-agent` workflow while preserving stability, preventing duplicate memory writes, enforcing strict knowledge-type isolation, and routing all memory operations through `workspace-knowledge-router`.

## Primary Outcomes

- Use `C:\Users\55451\.agents\skills` as the only canonical skill root.
- Use `C:\Users\55451\.agents\knowledge-base` as the canonical global knowledge root.
- Keep only two global knowledge partitions:
  - `programming`
  - `academic-writing`
- Route both reads and writes by thread knowledge type before any project/global decision.
- Prevent cross-type sharing. Similar content in different knowledge types is stored independently.
- Keep project-local learnings in workspace `.learnings/`.
- Make `workspace-knowledge-router` the only routing and write-custody layer.
- Make `self-improving-agent` the capability provider for reflection, heartbeat, export, forget, stats, and event generation.
- Keep legacy `C:\Users\55451\.codex\skills` paths only as compatibility forwarding.

## Constraints

- Knowledge must be read only from the current thread's knowledge type partition.
- Knowledge must be written only after knowledge-type routing.
- `programming` and `academic-writing` global knowledge do not share entries, references, or links.
- If the only partition difference is `project` vs `global`, router may avoid double-writing and keep a lightweight association.
- If the partition difference is knowledge type, entries must be stored separately even when content is similar.
- Historical normalization must not preserve `origin_refs`.
- Threads that classify as neither `programming` nor `academic-writing` must ask the user before entering any global knowledge base.
- Deletion-like memory operations must always require explicit user confirmation.

## Non-Goals

- Do not keep `assignments` and `other` as active global knowledge partitions.
- Do not let `self-improving-agent` write directly to global stores.
- Do not rely on `C:\Users\55451\.codex\skills` as an active installation root.
- Do not implement background timed heartbeat jobs.

## Architecture

### Canonical roots

- Skills root: `C:\Users\55451\.agents\skills`
- Global knowledge root: `C:\Users\55451\.agents\knowledge-base`
- Project knowledge root: `<workspace>\.learnings`
- Legacy compatibility root: `C:\Users\55451\.codex\skills`

### Responsibility split

`workspace-knowledge-router`
- sole routing entrypoint
- sole partition and write-custody layer
- knowledge-type classification
- project/global scope choice
- dedupe and conflict resolution
- heartbeat orchestration
- export, forget, and stats routing
- compatibility command handling

`self-improving-agent`
- event generation
- reflection generation
- heartbeat capability implementation
- export/forget/stats capability implementation
- command aliases compatible with the newer `self-improving` interaction style
- no direct final storage decisions

## Routing Model

### Step 1: knowledge-type routing

Every operation starts by determining thread knowledge type:

- `programming`
- `academic-writing`
- `other/unresolved`

Rules:
- `programming` reads and writes only use the `programming` partition.
- `academic-writing` reads and writes only use the `academic-writing` partition.
- `other/unresolved` can still use project-local storage but must ask the user before any global write.

### Step 2: scope routing

After knowledge type is known, router decides storage scope:

- `project`
- `global`
- `project + global association`

Rules:
- one-off task errors, corrections, and transient reflections default to project scope
- explicit durable preferences default to global scope within the current knowledge type
- repeated or clearly cross-project patterns may be promoted directly to the matching global partition
- project/global associations are allowed only within the same knowledge type

## Read Isolation

Read behavior is strict:

- no cross-type reads
- no fallback from `programming` into `academic-writing`
- no fallback from `academic-writing` into `programming`
- no mixed summaries across type partitions

The router may read both project and global data only when both belong to the same knowledge type.

## Write Isolation

Write behavior is also strict:

- router decides the destination after knowledge-type routing
- `self-improving-agent` never writes final memory files directly
- different knowledge types never share an entry
- if content is similar across knowledge types, each type stores its own normalized version

## Event Model

All memory-affecting operations are normalized into router events.

Minimum event fields:

- `event_type`
- `knowledge_type`
- `scope_hint`
- `project_id`
- `thread_id`
- `source`
- `summary`
- `details`
- stable key fields such as `memory_key`, `pattern_key`, or `preference_key`
- `evidence_count`
- `timestamps`

Supported event types:

- `error`
- `correction`
- `preference`
- `reflection`
- `pattern`
- `heartbeat`
- `export`
- `forget`
- `stats`

## Dedupe and Conflict Rules

### Dedupe

Use `key-first, semantics-second` dedupe.

Order:
1. exact stable key match
2. same-partition semantic similarity
3. scope association inside the same knowledge type

Rules:
- explicit preferences and repeated patterns should carry stable keys
- dedupe never crosses knowledge-type partitions
- project/global duplicates in the same knowledge type may collapse to a single primary record plus association

### Conflict priority

Conflict resolution order:
1. project-specific rule over global rule
2. newer confirmed rule over older rule within the same layer
3. user-confirmed rule over inferred rule

This priority is still confined to the same knowledge type.

## Reflection and Heartbeat

### Reflection

- reflection is first emitted as a `reflection` event
- normal reflection defaults to project scope
- clearly cross-project reflection may become a global candidate
- reflection cannot silently overwrite an existing rule; it can only update through router conflict handling

### Heartbeat

Heartbeat runs only at session start and session end.

Session start:
- inspect current thread type
- inspect project and same-type global state
- surface only high-value pending reminders

Session end:
- collect this turn's events
- route and write them
- update indices
- surface only critical or user-relevant outcomes

No background schedule is used.

## Export, Forget, and Stats

### Export

Router decides which partition and scope to export:

- project only
- current-type global only
- both project and current-type global

### Forget

- router locates the target first
- router shows affected entries before execution
- user confirmation is mandatory
- cross-type forget does not exist because cross-type linkage is forbidden

### Stats

Router returns stats by current knowledge type and relevant scope.

Example breakdown:
- project counts
- current-type global counts
- recent changes this turn
- dedupe/conflict actions

## Storage Layout

### Global

Canonical global root:

`C:\Users\55451\.agents\knowledge-base`

Active partitions:

- `programming`
- `academic-writing`

Inactive or migration-only partitions:

- `assignments`
- `other`

### Project

Per-workspace local memory remains in:

- `<workspace>\.learnings\LEARNINGS.md`
- `<workspace>\.learnings\ERRORS.md`
- `<workspace>\.learnings\FEATURE_REQUESTS.md`

## Legacy Compatibility

Legacy paths under `C:\Users\55451\.codex\skills` remain only as compatibility forwarders.

Compatibility requirements:
- old commands must still resolve
- forwarded execution must immediately delegate to `C:\Users\55451\.agents\skills`
- documentation and templates should gradually move to the canonical path

## Historical Migration

Migration is full-scan but normalized.

### Project history

- scan existing `.learnings`
- normalize entries
- route by knowledge type
- dedupe within the matched type and scope

### Global history

- migrate global memory into `C:\Users\55451\.agents\knowledge-base`
- keep only `programming` and `academic-writing` as active partitions
- move `assignments` and `other` into a review/migration holding area
- ask the user before mapping unresolved history into an active global partition

### Normalization rule

- do not preserve `origin_refs`
- keep normalized final content only

## Compatibility Command Layer

Supported alias behavior should include newer `self-improving` style commands, but all must route through router first.

Examples:
- `memory stats`
- `export memory`
- `forget <target>`

## Rollout Plan

1. create timestamped local backups before each modification batch
2. move canonical roots to `.agents`
3. add compatibility forwarders for legacy `.codex\skills` entrypoints
4. refactor router into the single custody layer
5. adapt `self-improving-agent` to emit router events instead of direct writes
6. implement read isolation and write isolation by knowledge type
7. migrate and normalize historical data
8. verify start/end heartbeat, reflection, export, forget, and stats flows
9. update docs and command guidance

## Verification Requirements

- `programming` threads must read only `programming`
- `academic-writing` threads must read only `academic-writing`
- `other/unresolved` threads must pause before global writes
- router must be the only final write authority
- project/global association must not create duplicate writes
- no entry may be shared across knowledge types
- legacy `.codex\skills` entrypoints must still execute through compatibility forwarding

## Risks

- existing scripts still contain many `.codex\skills` hardcoded paths
- legacy routing currently still writes review state under `.codex`
- full migration without `origin_refs` reduces traceability, so normalized content quality must be high
- empty or partially initialized Git storage paths may complicate early backup automation

## Decisions Confirmed In This Thread

- use `C:\Users\55451\.agents\skills` as canonical skill root
- use `C:\Users\55451\.agents\knowledge-base` as canonical global knowledge root
- global knowledge keeps only `programming` and `academic-writing`
- reads are isolated by thread knowledge type
- writes are isolated by knowledge type before scope routing
- `other` and unresolved types require explicit user confirmation before global writes
- cross-type similar knowledge is stored independently
- historical normalization drops `origin_refs`
- session-only heartbeat
- reflection is enabled
- export/forget/stats are enabled and routed through router
- router is the sole partition and write authority
