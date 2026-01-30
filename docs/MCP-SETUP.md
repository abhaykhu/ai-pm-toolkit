# MCP Tool Setup Guide

**Model Context Protocol (MCP)** enables Claude Code to access external tools like Canny, Zendesk, Gong, and Planhat. This guide walks through setting up each integration.

---

## Why Set This Up?

The **Customer Feedback Analysis** skill (`/analyze-feedback`) needs access to your feedback sources to work. Without MCP setup, the skill can't fetch data from:
- Canny (feature requests, user feedback)
- Zendesk (support tickets, customer issues)
- Gong (call transcripts, customer conversations)
- Planhat (customer success data, health scores, conversations)

**Time required:** 5-10 minutes per tool

---

## Overview

**What you'll do:**
1. Get API keys from each service
2. Configure MCP servers in Claude Code
3. Test the connection

**Where configuration lives:**
- MCP config file: `~/.config/claude/mcp.json` (Claude Code stores this globally)
- API keys are stored securely by Claude Code

---

## Tool 1: Canny Setup

**What is Canny?** Feature request and feedback management platform.

**What you'll get:** Access to feature requests, votes, comments, and user feedback.

### Step 1: Get Your Canny API Key

1. **Log into Canny** at https://canny.io
2. **Navigate to Settings** → **API & Webhooks**
3. **Copy your API Key** (looks like: `abc123...`)
4. **Note your subdomain** (e.g., if your Canny is at `yourcompany.canny.io`, subdomain is `yourcompany`)

### Step 2: Configure MCP Server

**Option A: Using Claude Code Interface (Recommended)**

1. Open Claude Code
2. Type `/mcp` and press Enter
3. Select "Configure MCP Servers"
4. Click "Add New Server"
5. Choose "Canny" from the list
6. Enter your API key when prompted
7. Enter your subdomain when prompted
8. Click "Save"

**Option B: Manual Configuration**

Edit `~/.config/claude/mcp.json`:

```json
{
  "mcpServers": {
    "canny": {
      "command": "npx",
      "args": ["-y", "@anthropic-ai/mcp-server-canny"],
      "env": {
        "CANNY_API_KEY": "your_api_key_here"
      }
    }
  }
}
```

### Step 3: Test the Connection

In Claude Code, try:
```
List my Canny boards
```

If configured correctly, Claude will show your Canny boards.

---

## Tool 2: Zendesk Setup

**What is Zendesk?** Customer support and ticketing platform.

**What you'll get:** Access to support tickets, customer conversations, and issue tracking.

### Step 1: Get Your Zendesk API Token

1. **Log into Zendesk** (e.g., `yourcompany.zendesk.com`)
2. **Click Settings** (gear icon) → **API**
3. Enable **Token Access**
4. Click **Add API Token**
5. Give it a name: "Claude Code MCP"
6. **Copy the token** (you'll only see this once!)
7. **Note your email** (the email you use to log into Zendesk)
8. **Note your subdomain** (e.g., `yourcompany` from `yourcompany.zendesk.com`)

### Step 2: Configure MCP Server

**Option A: Using Claude Code Interface (Recommended)**

1. Open Claude Code
2. Type `/mcp` and press Enter
3. Select "Configure MCP Servers"
4. Click "Add New Server"
5. Choose "Zendesk" from the list
6. Enter:
   - Your subdomain
   - Your email
   - Your API token
7. Click "Save"

**Option B: Manual Configuration**

Edit `~/.config/claude/mcp.json`:

```json
{
  "mcpServers": {
    "zendesk": {
      "command": "npx",
      "args": ["-y", "@anthropic-ai/mcp-server-zendesk"],
      "env": {
        "ZENDESK_SUBDOMAIN": "yourcompany",
        "ZENDESK_EMAIL": "your.email@yourcompany.com",
        "ZENDESK_API_TOKEN": "your_token_here"
      }
    }
  }
}
```

### Step 3: Test the Connection

In Claude Code, try:
```
Get my most recent Zendesk tickets
```

If configured correctly, Claude will show recent tickets.

---

## Tool 3: Gong Setup

**What is Gong?** Revenue intelligence platform with call recording and transcription.

**What you'll get:** Access to call transcripts, customer conversations, and insights.

### Step 1: Get Your Gong API Credentials

1. **Log into Gong** at https://app.gong.io
2. **Navigate to Settings** → **Ecosystem** → **API**
3. **Create API Key**:
   - Click "Create"
   - Name: "Claude Code MCP"
   - Permissions: Select "Read" for Calls, Transcripts, Users
4. **Copy the Access Key** (looks like: `abc123...`)
5. **Copy the Access Key Secret** (you'll only see this once!)

### Step 2: Configure MCP Server

**Option A: Using Claude Code Interface (Recommended)**

1. Open Claude Code
2. Type `/mcp` and press Enter
3. Select "Configure MCP Servers"
4. Click "Add New Server"
5. Choose "Gong" from the list
6. Enter:
   - Access Key
   - Access Key Secret
7. Click "Save"

**Option B: Manual Configuration**

Edit `~/.config/claude/mcp.json`:

```json
{
  "mcpServers": {
    "gong": {
      "command": "npx",
      "args": ["-y", "@anthropic-ai/mcp-server-gong"],
      "env": {
        "GONG_ACCESS_KEY": "your_access_key_here",
        "GONG_ACCESS_KEY_SECRET": "your_secret_here"
      }
    }
  }
}
```

### Step 3: Test the Connection

In Claude Code, try:
```
List my recent Gong calls
```

If configured correctly, Claude will show recent calls.

---

## Tool 4: Planhat Setup

**What is Planhat?** Customer success platform for managing customer relationships, health scores, usage data, and conversations.

**What you'll get:** Access to customer health data, usage metrics, conversation history, and customer success insights via three flexible tools that work with any Planhat data model.

### Step 1: Get Your Planhat API Token

1. **Log into Planhat** at https://app.planhat.com
2. **Navigate to App Center** (from the main menu)
3. **Create a Private App:**
   - Click "+ New app"
   - Click "+ Private app"
   - Give it a name: "Claude Code MCP"
   - Set permissions based on what data you need access to (Companies, Conversations, Users, etc.)
4. **Generate API Token:**
   - Click "Generate new token"
   - **Copy the token immediately** (you'll only see this once!)

### Step 2: Configure MCP Server

Edit `~/.config/claude/mcp.json` (or `~/Library/Application Support/Claude/claude_desktop_config.json` for Claude Desktop):

```json
{
  "mcpServers": {
    "planhat": {
      "url": "https://api.planhat.com/v1/mcp",
      "headers": {
        "Authorization": "Bearer your-access-token"
      }
    }
  }
}
```

Replace `your-access-token` with the token you generated in Step 1.

**Note:** For demo environments, use `https://api.planhatdemo.com/v1/mcp` instead.

### Step 3: Restart and Verify

1. Restart Claude Code (or Claude Desktop)
2. For Claude Desktop: Click "Reload MCP Configuration" in the developer tab
3. Verify the MCP icon appears in the bottom right of the chat input
4. Click the icon to see Planhat listed as an available server

### Available Tools

Planhat's MCP server provides three flexible tools:

| Tool | Purpose |
|------|---------|
| `get_model_actions` | Discover available Planhat data models and supported operations |
| `get_model_action_parameters` | Get parameter schemas for specific model-operation combinations |
| `perform_model_action` | Execute CRUD operations on Planhat data |

### Step 4: Test the Connection

In Claude Code, try:
```
Use Planhat to list companies
```

Claude will use `get_model_actions` to discover available models, then `perform_model_action` to fetch data.

### Troubleshooting

| Error | Cause | Solution |
|-------|-------|----------|
| 401 Unauthorized | Missing or invalid token | Check Authorization header, ensure token is active |
| 403 Forbidden | Insufficient permissions | Update app permissions in App Center |
| 404 Not Found | Invalid model or operation | Use `get_model_actions` to confirm valid options |
| 400 Bad Request | Missing/invalid parameters | Check `get_model_action_parameters` for requirements |
| 429 Too Many Requests | Rate limit hit | Retry with delay, check Retry-After header |

---

## All Four Together

If you're setting up all four, your `~/.config/claude/mcp.json` should look like:

```json
{
  "mcpServers": {
    "canny": {
      "command": "npx",
      "args": ["-y", "@anthropic-ai/mcp-server-canny"],
      "env": {
        "CANNY_API_KEY": "your_canny_key"
      }
    },
    "zendesk": {
      "command": "npx",
      "args": ["-y", "@anthropic-ai/mcp-server-zendesk"],
      "env": {
        "ZENDESK_SUBDOMAIN": "yourcompany",
        "ZENDESK_EMAIL": "you@yourcompany.com",
        "ZENDESK_API_TOKEN": "your_zendesk_token"
      }
    },
    "gong": {
      "command": "npx",
      "args": ["-y", "@anthropic-ai/mcp-server-gong"],
      "env": {
        "GONG_ACCESS_KEY": "your_gong_key",
        "GONG_ACCESS_KEY_SECRET": "your_gong_secret"
      }
    },
    "planhat": {
      "url": "https://api.planhat.com/v1/mcp",
      "headers": {
        "Authorization": "Bearer your_planhat_token"
      }
    }
  }
}
```

---

## Testing the Feedback Analysis Skill

Once configured, test the full workflow:

```
/analyze-feedback
```

When prompted:
- **Time frame:** Last 30 days
- **Data sources:** All sources
- **Product area:** All areas

Claude should:
1. ✅ Fetch posts from Canny
2. ✅ Fetch tickets from Zendesk
3. ✅ Fetch calls from Gong
4. ✅ Fetch customer data from Planhat
5. ✅ Synthesize into prioritized insights

---

## Troubleshooting

### "Permission denied" or "401 Unauthorized"

**Problem:** API key is invalid or expired

**Solution:**
1. Verify API key in service settings
2. Check if token has required permissions
3. Regenerate API key if needed
4. Update `mcp.json` with new key
5. Restart Claude Code

### "Cannot find module" or "Command not found"

**Problem:** MCP server package not installed

**Solution:**
1. Ensure Node.js is installed: `node --version` (need v18+)
2. Ensure npx is available: `npx --version`
3. Try manual install: `npm install -g @anthropic-ai/mcp-server-canny`
4. Restart Claude Code

### "No data found" or empty results

**Problem:** API key works but no data returned

**Solution:**
1. Check if data exists in the service (log into web interface)
2. Verify date ranges (try "Last 90 days" instead of "Last 30 days")
3. Check API rate limits (wait a few minutes and try again)
4. Verify your account has access to the data

### MCP command not working

**Problem:** `/mcp` command doesn't exist

**Solution:**
1. Update Claude Code to latest version
2. If still not available, use manual configuration (Option B)
3. Check Claude Code documentation for your version

---

## Security Best Practices

**API Key Storage:**
- ✅ Keys stored in `mcp.json` are local to your machine
- ✅ Not shared or transmitted except to the service
- ✅ Use read-only API keys when possible
- ❌ Don't commit `mcp.json` to git (it's in `~/.config`, not your project)

**API Key Permissions:**
- Only grant "Read" permissions (no Write/Delete)
- Use separate API keys for Claude Code vs other integrations
- Rotate keys periodically (every 90 days)
- Revoke immediately if compromised

**Access Control:**
- Create service accounts for API access (not personal accounts)
- Use email aliases if service allows (e.g., `claude-code@yourcompany.com`)
- Document who has API access
- Audit usage regularly

---

## Optional: Figma Setup

If you want Claude to access Figma designs:

### Get Figma Access Token

1. Log into Figma
2. Go to Settings → Account → Personal Access Tokens
3. Generate new token with "Read" access
4. Copy the token

### Configure Figma MCP

```json
{
  "mcpServers": {
    "figma": {
      "command": "npx",
      "args": ["-y", "@anthropic-ai/mcp-server-figma"],
      "env": {
        "FIGMA_ACCESS_TOKEN": "your_figma_token"
      }
    }
  }
}
```

**Usage:**
```
Get design context from Figma file: [paste URL]
```

---

## Skipping MCP Setup

**Can I use the toolkit without MCP?**

Yes! The toolkit works without MCP, but with limitations:

**Skills that work without MCP:**
- ✅ `/prd` - PRD writing (fully functional)
- ✅ `/research-competitors` - Competitive research (uses web search)
- ✅ `/qa-prd` - Quality checker (fully functional)

**Skills that need MCP:**
- ⚠️ `/analyze-feedback` - Won't work without at least one data source
  - Alternative: Skip feedback analysis phase in PRD workflow
  - Alternative: Manually gather feedback and paste into Claude

**Recommendation:** Set up at least one feedback source (Canny or Zendesk) to get value from feedback analysis.

---

## Help & Resources

**Claude Code Documentation:**
- MCP Overview: https://docs.anthropic.com/claude/docs/mcp
- Available MCP Servers: https://github.com/anthropics/mcp-servers

**Service Documentation:**
- Canny API: https://developers.canny.io/api-reference
- Zendesk API: https://developer.zendesk.com/api-reference
- Gong API: https://app.gong.io/settings/api/documentation
- Planhat API: https://docs.planhat.com

**Questions?**
- Check service status pages if connections fail
- Review API rate limits in service docs
- Ask in Claude Code Discord/Slack if issues persist

---

*Last updated: 2026-01-24*
*Version: 1.0.0*
