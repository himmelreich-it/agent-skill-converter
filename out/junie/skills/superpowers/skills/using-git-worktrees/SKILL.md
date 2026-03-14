---
name: using-git-worktrees
description: Use when starting feature work that needs isolation or before executing implementation plans. Creates isolated git worktrees with safety verification.
allowed-tools: bash, open, update_status
---

# Using Git Worktrees

Git worktrees create isolated workspaces sharing the same repository, allowing work on multiple branches simultaneously without switching.

**Core principle:** Systematic directory selection + safety verification = reliable isolation.

**Announce at start:** "I'm using the `using-git-worktrees` skill to set up an isolated workspace."

## Directory Selection Process

Follow this priority order:

### 1. Check Existing Directories
Check for `.worktrees` (preferred) or `worktrees` in the project root. If found, use that directory.

### 2. Check Guidelines
Check `CLAUDE.md` or other project guidelines for worktree preferences. If specified, use it.

### 3. Ask User
If no directory is found and no preference is specified, ask the user:
"No worktree directory found. Where should I create worktrees?
1. `.worktrees/` (project-local, hidden)
2. `~/.config/junie/worktrees/<project-name>/` (global location)
Which would you prefer?"

## Safety Verification

### For Project-Local Directories
**MUST verify directory is ignored before creating worktree:**
`git check-ignore -q .worktrees`

**If NOT ignored:**
1. Add the directory to `.gitignore`.
2. Commit the change with the Junie co-authored trailer.
3. Proceed with worktree creation.

**Why critical:** Prevents accidentally committing worktree contents to the repository.

## Creation Steps

### 1. Create Worktree
1. Determine the branch name.
2. Create the worktree: `git worktree add <path> -b <branch-name>`
3. Change directory to the new worktree: `cd <path>`

### 2. Run Project Setup
Auto-detect and run appropriate setup (e.g., `npm install`, `pip install -e .`, `uv sync`).

## Key Benefits
- **Isolation** - No accidental changes to your current branch.
- **Speed** - No need to stash/unstash when switching tasks.
- **Parallelism** - Work on multiple tasks at once in different worktrees.

## Remember
- Always check `.gitignore` first.
- Follow project setup conventions in the new worktree.
- Inform the user of the new worktree path.
