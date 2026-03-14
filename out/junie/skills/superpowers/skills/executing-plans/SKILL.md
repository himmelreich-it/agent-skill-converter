---
name: executing-plans
description: Use when you have a written implementation plan to execute with review checkpoints
allowed-tools: bash, open, create, search_replace, update_status
---

# Executing Plans

## Overview

Load plan, review critically, execute all tasks, report when complete.

**Announce at start:** "I'm using the `executing-plans` skill to implement this plan."

**Note:** If your environment supports sub-tasks/delegation, use `superpowers:subagent-driven-development` instead for higher quality.

## The Process

### Step 1: Load and Review Plan
1. Read the plan file (using `open` or `open_entire_file`).
2. Review critically - identify any questions or concerns about the plan.
3. If concerns: Raise them with the user before starting.
4. If no concerns: Initialize the plan using `update_status` and proceed.

### Step 2: Execute Tasks

For each task in the plan:
1. Mark the task as in-progress (`*`) in `update_status`.
2. Follow each step exactly as specified in the plan.
3. Run verifications as specified.
4. Mark the task as completed (`✓`) in `update_status`.

### Step 3: Complete Development

After all tasks are completed and verified:
- Use `superpowers:finishing-a-development-branch` to finalize the work.

## When to Stop and Ask for Help

**STOP executing immediately when:**
- Hit a blocker (missing dependency, test fails, instruction unclear).
- Plan has critical gaps preventing starting.
- You don't understand an instruction.
- Verification fails repeatedly.

**Ask for clarification rather than guessing.**

## When to Revisit Earlier Steps

**Return to Review (Step 1) when:**
- User updates the plan based on your feedback.
- Fundamental approach needs rethinking.

**Don't force through blockers** - stop and ask.

## Remember
- Review plan critically first.
- Follow plan steps exactly.
- Don't skip verifications.
- Reference skills when the plan says to (using `agent_skill_read_doc`).
- Stop when blocked, don't guess.
- Never start implementation on main/master branch without explicit user consent.

## Integration

**Required workflow skills:**
- `superpowers:writing-plans`: Creates the plan this skill executes.
- `superpowers:finishing-a-development-branch`: Complete development after all tasks.
- `superpowers:subagent-driven-development`: Preferred over this skill if sub-task delegation is supported.
