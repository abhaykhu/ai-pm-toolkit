# UX Principles: Workflow Integration & System Thinking

This document codifies design principles derived from the 2026 Navigation & Workflow Consolidation audit. These principles should be applied when scoping new features to ensure they integrate seamlessly with the platform rather than adding to fragmentation.

---

## Core Philosophy

**Principle:** Design features as **workflow completions**, not isolated capabilities.

Users don't want "a form builder" or "a segment creator" — they want to complete jobs like "raise money from lapsed donors" or "thank event attendees." Every feature should be evaluated not just on its standalone functionality but on how it connects to upstream and downstream workflows.

---

## The Five Integration Questions

When scoping any new feature, answer these five questions to ensure workflow integration:

### 1. **Audience Connection**: How does this feature connect to people/segments?

**Ask:**
- Does this feature generate new audience data (form visits, campaign engagement, event RSVPs)?
- Should it auto-create segments for common targeting needs?
- Can users easily target existing segments with this feature?
- Does person record data flow into this feature (personalization, conditional logic)?

**Anti-pattern:** Building features that create data but don't make it targetable.

**Example - Good:**
- Fundraising forms auto-generate segments: "Form Visitors", "Completers", "Abandoners"
- Event registration creates: "Registered", "Attended", "No-shows"
- Landing page creates: "Visited", "Converted", "Bounced"

**Example - Bad:**
- Forms collect visitor data but require manual export to create segments
- Events track attendance but data lives only in event reports
- Landing pages track visits but no way to target visitors in campaigns

**Implementation Checklist:**
- [ ] Identify what audience data this feature generates
- [ ] Design auto-segment generation for top 3 use cases
- [ ] Add "View Audiences" link in feature dashboard
- [ ] Ensure segment predicates exist for this feature's data
- [ ] Show data completeness indicators if targeting this audience

---

### 2. **Campaign Attribution**: How does this feature connect to campaigns?

**Ask:**
- Can campaigns drive traffic to this feature (forms, landing pages, events)?
- Can we track which campaigns generated engagement/conversions?
- Should this feature enable campaign creation shortcuts?
- Does campaign performance data inform this feature's optimization?

**Anti-pattern:** Building features that campaigns promote but with no attribution/connection.

**Example - Good:**
- Forms show "Traffic Sources" breakdown: Campaign vs Direct vs Organic
- Campaign dashboard shows "This campaign drove 15 form visits, 3 donations"
- "Create Campaign" shortcuts from feature dashboard with pre-selected audiences
- UTM parameters automatically tracked and reported

**Example - Bad:**
- Forms show total visits but can't identify which campaigns drove them
- Campaigns link to forms but no visibility into form conversions
- No shortcuts to create retargeting campaigns
- Manual work required to connect campaign spend to feature outcomes

**Implementation Checklist:**
- [ ] Add UTM tracking if feature has public-facing URLs
- [ ] Show campaign attribution in feature dashboard/reports
- [ ] Design campaign creation shortcuts for common workflows
- [ ] Enable conversion tracking from campaigns to feature outcomes
- [ ] Surface feature performance data in campaign reporting

---

### 3. **CRM Integration**: How does this feature connect to CRM data?

**Ask:**
- Does this feature sync data to/from Salesforce NPSP or Blackbaud RE NXT?
- Can CRM fields be used for targeting, personalization, or conditional logic?
- Should feature interactions flow back to CRM as activities?
- Does CRM data completeness affect this feature's effectiveness?

**Anti-pattern:** Building features that duplicate CRM functionality without integration.

**Example - Good:**
- Forms sync donations to Salesforce as Opportunities + Payments
- Event registrations create Campaign Members in Salesforce
- Email opens/clicks log as Activities on Contact records
- Segments suggest CRM fields: "Target by Total Gifts > $1000"

**Example - Bad:**
- Donation data lives only in Feathr, requires manual entry to CRM
- Event attendance tracked separately from CRM campaign membership
- No way to use CRM giving history for feature personalization
- Feature requires data that exists in CRM but isn't accessible

**Implementation Checklist:**
- [ ] Identify what data should sync to CRM (and which object/field)
- [ ] Determine what CRM data should sync to Feathr for this feature
- [ ] Add CRM field awareness in feature configuration (if applicable)
- [ ] Design bi-directional sync for feature interactions
- [ ] Show CRM sync status in feature dashboard

---

### 4. **Workflow Shortcuts**: What pre-configured shortcuts reduce friction?

**Ask:**
- What's the most common workflow that follows this feature's completion?
- Can we pre-configure that workflow and offer it as one-click shortcut?
- What templates or presets eliminate repetitive configuration?
- How do we guide users from this feature to the next logical step?

**Anti-pattern:** Requiring users to manually configure obvious next steps.

**Example - Good:**
- After publishing form: "Create retargeting campaign" with pre-selected audience
- After campaign sends: "Create follow-up campaign targeting openers"
- After CRM sync: Auto-suggest segments for "Major Donors", "Lapsed Donors"
- Campaign templates pre-configure goals, audiences, messaging for common use cases

**Example - Bad:**
- Form published, user left to figure out retargeting manually
- Campaign completes, no suggestion for follow-up workflows
- CRM syncs data, user must manually create segments from scratch
- Every campaign requires full configuration even for repetitive tasks

**Implementation Checklist:**
- [ ] Map common workflow sequences involving this feature
- [ ] Design 3-5 shortcut templates for top workflows
- [ ] Pre-configure shortcut settings (audiences, goals, messaging)
- [ ] Surface shortcuts prominently in feature dashboard
- [ ] Allow customization before executing shortcut

---

### 5. **Closed-Loop Reporting**: How does this feature close the data loop?

**Ask:**
- Can users see the complete funnel (source → feature → outcome)?
- Does reporting show upstream attribution (what drove traffic/engagement)?
- Does reporting show downstream impact (what happened after)?
- Can users optimize based on complete lifecycle data?

**Anti-pattern:** Reporting only feature-level metrics without context.

**Example - Good:**
- Form reports show: Campaign → Form Visit → Donation (complete funnel)
- Campaign reports show: Send → Open → Click → Form Visit → Donation
- Person records show: Timeline of all interactions across features
- Cross-feature reports: "Which campaigns drove highest-value donors?"

**Example - Bad:**
- Form reports show visits/donations but not traffic sources
- Campaign reports show opens/clicks but not conversion outcomes
- Person records don't connect interactions across features
- No way to analyze multi-touch attribution across features

**Implementation Checklist:**
- [ ] Design reporting that shows upstream attribution
- [ ] Design reporting that shows downstream outcomes
- [ ] Add feature data to person record timelines
- [ ] Enable cross-feature reporting where relevant
- [ ] Surface optimization insights based on complete funnel data

---

## Workflow Integration Patterns

### Pattern 1: Auto-Generation

**When to use:** Feature generates data that has obvious segmentation/targeting value.

**Implementation:**
1. On feature publish/completion, automatically generate segments/audiences
2. Use naming convention: "[Feature Name] - [Segment Type]"
3. Add "Auto-generated" badge to distinguish from manual segments
4. Make segments editable but with clear source attribution
5. Show "View Audiences" link in feature dashboard

**Examples:**
- Forms → Auto-generate visitor/completer/abandoner segments
- Events → Auto-generate registered/attended/no-show segments
- Landing pages → Auto-generate visitor/converter/bouncer segments
- Campaigns → Auto-suggest opened/clicked/no-engagement segments

### Pattern 2: Workflow Shortcuts & Next-Step Guidance

**When to use:** Common workflow follows predictable sequence (>30% of use cases).

**Critical principle:** Every feature should provide next-step guidance, even when full shortcuts aren't feasible. Never leave users wondering "what's next?" after completing a task.

**Two Implementation Levels:**

#### Level 1: Full Shortcuts (Preferred When Possible)
**Use when:** You can pre-configure >50% of settings with confidence.

**Characteristics:**
- Pre-fills audience, goals, messaging templates, timing
- One-click opens modal with editable pre-configured settings
- User reviews and customizes before executing
- Shows success feedback with link to created resource

**Examples:**
- Form dashboard → "Thank Donors" campaign shortcut (pre-fills completed audience, thank-you messaging)
- Campaign dashboard → "Re-engage non-openers" follow-up shortcut (pre-fills no-engagement audience, 3-day timing)
- CRM sync complete → "Target Major Donors" campaign shortcut (pre-fills auto-generated segment)
- Event complete → "Thank Attendees" email shortcut (pre-fills attendee segment, thank-you template)

#### Level 2: Next-Step Guidance (Always Provide)
**Use when:** Pre-configuration not possible OR in addition to full shortcuts.

**Characteristics:**
- Recommends logical next action with brief explanation
- Provides direct link to begin workflow (reduces navigation friction)
- May include contextual hints or best practices
- Lower friction than navigation menu, but requires more user configuration

**Examples:**
- Form success modal → "Next Steps: Retarget visitors (link to Audiences), Share form (link to URL), Track performance (link to dashboard)"
- Person record → "Add to campaign" (too many campaign options to pre-select, provide link with context)
- Dashboard empty state → "Create your first form" (can't pre-configure, provide link + context)
- Export button → "Export this segment to CSV for offline analysis"

**Decision tree:**
```
Can you pre-configure >50% of settings with confidence?
│
├─ YES → Provide Full Shortcut
│  (know audience, know goal, can suggest messaging/timing)
│
└─ NO → Provide Next-Step Guidance
   (too many options, unclear context, or generic action)

IMPORTANT: When in doubt, provide BOTH levels when possible
(full shortcuts for 80% use case + guidance for remaining 20%)
```

**Implementation:**
1. Identify top 3-5 common workflows following this feature
2. For each workflow, determine if full shortcut is feasible (>50% pre-configurable)
3. Design full shortcuts for feasible workflows
4. Design next-step guidance for all workflows (including those with shortcuts)
5. Show shortcuts/guidance prominently in feature dashboard or success modal
6. Track utilization to validate workflow assumptions

### Pattern 3: Bi-Directional Sync

**When to use:** Feature creates/consumes data that has value in other systems (CRM, external tools).

**Implementation:**
1. Design clear data mapping (which fields sync where)
2. Add "Sync to [System]" toggle in feature settings
3. Show sync status in feature dashboard (last synced time, success/error)
4. Handle conflicts gracefully (precedence rules, conflict resolution UI)
5. Log sync history for troubleshooting

**Examples:**
- Forms → Sync donations to Salesforce Opportunities
- Campaigns → Sync engagement to Salesforce Campaign Members
- Events → Sync registrations to RE NXT Actions
- CRM → Sync donor segments to Feathr for targeting

### Pattern 4: Contextual Suggestions

**When to use:** User completing task could benefit from related feature/workflow.

**Implementation:**
1. Detect context (what user just did, what data is available)
2. Surface suggestion as dismissible Banner or inline card
3. Pre-configure suggested action based on context
4. Track suggestion acceptance rate to validate relevance
5. Allow permanent dismissal if user doesn't want suggestions

**Examples:**
- After publishing form without retargeting: "Create retargeting campaign?"
- After campaign sends to generic audience: "Create engagement segments for follow-up?"
- After CRM sync completes: "Your donor data is ready for targeting"
- After creating segment: "Create campaign targeting this audience?"

### Pattern 5: Attribution Visibility

**When to use:** Feature is part of multi-step workflow and users need to see connections.

**Implementation:**
1. Show upstream sources (what drove traffic/engagement to this feature)
2. Show downstream outcomes (what happened after this feature interaction)
3. Add "Connected [Features]" section to feature dashboard
4. Enable drill-down from summary stats to detailed attribution
5. Use consistent visualization (tables, charts, timelines)

**Examples:**
- Form dashboard → "Traffic Sources" table showing campaign/direct/organic split
- Campaign dashboard → "Outcomes" table showing form visits/donations driven
- Person record → Timeline showing campaign touches → form visit → donation
- Segment dashboard → "Used by X campaigns" with performance data

---

## Scoping Integration Checklist

Use this checklist when writing PRDs to ensure workflow integration is considered:

### Discovery Phase
- [ ] Map upstream workflows (what happens before this feature?)
- [ ] Map downstream workflows (what happens after this feature?)
- [ ] Identify common workflow sequences involving this feature
- [ ] Interview customers about current workflow pain points
- [ ] Audit competitive tools for workflow integration examples

### Requirements Phase
- [ ] Answer all 5 Integration Questions (documented in PRD)
- [ ] Design auto-generation logic (if applicable)
- [ ] Design shortcut templates (at least 3)
- [ ] Design bi-directional sync (if CRM-related)
- [ ] Design attribution visibility
- [ ] Define success metrics for integration (not just feature adoption)

### User Stories Phase
- [ ] Separate "Feature-only" stories from "Workflow integration" stories
- [ ] Include stories for auto-generation, shortcuts, sync, attribution
- [ ] Define states/conditions for workflow triggers
- [ ] Consider edge cases (deleted dependencies, sync failures)
- [ ] Include success feedback that explains workflow connections

### Design Phase
- [ ] Mockups show workflow shortcuts prominently
- [ ] Mockups include "Connected [Features]" sections
- [ ] Mockups show attribution data (sources, outcomes)
- [ ] Mockups include contextual suggestions
- [ ] Mockups explain workflow connections (tooltips, help text)

### Technical Phase
- [ ] API design supports cross-feature data sharing
- [ ] Event-driven architecture for auto-generation triggers
- [ ] Database schema includes workflow attribution fields
- [ ] Performance considerations for real-time sync/updates
- [ ] Error handling for workflow integration failures

### QA Phase
- [ ] Test complete workflows (not just isolated feature)
- [ ] Test auto-generation triggers reliably fire
- [ ] Test shortcuts pre-configure correctly
- [ ] Test attribution data flows correctly
- [ ] Test sync handles conflicts/errors gracefully

### Launch Phase
- [ ] Customer communication explains workflow benefits
- [ ] Help docs include end-to-end workflow walkthroughs
- [ ] Onboarding highlights workflow shortcuts
- [ ] Measure workflow adoption (not just feature usage)
- [ ] Gather feedback on workflow integration specifically

---

## Anti-Patterns to Avoid

### 🚫 Feature Islands

**What it is:** Building features that create data but don't connect to rest of platform.

**Example:** Landing page builder tracks visits but no way to target visitors in campaigns.

**Why it's bad:** Users must manually export/import data between features. Reduces value of platform integration.

**Fix:** Always design audience connection before building feature.

---

### 🚫 Manual Duct Tape

**What it is:** Requiring users to manually connect obvious workflow steps.

**Example:** Forms collect emails but user must export CSV to create segment for retargeting.

**Why it's bad:** High friction, low adoption, "why do I need multiple tools?"

**Fix:** Automate obvious connections, provide shortcuts for common workflows.

---

### 🚫 Attribution Black Holes

**What it is:** Features that consume traffic/engagement but don't report sources.

**Example:** Forms show total donations but can't identify which campaigns drove them.

**Why it's bad:** Users can't optimize, can't prove campaign ROI, can't close the loop.

**Fix:** Always track upstream attribution, always show downstream outcomes.

---

### 🚫 One-Way Data Flow

**What it is:** Data syncs from external system (CRM) but feature outcomes don't sync back.

**Example:** Salesforce donors imported but campaign engagement doesn't flow back to CRM.

**Why it's bad:** CRM remains incomplete, users maintain two systems, reduces CRM value.

**Fix:** Design bi-directional sync from the start, show sync status prominently.

---

### 🚫 Workflow Cliffs

**What it is:** Feature completes successfully but user left without next steps.

**Example:** User publishes form, sees "Form published!" message, no guidance on retargeting.

**Why it's bad:** Users don't discover connected features, low activation of platform capabilities.

**Fix:** Success states include contextual next steps, shortcuts, or suggestions.

---

## Measuring Workflow Integration Success

Beyond measuring individual feature adoption, measure workflow completion:

### Workflow Completion Rate

**Definition:** % of users who complete common workflow sequences

**Examples:**
- Form creation → Auto-segment generated → Retargeting campaign created (Target: 40%+)
- Campaign sent → Engagement segment created → Follow-up campaign sent (Target: 30%+)
- CRM synced → Auto-segment used → Campaign targeted CRM audience (Target: 60%+)

**Why it matters:** Indicates platform is functioning as integrated system, not collection of tools.

---

### Time to Workflow Completion

**Definition:** Duration from workflow start to completion

**Examples:**
- Form publish to first retargeting campaign: <10 minutes (vs current ~never)
- Campaign completion to follow-up creation: <5 minutes (vs current ~30 minutes)
- CRM sync to first targeting campaign: <15 minutes (vs current ~60 minutes)

**Why it matters:** Shorter time indicates less friction, better integration, clearer shortcuts.

---

### Cross-Feature Engagement

**Definition:** % of users actively using connected features (not just standalone)

**Examples:**
- Users who create forms AND campaigns: Target 60%+ (vs treating as separate tools)
- Users who sync CRM AND create segments: Target 70%+ (vs CRM sync without targeting)
- Users who run campaigns AND create engagement segments: Target 50%+

**Why it matters:** Indicates users see platform as integrated whole, increases stickiness.

---

### Attribution Visibility

**Definition:** % of features where users can see upstream/downstream connections

**Examples:**
- Forms showing campaign attribution: Target 80%+ of forms
- Campaigns showing outcome conversions: Target 70%+ of campaigns
- Person records showing cross-feature timeline: Target 90%+ of profiles

**Why it matters:** Closed-loop reporting increases perceived value, enables optimization.

---

### Shortcut Utilization

**Definition:** % of workflow shortcuts used vs manual alternative

**Examples:**
- Retargeting campaigns created via shortcut vs manual: Target 60%+ via shortcut
- Follow-up campaigns via shortcut vs manual: Target 50%+ via shortcut
- CRM segments via auto-generation vs manual: Target 70%+ via auto-generation

**Why it matters:** High shortcut usage validates workflow design, indicates low friction.

---

## Integration Patterns by Feature Category

### Public-Facing Features (Forms, Landing Pages, Events)

**Must-have integrations:**
- ✅ Auto-generate visitor/completion segments
- ✅ UTM tracking for campaign attribution
- ✅ "Create campaign" shortcuts for retargeting
- ✅ Traffic sources reporting (campaign vs direct vs organic)
- ✅ CRM sync for conversions (if applicable)

**Nice-to-have integrations:**
- Person record timeline showing interactions
- Conversion funnel reporting (campaign → feature → outcome)
- Growth Credits application for paid promotion

---

### Communication Features (Email, Ads, SMS)

**Must-have integrations:**
- ✅ Auto-suggest engagement segments (opened, clicked, no engagement)
- ✅ "Create follow-up" shortcuts targeting engagement segments
- ✅ Goal tracking for conversion outcomes
- ✅ Audience targeting with data completeness indicators
- ✅ CRM sync for engagement activities

**Nice-to-have integrations:**
- Multi-touch workflow builder
- Engagement scoring in person records
- Predictive audience suggestions based on past performance

---

### Data Features (Segments, Imports, Integrations)

**Must-have integrations:**
- ✅ "Create campaign" shortcuts from segment dashboard
- ✅ Segment performance reporting (usage, campaign results)
- ✅ Data completeness indicators for targeting
- ✅ CRM field awareness in segment builder
- ✅ Auto-generated segments from other features

**Nice-to-have integrations:**
- Segment recommendations based on CRM data
- Lookalike audience generation
- Segment overlap analysis

---

### Reporting Features (Dashboard, Reports, Analytics)

**Must-have integrations:**
- ✅ Cross-feature reporting (campaign → form → donation)
- ✅ Multi-touch attribution showing complete funnel
- ✅ "Create segment" shortcuts from report filters
- ✅ "Create campaign" shortcuts from high-performing audiences
- ✅ Export includes attribution data

**Nice-to-have integrations:**
- Custom report builder with cross-feature data sources
- Automated insights surfacing optimization opportunities
- Goal tracking across workflow sequences

---

## PRD Skill Integration

To integrate these principles into the PRD skill, add this guidance:

### During Requirements Gathering

**Prompt after understanding feature description:**

"Before we continue, let's ensure this feature integrates well with the platform. I'll ask you the Five Integration Questions:

1. **Audience Connection**: Does this feature generate audience data? Should it auto-create segments?
2. **Campaign Attribution**: Can campaigns drive traffic here? Should we track which campaigns generate conversions?
3. **CRM Integration**: Should this feature sync data to/from Salesforce or RE NXT?
4. **Workflow Shortcuts**: What's the most common next step after using this feature? Can we pre-configure it?
5. **Closed-Loop Reporting**: Can users see the complete funnel (what drove them here, what happened after)?

For each YES answer, we'll add workflow integration requirements to the PRD."

---

### In Cross-Feature Requirements Section

**Auto-expand based on answers:**

If audience connection = YES:
```markdown
### Segmentation & Targeting
- **Auto-segment generation**: [Feature] automatically creates segments for [use cases]
- **Segment predicates**: Add predicates for [feature actions/states]
- **Data completeness**: Show % of segment with complete data for targeting
```

If campaign attribution = YES:
```markdown
### Reporting & Analytics
- **Campaign attribution**: Show which campaigns drove [feature] traffic/conversions
- **Traffic sources**: Break down [Direct, Campaign, Organic] in [feature] dashboard
- **Outcome tracking**: Show [feature] conversions in campaign reporting
```

If CRM integration = YES:
```markdown
### CRM Integration
- **Sync to CRM**: [Feature interactions] create [CRM records/activities]
- **Sync from CRM**: [CRM fields] used for [targeting/personalization]
- **Sync status**: Show last sync time, errors in [feature] dashboard
```

If workflow shortcuts = YES:
```markdown
### Other Platform Touchpoints
- **Workflow shortcuts**: [Feature] dashboard includes shortcuts:
  - "[Shortcut Name]": [Pre-configured workflow description]
  - "[Shortcut Name]": [Pre-configured workflow description]
- **Contextual suggestions**: After [trigger], suggest [next workflow step]
```

If closed-loop reporting = YES:
```markdown
### Reporting & Analytics
- **Upstream attribution**: Show what drove users to [feature]
- **Downstream outcomes**: Show what happened after [feature] interaction
- **Cross-feature reporting**: Enable reports showing [complete funnel]
```

---

### In User Stories Section

**Add integration stories alongside feature stories:**

```markdown
## User Stories

### Core Feature Stories
[Standard feature user stories...]

### Workflow Integration Stories

#### Auto-Segment Generation
**User Story:** As a [user type], I want segments automatically created from [feature] interactions so I can quickly retarget audiences without manual segment building.

**User Requirements:**
- After [feature action], system auto-generates segments: "[Segment names]"
- Segments appear in Audience section with "Auto-generated from [Feature]" badge
- [Feature] dashboard shows "View Audiences" link to generated segments
- Segments are editable but maintain source attribution

**System Requirements:**
- Background job creates segments after [trigger event]
- Segments update in real-time as new [feature] interactions occur
- Naming convention: "[Feature Name] - [Segment Type]"

---

#### Campaign Shortcuts
**User Story:** As a [user type], I want one-click campaign creation from [feature] dashboard so I can quickly act on [feature] audiences without manual configuration.

**User Requirements:**
- [Feature] dashboard includes "[Shortcut Name]" button
- Clicking shortcut opens campaign creation modal with pre-selected audience
- User can customize messaging, timing before creating campaign
- Success message: "Campaign created! View campaign →"

**System Requirements:**
- Shortcut pre-configures: audience, goal, suggested messaging
- Track shortcut usage for workflow validation
```

---

### Quality Checklist Addition

Add to PRD review checklist:

```markdown
## Workflow Integration Quality

- [ ] All 5 Integration Questions answered in PRD
- [ ] Cross-Feature Requirements include workflow integration sections (not N/A)
- [ ] User stories include integration stories (not just core feature)
- [ ] Success metrics include workflow completion rates (not just feature adoption)
- [ ] Mockups show workflow shortcuts, attribution, connected features
- [ ] No "feature islands" or "attribution black holes" identified
```

---

## Quick Reference Checklist

Use this during PRD scoping to ensure workflow integration:

### The Five Integration Questions
- [ ] **Audience Connection:** Does this generate audience data? Should it auto-create segments?
- [ ] **Campaign Attribution:** Can campaigns drive traffic? Should we track conversions?
- [ ] **CRM Integration:** Should this sync to/from Salesforce NPSP or RE NXT?
- [ ] **Workflow Shortcuts:** What's the most common next step? Can we pre-configure it?
- [ ] **Closed-Loop Reporting:** Can users see complete funnel (source → feature → outcome)?

### Integration Patterns to Apply
- [ ] **Auto-Generation:** If feature generates data, auto-create segments (what/when/naming)
- [ ] **Full Shortcuts:** Pre-configured workflows when >50% settings known (3-5 shortcuts)
- [ ] **Next-Step Guidance:** Recommended actions + quick links (always provide)
- [ ] **Bi-Directional Sync:** Data flows both ways with CRM (TO + FROM + status)
- [ ] **Attribution Visibility:** Show upstream sources + downstream outcomes

### PRD Sections to Populate
- [ ] Person Records - Timeline/journey visualization
- [ ] Segmentation & Targeting - Auto-generation pattern
- [ ] Reporting & Analytics - Attribution visibility pattern
- [ ] Billing & Credits - Growth Credits if applicable
- [ ] CRM Integration - Bi-directional sync pattern
- [ ] Campaign Goals - Goal tracking + attribution
- [ ] Other Platform Touchpoints - Shortcuts + next-step guidance

### Anti-Patterns to Avoid
- [ ] 🚫 Feature Islands (data created but not connected)
- [ ] 🚫 Manual Duct Tape (obvious workflows require manual connection)
- [ ] 🚫 Attribution Black Holes (can't identify sources or outcomes)
- [ ] 🚫 One-Way Data Flow (data syncs in but outcomes don't sync out)
- [ ] 🚫 Workflow Cliffs (success state with no guidance on next steps)

### Success Metrics to Define
- [ ] Workflow completion rate (% completing full sequence)
- [ ] Time to workflow completion (duration from start to finish)
- [ ] Cross-feature engagement (% using connected features)
- [ ] Attribution visibility (% with visible upstream/downstream)
- [ ] Shortcut utilization (% via shortcut vs manual)

---

## Conclusion

These principles transform feature development from **"build isolated capability"** to **"complete user workflow."**

By systematically applying the Five Integration Questions and workflow patterns, we ensure every new feature:
- Connects to existing platform data (audience, campaigns, CRM)
- Provides shortcuts for common workflows (or guidance when shortcuts not feasible)
- Shows attribution and closes the data loop
- Functions as part of integrated system, not standalone tool

This approach directly addresses customer feedback that platforms feel complex/fragmented compared to competitors. Over time, it transforms a product from "collection of tools" into "unified integrated platform."

---

**Related Documentation:**
- `prd-quality-guide.md` - Quality standards for PRD writing
- `usability-components.md` - UI component patterns for workflows
- `ui-patterns.md` - Common UI patterns across platform
- PRD skill Phase 3 - Implements these principles in active workflow
