# Customer Feedback Analysis Skill

A comprehensive Claude Code skill for analyzing customer feedback from Canny, Zendesk, Gong, and Planhat to inform product roadmap prioritization at Feathr.

## Quick Start

**To use this skill:**

**Option 1: Slash command**
```
/analyze-feedback
```

**Option 2: Natural language**
Simply ask Claude Code to "analyze customer feedback" in a regular conversation. The skill will be auto-discovered based on your request.

Example invocations:
- "Analyze all customer feedback from the last 90 days"
- "Analyze recent feedback since the last run"
- "Review Canny, Zendesk, Gong, and Planhat feedback for Q1 roadmap planning"
- "Analyze email feedback from Q4 2025"
- `/analyze-feedback` (slash command)

**The skill will prompt you for any missing parameters:**
- Time frame (last 30/60/90 days, custom range, since last run)
- Data sources (Canny, Zendesk, Gong, Planhat, or all)
- Product area focus (all areas or specific: Email, Advertising, Fundraising, etc.)
- Clustering preference (individual items or grouped themes)
- Optional filters (minimum customer count, urgency level, customer tier)

## Skill Parameters

The skill uses a comprehensive parameter system to ensure analysis scope is clearly defined. If you don't provide all parameters in your initial request, the skill will prompt you.

### Required Parameters

| Parameter | Options | Default | Description |
|-----------|---------|---------|-------------|
| **Time Frame** | Last 30/60/90 days, Q4 2025, Since last run, Custom | Must specify | Date range for analysis |
| **Analysis Mode** | Full review, Incremental (since last run) | Auto-detect from time frame | Type of analysis |
| **Data Sources** | All, Canny only, Zendesk only, Gong only, Planhat only | All sources | Which feedback sources to include |

### Optional Parameters

| Parameter | Options | Default | Description |
|-----------|---------|---------|-------------|
| **Clustering** | Individual items, Specific themes | Individual items | How to organize feedback |
| **Product Area Focus** | All, Email, Advertising, Fundraising, Integrations, Platform | All areas | Which product areas to analyze |
| **Minimum Customers** | Any number | None (include all) | Filter items below customer threshold |
| **Minimum Urgency** | 0-100 score | None (include all) | Filter items below urgency threshold |
| **Customer Tier** | All, Light, Essential, Advanced | All tiers | Filter by customer tier |

### Parameter Examples

**Minimal invocation (skill will prompt for details):**
```
/analyze-feedback
```

**Partial specification (skill will prompt for missing details):**
```
"Analyze recent feedback"
→ Skill asks: Time frame? Sources? Product areas?
```

**Full specification (no prompts needed):**
```
"Analyze all Canny and Zendesk feedback for Email from Q4 2025,
 showing individual items with at least 5 customers"
→ Skill confirms scope and proceeds
```

## Key Features

### ✅ Multi-Source Integration
- **Canny:** Feature requests, votes, comments, scores
- **Zendesk:** Support tickets, priority levels, customer context
- **Gong:** Call transcripts, sentiment analysis, urgency indicators
- **Planhat:** Customer success data, health scores, CSM conversations, churn risk

### ✅ Individual Feature Request Tracking (Default)
- Each distinct feature request is a separate, actionable line item
- NO generic clustering by default (avoids "Reporting Improvements" vagueness)
- Organized by product area (Email, Advertising, Fundraising, etc.)

### ✅ Optional Specific Clustering
- User can request "cluster feedback" for high-volume analyses
- Clustering uses SPECIFIC themes (e.g., "Flight-level email activity tables")
- NOT generic themes (e.g., "Email improvements")

### ✅ 4-Factor Prioritization
1. **Frequency (30%):** Count of distinct customers/mentions
2. **Recency (25%):** Time-weighted score (recent = higher priority)
3. **Urgency (25%):** Sentiment analysis from all sources
4. **Complexity (20%):** Cross-feature impact analysis (inverse)

### ✅ Incremental Analysis Mode
- Analyze feedback since last run
- Compare to previous analysis with trend tracking
- Mark items as: 🆕 New, 🔺 Growing, 🔻 Declining, ➡️ Stable

### ✅ State Persistence
- Metadata stored in analysis reports for future comparison
- JSON snapshot of items with scores for trend tracking
- Historical file retention (no archiving needed)

### ✅ PRD-Ready Output
- Problem statements formatted for immediate PRD creation
- Customer quotes and context from all sources
- Cross-feature impact analysis
- Complexity estimates (user-reviewable)
- Optional handoff to PRD skill

## File Structure

```
customer-feedback-analysis/
├── SKILL.md                           # Main skill definition (3,390 words)
├── README.md                          # This file
├── references/
│   ├── analysis-framework.md          # Detailed methodology (individual vs. clustered)
│   ├── mcp-integration-guide.md       # Canny, Zendesk, Gong, Planhat tool usage
│   ├── prioritization-rubric.md      # Scoring formulas and examples
│   └── output-examples.md             # Report formatting reference
├── examples/
│   ├── canny-data-sample.json         # Sample Canny API response
│   ├── zendesk-tickets-sample.json    # Sample Zendesk API response
│   ├── gong-transcript-sample.txt     # Sample call transcript
│   └── full-analysis-output.md        # Complete analysis report example
└── scripts/
    ├── validate-feedback-sources.sh   # Test MCP connectivity
    └── format-analysis-report.sh      # Generate report template
```

## Output Location

Analysis reports are saved to:
```
/Users/abhaykhurana/feathr/docs/feedback-analysis/YYYY-MM-DD-feedback-analysis.md
```

## Comparison to Legacy Agent

| Feature | Legacy Agent | New Skill |
|---------|--------------|-----------|
| **Invocation** | Manual (`invoke feedback-analyzer`) | Auto-discovered |
| **Data Sources** | Canny only (manual exports) | Canny + Zendesk + Gong + Planhat (MCP) |
| **Organization** | Thematic clustering (too generic) | ✅ Individual items (default) |
| **Prioritization** | Vote count + ARR | 4-factor scoring |
| **Incremental Mode** | ❌ No | ✅ Yes |
| **Trend Tracking** | ❌ No | ✅ Yes |
| **Tone/Urgency** | ❌ No | ✅ Yes |
| **Complexity Scoring** | ❌ No | ✅ Yes (auto + user review) |
| **State Persistence** | ❌ No | ✅ Yes |
| **PRD Integration** | Basic statements | PRD-ready + handoff |

## Usage Examples

### Full Review Mode

```
User: "Analyze all customer feedback from the last 90 days"

Skill will:
1. Prompt for date range confirmation
2. Fetch data from Canny, Zendesk, Gong, Planhat
3. Organize as individual feature requests
4. Score each item (frequency, recency, urgency, complexity)
5. Generate PRD-ready problem statements
6. Save report with metadata for future runs
```

### Incremental Mode

```
User: "Analyze recent feedback since last run"

Skill will:
1. Read previous analysis metadata
2. Fetch only new/updated data since last run
3. Compare to previous analysis
4. Show trends: Growing, Declining, Stable, New
5. Generate report with trend analysis section
```

### With Clustering (Optional)

```
User: "Analyze Q4 2025 feedback and cluster similar requests"

Skill will:
1. Follow full review workflow
2. Create SPECIFIC clusters (not generic themes)
3. Example: "Flight-level email activity tables" NOT "Email improvements"
4. List individual items within each cluster
```

## Design Decisions

Based on user input, the following design decisions were finalized:

1. **Default:** Individual feature requests (no clustering)
2. **Incremental mode trigger:** User specifies in request ("recent" vs. "all")
3. **Date range:** User-specified (with 90-day default suggestion)
4. **Complexity estimates:** Auto-estimated, then user reviews/overrides
5. **Customer data:** Include names, emails, ARR (internal use)
6. **Trend threshold:** ±20% for growing/declining classification
7. **File management:** Keep all historical files (no archiving)
8. **PRD integration:** Offer handoff at end of analysis

## Key Differentiator

**The most critical improvement:** Removing broad thematic clustering as the default. Each distinct feature request is now a separate, actionable line item—directly translatable to PRDs without the "generic clustering" problem. Clustering is only used when explicitly requested by the user, and even then, follows strict rules to create SPECIFIC themes (e.g., "Flight-level email activity tables") not generic ones (e.g., "Reporting & Analytics").

## Next Steps

1. **Test the skill:** Ask to "analyze customer feedback" in Claude Code
2. **Validate MCP tools:** Run `scripts/validate-feedback-sources.sh`
3. **Review examples:** See `examples/full-analysis-output.md` for expected format
4. **Read references:** Detailed methodology in `references/` directory

## Legacy Agent Status

The previous `feedback-analyzer` agent has been marked as **[DEPRECATED]** with a notice pointing users to this new skill. The agent file is preserved for reference but should not be used for new analyses.

---

**Version:** 1.1.0
**Last Updated:** 2026-01-29
**Author:** Claude Code Implementation
