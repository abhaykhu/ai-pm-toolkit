# Updating the AI PM Toolkit

## Updating Skills in Your Workspace

When the toolkit is updated with new skills or improvements:

1. Pull the latest changes to your toolkit repo:
   ```bash
   cd /path/to/AI-PM-Toolkit
   git pull
   ```

2. Re-run the installer pointing to your workspace:
   ```bash
   ./install.sh /path/to/your-workspace
   ```

The installer detects your existing workspace and runs in **update mode**:
- Skills are replaced with the latest versions
- Your `context/`, `outputs/`, `CLAUDE.md`, and `.mcp.json` are preserved
- No data is lost

## What Gets Updated

| Updated | Preserved |
|---------|-----------|
| `.claude/skills/*` | `context/*` |
| | `outputs/*` |
| | `CLAUDE.md` |
| | `.mcp.json` |
| | `.gitignore` |

## Manual Merging

If `templates/CLAUDE.md` has changed significantly, you may want to manually compare it with your workspace's `CLAUDE.md` and merge any new instructions.
