---
name: customer-feedback-analysis
command: analyze-feedback
description: A comprehensive user feedback analysis skill to research, analyze, and prioritize feedback from multiple user feedback communication and channels. This skill should be used when the user asks to "analyze customer feedback", "research feature requests", "synthesize support tickets", "quantify customer demand", "create roadmap priorities", "review recent feedback", "analyze Canny/Zendesk/Gong data", or needs to understand customer pain points for PRD research or roadmap planning. By default, presents each feature request individually without clustering. User can optionally request "cluster feedback" for high-volume analyses.
version: 1.0.0
---

# Customer Feedback Analysis Skill

## Invocation

**Slash command:** `/analyze-feedback`

**Natural language triggers:**
- "Analyze customer feedback"
- "Research feature requests"
- "Synthesize support tickets"
- "Review recent feedback"
- "Analyze Canny/Zendesk/Gong data"

## Skill Parameters

**IMPORTANT:** If the user does not provide sufficient context when invoking this skill, you MUST clarify scope before proceeding. Use the AskUserQuestion tool to gather missing parameters.

### Required Parameters

1. **Time Frame**
   - What date range should be analyzed?
   - Options: Last 30/60/90 days, Q4 2025, Since last run, Custom range
   - If not specified: Ask user

2. **Analysis Mode**
   - Full review or incremental (since last run)?
   - If ambiguous and previous analysis exists: Show last run date and ask
   - If not specified: Default to full review and confirm date range

3. **Data Sources**
   - Which sources to analyze: Canny, Zendesk, Gong, or all?
   - If not specified: Default to ALL sources, confirm with user
   - Note: Some sources may have limited data for certain time periods

### Optional Parameters

4. **Clustering Preference**
   - Present individual items (default) or cluster similar requests?
   - If not specified: Default to individual items
   - Only ask if user mentions "cluster", "group", or "themes"

5. **Product Area Focus**
   - Analyze all areas or focus on specific ones (Email, Advertising, Fundraising, etc.)?
   - If not specified: Default to ALL areas
   - If user mentions specific area: Focus there and confirm scope

6. **Priority Filters**
   - Minimum customer count threshold?
   - Minimum urgency level?
   - Specific customer tiers (Light, Essential, Advanced)?
   - If not specified: Include all feedback (no filtering)

### Parameter Gathering Workflow

**Step 1: Check what user provided**
```
User: "/analyze-feedback"
→ Missing: Time frame, analysis mode
→ Action: Ask for both

User: "Analyze recent feedback"
→ Provided: Analysis mode (incremental implied by "recent")
→ Missing: Confirm time frame (since last run?)
→ Action: Ask for confirmation

User: "Analyze all email feedback from Q4 2025"
→ Provided: Time frame (Q4 2025), product area (Email)
→ Missing: Analysis mode, data sources
→ Action: Confirm full review mode, confirm all sources or just email-related
```

**Step 2: Use AskUserQuestion for missing parameters**

Present missing parameters as a single question with options:

```markdown
I need a few details before analyzing feedback:

**Question 1: What time frame should I analyze?**
- Last 30 days
- Last 60 days
- Last 90 days (Recommended for quarterly planning)
- Since last run (incremental mode)
- Custom date range

**Question 2: Which data sources?**
- All sources: Canny + Zendesk + Gong (Recommended)
- Canny only
- Zendesk only
- Gong only
- Custom combination

**Question 3: Product area focus?**
- All product areas (Recommended for roadmap planning)
- Email only
- Advertising only
- Fundraising only
- Multiple specific areas
```

**Step 3: Confirm gathered parameters**

Before starting analysis, echo back the scope:

```markdown
Confirmed scope:
- **Time frame:** Last 90 days (2025-10-18 to 2026-01-17)
- **Analysis mode:** Full review
- **Data sources:** All (Canny + Zendesk + Gong)
- **Product areas:** All
- **Clustering:** Individual items (default)
- **Filters:** None (include all feedback)

Proceeding with analysis...
```

## Purpose

This skill analyzes customer feedback from multiple sources (Canny, Zendesk, Gong) to identify **specific, actionable feature requests and problems** that can be directly prioritized for roadmap planning and PRD development.

**Key differentiator:** By default, this skill presents each distinct feature request as its own line item—not grouped into broad themes. This eliminates the "generic clustering" problem where feedback gets lumped into vague categories like "Reporting & Analytics" or "Email Improvements." Every item in the output should be specific enough to translate directly into a PRD without additional clarification.

**When to use this skill:**
- Roadmap planning and prioritization decisions
- PRD research to quantify customer demand
- Quarterly/monthly feedback reviews
- Understanding customer pain points for specific product areas
- Validating product assumptions with real customer data

**Expected outcomes:**
- Prioritized list of specific feature requests with multi-factor scoring
- Customer quotes and context from all three data sources
- PRD-ready problem statements for top items
- Trend analysis comparing to previous runs (when in incremental mode)

**Default behavior:** Each feature request is a separate line item, organized by product area (Email, Advertising, Fundraising, etc.).

**Optional clustering:** User can request "cluster feedback" for very high-volume analyses. When clustering is used, themes must be specific and concrete (e.g., "Flight-level email activity tables") not generic (e.g., "Email improvements").

## Activation Modes

This skill operates in two modes based on the user's request language:

### Full Review Mode

**Triggers:**
- User says: "analyze all feedback", "full review", "comprehensive analysis"
- No previous analysis file exists
- User explicitly requests a specific date range

**Behavior:**
- Prompts user for date range (e.g., "last 90 days", "Q4 2025", "since October")
- Default suggestion: "Last 90 days" if user doesn't specify
- Analyzes all feedback within the specified range
- Does NOT compare to previous runs
- Generates complete analysis report with metadata for future incremental runs

### Incremental Mode

**Triggers:**
- User says: "analyze recent feedback", "new feedback", "since last run", "incremental analysis"
- Previous analysis file exists in `/Users/abhaykhurana/feathr/docs/feedback-analysis/`

**Behavior:**
- Reads most recent analysis file to extract last run date from metadata
- Confirms with user: "Analyzing feedback from [last date] to today. Proceed?"
- Fetches only feedback created/updated since last run date
- Compares current feedback to previous run, calculating score deltas
- Marks items as: 🆕 New, 🔺 Growing (≥20% increase), 🔻 Declining (≥20% decrease), ➡️ Stable (±20%)
- Generates report with trend analysis section

**Ambiguous requests:**
If the user's request doesn't clearly indicate mode and a previous analysis exists:
1. Show the last run date
2. Ask: "Full review or analyze since [last date]?"
3. Proceed based on user's response

## Data Sources & Integration

This skill integrates three MCP-connected data sources to provide comprehensive customer feedback analysis:

### Canny (Feature Requests Platform)

**What to extract:**
- Feature request posts with titles, descriptions, and vote counts
- Post scores (Canny's algorithmic ranking)
- Comments for additional context and sentiment
- Customer information (when available)
- Timestamps for recency calculations

**MCP tool workflow:**
1. `mcp__canny__get_boards` - Identify relevant boards (e.g., "Feature Requests", "Feedback")
2. `mcp__canny__search_posts` or `mcp__canny__get_posts` - Fetch posts within date range, sorted by trending/newest
3. `mcp__canny__get_post` - Get detailed information for high-vote items

**Date filtering:**
- Use `get_posts` with appropriate board IDs
- Filter by post creation date for full review mode
- Filter by last updated date for incremental mode (captures new comments)

### Zendesk (Support Tickets)

**What to extract:**
- Ticket subjects and descriptions (pain points, feature requests embedded in support issues)
- Priority levels (urgent, high, normal, low)
- Ticket status and resolution
- Customer information and ARR data (when available)
- Ticket comments for full context
- Timestamps for recency calculations

**MCP tool workflow:**
1. `mcp__zendesk__get_tickets` - Fetch tickets within date range
2. `mcp__zendesk__get_ticket_comments` - Get full conversation for high-priority tickets
3. Filter for tickets that represent feature requests or recurring pain points (not just one-off bugs)

**Date filtering:**
- Use `created_at` field for full review mode
- Use `updated_at` field for incremental mode
- Consider priority weighting: urgent/high tickets get higher urgency scores

### Gong (Customer Call Transcripts)

**What to extract:**
- Call transcripts with topics and themes
- Customer quotes about pain points, feature requests, frustrations
- Sentiment indicators: "frustrated", "urgent", "blocker", "considering alternatives", "switching to"
- Competitive mentions
- Timestamps for recency calculations

**MCP tool workflow:**
1. `mcp__gong__list_calls` - List calls within date range
2. `mcp__gong__retrieve_transcripts` - Get transcripts for relevant calls
3. Extract quotes and sentiment manually from transcript text

**Date filtering:**
- Use `fromDateTime` and `toDateTime` parameters in `list_calls`
- Focus on customer-facing calls (not internal meetings)

### Cross-Source Deduplication

When the same feature/problem appears in multiple sources:
- **Count frequency across sources** (e.g., 5 Canny votes + 2 Zendesk tickets + 1 Gong mention = 8 total mentions)
- **Use most recent timestamp** across all sources for recency score
- **Combine urgency indicators** (highest urgency level wins)
- **Merge customer lists** (deduplicate by email/organization)

## Analysis Framework Overview

### Default Approach: Individual Feature Requests

By default, this skill treats each distinct feature request or problem as a separate line item. This ensures maximum actionability—every item in the output should be specific enough to:
- Translate directly to a PRD without clarification
- Estimate development complexity
- Assign to a product area and team
- Explain to stakeholders without additional context

**Organization:**
- Group items by product area (Email, Advertising, Fundraising, Integrations, Data & Reporting, Platform)
- Within each product area, list items sorted by final priority score (high to low)
- Each item includes: specific description, score breakdown, customer quotes, source breakdown, cross-feature impacts

**When to keep items separate:**
- Different user workflows or use cases
- Different personas or user types
- Different technical implementations
- Different product areas affected

**Example of proper separation:**
- ✅ Item 1: "Flight-level email activity tables showing opens/clicks per individual flight"
- ✅ Item 2: "Export email performance data with flight-level granularity"
- ✅ Item 3: "API endpoint for programmatic access to flight-level email metrics"

These are three distinct feature requests, even though they're related to "flight-level email data." Keep them separate.

### Optional Clustering Mode (User-Requested)

When the user explicitly requests "cluster feedback" or "group similar themes" (typically for very long-term analyses with hundreds of items), use clustering with these strict rules:

**Clustering rules:**
- ❌ **AVOID generic themes:** "Reporting & Analytics", "Email Improvements", "User Experience Enhancements"
- ✅ **USE specific themes:** "Flight-level email activity tables", "Lookalike audience attribution in Pixl Plus reports", "Browser language auto-translation for donation forms"
- Each cluster name should describe a specific, concrete feature or capability
- Only cluster items if they are **clearly the same feature request** worded differently
- If two items solve different problems or require different implementations, keep them separate

**Clustering process:**
1. Identify truly identical requests from different sources (e.g., same feature from Canny and Zendesk)
2. Name the cluster using the most specific, concrete description available
3. List all individual feedback items within the cluster
4. Show combined scoring (aggregated frequency, most recent timestamp, highest urgency)

**Example of proper clustering:**

**Cluster: "Flight-level email activity tables"**
- Item 1: Canny post requesting "See email stats broken down by individual flights, not just campaigns"
- Item 2: Zendesk ticket asking "Can we export data showing which specific emails performed best?"
- Item 3: Gong call mention: "We need to see open rates for each email send, not aggregate"

These three items are clearly the same underlying feature request, so they can be clustered.

### Four-Factor Prioritization Model

Every feature request/problem gets scored on four factors:

**1. Frequency (30% weight)**
- How many distinct customers or feedback instances mention this?
- Count: Canny votes + Zendesk ticket mentions + Gong call mentions
- Deduplicates customers across sources (same customer in Canny + Zendesk = 1 customer)

**2. Recency (25% weight)**
- How recently was this mentioned?
- Uses most recent timestamp across all sources
- Time-decay formula gives higher scores to recent feedback

**3. Tone/Urgency (25% weight)**
- How urgent or frustrated are customers about this?
- Indicators:
  - Gong: Keywords like "frustrated", "urgent", "blocker", "considering alternatives"
  - Zendesk: Priority level (urgent=100, high=75, normal=50, low=25)
  - Canny: Angry/frustrated comments, churn threats

**4. Technical Complexity (20% weight, inverse)**
- How difficult is this to build?
- **Auto-estimated** based on cross-feature impact analysis (see below)
- Higher complexity = lower score (we want to surface quick wins alongside big bets)
- User can override estimates during review phase

**Final score calculation:**
```
Final Score = (Frequency × 0.30) + (Recency × 0.25) + (Urgency × 0.25) + (Complexity × 0.20)
```

See `references/prioritization-rubric.md` for detailed scoring formulas.

### Cross-Feature Impact Analysis

For each feature request, identify which platform areas are affected using Feathr's 7-point framework:

1. **Person Records:** Changes to person record display, data structure, activity logging
2. **Segmentation & Targeting:** New segmentation criteria, audience building, targeting options
3. **Reporting & Analytics:** Dashboard updates, new metrics, data visualizations, exports
4. **Billing & Credits:** Growth Credits, payment processing, pricing, financial transactions
5. **CRM Integration:** Salesforce NPSP or RE NXT sync behavior, field mapping, data flow
6. **Campaign Goals:** New goal types or conversion tracking for email/ad campaigns
7. **Other Platform Touchpoints:** Forms, landing pages, email builder, etc.

**Complexity estimation:**
- **1-2 areas:** Low complexity (100 pts) - estimated 1-2 weeks
- **3-4 areas:** Medium-low complexity (70 pts) - estimated 2-4 weeks
- **5-6 areas:** Medium-high complexity (40 pts) - estimated 4-8 weeks
- **7+ areas:** High complexity (20 pts) - estimated 8+ weeks

**Adjustments:**
- CRM integration required: -10 pts
- Data model changes (new fields/tables): -15 pts
- Payment/billing changes: -10 pts

## Workflow Steps

### Step 0: Gather and Confirm Parameters

**CRITICAL:** This step must happen BEFORE any data collection. Do not proceed to Step 1 until all parameters are confirmed.

**Parse user request for explicit parameters:**
- Time frame: "last 90 days", "Q4 2025", "since last run", "recent"
- Data sources: "Canny", "Zendesk", "Gong", mentions of specific tools
- Product area: "email", "advertising", "fundraising", specific feature mentions
- Clustering: "cluster", "group", "themes"
- Analysis mode: "all", "full review", "recent", "incremental", "since last"

**Identify missing required parameters:**

If missing time frame:
- Check for previous analysis file
- If exists: Ask "Analyze since last run (YYYY-MM-DD) or full review?"
- If not exists: Ask "What time frame? (Options: Last 30/60/90 days, Quarter, Custom)"

If missing data sources:
- Default to ALL sources (Canny + Zendesk + Gong)
- Confirm with user: "I'll analyze all sources (Canny, Zendesk, Gong). Correct?"

If product area specified but ambiguous:
- Example: User says "email feedback"
- Clarify: "Focus only on Email product area, or analyze all areas but highlight Email?"

**Use AskUserQuestion for batch parameter gathering:**

If multiple parameters are missing, ask them together:

```
{
  "questions": [
    {
      "question": "What time frame should I analyze?",
      "header": "Time Frame",
      "options": [
        {"label": "Last 90 days (Recommended)", "description": "Standard quarterly review"},
        {"label": "Last 30 days", "description": "Monthly review"},
        {"label": "Since last run", "description": "Incremental mode"},
        {"label": "Custom date range", "description": "Specify your own dates"}
      ],
      "multiSelect": false
    },
    {
      "question": "Which data sources should I analyze?",
      "header": "Sources",
      "options": [
        {"label": "All sources (Recommended)", "description": "Canny + Zendesk + Gong for comprehensive view"},
        {"label": "Canny only", "description": "Feature requests and votes"},
        {"label": "Zendesk only", "description": "Support tickets"},
        {"label": "Gong only", "description": "Customer call transcripts"}
      ],
      "multiSelect": false
    },
    {
      "question": "Should I focus on specific product areas?",
      "header": "Product Areas",
      "options": [
        {"label": "All areas (Recommended)", "description": "Email, Advertising, Fundraising, Integrations, Platform"},
        {"label": "Email only", "description": "Focus on email campaigns and tools"},
        {"label": "Advertising only", "description": "Focus on Pixl/Pixl Plus, Google Ads, Meta"},
        {"label": "Fundraising only", "description": "Focus on donation forms and Growth Credits"}
      ],
      "multiSelect": false
    }
  ]
}
```

**Confirm scope before proceeding:**

Echo back all parameters for user validation:

```
Confirmed analysis scope:
✓ Time frame: Last 90 days (2025-10-18 to 2026-01-17)
✓ Analysis mode: Full review
✓ Data sources: All (Canny + Zendesk + Gong)
✓ Product areas: All
✓ Organization: Individual items (no clustering)
✓ Filters: None

Proceeding to fetch data...
```

If user says "no" or wants to change anything, re-gather parameters.

### Step 1: Determine Analysis Mode

Based on confirmed parameters from Step 0:

**Full review indicators:**
- "all feedback", "full review", "comprehensive"
- No previous analysis file exists
- User specifies a date range explicitly

**Incremental indicators:**
- "recent", "new", "since last", "incremental"
- Previous analysis file exists

**If ambiguous:**
1. Check for previous analysis file in `/Users/abhaykhurana/feathr/docs/feedback-analysis/`
2. If found: Show last run date and ask "Full review or analyze since [date]?"
3. If not found: Default to full review

### Step 2: Determine Date Range

**Full review mode:**
1. Ask user: "What date range should I analyze? (e.g., 'last 90 days', 'Q4 2025', 'since October')"
2. If user doesn't specify, suggest: "Last 90 days"
3. Parse natural language dates (support common formats)

**Incremental mode:**
1. Read most recent analysis file from `/Users/abhaykhurana/feathr/docs/feedback-analysis/`
2. Extract "Analysis date" from metadata section
3. Use as start date, today as end date
4. Confirm with user: "Analyzing feedback from [last date] to today. Proceed?"

### Step 3: Fetch Data from Confirmed Sources

**Use only the sources specified in Step 0 parameters.**

Execute MCP tool calls in parallel for efficiency:

**If Canny included:**
```
1. mcp__canny__get_boards → identify board IDs
2. mcp__canny__get_posts (per board) with date filters from Step 0
3. mcp__canny__get_post for high-vote items needing detail
```

**If Zendesk included:**
```
1. mcp__zendesk__get_tickets with date filters from Step 0 and sorting
2. mcp__zendesk__get_ticket_comments for high-priority tickets
```

**If Gong included:**
```
1. mcp__gong__list_calls with fromDateTime/toDateTime from Step 0
2. mcp__gong__retrieve_transcripts for relevant calls
```

**If only subset of sources:**
- Skip tools for excluded sources
- Note in report which sources were analyzed vs. excluded

Extract key data:
- Titles/descriptions/subjects
- Timestamps (created, updated)
- Customer information (name, email, ARR)
- Vote counts, priority levels, sentiment indicators
- Quotes and context

### Step 4: Organize Feedback

**Default mode (no clustering):**
1. Create list of distinct feature requests/problems
2. For each item, consolidate mentions across sources
3. Calculate frequency (deduplicated customer count)
4. Extract representative quotes from each source
5. Note timestamps for recency
6. Identify urgency indicators
7. Map to product area (Email, Advertising, Fundraising, etc.)

**Optional clustering mode (user-requested):**
1. Identify truly identical requests across sources
2. Create specific, concrete cluster names (not generic themes)
3. Group only items that are clearly the same underlying feature
4. List all individual feedback within each cluster
5. Aggregate scoring (total frequency, most recent, highest urgency)

### Step 5: Score Each Item

For every feature request/problem:

1. **Calculate frequency score** (0-100)
   - Count distinct mentions/customers
   - Apply frequency scoring rubric (see `references/prioritization-rubric.md`)

2. **Calculate recency score** (0-100)
   - Use most recent timestamp across sources
   - Apply time-decay formula

3. **Calculate urgency score** (0-100)
   - Extract sentiment from Gong transcripts
   - Map Zendesk priority to score
   - Detect frustration indicators in Canny comments
   - Use highest urgency found across sources

4. **Auto-estimate complexity score** (0-100, inverse)
   - Map item to cross-feature impact areas (1-7+ areas)
   - Apply complexity rubric
   - Adjust for integration/data model/payment factors

5. **Calculate final score**
   - Apply weighted formula: (Freq × 0.30) + (Rec × 0.25) + (Urg × 0.25) + (Comp × 0.20)

6. **Sort items by final score** (high to low)

### Step 6: Map to Product Areas and Apply Filters

**Product area mapping:**

Assign each item to one primary product area:
- **Email:** Email campaigns, templates, deliverability, automation
- **Advertising:** Display ads, search ads, Meta ads, Pixl Plus
- **Fundraising:** Donation forms, Growth Credits, payment processing
- **Integrations:** CRM sync, data imports/exports, API
- **Data & Reporting:** Dashboards, analytics, person records, segmentation
- **Platform:** User management, permissions, settings, infrastructure

Identify secondary areas affected (cross-feature impacts).

**Apply product area filter from Step 0:**

If user specified focus area(s):
- Filter items to only include those mapped to specified areas
- Note in report: "Filtered to [Area] feedback only per user request"
- Include cross-feature impacts even if they touch other areas

If "all areas" (default):
- Include all items regardless of product area
- Organize report by product area sections

**Apply optional filters from Step 0:**

If minimum customer count specified:
- Filter out items below threshold
- Note in report: "Showing only items with ≥N customers"

If minimum urgency specified:
- Filter out items below urgency threshold
- Note in report: "Showing only high-urgency items (score ≥X)"

If customer tier filter specified:
- Filter to only items from specified tier(s)
- Note in report: "Filtered to [Light/Essential/Advanced] tier feedback only"

### Step 7: Generate PRD-Ready Problem Statements

For the top 5 items by final score, create PRD-ready problem statements:

**Format:**
"[User Type] needs [capability] because [pain point], resulting in [quantifiable impact]."

**Example:**
"Email marketers need flight-level activity tables in the campaign dashboard because they currently cannot see which specific email sends performed best, resulting in manual CSV exports and data manipulation for 12+ customers (combined $240K ARR) who request this monthly."

Include:
- Customer count and ARR impact
- Source references (Canny votes, Zendesk tickets, Gong calls)
- Representative quotes

### Step 8: Draft Report & Complexity Review

Generate full markdown report with all sections (see Output Requirements below).

Present draft to user with complexity estimates highlighted:

"Here's the draft analysis. I've auto-estimated technical complexity based on cross-feature impact. Do these complexity estimates look reasonable? Any overrides?"

**If user provides adjustments:**
1. Update complexity scores for specified items
2. Recalculate final scores with new complexity values
3. Re-sort items by updated scores
4. Regenerate report with revised rankings

### Step 9: Finalize & Save Report

Write final report to:
`/Users/abhaykhurana/feathr/docs/feedback-analysis/YYYY-MM-DD-feedback-analysis.md`

Include complete metadata section at end for future incremental runs (see Output Requirements).

### Step 10: Offer PRD Skill Handoff

After saving report, ask user:

"Would you like me to start a PRD for any of these top items?"

**If yes:**
1. Show top 5 items with scores
2. User selects which item(s)
3. Pass context to PRD skill:
   - Item name and description
   - Customer quotes and feedback
   - Prioritization scores and factors
   - Cross-feature impact analysis
   - Customer count, ARR, vote counts
   - Source references

PRD skill takes over with pre-populated context, starting from Phase 1 (PRD research).

## Output Requirements

### File Location & Naming

**Directory:** `/Users/abhaykhurana/feathr/docs/feedback-analysis/`

**Filename format:** `YYYY-MM-DD-feedback-analysis.md`

**Example:** `2026-01-17-feedback-analysis.md`

### Report Structure (Default - No Clustering)

```markdown
# Feathr Customer Feedback Analysis
**Analysis Date:** YYYY-MM-DD
**Analysis Type:** [Full Review | Incremental Since YYYY-MM-DD]
**Date Range:** YYYY-MM-DD to YYYY-MM-DD
**Sources:** Canny (N posts), Zendesk (N tickets), Gong (N calls)
**Clustering:** Disabled (distinct items presented individually)

## Executive Summary
- Top 5 feature requests by priority score
- Urgent items requiring immediate attention
- New items vs. previous run (if incremental)
- Key patterns and trends

## 1. Prioritized Feature Requests by Product Area

### Email (N items)
| # | Feature/Problem | Score | Freq | Recency | Urgency | Complexity | Customers | Sources |
|---|-----------------|-------|------|---------|---------|------------|-----------|---------|
| 1 | Flight-level email activity tables | 85.5 | 90 | 100 | 80 | 70 | 12 | Canny (20 votes), Zendesk (3 tickets) |

**Details:**
- **Customer Quotes:**
  - Canny (Post #123): "We need to see email stats broken down by individual flights, not just campaigns."
  - Zendesk (Ticket #456): "Can we export data showing which specific emails performed best?"
- **Cross-Feature Impact:** Person Records (activity logging), Reporting (dashboard tables), Data Export (CSV)
- **Affected Tiers:** Essential, Advanced

[Repeat for each item in Email]

### Advertising (N items)
[Same table and details format]

### Fundraising (N items)
[Same table and details format]

[Continue for all product areas]

## 2. PRD-Ready Problem Statements

### #1: Flight-level email activity tables (Score: 85.5)
"Email marketers need flight-level activity tables in the campaign dashboard because they currently cannot see which specific email sends performed best, resulting in manual CSV exports and data manipulation for 12+ customers (combined $240K ARR) who request this monthly."

**Context:**
- 12 customers, $240K ARR
- 20 Canny votes, 3 Zendesk tickets, 1 Gong call
- Cross-feature impact: Person Records, Reporting, Data Export

[Repeat for top 5 items]

## 3. Trend Analysis (Incremental mode only)

| Feature/Problem | Current Score | Previous Score | Delta | Trend | Notes |
|-----------------|---------------|----------------|-------|-------|-------|
| Flight-level email activity | 85.5 | 72.0 | +18.8% | ➡️ Stable | 3 new mentions |
| Lookalike attribution | 78.0 | 62.0 | +25.8% | 🔺 Growing | High urgency in recent Gong call |

## 4. Strategic Insights
- Patterns across product areas
- Competitive considerations
- Roadmap implications
- Quick wins vs. long-term investments

## Metadata for Next Run
- **Analysis date:** YYYY-MM-DD
- **Date range:** YYYY-MM-DD to YYYY-MM-DD
- **Sources queried:** Canny (N posts), Zendesk (N tickets), Gong (N calls)
- **Items analyzed:** N items
- **Items snapshot (JSON):**
```json
{
  "flight-level-email-activity": {
    "name": "Flight-level email activity tables",
    "score": 85.5,
    "frequency": 90,
    "recency": 100,
    "urgency": 80,
    "complexity": 70,
    "area": "Email",
    "customers": 12
  },
  "lookalike-pixl-reporting": {
    "name": "Lookalike audience attribution in Pixl Plus reports",
    "score": 72.0,
    "frequency": 75,
    "recency": 85,
    "urgency": 70,
    "complexity": 65,
    "area": "Advertising",
    "customers": 8
  }
}
```
```

### Report Structure (Optional - With Clustering)

When user requests clustering, use this structure:

```markdown
# Feathr Customer Feedback Analysis
[Same headers as default]
**Clustering:** Enabled (similar items grouped into specific themes)

## Executive Summary
[Same as default]

## 1. Prioritized Themes by Product Area

### Email (N themes)
| # | Theme | Score | Items | Freq | Recency | Urgency | Complexity | Customers |
|---|-------|-------|-------|------|---------|---------|------------|-----------|
| 1 | Flight-level email activity tables | 85.5 | 3 | 90 | 100 | 80 | 70 | 12 |

**Clustered Feedback:**
- Item 1 (Canny #123): "See email stats broken down by individual flights"
- Item 2 (Zendesk #456): "Export data showing which specific emails performed best"
- Item 3 (Gong Call 2026-01-10): "Need to see open rates for each email send"

**Customer Quotes:** [Same as default format]
**Cross-Feature Impact:** [Same as default format]

[Continue for remaining sections 2-4 with same format as default]
```

### Formatting Requirements

- **Tables:** Use markdown tables for scannability
- **Bullets:** Use for detailed context, quotes, impacts
- **Headers:** Use ## for major sections, ### for product areas, #### for subsections
- **Customer data:** Include names, emails, ARR (internal use - no redaction needed)
- **Scores:** Display to 1 decimal place (e.g., 85.5)
- **Trend markers:** 🆕 New, 🔺 Growing, 🔻 Declining, ➡️ Stable
- **JSON metadata:** Properly formatted, valid JSON in code block

## Reference Pointers

For detailed implementation guidance, see:

- **Detailed scoring formulas:** `references/prioritization-rubric.md`
- **MCP tool usage patterns:** `references/mcp-integration-guide.md`
- **Feedback organization & clustering guidelines:** `references/analysis-framework.md`
- **Sample report outputs:** `references/output-examples.md` and `examples/full-analysis-output.md`
- **Example source data:** `examples/canny-data-sample.json`, `examples/zendesk-tickets-sample.json`, `examples/gong-transcript-sample.txt`

## Key Success Criteria

A successful analysis should:

1. ✅ **Be actionable:** Every item specific enough to translate to a PRD
2. ✅ **Be evidence-based:** All claims supported by customer quotes and data
3. ✅ **Be prioritized:** Clear scoring rationale, not just gut feel
4. ✅ **Be comprehensive:** All three data sources represented
5. ✅ **Be organized:** Easy to scan, grouped logically by product area
6. ✅ **Be persistent:** Metadata enables future trend tracking
7. ✅ **Avoid generic clustering:** No vague themes like "Reporting Improvements" (unless user explicitly requests clustering)

This skill should produce analysis that product managers can immediately use for roadmap decisions and PRD development without additional research or clarification.
