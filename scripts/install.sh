#!/bin/bash

# AI PM Toolkit Installer
# Interactive installer that copies toolkit to target project and customizes it

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get script directory (where ai-pm-toolkit is located)
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TOOLKIT_DIR="$( cd "$SCRIPT_DIR/.." && pwd )"

echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
echo -e "${BLUE}   AI PM Toolkit Installer v1.0.0${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
echo ""

# Check if target directory provided
if [ -z "$1" ]; then
    echo -e "${YELLOW}Usage: ./scripts/install.sh /path/to/your/project${NC}"
    echo ""
    echo "Example:"
    echo "  ./scripts/install.sh ~/my-company/my-project"
    echo ""
    exit 1
fi

TARGET_DIR="$1"

# Validate target directory
if [ ! -d "$TARGET_DIR" ]; then
    echo -e "${RED}✗ Error: Target directory does not exist: $TARGET_DIR${NC}"
    echo ""
    echo "Create it first:"
    echo "  mkdir -p $TARGET_DIR"
    echo ""
    exit 1
fi

echo -e "${GREEN}✓ Target directory: $TARGET_DIR${NC}"
echo ""

# Check if toolkit already installed
if [ -d "$TARGET_DIR/.claude/skills/prd" ]; then
    echo -e "${YELLOW}⚠ Warning: Toolkit appears to be already installed in this directory${NC}"
    echo ""
    read -p "Do you want to overwrite? (y/N): " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Installation cancelled."
        exit 0
    fi
    echo ""
fi

echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
echo -e "${BLUE}   Step 1: Company Information${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
echo ""
echo "Let's customize the toolkit for your company."
echo ""

# Gather company information
read -p "Company name: " COMPANY_NAME

# Check for Feathr easter egg
if [ "$COMPANY_NAME" = "FeathrEgg" ]; then
    echo ""
    echo -e "${GREEN}═══════════════════════════════════════════════════${NC}"
    echo -e "${GREEN}   🥚 You found the Feathr Egg! 🥚${NC}"
    echo -e "${GREEN}═══════════════════════════════════════════════════${NC}"
    echo ""
    echo "Loading Feathr-specific configuration..."
    echo "Bypassing setup prompts and using pre-configured Feathr context."
    echo ""
    sleep 1

    # Set all Feathr-specific variables
    COMPANY_NAME="Feathr"
    PRODUCT_NAME="Feathr"
    PRODUCT_TYPE="web-based SaaS platform"
    TARGET_CUSTOMERS="nonprofits"
    VALUE_PROP="promote their causes/organizations and increase awareness, engagement, donations, volunteer sign-ups, membership, event registrations"

    # Repositories
    PRIMARY_REPO="shrike"
    BACKEND_REPO="anhinga"
    DESIGN_REPO="golden-goose"

    # Platform capabilities
    PLATFORM_CAPABILITIES="Email marketing, Programmatic/display advertising, Google Search advertising, Meta advertising, Website tracking (Pixl/Pixl Plus), Audience segmentation, Data integrations with nonprofit-focused CRMs (Salesforce NPSP, Blackbaud Raiser's Edge NXT), Donation forms and fundraising (Growth Credits system), Landing pages, Forms"

    # Pricing tiers
    PRICING_TIERS="Feathr Light (\$3,600/year) - requires self-service onboarding, Essential, Advanced"

    # Key terminology
    KEY_TERMINOLOGY="Growth Credits | Universal marketing spend currency (formerly \"Media Credits\"); earned 1:1 from tips
Pixl/Pixl Plus | Website tracking pixel system
Person Record | Feathr's contact/constituent record system
NPSP | Nonprofit Success Pack for Salesforce
RE NXT | Raiser's Edge NXT by Blackbaud
Flight | Individual ad campaign unit within broader campaign
Modal Publishing | Form appears as overlay when link clicked
Express Account | Type of Stripe Connected Account"

    # Team members
    TEAM_MEMBERS="Abhay Khurana | VP Product | abhaykhu
Freddy Wong | Product Manager | freddy-wong-feathr
Andy Weir | Senior Product Designer | andy-weir
Kurtis Schlienger | Senior Director of Engineering | schliengerk
Reese Allison | Associate Director of Platform Engineering | reese-allison
Ryan Emslie | Associate Director of Product Engineering | RyanEmslie
Alex Van Holtz | Principal Software Engineer | vanholtzatwork
Bala Bosch | Principal Software Engineer | moonray
Paul McClelland | Principal Software Engineer | pmcclelland
David Duque | Senior Software Engineer | dvd-rsnw
Omar Lopez | Software Engineer | Omar-L
Andrew Wirtz | Principal Software Engineer | awirtz-feathr
Jeff Wood | Principal Software Engineer | jwoodfeathr
Graham Clark | Senior Software Engineer | gmclark
Thomas Royal | Software Engineer | tmroyal-feathr
Jesse Edwards-Kwabla | Software Engineer | JEdwardsK"

    # Set flag for Feathr mode
    FEATHR_MODE="yes"

    echo -e "${GREEN}✓ Feathr configuration loaded${NC}"
    echo ""

    # Skip to MCP setup
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}   Step 2: Customer Feedback Sources${NC}"
else
    # Normal flow - continue with prompts
    read -p "Product name: " PRODUCT_NAME
    read -p "Product type (e.g., 'SaaS platform', 'mobile app'): " PRODUCT_TYPE
    read -p "Target customers (e.g., 'nonprofits', 'small businesses'): " TARGET_CUSTOMERS
    read -p "Primary value proposition: " VALUE_PROP

    echo ""
    read -p "Primary repository name (e.g., 'frontend', 'main'): " PRIMARY_REPO
    read -p "Backend repository name (optional, press enter to skip): " BACKEND_REPO
    read -p "Design repository name (optional, press enter to skip): " DESIGN_REPO

    echo ""
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}   Step 2: Team Information${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo ""
    echo "Enter key team members (press Ctrl+D when done):"
    echo "Format: Name | Role | GitHub Username"
    echo "Example: John Doe | VP Product | johndoe"
    echo ""

    TEAM_MEMBERS=""
    while IFS= read -r line; do
        TEAM_MEMBERS="$TEAM_MEMBERS$line\n"
    done

    echo ""
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}   Step 3: Product Details${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo ""
    echo "Let's gather key product information for better PRD context."
    echo ""

    # Platform capabilities
    echo "List your platform's key capabilities (comma-separated):"
    echo "Examples: 'Email marketing, Landing pages, Analytics' or 'Task management, Time tracking, Reporting'"
    read -p "Key capabilities: " PLATFORM_CAPABILITIES

    echo ""

    # Pricing tiers (optional)
    echo "Do you have pricing tiers? (y/N)"
    read -p "> " -n 1 -r HAS_PRICING_TIERS
    echo ""

    PRICING_TIERS=""
    if [[ $HAS_PRICING_TIERS =~ ^[Yy]$ ]]; then
        echo "List your pricing tiers (comma-separated):"
        echo "Examples: 'Free, Pro ($49/mo), Enterprise' or 'Starter, Growth, Enterprise'"
        read -p "Pricing tiers: " PRICING_TIERS
        echo ""
    fi

    # Key terminology
    echo "Any company-specific terms to document? (press Enter to skip)"
    echo "Format: Term | Definition (one per line, Ctrl+D when done)"
    echo "Example: Growth Credits | Universal currency for marketing spend"
    echo ""

    KEY_TERMINOLOGY=""
    while IFS= read -r line; do
        if [ -n "$line" ]; then
            KEY_TERMINOLOGY="$KEY_TERMINOLOGY$line\n"
        fi
    done

    echo ""
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}   Step 4: Customer Feedback Sources${NC}"
fi

# MCP Setup Section - different messaging for Feathr mode
if [ "$FEATHR_MODE" = "yes" ]; then
    echo ""
    echo "🎉 You're almost there! You now have a powerful AI PM Toolkit with"
    echo "   detailed Feathr context at your fingertips."
    echo ""
    echo "To power the Customer Feedback Analysis skill, you'll need to configure"
    echo "MCP servers for Feathr's customer feedback sources."
    echo ""
    echo "💡 You can skip this by pressing 'n' if you don't need feedback analysis."
    echo ""
else
    echo "The Customer Feedback Analysis skill (/analyze-feedback) needs access"
    echo "to your feedback sources. This requires MCP (Model Context Protocol) setup."
    echo ""
    echo "Where does your customer feedback live?"
    echo ""
fi

# Canny
read -p "Do you use Canny for feature requests? (y/N): " -n 1 -r USE_CANNY
echo ""
NEEDS_MCP_SETUP="no"
if [[ $USE_CANNY =~ ^[Yy]$ ]]; then
    echo -e "${GREEN}✓ Canny selected${NC}"
    NEEDS_MCP_SETUP="yes"
fi

# Zendesk
read -p "Do you use Zendesk for support tickets? (y/N): " -n 1 -r USE_ZENDESK
echo ""
if [[ $USE_ZENDESK =~ ^[Yy]$ ]]; then
    echo -e "${GREEN}✓ Zendesk selected${NC}"
    NEEDS_MCP_SETUP="yes"
fi

# Gong
read -p "Do you use Gong for call recordings? (y/N): " -n 1 -r USE_GONG
echo ""
if [[ $USE_GONG =~ ^[Yy]$ ]]; then
    echo -e "${GREEN}✓ Gong selected${NC}"
    NEEDS_MCP_SETUP="yes"
fi

# Planhat
read -p "Do you use Planhat for customer success? (y/N): " -n 1 -r USE_PLANHAT
echo ""
if [[ $USE_PLANHAT =~ ^[Yy]$ ]]; then
    echo -e "${GREEN}✓ Planhat selected${NC}"
    NEEDS_MCP_SETUP="yes"
fi

echo ""

# MCP Setup - Inline if needed
if [ "$NEEDS_MCP_SETUP" = "yes" ]; then
    echo -e "${YELLOW}═══════════════════════════════════════════════════${NC}"
    echo -e "${YELLOW}   MCP Server Setup${NC}"
    echo -e "${YELLOW}═══════════════════════════════════════════════════${NC}"
    echo ""
    echo "Let's configure MCP servers for your feedback tools."
    echo ""

    # Canny Setup
    if [[ $USE_CANNY =~ ^[Yy]$ ]]; then
        echo -e "${BLUE}Configuring Canny...${NC}"
        echo ""
        echo "To get your Canny API key:"
        echo "  1. Go to: https://canny.io"
        echo "  2. Navigate to Settings → API & Webhooks"
        echo "  3. Copy your API Key"
        echo ""
        read -p "Enter your Canny API key (or press Enter to skip): " CANNY_API_KEY

        if [ -n "$CANNY_API_KEY" ]; then
            echo ""
            echo "Configuring Canny MCP server..."

            # Create or update MCP config
            MCP_CONFIG_FILE="$HOME/.claude/mcp_settings.json"

            if [ ! -f "$MCP_CONFIG_FILE" ]; then
                mkdir -p "$HOME/.claude"
                cat > "$MCP_CONFIG_FILE" << MCPEOF
{
  "mcpServers": {
    "canny": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-server-canny"],
      "env": {
        "CANNY_API_KEY": "$CANNY_API_KEY"
      }
    }
  }
}
MCPEOF
            else
                # Merge with existing config (basic approach - adds to end)
                # Note: This is simplified - in production would use jq for proper JSON merging
                echo "  Note: MCP config already exists. Please manually add Canny to: $MCP_CONFIG_FILE"
                echo "  API Key: $CANNY_API_KEY"
            fi

            echo -e "${GREEN}✓ Canny API key saved${NC}"
        else
            echo -e "${YELLOW}⚠ Skipped - you can configure this later${NC}"
        fi
        echo ""
    fi

    # Zendesk Setup
    if [[ $USE_ZENDESK =~ ^[Yy]$ ]]; then
        echo -e "${BLUE}Configuring Zendesk...${NC}"
        echo ""
        echo "To get your Zendesk API credentials:"
        echo "  1. Go to: https://yourcompany.zendesk.com/agent/admin/api/settings"
        echo "  2. Enable Token Access"
        echo "  3. Create a new API token"
        echo ""
        read -p "Enter your Zendesk subdomain (e.g., 'acme' for acme.zendesk.com): " ZENDESK_SUBDOMAIN
        read -p "Enter your Zendesk email: " ZENDESK_EMAIL
        read -p "Enter your Zendesk API token (or press Enter to skip): " ZENDESK_TOKEN

        if [ -n "$ZENDESK_TOKEN" ]; then
            echo ""
            echo "Configuring Zendesk MCP server..."
            echo "  Note: Please manually add to: $HOME/.claude/mcp_settings.json"
            echo "  Subdomain: $ZENDESK_SUBDOMAIN"
            echo "  Email: $ZENDESK_EMAIL"
            echo "  Token: $ZENDESK_TOKEN"
            echo -e "${GREEN}✓ Zendesk credentials collected${NC}"
        else
            echo -e "${YELLOW}⚠ Skipped - you can configure this later${NC}"
        fi
        echo ""
    fi

    # Gong Setup
    if [[ $USE_GONG =~ ^[Yy]$ ]]; then
        echo -e "${BLUE}Configuring Gong...${NC}"
        echo ""
        echo "To get your Gong API credentials:"
        echo "  1. Go to: https://app.gong.io"
        echo "  2. Navigate to Settings → Ecosystem → API"
        echo "  3. Create a new Access Key"
        echo ""
        read -p "Enter your Gong Access Key (or press Enter to skip): " GONG_ACCESS_KEY
        read -p "Enter your Gong Access Key Secret (or press Enter to skip): " GONG_SECRET

        if [ -n "$GONG_ACCESS_KEY" ]; then
            echo ""
            echo "Configuring Gong MCP server..."
            echo "  Note: Please manually add to: $HOME/.claude/mcp_settings.json"
            echo "  Access Key: $GONG_ACCESS_KEY"
            echo "  Secret: $GONG_SECRET"
            echo -e "${GREEN}✓ Gong credentials collected${NC}"
        else
            echo -e "${YELLOW}⚠ Skipped - you can configure this later${NC}"
        fi
        echo ""
    fi

    # Planhat Setup
    if [[ $USE_PLANHAT =~ ^[Yy]$ ]]; then
        echo -e "${BLUE}Configuring Planhat...${NC}"
        echo ""
        echo "To get your Planhat API token:"
        echo "  1. Go to: https://app.planhat.com"
        echo "  2. Navigate to App Center → + New app → + Private app"
        echo "  3. Set permissions for the data you need access to"
        echo "  4. Generate API token (copy it - only shown once!)"
        echo ""
        read -p "Enter your Planhat API Token (or press Enter to skip): " PLANHAT_API_TOKEN

        if [ -n "$PLANHAT_API_TOKEN" ]; then
            echo ""
            echo "Configuring Planhat MCP server..."
            echo "  Note: Add to your MCP config file with this format:"
            echo "  \"planhat\": {"
            echo "    \"url\": \"https://api.planhat.com/v1/mcp\","
            echo "    \"headers\": {"
            echo "      \"Authorization\": \"Bearer $PLANHAT_API_TOKEN\""
            echo "    }"
            echo "  }"
            echo -e "${GREEN}✓ Planhat token collected${NC}"
        else
            echo -e "${YELLOW}⚠ Skipped - you can configure this later${NC}"
        fi
        echo ""
    fi

    echo -e "${YELLOW}MCP setup complete!${NC}"
    echo "For detailed troubleshooting, see: $TARGET_DIR/docs/MCP-SETUP.md"
    echo ""
    read -p "Press Enter to continue with installation..."
    echo ""
else
    echo -e "${YELLOW}⚠ No feedback sources selected${NC}"
    echo ""
    echo "The /analyze-feedback skill won't work without at least one source."
    echo "You can set this up later by following: docs/MCP-SETUP.md"
    echo ""
    read -p "Press Enter to continue anyway..."
    echo ""
fi

echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
echo -e "${BLUE}   Step 5: Copying Files${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
echo ""

# Create directories
echo -e "${YELLOW}Creating directories...${NC}"
mkdir -p "$TARGET_DIR/.claude/skills"
mkdir -p "$TARGET_DIR/docs/reference"
mkdir -p "$TARGET_DIR/docs/templates"
mkdir -p "$TARGET_DIR/docs/prds"
mkdir -p "$TARGET_DIR/docs/feedback-analysis"
mkdir -p "$TARGET_DIR/docs/research"

# Copy skills
echo -e "${YELLOW}Copying skills...${NC}"
cp -r "$TOOLKIT_DIR/.claude/skills/"* "$TARGET_DIR/.claude/skills/"

# Copy documentation
echo -e "${YELLOW}Copying documentation...${NC}"
cp -r "$TOOLKIT_DIR/docs/reference/"* "$TARGET_DIR/docs/reference/"
cp -r "$TOOLKIT_DIR/docs/templates/"* "$TARGET_DIR/docs/templates/"
cp "$TOOLKIT_DIR/docs/TOOLKIT-GUIDE.md" "$TARGET_DIR/docs/"
cp "$TOOLKIT_DIR/docs/ONBOARDING.md" "$TARGET_DIR/docs/"
cp "$TOOLKIT_DIR/docs/CONFIGURATION-REFERENCE.md" "$TARGET_DIR/docs/"
cp "$TOOLKIT_DIR/docs/README.md" "$TARGET_DIR/docs/"

# Copy MCP setup guide if exists
if [ -f "$TOOLKIT_DIR/docs/MCP-SETUP.md" ]; then
    cp "$TOOLKIT_DIR/docs/MCP-SETUP.md" "$TARGET_DIR/docs/"
fi

# Copy Feathr-specific reference docs if in Feathr mode
if [ "$FEATHR_MODE" = "yes" ]; then
    echo -e "${YELLOW}Copying Feathr-specific reference documentation...${NC}"
    cp "$TOOLKIT_DIR/feathr-specific/reference/usability-components.md" "$TARGET_DIR/docs/reference/"
    cp "$TOOLKIT_DIR/feathr-specific/reference/sdlc-overview.md" "$TARGET_DIR/docs/reference/"
    cp "$TOOLKIT_DIR/feathr-specific/reference/team-directory.md" "$TARGET_DIR/docs/reference/"
    cp "$TOOLKIT_DIR/feathr-specific/reference/ui-patterns.md" "$TARGET_DIR/docs/reference/"
    echo -e "${GREEN}✓ Feathr-specific docs copied${NC}"
fi

echo -e "${GREEN}✓ Files copied${NC}"
echo ""

echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
echo -e "${BLUE}   Step 6: Generating Configuration${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
echo ""
echo -e "${YELLOW}Generating customized CLAUDE.md...${NC}"

# Generate CLAUDE.md from template (using proper variable expansion)
cat > "$TARGET_DIR/CLAUDE.md" <<EOF
# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

> **IMPORTANT: Product Manager Context**
>
> The primary user of this workspace is a product manager, not a developer. I do NOT intend to edit, modify, or execute any code. I use this codebase solely as a reference to:
> - Understand how features are implemented
> - Analyze product behavior and architecture
> - Inform PRDs, specs, and research documents
> - Answer questions about current functionality
>
> When I ask questions, prioritize explanations over code changes. Help me understand *what* the code does and *why*, rather than suggesting modifications.

---

## Repository Overview

This is ${COMPANY_NAME}'s development repository for ${PRODUCT_NAME}.

**Primary Repository:** ${PRIMARY_REPO}
EOF

if [ -n "$BACKEND_REPO" ]; then
    echo "**Backend Repository:** ${BACKEND_REPO}" >> "$TARGET_DIR/CLAUDE.md"
fi

if [ -n "$DESIGN_REPO" ]; then
    echo "**Design Repository:** ${DESIGN_REPO}" >> "$TARGET_DIR/CLAUDE.md"
fi

cat >> "$TARGET_DIR/CLAUDE.md" <<EOF

---

## Product Context

### About ${COMPANY_NAME}

${COMPANY_NAME} is a ${PRODUCT_TYPE} built to help ${TARGET_CUSTOMERS} ${VALUE_PROP}.

**Platform Capabilities:**
${PLATFORM_CAPABILITIES}

**Customers:**
${TARGET_CUSTOMERS}

**Product Tiers:**
EOF

if [ -n "$PRICING_TIERS" ]; then
    echo "${PRICING_TIERS}" >> "$TARGET_DIR/CLAUDE.md"
else
    echo "[Add pricing tiers if applicable]" >> "$TARGET_DIR/CLAUDE.md"
fi

cat >> "$TARGET_DIR/CLAUDE.md" <<EOF

---

## PM Toolkit Overview

The PM Toolkit provides AI-powered tools for product management work. See **[docs/TOOLKIT-GUIDE.md](docs/TOOLKIT-GUIDE.md)** for comprehensive usage guide.

### Available Skills

| Skill | Command | When to Use |
|-------|---------|-------------|
| Scoping | \`/scope\` | Scoping features, writing requirements, creating GitHub issues |
| Competitive Research | \`/research-competitors\` | Research competitors, UX patterns, feature gaps |
| Feedback Analysis | \`/analyze-feedback\` | Research customer feedback, understand pain points, validate PRD assumptions |
| Quality Assurance | \`/qa-prd\` | Review PRD quality before design handoff |

### Reference Documentation

All reference documentation is in **[docs/reference/](docs/reference/)**:

- **[prd-quality-guide.md](docs/reference/prd-quality-guide.md)** - Quality standards, examples, antipatterns
- **[workflow-integration.md](docs/reference/workflow-integration.md)** - Platform integration principles
- **[ui-patterns.md](docs/reference/ui-patterns.md)** - Common UI patterns
- **[sdlc-overview.md](docs/reference/sdlc-overview.md)** - Development lifecycle
- **[team-directory.md](docs/reference/team-directory.md)** - Team members and GitHub usernames

### Issue Templates

All GitHub issue templates are in **[docs/templates/](docs/templates/)**

---

## Skill Invocation Rules

When the user's request matches these patterns, **proactively invoke the corresponding skill**:

### Scoping

**Auto-invoke \`/scope\` when user says:**
- "Help me scope [feature]"
- "Write a PRD for [feature]"
- "Document requirements for [feature]"
- "Create a feature spec for [feature]"

### Competitive Research

**Auto-invoke \`/research-competitors\` when user says:**
- "Research competitors for [feature]"
- "What do competitors offer for [feature]"
- "How does [competitor] handle [feature]"
- "Industry best practices for [feature]"

### Feedback Analysis

**Auto-invoke \`/analyze-feedback\` when user says:**
- "Analyze customer feedback"
- "What are customers saying about [topic]"
- "Research feature requests"
- "Review recent feedback"

### PRD Quality Assurance

**Auto-invoke \`/qa-prd\` when user says:**
- "Review this PRD for quality"
- "Check if this PRD meets quality standards"
- "QA this PRD before design handoff"
- "Score this PRD"

---

## GitHub Integration

### Repository Configuration

| Repository | Description | Default for |
|------------|-------------|-------------|
| **${PRIMARY_REPO}** | Primary repository | Most issues |
EOF

if [ -n "$BACKEND_REPO" ]; then
    echo "| **${BACKEND_REPO}** | Backend repository | Backend-specific issues |" >> "$TARGET_DIR/CLAUDE.md"
fi

if [ -n "$DESIGN_REPO" ]; then
    echo "| **${DESIGN_REPO}** | Design repository | Design tasks |" >> "$TARGET_DIR/CLAUDE.md"
fi

cat >> "$TARGET_DIR/CLAUDE.md" <<'EOF'

### Issue Creation Rules

1. **Always provide issue summaries** including: URL, issue name, assignee, project name and status
2. **Don't add labels unless specifically instructed**
3. **Precede comments with "From Claude:"**
4. **Don't include H1 title in issue body** - only in the title field
5. **Always paste issue link in response** after creating/updating issues

### Template Selection Logic

- **Epic** - Large initiative with multiple features
- **Feature** - Specific functionality chunk, requires design
- **Task** - Individual dev work unit, no design needed
- **Bug** - Something broken that needs fixing
- **Discovery** - Research before scoping

---

## User Story Writing Guidelines

**Core Principle:** Organize by workflow context.

### DO: Separate Workflow Contexts

- **In-app builder/configuration** → separate story
- **User-facing/public-facing** → separate story
- **Data syncing/backend operations** → separate story
- **Admin/reporting** → separate story

### DON'T: Mix Workflow Contexts

❌ **Bad:** Single story with builder UI + user experience + backend sync
✅ **Good:** Three separate stories, one per workflow context

### User vs System Requirements

**In each user story:**
- **User Requirements** (requires design) - UI, interactions, user-facing behavior
- **System Requirements** (no design needed) - Validation, data processing, backend logic

**System-only stories:** Prefix with `⚙️ [SYS]` when story contains ONLY system requirements.

**See:** [docs/reference/prd-quality-guide.md](docs/reference/prd-quality-guide.md) for detailed examples.

---

## PRD Quality Standards

Before presenting any PRD to the user or moving to design phase, validate against these standards:

### Problem Statement Quality

**Must answer 4 questions:**
1. Who's struggling? (specific persona)
2. What are they trying to accomplish? (workflow/outcome)
3. What's going wrong? (not just "feature doesn't exist")
4. What's the quantifiable impact? (revenue, time, metrics, customer count)

### Cross-Feature Integration Quality

**Must systematically evaluate relevant integration areas:**
- User/customer records
- Segmentation & targeting (if applicable)
- Reporting & analytics
- Billing & credits (if applicable)
- External integrations (CRM, payment systems, etc.)
- Campaign/workflow touchpoints
- Other platform features

**Remove empty sections entirely.** Don't include "N/A" placeholders.

### Usability Component Quality

**Must specify for all user requirements:**
- Success states (modal, banner, or toast)
- Error handling (validation rules, error messages, recovery paths)
- Progress indicators (for multi-step flows)
- Confirmations (for destructive actions)
- Form validation (help text, validation rules)

### Workflow Integration Quality

**Apply workflow patterns where applicable:**
1. **Auto-Generation** - What data auto-creates, when, naming convention
2. **Attribution Visibility** - Show upstream sources and downstream outcomes
3. **Workflow Shortcuts** - Provide shortcuts and next-step guidance

---

## Key Terminology

EOF

if [ -n "$KEY_TERMINOLOGY" ]; then
    echo "| Term | Definition |" >> "$TARGET_DIR/CLAUDE.md"
    echo "|------|------------|" >> "$TARGET_DIR/CLAUDE.md"
    echo -e "$KEY_TERMINOLOGY" | while IFS='|' read -r term definition; do
        if [ -n "$term" ]; then
            echo "| ${term} | ${definition} |" >> "$TARGET_DIR/CLAUDE.md"
        fi
    done
else
    echo "[Add company-specific terminology as needed]" >> "$TARGET_DIR/CLAUDE.md"
    echo "" >> "$TARGET_DIR/CLAUDE.md"
    echo "Example format:" >> "$TARGET_DIR/CLAUDE.md"
    echo "| Term | Definition |" >> "$TARGET_DIR/CLAUDE.md"
    echo "|------|------------|" >> "$TARGET_DIR/CLAUDE.md"
    echo "| Your Term | What it means |" >> "$TARGET_DIR/CLAUDE.md"
fi

# Add Feathr-specific sections if in Feathr mode
if [ "$FEATHR_MODE" = "yes" ]; then
    cat >> "$TARGET_DIR/CLAUDE.md" <<'FEATHREOF'

---

## Repository Overview (Extended)

This is Feathr's multi-project development directory containing three main codebases:

| Project | Description | Stack | Local URL |
|---------|-------------|-------|-----------|
| **shrike/** | Main application frontend | React 18, TypeScript, MobX, Mantine v7, CSS Modules | https://local.feathr.app:9001 |
| **golden-goose/** | Fundraising frontend (donation forms) | React 19, TypeScript, Vite, Zustand, Tailwind v4 | https://local.feathr.app:9007 |
| **anhinga/** | Backend API | Flask, MongoDB, Docker | https://local.feathr.app:8000 |

Each project has its own `CLAUDE.md` with detailed commands and architecture. Refer to those for project-specific guidance.

---

## Reference Documentation (Extended)

In addition to the standard reference docs, Feathr includes:

- **[usability-components.md](docs/reference/usability-components.md)** - Comprehensive UI component usage rules for Feathr's Mantine v7 components (success modals, progress indicators, error handling, form components, navigation, onboarding, data display, mobile patterns)

This document is critical for writing PRDs with proper usability specifications.

---

## GitHub Integration (Extended)

### GitHub Projects

| Project Name | ID | Purpose | Managed By |
|--------------|-----|---------|------------|
| **Product & Design** | 26 | Product and design workflows | Abhay, Freddy, Andy |
| **Ads** | 42 | Ads product area | Andrew, Alex, Jesse, Omar, Sara, Paul |
| **Fundraising** | 48 | Fundraising product area | Lucas, Otis, Tristan, David, Jeff, Thomas Royal |
| **Roadmap** | 51 | High-level roadmap planning | Occasional use |

### Issue Creation Rules (Extended)

1. **Always assign design task issues to andy-weir**
2. **Always provide issue summaries** including: URL, issue name, assignee, project name and status
3. **Don't add labels unless specifically instructed**
4. **Precede comments with "From Claude:"**
5. **Don't include H1 title in issue body** - only in the title field
6. **Always paste issue link in response** after creating/updating issues

### Assignment Guidelines by Product Area

**Design Phase Issues:**
- Assign to: andy-weir
- Add to: Product & Design (Project ID: 26)

**Ads Pod Issues:**
- Assign based on pod triage
- Add to: Ads (Project ID: 42)
- Pod: Andrew, Alex, Jesse, Omar, Sara, Paul

**Fundraising Pod Issues:**
- Assign based on pod triage
- Add to: Fundraising (Project ID: 48)
- Pod: Lucas, Otis, Tristan, David, Jeff, Thomas Royal

**Roadmap Planning:**
- Add to: Roadmap (Project ID: 51)
- Use for high-level strategic work

### Issue Title Prefixes

Use these prefixes to categorize issues:
- `[Fundraising]` - Fundraising platform issues
- `[Pixl+]` - Pixl Plus advertising issues
- `[Email]` - Email campaign issues

---

## User Story Writing Guidelines (Extended)

**Core Principle:** Organize by workflow context because Andy translates user stories into Figma screens showing linear workflows.

### DO: Separate Workflow Contexts

- **In-app builder/configuration** → separate story
- **Donor-facing/public-facing** → separate story
- **Data syncing/backend operations** → separate story
- **Admin/reporting** → separate story

### DON'T: Mix Workflow Contexts

❌ **Bad:** Single story with builder UI + donor experience + backend sync
✅ **Good:** Three separate stories, one per workflow context

### User vs System Requirements

**In each user story:**
- **User Requirements** (requires design) - UI, interactions, user-facing behavior
- **System Requirements** (no design needed) - Validation, data processing, backend logic

**System-only stories:** Prefix with `⚙️ [SYS]` when story contains ONLY system requirements.

**See:** [docs/reference/prd-quality-guide.md](docs/reference/prd-quality-guide.md) for detailed examples and antipatterns.

---

## Issue Rescoping Instructions

### Mode 1: Rescope and Overwrite

**Command:** "Rescope and overwrite"

Completely replace issue content with new scoping, ignoring previous content.

**Use when:**
- Original scope is outdated or incorrect
- Requirements have fundamentally changed
- Starting fresh is clearer

**Process:**
1. Read existing issue
2. Gather new requirements
3. Follow standard template
4. Replace entire issue body
5. Post comment: "From Claude: Issue rescoped with new requirements (previous content overwritten)"

### Mode 2: Rescope and Retain

**Command:** "Rescope and retain"

Update issue while preserving original content using strikethrough for replaced text and bold for additions.

**Use when:**
- Tracking evolution is valuable
- Multiple stakeholders need to see changes
- **Issues in design phase** - critical for Andy to reconcile Figma designs with new requirements

**Markdown syntax:**
- Strikethrough removed content: `~~old content~~`
- Bold new content: `**new content**`
- **Striking through entire user stories**: When removing an entire user story, format as: `~~<details><summary>~~Story title~~</summary>~~` with double tildes outside details tag, inside summary tag, and outside closing summary tag

**Process:**
1. Read existing issue
2. Gather new requirements
3. Apply markdown changes
4. Update issue body
5. Post comment: "From Claude: Issue rescoped with tracked changes (strikethrough = removed, bold = added)"

---

## Copywriting Guidelines

### Nonprofit-Specific Language

| Use | Instead of |
|-----|------------|
| supporters | customers |
| donors | users (when appropriate) |
| campaigns | projects |
| impact, mission | generic business terms |

### Patterns by Context

- **Onboarding:** "Let's" and "We'll" to create partnership feeling
- **Form Fields:** Include format requirements, explain why info is needed
- **Buttons:** Action verb + specific object (e.g., "Create my first campaign")
- **Errors:** What went wrong → Why → Next steps
- **Success:** Lead with celebration → Confirm action → Set expectations

---

FEATHREOF
fi

cat >> "$TARGET_DIR/CLAUDE.md" <<'EOF'

---

## Working Preferences

### Issue Writing
- Write issues first without creating in GitHub; create separately if requested
- Issues are for PM/Designer consumption, not engineers
- Don't include implementation/technical details
- Don't include H1 title in issue body

### Communication
- Ask follow-up questions when more information is needed
- Always paste issue links after creating/updating in GitHub
- Precede GitHub comments with "From Claude:"

---

EOF

echo "*Last updated: $(date +%Y-%m-%d)*" >> "$TARGET_DIR/CLAUDE.md"
echo "*See [docs/TOOLKIT-GUIDE.md](docs/TOOLKIT-GUIDE.md) for comprehensive toolkit documentation.*" >> "$TARGET_DIR/CLAUDE.md"

echo -e "${GREEN}✓ CLAUDE.md created${NC}"
echo ""

# Update team directory template
if [ -n "$TEAM_MEMBERS" ]; then
    echo -e "${YELLOW}Updating team directory...${NC}"

    if [ "$FEATHR_MODE" = "yes" ]; then
        # Feathr-specific team directory with pod structure
        cat > "$TARGET_DIR/docs/reference/team-directory.md" <<EOF
---
audience: All team members
when_to_use: Assigning GitHub issues, tagging collaborators, understanding team structure
related_docs: sdlc-overview.md
last_updated: $(date +%Y-%m-%d)
---

# ${COMPANY_NAME} Team Directory

## Product & Design

| Name | Role | GitHub Username |
|------|------|-----------------|
| Abhay Khurana | VP Product | abhaykhu |
| Freddy Wong | Product Manager | freddy-wong-feathr |
| Andy Weir | Senior Product Designer | andy-weir |

## Engineering Leadership

| Name | Role | GitHub Username |
|------|------|-----------------|
| Kurtis Schlienger | Senior Director of Engineering | schliengerk |
| Reese Allison | Associate Director of Platform Engineering | reese-allison |
| Ryan Emslie | Associate Director of Product Engineering | RyanEmslie |

## Ads Pod

| Name | Role | GitHub Username |
|------|------|-----------------|
| Andrew Wirtz | Principal Software Engineer | awirtz-feathr |
| Alex Van Holtz | Principal Software Engineer | vanholtzatwork |
| Jesse Edwards-Kwabla | Software Engineer | JEdwardsK |
| Omar Lopez | Software Engineer | Omar-L |
| Sara [Last Name] | [Role] | [GitHub Username] |
| Paul McClelland | Principal Software Engineer | pmcclelland |

## Fundraising Pod

| Name | Role | GitHub Username |
|------|------|-----------------|
| Lucas [Last Name] | [Role] | [GitHub Username] |
| Otis [Last Name] | [Role] | [GitHub Username] |
| Tristan [Last Name] | [Role] | [GitHub Username] |
| David Duque | Senior Software Engineer | dvd-rsnw |
| Jeff Wood | Principal Software Engineer | jwoodfeathr |
| Thomas Royal | Software Engineer | tmroyal-feathr |

## Other Engineers

| Name | Role | GitHub Username |
|------|------|-----------------|
| Bala Bosch | Principal Software Engineer | moonray |
| Graham Clark | Senior Software Engineer | gmclark |

---

## Assignment Guidelines

### Design Phase Issues
- **Always assign to andy-weir** for design tasks
- Add to "Product & Design" project (ID: 26)

### Ads Pod Issues
- Assign to Ads pod engineers for triage
- Add to "Ads" project (ID: 42)
- Pod: Andrew, Alex, Jesse, Omar, Sara, Paul

### Fundraising Pod Issues
- Assign to Fundraising pod engineers for triage
- Add to "Fundraising" project (ID: 48)
- Pod: Lucas, Otis, Tristan, David, Jeff, Thomas Royal

### Roadmap Planning
- High-level strategic work
- Add to "Roadmap" project (ID: 51)
- Use occasionally for long-term planning

### Backend Issues
- Create in \`anhinga\` repository
- Assign based on pod ownership (Ads vs Fundraising)

### Full-Stack Features
- Create epic in appropriate frontend repo (\`shrike\` or \`golden-goose\`)
- Create linked issues in both repos if needed
- Coordinate with pod leads and engineering leadership

---

## GitHub Projects

| Project Name | ID | Purpose | Managed By |
|--------------|-----|---------|------------|
| **Product & Design** | 26 | Product and design workflows | Abhay, Freddy, Andy |
| **Ads** | 42 | Ads product area | Andrew, Alex, Jesse, Omar, Sara, Paul |
| **Fundraising** | 48 | Fundraising product area | Lucas, Otis, Tristan, David, Jeff, Thomas Royal |
| **Roadmap** | 51 | High-level roadmap planning | Occasional use |

---

*Last updated: $(date +%Y-%m-%d)*
EOF
    else
        # Generic team directory template
        cat > "$TARGET_DIR/docs/reference/team-directory.md" <<EOF
---
audience: All team members
when_to_use: Assigning GitHub issues, tagging collaborators, understanding team structure
related_docs: sdlc-overview.md
last_updated: $(date +%Y-%m-%d)
---

# ${COMPANY_NAME} Team Directory

## Team Members

$TEAM_MEMBERS

---

## Assignment Guidelines

**Design Phase Issues:**
- Assign to: [Design lead from team list above]
- Add to: [Design project]

**Frontend Issues:**
- Assign to: [Frontend lead from team list above]
- Add to: [Main project]

**Backend Issues:**
- Assign to: [Backend lead from team list above]
- Add to: [Main project]

---

*Last updated: $(date +%Y-%m-%d)*
EOF
    fi

    echo -e "${GREEN}✓ Team directory updated${NC}"
fi

echo ""

# Only customize reference docs for non-Feathr installations
# Feathr-specific docs are already properly configured
if [ "$FEATHR_MODE" != "yes" ]; then
    # Update SDLC overview with company context
    echo -e "${YELLOW}Updating SDLC overview...${NC}"
    sed -i.bak "s/PLACEHOLDER_DATE/$(date +%Y-%m-%d)/g" "$TARGET_DIR/docs/reference/sdlc-overview.md"
    sed -i.bak "s/your company's/$COMPANY_NAME's/g" "$TARGET_DIR/docs/reference/sdlc-overview.md"
    sed -i.bak "s/TODO: Customize this section with your company's actual process/Customize this section with $COMPANY_NAME's actual process/g" "$TARGET_DIR/docs/reference/sdlc-overview.md"
    rm -f "$TARGET_DIR/docs/reference/sdlc-overview.md.bak"
    echo -e "${GREEN}✓ SDLC overview updated${NC}"

    # Update UI patterns with company context
    echo -e "${YELLOW}Updating UI patterns guide...${NC}"
    sed -i.bak "s/PLACEHOLDER_DATE/$(date +%Y-%m-%d)/g" "$TARGET_DIR/docs/reference/ui-patterns.md"
    sed -i.bak "s/your product's/$COMPANY_NAME's/g" "$TARGET_DIR/docs/reference/ui-patterns.md"
    rm -f "$TARGET_DIR/docs/reference/ui-patterns.md.bak"
    echo -e "${GREEN}✓ UI patterns updated${NC}"

    # Update prd-quality-guide with company context
    echo -e "${YELLOW}Updating PRD quality guide...${NC}"
    # Replace any Feathr-specific references with generic or company name
    sed -i.bak "s/Feathr/$PRODUCT_NAME/g" "$TARGET_DIR/docs/reference/prd-quality-guide.md"
    sed -i.bak "s/$PRODUCT_NAME's/$COMPANY_NAME's/g" "$TARGET_DIR/docs/reference/prd-quality-guide.md"
    # Update customers reference if present
    sed -i.bak "s/nonprofits/$TARGET_CUSTOMERS/g" "$TARGET_DIR/docs/reference/prd-quality-guide.md"
    sed -i.bak "s/donors/$TARGET_CUSTOMERS/g" "$TARGET_DIR/docs/reference/prd-quality-guide.md"
    sed -i.bak "s/Fundraising managers/[User role] at $TARGET_CUSTOMERS/g" "$TARGET_DIR/docs/reference/prd-quality-guide.md"
    sed -i.bak "s/recurring donation/[example feature]/g" "$TARGET_DIR/docs/reference/prd-quality-guide.md"
    sed -i.bak "s/Stripe subscription data/[external system data]/g" "$TARGET_DIR/docs/reference/prd-quality-guide.md"
    sed -i.bak "s/Salesforce NPSP or RE NXT/[your CRM system]/g" "$TARGET_DIR/docs/reference/prd-quality-guide.md"
    sed -i.bak "s/form builder/[feature context]/g" "$TARGET_DIR/docs/reference/prd-quality-guide.md"
    rm -f "$TARGET_DIR/docs/reference/prd-quality-guide.md.bak"
    echo -e "${GREEN}✓ PRD quality guide updated${NC}"

    # Update workflow-integration with company context
    echo -e "${YELLOW}Updating workflow integration guide...${NC}"
    sed -i.bak "s/Feathr/$PRODUCT_NAME/g" "$TARGET_DIR/docs/reference/workflow-integration.md"
    sed -i.bak "s/$PRODUCT_NAME's/$COMPANY_NAME's/g" "$TARGET_DIR/docs/reference/workflow-integration.md"
    sed -i.bak "s/nonprofits/$TARGET_CUSTOMERS/g" "$TARGET_DIR/docs/reference/workflow-integration.md"
    sed -i.bak "s/Donation data/Customer data/g" "$TARGET_DIR/docs/reference/workflow-integration.md"
    sed -i.bak "s/donation/transaction/g" "$TARGET_DIR/docs/reference/workflow-integration.md"
    sed -i.bak "s/donor/customer/g" "$TARGET_DIR/docs/reference/workflow-integration.md"
    sed -i.bak "s/fundraising + communications platform/$VALUE_PROP/g" "$TARGET_DIR/docs/reference/workflow-integration.md"
    rm -f "$TARGET_DIR/docs/reference/workflow-integration.md.bak"
    echo -e "${GREEN}✓ Workflow integration updated${NC}"
else
    echo -e "${GREEN}✓ Using Feathr-specific reference documentation${NC}"
fi

echo ""
echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
echo -e "${BLUE}   Step 7: Final Setup${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
echo ""

# Create .gitignore if it doesn't exist
if [ ! -f "$TARGET_DIR/.gitignore" ]; then
    echo -e "${YELLOW}Creating .gitignore...${NC}"
    cat > "$TARGET_DIR/.gitignore" <<'EOF'
# AI PM Toolkit
.DS_Store
*.log
.claude/mcp_settings.json
docs/prds/*.backup.md
docs/feedback-analysis/*.backup.md
EOF
    echo -e "${GREEN}✓ .gitignore created${NC}"
fi

echo ""
echo -e "${GREEN}═══════════════════════════════════════════════════${NC}"
echo -e "${GREEN}   ✓ Installation Complete!${NC}"
echo -e "${GREEN}═══════════════════════════════════════════════════${NC}"
echo ""
echo "The AI PM Toolkit has been installed to:"
echo -e "${BLUE}$TARGET_DIR${NC}"
echo ""
echo -e "${YELLOW}🎓 Getting Started:${NC}"
echo ""
echo -e "${BLUE}New to the toolkit?${NC} Start here:"
echo "   📖 $TARGET_DIR/docs/ONBOARDING.md"
echo "   • Task-based learning path (11 sequential tasks)"
echo "   • Hands-on exercises with examples"
echo "   • Learn by doing, starting with simple features"
echo ""
echo -e "${YELLOW}Quick Start (if you're comfortable with AI tools):${NC}"
echo ""
echo "1. Open Claude Code in your project:"
echo "   cd $TARGET_DIR"
echo "   claude"
echo ""
echo "2. Try your first skill:"
echo "   /scope"
echo ""
echo -e "${YELLOW}Optional: Review and customize generated files${NC}"
echo "   - $TARGET_DIR/CLAUDE.md (company context, capabilities, terminology)"
echo "   - $TARGET_DIR/docs/reference/team-directory.md (team assignments)"
echo "   - $TARGET_DIR/docs/reference/ (quality standards, patterns)"
echo ""
echo -e "${YELLOW}For questions or issues, see: $TOOLKIT_DIR/README.md${NC}"
echo ""
