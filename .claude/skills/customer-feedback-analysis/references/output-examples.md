# Output Examples - Report Formatting Reference

This document provides quick-reference examples of proper report formatting and structure.

## Report Header Example

```markdown
# Feathr Customer Feedback Analysis
**Analysis Date:** 2026-01-17
**Analysis Type:** Full Review
**Date Range:** 2025-10-18 to 2026-01-17 (90 days)
**Sources:** Canny (47 posts), Zendesk (89 tickets), Gong (23 calls)
**Clustering:** Disabled (distinct items presented individually)
```

## Executive Summary Example

```markdown
## Executive Summary

**Top 5 Priorities:**
1. Flight-level email activity tables (Score: 85.5) - 18 customers, high urgency, churn risk
2. Lookalike audience attribution in Pixl Plus reports (Score: 78.0) - 12 customers, recent surge
3. Automated RE NXT sync for recurring gifts (Score: 72.5) - 8 customers, enterprise demand
4. Granular content editor role permissions (Score: 68.0) - 15 customers, security concern
5. Browser language auto-translation for donation forms (Score: 65.5) - 20 customers, competitive gap

**Urgent Items Requiring Attention:**
- Flight-level email activity (churn risk language in recent Gong call)
- Granular content editor permissions (security concerns from enterprise customers)

**Key Patterns:**
- Email reporting gaps are most frequent pain point (3 of top 10 items)
- Fundraising feature requests increased 40% vs. previous quarter
- Integration requests focused on RE NXT (Salesforce well-supported)
```

## Product Area Section Example (Individual Items - Default)

```markdown
### Email (8 items)

| # | Feature/Problem | Score | Freq | Recency | Urgency | Complexity | Customers | Sources |
|---|-----------------|-------|------|---------|---------|------------|-----------|---------|
| 1 | Flight-level email activity tables | 85.5 | 80 | 100 | 95 | 65 | 18 | Canny (15 votes), Zendesk (2 tickets), Gong (1 call) |
| 2 | Export email performance with flight-level granularity | 72.0 | 65 | 85 | 70 | 75 | 12 | Canny (10 votes), Zendesk (1 ticket) |
| 3 | Email automation rules based on flight performance | 68.5 | 60 | 80 | 65 | 55 | 11 | Canny (8 votes), Gong (1 call) |

#### Item 1: Flight-level email activity tables

**Customer Quotes:**
- **Canny** (Post #1234, 15 votes): "We need to see email performance broken down by individual flights (sends), not just rolled up at the campaign level. This would help us understand which specific emails performed best."
- **Zendesk** (Ticket #5678, High priority): "Currently we have to export CSVs and manually analyze in Excel, which takes hours every week. Need dashboard tables showing opens/clicks per flight."
- **Gong** (Call 2026-01-10, Jane Smith, ACME Nonprofit): "One thing that's been frustrating for our team is not being able to see email performance at the flight level. Honestly, if we don't get better reporting tools soon, we're going to have to look at alternatives."

**Cross-Feature Impact:**
- Person Records (activity detail view)
- Reporting & Analytics (new dashboard widget)
- Campaign Goals (goal tracking at flight level)

**Affected Tiers:** Essential, Advanced

**Customer Details:**
- ACME Nonprofit (jane@acmenonprofit.org, $45K ARR)
- Helping Hands NPO (bob@helpinghands.org, $28K ARR)
- Community First (sarah@communityfirst.org, $38K ARR)
- [15 more customers...]

---
```

## Product Area Section Example (Clustered Items - Optional)

```markdown
### Email (6 themes)

| # | Theme | Score | Items | Freq | Recency | Urgency | Complexity | Customers |
|---|-------|-------|-------|------|---------|---------|------------|-----------|
| 1 | Flight-level email activity tables | 85.5 | 3 | 80 | 100 | 95 | 65 | 18 |
| 2 | Email template organization and management | 74.0 | 4 | 75 | 90 | 60 | 80 | 22 |

#### Theme 1: Flight-level email activity tables

**Clustered Feedback:**
- **Item 1** (Canny #1234): "See email stats broken down by individual flights"
- **Item 2** (Zendesk #5678): "Dashboard table showing opens/clicks per flight"
- **Item 3** (Gong Call 2026-01-10): "Need visibility into which specific email sends performed best"

**Customer Quotes:** [Same as individual format]
**Cross-Feature Impact:** [Same as individual format]

---
```

## PRD-Ready Problem Statement Example

```markdown
### #1: Flight-level email activity tables (Score: 85.5)

**Problem Statement:**
"Email marketers need flight-level activity tables in the campaign dashboard because they currently cannot see which specific email sends (flights) performed best within a multi-send campaign, resulting in manual CSV exports and Excel analysis for 18+ customers (combined $450K ARR) who request this visibility monthly."

**Context:**
- **Demand:** 18 customers, 15 Canny votes, 2 Zendesk tickets, 1 Gong call
- **ARR Impact:** $450K+ across affected customers
- **Urgency:** Churn risk language in recent Gong call (ACME Nonprofit considering alternatives)
- **Complexity:** 3-4 weeks estimated (UI work, data aggregation, goal tracking updates)
- **Cross-Feature Impact:** Person Records, Reporting & Analytics, Campaign Goals
- **Competitive Gap:** Mailchimp, Constant Contact, and other email platforms provide flight-level reporting

**Representative Quotes:**
- Canny: "We need to see email stats broken down by individual flights, not just campaigns."
- Zendesk: "Takes hours every week to export and analyze flight data manually."
- Gong: "If we don't get better reporting soon, we're going to have to look at alternatives."

**Affected Customers:**
- ACME Nonprofit ($45K ARR)
- Helping Hands NPO ($28K ARR)
- Community First ($38K ARR)
- [15 more...]
```

## Trend Analysis Section Example (Incremental Mode)

```markdown
## 3. Trend Analysis

### Growing Trends (≥20% increase)

| Feature/Problem | Current Score | Previous Score | Delta | Customers | Notes |
|-----------------|---------------|----------------|-------|-----------|-------|
| Lookalike audience attribution | 78.0 | 62.0 | +25.8% | 12 (+3) | High urgency in 2 recent Gong calls; competitive pressure |
| Browser language translation | 65.5 | 52.0 | +26.0% | 20 (+7) | 5 new Canny votes, 2 new Zendesk tickets since last run |

### Stable Trends (±20%)

| Feature/Problem | Current Score | Previous Score | Delta | Customers | Notes |
|-----------------|---------------|----------------|-------|-----------|-------|
| Flight-level email activity | 85.5 | 72.0 | +18.8% | 18 (+3) | Still top priority; new churn risk mention |
| RE NXT recurring sync | 72.5 | 70.0 | +3.6% | 8 (no change) | Sustained demand, no new urgency |

### Declining Trends (≥20% decrease)

| Feature/Problem | Current Score | Previous Score | Delta | Customers | Notes |
|-----------------|---------------|----------------|-------|-----------|-------|
| Email template library | 45.0 | 58.0 | -22.4% | 10 (-5) | Customers found workarounds; less urgent now |

### New Items (Not in Previous Analysis)

- API webhooks for real-time event notifications (Score: 70.0, 9 customers)
- Multi-day event registration with session selection (Score: 62.5, 7 customers)

### Items No Longer Mentioned

- Custom event registration fields (Previous score: 52.0) - Not mentioned in current analysis period
- Multi-currency donation forms (Previous score: 48.0) - Feature launched, requests ceased
```

## Strategic Insights Section Example

```markdown
## 4. Strategic Insights

### Cross-Product Patterns

**Email reporting gaps dominate:**
- 3 of top 10 items are email reporting features
- Pattern: Customers need granular visibility into email performance (flight-level, A/B test results, engagement trends)
- Opportunity: Comprehensive email analytics overhaul could address multiple high-priority items

**Fundraising momentum:**
- 40% increase in fundraising feature requests vs. previous quarter
- Browser translation, recurring gift improvements, anonymous donor support all trending up
- Driver: Q4 fundraising season + competitive pressure (Givebutter, Donorbox have these features)

### Competitive Considerations

**Email competitors (Mailchimp, Constant Contact):**
- Have flight-level reporting, advanced segmentation, A/B testing analytics
- Feathr customers mention these gaps when evaluating alternatives

**Fundraising competitors (Givebutter, Donorbox):**
- Have multi-language support, anonymous donor options, better recurring gift UX
- Feathr at risk of losing fundraising customers without these features

### Roadmap Implications

**Quick Wins (≤4 weeks, high impact):**
- Flight-level email activity tables (Score: 85.5, 3 weeks)
- Email template organization (Score: 74.0, 2 weeks)
- Granular content editor permissions (Score: 68.0, 2 weeks)

**Strategic Bets (8+ weeks, high impact):**
- Browser language auto-translation (Score: 65.5, 8-10 weeks) - addresses competitive gap
- Unified person record redesign (Score: 60.0, 12+ weeks) - foundational for future features

**Enterprise Focus:**
- RE NXT recurring sync (Score: 72.5) - 6 of 8 customers are Advanced tier
- Granular permissions (Score: 68.0) - requested by all enterprise customers
- Consider enterprise-tier roadmap with dedicated resources
```

## Metadata Section Example

```markdown
## Metadata for Next Run

- **Analysis date:** 2026-01-17
- **Date range:** 2025-10-18 to 2026-01-17
- **Sources queried:** Canny (47 posts), Zendesk (89 tickets), Gong (23 calls)
- **Items analyzed:** 42 distinct feature requests
- **Customers represented:** 127 unique customers
- **Items snapshot (JSON):**

```json
{
  "flight-level-email-activity": {
    "name": "Flight-level email activity tables",
    "score": 85.5,
    "frequency": 80,
    "recency": 100,
    "urgency": 95,
    "complexity": 65,
    "area": "Email",
    "customers": 18,
    "arr": 450000
  },
  "lookalike-pixl-reporting": {
    "name": "Lookalike audience attribution in Pixl Plus reports",
    "score": 78.0,
    "frequency": 75,
    "recency": 95,
    "urgency": 80,
    "complexity": 60,
    "area": "Advertising",
    "customers": 12,
    "arr": 320000
  },
  "re-nxt-recurring-sync": {
    "name": "Automated RE NXT sync for recurring gifts",
    "score": 72.5,
    "frequency": 70,
    "recency": 85,
    "urgency": 75,
    "complexity": 50,
    "area": "Integrations",
    "customers": 8,
    "arr": 280000
  }
}
```
```

## Formatting Best Practices

### Tables
- Use markdown tables for scannability
- Keep columns aligned
- Use concise headers (Score, Freq, not "Priority Score", "Frequency Count")
- Limit decimals to 1 place (85.5, not 85.532)

### Customer Data
- Include names, emails, ARR for full context
- Group by organization when multiple contacts from same org
- Use actual data (no redaction needed for internal reports)

### Quotes
- Use **bold** for source label (Canny, Zendesk, Gong)
- Include source ID (Post #1234, Ticket #5678, Call date)
- Use verbatim quotes in "quotation marks"
- Add context in parentheses (customer name, org, date)

### Trend Markers
- 🆕 New (item not in previous analysis)
- 🔺 Growing (≥20% score increase)
- ➡️ Stable (±20%)
- 🔻 Declining (≥20% score decrease)
- ⚠️ No longer mentioned (was in previous, not in current)

### Sections
- Use ## for major sections (Executive Summary, Trend Analysis, etc.)
- Use ### for product areas (Email, Advertising, etc.)
- Use #### for individual items or themes
- Use **bold** for subsection labels (Customer Quotes, Cross-Feature Impact)

### JSON Metadata
- Properly formatted, valid JSON
- Use lowercase-with-hyphens for keys (flight-level-email-activity)
- Include all scoring factors for trend comparison
- Include area, customers, arr for filtering/analysis

---

For complete example reports, see:
- `examples/full-analysis-output.md` - Full review mode with individual items (default)
- `examples/clustered-analysis-output.md` - Clustered mode (optional, user-requested)
- `examples/incremental-analysis-output.md` - Incremental mode with trend comparison
