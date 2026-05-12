---
title: TheWitnessPuzzlesReview
modified: Add Stage 1 Task 1 - Port reference puzzle generator logic
---

# APM Plan

## Workers

| Agent | Description |
|-------|-------------|
| generator-worker | Implements and ports puzzle generator logic |

## Stages

### Stage 1: Port Reference Generator

| Task | Objective | Output | Validation | Guidance | Dependencies | Steps |
|------|-----------|--------|------------|----------|--------------|-------|
| 1.1 | Port reference puzzle generator logic to TWP Shared | Updated ReversePanelGenerator.cs with reference logic | Manual validation: generated puzzles match reference quality/features | Use referencecode/witness-randomizer-master/Source/Generate.cpp as source; preserve integration; modularize symbol placement | None | 1. Read reference implementation; 2. Map logic to C#; 3. Implement in ReversePanelGenerator.cs; 4. Validate output |

## Dependency Graph

1.1

---

> **Notes:** First task is to port the reference generator logic. Manual validation required. Task 1.1 was completed prior to APM tracking.
