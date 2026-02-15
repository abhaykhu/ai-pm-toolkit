# AI PM Toolkit

AI-powered product management workflows for [Claude Code](https://docs.anthropic.com/en/docs/claude-code). A skills-based toolkit that gives Product Managers structured, repeatable workflows across the full PM lifecycle.

## What It Does

The AI PM Toolkit provides 10 slash-command skills that guide you through PM workflows — from customer research to PRD writing to dev handoff. Each skill conducts a structured interview, references your product context, and produces formatted output documents.

| Skill | What It Does |
|-------|-------------|
| `/pm-setup` | Onboard your product context, team, integrations, and codebase |
| `/customer-research` | Analyze customer feedback with JTBD and affinity mapping |
| `/competitive-analysis` | Research competitors and build comparison matrices |
| `/prd` | Write PRDs — feature, epic, bug, task, brief, or discovery |
| `/prototype` | Build interactive prototypes from PRDs |
| `/prd-refine` | Refine PRDs with prototype learnings and stakeholder feedback |
| `/dev-handoff` | Generate technical specs, acceptance criteria, and tickets |
| `/pm-docs` | Write API docs, user guides, FAQs, release notes, ADRs |
| `/enablement` | Create pitch decks, battle cards, training guides, demo scripts |
| `/user-comms` | Draft changelogs, emails, blog posts, social posts, migration notices |

## Quick Start

### 1. Clone the toolkit

```bash
git clone https://github.com/your-org/ai-pm-toolkit.git
cd ai-pm-toolkit
```

### 2. Install to a workspace

```bash
# Standalone PM workspace
./install.sh ~/my-pm-workspace

# Or install into an existing codebase
./install.sh ~/projects/my-app
```

### 3. Open Claude Code and run setup

```bash
cd ~/my-pm-workspace
claude
```

Then run:
```
/pm-setup
```

This walks you through a guided interview to capture your product context, team structure, integrations, and (if applicable) codebase architecture.

### 4. Start working

```
/prd feature        # Scope a feature PRD
/competitive-analysis  # Research competitors
/customer-research     # Analyze feedback
```

## Workflow

The skills are designed to flow naturally through the PM lifecycle:

```
/pm-setup → /customer-research → /competitive-analysis
                                         ↓
                              /prd (feature/epic/bug/task/brief/discovery)
                                         ↓
                                    /prototype
                                         ↓
                                    /prd-refine
                                         ↓
                                    /dev-handoff
                                         ↓
                              /pm-docs  /enablement  /user-comms
```

You don't have to follow this order — each skill works independently. But they build on each other: research informs PRDs, PRDs inform prototypes, prototypes inform refined PRDs, and so on.

## PRD Types

The `/prd` skill supports 6 document types:

| Type | Shorthand | Use When |
|------|-----------|----------|
| Feature PRD | `/prd feature` or `/prd f` | Scoping a single feature with full requirements |
| Epic PRD | `/prd epic` or `/prd e` | Planning a multi-feature initiative with milestones |
| Discovery Task | `/prd discovery` or `/prd d` | Defining a research or exploration task |
| Product Brief | `/prd brief` or `/prd b` | Pitching an opportunity to stakeholders |
| Bug Report | `/prd bug` | Documenting a bug with repro steps and impact |
| Dev Task | `/prd task` or `/prd t` | Writing a technical task with acceptance criteria |

Feature and Epic PRDs include automatic **codebase exploration** (if installed in a codebase), **competitive analysis**, and **usability review** phases.

## Custom Templates

During `/pm-setup`, you can provide your own templates for any document type. If your company has a standard PRD format or bug report template, the toolkit will use your template instead of the defaults.

## Codebase Awareness

When installed into a directory with source code, `/pm-setup` analyzes the codebase and creates a `context/codebase-map.md` with:
- Architecture overview
- Key entities and data models
- UI views and pages
- API surface
- Component relationships

This context is used by `/prd` (for cross-product impact analysis), `/prototype` (for matching existing patterns), and `/dev-handoff` (for technical spec generation).

## Integrations

The toolkit works with your existing tools:

**CLI Tools** (detected during setup):
- GitHub CLI (`gh`) — create issues and PRs via `/dev-handoff`
- Jira CLI — create tickets via `/dev-handoff`
- Linear CLI — create issues via `/dev-handoff`

**MCP Servers** (configured during setup):
- Project management: Jira, Linear, Asana, GitHub
- Customer feedback: Intercom, Zendesk, Productboard
- Communication: Slack, Notion, Confluence

MCP servers enable direct data access from Claude Code. They're optional — all skills work without them via paste/file import.

## Standalone vs. In-Repo Install

**Standalone workspace**: Install to a new directory for general PM work not tied to a specific codebase.
```bash
./install.sh ~/pm-workspace
```

**In-repo install**: Install into an existing project directory to get codebase-aware PRDs and handoffs.
```bash
./install.sh ~/projects/my-app
```

Both modes create the same toolkit structure. In-repo mode additionally generates `context/codebase-map.md` during setup.

## Directory Structure

After installation, your workspace contains:

```
workspace/
├── CLAUDE.md              # Instructions for Claude
├── .gitignore
├── .claude/skills/        # Toolkit skills (10 skills)
├── context/               # Your product context (created by /pm-setup)
│   ├── user-profile.md
│   ├── company-profile.md
│   ├── product-profile.md
│   ├── team-profile.md
│   ├── integrations.md
│   ├── codebase-map.md    # Auto-generated if codebase present
│   ├── custom-templates.md
│   └── learnings.md       # Accumulated insights
└── outputs/               # Generated documents
    ├── research/
    ├── competitive/
    ├── prds/
    ├── prototypes/
    ├── handoffs/
    ├── docs/
    ├── enablement/
    └── comms/
```

## Updating

When the toolkit is updated:

```bash
cd /path/to/ai-pm-toolkit
git pull
./install.sh /path/to/your-workspace
```

The installer detects your existing workspace and updates skills only. Your context, outputs, and configuration are preserved. See [docs/updating.md](docs/updating.md) for details.

## Privacy

All data stays local. The toolkit is a collection of skill files and templates — it doesn't phone home, collect telemetry, or send data anywhere. Your context files and outputs live in your workspace directory.

MCP servers connect directly between Claude Code and your tools (Jira, Slack, etc.) with your own API keys. No data passes through the toolkit.

## License

MIT — see [LICENSE](LICENSE).
