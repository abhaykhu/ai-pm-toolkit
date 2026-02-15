# AI PM Toolkit Workspace

## Context System
Before acting on any skill, always read relevant files from `context/`:
- `user-profile.md` — who you're working with
- `company-profile.md` — company, customers, market
- `product-profile.md` — product details, tech stack, repos
- `team-profile.md` — eng team, stakeholders, processes
- `integrations.md` — configured CLI tools and MCP servers
- `codebase-map.md` — architecture and code structure (if applicable)
- `custom-templates.md` — user's own PRD/issue templates (if any)
- `learnings.md` — accumulated insights from previous work

If context files are missing or empty, suggest running `/pm-setup` first.

## Output Conventions
- Save all outputs to `outputs/{category}/` subdirectories
- Filename format: `YYYY-MM-DD-{type}-{slug}.md`
  - Example: `2025-01-15-feature-prd-contact-import.md`
  - Example: `2025-01-15-changelog-v2-release.md`
- After generating output, append key learnings to `context/learnings.md`
- Suggest the next logical skill in the PM workflow

## Skill Workflow Order
1. `/pm-setup` — onboarding and context gathering
2. `/customer-research` — analyze feedback and identify themes
3. `/competitive-analysis` — research competitors
4. `/prd` — scope and write PRDs
5. `/prototype` — build interactive prototypes
6. `/prd-refine` — refine PRDs with learnings
7. `/dev-handoff` — generate specs and tickets
8. `/pm-docs` — write documentation
9. `/enablement` — create sales/training materials
10. `/user-comms` — draft user-facing communications

## Codebase Awareness
When `context/codebase-map.md` exists, reference it during PRD scoping, prototyping, and dev handoff to understand existing architecture, entities, and component relationships.
