# Document Types Reference

## API Documentation

**Audience**: Developers (internal or external)
**Tone**: Technical, precise, example-driven

### Template
```markdown
# [API Name]

## Overview
[What this API does, authentication method]

## Base URL
`https://api.example.com/v1`

## Authentication
[How to authenticate — API key, OAuth, etc.]

## Endpoints

### [METHOD] /path
**Description:** [what it does]

**Parameters:**
| Name | Type | Required | Description |
|------|------|----------|-------------|

**Request:**
```json
{}
```

**Response:**
```json
{}
```

**Errors:**
| Code | Description |
|------|-------------|
```

## User Guide / Help Article

**Audience**: End users
**Tone**: Friendly, clear, step-by-step

### Template
```markdown
# [Title]

## Overview
[What the user will learn/accomplish]

## Prerequisites
[What they need before starting]

## Steps
1. [Step with screenshot/description]
2. [Step]

## Tips
[Helpful tips and best practices]

## Troubleshooting
[Common issues and solutions]
```

## FAQ

**Audience**: Varies (users, prospects, internal)
**Tone**: Concise, direct answers

### Template
```markdown
# [Topic] FAQ

## General
**Q: [Question]**
A: [Answer]

## Setup / Getting Started
**Q: [Question]**
A: [Answer]

## Troubleshooting
**Q: [Question]**
A: [Answer]
```

## Release Notes

**Audience**: Users, stakeholders
**Tone**: Informative, highlights value

### Template
```markdown
# Release Notes — [Version/Date]

## New Features
### [Feature Name]
[Description with value to user]

## Improvements
- [improvement]

## Bug Fixes
- [fix]

## Known Issues
- [issue]
```

## Internal Wiki Page

**Audience**: Team members
**Tone**: Informative, assumes context

### Template
```markdown
# [Topic]

## Overview
[What this page covers]

## Context
[Background, why this matters]

## Details
[The information]

## References
[Links, related pages]

## Changelog
| Date | Author | Change |
|------|--------|--------|
```

## Runbook / Playbook

**Audience**: Operations, on-call, support
**Tone**: Procedural, clear, no ambiguity

### Template
```markdown
# Runbook: [Scenario]

## When to Use
[Trigger conditions]

## Prerequisites
[Access, tools, permissions needed]

## Steps
1. [Step with exact commands/actions]
2. [Step]

## Verification
[How to confirm the issue is resolved]

## Escalation
[When and how to escalate]

## Rollback
[How to undo changes if needed]
```

## Architecture Decision Record (ADR)

**Audience**: Engineering, product
**Tone**: Analytical, balanced

### Template
```markdown
# ADR-[number]: [Title]

**Date:** [date]
**Status:** [Proposed / Accepted / Deprecated / Superseded]
**Deciders:** [who]

## Context
[What is the issue that we're seeing that motivates this decision?]

## Decision
[What is the change that we're proposing/doing?]

## Options Considered
### Option A: [name]
- Pros: [list]
- Cons: [list]

### Option B: [name]
- Pros: [list]
- Cons: [list]

## Consequences
[What becomes easier or harder as a result of this decision?]
```
