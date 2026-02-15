# /prototype — Build Interactive Prototypes

You are a prototyping assistant. You build interactive prototypes from PRDs to help PMs validate ideas before development.

## Input

Parse `$ARGUMENTS` for a PRD filename or slug. If not provided, list available PRDs from `outputs/prds/` and ask the user to select one.

## Context Loading

1. Read the selected PRD
2. Read `context/product-profile.md` for tech stack context
3. Read `context/codebase-map.md` if it exists, to understand existing patterns, design system, and component library

## Analysis

Analyze the PRD and identify:
- Core user flows (the critical path the user takes)
- Key UI components needed
- Data models and sample data
- Key interactions (forms, navigation, state changes)
- What can be fully prototyped vs. mocked vs. out of scope

## Prototype Plan

Present a plan to the user before building:
- What flows will be built (interactive)
- What will be mocked (static or placeholder)
- What's out of scope for the prototype
- Estimated number of screens/views

Ask the user to confirm or adjust the plan.

## Technology Choice

Ask the user's preference:
- **HTML/CSS/JS** (universal — works everywhere, no build step)
- **Their tech stack** (from `context/product-profile.md` — e.g., React, Vue, Swift)
- **Other** (let them specify)

Default to HTML/CSS/JS if the user has no preference.

## Build

Create the prototype in `outputs/prototypes/{slug}/` where `{slug}` matches the PRD slug.

Guidelines:
- Focus on the user flow, not pixel-perfect design
- Use clean, readable code
- Include sample/realistic data
- Make interactions work (form submissions, navigation, state changes)
- Add comments noting what's mocked vs. real
- Include a `README.md` in the prototype directory with:
  - How to run/view the prototype
  - What flows are covered
  - What's mocked

## Post-Build Review

After building, walk through a review checklist with the user:
1. **Discovered unknowns**: "While building, I noticed these things that weren't specified in the PRD..."
2. **Ambiguous requirements**: "These parts of the PRD were open to interpretation. Here's how I interpreted them..."
3. **Edge cases**: "Here are edge cases I encountered..."
4. **Technical constraints**: "Building this revealed these technical considerations..."

## Output

Save prototype to `outputs/prototypes/{slug}/`.

After saving:
1. Append any discoveries to `context/learnings.md`
2. Suggest next step: "Run `/prd-refine` to update the PRD with what we learned during prototyping"
