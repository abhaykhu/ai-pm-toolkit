# Prioritization Rubric - Scoring Framework

This document provides detailed scoring formulas and rubrics for the four-factor prioritization model used in customer feedback analysis.

## Overview

Every feature request or problem is scored on four factors:

| Factor | Weight | Range | Higher is Better |
|--------|--------|-------|------------------|
| **Frequency** | 30% | 0-100 | Yes - more customers = higher priority |
| **Recency** | 25% | 0-100 | Yes - more recent = higher priority |
| **Urgency** | 25% | 0-100 | Yes - more urgent = higher priority |
| **Complexity** | 20% | 0-100 | Yes - less complex = higher priority (inverse scale) |

**Final Score Calculation:**

```
Final Score = (Frequency × 0.30) + (Recency × 0.25) + (Urgency × 0.25) + (Complexity × 0.20)
```

**Score interpretation:**

| Final Score | Interpretation |
|-------------|----------------|
| 85-100 | Top priority - strong demand, recent, urgent, feasible |
| 70-84 | High priority - multiple strong factors |
| 55-69 | Medium priority - solid case but trade-offs |
| 40-54 | Lower priority - limited demand or high complexity |
| 0-39 | Low priority - consider deferring |

---

## Factor 1: Frequency Scoring

### Definition

Frequency measures how many distinct customers or mentions exist for this feature/problem across all data sources.

### Counting Methodology

**Base count:**
- Canny: Each vote = 1 customer mention
- Zendesk: Each ticket = 1 customer mention
- Gong: Each call mentioning the feature = 1 customer mention

**Cross-source deduplication:**
- If same customer (matched by email) appears in multiple sources, count once
- Note multi-source mentions separately (signals stronger need)

**Example calculation:**

Feature: "Flight-level email activity tables"

Data:
- Canny post: 18 votes
- Zendesk tickets: 3 tickets from 3 different customers
- Gong calls: 2 calls, one from customer already in Canny, one new customer

Frequency count:
- Canny: 18 customers
- Zendesk: 3 customers (all new)
- Gong: 1 new customer (other was in Canny)
- **Total: 22 distinct customers**

### Scoring Rubric

| Mention Count | Score | Interpretation |
|---------------|-------|----------------|
| 1-2 | 20 | Isolated request, may be niche need |
| 3-5 | 40 | Multiple customers, emerging pattern |
| 6-10 | 60 | Clear demand, solid frequency |
| 11-20 | 80 | Strong demand, many customers affected |
| 21-50 | 95 | Very strong demand, broad impact |
| 51+ | 100 | Extremely high demand, critical mass |

### Linear Interpolation Formula

For more precise scoring between thresholds:

```python
def calculate_frequency_score(count):
    if count <= 2:
        return 20
    elif count <= 5:
        return 20 + ((count - 2) / 3) * 20  # Linear from 20 to 40
    elif count <= 10:
        return 40 + ((count - 5) / 5) * 20  # Linear from 40 to 60
    elif count <= 20:
        return 60 + ((count - 10) / 10) * 20  # Linear from 60 to 80
    elif count <= 50:
        return 80 + ((count - 20) / 30) * 15  # Linear from 80 to 95
    else:
        return 100
```

**Examples:**
- 8 mentions → 40 + ((8-5)/5)*20 = 40 + 12 = **52 points**
- 15 mentions → 60 + ((15-10)/10)*20 = 60 + 10 = **70 points**
- 35 mentions → 80 + ((35-20)/30)*15 = 80 + 7.5 = **87.5 points**

### Special Cases

**Single customer, multiple channels:**
- If one customer mentions in Canny + Zendesk + Gong: Count as 1 for frequency
- Note as "Multi-source" in details (shows strength of need)
- May boost urgency score instead

**Vote inflation:**
- If Canny post has unusually high votes (50+) but no other source mentions:
  - Use full count but flag for validation
  - May indicate viral post or coordinated voting
  - Check comments for genuine demand vs. bandwagon effect

**Zendesk ticket volumes:**
- Multiple tickets from same organization about same issue: Count once
- Tickets from different contacts at same org: Count separately (different users affected)

---

## Factor 2: Recency Scoring

### Definition

Recency measures how recently this feature/problem was mentioned, using time-decay to prioritize current needs over older requests.

### Timestamp Selection

**Use the most recent mention** across all sources:
- Canny: `post.updated` (includes new votes/comments)
- Zendesk: `ticket.updated_at` (includes new comments)
- Gong: `call.started`

**Rationale:** If a feature was mentioned 6 months ago but re-raised this week, it's current again.

### Scoring Rubric

| Days Since Last Mention | Score | Interpretation |
|-------------------------|-------|----------------|
| 0-7 days | 100 | Within past week, very current |
| 8-14 days | 90 | Within past 2 weeks, recent |
| 15-30 days | 80 | Within past month, current |
| 31-60 days | 60 | Within past 2 months, moderately recent |
| 61-90 days | 50 | Within past quarter, aging |
| 91-180 days | 30 | Within past 6 months, older |
| 181-365 days | 15 | Within past year, stale |
| 365+ days | 5 | Over a year old, very stale |

### Linear Interpolation Formula

```python
from datetime import datetime

def calculate_recency_score(most_recent_date):
    today = datetime.now()
    days_since = (today - most_recent_date).days

    if days_since <= 7:
        return 100
    elif days_since <= 14:
        return 100 - ((days_since - 7) / 7) * 10  # Linear from 100 to 90
    elif days_since <= 30:
        return 90 - ((days_since - 14) / 16) * 10  # Linear from 90 to 80
    elif days_since <= 60:
        return 80 - ((days_since - 30) / 30) * 20  # Linear from 80 to 60
    elif days_since <= 90:
        return 60 - ((days_since - 60) / 30) * 10  # Linear from 60 to 50
    elif days_since <= 180:
        return 50 - ((days_since - 90) / 90) * 20  # Linear from 50 to 30
    elif days_since <= 365:
        return 30 - ((days_since - 180) / 185) * 15  # Linear from 30 to 15
    else:
        return 5
```

**Examples:**
- Mentioned 3 days ago → **100 points**
- Mentioned 45 days ago → 80 - ((45-30)/30)*20 = 80 - 10 = **70 points**
- Mentioned 120 days ago → 50 - ((120-90)/90)*20 = 50 - 6.7 = **43.3 points**

### Special Cases

**Multiple recent mentions:**
- If mentioned in all 3 sources within past week: Use 100 (most recent)
- Trending pattern (multiple mentions in short time): Consider boosting urgency instead

**Long-dormant then re-raised:**
- Original request 2 years ago, new mention last week: Score based on last week (100)
- Note in details: "Originally requested [date], recently re-raised"

**Ongoing conversation:**
- Feature discussed in Zendesk thread over several weeks: Use most recent comment date
- Shows sustained interest, may boost frequency or urgency

---

## Factor 3: Urgency Scoring

### Definition

Urgency measures how critical, time-sensitive, or frustration-inducing this feature/problem is based on customer language and support indicators.

### Urgency Sources

1. **Gong call transcripts** - Sentiment keywords
2. **Zendesk ticket priority** - Explicit priority levels
3. **Canny comment sentiment** - Tone and language

**Aggregation rule:** Use the **highest urgency score** across all sources.

**Rationale:** If any customer is highly urgent/frustrated, that signals risk worth addressing.

### Gong Transcript Keywords

**Score: 90-100 (Critical Urgency)**

Keywords indicating churn risk or business blocker:
- "considering alternatives", "looking at other tools", "evaluating [competitor]"
- "switching to", "moving to", "migrating to"
- "deal breaker", "must have", "non-negotiable"
- "blocker", "blocking us", "can't proceed", "can't do our job"
- "losing customers", "churning", "about to cancel"

**Score: 75-85 (High Urgency)**

Keywords indicating strong need or frustration:
- "urgent", "urgently", "ASAP", "as soon as possible"
- "frustrated", "frustrating", "really disappointed"
- "critical", "essential", "mission critical"
- "leadership asking", "executive team needs", "board wants"
- "deadline", "time-sensitive"

**Score: 50-70 (Medium Urgency)**

Keywords indicating importance but not critical:
- "important", "priority", "would really help"
- "inefficient", "time-consuming", "manual workaround"
- "would save us [time/money]", "would improve [workflow]"
- "repeatedly requested", "keep asking about"

**Score: 20-40 (Low Urgency)**

Keywords indicating nice-to-have:
- "nice to have", "would be cool", "someday"
- "enhancement", "improvement", "polish"
- "not urgent", "low priority", "when you get to it"

**Scoring formula:**

```python
def analyze_gong_urgency(transcript_text):
    text_lower = transcript_text.lower()

    # Critical urgency keywords
    if any(kw in text_lower for kw in [
        "considering alternatives", "looking at other tools",
        "switching to", "deal breaker", "blocker", "churning"
    ]):
        return 95

    # High urgency keywords
    if any(kw in text_lower for kw in [
        "urgent", "asap", "frustrated", "critical",
        "leadership asking", "executive team"
    ]):
        return 80

    # Medium urgency keywords
    if any(kw in text_lower for kw in [
        "important", "priority", "inefficient", "time-consuming"
    ]):
        return 60

    # Low urgency keywords
    if any(kw in text_lower for kw in [
        "nice to have", "would be cool", "enhancement", "low priority"
    ]):
        return 30

    # No clear urgency indicators
    return 50
```

### Zendesk Priority Mapping

Direct mapping from Zendesk priority field to urgency score:

| Zendesk Priority | Score | Interpretation |
|------------------|-------|----------------|
| Urgent | 100 | Critical issue, escalated by customer or support |
| High | 75 | Important issue, should be addressed soon |
| Normal | 50 | Standard queue processing, typical request |
| Low | 25 | Minor issue, low customer impact |

### Canny Comment Sentiment

Analyze tone and language in comments:

**Score: 80-100 (High Urgency)**

Indicators:
- Angry or frustrated tone
- Mentions of churn/cancellation ("may not renew", "looking elsewhere")
- Comparisons to competitors having the feature
- Time pressure ("need by [date]", "board meeting next month")
- Multiple follow-ups with escalating frustration

**Score: 50-70 (Medium Urgency)**

Indicators:
- Multiple "any updates?" comments
- Detailed use cases showing importance
- Business impact described (but not critical)
- Workarounds mentioned as painful

**Score: 20-40 (Low Urgency)**

Indicators:
- Positive, patient tone
- "Would be nice", "when you have time" language
- Few follow-ups, no escalation
- Feature framed as enhancement vs. need

**Scoring formula:**

```python
def analyze_canny_urgency(comments):
    if not comments:
        return 50  # Default if no comments

    # Analyze all comments for sentiment signals
    high_urgency_signals = sum(1 for c in comments if any(kw in c.lower() for kw in [
        "frustrated", "disappointed", "may not renew", "looking at",
        "urgent", "need soon", "critical"
    ]))

    follow_up_count = len([c for c in comments if "update" in c.lower() or "status" in c.lower()])

    if high_urgency_signals >= 2 or follow_up_count >= 5:
        return 85  # High urgency

    if high_urgency_signals >= 1 or follow_up_count >= 3:
        return 65  # Medium-high urgency

    if follow_up_count >= 1:
        return 55  # Medium urgency

    return 40  # Low urgency (positive/patient tone)
```

### Aggregation Example

Feature: "Flight-level email activity tables"

Data:
- Canny: 7 comments, 2 mention frustration → Urgency: 65
- Zendesk: 3 tickets, all "Normal" priority → Urgency: 50
- Gong: 1 call with "honestly, if we don't get better reporting soon, we're going to look at alternatives" → Urgency: 95

**Final urgency score: 95** (highest across sources)

**Note in report:** "Churn risk language in Gong call (2026-01-10) elevates urgency despite normal Zendesk priority."

---

## Factor 4: Technical Complexity Scoring (Inverse)

### Definition

Complexity estimates development effort required. This is an **inverse scale** - lower complexity (easier to build) = higher score.

**Goal:** Surface "quick wins" alongside "strategic bets" in prioritization.

### Cross-Feature Impact Analysis

Use Feathr's 7-point framework to count how many platform areas are affected:

1. **Person Records:** Data structure, display, activity logging
2. **Segmentation & Targeting:** Audience building, filtering, targeting options
3. **Reporting & Analytics:** Dashboards, metrics, visualizations, exports
4. **Billing & Credits:** Growth Credits, payments, pricing, transactions
5. **CRM Integration:** Salesforce NPSP/RE NXT sync, field mapping, data flow
6. **Campaign Goals:** Goal types, conversion tracking
7. **Other Platform Touchpoints:** Forms, landing pages, email builder, infrastructure

### Base Complexity Scoring

| Areas Affected | Base Score | Estimated Effort | Interpretation |
|----------------|------------|------------------|----------------|
| 1-2 areas | 100 | 1-2 weeks | Low complexity, quick win |
| 3-4 areas | 70 | 2-4 weeks | Medium-low complexity, moderate effort |
| 5-6 areas | 40 | 4-8 weeks | Medium-high complexity, significant effort |
| 7+ areas | 20 | 8+ weeks | High complexity, major effort |

### Complexity Adjustments

Apply these adjustments (subtractions) to base score:

| Adjustment Factor | Points Deducted | Reasoning |
|-------------------|-----------------|-----------|
| **CRM integration required** | -10 | Salesforce/RE NXT changes, sync logic, field mapping, testing |
| **Data model changes** | -15 | New tables/fields, schema migrations, backwards compatibility |
| **Payment/billing changes** | -10 | Stripe integration, financial transactions, PCI compliance |
| **Third-party API integration** | -10 | External dependency, rate limits, error handling |
| **Multi-tier rollout** | -5 | Feature flag logic, tier-specific behavior |

**Example calculation:**

Feature: "Automated RE NXT sync for recurring gifts"

**Step 1: Count affected areas**
1. Person Records (recurring donor flag) ✓
2. CRM Integration (RE NXT sync) ✓
3. Billing & Credits (recurring transactions) ✓
4. Reporting & Analytics (recurring gift reports) ✓

**4 areas affected → Base score: 70**

**Step 2: Apply adjustments**
- CRM integration: -10
- Payment/billing: -10

**Step 3: Calculate final**
- 70 - 10 - 10 = **50 points**

**Estimated effort:** 3-4 weeks (mid-range due to complexity of recurring payment + CRM sync)

### Detailed Complexity Examples

#### Low Complexity Example (Score: 100, Effort: 1 week)

**Feature:** "Add flight name column to email activity CSV export"

**Areas affected:**
- Reporting & Analytics (CSV export format only)

**Adjustments:** None

**Final complexity score: 100**

**Effort estimate:** 1 week
- Update export query to include flight name
- Update CSV header
- Add tests
- Deploy

---

#### Medium-Low Complexity Example (Score: 65, Effort: 3 weeks)

**Feature:** "Flight-level email activity tables in dashboard"

**Areas affected:**
1. Reporting & Analytics (new dashboard widget)
2. Person Records (activity detail view linked from person record)
3. Campaign Goals (goal tracking at flight level)

**Base score:** 70 (3 areas)

**Adjustments:**
- None major, but some data aggregation logic needed
- Deduct -5 for complexity of aggregating flight-level data

**Final complexity score: 65**

**Effort estimate:** 3 weeks
- Design new dashboard widget (UI/UX)
- Implement data aggregation queries
- Add filtering/sorting
- Link from person records
- Update goal tracking to support flight level
- Testing and QA

---

#### Medium-High Complexity Example (Score: 35, Effort: 6 weeks)

**Feature:** "Browser language auto-translation for donation forms"

**Areas affected:**
1. Fundraising (form builder, form display)
2. Person Records (language preference field, tracking)
3. Reporting & Analytics (donations by language)
4. CRM Integration (sync language field to NPSP/RE NXT)
5. Billing & Credits (multi-currency considerations)
6. Other Platform Touchpoints (email receipts in donor language)

**Base score:** 40 (6 areas)

**Adjustments:**
- CRM integration: -10
- Data model changes (language field): -15
- Third-party API (translation service): -10

**Final complexity score: 40 - 10 - 15 - 10 = 5**

**Adjustment:** Score floors at 10 (never go below 10)

**Final complexity score: 10**

**Effort estimate:** 8-10 weeks
- Integrate translation API (Google Translate, DeepL, etc.)
- Update form builder to support multi-language content
- Implement language detection and form display logic
- Add language preference field to person records
- Update CRM sync to include language field
- Handle multi-currency payment flows
- Translate email receipt templates
- Extensive testing across languages and currencies
- Browser compatibility testing

---

#### High Complexity Example (Score: 10, Effort: 12 weeks)

**Feature:** "Unified person record across all products with real-time sync"

**Areas affected:**
1. Person Records (complete redesign)
2. Segmentation & Targeting (new query engine)
3. Reporting & Analytics (unified reporting)
4. CRM Integration (bidirectional sync)
5. Campaign Goals (unified conversion tracking)
6. Billing & Credits (usage tracking across products)
7. Email (unified subscription management)
8. Advertising (unified audience targeting)
9. Fundraising (unified donor profiles)

**Base score:** 20 (7+ areas, actually 9)

**Adjustments:**
- CRM integration (major changes): -10
- Data model changes (fundamental restructuring): -15
- Multi-tier rollout (phased deployment): -5

**Final complexity score: 20 - 10 - 15 - 5 = -10**

**Adjustment:** Score floors at 10

**Final complexity score: 10**

**Effort estimate:** 12+ weeks (possibly multiple quarters)
- Platform-wide architectural changes
- Data migration strategy
- Backwards compatibility layer
- Multiple team coordination
- Phased rollout with feature flags
- Extensive testing across all products

---

### User Complexity Review Process

**Auto-estimate first, then ask user:**

After auto-calculating complexity scores, present to user:

```markdown
### Complexity Estimates (Auto-Generated)

I've estimated technical complexity based on cross-feature impact. Please review:

| Feature | Areas Affected | Auto Score | Estimated Effort |
|---------|----------------|------------|------------------|
| Flight-level email activity tables | 3 | 65 | 3 weeks |
| Lookalike attribution reporting | 4 | 60 | 4 weeks |
| RE NXT recurring sync | 4 + integrations | 50 | 5 weeks |

**Do these estimates look reasonable? Any adjustments needed?**
```

**User can override:**
- "Flight-level tables is simpler - already have the data, just need UI. 1 week."
  - Update score: 65 → 90 (1-2 week range)
- "RE NXT sync is more complex - recurring gifts have many edge cases. 8 weeks."
  - Update score: 50 → 25 (8+ week range)

**After adjustments, recalculate final scores** and re-sort items.

---

## Combined Score Calculation

### Formula

```
Final Score = (Frequency × 0.30) + (Recency × 0.25) + (Urgency × 0.25) + (Complexity × 0.20)
```

### Weight Rationale

**Frequency (30%)** - Highest weight because customer demand is the strongest signal
**Recency (25%)** - Important to prioritize current needs over old requests
**Urgency (25%)** - Equal to recency; churn risk and frustration matter
**Complexity (20%)** - Lowest weight; we shouldn't avoid big bets, but quick wins get a boost

### Example Calculation

**Feature:** "Flight-level email activity tables"

**Scores:**
- Frequency: 80 (18 customers)
- Recency: 100 (mentioned 3 days ago)
- Urgency: 95 (churn risk language in Gong)
- Complexity: 65 (3 areas, moderate effort)

**Calculation:**
```
Final = (80 × 0.30) + (100 × 0.25) + (95 × 0.25) + (65 × 0.20)
Final = 24 + 25 + 23.75 + 13
Final = 85.75
```

**Interpretation:** **Top priority** (score: 85.75)
- Strong customer demand (18 customers)
- Very recent (last week)
- High urgency with churn risk
- Moderate complexity (feasible)

---

## Prioritization Scenarios

### Scenario 1: High Demand, Low Urgency, Low Complexity

**Example:** "Email template library with drag-and-drop organization"

- Frequency: 95 (45 customers)
- Recency: 80 (mentioned 2 weeks ago)
- Urgency: 40 (nice-to-have, no frustration)
- Complexity: 85 (straightforward UI work)

**Final Score:** (95 × 0.30) + (80 × 0.25) + (40 × 0.25) + (85 × 0.20) = 28.5 + 20 + 10 + 17 = **75.5**

**Interpretation:** **High priority** despite low urgency due to:
- Very high demand
- Low complexity (quick win)
- Recent enough

---

### Scenario 2: Low Demand, High Urgency, Low Complexity

**Example:** "API rate limit increase for enterprise customer"

- Frequency: 30 (2 customers)
- Recency: 100 (mentioned today)
- Urgency: 100 (blocker, customer can't proceed)
- Complexity: 95 (simple config change)

**Final Score:** (30 × 0.30) + (100 × 0.25) + (100 × 0.25) + (95 × 0.20) = 9 + 25 + 25 + 19 = **78**

**Interpretation:** **High priority** despite low frequency due to:
- Critical urgency (blocker)
- Very recent
- Trivial to implement

**Note:** May handle as hotfix rather than roadmap item.

---

### Scenario 3: High Demand, Low Urgency, High Complexity

**Example:** "Multi-language support for all platform features"

- Frequency: 90 (38 customers)
- Recency: 70 (mentioned 6 weeks ago)
- Urgency: 50 (important but not urgent)
- Complexity: 15 (platform-wide changes, 12+ weeks)

**Final Score:** (90 × 0.30) + (70 × 0.25) + (50 × 0.25) + (15 × 0.20) = 27 + 17.5 + 12.5 + 3 = **60**

**Interpretation:** **Medium priority** despite high demand due to:
- Very high complexity
- Not urgent
- Requires strategic planning and resources

**Recommendation:** Consider phased approach or MVP to reduce complexity.

---

### Scenario 4: Medium Demand, High Urgency, Medium Complexity

**Example:** "Fix critical CRM sync bug affecting enterprise customers"

- Frequency: 50 (8 customers, all enterprise)
- Recency: 100 (reported yesterday)
- Urgency: 100 (data integrity issue, revenue at risk)
- Complexity: 55 (complex sync logic, testing required)

**Final Score:** (50 × 0.30) + (100 × 0.25) + (100 × 0.25) + (55 × 0.20) = 15 + 25 + 25 + 11 = **76**

**Interpretation:** **High priority** despite medium frequency due to:
- Critical urgency (data issue, enterprise revenue at risk)
- Very recent
- Reasonable complexity

**Note:** May handle as hotfix/P0 issue rather than roadmap item.

---

## Tiebreaker Rules

When two features have similar final scores (within 5 points), use these tiebreakers:

1. **Urgency:** Higher urgency wins (churn risk takes precedence)
2. **Complexity:** Lower complexity wins (prefer quick wins when scores are equal)
3. **ARR impact:** Higher total ARR of affected customers wins
4. **Strategic alignment:** Feature that aligns with product vision/roadmap wins

---

## Adjusting Weights (Advanced)

While the default weights work well, you can adjust for specific contexts:

### When to Increase Frequency Weight

- Early-stage product: Customer demand is key signal for product-market fit
- Low-urgency environment: No fires to fight, optimize for broad impact

**Example:** Frequency 40%, Recency 20%, Urgency 20%, Complexity 20%

### When to Increase Urgency Weight

- High-churn environment: Retention is critical
- Competitive pressure: Customers mentioning competitors

**Example:** Frequency 25%, Recency 20%, Urgency 35%, Complexity 20%

### When to Increase Complexity Weight

- Resource-constrained team: Maximize output with quick wins
- Sprint planning: Need to fill sprint with feasible work

**Example:** Frequency 25%, Recency 20%, Urgency 25%, Complexity 30%

**Note:** Always ensure weights sum to 100% (1.0).

---

## Summary: Scoring Checklist

For each feature request:

- [ ] **Frequency:**
  - [ ] Count distinct customers across all sources
  - [ ] Deduplicate by email
  - [ ] Apply frequency scoring rubric (1-2 = 20, 3-5 = 40, etc.)

- [ ] **Recency:**
  - [ ] Find most recent mention across all sources
  - [ ] Calculate days since mention
  - [ ] Apply recency scoring rubric (0-7 = 100, 8-14 = 90, etc.)

- [ ] **Urgency:**
  - [ ] Analyze Gong transcripts for keywords
  - [ ] Map Zendesk priority to score
  - [ ] Analyze Canny comment sentiment
  - [ ] Use highest urgency across sources

- [ ] **Complexity:**
  - [ ] Map to 7-point framework, count affected areas
  - [ ] Apply base complexity score (1-2 = 100, 3-4 = 70, etc.)
  - [ ] Apply adjustments (CRM -10, data model -15, etc.)
  - [ ] Floor at 10 (never below 10)
  - [ ] Confirm with user, adjust if needed

- [ ] **Final Score:**
  - [ ] Calculate: (Freq × 0.30) + (Rec × 0.25) + (Urg × 0.25) + (Comp × 0.20)
  - [ ] Round to 1 decimal place
  - [ ] Sort items by final score (high to low)

This rubric ensures consistent, defensible prioritization based on objective criteria and data.
