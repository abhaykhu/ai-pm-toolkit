#!/bin/bash

# AI PM Toolkit Updater
# Syncs skills, templates, and reference docs without touching CLAUDE.md

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
echo -e "${BLUE}   AI PM Toolkit Updater v1.1.0${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
echo ""

# Check if target directory provided
if [ -z "$1" ]; then
    echo -e "${YELLOW}Usage: ./scripts/update.sh /path/to/your/project${NC}"
    echo ""
    echo "Updates skills, templates, and reference docs without"
    echo "touching CLAUDE.md or other configuration."
    echo ""
    exit 1
fi

TARGET_DIR="$1"

# Validate target directory
if [ ! -d "$TARGET_DIR" ]; then
    echo -e "${RED}Error: Target directory does not exist: $TARGET_DIR${NC}"
    exit 1
fi

# Check if toolkit is installed (check for .claude/skills directory)
if [ ! -d "$TARGET_DIR/.claude/skills" ]; then
    echo -e "${RED}Error: Toolkit not installed in $TARGET_DIR${NC}"
    echo "Run install.sh first: ./scripts/install.sh $TARGET_DIR"
    exit 1
fi

echo -e "${GREEN}Target: $TARGET_DIR${NC}"
echo ""
echo "This will update:"
echo "  - .claude/skills/*"
echo "  - docs/templates/*"
echo "  - docs/reference/*"
echo ""
echo "This will NOT touch:"
echo "  - CLAUDE.md"
echo "  - Other docs or custom files"
echo ""

read -p "Continue? (y/N): " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Cancelled."
    exit 0
fi

echo ""

# Update skills
echo -e "${YELLOW}Updating skills...${NC}"

# Remove old skill directories that no longer exist in source
for dir in "$TARGET_DIR/.claude/skills/"*/; do
    [ -d "$dir" ] || continue
    skill_name=$(basename "$dir")
    if [ ! -d "$TOOLKIT_DIR/.claude/skills/$skill_name" ]; then
        echo "  Removing deprecated: $skill_name"
        rm -rf "$dir"
    fi
done

# Copy all current skills
cp -r "$TOOLKIT_DIR/.claude/skills/"* "$TARGET_DIR/.claude/skills/"
echo -e "${GREEN}  Done${NC}"

# Update templates
echo -e "${YELLOW}Updating templates...${NC}"
if [ -d "$TOOLKIT_DIR/docs/templates" ]; then
    mkdir -p "$TARGET_DIR/docs/templates"

    # Remove old templates that no longer exist
    for file in "$TARGET_DIR/docs/templates/"*.md; do
        [ -e "$file" ] || continue
        template_name=$(basename "$file")
        if [ ! -f "$TOOLKIT_DIR/docs/templates/$template_name" ]; then
            echo "  Removing deprecated: $template_name"
            rm -f "$file"
        fi
    done

    cp -r "$TOOLKIT_DIR/docs/templates/"* "$TARGET_DIR/docs/templates/"
    echo -e "${GREEN}  Done${NC}"
fi

# Update reference docs
echo -e "${YELLOW}Updating reference docs...${NC}"
if [ -d "$TOOLKIT_DIR/docs/reference" ]; then
    mkdir -p "$TARGET_DIR/docs/reference"

    # Remove old reference docs that no longer exist
    for file in "$TARGET_DIR/docs/reference/"*.md; do
        [ -e "$file" ] || continue
        ref_name=$(basename "$file")
        if [ ! -f "$TOOLKIT_DIR/docs/reference/$ref_name" ]; then
            echo "  Removing deprecated: $ref_name"
            rm -f "$file"
        fi
    done

    cp -r "$TOOLKIT_DIR/docs/reference/"* "$TARGET_DIR/docs/reference/"
    echo -e "${GREEN}  Done${NC}"
fi

echo ""
echo -e "${GREEN}═══════════════════════════════════════════════════${NC}"
echo -e "${GREEN}   Update complete${NC}"
echo -e "${GREEN}═══════════════════════════════════════════════════${NC}"
echo ""
echo "Updated:"
echo "  - .claude/skills/*"
echo "  - docs/templates/*"
echo "  - docs/reference/*"
echo ""
echo -e "${YELLOW}Note: If skill commands changed (e.g., /prd → /scope),${NC}"
echo -e "${YELLOW}update your CLAUDE.md skill table manually.${NC}"
echo -e "${YELLOW}See RELEASE-NOTES.md for details.${NC}"
echo ""
