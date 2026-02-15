# Epic PRD — Interview Guide & Template

## Interview Questions

### Vision & Context
- What's the overarching vision for this initiative?
- What strategic goal does it support?
- Why now? What's changed that makes this the right time?

### Scope & Themes
- What are the major themes or feature groups in this epic?
- For each theme, what's the core capability?
- What's explicitly out of scope?

### Users & Impact
- Who benefits from this initiative?
- What does the end-state look like for users?
- How does this change the product experience?

### Success Criteria
- How will we know this initiative succeeded?
- What metrics define success at the epic level?
- Are there intermediate milestones?

### Dependencies & Risks
- Cross-team dependencies?
- External dependencies (APIs, vendors, partners)?
- Biggest risks to delivery or adoption?

### Phasing
- Can this be broken into phases or milestones?
- What's the MVP phase vs. full vision?
- Are there natural sequencing constraints?

After these questions, proceed to Codebase Exploration, Competitive Analysis, and Usability Review phases (defined in SKILL.md).

## Output Template

```markdown
# Epic PRD: [Title]

**Author:** [from context/user-profile.md]
**Date:** [today's date]
**Status:** Draft

## Vision
[What we're building and why — the north star]

## Strategic Alignment
[Which company/product goals this supports]

## Background & Motivation
[Why now, what's changed, evidence supporting the initiative]

## Users & Impact
- **Primary users:** [who]
- **Expected impact:** [how their experience changes]

## Success Criteria
| Metric | Baseline | Target | Timeframe |
|--------|----------|--------|-----------|
| | | | |

## Themes & Features

### Theme 1: [Name]
**Goal:** [what this theme achieves]
- Feature A: [brief description]
- Feature B: [brief description]

### Theme 2: [Name]
**Goal:** [what this theme achieves]
- Feature C: [brief description]
- Feature D: [brief description]

## Milestones

### Phase 1: [Name] — [Target Date]
- [ ] [Deliverable]
- **Exit criteria:** [what must be true to move to Phase 2]

### Phase 2: [Name] — [Target Date]
- [ ] [Deliverable]

## Technical Considerations
[From codebase exploration phase, if applicable]

### Architecture Impact
[How this changes the system architecture]

### Data Model Changes
[New or modified entities across the epic]

### Cross-Product Impact
[Implications for other parts of the product]

## Competitive Landscape
[From competitive analysis phase, if applicable]

## Usability Requirements
[From usability review phase — epic-level UX considerations]

## Cross-Feature Dependencies
[How features within this epic depend on each other]

## External Dependencies
[Other teams, systems, vendors]

## Risks & Mitigations
| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| | | | |

## Out of Scope
[Explicitly not included in this initiative]

## Open Questions
- [ ] [question]

## Resource Estimate
[Rough team/effort estimate, if known]
```
