#!/bin/bash
#
# Format Analysis Report - Report Template Generator
#
# This script generates a template markdown file for feedback analysis reports
# with all the standard sections and metadata placeholders.
#
# Usage: ./format-analysis-report.sh [output_file]
#
# Example: ./format-analysis-report.sh ~/feathr/docs/feedback-analysis/2026-01-17-feedback-analysis.md

set -e

# Default output location if not specified
OUTPUT_FILE="${1:-$(pwd)/feedback-analysis-$(date +%Y-%m-%d).md}"

# Get date info
ANALYSIS_DATE=$(date +%Y-%m-%d)
START_DATE=$(date -v-90d +%Y-%m-%d 2>/dev/null || date -d '90 days ago' +%Y-%m-%d)
END_DATE=$(date +%Y-%m-%d)

echo "Generating feedback analysis report template..."
echo "Output file: $OUTPUT_FILE"

# Create the template
cat > "$OUTPUT_FILE" << 'EOF'
# Feathr Customer Feedback Analysis

**Analysis Date:** YYYY-MM-DD
**Analysis Type:** [Full Review | Incremental Since YYYY-MM-DD]
**Date Range:** YYYY-MM-DD to YYYY-MM-DD
**Sources:** Canny (N posts), Zendesk (N tickets), Gong (N calls)
**Clustering:** [Disabled (distinct items) | Enabled (specific themes)]

## Executive Summary

**Top 5 Priorities:**
1. [Feature Name] (Score: XX.X) - [Brief context]
2. [Feature Name] (Score: XX.X) - [Brief context]
3. [Feature Name] (Score: XX.X) - [Brief context]
4. [Feature Name] (Score: XX.X) - [Brief context]
5. [Feature Name] (Score: XX.X) - [Brief context]

**Urgent Items Requiring Attention:**
- [Item with churn risk or compliance concern]

**Key Patterns:**
- [Pattern 1]
- [Pattern 2]
- [Pattern 3]

---

## 1. Prioritized Feature Requests by Product Area

### Email (N items)

| # | Feature/Problem | Score | Freq | Recency | Urgency | Complexity | Customers | Sources |
|---|-----------------|-------|------|---------|---------|------------|-----------|---------|
| 1 | [Feature name] | XX.X | XX | XX | XX | XX | N | [Sources] |

#### Item 1: [Feature Name]

**Customer Quotes:**
- **Canny** (Post #XXXX, N votes): "[Quote]"
- **Zendesk** (Ticket #XXXX, Priority): "[Quote]"
- **Gong** (Call YYYY-MM-DD, Customer Name, Org): "[Quote]"

**Cross-Feature Impact:**
- [Area 1]: [Description]
- [Area 2]: [Description]

**Affected Tiers:** [Light | Essential | Advanced]

**Complexity Estimate:** N weeks
- [Work breakdown]

**Customer Details:**
- [Customer Name] (email@org.com, $XXK ARR)
- [Continue...]

---

### Advertising (N items)

[Same format as Email section]

---

### Fundraising (N items)

[Same format as Email section]

---

### Integrations (N items)

[Same format as Email section]

---

### Data & Reporting (N items)

[Same format as Email section]

---

### Platform (N items)

[Same format as Email section]

---

## 2. PRD-Ready Problem Statements

### #1: [Feature Name] (Score: XX.X)

**Problem Statement:**
"[User Type] needs [capability] because [pain point], resulting in [quantifiable impact]."

**Context:**
- **Demand:** N customers, X Canny votes, Y Zendesk tickets, Z Gong calls
- **ARR Impact:** $XXXk across affected customers
- **Urgency:** [Description of urgency signals]
- **Frequency:** [Mention count and pattern]
- **Recency:** [Most recent mention details]
- **Complexity:** [Estimated effort and areas affected]
- **Competitive Gap:** [Competitor comparison if applicable]

**Representative Quotes:**
- [Quote 1]
- [Quote 2]
- [Quote 3]

**Affected Customers (top 10 by ARR):**
- [Customer list]

---

[Repeat for #2-5]

---

## 3. Trend Analysis (Incremental mode only)

### Growing Trends (≥20% increase)

| Feature/Problem | Current Score | Previous Score | Delta | Customers | Notes |
|-----------------|---------------|----------------|-------|-----------|-------|
| [Feature] | XX.X | YY.Y | +ZZ.Z% | N (+M) | [Context] |

### Stable Trends (±20%)

| Feature/Problem | Current Score | Previous Score | Delta | Customers | Notes |
|-----------------|---------------|----------------|-------|-----------|-------|
| [Feature] | XX.X | YY.Y | +/-ZZ.Z% | N | [Context] |

### Declining Trends (≥20% decrease)

| Feature/Problem | Current Score | Previous Score | Delta | Customers | Notes |
|-----------------|---------------|----------------|-------|-----------|-------|
| [Feature] | XX.X | YY.Y | -ZZ.Z% | N (-M) | [Context] |

### New Items

- [Feature] (Score: XX.X, N customers)

### Items No Longer Mentioned

- [Feature] (Previous score: XX.X)

---

## 4. Strategic Insights

### Cross-Product Patterns

**[Pattern Category]:**
- [Observation 1]
- [Observation 2]
- Opportunity: [Strategic insight]

### Competitive Considerations

**[Competitor Category]:**
- Competitors have: [Feature list]
- Feathr gap: [Description]
- Risk/Opportunity: [Strategic insight]

### Roadmap Implications

**Quick Wins (≤4 weeks, high impact):**
- [Feature] (Score: XX.X, N weeks)

**Medium Efforts (4-8 weeks, high impact):**
- [Feature] (Score: XX.X, N weeks)

**Strategic Bets (8+ weeks, high impact):**
- [Feature] (Score: XX.X, N weeks)

**Suggested Sprint Planning:**
- Q1 Sprint 1-2: [Features]
- Q1 Sprint 3: [Features]
- Q2: [Features]

---

## Metadata for Next Run

- **Analysis date:** YYYY-MM-DD
- **Date range:** YYYY-MM-DD to YYYY-MM-DD
- **Sources queried:** Canny (N posts), Zendesk (N tickets), Gong (N calls)
- **Items analyzed:** N distinct feature requests
- **Customers represented:** N unique customers
- **Total ARR represented:** $X.XM across all feedback
- **Items snapshot (JSON):**

```json
{
  "feature-slug": {
    "name": "Feature Name",
    "score": 85.5,
    "frequency": 80,
    "recency": 100,
    "urgency": 95,
    "complexity": 65,
    "area": "Email",
    "customers": 18,
    "arr": 450000,
    "sources": {"canny": 15, "zendesk": 2, "gong": 1}
  }
}
```
EOF

# Replace placeholders with actual dates
sed -i.bak "s/YYYY-MM-DD (first occurrence)/$ANALYSIS_DATE/" "$OUTPUT_FILE" 2>/dev/null || \
sed -i "s/YYYY-MM-DD (first occurrence)/$ANALYSIS_DATE/" "$OUTPUT_FILE" 2>/dev/null || true

echo ""
echo "✓ Template created: $OUTPUT_FILE"
echo ""
echo "Next steps:"
echo "1. Run feedback analysis skill to populate template"
echo "2. Review and adjust complexity estimates"
echo "3. Finalize and save to docs/feedback-analysis/"
echo ""
