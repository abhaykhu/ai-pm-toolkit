#!/bin/bash
#
# Validate Feedback Sources - MCP Tool Connectivity Checker
#
# This script tests connectivity to Canny, Zendesk, and Gong MCP tools
# to ensure they're properly configured before running feedback analysis.
#
# Usage: ./validate-feedback-sources.sh

set -e

echo "=================================="
echo "Feedback Sources Validation"
echo "=================================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Track overall success
ALL_PASSED=true

# Function to test MCP tool availability
test_mcp_tool() {
    local tool_name=$1
    local test_description=$2

    echo -n "Testing $test_description... "

    # Note: This is a placeholder. In actual implementation, you would:
    # 1. Use Claude MCP tool invocation to test connectivity
    # 2. Parse the response to determine success/failure
    # 3. For now, we'll just check if the tool name is recognized

    # Placeholder logic - replace with actual MCP tool test
    echo -e "${YELLOW}SKIP${NC} (Manual MCP tool test required)"
    echo "  To test: Invoke mcp__${tool_name}__ tool directly in Claude Code"
    echo ""
}

# Test Canny connectivity
echo "=== Canny MCP Tools ==="
test_mcp_tool "canny" "get_boards"
test_mcp_tool "canny" "get_posts"
test_mcp_tool "canny" "get_post"

# Test Zendesk connectivity
echo "=== Zendesk MCP Tools ==="
test_mcp_tool "zendesk" "get_tickets"
test_mcp_tool "zendesk" "get_ticket"
test_mcp_tool "zendesk" "get_ticket_comments"

# Test Gong connectivity
echo "=== Gong MCP Tools ==="
test_mcp_tool "gong" "list_calls"
test_mcp_tool "gong" "retrieve_transcripts"

echo ""
echo "=================================="
echo "Validation Instructions"
echo "=================================="
echo ""
echo "To manually validate MCP tool connectivity:"
echo ""
echo "1. Canny:"
echo "   - Run: Use mcp__canny__get_boards tool"
echo "   - Expected: List of Canny boards returned"
echo ""
echo "2. Zendesk:"
echo "   - Run: Use mcp__zendesk__get_tickets tool with per_page=1"
echo "   - Expected: At least one ticket returned"
echo ""
echo "3. Gong:"
echo "   - Run: Use mcp__gong__list_calls tool with last 7 days date range"
echo "   - Expected: List of calls returned (may be empty if no recent calls)"
echo ""
echo "If any tools fail:"
echo "  - Check MCP server configuration in claude.json"
echo "  - Verify API credentials are set correctly"
echo "  - Ensure MCP servers are running"
echo "  - Re-authenticate with /mcp command if needed"
echo ""
