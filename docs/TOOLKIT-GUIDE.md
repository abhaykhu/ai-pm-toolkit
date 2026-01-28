# Feathr PM Toolkit Guide

**Last Updated:** 2026-01-23

A comprehensive AI-powered toolkit for product management work at Feathr. This guide explains what tools are available, when to use them, and how to get the most value.

---

## What This Toolkit Does

The PM Toolkit integrates with Claude Code to provide:

- **Structured Scoping** - Template-based workflows for 9 issue types (from quick bugs to comprehensive PRDs)
- **Customer Feedback Analysis** - Multi-source synthesis (Canny, Zendesk, Gong)
- **Design Integration** - Direct Figma access and context
- **GitHub Automation** - Template-based issue creation with quality validation
- **Codebase Intelligence** - Understand existing features and patterns

---

## Quick Start

### First Time Setup

1. **Install Claude Code** - Download from [claude.ai/download](https://claude.ai/download)
2. **Open Feathr project** - `cd ~/feathr && claude`
3. **You're ready!** - The toolkit is already configured in this repo

### Your First Issue

```
/scope
```

Claude will present a template selection menu, then guide you through the appropriate workflow:
- **Complex** (Epic, Feature, Brief) - Full 4-5 phase workflow with research
- **Medium** (QA Testing, Frontend Component Update) - 3-phase structured workflow
- **Simple** (Bug, Discovery, Task, Changelog Entry) - Quick grouped form-fill

---

## Available Skills

### `/scope` - Issue Scoping Workflow

**When to use:**
- Creating any type of issue (Epic, Feature, Bug, Task, etc.)
- Scoping initiatives for roadmap planning
- Documenting requirements for design
- Quick bug reports or task creation

**What it does:**
- Routes to appropriate workflow based on issue type
- Supports 9 templates with tailored workflows
- Runs competitive research and feedback analysis (for complex issues)
- Prompts for cross-feature integration (for features/epics)
- Applies quality checks automatically
- Saves markdown with metadata
- Can create GitHub issues

**Template Workflows:**

| Category | Templates | Workflow |
|----------|-----------|----------|
| **Complex** | Epic, Feature | Full 5-phase workflow |
| **Research-Focused** | Brief | 4-phase research workflow |
| **Medium** | QA Testing, Frontend Component Update | 3-phase structured |
| **Simple** | Bug, Discovery, Task, Changelog Entry | Grouped form-fill |

**Example:**
```
You: /scope
Claude: What type of issue are you creating?
       [Presents menu with 9 options + "I'm not sure"]
You: 2 (Feature)
Claude: [Guides through 5-phase workflow]
```

**Output:**
- Markdown file in appropriate location
- Optional GitHub issue with proper template
- Quality validation report (for complex issues)

---

### `/analyze-feedback` - Customer Feedback Analysis

**When to use:**
- Quarterly roadmap planning
- Researching feature requests
- Understanding customer pain points
- Validating PRD assumptions
- Identifying support trends

**What it does:**
- Fetches data from Canny, Zendesk, Gong
- Synthesizes feedback by theme
- Quantifies customer demand
- Identifies urgent issues
- Generates prioritized insights

**Example:**
```
You: /analyze-feedback
Claude: What time frame should I analyze?
You: Last 90 days, focus on fundraising features
Claude: [Fetches and analyzes data from all sources]
```

**Output:**
- Feedback analysis markdown in `docs/feedback-analysis/`
- Feature request breakdown with customer counts
- Support ticket themes and volume
- Gong call insights and quotes
- Prioritization recommendations

---

### `/research-competitors` - Competitive Research

**When to use:**
- PRD research phase (competitive intelligence)
- Understanding how competitors solve problems
- Identifying UX patterns and best practices
- Finding feature gaps and opportunities
- Strategic planning and roadmap research

**What it does:**
- Searches competitor sites, documentation, and reviews
- Extracts UX patterns and workflows
- Generates feature comparison matrices
- Identifies technical approaches (when discoverable)
- Highlights gaps and differentiation opportunities
- Provides actionable recommendations

**Example:**
```
You: /research-competitors recurring donations
Claude: Let's research competitors. Which aspects interest you most?
You: UX patterns and pricing
Claude: [4-phase workflow: Scope → Research → Analysis → Deliverable]
```

**Output:**
- Feature comparison matrix (table format)
- UX patterns documentation
- Gaps and opportunities analysis
- Recommendations for Feathr
- Optional: Saved to `docs/research/`

**Competitors covered:**
- **Direct:** Givebutter, Donorbox, Classy, GoFundMe Charity, Fundraise Up, Blackbaud, Salsa
- **Adjacent:** Mailchimp, Typeform, Stripe, Salesforce, etc.
- **Category leaders:** Best-in-class examples outside nonprofit space

---

### `/qa-prd` - PRD Quality Assurance

**When to use:**
- Before design handoff (critical)
- After drafting PRD (catch issues early)
- Reviewing existing PRDs
- Teaching PRD quality standards
- Validating PRD improvements

**What it does:**
- Validates PRD against Feathr quality standards
- Scores 6 dimensions (problem statement, user stories, cross-feature integration, usability components, workflow integration, writing quality)
- Detects common antipatterns
- Prioritizes issues by severity (critical, high, medium, low)
- Provides actionable recommendations with line references
- Assesses design readiness (✅ Ready | ⚠️ Conditional | ❌ Not Ready)

**Example:**
```
You: /qa-prd docs/prds/recurring-donations.md
Claude: [Analyzes PRD against all quality standards]
Claude: Overall Score: 8.5/10 ✅ Ready for Design

Critical Issues: None
High Priority: 2 issues found
- Missing validation rule for email field (Line 145)
- Mixed workflow context in Story 3 (Line 203)

Recommendations:
1. Add email validation: "Please enter valid email..."
2. Split Story 3 into donor-facing and backend stories
```

**Output:**
- Overall quality score (0-10)
- Detailed scores by dimension
- Prioritized issues with line references
- Specific fix recommendations
- Design readiness assessment
- Optional: Quality report saved to `docs/quality-reports/`

**Scoring rubric:**
- **9.0-10.0:** Excellent - Ready for design
- **7.0-8.9:** Good - Minor revisions, then ready
- **5.0-6.9:** Fair - Not ready, needs revision
- **3.0-4.9:** Poor - Major revision needed
- **0.0-2.9:** Incomplete - Start over

---

### `/skill-evaluator` - Skill Quality Analysis

**When to use:**
- Evaluating skill performance after use
- Improving existing skills
- Debugging skill issues

**What it does:**
- Analyzes skill output quality
- Identifies improvement opportunities
- Suggests skill enhancements

**Example:**
```
You: /skill-evaluator
Claude: Which skill would you like me to evaluate?
You: The PRD skill - last output was too generic
Claude: [Analyzes recent PRD output and suggests improvements]
```

---

## MCP Tool Integrations

The toolkit integrates with external services via Model Context Protocol (MCP) tools.

### Figma Tools

**Available:**
- `get_design_context` - Generate code from Figma designs
- `get_screenshot` - View design mockups
- `get_metadata` - Browse file structure
- `get_variable_defs` - Access design tokens

**When to use:**
- Reviewing designs linked in GitHub issues
- Understanding implementation patterns
- Analyzing UI components
- Referencing design system

**Example:**
```
You: What's in this Figma file? [paste URL]
Claude: [Uses get_metadata to show structure, then get_screenshot for key screens]
```

### Canny Tools

**Available:**
- `get_boards` - List feedback boards
- `get_posts` - Fetch posts with filters
- `search_posts` - Search across boards
- `get_post` - Get detailed post info

**When to use:**
- PRD research phase
- Quantifying customer demand
- Roadmap prioritization
- Feature validation

### Zendesk Tools

**Available:**
- `get_tickets` - Fetch recent tickets
- `get_ticket` - Get specific ticket
- `get_ticket_comments` - Read full conversation

**When to use:**
- Identifying support pain points
- Understanding customer issues
- PRD problem statements
- Feature impact analysis

### Gong Tools

**Available:**
- `list_calls` - Find calls by date range
- `retrieve_transcripts` - Get call transcripts

**When to use:**
- Validating product assumptions
- Understanding customer workflows
- Competitive intelligence
- Feature discovery

---

## Core Workflows

### Scoping an Issue

1. **Start the workflow**
   ```
   /scope
   ```

2. **Template Selection (Phase 0)**
   - Choose from 9 issue types
   - Or select "I'm not sure" for guided decision tree

3. **Workflow varies by complexity:**

**For Complex (Epic, Feature):**
- Phase 1: Discovery - Describe initiative, clarify business goal
- Phase 2: Research (Optional) - Competitive analysis, codebase context
- Phase 3: Cross-Feature Integration - 7 integration areas with workflow patterns
- Phase 4: Drafting - PRD with problem statement, user stories, usability specs
- Phase 5: Finalization - Review, iterate, save/publish

**For Research-Focused (Brief):**
- Phase 1: Context - Strategic rationale, customer pain points
- Phase 2: Research - Customer feedback analysis, competitive landscape
- Phase 3: Scope - Sub-features, success indicators
- Phase 4: Drafting & Finalization

**For Medium (QA Testing, Frontend Component Update):**
- Phase 1: Context - Feature link, overview, prerequisites
- Phase 2: Details - Scenarios/locations, requirements
- Phase 3: Draft & Finalize

**For Simple (Bug, Discovery, Task, Changelog Entry):**
- Grouped form-fill with related questions together
- Quick review and save

---

### Analyzing Customer Feedback

1. **Invoke skill**
   ```
   /analyze-feedback
   ```

2. **Specify parameters**
   - Time frame (last 30/60/90 days)
   - Data sources (Canny, Zendesk, Gong, or all)
   - Product area focus (optional)

3. **Review results**
   - Feature requests with customer counts
   - Support themes and volume
   - Call insights and quotes
   - Prioritization recommendations

4. **Export for stakeholders**
   - Markdown saved to `docs/feedback-analysis/`
   - Use in PRDs or roadmap planning
   - Share with leadership

**Time estimate:** 10-20 minutes

---

### Researching Competitors

1. **Invoke skill**
   ```
   /research-competitors [feature or product area]
   ```

2. **Scope the research**
   - Specify feature/capability to research
   - Choose aspect focus (pricing, UX, features, technical)
   - Select competitors to prioritize (3-5 recommended)

3. **Review research findings**
   - Competitor feature availability and pricing
   - UX patterns and workflows
   - Capabilities and limitations
   - Technical approaches

4. **Analyze insights**
   - Feature comparison matrix
   - UX pattern extraction
   - Best practices and standards
   - Gaps and opportunities

5. **Choose deliverable format**
   - PRD research section (ready to paste)
   - Presentation format (slide-ready)
   - Detailed report (saved to `docs/research/`)

6. **Integrate into PRD**
   - Use comparison matrix in "Competitive Landscape"
   - Reference UX patterns in user stories
   - Cite gaps in problem statement
   - Include recommendations in approach

**Time estimate:** 15-30 minutes depending on depth

---

### Creating GitHub Issues

**From a PRD:**
```
Create an epic from docs/prds/recurring-donations.md
```

Claude will:
- Read the PRD file
- Use appropriate template (epic.md, feature.md, etc.)
- Populate fields from PRD content
- Create issue in correct repo (shrike by default)
- Assign to andy-weir (if design phase)
- Add to appropriate project board
- Return issue URL

**From scratch:**
```
Create a feature issue for [description]
```

Claude will:
- Ask clarifying questions
- Choose appropriate template
- Draft issue content
- Create in GitHub
- Add proper formatting

**Rescoping existing issues:**
```
Rescope issue #123 and retain previous content
```

Claude will:
- Read existing issue
- Gather new requirements
- Apply markdown changes (strikethrough removed, bold added)
- Update issue with tracked changes
- Post comment explaining rescope

---

## Reference Documentation

### PRD Quality Standards

**[docs/reference/prd-quality-guide.md](reference/prd-quality-guide.md)**

Detailed quality standards with examples and antipatterns:
- Problem statement quality (strong vs weak examples)
- User story organization (workflow-based grouping)
- Cross-feature integration (comprehensive evaluation)
- Writing quality (scannability, terminology, clarity)
- PRD review checklist

**Use when:**
- Reviewing PRDs before design handoff
- Teaching PRD writing skills
- Evaluating quality issues

---

### UI Patterns

**[docs/reference/ui-patterns.md](reference/ui-patterns.md)**

Common UI patterns to reference in PRDs:
- Navigation patterns (primary nav, breadcrumbs)
- Data display (tables, cards)
- Form patterns (multi-step, inline editing)
- Feedback patterns (empty states, loading states)
- Action patterns (bulk actions, undo/redo)
- Search and filter patterns
- Form components (FormElement wrapper, validation)
- Onboarding (tooltips, help panels, milestones)
- Mobile patterns (touch targets, responsive layout)

**Use when:**
- Writing user requirements in PRDs
- Specifying UI behavior
- Scoping feature workflows

---

### Workflow Integration Principles

**[docs/reference/workflow-integration.md](ux-principles-workflow-integration.md)**

Design principles for platform cohesion:
- The Five Integration Questions
- Audience connection (segments, targeting)
- Campaign attribution (traffic sources, conversions)
- CRM integration (sync, field mapping)
- Cross-feature touchpoints

**Use when:**
- Scoping new features
- Cross-feature integration phase
- Evaluating platform impact

---

### SDLC Overview

**[docs/reference/sdlc-overview.md](reference/sdlc-overview.md)**

Feathr's Software Development Lifecycle:
- Pre-development phases (Evaluation → Scoping → Prototyping → Design → Ready for Dev)
- Development phases (Technical Evaluation → Discovery → Sprint Planning → Active Dev → Review)
- Post-development phases (Release Planning → QA → Deployment → Monitoring)
- Critical processes (Kickback, Mid-sprint Escalation, Hotfix)

**Use when:**
- Understanding where PRD fits in lifecycle
- Determining stakeholder approvals needed
- Planning feature delivery

---

### UI Patterns

**[docs/ui-patterns.md](ui-patterns.md)**

Common UI patterns and conventions used across Feathr platform.

**Use when:**
- Understanding existing patterns
- Ensuring consistency

---

## Issue Templates

All templates are in **[docs/templates/](templates/)**

| Template | When to Use | Key Sections |
|----------|-------------|--------------|
| **brief.md** | VP-to-PM initiative handoff | Business context, research findings, high-level scope, success indicators |
| **epic.md** | Large initiatives with multiple features | Problem, business context, features breakdown, success metrics |
| **feature.md** | Specific functionality chunks | Problem, user stories, cross-feature integration, acceptance criteria |
| **task.md** | Individual units of dev work | Description, acceptance criteria, related issues |
| **bug.md** | Bug reports | Steps to reproduce, expected vs actual, impact |
| **discovery.md** | Research and learning tasks | Research goals, questions to answer, deliverables |
| **qa-testing.md** | QA test scenarios | Test scenarios, prerequisites, expected outcomes |
| **frontend-component-update.md** | Component replacement work | Components to update, locations, migration strategy |
| **changelog-entry.md** | External feature announcements | What was built, why it matters, customer impact |

**Template Selection Logic:**
- **Brief** - VP-to-PM handoff with business context and research (precedes Epic/Feature)
- **Epic** - Contains multiple features, strategic initiative
- **Feature** - Single functionality chunk, requires design
- **Task** - Small dev work, no design needed
- **Bug** - Something broken that needs fixing
- **Discovery** - Research before scoping

---

## Configuration & Customization

### Where Your Configuration Lives

All company-specific settings are stored in files in your project:

**Primary Configuration: `CLAUDE.md`**

This is Claude Code's main configuration file. It contains:

- **Company Context** (lines 10-30)
  - Company name, product name, product type
  - Target customers and value proposition
  - Repository names (primary, backend, design)

- **Platform Capabilities** (lines 35-45)
  - List of your platform's key features
  - **To update:** Add/remove items from this list as features change

- **Product Tiers** (lines 50-55)
  - Your pricing structure
  - **To update:** Add new tiers or update pricing

- **Key Terminology** (lines 550-570)
  - Company-specific terms and definitions
  - **To update:** Add rows to the markdown table

- **Team Directory Reference** (lines 300)
  - Points to team members list

**Team Configuration: `docs/reference/team-directory.md`**

Contains all team member information:
- Name | Role | GitHub Username
- Assignment guidelines

**To update:** Edit the table directly, add/remove team members

**Reference Documentation: `docs/reference/`**

All reference docs are customized with your company name:
- `prd-quality-guide.md` - Uses your product name in examples
- `workflow-integration.md` - References your platform
- `sdlc-overview.md` - Your development process
- `ui-patterns.md` - Common patterns for your product

### How to Update Configuration

**Add a new platform capability:**
```markdown
# Edit CLAUDE.md, find "Platform Capabilities" section
**Platform Capabilities:**
- Email marketing
- Landing pages
- Analytics
- [Your new feature]  ← Add here
```

**Add a pricing tier:**
```markdown
# Edit CLAUDE.md, find "Product Tiers" section
**Product Tiers:**
- Free
- Pro ($49/mo)
- Enterprise (custom)
- [Your new tier]  ← Add here
```

**Add terminology:**
```markdown
# Edit CLAUDE.md, find "Key Terminology" section
| Term | Definition |
|------|------------|
| Existing Term | Existing definition |
| New Term | New definition |  ← Add here
```

**Add a team member:**
```markdown
# Edit docs/reference/team-directory.md
| Name | Role | GitHub Username |
|------|------|-----------------|
| Alice | PM | alice |
| Bob | New Person | newperson |  ← Add here
```

### When to Update

**Update immediately:**
- New team member joins → Add to team directory
- Launch new major feature → Add to platform capabilities
- Change pricing → Update product tiers
- New company jargon → Add to terminology

**Update quarterly:**
- Review terminology table for outdated terms
- Review SDLC process for changes
- Update reference doc examples

---

## Tips & Tricks

### Get Better PRD Output

1. **Provide context upfront** - More detail = better output
2. **Use research phase** - Competitive analysis improves quality
3. **Don't rush cross-feature integration** - This catches requirements early
4. **Iterate on problem statements** - Ask Claude to refine until quantified
5. **Request quality check** - Ask "Does this meet PRD quality standards?"

### Efficient Feedback Analysis

1. **Run incrementally** - "Since last run" mode for regular updates
2. **Focus on specific areas** - Don't analyze everything every time
3. **Use for PRD validation** - Reference customer demand in problem statements
4. **Export for stakeholders** - Saved markdown files are ready to share

### GitHub Workflow Optimization

1. **Save PRD first, issue second** - Easier to iterate on markdown
2. **Use "retain mode" in design phase** - Andy needs to see changes
3. **Link issues immediately** - Easier to maintain hierarchy
4. **Assign andy-weir for design tasks** - Automatic workflow

### Working with Design Files

1. **Use get_metadata first** - Understand structure before diving in
2. **Reference node IDs in issues** - Makes it easy for Andy to find
3. **Extract fileKey and nodeId from URLs** - Format: `figma.com/design/:fileKey/:fileName?node-id=1-2`

---

## Common Questions

### How do I add a new template?

1. Create template in `docs/templates/`
2. Update `docs/README.md` with template description
3. Add template selection logic to CLAUDE.md if needed

### How do I improve a skill?

1. Use `/skill-evaluator` to analyze output
2. Edit skill file in `.claude/skills/[skill-name]/SKILL.md`
3. Test changes with new invocation
4. Update version number if significant changes

### What if Claude doesn't use the right template?

Be explicit: "Create an epic issue for..." or "Use the feature template for..."

### How do I configure MCP tools?

See CLAUDE.md "MCP Tools Configuration" section for authentication and setup.

### Can I customize the workflow?

Yes! Edit `.claude/skills/[skill-name]/SKILL.md` to adjust phases, prompts, or outputs.

---

## Getting Help

### Documentation Issues
- Check [docs/README.md](README.md) for overview
- Review specific reference docs in [docs/reference/](reference/)

### Skill Issues
- Use `/skill-evaluator` to diagnose
- Check skill file: `.claude/skills/[skill-name]/SKILL.md`
- Review recent outputs for patterns

### Questions or Improvements
- Ask Abhay or Freddy
- Document common issues here
- Suggest new features or agents

---

## Version History

- **1.0.0** (2026-01-23) - Initial toolkit consolidation and restructure
