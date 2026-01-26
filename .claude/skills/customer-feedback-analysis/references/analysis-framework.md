# Analysis Framework - Detailed Methodology

This document provides detailed guidance on organizing, analyzing, and scoring customer feedback for roadmap prioritization.

## Default Organization Approach (No Clustering)

### Core Principle

By default, treat each distinct feature request or customer problem as its own line item. This maximizes actionability and eliminates the "generic clustering" problem that makes feedback analyses too vague to act on.

### Identifying Distinct Feature Requests

A feature request is "distinct" when it:
- Solves a different user problem or addresses a different pain point
- Requires a different technical implementation
- Affects different product areas or workflows
- Serves different user personas or use cases

### When to Keep Items Separate

**Example scenario:** Flight-level email data

Keep these as separate items:
1. ✅ "Flight-level email activity tables in dashboard"
2. ✅ "Export email performance data with flight-level granularity"
3. ✅ "API endpoint for programmatic access to flight-level metrics"
4. ✅ "Email automation rules based on flight-level performance"

**Why separate?** Each requires different implementation:
- #1 = UI/dashboard work
- #2 = Data export functionality
- #3 = API development
- #4 = Automation engine changes

Even though they all relate to "flight-level email data," they solve different problems for different workflows.

### When Items Can Be Combined

Combine items only when they are **the exact same feature request** worded differently:

**Example:**
- Canny: "See email stats broken down by individual flights, not just campaigns"
- Zendesk: "Can we get a table showing performance for each email send?"
- Gong: "We need to see open rates for each individual email in a campaign"

These are clearly the same underlying request (flight-level activity tables), so they can be combined into a single line item with multiple source references.

### Organizing by Product Area

Group items within these primary product areas:

**Email:**
- Campaign management, templates, sending, deliverability
- Email automation and workflows
- Email performance and analytics

**Advertising:**
- Display ads, search ads, Meta ads
- Pixl/Pixl Plus tracking
- Ad campaign management and optimization
- Lookalike audiences

**Fundraising:**
- Donation forms and landing pages
- Growth Credits and tipping
- Payment processing
- Donor management

**Integrations:**
- CRM sync (Salesforce NPSP, RE NXT)
- Data imports and exports
- API and webhooks
- Third-party tool integrations

**Data & Reporting:**
- Dashboards and analytics
- Person records and profiles
- Segmentation and audience building
- Data visualization and exports

**Platform:**
- User management and permissions
- Account settings and configuration
- Infrastructure and performance
- Security and compliance

## Optional Clustering Guidelines (User-Requested)

### When to Use Clustering

Use clustering mode only when:
- User explicitly requests "cluster feedback" or "group similar themes"
- Feedback volume is very high (hundreds of items) and individual presentation would be overwhelming
- Analysis covers a very long time period (6+ months, quarterly/annual reviews)

### Rules for Specific, Concrete Clustering

#### ❌ Anti-Pattern: Generic Themes

Do NOT create clusters like:
- "Reporting & Analytics Improvements"
- "Email Enhancements"
- "User Experience Updates"
- "Integration Capabilities"
- "Dashboard Enhancements"

**Why?** These are too vague to act on. You can't write a PRD for "Reporting Improvements"—you need to know exactly what improvement is being requested.

#### ✅ Best Practice: Specific Themes

DO create clusters like:
- "Flight-level email activity tables"
- "Lookalike audience attribution in Pixl Plus reports"
- "Browser language auto-translation for donation forms"
- "Granular content editor role without audience management access"
- "Automated RE NXT sync for recurring gifts"

**Why?** These describe specific, concrete features that can be directly translated into PRDs and development work.

### Clustering Process

**Step 1: Identify truly identical requests**

Look for feedback that describes the same underlying feature/problem:
- Same user workflow
- Same pain point
- Same desired outcome
- Just worded differently

**Step 2: Name the cluster specifically**

Use the most specific, concrete description available:
- Prefer technical/product terms over generic language
- Include the "what" and "where" in the name
- Avoid adjectives like "better", "improved", "enhanced"

**Good cluster names:**
- "Multi-day event registration with session selection" (not "Event improvements")
- "CSV import for bulk person record updates" (not "Data import enhancements")
- "Scheduled report delivery via email" (not "Reporting automation")

**Step 3: List individual feedback within cluster**

For each cluster, show:
- All distinct feedback items (Canny posts, Zendesk tickets, Gong mentions)
- Specific quotes from each source
- Customer information for each mention

**Step 4: Aggregate scoring**

When clustering:
- **Frequency:** Sum all mentions across items in cluster
- **Recency:** Use most recent timestamp across all items
- **Urgency:** Use highest urgency indicator across all items
- **Complexity:** Estimate for the combined feature (may be higher than individual items)

### Detecting Truly Identical Requests

Use these signals to determine if items should be clustered:

**Strong signals (cluster these):**
- Same feature name used across sources
- Same user workflow described
- Same pain point articulated
- Same expected outcome
- Cross-references between sources (e.g., Zendesk ticket mentions Canny post)

**Weak signals (keep separate):**
- Both mention the same product area (e.g., "email")
- Both are about "reporting" or "analytics"
- Both would improve "user experience"
- Both are requested by similar personas

**Example comparison:**

**Item A:** "Export email performance data with flight-level granularity"
**Item B:** "API endpoint for programmatic access to flight-level email metrics"

**Should these cluster?**
- ❌ Same product area? Yes, but not sufficient
- ❌ Same underlying data? Yes, but not sufficient
- ❌ Same user workflow? No - one is manual export, one is API integration
- ❌ Same pain point? No - one is about ad-hoc analysis, one is about automation
- ✅ Same technical implementation? No - different features

**Verdict:** Keep separate. These solve different problems despite sharing similar data.

## Frequency Calculation Methodology

### Counting Distinct Mentions

**Goal:** Count how many times customers mention this feature/problem across all sources.

**Basic counting:**
- 1 Canny post with 15 votes = 15 mentions (each vote is a distinct customer)
- 1 Zendesk ticket = 1 mention
- 1 Gong call transcript mentioning the feature = 1 mention

**Cross-source deduplication:**

If the same customer appears in multiple sources mentioning the same feature:
- Count them once for frequency
- Note multi-source mention in item details (shows stronger signal)

**Example:**
- Canny post from "ACME Nonprofit" with 5 votes
- Zendesk ticket from "ACME Nonprofit" (jane@acme.org)
- Gong call with "ACME Nonprofit" representative

Frequency count: **6 mentions** (5 Canny votes + 1 Zendesk, Gong is same customer as Zendesk)

Note in details: "ACME Nonprofit mentioned across all three sources (Canny, Zendesk, Gong)"

### Handling Vote Counts vs. Mentions

**Canny votes:** Each vote represents one customer who wants this feature
- Post with 20 votes = 20 mentions

**Canny comments:** Do NOT count each comment as a separate mention
- Comments provide context and sentiment, not additional frequency
- Only count the vote from the commenter (already included in vote count)

**Zendesk tickets:** Each ticket = 1 mention
- If multiple tickets from the same customer about the same feature, count once

**Gong calls:** Each call mentioning the feature = 1 mention
- If feature mentioned multiple times in same call, count once
- If same customer mentions feature in multiple calls, count each call

### Frequency Scoring Rubric

Map mention count to 0-100 score:

| Mention Count | Score | Interpretation |
|---------------|-------|----------------|
| 1-2 | 20 | Isolated request, low frequency |
| 3-5 | 40 | Multiple customers, emerging pattern |
| 6-10 | 60 | Clear demand, medium frequency |
| 11-20 | 80 | Strong demand, high frequency |
| 21+ | 100 | Very strong demand, very high frequency |

## Recency Time-Weighting Formulas

### Goal

Prioritize recently mentioned feedback over older feedback, even if older feedback has higher total mentions.

### Date Parsing and Normalization

Extract timestamps from each source:
- **Canny:** `created` timestamp (for full review) or `updated` timestamp (for incremental)
- **Zendesk:** `created_at` (for full review) or `updated_at` (for incremental)
- **Gong:** Call `started` timestamp

Normalize all to ISO 8601 format (YYYY-MM-DD) for comparison.

### Time-Decay Calculation

**Step 1: Find most recent mention**

For each feature/problem, find the most recent timestamp across all sources.

**Step 2: Calculate days since mention**

```
days_since = today's date - most recent mention date
```

**Step 3: Map to recency score**

| Days Since | Score | Interpretation |
|------------|-------|----------------|
| 0-7 days | 100 | Within past week, very recent |
| 8-30 days | 80 | Within past month, recent |
| 31-90 days | 60 | Within past quarter, moderately recent |
| 91-180 days | 40 | Within past 6 months, older |
| 181+ days | 20 | Older than 6 months, stale |

**Example:**

Feature mentioned on:
- Canny: 2025-11-15
- Zendesk: 2025-12-20
- Gong: 2026-01-10

Most recent: 2026-01-10
Today: 2026-01-17
Days since: 7 days
Recency score: **100**

## Tone/Urgency Indicators

### Goal

Identify feedback that signals high urgency, frustration, or churn risk—these need faster action even if frequency is lower.

### Gong Transcript Keywords

**High urgency indicators (score: 80-100):**
- "urgent", "urgently", "as soon as possible", "ASAP"
- "blocker", "blocking us", "can't proceed"
- "frustrated", "frustrating", "disappointed"
- "considering alternatives", "looking at other tools"
- "switching to", "moving to", "evaluating [competitor]"
- "deal breaker", "must have", "non-negotiable"

**Medium urgency indicators (score: 50-70):**
- "important", "priority", "need soon"
- "workaround", "manual process", "inefficient"
- "would really help", "would save us time"
- "requested by leadership", "board wants"

**Low urgency indicators (score: 20-40):**
- "nice to have", "would be cool", "someday"
- "not urgent", "low priority"
- "when you get to it"

### Zendesk Priority Mapping

Map Zendesk ticket priority directly to urgency score:

| Priority Level | Score |
|----------------|-------|
| Urgent | 100 |
| High | 75 |
| Normal | 50 |
| Low | 25 |

### Canny Comment Sentiment Analysis

Review comments on Canny posts for sentiment indicators:

**High urgency signals:**
- Angry or frustrated tone
- Mentions of churn or cancellation
- Comparisons to competitors who have the feature
- Executive/leadership pressure mentioned

**Medium urgency signals:**
- Multiple follow-up comments asking "any updates?"
- Detailed use cases showing importance
- Mentions of workarounds being painful

**Low urgency signals:**
- Positive, patient tone
- "Would be nice" language
- No follow-up activity

### Aggregating Urgency Across Sources

When a feature is mentioned in multiple sources with different urgency levels:

**Use the highest urgency score** across all sources.

**Rationale:** If even one customer is highly urgent/frustrated, that signals risk and need for action.

**Example:**

Feature mentioned in:
- Canny: 10 votes, comments mostly "would be nice" (urgency: 40)
- Zendesk: 2 tickets, both "normal" priority (urgency: 50)
- Gong: 1 call with "frustrated, considering alternatives" (urgency: 90)

**Final urgency score: 90** (highest across sources)

## Technical Complexity Rubric

### Goal

Estimate development effort to balance "quick wins" against "strategic bets" in prioritization.

### Cross-Feature Impact Scoring

Use Feathr's 7-point framework to count how many areas are affected:

1. Person Records
2. Segmentation & Targeting
3. Reporting & Analytics
4. Billing & Credits
5. CRM Integration
6. Campaign Goals
7. Other Platform Touchpoints

**Base complexity score:**

| Areas Affected | Base Score | Estimated Effort |
|----------------|------------|------------------|
| 1-2 areas | 100 | Low: 1-2 weeks |
| 3-4 areas | 70 | Medium-low: 2-4 weeks |
| 5-6 areas | 40 | Medium-high: 4-8 weeks |
| 7+ areas | 20 | High: 8+ weeks |

### Complexity Adjustments

Apply these adjustments to base score:

**CRM integration required:** -10 points
- Salesforce NPSP or RE NXT sync changes
- New field mappings
- Custom object updates

**Data model changes:** -15 points
- New database tables
- New fields on existing tables
- Schema migrations
- Backwards compatibility considerations

**Payment/billing changes:** -10 points
- Stripe integration modifications
- Growth Credits calculations
- Financial transaction handling
- PCI compliance considerations

**Example calculation:**

Feature: "Automated RE NXT sync for recurring gifts"

Areas affected:
1. Person Records (recurring donor flag)
2. CRM Integration (RE NXT sync)
3. Billing & Credits (recurring transactions)
4. Reporting & Analytics (recurring gift reports)

Base score: 70 (4 areas, medium-low complexity)

Adjustments:
- CRM integration: -10
- Payment/billing: -10

**Final complexity score: 50**

### Detailed Examples with Estimates

**Low Complexity Example (100 points, 1-2 weeks):**

Feature: "Add flight name to email activity CSV export"

Areas affected:
- Reporting & Analytics (CSV export format)

No adjustments needed.

Estimate: 1 week (add column to export, update tests)

---

**Medium Complexity Example (60 points, 3-4 weeks):**

Feature: "Flight-level email activity tables in dashboard"

Areas affected:
1. Reporting & Analytics (new dashboard widget)
2. Person Records (activity detail view)
3. Campaign Goals (goal tracking at flight level)

No major adjustments (no CRM, data model changes are minor)

Estimate: 3-4 weeks (UI work, data aggregation, testing)

---

**High Complexity Example (25 points, 8-10 weeks):**

Feature: "Browser language auto-translation for donation forms"

Areas affected:
1. Fundraising (form builder, form display)
2. Person Records (language preference tracking)
3. Reporting & Analytics (donations by language)
4. CRM Integration (language field sync)
5. Billing & Credits (multi-currency considerations)
6. Other Platform Touchpoints (email receipts in donor language)

Adjustments:
- CRM integration: -10
- Data model changes (language field): -15

Base score: 40 (6 areas)
Final score: 15

Estimate: 8-10 weeks (translation API integration, form builder updates, CRM sync, multi-currency handling, extensive testing)

## Trend Comparison Algorithms

### Goal

When running incremental analysis, compare current feedback to previous run to identify growing, declining, or stable trends.

### Matching Items Across Runs

**Step 1: Read previous analysis metadata**

Extract "Items snapshot" JSON from previous analysis report.

**Step 2: Match items by name/description**

For each item in current analysis:
- Look for item with same or very similar name in previous snapshot
- Use fuzzy matching if names don't match exactly (90%+ similarity threshold)
- If no match found, mark as "🆕 New"

**Step 3: Extract previous scores**

For matched items, extract:
- Previous final score
- Previous frequency, recency, urgency, complexity scores

### Score Delta Calculations

**Formula:**

```
delta_percentage = ((current_score - previous_score) / previous_score) × 100
```

**Example:**

Item: "Flight-level email activity tables"
- Previous score: 72.0
- Current score: 85.5

Delta: ((85.5 - 72.0) / 72.0) × 100 = +18.75%

### Trend Classification Thresholds

Map delta percentage to trend marker:

| Delta Range | Marker | Interpretation |
|-------------|--------|----------------|
| ≥ +20% | 🔺 Growing | Significant increase in priority |
| +5% to +19.9% | ➡️ Stable | Slight increase, relatively stable |
| -4.9% to +4.9% | ➡️ Stable | No significant change |
| -5% to -19.9% | ➡️ Stable | Slight decrease, relatively stable |
| ≤ -20% | 🔻 Declining | Significant decrease in priority |

**Special cases:**

- **New item (no previous match):** 🆕 New
- **Item in previous but not current:** ⚠️ No longer mentioned (show in separate section)

### Trend Analysis Table Format

```markdown
## 3. Trend Analysis

| Feature/Problem | Current Score | Previous Score | Delta | Trend | Notes |
|-----------------|---------------|----------------|-------|-------|-------|
| Flight-level email activity | 85.5 | 72.0 | +18.8% | ➡️ Stable | 3 new mentions since last run |
| Lookalike attribution | 78.0 | 62.0 | +25.8% | 🔺 Growing | High urgency in recent Gong call |
| RE NXT recurring sync | 65.0 | 68.0 | -4.4% | ➡️ Stable | No new mentions |
| Email template library | 45.0 | 58.0 | -22.4% | 🔻 Declining | Workarounds adopted |

### Items No Longer Mentioned
- "Multi-day event registration" (previous score: 52.0) - not mentioned in current analysis period
```

### Explaining Trend Changes

For items with significant changes (≥20%), add context in notes column:
- New mentions or customers
- Urgency changes (Gong frustration, Zendesk escalations)
- Competitive pressure
- Workarounds adopted (for declining trends)

**Example notes:**

**Growing trends:**
- "5 new Canny votes since last run"
- "Mentioned in 3 recent Gong calls with churn risk language"
- "Competitor launched this feature, customers asking why we don't have it"

**Declining trends:**
- "Customers found acceptable workaround via CSV exports"
- "No new mentions in past 60 days"
- "Lower priority after [related feature] launched"

## Summary: Key Decision Points

When analyzing feedback, make these key decisions:

1. **Clustering or individual items?**
   - Default: Individual items (more actionable)
   - Optional: Clustering only if user requests AND can create specific themes

2. **How to organize?**
   - Group by product area (Email, Advertising, etc.)
   - Sort by priority score within each area
   - Present highest-value items first

3. **How to score?**
   - 4-factor model: Frequency (30%), Recency (25%), Urgency (25%), Complexity (20%)
   - Use rubrics consistently
   - Allow user to override complexity estimates

4. **How to track trends?**
   - Match items across runs by name similarity
   - Calculate score deltas
   - Use ±20% threshold for growing/declining classification
   - Explain significant changes in notes

5. **How to make it actionable?**
   - Every item should be specific enough for PRD creation
   - Include customer quotes and context
   - Map to product areas and cross-feature impacts
   - Generate PRD-ready problem statements for top items

This framework ensures consistent, rigorous analysis that product teams can act on immediately.
