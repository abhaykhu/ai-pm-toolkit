# Release Notes

## v1.1.3 - 2026-01-29

### New Features

**Planhat Integration for Customer Feedback Analysis**
- Added Planhat as fourth customer feedback data source alongside Canny, Zendesk, and Gong
- Planhat MCP tools: `get_model_actions`, `get_model_action_parameters`, `perform_model_action`
  - Flexible API allowing access to Companies, Conversations, Activities, and other models
  - Bearer token authentication via `https://api.planhat.com/v1/mcp`
- Health score integration: Low health scores boost urgency prioritization
- ARR-weighted prioritization: Optionally weight feedback by customer revenue
- CSM conversation analysis: Extract feature requests from customer success notes
- Updated installer to prompt for Planhat API token during setup
- Updated MCP-SETUP.md with Planhat configuration instructions
- Updated all documentation to reference Planhat as feedback source

---

## v1.1.2 - 2026-01-29

### New Features

**Internal Tooling Template & Workflow**
- Added `internal-tooling.md` template for internal tools, admin features, and developer utilities
- Scope skill now routes internal tooling requests to streamlined 3-phase workflow
- Template focuses on technical specs, admin controls, and operational considerations

### Bug Fixes

- Updated install.sh to use `/scope` instead of deprecated `/prd` in generated CLAUDE.md and instructions

---

## v1.1.1 - 2026-01-28

### New Features

**Feathr-Specific Reference Documentation**
- Added `feathr-specific/` directory with pre-configured Feathr content
- FeathrEgg easter egg now installs comprehensive Feathr reference docs:
  - `usability-components.md` (2,100+ lines) - Complete UI component usage guide for Mantine v7
  - `sdlc-overview.md` - Feathr's 14-phase SDLC with PM role mapping
  - `team-directory.md` - Full team roster with pod structure and assignment guidelines
  - `ui-patterns.md` - Feathr-specific UI decision trees and patterns
- Feathr installations skip generic customization (sed replacements) to preserve Feathr-specific content

### Internal

- Updated install script to conditionally copy Feathr-specific docs when FeathrEgg mode is active
- Refactored reference doc customization to only run for non-Feathr installations

---

## v1.1.0 - 2026-01-28

### Major Changes

**Renamed/Refactored PRD Skill → Scope Skill**
- The `/prd` skill is now `/scope` with a unified workflow for all issue types
- Supports 9 issue types: Epic, Feature, Brief, QA Testing, Frontend Component Update, Bug, Discovery, Task, Changelog Entry
- Workflows scale with complexity: full 5-phase for Epics/Features, 4-phase for Briefs, 3-phase for medium issues, grouped form-fill for simple issues

### New Features

**New Brief Template**
- High-level initiative summary format for early-stage scoping
- 4-phase research-focused workflow: Context → Research → Scope → Draft
- Integrates with `/analyze-feedback` and `/research-competitors` skills
- Captures business context, customer context, research findings, and success indicators

**Enhanced Workflow Routing**
- Phase 0 template selection with "I'm not sure" decision tree
- Intelligent routing based on issue complexity
- Clear guidance for choosing between 9 issue types

**Workflow Integration Patterns**
- Auto-generation: Automatic segment creation from feature data
- Attribution visibility: Upstream sources + downstream outcomes tracking
- Bi-directional sync: CRM data flows both directions
- Full shortcuts: Pre-configured workflows for common actions
- Next-step guidance: Always-present recommended actions

**Usability Component Integration**
- PRDs now reference `usability-components.md` for UI patterns
- Spec templates for success states, progress indicators, error handling
- Confirmation patterns for destructive actions
- Form validation and empty state definitions

**Lightweight Update Script**
- New `scripts/update.sh` for existing installations
- Syncs skills, templates, and reference docs without touching CLAUDE.md
- Automatically removes deprecated files (e.g., old `prd` skill)
- Usage: `./scripts/update.sh /path/to/project`

### Template Changes

| Old | New |
|-----|-----|
| `product-brief.md` | `changelog-entry.md` |
| — | `brief.md` (new) |

### Breaking Changes

- Skill renamed from `/prd` to `/scope`
- Template `product-brief.md` renamed to `changelog-entry.md` (different purpose)

---

## v1.0.0 - 2026-01-26

Initial release of AI PM Toolkit.
