# MCP Servers Reference

Known MCP server configurations for common PM tools. Add to `.mcp.json` in the workspace root.

## Project Management

### Jira (Atlassian)
```json
{
  "mcpServers": {
    "jira": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-server-jira"],
      "env": {
        "JIRA_URL": "https://your-org.atlassian.net",
        "JIRA_EMAIL": "your-email@company.com",
        "JIRA_API_TOKEN": "your-api-token"
      }
    }
  }
}
```

### Linear
```json
{
  "mcpServers": {
    "linear": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-server-linear"],
      "env": {
        "LINEAR_API_KEY": "your-api-key"
      }
    }
  }
}
```

### Asana
```json
{
  "mcpServers": {
    "asana": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-server-asana"],
      "env": {
        "ASANA_ACCESS_TOKEN": "your-access-token"
      }
    }
  }
}
```

### GitHub (Issues & Projects)
```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-server-github"],
      "env": {
        "GITHUB_TOKEN": "your-github-token"
      }
    }
  }
}
```

## Customer Feedback & Support

### Intercom
```json
{
  "mcpServers": {
    "intercom": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-server-intercom"],
      "env": {
        "INTERCOM_ACCESS_TOKEN": "your-access-token"
      }
    }
  }
}
```

### Zendesk
```json
{
  "mcpServers": {
    "zendesk": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-server-zendesk"],
      "env": {
        "ZENDESK_SUBDOMAIN": "your-subdomain",
        "ZENDESK_EMAIL": "your-email",
        "ZENDESK_API_TOKEN": "your-api-token"
      }
    }
  }
}
```

### Productboard
```json
{
  "mcpServers": {
    "productboard": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-server-productboard"],
      "env": {
        "PRODUCTBOARD_ACCESS_TOKEN": "your-access-token"
      }
    }
  }
}
```

## Communication & Documentation

### Slack
```json
{
  "mcpServers": {
    "slack": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-server-slack"],
      "env": {
        "SLACK_BOT_TOKEN": "xoxb-your-bot-token"
      }
    }
  }
}
```

### Notion
```json
{
  "mcpServers": {
    "notion": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-server-notion"],
      "env": {
        "NOTION_API_KEY": "your-integration-token"
      }
    }
  }
}
```

### Confluence
```json
{
  "mcpServers": {
    "confluence": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-server-confluence"],
      "env": {
        "CONFLUENCE_URL": "https://your-org.atlassian.net/wiki",
        "CONFLUENCE_EMAIL": "your-email@company.com",
        "CONFLUENCE_API_TOKEN": "your-api-token"
      }
    }
  }
}
```

## Tool Not Listed?

If the user's tool isn't listed above:
1. Web search for `"<tool-name> MCP server"` or `"<tool-name> model context protocol"`
2. Check the MCP server registry at https://github.com/modelcontextprotocol/servers
3. If an MCP server exists, help the user configure it following the patterns above
4. If no MCP server exists, suggest alternative approaches:
   - Use the tool's REST API via CLI commands
   - Export data from the tool and import via file
   - Use the tool's CLI if available
