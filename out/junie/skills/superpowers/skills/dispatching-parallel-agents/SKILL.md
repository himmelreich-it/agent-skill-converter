---
name: dispatching-parallel-agents
description: Use when facing 2+ independent tasks that can be worked on without shared state or sequential dependencies.
allowed-tools: bash, update_status, agent_skill_read_doc
---

# Dispatching Parallel Tasks

Delegate independent tasks to specialized personas with isolated focus. By precisely crafting their instructions and context, you ensure they stay focused and succeed.

## When to Use
- 3+ test files failing with different root causes.
- Multiple subsystems broken independently.
- Each problem can be understood without context from others.
- No shared state between investigations.

## The Process

### 1. Identify Independent Domains
Group failures or tasks by what's broken or needs to be done. Ensure each domain is independent.

### 2. Create Focused Task Plans
Use `update_status` to create a plan where each independent task is a separate point.
For each task, define:
- **Specific scope:** One test file or subsystem.
- **Clear goal:** What needs to be achieved.
- **Constraints:** What NOT to change.
- **Expected output:** Summary of findings and fixes.

### 3. Dispatch Tasks
For each task in the plan:
1. Adopt the appropriate persona (e.g., `implementer`, `debugger`) via `agent_skill_read_doc`.
2. Mark the task as in-progress (`*`) in `update_status`.
3. Execute the task following its specific goals and constraints.
4. Mark the task as completed (`✓`) in `update_status`.

### 4. Review and Integrate
When a task is finished:
- Verify the fixes don't conflict with other tasks.
- Run the relevant test suite.
- If all parallel tasks are done, run the full test suite to ensure system-wide integrity.

## Key Benefits
- **Parallelization** - Multiple investigations happen simultaneously in your workflow.
- **Focus** - Each persona adoption narrow your scope.
- **Independence** - Tasks don't interfere with each other if scoped correctly.
