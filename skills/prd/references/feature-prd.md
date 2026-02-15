# Feature PRD — Interview Guide & Template

## Interview Questions

Ask these in a conversational flow, 2-3 at a time:

### Problem & Evidence
- What problem are we solving? Who experiences it?
- What evidence do we have? (customer feedback, data, support tickets, research)
- What happens if we don't solve this?

### Users & Goals
- Who is the primary user? Any secondary users?
- What is the user trying to accomplish (job to be done)?
- How do they solve this today (workarounds)?
- What does success look like? What metrics would move?

### Proposed Solution
- What's the high-level solution?
- Walk me through the core user flow, step by step
- What's the MVP vs. nice-to-have?

### Constraints & Dependencies
- Any technical constraints or limitations?
- Dependencies on other teams, features, or third parties?
- Timeline pressures or launch deadlines?

### Risks & Open Questions
- What are the biggest risks?
- What's still unknown or needs more research?

After these questions, proceed to Codebase Exploration, Competitive Analysis, and Usability Review phases (defined in SKILL.md).

## Output Template

```markdown
# Feature PRD: [Title]

**Author:** [from context/user-profile.md]
**Date:** [today's date]
**Status:** Draft

## Problem Statement
[What problem are we solving and why it matters]

## Evidence
[Customer feedback, data, support tickets, research supporting the need]

## Users
- **Primary:** [who]
- **Secondary:** [who, if any]

## Goals & Success Metrics
| Goal | Metric | Target |
|------|--------|--------|
| | | |

## Current Workarounds
[How users solve this today]

## Proposed Solution

### Overview
[High-level description]

### User Flow
1. [Step-by-step flow]

## Requirements

### P0 — Must Have
- [ ] [requirement]

### P1 — Should Have
- [ ] [requirement]

### P2 — Nice to Have
- [ ] [requirement]

## Technical Considerations
[From codebase exploration phase, if applicable]

### Affected Components
[Components/modules that will need changes]

### Data Model Changes
[New or modified entities/fields]

### API Changes
[New or modified endpoints]

### Cross-Product Impact
[Implications for other parts of the product]

## Competitive Landscape
[From competitive analysis phase, if applicable]

## Usability Requirements
[From usability review phase]

## User Stories
- As a [user], I want to [action] so that [benefit]

## Constraints
[Technical, business, or design constraints]

## Dependencies
[Other teams, features, or systems this depends on]

## Risks & Mitigations
| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| | | | |

## Open Questions
- [ ] [question]

## Timeline
[Rough phases or milestones, if known]
```
