# Feathr Customer Feedback Analysis

**Analysis Date:** 2026-01-17
**Analysis Type:** Full Review
**Date Range:** 2025-10-18 to 2026-01-17 (90 days)
**Sources:** Canny (47 posts), Zendesk (89 tickets), Gong (23 calls)
**Clustering:** Disabled (distinct items presented individually)

## Executive Summary

**Top 5 Priorities:**
1. Flight-level email activity tables (Score: 85.5) - 18 customers, high urgency, churn risk language
2. Lookalike audience attribution in Pixl Plus reports (Score: 78.0) - 12 customers, recent surge, budget planning blocker
3. Automated RE NXT sync for recurring gifts (Score: 72.5) - 8 customers, enterprise demand, manual workaround required
4. Granular content editor role permissions (Score: 68.0) - 15 customers, security/compliance concern
5. Browser language auto-translation for donation forms (Score: 65.5) - 20 customers, competitive gap, international expansion blocker

**Urgent Items Requiring Attention:**
- Flight-level email activity (churn risk: ACME Nonprofit considering alternatives)
- Granular content editor permissions (compliance blocker for enterprise customers)
- Lookalike attribution (budget planning blocked for Q1)

**New Patterns vs. Previous Analysis:**
- Email reporting gaps remain top pain point (consistent with previous quarter)
- Fundraising internationalization requests increased 45% (browser translation, multi-currency)
- RE NXT integration requests growing (8 customers, up from 4 last quarter)

**Key Insights:**
- Email product has strong engagement but reporting gaps frustrating power users
- Fundraising product competitive pressure from Givebutter/Donorbox on international features
- Enterprise customers requesting more granular permissions for contractor/vendor access

---

## 1. Prioritized Feature Requests by Product Area

### Email (8 items)

| # | Feature/Problem | Score | Freq | Recency | Urgency | Complexity | Customers | Sources |
|---|-----------------|-------|------|---------|---------|------------|-----------|---------|
| 1 | Flight-level email activity tables | 85.5 | 80 | 100 | 95 | 65 | 18 | Canny (15 votes), Zendesk (2 tickets), Gong (1 call) |
| 2 | Export email performance with flight-level granularity | 72.0 | 65 | 85 | 70 | 75 | 12 | Canny (10 votes), Zendesk (1 ticket) |
| 3 | Email template organization and management | 74.0 | 75 | 80 | 60 | 80 | 22 | Canny (22 votes) |

#### Item 1: Flight-level email activity tables

**Customer Quotes:**
- **Canny** (Post #1234, 15 votes): "We need to see email performance broken down by individual flights (sends), not just rolled up at the campaign level. This would help us understand which specific emails performed best so we can optimize our campaigns."
- **Zendesk** (Ticket #12345, High priority, jane@acmenonprofit.org): "Currently we have to manually pull this from CSVs which is very time-consuming. We run A/B tests at the flight level and need to see which variations performed better. The current reporting doesn't support this workflow."
- **Gong** (Call 2026-01-10, Jane Smith, ACME Nonprofit): "One thing that's been frustrating for our team is not being able to see email performance at the flight level in a modern, easy-to-use way. We're doing all this manual Excel analysis and it feels very 2010. And I'll be straight with you - if we don't get better reporting tools soon, we're going to have to look at alternatives."

**Cross-Feature Impact:**
- **Person Records:** Activity detail view needs flight-level granularity
- **Reporting & Analytics:** New dashboard widget for flight-level performance tables
- **Campaign Goals:** Goal tracking needs to support flight-level attribution

**Affected Tiers:** Essential, Advanced

**Complexity Estimate:** 3 weeks
- UI/dashboard widget development (1 week)
- Data aggregation queries and optimization (1 week)
- Goal tracking updates and testing (1 week)

**Customer Details:**
- ACME Nonprofit (jane@acmenonprofit.org, $45K ARR) - **Multi-source: Canny + Zendesk + Gong**
- Helping Hands NPO (bob@helpinghandsnpo.org, $28K ARR) - Canny comment
- Community First (sarah@communityfirst.org, $38K ARR) - Canny vote
- Equality Forward (michael@equalityforward.org, $32K ARR) - Canny comment
- [14 more customers... total $450K+ ARR]

---

#### Item 2: Export email performance with flight-level granularity

**Customer Quotes:**
- **Canny** (Post #2456, 10 votes): "Once we have flight-level tables in the dashboard, we also need to be able to export that data for board meetings and annual reports."
- **Zendesk** (Ticket #12567, Normal priority): "Need CSV export of email performance with columns for flight ID, flight name, send date, opens, clicks, conversions."

**Cross-Feature Impact:**
- **Reporting & Analytics:** Add flight-level columns to existing email export
- **Data Export:** Ensure consistent export format across all report types

**Affected Tiers:** Essential, Advanced

**Complexity Estimate:** 2 weeks
- Update export query to include flight data (3 days)
- CSV formatting and header updates (2 days)
- Testing across different campaign types (1 week)

**Customer Details:**
- [12 customers, $320K combined ARR]

---

### Advertising (5 items)

| # | Feature/Problem | Score | Freq | Recency | Urgency | Complexity | Customers | Sources |
|---|-----------------|-------|------|---------|---------|------------|-----------|---------|
| 1 | Lookalike audience attribution in Pixl Plus reports | 78.0 | 75 | 95 | 85 | 60 | 12 | Canny (10 votes), Zendesk (2 tickets) |
| 2 | Pixl Plus dashboard filtering by audience type | 65.0 | 60 | 70 | 65 | 70 | 9 | Canny (8 votes), Gong (1 call) |

#### Item 1: Lookalike audience attribution in Pixl Plus reports

**Customer Quotes:**
- **Canny** (Post #2345, 10 votes): "When we run lookalike audience campaigns through Pixl Plus, we can't see which conversions came from the lookalike audiences vs. other targeting methods. Need attribution reporting that shows performance by audience type."
- **Zendesk** (Ticket #12346, Urgent priority, david@healthaccess.org): "We're running lookalike audience campaigns through Pixl Plus but cannot see attribution in our reports. Without this data, we can't determine if our lookalike spend is effective. This is blocking our Q1 budget planning."
- **Zendesk** (Ticket #12378, High priority): "Executive team is asking for ROI on our lookalike spend and we literally can't provide it. Need this ASAP."

**Cross-Feature Impact:**
- **Reporting & Analytics:** Add audience type dimension to Pixl Plus reports
- **Campaign Goals:** Track goal completions by audience type
- **Segmentation & Targeting:** Ensure audience type metadata flows through to reporting

**Affected Tiers:** Essential, Advanced (Pixl Plus is Advanced-tier feature)

**Complexity Estimate:** 4 weeks
- Pixl Plus data model updates to capture audience type (1 week)
- Report queries and aggregation logic (1 week)
- Dashboard UI updates (1 week)
- Testing and validation (1 week)

**Customer Details:**
- Health Access Coalition (david@healthaccess.org, $32K ARR) - **Multi-source: Canny + Zendesk (urgent)**
- Youth Services Network (lisa@youthservices.org, $28K ARR) - Canny comment
- [10 more customers... total $280K+ ARR]

---

### Fundraising (6 items)

| # | Feature/Problem | Score | Freq | Recency | Urgency | Complexity | Customers | Sources |
|---|-----------------|-------|------|---------|---------|------------|-----------|---------|
| 1 | Browser language auto-translation for donation forms | 65.5 | 70 | 90 | 75 | 35 | 20 | Canny (20 votes), Zendesk (3 tickets) |
| 2 | Anonymous donor support with donation forms | 58.0 | 55 | 75 | 60 | 65 | 14 | Canny (12 votes), Zendesk (2 tickets) |

#### Item 1: Browser language auto-translation for donation forms

**Customer Quotes:**
- **Canny** (Post #3456, 20 votes): "Our donor base is international and we need donation forms to automatically detect browser language and display in the donor's preferred language. Currently we have to create separate forms for each language which is a maintenance nightmare."
- **Zendesk** (Ticket #12349, High priority, sophie@globalwellness.org): "We operate in 12 countries and this is becoming a major pain point. Competitors like Givebutter have this feature and we're getting pressure from our international team to switch."
- **Zendesk** (Ticket #12401, Normal priority): "Need form builder to allow entering content in multiple languages, with automatic display based on browser setting. Should also track donor's preferred language for future communications."

**Cross-Feature Impact:**
- **Fundraising:** Form builder multi-language content management
- **Person Records:** Language preference field and tracking
- **Reporting & Analytics:** Donations by language dimension
- **CRM Integration:** Sync language field to Salesforce NPSP / RE NXT
- **Billing & Credits:** Multi-currency considerations (related feature)
- **Other Platform:** Email receipts in donor's language

**Affected Tiers:** All tiers (fundraising available across Light, Essential, Advanced)

**Complexity Estimate:** 8-10 weeks
- Third-party translation API integration (Google Translate or DeepL) (2 weeks)
- Form builder multi-language UI and content management (2 weeks)
- Language detection and form display logic (1 week)
- Person records language field and CRM sync (1 week)
- Email receipt template translation system (1 week)
- Multi-currency payment handling (related, if combined) (2 weeks)
- Testing across languages, browsers, and currencies (1-2 weeks)

**Customer Details:**
- Global Wellness Initiative (sophie@globalwellness.org, $68K ARR) - **Multi-source: Canny + Zendesk**
- Educación Mundial (carlos@educacionmundial.org, $42K ARR) - Canny comment
- Asia Relief Fund (yuki@asiarelieffund.org, $55K ARR) - Canny comment, churn risk
- [17 more customers... total $620K+ ARR]

**Competitive Pressure:**
- Givebutter has multi-language donation forms
- Donorbox supports browser language detection
- Feathr at risk of losing international customers without this feature

---

### Integrations (4 items)

| # | Feature/Problem | Score | Freq | Recency | Urgency | Complexity | Customers | Sources |
|---|-----------------|-------|------|---------|---------|------------|-----------|---------|
| 1 | Automated RE NXT sync for recurring gifts | 72.5 | 70 | 85 | 75 | 50 | 8 | Canny (5 votes), Zendesk (3 tickets) |

#### Item 1: Automated RE NXT sync for recurring gifts

**Customer Quotes:**
- **Zendesk** (Ticket #12347, High priority, patricia@museumfriends.org): "When donors make recurring gift commitments through our donation forms, the gifts are creating one-time opportunities in RE NXT instead of recurring gift records. We need the Feathr -> RE NXT sync to properly create recurring gift records with the correct frequency and start date. Currently our development team has to manually fix these which defeats the purpose of the integration."
- **Canny** (Post #4789, 5 votes): "RE NXT sync should handle recurring gifts natively. Right now we have to manually create recurring gift records in RE NXT after they come through as one-time gifts from Feathr."
- **Zendesk** (Ticket #12489, High priority): "Recurring gift sync is broken - creates wrong record type in RE NXT. Manual cleanup taking 5+ hours per month."

**Cross-Feature Impact:**
- **CRM Integration:** RE NXT sync logic for recurring gift record creation
- **Fundraising:** Ensure recurring gift metadata flows through API
- **Person Records:** Track recurring gift commitments and status
- **Reporting & Analytics:** Recurring gift reporting and forecasting

**Affected Tiers:** Advanced (RE NXT integration is Advanced-tier feature)

**Complexity Estimate:** 5 weeks
- RE NXT API research for recurring gift endpoints (3 days)
- Sync logic for recurring gift record creation (1 week)
- Frequency mapping (monthly, quarterly, annual) (3 days)
- Data validation and error handling (1 week)
- Testing with multiple RE NXT configurations (2 weeks)

**Customer Details:**
- Museum Friends Society (patricia@museumfriends.org, $28K ARR) - Zendesk, manual workaround
- [7 more customers... total $240K+ ARR, all Advanced tier]

---

### Platform (5 items)

| # | Feature/Problem | Score | Freq | Recency | Urgency | Complexity | Customers | Sources |
|---|-----------------|-------|------|---------|---------|------------|-----------|---------|
| 1 | Granular content editor role permissions | 68.0 | 65 | 95 | 85 | 70 | 15 | Canny (12 votes), Zendesk (3 tickets) |

#### Item 1: Granular content editor role permissions

**Customer Quotes:**
- **Canny** (Post #4567, 12 votes): "We need a role that can edit email content and landing pages but cannot view or manage audiences, person records, or reports. Currently the Content Editor role has too many permissions for our security requirements. Use case: We have contractors who help write email copy but shouldn't have access to our donor database."
- **Zendesk** (Ticket #12348, Urgent priority, rachel@privacymatters.org): "We hired a freelance copywriter but the Content Editor role gives them access to person records and audience lists, which they shouldn't see due to our data privacy policies. This is a compliance issue and we may need to stop using contractors until this is resolved."
- **Zendesk** (Ticket #12456, High priority): "All of our enterprise customers ask about this during sales calls. It's a common requirement for larger organizations with compliance needs."

**Cross-Feature Impact:**
- **Platform:** User permissions system overhaul
- **Reporting & Analytics:** Ensure report access properly restricted
- **Person Records:** Ensure person data properly restricted
- **Segmentation & Targeting:** Ensure audience access properly restricted

**Affected Tiers:** Primarily Advanced (enterprise customers with contractors/vendors)

**Complexity Estimate:** 3 weeks
- Define new permission granularity (3 days)
- Update role definitions and permission checks (1 week)
- UI updates for role management (3 days)
- Testing across all product areas (1 week)

**Customer Details:**
- Privacy Matters Foundation (rachel@privacymatters.org, $52K ARR) - **Multi-source: Canny + Zendesk (urgent, compliance)**
- Secure Giving Alliance (tom@securegiving.org, $48K ARR) - Canny comment, security concern
- [13 more customers... total $580K+ ARR, primarily enterprise]

---

## 2. PRD-Ready Problem Statements

### #1: Flight-level email activity tables (Score: 85.5)

**Problem Statement:**
"Email marketers need flight-level activity tables in the campaign dashboard because they currently cannot see which specific email sends (flights) performed best within a multi-send campaign, resulting in manual CSV exports and Excel analysis for 18+ customers (combined $450K ARR) who spend hours weekly on this workaround."

**Context:**
- **Demand:** 18 customers, 15 Canny votes, 2 Zendesk tickets, 1 Gong call
- **ARR Impact:** $450K+ across affected customers
- **Urgency:** Churn risk - ACME Nonprofit ($45K ARR) mentioned "look at alternatives" in Gong call
- **Frequency:** Mentioned 18 times across 3 sources in past 90 days
- **Recency:** Mentioned in Gong call 7 days ago (2026-01-10)
- **Complexity:** Medium (3 areas affected, 3-4 weeks estimated)
  - Person Records (activity detail)
  - Reporting & Analytics (dashboard widget)
  - Campaign Goals (flight-level tracking)
- **Competitive Gap:** Mailchimp, Constant Contact, and other email platforms provide flight-level reporting

**Representative Quotes:**
- "We're doing all this manual Excel analysis and it feels very 2010."
- "If we don't get better reporting tools soon, we're going to have to look at alternatives."
- "Our executive team is very data-driven and they want to see ROI on every campaign. Without flight-level data, we're basically guessing."

**Affected Customers (top 10 by ARR):**
- ACME Nonprofit (jane@acmenonprofit.org, $45K ARR)
- Community First (sarah@communityfirst.org, $38K ARR)
- Equality Forward (michael@equalityforward.org, $32K ARR)
- Helping Hands NPO (bob@helpinghandsnpo.org, $28K ARR)
- [6 more customers...]

---

### #2: Lookalike audience attribution in Pixl Plus reports (Score: 78.0)

**Problem Statement:**
"Advertising managers need attribution reporting by audience type (lookalike, retargeting, prospecting) in Pixl Plus dashboards because they cannot currently measure ROI on lookalike spend, resulting in blocked Q1 budget planning for 12+ customers (combined $280K ARR) who are running lookalike campaigns blind."

**Context:**
- **Demand:** 12 customers, 10 Canny votes, 2 Zendesk tickets
- **ARR Impact:** $280K+ across affected customers
- **Urgency:** High - One customer marked ticket "urgent", blocker for Q1 budget planning
- **Frequency:** Mentioned 12 times in past 90 days
- **Recency:** Mentioned in urgent Zendesk ticket 11 days ago (2026-01-06)
- **Complexity:** Medium (4 areas affected, 4 weeks estimated)
  - Reporting & Analytics (attribution dimensions)
  - Campaign Goals (audience type tracking)
  - Segmentation & Targeting (metadata flow)
- **Competitive Gap:** Standard feature in Facebook Ads Manager, Google Ads

[Continue for #3-5...]

---

## 3. Strategic Insights

### Cross-Product Patterns

**Email reporting gaps dominate high-priority requests:**
- 3 of top 10 items are email reporting features (flight-level tables, flight-level export, A/B test reporting)
- Pattern: Power users hitting ceiling with current reporting capabilities
- Common complaints: Manual workarounds, Excel exports, time-consuming analysis
- Opportunity: Comprehensive email analytics overhaul could address multiple high-priority items at once

**Fundraising internationalization momentum:**
- Browser translation requests increased 45% vs. previous quarter
- Multi-currency support also trending up
- Driver: International expansion by existing customers + competitive pressure (Givebutter, Donorbox)
- Risk: Losing international nonprofit market if features not added soon

**Enterprise permission requirements:**
- Granular permissions requested by 15 customers, all Advanced tier
- Common use case: Contractors, vendors, agencies need content access but not data access
- Compliance driver: GDPR, CCPA, internal security policies
- Opportunity: Differentiate on enterprise-grade security features

### Competitive Considerations

**Email category (Mailchimp, Constant Contact):**
- Competitors have: Flight-level reporting, advanced A/B testing analytics, predictive sending
- Feathr gap: Email product is strong on usability but weak on advanced analytics
- Risk: Power users churning to email specialists

**Fundraising category (Givebutter, Donorbox, Classy):**
- Competitors have: Multi-language forms, anonymous donor options, better recurring gift UX, peer-to-peer fundraising
- Feathr gap: Fundraising product is MVP-level, missing table-stakes international features
- Risk: Losing fundraising customers who need international support

**Integration category (Blackbaud ecosystem):**
- RE NXT customers have fewer integration options than Salesforce NPSP customers
- Feathr gap: RE NXT integration less mature than Salesforce integration
- Opportunity: Strong RE NXT support could differentiate in Blackbaud-heavy nonprofit market

### Roadmap Implications

**Quick Wins (≤4 weeks, high impact):**
1. Flight-level email activity tables (Score: 85.5, 3 weeks)
2. Email template organization (Score: 74.0, 2 weeks)
3. Granular content editor permissions (Score: 68.0, 3 weeks)

**Medium Efforts (4-8 weeks, high impact):**
1. Lookalike audience attribution (Score: 78.0, 4 weeks)
2. RE NXT recurring sync (Score: 72.5, 5 weeks)

**Strategic Bets (8+ weeks, high impact):**
1. Browser language auto-translation (Score: 65.5, 8-10 weeks) - Addresses competitive gap and enables international expansion
2. Unified person record redesign (Score: 60.0, 12+ weeks) - Foundational for future cross-product features

**Suggested Sprint Planning:**
- **Q1 Sprint 1-2:** Flight-level email tables + Email template organization (Quick wins, total 5 weeks)
- **Q1 Sprint 3:** Granular permissions (Enterprise blocker, 3 weeks)
- **Q1 Sprint 4-5:** Lookalike attribution + RE NXT recurring sync (Medium efforts, total 9 weeks)
- **Q2:** Browser translation (Strategic bet, international expansion enabler)

---

## Metadata for Next Run

- **Analysis date:** 2026-01-17
- **Date range:** 2025-10-18 to 2026-01-17
- **Sources queried:** Canny (47 posts), Zendesk (89 tickets), Gong (23 calls)
- **Items analyzed:** 42 distinct feature requests
- **Customers represented:** 127 unique customers
- **Total ARR represented:** $3.2M+ across all feedback
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
    "arr": 450000,
    "sources": {"canny": 15, "zendesk": 2, "gong": 1}
  },
  "lookalike-pixl-reporting": {
    "name": "Lookalike audience attribution in Pixl Plus reports",
    "score": 78.0,
    "frequency": 75,
    "recency": 95,
    "urgency": 85,
    "complexity": 60,
    "area": "Advertising",
    "customers": 12,
    "arr": 280000,
    "sources": {"canny": 10, "zendesk": 2, "gong": 0}
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
    "arr": 240000,
    "sources": {"canny": 5, "zendesk": 3, "gong": 0}
  },
  "granular-editor-permissions": {
    "name": "Granular content editor role permissions",
    "score": 68.0,
    "frequency": 65,
    "recency": 95,
    "urgency": 85,
    "complexity": 70,
    "area": "Platform",
    "customers": 15,
    "arr": 580000,
    "sources": {"canny": 12, "zendesk": 3, "gong": 0}
  },
  "browser-language-translation": {
    "name": "Browser language auto-translation for donation forms",
    "score": 65.5,
    "frequency": 70,
    "recency": 90,
    "urgency": 75,
    "complexity": 35,
    "area": "Fundraising",
    "customers": 20,
    "arr": 620000,
    "sources": {"canny": 20, "zendesk": 3, "gong": 0}
  }
}
```
