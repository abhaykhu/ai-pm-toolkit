#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="${1:-}"

if [ -z "$TARGET_DIR" ]; then
  echo "Usage: ./install.sh <target-directory>"
  echo ""
  echo "Examples:"
  echo "  ./install.sh ~/my-pm-workspace        # Standalone PM workspace"
  echo "  ./install.sh ~/projects/my-app         # Install into existing codebase"
  exit 1
fi

# Resolve to absolute path
TARGET_DIR="$(cd "$(dirname "$TARGET_DIR")" 2>/dev/null && pwd)/$(basename "$TARGET_DIR")" || TARGET_DIR="$(pwd)/$1"

# Detect update mode
UPDATE_MODE=false
if [ -d "$TARGET_DIR/.claude/skills/pm-setup" ]; then
  UPDATE_MODE=true
fi

if [ "$UPDATE_MODE" = true ]; then
  echo "Existing AI PM Toolkit workspace detected. Updating skills..."
  echo ""

  # Update skills only
  rm -rf "$TARGET_DIR/.claude/skills"
  mkdir -p "$TARGET_DIR/.claude/skills"
  cp -R "$SCRIPT_DIR/skills/"* "$TARGET_DIR/.claude/skills/"

  echo "Skills updated successfully!"
  echo ""
  echo "Preserved: context/, outputs/, CLAUDE.md, .mcp.json"
  echo ""
  echo "Next steps:"
  echo "  cd $TARGET_DIR && claude"
  exit 0
fi

# Fresh install
if [ -d "$TARGET_DIR" ] && [ "$(ls -A "$TARGET_DIR" 2>/dev/null)" ]; then
  echo "Note: Target directory is not empty. Toolkit files will be added alongside existing content."
  echo ""
fi

mkdir -p "$TARGET_DIR"

# Copy skills
echo "Installing skills..."
mkdir -p "$TARGET_DIR/.claude/skills"
cp -R "$SCRIPT_DIR/skills/"* "$TARGET_DIR/.claude/skills/"

# Copy templates
echo "Setting up workspace files..."
if [ ! -f "$TARGET_DIR/CLAUDE.md" ]; then
  cp "$SCRIPT_DIR/templates/CLAUDE.md" "$TARGET_DIR/CLAUDE.md"
else
  echo "  CLAUDE.md already exists, skipping (you may want to merge manually)"
fi

if [ ! -f "$TARGET_DIR/.gitignore" ]; then
  cp "$SCRIPT_DIR/templates/.gitignore" "$TARGET_DIR/.gitignore"
else
  echo "  .gitignore already exists, skipping"
fi

# Create context directory
echo "Creating context and output directories..."
mkdir -p "$TARGET_DIR/context"
mkdir -p "$TARGET_DIR/outputs/research"
mkdir -p "$TARGET_DIR/outputs/competitive"
mkdir -p "$TARGET_DIR/outputs/prds"
mkdir -p "$TARGET_DIR/outputs/prototypes"
mkdir -p "$TARGET_DIR/outputs/handoffs"
mkdir -p "$TARGET_DIR/outputs/docs"
mkdir -p "$TARGET_DIR/outputs/enablement"
mkdir -p "$TARGET_DIR/outputs/comms"

echo ""
echo "AI PM Toolkit installed successfully!"
echo ""
echo "Next steps:"
echo "  1. cd $TARGET_DIR"
echo "  2. claude"
echo "  3. /pm-setup    (configure your context and integrations)"
echo ""
echo "Available skills after setup:"
echo "  /customer-research   - Analyze customer feedback"
echo "  /competitive-analysis - Research competitors"
echo "  /prd                 - Write PRDs (feature, epic, bug, task, brief, discovery)"
echo "  /prototype           - Build interactive prototypes from PRDs"
echo "  /prd-refine          - Refine PRDs with new learnings"
echo "  /dev-handoff         - Generate dev specs and tickets"
echo "  /pm-docs             - Write product documentation"
echo "  /enablement          - Create sales/training materials"
echo "  /user-comms          - Draft changelogs, emails, announcements"
