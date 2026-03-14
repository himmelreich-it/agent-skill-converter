---
name: subagent-driven-development
description: Use when executing implementation plans with independent tasks by adopting specialized personas
allowed-tools: bash, open, create, search_replace, update_status
---

# Subagent-Driven Development

Execute plan by adopting a fresh specialized persona per task, with two-stage review after each: spec compliance review first, then code quality review.

**Why personas:** You delegate tasks to specialized "skills" (personas) with isolated focus. By adopting these specific instructions (via `agent_skill_read_doc`), you ensure you stay focused and succeed at each task. This also preserves your overall coordination context.

**Core principle:** Fresh persona per task + two-stage review (spec then quality) = high quality, fast iteration.

## The Process

### Phase 1: Preparation
1. Read the plan, extract all tasks with full text, and note required context.
2. Initialize the plan in `update_status` with all identified tasks.

### Phase 2: Per Task Execution
For each task in the plan:

1. **Adopt Implementer Persona**: Load the `implementer-prompt.md` (or equivalent implementer skill) via `agent_skill_read_doc`.
2. **Execute Task**: 
   - Mark task as in-progress (`*`) in `update_status`.
   - Implement the code, run tests, and commit (using `--trailer "Co-authored-by: Junie <junie@jetbrains.com>"`).
   - Perform a self-review.
3. **Spec Review**:
   - Adopt the `spec-reviewer-prompt.md` (persona) via `agent_skill_read_doc`.
   - Verify the implementation matches the spec exactly.
   - If gaps found, return to the implementer persona to fix them.
4. **Quality Review**:
   - Adopt the `code-quality-reviewer-prompt.md` (persona) via `agent_skill_read_doc`.
   - Verify code quality, DRY, YAGNI, and project standards.
   - If issues found, return to the implementer persona to fix them.
5. **Completion**:
   - Mark task as completed (`✓`) in `update_status`.

### Phase 3: Finalization
1. Once all tasks are complete, adopt the final code reviewer persona for the entire implementation.
2. Use `superpowers:finishing-a-development-branch` to complete the work.

## Handling Implementer Status

When working through a task, report one of these statuses in your thoughts/plan:

- **DONE:** Proceed to spec compliance review.
- **DONE_WITH_CONCERNS:** Work completed but with doubts. Address concerns before review.
- **NEEDS_CONTEXT:** Missing information. Ask the user and re-evaluate.
- **BLOCKED:** Cannot proceed due to external issues. Report to user immediately.

## Remember
- One persona per task.
- Two-stage review: spec first, then quality.
- Update `update_status` at every step.
- Follow the plan exactly.
- Stop when blocked, don't guess.
