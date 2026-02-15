# Bug Report — Interview Guide & Template

## Interview Questions

### What Happened
- What's the bug? Describe what you're seeing.
- What should happen instead (expected behavior)?
- How do you reproduce it? Step by step.

### Impact
- How many users are affected?
- How severe is this? (blocker, major, minor, cosmetic)
- Is there a workaround?

### Environment
- Where does this occur? (browser, OS, device, environment)
- When did it start? (recent deploy, always been there, intermittent)
- Any screenshots, error messages, or logs?

## Output Template

```markdown
# Bug Report: [Title]

**Reporter:** [from context/user-profile.md]
**Date:** [today's date]
**Severity:** [Blocker / Major / Minor / Cosmetic]
**Status:** Open

## Description
[Clear, concise description of the bug]

## Steps to Reproduce
1. [step]
2. [step]
3. [step]

## Expected Behavior
[What should happen]

## Actual Behavior
[What actually happens]

## Impact
- **Users affected:** [scope]
- **Workaround:** [available / none]
- **Business impact:** [description]

## Environment
- **Browser/Client:** [details]
- **OS:** [details]
- **Environment:** [production / staging / local]
- **Version/Build:** [if known]

## Evidence
[Screenshots, error messages, log snippets, or links]

## Notes
[Any additional context, related issues, suspected root cause]
```
