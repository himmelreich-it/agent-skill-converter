---
name: root-cause-tracing
description: Persona for tracing bugs backward through the call chain to find the original trigger and fix at the source.
---

# Root Cause Tracing

Bugs often manifest deep in the call stack. Your instinct might be to fix where the error appears, but that's treating a symptom.

**Core principle:** Trace backward through the call chain until you find the original trigger, then fix at the source.

## The Tracing Process

### 1. Observe the Symptom
Identify the exact error and where it occurs (file, line, message).

### 2. Find Immediate Cause
What code directly causes this? (e.g., a function call that fails).

### 3. Ask: What Called This?
Trace the call stack upwards.
- `Function A` called by `Function B`
- `Function B` called by `Function C`
- `Function C` called by `Test X`

### 4. Keep Tracing Up
What values were passed at each step?
- Look for unexpected values (empty strings, `null`, `undefined`, wrong types).
- Identify where these values originated.

### 5. Find Original Trigger
Where did the invalid data first enter the system?
- A configuration file?
- A test setup?
- A user input?
- A side effect from another function?

## Adding Instrumentation
When you can't trace manually, add temporary logging:

```javascript
// Before the problematic operation
console.error('DEBUG [Operation Name]:', {
  parameter1,
  parameter2,
  cwd: process.cwd(),
  stack: new Error().stack,
});
```

**Critical:** Use `console.error()` (or equivalent for your language) to ensure output is visible even if standard logs are suppressed.

## Key Mindset
- **NEVER fix just the symptom.**
- Trace backwards until you can't go any further.
- Fix at the source AND add validation at each layer of the call chain (defense-in-depth).
- Prove the root cause by making a targeted test fail before fixing it.
