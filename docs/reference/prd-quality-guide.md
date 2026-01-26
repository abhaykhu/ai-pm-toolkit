---
audience: Product Managers
when_to_use: Writing PRDs, reviewing PRDs before design handoff, teaching PRD quality standards
related_docs: usability-components.md, workflow-integration.md
last_updated: 2026-01-23
---

# PRD Examples & Anti-Patterns

## Example 1: Well-Scoped Cross-Feature Integration

**Good - Specific and Actionable:**

**Reporting & Analytics:**
- Add "Recurring Donations" widget to fundraising dashboard showing:
  - Total active recurring donors (count)
  - Monthly recurring revenue (MRR)
  - Breakdown by frequency (weekly, monthly, quarterly, annual)
- Add "Recurring Revenue Trend" chart (line graph, 12-month view)
- Add recurring donation filters to existing donation reports:
  - Filter by frequency (weekly/monthly/quarterly/annual)
  - Filter by status (active/cancelled/paused)
- Include recurring donation metrics in CSV export from Reports tab

**Bad - Vague and Generic:**

**Reporting & Analytics:**
- Update dashboard with recurring donation info
- Add some charts for recurring revenue
- Make sure data can be exported

---

## Example 2: Well-Organized User Stories

**Good - Workflow-Based Organization:**

<details><summary>As a Feathr user, I want to configure recurring donation options in my form builder so that donors can sign up for ongoing support</summary>

**User Requirements** *(requires design)*
- [ ] User sees "Recurring Donations" toggle in form builder settings panel
- [ ] When enabled, user can configure frequency options (checkboxes for: weekly, monthly, quarterly, annual)
- [ ] User can set default frequency selection
- [ ] User sees preview of recurring options in form preview pane
- [ ] User can reorder frequency options via drag-and-drop

**System Requirements** *(no design needed)*
- [ ] System validates at least one frequency option is selected
- [ ] System saves recurring configuration to form settings
</details>

<details><summary>As a donor, I want to choose a recurring donation frequency so that I can support the organization ongoing</summary>

**User Requirements** *(requires design)*
- [ ] Donor sees "One-time" and "Recurring" toggle buttons on step 1
- [ ] When "Recurring" selected, donor sees frequency options configured by organization
- [ ] Frequency options display as radio buttons
- [ ] Donor sees confirmation of recurring commitment in review step ("You'll be charged $X [frequency]")

**System Requirements** *(no design needed)*
- [ ] System captures selected frequency with donation data
- [ ] System creates Stripe subscription (not one-time payment intent)
</details>

**Bad - Mixed Workflow Contexts:**

<details><summary>As a user, I want to set up recurring donations</summary>

- [ ] User can toggle recurring donations in form builder
- [ ] Donor sees frequency options on donation form
- [ ] System creates Stripe subscription
- [ ] Recurring data syncs to Salesforce as Recurring Donation record
- [ ] Dashboard shows recurring revenue metrics

</details>

---

## Example 3: Appropriate Detail Level

**Good - Right Balance:**

**CRM Integration:**

*Salesforce NPSP:*
- Create/update `npe03__Recurring_Donation__c` record:
  - `npe03__Amount__c` = donation amount
  - `npe03__Installment_Period__c` = frequency (Weekly/Monthly/Quarterly/Yearly)
  - `npe03__Date_Established__c` = subscription start date
  - `npe03__Installments__c` = null (open-ended)
  - `npe03__Open_Ended_Status__c` = "Open"
  - `npsp__RecurringType__c` = "Open"
  - `Recurring_Donation_Campaign__c` = mapped from form's campaign
- Link to Contact using existing matching logic (First Name + Last Name + Email)
- Create Opportunity records for each payment following existing payment webhook flow

*RE NXT:*
- Create Recurring Gift record with frequency and amount
- Link to Constituent using email matching
- Individual Gift records created per payment

**Bad - Too Technical:**

**CRM Integration:**
- On recurring_subscription.created webhook, instantiate SalesforceNPSPAdapter class and call create_recurring_donation() method with subscription object serialized to JSON, then map fields using RecurringDonationFieldMapper with transform_stripe_to_npsp() function following the adapter pattern...

**Also Bad - Too Vague:**

**CRM Integration:**
- Sync recurring donations to Salesforce and RE NXT
- Create appropriate records in CRM

---

## Example 4: Describing Needs vs. Prescribing Design

**Good - User Need Focus:**

**Requirement:** User needs to filter the donations table by multiple criteria simultaneously (date range, amount range, donation type, campaign source) and save filter combinations for quick access.

**Why It's Good:** Describes what the user needs to accomplish and the context. Leaves Andy free to design the best UX - could be a filter panel, advanced search modal, saved views dropdown, or something else entirely.

**Bad - Prescriptive Design:**

**Requirement:** Add a collapsible filter panel on the left side of the donations table with dropdown menus for date range, amount range, donation type, and campaign source. Include a "Save Filter" button at the bottom that opens a modal where users can name their filter preset.

**Why It's Bad:** Dictates specific UI components (collapsible panel, dropdowns, modal), layout (left side), and interaction patterns. Constrains Andy's ability to design the optimal solution and may miss better UX approaches.

---

## Example 5: Strong vs. Weak Problem Statements

**Strong Problem Statement:**

"Fundraising managers at nonprofits with recurring donation programs spend 4-6 hours per month manually reconciling Stripe subscription data with their CRM because Feathr doesn't sync recurring donation metadata to Salesforce NPSP or RE NXT. This creates data integrity issues, delays monthly reporting, and has contributed to churn risk for 3 Advanced tier customers ($47k ARR)."

**Why It's Strong:**
- ✅ Specific persona: Fundraising managers with recurring programs
- ✅ Clear outcome: Reconcile subscription data with CRM
- ✅ Concrete problem: Manual work due to missing sync
- ✅ Quantified impact: 4-6 hrs/month, 3 customers, $47k ARR at risk

**Weak Problem Statement:**

"Users want recurring donations to sync to their CRM because it's important for their workflow and the current system doesn't support this."

**Why It's Weak:**
- ❌ Generic user type: "Users"
- ❌ Vague outcome: "important for their workflow"
- ❌ No concrete problem: Just states feature doesn't exist
- ❌ No quantifiable impact: No numbers or observable indicators

---

## Common PRD Pitfalls

### Pitfall 1: Weak or Missing Problem Statement

**Symptom:** Problem statement is vague ("users want X feature"), lacks quantifiable impact, or is missing entirely.

**Why It's Bad:** Without a clear problem statement, stakeholders can't evaluate priority, engineering can't understand context, and the team can't measure success. Weak problem statements fail to justify investment and create alignment issues.

**Fix:** Craft a problem statement that answers all four questions:
1. Who's struggling? (specific persona)
2. What are they trying to accomplish? (workflow/business outcome)
3. What's going wrong? (concrete issue, not just "feature missing")
4. What's the quantifiable impact? (ARR, time, drop-off rate, support tickets)

**Example Fix:**

❌ **Before:** "Users want better donation filtering."

✅ **After:** "Fundraising directors managing 500+ annual donations cannot efficiently analyze giving patterns or identify major donor trends because the donations table lacks advanced filtering and sorting capabilities. This forces them to export data to Excel for basic analysis, adding 2-3 hours per week of manual work and delaying donor outreach by an average of 5 business days."

---

### Pitfall 2: Mixing Workflow Contexts

**Symptom:** Single user story contains in-app builder actions, donor-facing UI, and backend data sync.

**Why It's Bad:** Andy needs to create separate Figma screens for each workflow. Mixed contexts create confusion and slow down design.

**Fix:** Split into separate stories by workflow (builder, donor, backend, admin).

---

### Pitfall 3: Skipping Cross-Feature Integration

**Symptom:** Cross-feature section only says "N/A" or left blank entirely.

**Why It's Bad:** Catches requirements late in development, causes rework, misses opportunities for platform cohesion.

**Fix:** Systematically evaluate all 7 areas, extrapolate reasonable details based on platform patterns.

---

### Pitfall 4: Including Implementation Details

**Symptom:** PRD specifies React components, API endpoints, database schemas, or technical architecture.

**Why It's Bad:** PRDs are for PM/Designer consumption, not engineers. Technical details should emerge during technical scoping phase.

**Fix:** Focus on what users need, not how it's built. Leave technical decisions to engineering.

---

### Pitfall 5: Prescribing Design Solutions

**Symptom:** PRD specifies UI components ("use a modal dialog", "add a dropdown menu", "use tabs"), layout decisions, or visual design patterns.

**Why It's Bad:** This is Andy's domain. Design owns the user experience and knows which components/patterns best serve the requirements. Prescriptive PRDs constrain creative problem-solving and may miss better UX solutions.

**Fix:** Describe the user need and context, not the UI solution. Instead of "Add a modal to configure settings," write "User needs to configure settings without losing their place in the workflow." Let design determine whether that's a modal, slide-out panel, inline expansion, or something else.

**Good Example:**
- ❌ "Add a dropdown menu to filter by donation frequency"
- ✅ "User needs to filter donations by frequency (weekly, monthly, quarterly, annual)"

**Good Example:**
- ❌ "Use a stepper component to show progress through the 3-step form"
- ✅ "User needs clear visibility of their progress through the multi-step donation form"

---

### Pitfall 6: Vague Success Metrics

**Symptom:** "Improve user experience" or "Increase adoption"

**Why It's Bad:** Can't measure success, can't validate assumptions, can't prioritize.

**Fix:** Define specific KPIs with baseline and target (e.g., "Increase form conversion rate from 12% to 15%").

---

### Pitfall 7: Inconsistent Terminology

**Symptom:** Switching between "Media Credits" and "Growth Credits", "customers" and "supporters", "users" and "donors" interchangeably.

**Why It's Bad:** Confuses stakeholders, creates inconsistent UI copy, slows down design/development.

**Fix:** Use Feathr's standard terminology consistently (see Key Terminology section in main CLAUDE.md).

---

### Pitfall 8: Missing Edge Cases

**Symptom:** Happy path only, no error states, no validation, no "what if" scenarios.

**Why It's Bad:** Design catches issues late, engineering makes assumptions, QA finds bugs.

**Fix:** For each user story, consider: What could go wrong? What validation is needed? What error states exist?
