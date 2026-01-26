#!/bin/bash

# AI PM Toolkit Update Script
# Updates skills and documentation while preserving customizations

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Get script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TOOLKIT_DIR="$( cd "$SCRIPT_DIR/.." && pwd )"

echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
echo -e "${BLUE}   AI PM Toolkit Update Script v1.0.0${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
echo ""

# Check if target directory provided
if [ -z "$1" ]; then
    echo -e "${YELLOW}Usage: ./scripts/update.sh /path/to/your/project${NC}"
    echo ""
    echo "This will update the toolkit installation in your project."
    echo ""
    exit 1
fi

TARGET_DIR="$1"

# Validate target directory
if [ ! -d "$TARGET_DIR" ]; then
    echo -e "${RED}✗ Error: Target directory does not exist: $TARGET_DIR${NC}"
    exit 1
fi

# Check if toolkit is installed
if [ ! -d "$TARGET_DIR/.claude/skills/prd" ]; then
    echo -e "${RED}✗ Error: Toolkit doesn't appear to be installed in this directory${NC}"
    echo ""
    echo "Run install.sh first:"
    echo "  ./scripts/install.sh $TARGET_DIR"
    echo ""
    exit 1
fi

echo -e "${GREEN}✓ Found toolkit installation in: $TARGET_DIR${NC}"
echo ""

echo -e "${YELLOW}⚠ This will update:${NC}"
echo "  - Skills (.claude/skills/)"
echo "  - Core documentation (docs/TOOLKIT-GUIDE.md, docs/ONBOARDING.md)"
echo "  - Templates (docs/templates/)"
echo ""
echo -e "${YELLOW}⚠ This will NOT update (your customizations preserved):${NC}"
echo "  - CLAUDE.md (your config)"
echo "  - docs/reference/team-directory.md"
echo "  - docs/reference/usability-components.md"
echo "  - docs/reference/sdlc-overview.md"
echo "  - Your PRDs in docs/prds/"
echo ""

read -p "Continue? (y/N): " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Update cancelled."
    exit 0
fi

echo ""
echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
echo -e "${BLUE}   Step 1: Backup${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
echo ""

BACKUP_DIR="$TARGET_DIR/.toolkit-backup-$(date +%Y%m%d-%H%M%S)"
echo -e "${YELLOW}Creating backup in: $BACKUP_DIR${NC}"

mkdir -p "$BACKUP_DIR/.claude/skills"
mkdir -p "$BACKUP_DIR/docs"

# Backup skills
cp -r "$TARGET_DIR/.claude/skills" "$BACKUP_DIR/.claude/" 2>/dev/null || true

# Backup docs
cp "$TARGET_DIR/docs/TOOLKIT-GUIDE.md" "$BACKUP_DIR/docs/" 2>/dev/null || true
cp "$TARGET_DIR/docs/ONBOARDING.md" "$BACKUP_DIR/docs/" 2>/dev/null || true
cp -r "$TARGET_DIR/docs/templates" "$BACKUP_DIR/docs/" 2>/dev/null || true

echo -e "${GREEN}✓ Backup created${NC}"
echo ""

echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
echo -e "${BLUE}   Step 2: Update Skills${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
echo ""

echo -e "${YELLOW}Updating skills...${NC}"

# Update each skill
for skill in prd competitive-research customer-feedback-analysis requirement-qa; do
    if [ -d "$TOOLKIT_DIR/.claude/skills/$skill" ]; then
        echo "  - Updating $skill"
        rm -rf "$TARGET_DIR/.claude/skills/$skill"
        cp -r "$TOOLKIT_DIR/.claude/skills/$skill" "$TARGET_DIR/.claude/skills/"
    fi
done

echo -e "${GREEN}✓ Skills updated${NC}"
echo ""

echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
echo -e "${BLUE}   Step 3: Update Documentation${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
echo ""

echo -e "${YELLOW}Updating core documentation...${NC}"

# Update core docs
cp "$TOOLKIT_DIR/docs/TOOLKIT-GUIDE.md" "$TARGET_DIR/docs/"
cp "$TOOLKIT_DIR/docs/ONBOARDING.md" "$TARGET_DIR/docs/"

# Update templates
rm -rf "$TARGET_DIR/docs/templates"
cp -r "$TOOLKIT_DIR/docs/templates" "$TARGET_DIR/docs/"

echo -e "${GREEN}✓ Documentation updated${NC}"
echo ""

echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
echo -e "${BLUE}   Step 4: Summary${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
echo ""

# Check for new files in template
echo -e "${YELLOW}Checking for new reference docs...${NC}"
NEW_DOCS=""
for doc in "$TOOLKIT_DIR/docs/reference/"*.md; do
    filename=$(basename "$doc")
    if [ ! -f "$TARGET_DIR/docs/reference/$filename" ]; then
        NEW_DOCS="$NEW_DOCS\n  - $filename"
    fi
done

if [ -n "$NEW_DOCS" ]; then
    echo -e "${YELLOW}⚠ New reference docs available (not auto-copied):${NC}"
    echo -e "$NEW_DOCS"
    echo ""
    echo "Copy these manually if you want them:"
    echo "  cp $TOOLKIT_DIR/docs/reference/[filename] $TARGET_DIR/docs/reference/"
    echo ""
fi

echo -e "${GREEN}═══════════════════════════════════════════════════${NC}"
echo -e "${GREEN}   ✓ Update Complete!${NC}"
echo -e "${GREEN}═══════════════════════════════════════════════════${NC}"
echo ""
echo "Updated:"
echo -e "  ${GREEN}✓${NC} Skills (.claude/skills/)"
echo -e "  ${GREEN}✓${NC} Core docs (TOOLKIT-GUIDE.md, ONBOARDING.md)"
echo -e "  ${GREEN}✓${NC} Templates (docs/templates/)"
echo ""
echo "Preserved (your customizations):"
echo -e "  ${BLUE}→${NC} CLAUDE.md"
echo -e "  ${BLUE}→${NC} docs/reference/team-directory.md"
echo -e "  ${BLUE}→${NC} docs/reference/usability-components.md"
echo -e "  ${BLUE}→${NC} docs/reference/sdlc-overview.md"
echo -e "  ${BLUE}→${NC} docs/prds/"
echo ""
echo "Backup location: $BACKUP_DIR"
echo ""
echo -e "${YELLOW}To rollback if needed:${NC}"
echo "  cp -r $BACKUP_DIR/.claude/skills/* $TARGET_DIR/.claude/skills/"
echo "  cp -r $BACKUP_DIR/docs/* $TARGET_DIR/docs/"
echo ""
