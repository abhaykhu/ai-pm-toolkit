# CLI Integrations Reference

## GitHub CLI (`gh`)

**Install:**
```bash
# macOS
brew install gh

# Linux
sudo apt install gh   # Debian/Ubuntu
sudo dnf install gh   # Fedora
```

**Authenticate:**
```bash
gh auth login
# Follow prompts to authenticate via browser
```

**Verify:**
```bash
gh auth status
```

**Key PM commands:**
- `gh issue create` — create issues
- `gh issue list` — list issues
- `gh pr create` — create pull requests
- `gh pr list` — list pull requests
- `gh project list` — list GitHub Projects

## Jira CLI

**Install:**
```bash
# Via npm
npm install -g jira-cli

# Via go
go install github.com/ankitpokhrel/jira-cli/cmd/jira@latest
```

**Authenticate:**
```bash
jira init
# Provide: Jira instance URL, email, API token
# Get API token from: https://id.atlassian.com/manage-profile/security/api-tokens
```

**Key PM commands:**
- `jira issue create` — create issues
- `jira issue list` — list issues
- `jira sprint list` — list sprints
- `jira board list` — list boards

## Linear CLI

**Install:**
```bash
npm install -g @linear/cli
```

**Authenticate:**
```bash
linear auth
# Or set LINEAR_API_KEY environment variable
# Get API key from: Linear Settings > API > Personal API keys
```

**Key PM commands:**
- `linear issue create` — create issues
- `linear issue list` — list issues
- `linear team list` — list teams
