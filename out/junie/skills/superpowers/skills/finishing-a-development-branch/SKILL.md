---
name: finishing-a-development-branch
description: Use when implementation is complete, all tests pass, and you need to decide how to integrate the work
allowed-tools: bash, open, create, search_replace, update_status
---

# Finishing a Development Branch

## Overview

Guide completion of development work by presenting clear options and handling chosen workflow.

**Core principle:** Verify tests → Present options → Execute choice → Clean up.

**Announce at start:** "I'm using the `finishing-a-development-branch` skill to complete this work."

## The Process

### Step 1: Verify Tests

**Before presenting options, verify tests pass:**

```bash
# Run project's test suite
npm test / cargo test / pytest / go test ./...
```

**If tests fail:**
```
Tests failing (<N> failures). Must fix before completing:

[Show failures]

Cannot proceed with merge/PR until tests pass.
```

Stop. Don't proceed to Step 2.

**If tests pass:** Continue to Step 2.

### Step 2: Determine Base Branch

```bash
# Try common base branches
git merge-base HEAD main 2>/dev/null || git merge-base HEAD master 2>/dev/null
```

Or ask the user: "This branch split from main - is that correct?"

### Step 3: Present Options

Present exactly these 4 options:

```
Implementation complete. What would you like to do?

1. Merge back to <base-branch> locally
2. Push and create a Pull Request
3. Keep the branch as-is (I'll handle it later)
4. Discard this work

Which option?
```

**Keep options concise.**

### Step 4: Execute Choice

#### Option 1: Merge Locally
1. Switch to base branch: `git checkout <base-branch>`
2. Pull latest: `git pull`
3. Merge feature branch: `git merge <feature-branch>`
4. Verify tests on merged result.
5. If tests pass, delete feature branch: `git branch -d <feature-branch>`

#### Option 2: Push and Create PR
1. Push branch: `git push -u origin <feature-branch>`
2. Create PR using `gh` CLI if available, or provide the URL to the user.

#### Option 3: Keep As-Is
Report: "Keeping branch <name>."

#### Option 4: Discard
Ask for confirmation: "Are you sure you want to discard ALL changes on <feature-branch>?"

### Step 5: Cleanup

Clean up any temporary files or worktrees created during development.

## Remember
- Verify tests pass before offering merge/PR.
- Follow the chosen workflow exactly.
- Always include the Junie co-authored trailer in any final commits if needed: `--trailer "Co-authored-by: Junie <junie@jetbrains.com>"`
- Ensure the user is informed at each step.
