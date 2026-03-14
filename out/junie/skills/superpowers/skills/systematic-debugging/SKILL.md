---
name: systematic-debugging
description: Use when a problem isn't obvious, after 3+ failing tests with different symptoms, or when facing complex, cross-cutting bugs.
allowed-tools: bash, open, search_paths_by_glob, search_contents_by_grep, update_status, agent_skill_read_doc
---

# Systematic Debugging

Debugging is science, not magic.

**Core principle:** Observe → Hypothesize → Experiment → Verify. Never guess.

## When to Use
- 3+ failing tests with different symptoms.
- "Obvious" fixes keep failing.
- Complex system-wide errors.
- Regressions with unknown cause.

## The Process

### 1. Observe and Report
Don't rush to fix. List EXACT symptoms.
- What fails? (Test name, file, line)
- What is the error? (Full traceback)
- What changed recently? (Git commits)

### 2. Formulate Hypotheses
List 2-3 potential causes. For each:
- **How would this cause the symptom?**
- **How can we PROVE or DISPROVE this?**

### 3. Root Cause Tracing
Adopt the `root-cause-tracing` persona by loading `agents/root-cause-tracing/SKILL.md` via `agent_skill_read_doc`.
Follow the tracing instructions precisely:
- Start from the failure point.
- Trace backwards through variables and function calls.
- Verify assumptions at each step (e.g., using `bash` for targeted logs).

### 4. Create Regression Test
Before fixing, write a test that fails due to this specific root cause.
Verify it fails (RED).

### 5. Minimal Fix
Implement the smallest possible fix that addresses the root cause.
Verify the regression test passes (GREEN).

### 6. Verify All Tests
Run the full test suite to ensure no regressions.

## Forbidden Actions
- Guessing "maybe this will work".
- Changing code before understanding why it fails.
- Blindly applying "best practices" to fix a bug.
- Trusting partial verification.

## Key Mindset
- You don't know what's wrong yet.
- Every assumption is a potential lie.
- Proof is better than confidence.
