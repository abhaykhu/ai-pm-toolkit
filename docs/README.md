# Product Management Documentation

**Last Updated:** 2026-01-23

This directory contains a PM Toolkit for AI-powered product management work.

---

## 📚 Quick Start

**New to the toolkit?** Start with **[TOOLKIT-GUIDE.md](TOOLKIT-GUIDE.md)** for a comprehensive overview of tools, skills, and workflows.

**Creating an issue?** Run `/scope` in Claude Code to start the guided workflow for any issue type.

**Analyzing feedback?** Run `/analyze-feedback` to synthesize Canny, Zendesk, Gong, and Planhat data.

---

## Directory Structure

```
docs/
├── README.md                    # This file - toolkit overview
├── TOOLKIT-GUIDE.md             # Comprehensive guide for team (START HERE)
├── reference/                   # Reference documentation (use on-demand)
│   ├── prd-quality-guide.md    # Quality standards, examples, antipatterns
│   ├── usability-components.md # UI component usage rules
│   ├── workflow-integration.md # Platform integration principles
│   ├── sdlc-overview.md        # Feathr's development lifecycle
│   ├── team-directory.md       # Team members and GitHub usernames
│   └── ui-patterns.md          # Common UI patterns
├── templates/                   # GitHub issue templates
│   ├── brief.md
│   ├── epic.md
│   ├── feature.md
│   ├── task.md
│   ├── bug.md
│   ├── discovery.md
│   ├── qa-testing.md
│   ├── frontend-component-update.md
│   └── changelog-entry.md
├── prds/                        # Example PRDs and active PRD work
└── feedback-analysis/           # Feedback analysis reports
```

---

## Available Skills

### `/scope` - Issue Scoping Workflow

**Template-based workflows for 9 issue types:**

| Category | Templates | Workflow |
|----------|-----------|----------|
| **Complex** | Epic, Feature | Full 5-phase workflow |
| **Research-Focused** | Brief | 4-phase research workflow |
| **Medium** | QA Testing, Frontend Component Update | 3-phase structured |
| **Simple** | Bug, Discovery, Task, Changelog Entry | Grouped form-fill |

**Outputs:**
- Markdown in appropriate location (`prds/` or `issues/`)
- Optional GitHub issue with proper template
- Quality validation report (for complex issues)

**See:** [TOOLKIT-GUIDE.md](TOOLKIT-GUIDE.md#scope---issue-scoping-workflow) for detailed usage

---

### `/analyze-feedback` - Customer Feedback Analysis

**Multi-source feedback synthesis from Canny, Zendesk, Gong, and Planhat:**

- Fetches data across configurable time ranges
- Synthesizes feedback by theme
- Quantifies customer demand
- Identifies urgent issues
- Generates prioritized insights

**Outputs:**
- Feedback analysis markdown in `feedback-analysis/`
- Feature request breakdown with customer counts
- Support ticket themes and volume
- Gong call insights and quotes
- Prioritization recommendations

**See:** [TOOLKIT-GUIDE.md](TOOLKIT-GUIDE.md#analyze-feedback---customer-feedback-analysis) for detailed usage

---

### `/research-competitors` - Competitive Research

**Deep competitive analysis for PRD research:**

- Searches competitor sites, documentation, reviews
- Extracts UX patterns and workflows
- Generates feature comparison matrices
- Identifies gaps and opportunities
- Provides actionable recommendations

**Outputs:**
- Feature comparison matrix (table)
- UX patterns documentation
- Gaps and opportunities analysis
- Recommendations for Feathr
- Optional: Research report in `docs/research/`

**Competitors covered:** Givebutter, Donorbox, Classy, GoFundMe Charity, Fundraise Up, Blackbaud, Salsa, Mailchimp, Typeform, Stripe, and more

**See:** [TOOLKIT-GUIDE.md](TOOLKIT-GUIDE.md#research-competitors---competitive-research) for detailed usage

---

### `/qa-prd` - PRD Quality Assurance

**Automated PRD quality checker:**

- Validates against Feathr quality standards
- Scores 6 dimensions (problem statement, user stories, cross-feature integration, usability, workflow integration, writing)
- Detects antipatterns with line references
- Prioritizes issues by severity
- Provides actionable recommendations
- Assesses design readiness

**Outputs:**
- Overall quality score (0-10)
- Detailed issue report with priorities
- Specific fix recommendations
- Design readiness assessment
- Optional: Quality report in `docs/quality-reports/`

**Scoring:** 9-10 = Excellent, 7-8.9 = Good, 5-6.9 = Fair, 3-4.9 = Poor, 0-2.9 = Incomplete

**See:** [TOOLKIT-GUIDE.md](TOOLKIT-GUIDE.md#qa-prd---prd-quality-assurance) for detailed usage

---

### `/skill-evaluator` - Skill Quality Analysis

**Evaluates skill performance and suggests improvements:**

- Analyzes skill output quality
- Identifies improvement opportunities
- Suggests skill enhancements
- Helps debug skill issues

---

## Reference Documentation

All reference docs are in **[reference/](reference/)**. Click through for detailed guidance.

| Document | Audience | When to Use |
|----------|----------|-------------|
| **[prd-quality-guide.md](reference/prd-quality-guide.md)** | PMs | Writing PRDs, reviewing quality, teaching standards |
| **[usability-components.md](reference/usability-components.md)** | PMs, Designers | Writing user requirements, specifying UI behavior |
| **[workflow-integration.md](reference/workflow-integration.md)** | PMs, Designers | Scoping features, cross-feature integration |
| **[sdlc-overview.md](reference/sdlc-overview.md)** | Everyone | Understanding feature delivery process |
| **[team-directory.md](reference/team-directory.md)** | Everyone | Assigning issues, tagging collaborators |
| **[ui-patterns.md](reference/ui-patterns.md)** | PMs, Designers, Engineers | Understanding existing UI patterns |

---

## Issue Templates

All templates are in **[templates/](templates/)** and automatically used by `/prd` skill based on scope.

### When to Use Each Template

| Template | Use For | Key Sections |
|----------|---------|--------------|
| **[brief.md](templates/brief.md)** | VP-to-PM initiative handoff | Business context, research findings, high-level scope, success indicators |
| **[epic.md](templates/epic.md)** | Large initiatives with multiple features | Problem, business context, features breakdown, success metrics |
| **[feature.md](templates/feature.md)** | Specific functionality chunks | Problem, user stories, cross-feature integration, acceptance criteria |
| **[task.md](templates/task.md)** | Individual units of dev work | Description, acceptance criteria, related issues |
| **[bug.md](templates/bug.md)** | Bug reports | Steps to reproduce, expected vs actual, impact |
| **[discovery.md](templates/discovery.md)** | Research and learning tasks | Research goals, questions to answer, deliverables |
| **[qa-testing.md](templates/qa-testing.md)** | QA test scenarios | Test scenarios, prerequisites, expected outcomes |
| **[frontend-component-update.md](templates/frontend-component-update.md)** | Component replacement work | Components to update, locations, migration strategy |
| **[changelog-entry.md](templates/changelog-entry.md)** | External feature announcements | What was built, why it matters, customer impact |

**Template Selection Logic:**
- **Brief** - VP-to-PM handoff with business context and research (precedes Epic/Feature)
- **Epic** - Contains multiple features, strategic initiative
- **Feature** - Single functionality chunk, requires design
- **Task** - Small dev work, no design needed
- **Bug** - Something broken that needs fixing
- **Discovery** - Research before scoping

---

## MCP Tool Integrations

The toolkit integrates with external services via Model Context Protocol (MCP):

| Tool | Provider | Usage |
|------|----------|-------|
| **Design** | Figma | View designs, generate code, access design system |
| **Feedback** | Canny | Research feature requests, track sentiment |
| **Support** | Zendesk | Analyze tickets, identify pain points |
| **Calls** | Gong | Review customer conversations, extract insights |
| **Customer Success** | Planhat | Customer health scores, CSM conversations, churn risk |

**See:** [TOOLKIT-GUIDE.md](TOOLKIT-GUIDE.md#mcp-tool-integrations) for detailed tool usage guide.

---

## Common Workflows

### Create Any Issue

```
/scope
```

Select template type, follow the appropriate workflow. Complex issues take longer, simple issues complete quickly.

**See:** [TOOLKIT-GUIDE.md](TOOLKIT-GUIDE.md#scoping-an-issue) for step-by-step guide.

---

### Analyze Customer Feedback

```
/analyze-feedback
```

Specify time frame, data sources, and focus area. Time: 10-20 minutes.

**See:** [TOOLKIT-GUIDE.md](TOOLKIT-GUIDE.md#analyzing-customer-feedback) for step-by-step guide.

---

### Create GitHub Issues

**From a PRD:**
```
Create an epic from docs/prds/recurring-donations.md
```

**From scratch:**
```
Create a feature issue for [description]
```

**Rescoping existing:**
```
Rescope issue #123 and retain previous content
```

**See:** [TOOLKIT-GUIDE.md](TOOLKIT-GUIDE.md#creating-github-issues) for detailed workflow.

---

## Tips & Best Practices

### Get Better PRD Output
- Provide context upfront (more detail = better output)
- Use research phase for competitive intelligence
- Don't rush cross-feature integration (catches requirements early)
- Iterate on problem statements until quantified
- Request quality check before finalization

### Efficient Feedback Analysis
- Run incrementally ("since last run" mode for regular updates)
- Focus on specific areas (don't analyze everything every time)
- Use for PRD validation (reference customer demand in problem statements)

### GitHub Workflow Optimization
- Save PRD first, issue second (easier to iterate on markdown)
- Use "retain mode" when rescoping in design phase (Andy needs to see changes)
- Link issues immediately (easier to maintain hierarchy)
- Assign andy-weir for design tasks (automatic workflow)

---

## Getting Help

### For toolkit questions:
1. Check [TOOLKIT-GUIDE.md](TOOLKIT-GUIDE.md)
2. Review specific reference doc in [reference/](reference/)
3. Use `/skill-evaluator` to diagnose skill issues
4. Ask Abhay or Freddy

### For skill improvements:
1. Use `/skill-evaluator` to analyze output
2. Edit skill file in `.claude/skills/[skill-name]/SKILL.md`
3. Test changes with new invocation
4. Document improvements here

---

## Version History

- **1.0.0** (2026-01-23) - Initial toolkit consolidation and restructure
  - Created TOOLKIT-GUIDE.md for team onboarding
  - Organized reference docs in reference/
  - Streamlined CLAUDE.md from 815 → 421 lines
  - Moved SDLC, team directory, and quality guides to reference/
  - Added frontmatter to all reference docs

---

*For comprehensive toolkit documentation, see [TOOLKIT-GUIDE.md](TOOLKIT-GUIDE.md)*
