# Skill Parameters Reference

This document provides a complete reference for all parameters the Customer Feedback Analysis skill uses to scope analysis.

## Parameter Categories

### 1. Required Parameters

These parameters **must** be specified. If not provided in the initial request, the skill will prompt for them.

#### Time Frame

**What it controls:** Date range for feedback analysis

**Options:**
- `Last 30 days` - Monthly review
- `Last 60 days` - Bi-monthly review
- `Last 90 days` - Quarterly review (Recommended)
- `Since last run` - Incremental mode (only if previous analysis exists)
- `Custom date range` - User specifies exact start/end dates (e.g., "Q4 2025", "October 1 to December 31")

**How to specify:**
- Natural language: "last 90 days", "Q4 2025", "since October"
- Slash command: Skill will prompt after `/feedback`

**Default behavior:** No default - skill will always ask if not specified

---

#### Analysis Mode

**What it controls:** Full review (all feedback in range) vs. Incremental (new feedback since last run)

**Options:**
- `Full review` - Analyze all feedback within specified time frame
- `Incremental` - Analyze only new/updated feedback since last analysis

**How to determine:**
- Auto-detected from time frame:
  - "Last N days" → Full review
  - "Since last run" → Incremental
- If ambiguous and previous analysis exists: Skill asks user to choose

**Default behavior:** Full review (if no previous analysis exists)

---

#### Data Sources

**What it controls:** Which feedback sources to query

**Options:**
- `All sources` - Canny + Zendesk + Gong (Recommended)
- `Canny only` - Feature requests, votes, comments
- `Zendesk only` - Support tickets and conversations
- `Gong only` - Customer call transcripts
- `Custom combination` - Specify subset (e.g., "Canny and Zendesk")

**How to specify:**
- Natural language: "analyze Canny feedback", "review all sources"
- Slash command: Skill will prompt after `/feedback`

**Default behavior:** All sources (Canny + Zendesk + Gong)
- If not specified, skill confirms: "I'll analyze all sources. Correct?"

---

### 2. Optional Parameters

These parameters have sensible defaults. Skill only prompts if user mentions them or if context suggests they're relevant.

#### Clustering Preference

**What it controls:** How feedback is organized in the report

**Options:**
- `Individual items` - Each distinct feature request as separate line item (Default)
- `Specific themes` - Cluster similar requests with concrete theme names

**How to specify:**
- Natural language: "cluster feedback", "group similar themes"
- If not mentioned: Default to individual items (no prompt)

**Default behavior:** Individual items (no clustering)

**Important:** Even when clustering, themes must be SPECIFIC (e.g., "Flight-level email activity tables") not generic (e.g., "Email improvements")

---

#### Product Area Focus

**What it controls:** Which product areas to include in analysis

**Options:**
- `All areas` - Email, Advertising, Fundraising, Integrations, Data & Reporting, Platform (Default)
- `Email only` - Email campaigns, templates, deliverability
- `Advertising only` - Pixl/Pixl Plus, Google Ads, Meta
- `Fundraising only` - Donation forms, Growth Credits
- `Integrations only` - CRM sync, API, data imports/exports
- `Data & Reporting only` - Dashboards, person records, segmentation
- `Platform only` - User management, permissions, settings
- `Multiple specific areas` - User specifies subset (e.g., "Email and Fundraising")

**How to specify:**
- Natural language: "email feedback", "analyze advertising and fundraising"
- If not mentioned: Default to all areas (no prompt)

**Default behavior:** All areas

**Effect on report:**
- If focused: Items filtered to specified area(s) only
- Cross-feature impacts still shown even if they touch other areas

---

#### Minimum Customer Count

**What it controls:** Filter threshold - exclude items mentioned by fewer customers

**Options:**
- Any positive integer (e.g., 3, 5, 10)
- No minimum (include all feedback regardless of count)

**How to specify:**
- Natural language: "at least 5 customers", "minimum 10 mentions"
- If not mentioned: No filtering applied (include all)

**Default behavior:** No minimum (include all feedback)

**Effect on report:**
- Items below threshold excluded from results
- Report header notes: "Filtered to items with ≥N customers"

---

#### Minimum Urgency Level

**What it controls:** Filter threshold - exclude items below urgency score

**Options:**
- Urgency score 0-100 (e.g., 70 for "high urgency only")
- No minimum (include all feedback regardless of urgency)

**How to specify:**
- Natural language: "high urgency only", "urgent items", "minimum urgency 70"
- If not mentioned: No filtering applied (include all)

**Default behavior:** No minimum (include all feedback)

**Effect on report:**
- Items below urgency threshold excluded from results
- Report header notes: "Filtered to high-urgency items (score ≥X)"

---

#### Customer Tier Filter

**What it controls:** Which customer tiers to include

**Options:**
- `All tiers` - Light, Essential, Advanced (Default)
- `Light only` - Light tier customers only
- `Essential only` - Essential tier customers only
- `Advanced only` - Advanced tier customers only
- `Multiple tiers` - Subset (e.g., "Essential and Advanced")

**How to specify:**
- Natural language: "Advanced tier feedback", "Essential and Advanced customers"
- If not mentioned: Default to all tiers (no filtering)

**Default behavior:** All tiers (no filtering)

**Effect on report:**
- Items from excluded tiers not included
- Report header notes: "Filtered to [Tier] customers only"

---

## Parameter Gathering Workflow

### Scenario 1: Minimal Invocation

**User input:**
```
/analyze-feedback
```

**Skill behavior:**
1. No parameters provided
2. Prompts with AskUserQuestion for: Time frame, Data sources, Product areas
3. Confirms scope before proceeding

---

### Scenario 2: Partial Specification

**User input:**
```
"Analyze recent email feedback"
```

**Skill behavior:**
1. Detected parameters:
   - Time frame: "recent" (ambiguous - is it incremental or last 30 days?)
   - Product area: "email"
2. Prompts to clarify:
   - Time frame: "Since last run (YYYY-MM-DD) or specify date range?"
   - Data sources: "All sources or email-specific sources?"
3. Confirms scope before proceeding

---

### Scenario 3: Full Specification

**User input:**
```
"Analyze all Canny and Zendesk feedback for Email and Advertising from Q4 2025,
 showing individual items with at least 5 customers"
```

**Skill behavior:**
1. Detected parameters:
   - Time frame: Q4 2025 (October 1 - December 31, 2025)
   - Analysis mode: Full review
   - Data sources: Canny + Zendesk (Gong excluded)
   - Product areas: Email + Advertising
   - Clustering: Individual items
   - Minimum customers: 5
2. Confirms detected scope:
   ```
   Confirmed analysis scope:
   ✓ Time frame: Q4 2025 (2025-10-01 to 2025-12-31)
   ✓ Analysis mode: Full review
   ✓ Data sources: Canny + Zendesk (Gong excluded)
   ✓ Product areas: Email, Advertising
   ✓ Organization: Individual items
   ✓ Minimum customers: 5

   Proceeding to fetch data...
   ```
3. No additional prompts needed

---

### Scenario 4: Ambiguous Specification

**User input:**
```
"Analyze feedback"
```

**Skill behavior:**
1. No parameters detected
2. Checks for previous analysis file:
   - If exists: Shows last run date, asks "Since last run or full review?"
   - If not exists: Prompts for time frame
3. Prompts for data sources and product areas
4. Confirms scope before proceeding

---

## Parameter Validation

Before proceeding with analysis, the skill validates:

### Time Frame Validation
- If custom date range: Ensure end date > start date
- If "since last run": Verify previous analysis file exists
- If quarter specified: Parse to actual dates (Q1 = Jan-Mar, Q2 = Apr-Jun, etc.)

### Data Sources Validation
- Verify MCP tools are available for requested sources
- Warn if source is likely to have limited data for time period
- Example: "Gong calls may be limited for dates >90 days ago"

### Product Area Validation
- Ensure specified areas are valid (Email, Advertising, etc.)
- Warn if area receives low feedback volume
- Example: "Platform feedback typically has lower volume than Email"

### Filter Validation
- If minimum customer count specified: Ensure it's reasonable (1-50 range)
- Warn if filters are too restrictive
- Example: "Minimum 20 customers + high urgency may yield <5 results"

---

## Report Metadata

All parameters are documented in the report header for transparency:

```markdown
# Feathr Customer Feedback Analysis

**Analysis Date:** 2026-01-17
**Analysis Type:** Full Review
**Date Range:** 2025-10-01 to 2025-12-31 (Q4 2025, 92 days)
**Sources:** Canny (42 posts), Zendesk (67 tickets), Gong excluded per user request
**Product Areas:** Email, Advertising (Filtered per user request)
**Clustering:** Disabled (individual items presented)
**Filters Applied:**
- Minimum customers: 5
- Customer tiers: All
```

This ensures future users can understand exactly what was included/excluded from the analysis.

---

## Tips for Effective Parameter Use

1. **Start broad, filter later:** Use default parameters (all sources, all areas, no filters) first, then create focused analyses as needed

2. **Use incremental mode frequently:** After initial full review, use "since last run" for weekly/monthly updates

3. **Product area focus for deep dives:** Use area filters when you need detailed analysis of specific product line

4. **Combine time + urgency filters:** For crisis management, use "Last 30 days + high urgency only"

5. **Tier-specific analyses:** Use tier filters for roadmap planning by customer segment (e.g., "Advanced tier only" for enterprise features)

6. **Document filter rationale:** When using restrictive filters, note why in your request (helps with report interpretation later)

---

## Future Parameter Enhancements

Potential additions for future versions:

- **Competitive filter:** Only show feedback mentioning competitors
- **Churn risk filter:** Only show feedback with churn risk signals
- **Feature category tags:** Filter by specific feature types (e.g., "reporting", "API", "UI/UX")
- **Customer segment:** Filter by ARR bands, industry, organization size
- **Sentiment filter:** Only negative/frustrated feedback
- **Source priority:** Weight certain sources higher in scoring
