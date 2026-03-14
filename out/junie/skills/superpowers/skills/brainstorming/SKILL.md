---
name: brainstorming
description: Use before any creative work (creating features, building components, adding functionality) to explore user intent, requirements, and design before implementation.
allowed-tools: bash, open, search_paths_by_glob, search_contents_by_grep, create, update_status, agent_skill_read_doc
---

# Brainstorming Ideas Into Designs

Help turn ideas into fully formed designs and specs through natural collaborative dialogue.

Start by understanding the current project context, then ask questions one at a time to refine the idea. Once you understand what you're building, present the design and get user approval.

## The Process

### Phase 1: Context Exploration
1. Use `search_paths_by_glob`, `search_contents_by_grep`, and `open` to understand the current project state (files, docs, recent commits).
2. If the request is too large (multiple independent subsystems), help the user decompose it into sub-projects first.

### Phase 2: Clarifying Questions
1. Ask questions one at a time to refine the idea.
2. Focus on purpose, constraints, and success criteria.
3. One question per message - don't overwhelm the user.

### Phase 3: Propose Approaches
1. Propose 2-3 different approaches with trade-offs.
2. Lead with your recommended option and explain why.

### Phase 4: Present Design
1. Present the design in sections (architecture, components, data flow, error handling, testing).
2. Get user approval after each section.
3. Design for isolation: break the system into smaller units with clear boundaries and well-defined interfaces.

### Phase 5: Design Documentation
1. Write the validated design (spec) to `docs/superpowers/specs/YYYY-MM-DD-<topic>-design.md`.
2. Commit the design document using `bash` (include the Junie co-authored trailer).

### Phase 6: Spec Review Loop
1. Adopt the `spec-document-reviewer` persona by loading `agents/spec-document-reviewer/SKILL.md` via `agent_skill_read_doc`.
2. Review the spec for completeness, consistency, coverage, and YAGNI.
3. Fix any issues and repeat until approved (max 5 iterations).

### Phase 7: User Final Review
1. Ask the user to review the written spec file: "Spec written and committed to `<path>`. Please review it and let me know if you want to make any changes before we start writing out the implementation plan."
2. Only proceed once the user approves.

### Phase 8: Transition to Implementation
1. Invoke the `writing-plans` skill to create a detailed implementation plan.

## Key Principles
- One question at a time.
- YAGNI ruthlessly.
- Explore 2-3 alternatives.
- Incremental validation.
- Evidence before assertions.
