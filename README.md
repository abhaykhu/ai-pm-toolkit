# AI PM Toolkit

**AI-powered product management tools for enabling faster, higher-quality product management work.**

This toolkit integrates with [Claude Code](https://claude.ai/download) to provide automated PRD writing, competitive research, customer feedback analysis, and quality assurance.

---

## What This Toolkit Provides

**4 AI-Powered Skills:**

| Skill | Command | Purpose | Time Savings |
|-------|---------|---------|--------------|
| **PRD Writing** | `/prd` | Guided 5-phase PRD workflow with quality checks | 2-3 hours → 30-60 min |
| **Competitive Research** | `/research-competitors` | Automated competitor analysis with comparison matrices | 1-2 hours → 15-30 min |
| **Feedback Analysis** | `/analyze-feedback` | Multi-source customer feedback synthesis | 1-2 hours → 10-20 min |
| **Quality Assurance** | `/qa-prd` | Automated PRD quality checker | 30-45 min → 5-10 min |

**Total time savings per PRD:** 4-6 hours → 1-2 hours (60-75% reduction)

---

## Key Features

**PRD Writing (`/prd`):**
- 5-phase guided workflow (Discovery → Research → Integration → Drafting → Finalization)
- Automatic cross-feature integration prompts
- Usability component specifications
- Built-in quality checks
- GitHub issue creation

**Competitive Research (`/research-competitors`):**
- 4-phase workflow (Scope → Research → Analysis → Deliverable)
- Web search across competitors
- Feature comparison matrices
- UX pattern extraction
- Gap and opportunity analysis
- Multiple output formats (PRD section, presentation, detailed report)

**Feedback Analysis (`/analyze-feedback`):**
- Multi-source synthesis (Canny, Zendesk, Gong via MCP tools)
- Configurable time ranges
- Product area filtering
- Quantified customer demand
- Prioritization recommendations

**Quality Assurance (`/qa-prd`):**
- 6-dimension quality scoring (problem statement, user stories, cross-feature integration, usability, workflow integration, writing)
- Antipattern detection (20+ patterns)
- Prioritized issues with line references
- Design readiness assessment
- Actionable recommendations

---

## Installation

### Prerequisites

1. **Claude Code installed** - [Download here](https://claude.ai/download)
2. **Node.js 20+** (if using JavaScript/TypeScript projects)
3. **Git** (for version control)

### Quick Install

```bash
# Clone this repository
git clone https://github.com/your-org/ai-pm-toolkit.git
cd ai-pm-toolkit

# Run interactive installer
./scripts/install.sh /path/to/your/project

# Follow prompts to customize for your company
```

The installer will:
1. Prompt for company information (name, product, repositories)
2. Prompt for team members
3. Prompt for product details (capabilities, pricing, terminology)
4. Optionally configure MCP tools (Canny, Zendesk, Gong)
5. Copy skills to your project's `.claude/skills/` directory
6. Copy documentation to your project's `docs/` directory
7. Generate customized `CLAUDE.md` with all your context
8. Update all reference docs with company-specific information

### Manual Install

If you prefer manual installation:

1. **Copy skills**
   ```bash
   cp -r .claude /path/to/your/project/
   ```

2. **Copy documentation**
   ```bash
   cp -r docs /path/to/your/project/
   ```

3. **Customize configuration**
   - Run `./scripts/install.sh /path/to/your/project` and answer the prompts
   - Or manually edit generated `CLAUDE.md` and `docs/reference/` files
   - Update company-specific terminology and standards

4. **Configure MCP tools** (optional but recommended)
   - See [docs/MCP-SETUP.md](docs/MCP-SETUP.md) for Canny, Zendesk, Gong integration
   - Installer prompts for MCP setup during installation

---

## Quick Start

After installation:

1. **Open Claude Code in your project**
   ```bash
   cd /path/to/your/project
   claude
   ```

2. **Try your first PRD**
   ```
   /prd
   ```

3. **Read the onboarding guide**
   - Location: `docs/ONBOARDING.md` (in your project after install)
   - Sequential task-based learning path (11 tasks)
   - Exercises and examples to build proficiency

---

## Documentation

After installation, your project will have:

- **`docs/TOOLKIT-GUIDE.md`** - Comprehensive usage guide
- **`docs/ONBOARDING.md`** - Task-based learning path (11 tasks)
- **`docs/CONFIGURATION-REFERENCE.md`** - Where values are stored and how to update them
- **`docs/reference/`** - Quality standards, UI patterns, workflow integration
- **`docs/templates/`** - GitHub issue templates
- **`CLAUDE.md`** - Claude Code configuration (main config file)

---

## Customization

This toolkit is designed to be customized for your company.

### Where Configuration Values Are Stored

After installation, all your company-specific configuration lives in your project:

**`CLAUDE.md` (main configuration file)**
- Company name, product name, target customers
- Platform capabilities list
- Product/pricing tiers
- Key terminology table
- Repository names
- GitHub integration settings
- PRD quality standards

**`docs/reference/team-directory.md`**
- Team member names, roles, GitHub usernames
- Assignment guidelines

**`docs/reference/`**
- All reference docs updated with your company name and product name
- Quality standards with your examples
- SDLC customized for your process

### During Installation

The installer prompts for and populates:
- Company information (name, product, type, customers, value prop)
- Team members and GitHub usernames
- Platform capabilities (key features)
- Pricing tiers (optional)
- Company-specific terminology (optional)
- MCP tool configuration (Canny, Zendesk, Gong)

### After Installation

To update or add more detail:

1. **Edit `CLAUDE.md` directly** - All sections are clearly marked:
   - Update "Platform Capabilities" list as features are added
   - Add more pricing tiers
   - Add more terminology to the table

2. **Edit `docs/reference/team-directory.md`** - Add/remove team members

3. **Customize reference docs:**
   - `docs/reference/sdlc-overview.md` - Your development process
   - `docs/reference/prd-quality-guide.md` - Add company-specific examples
   - `docs/reference/ui-patterns.md` - Add your product's UI patterns

4. **Customize templates:**
   - `docs/templates/*.md` - GitHub issue templates for your workflow

**Quick Reference:** See `docs/CONFIGURATION-REFERENCE.md` for a quick lookup of where to update specific values

---

## MCP Tool Integration

The toolkit can integrate with external tools via Model Context Protocol (MCP):

- **Figma** - Design file access, code generation, design system
- **Canny** - Feature requests, customer feedback, roadmap prioritization
- **Zendesk** - Support tickets, pain point analysis
- **Gong** - Customer call transcripts, insights

See [docs/MCP-SETUP.md](docs/MCP-SETUP.md) for setup instructions.

---

## Examples

### Writing a PRD

```
You: /prd
Claude: Let's write a PRD. What feature are you looking to scope?
You: User authentication with SSO
Claude: [Guides through 5-phase workflow]
       [Outputs complete PRD with quality checks]
```

### Researching Competitors

```
You: /research-competitors email templates
Claude: [4-phase workflow: Scope → Research → Analysis → Deliverable]
        [Outputs feature comparison matrix and recommendations]
```

### Analyzing Feedback

```
You: /analyze-feedback
Claude: What time frame should I analyze?
You: Last 90 days, focus on authentication features
Claude: [Synthesizes Canny, Zendesk, Gong data]
        [Outputs prioritized feature requests]
```

### Checking PRD Quality

```
You: /qa-prd docs/prds/authentication.md
Claude: Overall Score: 8.5/10 ✅ Ready for Design

        Strengths:
        ✅ Strong problem statement with quantified impact
        ✅ Complete cross-feature integration

        Issues:
        ⚠️ Missing validation rule for email field (Line 145)

        [Detailed recommendations...]
```

---

## Architecture

```
your-project/
├── .claude/
│   └── skills/
│       ├── prd/                          # PRD writing workflow
│       ├── competitive-research/         # Competitor analysis
│       ├── customer-feedback-analysis/   # Feedback synthesis
│       └── requirement-qa/               # Quality checker
├── docs/
│   ├── TOOLKIT-GUIDE.md                 # Comprehensive guide
│   ├── ONBOARDING.md                    # 3-week learning plan
│   ├── reference/                       # Quality standards, patterns
│   └── templates/                       # GitHub issue templates
└── CLAUDE.md                            # Claude Code configuration
```

---

## Updating the Toolkit

To pull latest skills and improvements:

```bash
cd /path/to/ai-pm-toolkit
git pull origin main

# Update your project installation
./scripts/update.sh /path/to/your/project
```

The update script:
- Pulls latest skills
- Preserves your customizations
- Merges new documentation
- Reports changes

---

## Contributing

We welcome contributions! See [CONTRIBUTING.md](CONTRIBUTING.md) for:

- How to report bugs
- Feature requests
- Pull request process
- Coding standards

---

## Version History

- **1.0.0** (2026-01-23) - Initial release
  - PRD Writing skill with 5-phase workflow
  - Competitive Research skill with 4-phase workflow
  - Customer Feedback Analysis skill (multi-source)
  - Requirement QA skill with 6-dimension scoring
  - Comprehensive documentation and onboarding guide

---

## License

[Choose appropriate license - MIT, Apache 2.0, etc.]

---

## Support

- **Documentation:** See `docs/` after installation
- **Issues:** [GitHub Issues](https://github.com/your-org/ai-pm-toolkit/issues)
- **Discussions:** [GitHub Discussions](https://github.com/your-org/ai-pm-toolkit/discussions)

---

## Credits

Created by Abhay Khurana for product management teams.

Built with [Claude Code](https://claude.ai/download) and [Claude API](https://anthropic.com).

---

## FAQ

**Q: Do I need to know how to code?**
A: No! This toolkit is designed for product managers. The AI handles the complexity.

**Q: Can I use this with other AI tools besides Claude?**
A: Currently designed for Claude Code. Other tools may work but aren't officially supported.

**Q: How do I customize for my company?**
A: The installer (`./scripts/install.sh`) handles most customization interactively. After installation, edit the generated `CLAUDE.md` and files in `docs/reference/` to add company-specific details.

**Q: Is my data private?**
A: Skills run locally. Data only goes to Claude API when you invoke skills. MCP tools require API keys for external services.

**Q: Can I use this commercially?**
A: Yes, subject to license terms (to be determined).

**Q: How often is this updated?**
A: Check [CHANGELOG.md](CHANGELOG.md) for release history. Major releases quarterly, minor updates monthly.

---

*Last updated: 2026-01-23 | Version: 1.0.0*
