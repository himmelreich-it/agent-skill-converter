---
name: verification-before-completion
description: Use before any success claim, fixed status, or work completion, especially before committing or creating PRs.
allowed-tools: bash, open, update_status
---

# Verification Before Completion

Claiming work is complete without verification is dishonesty. Evidence before claims, always.

**Core principle:** If you haven't run the verification command in this message, you cannot claim it passes.

## The Gate Function

BEFORE claiming any status or expressing satisfaction:

1. **IDENTIFY**: What command proves this claim?
2. **RUN**: Execute the FULL command (fresh, complete).
3. **READ**: Full output, check exit code, count failures.
4. **VERIFY**: Does the output confirm the claim?
5. **CLAIM**: ONLY then, make the claim WITH evidence.

## Common Failures

| Claim | Requires | Not Sufficient |
|-------|----------|----------------|
| Tests pass | Test command output: 0 failures | Previous run, "should pass" |
| Linter clean | Linter output: 0 errors | Partial check, extrapolation |
| Build succeeds | Build command: exit 0 | Logs look good, but not checked |
| Bug fixed | Test original symptom: passes | Code changed, assumed fixed |
| Requirements met | Line-by-line checklist | Tests passing but not checked |

## Red Flags - STOP
- Using "should", "probably", "seems to".
- Expressing satisfaction before verification ("Great!", "Done!").
- Trusting agent success reports without manual verification.
- Relying on partial verification.

## When To Apply
- Before ANY completion claim.
- Before committing, pushing, or creating PRs.
- Before moving to the next task.
- Before delegating to agents/personas.

**No shortcuts for verification.** Run the command. Read the output. THEN claim the result.
