# Feathr Usability Component Usage Guide

**Purpose**: This document provides prescriptive usage rules for Feathr's existing UI components to ensure consistent, user-friendly experiences across the platform. Use this guide when scoping features, writing PRDs, and designing user workflows.

**Target Audience**: Product Managers, Product Designers, and Claude Code for PRD/issue scoping

**Last Updated**: 2026-01-21

---

## Table of Contents

1. [Success & Completion Feedback](#1-success--completion-feedback)
2. [Progress Indicators](#2-progress-indicators)
3. [Error Handling & Validation](#3-error-handling--validation)
4. [Confirmation & Warnings](#4-confirmation--warnings)
5. [Form Components](#5-form-components)
6. [Navigation](#6-navigation)
7. [Onboarding & Guidance](#7-onboarding--guidance)
8. [Data Display](#8-data-display)
9. [Mobile Patterns](#9-mobile-patterns)
10. [Scoping Integration Guidelines](#10-scoping-integration-guidelines)

---

## 1. Success & Completion Feedback

### 1.1 Full-Screen Success Modal

**Component**: `FullScreenModal` (shrike)

**When to Use in User Stories**:
- Campaign launch workflows
- Integration setup completion
- Data import completion
- Form publication
- First-time major milestones

**Usage Rules**:

```
Structure:
- Headline (past tense): "Your campaign is live!"
- Subheading (expectation setting): "We'll start showing your ads within 24 hours"
- Primary action button: Navigate to created entity
- Secondary action button: Start another workflow or return to list
- Optional: Confetti animation for celebrations
```

**Scoping Template**:
```markdown
**On Success**:
- Show FullScreenModal with:
  - Headline: "[Entity] [action completed]"
  - Subheading: [What happens next / timeframe]
  - Primary CTA: "View [Entity]" -> navigates to [entity detail page]
  - Secondary CTA: "Create Another [Entity]" -> returns to [creation flow]
  - Confetti: [Yes/No - only for major milestones]
```

**Examples**:
| Workflow | Headline | Subheading | Primary CTA | Secondary CTA |
|----------|----------|------------|-------------|---------------|
| Campaign Launch | "Your campaign is live!" | "We'll start showing your ads within 24 hours. Track performance in your dashboard." | "View Campaign" | "Create Another Campaign" |
| Form Publication | "Your donation form is published!" | "Share your link to start collecting donations. Tips automatically convert to Growth Credits." | "Copy Form Link" | "View Dashboard" |
| CRM Integration | "Salesforce connected successfully!" | "We'll sync your contacts every hour. Your first sync starts now." | "View Sync Settings" | "Go to Contacts" |

**Implementation Notes**:
- Do NOT include "Don't show again" for one-time setup tasks
- Include Confetti component for first-time achievements (first campaign, first form, first integration)
- Store dismissal preferences in `user_preferences.success_modals_dismissed[]` for repeatable workflows

---

### 1.2 Inline Success Banner

**Component**: `NotificationV2` or `BannerNotification` (shrike)

**When to Use in User Stories**:
- Settings saved
- Team member invited
- Draft saved
- Item archived/deleted (with undo)
- Minor updates within current context

**Usage Rules**:

```
Structure:
- Position: Top of content area, below page header
- Auto-dismiss: 5 seconds
- Message format: "[What changed]. [Optional: What happens next]"
- Include Undo link: For destructive or significant changes
- Close button: Always visible
```

**Scoping Template**:
```markdown
**On Success**:
- Show inline success banner:
  - Message: "[Action completed]. [Optional impact/next step]"
  - Undo: [Yes/No - include 5-second undo window for destructive actions]
  - Auto-dismiss: 5 seconds
  - Position: Top of [page/section name]
```

**Examples**:
| Action | Message | Include Undo |
|--------|---------|--------------|
| Save Campaign Settings | "Campaign settings saved. Changes will apply to new flights." | No |
| Delete Contact | "Contact deleted." | Yes (5 sec) |
| Add Team Member | "Invitation sent to sarah@nonprofit.org" | No |
| Archive Campaign | "Campaign archived. You can restore it from Archived Campaigns." | Yes (5 sec) |

---

### 1.3 Toast Notification

**Component**: `Toast` (shrike, react-toastify)

**When to Use in User Stories**:
- Background processes complete (export, sync, report generation)
- Async operations finish while user works elsewhere
- System notifications (payment processed, sync complete)

**Usage Rules**:

```
Position: Bottom-left corner
Duration: 7 seconds (longer than inline banner)
Stacking: Max 3 toasts; queue additional
Types: Success (green), Error (red, no auto-dismiss), Warning (yellow), Info (blue)
Include link: If user might want immediate action
```

**Scoping Template**:
```markdown
**Background Process Completion**:
- Show toast notification:
  - Type: [success/error/warning/info]
  - Message: "[Process] is [status]"
  - Action link: "[View Results]" -> navigates to [destination]
  - Duration: 7 seconds (errors persist until dismissed)
```

**Examples**:
| Event | Type | Message | Action Link |
|-------|------|---------|-------------|
| Export Complete | Success | "Your contact export is ready" | "Download File" |
| CRM Sync Complete | Success | "Synced 342 contacts from Salesforce" | "View Activity Log" |
| Campaign Budget Exceeded | Warning | "Campaign paused: budget exceeded" | "Adjust Budget" |
| Payment Failed | Error | "Payment method declined. Update billing info." | "Update Payment" |

---

## 2. Progress Indicators

### 2.1 Multi-Step Progress Bar

**Component**: `Steps` + `StepSection` (shrike)

**When to Use in User Stories**:
- Multi-step workflows with 3-7 sequential steps
- Campaign creation
- Integration setup
- Form builder
- User needs to know position and remaining effort

**Usage Rules**:

```
Step Count: 3-5 ideal, max 7
Step Naming: Use action verbs (Configure, Import, Review, Launch)
Navigation: Allow return to completed steps, disable upcoming steps
Persistence: Save progress; allow "Save and Continue Later"
Visual States:
  - Completed: Filled circle with checkmark
  - Current: Filled circle, larger
  - Upcoming: Outline circle, gray
```

**Scoping Template**:
```markdown
**Multi-Step Workflow**:
- Use Steps component with [X] steps:
  1. [Step Name] - [Brief description of what user does]
  2. [Step Name] - [Brief description]
  3. [Step Name] - [Brief description]
  4. [Step Name] - [Brief description]

**Navigation Rules**:
- Allow back to previous steps: Yes
- Allow skip to upcoming steps: No (must complete sequentially)
- Save progress between steps: Yes
- "Save and Continue Later" button: [Yes/No]

**Validation**:
- Validate step before allowing "Next": Yes
- Show inline errors: Yes (use FormElement validation)
```

**Examples**:
| Workflow | Steps |
|----------|-------|
| Campaign Creation | 1. Choose Goal -> 2. Select Audience -> 3. Set Budget -> 4. Design Ads -> 5. Review & Launch |
| Integration Setup | 1. Connect Account -> 2. Map Fields -> 3. Configure Sync -> 4. Test Connection |
| Form Builder | 1. Form Details -> 2. Add Fields -> 3. Customize Design -> 4. Set Up Payments -> 5. Publish |
| CRM Sync Setup | 1. Authenticate -> 2. Select Objects -> 3. Map Fields -> 4. Schedule Sync -> 5. Run First Sync |

---

### 2.2 Loading States with Context

**Component**: `Spinner` + `AsyncDisplay` (shrike)

**When to Use in User Stories**:
- Any process taking >2 seconds
- File uploads
- Data imports
- API calls
- Report generation

**Usage Rules**:

```
<2 seconds: No indicator needed
2-30 seconds: Spinner with context message
30 sec - 2 min: Spinner with "About X minutes remaining"
2+ minutes: Progress bar with % and time estimate

Context message: Explain what's happening
  - "Validating 2,450 email addresses..."
  - "Uploading file 3 of 12..."
  - "Generating your report..."

Cancellation: Include "Cancel" button for processes >10 seconds
Warning: "Don't close this window" for processes >1 minute
```

**Scoping Template**:
```markdown
**Loading State**:
- Expected duration: [time estimate]
- Show: [Spinner/Progress bar]
- Context message: "[What system is doing]"
- Time estimate display: [Yes/No]
- Cancellation: [Yes/No - for processes >10 seconds]
- Keep-alive warning: [Yes/No - for processes >1 minute]

**On Error**:
- Preserve completed work: [Yes/No]
- Show error message: "[Error description with recovery guidance]"
- Allow retry: Yes
```

**Examples**:
| Process | Duration | Display | Context Message | Cancellable |
|---------|----------|---------|-----------------|-------------|
| Contact Import | 30-120 sec | Progress bar with % | "Validating email addresses... 1,247 of 3,500" | Yes |
| Campaign Launch | 5-10 sec | Spinner | "Finalizing campaign settings..." | No |
| Report Export | 30-120 sec | Spinner + estimate | "Generating your report... This may take up to 2 minutes" | Yes |
| CRM Sync | 60-300 sec | Progress bar | "Syncing contacts from Salesforce... 450 of 1,200" | No |

---

### 2.3 Skeleton Screens

**Component**: `Skeleton` or `FormSkeleton` (shrike, golden-goose)

**When to Use in User Stories**:
- Initial page load
- Fetching dashboard metrics
- Loading contact/campaign lists
- Loading report data
- Any predictable layout with async data

**Usage Rules**:

```
Match Layout: Skeleton should mirror actual content structure
Animation: Subtle shimmer effect (built-in)
Duration: Replace with actual content immediately; no minimum display time
Partial Loading: Show skeletons for pending sections while displaying loaded content
Never for Errors: Don't show skeleton if data fetch fails; show error state instead

DON'T USE:
- Unpredictable content structure
- User-triggered actions (use Spinner instead)
- Very fast loads (<500ms) - causes visual jitter
```

**Scoping Template**:
```markdown
**Initial Page Load**:
- Show skeleton for: [component/section names]
- Skeleton structure:
  - [Description of placeholder layout - e.g., "3 rows with title + 2 paragraphs each"]
- Replace with data when: [loading condition completes]

**Partial Loading**:
- Show real data for: [sections that load first]
- Show skeleton for: [sections still loading]
```

**Examples**:
| Page/Section | Skeleton Structure |
|--------------|-------------------|
| Dashboard Metrics | 4 card skeletons with title + large number + subtitle |
| Contact List | Table with 10 rows, 5 columns, alternating heights |
| Campaign Performance | Chart skeleton (bars) + 3 metric cards |
| Person Record | Profile header + 2-column layout with 6 sections |

---

## 3. Error Handling & Validation

### 3.1 Inline Field Validation

**Component**: `FormElement` (shrike) with integrated error display

**When to Use in User Stories**:
- All form inputs requiring validation
- Required fields
- Format-specific fields (email, URL, phone, currency)
- Unique fields (campaign name, email)
- Conditional validation

**Usage Rules**:

```
Validation Timing:
- Required fields: On blur (when user leaves field)
- Format fields (email, URL, phone): On blur
- Password strength: On input (real-time)
- Unique fields: On blur with 500ms debounce
- Cross-field validation: On blur of dependent field

Error Message Format: "[What's wrong] [How to fix it]"

Icon: Red warning triangle (built into FormElement)

Recovery: Clear error immediately when user corrects (validate on input after error shown)

Accessibility: FormElement handles aria-describedby automatically
```

**Scoping Template**:
```markdown
**Field Validation**:

[Field Name]:
- Required: [Yes/No]
- Validation rules:
  - [Rule 1]: [Error message if violated]
  - [Rule 2]: [Error message if violated]
- Validation timing: [On blur / On input / On submit]
- Error message format: "[What's wrong]. [How to fix it]"

**Example**:
Email Address:
- Required: Yes
- Validation rules:
  - Valid email format: "Please enter a valid email address (e.g., name@nonprofit.org)"
  - Not already in use: "This email is already associated with another account"
- Validation timing: On blur
```

**Common Validation Examples**:
| Field Type | Validation Rule | Error Message |
|------------|-----------------|---------------|
| Email | Valid format | "Please enter a valid email address (e.g., name@nonprofit.org)" |
| URL | Valid format | "Please enter a valid URL starting with http:// or https://" |
| Phone | Valid format | "Please enter phone number in format: (555) 123-4567" |
| Budget | Minimum value | "Campaign budget must be at least $100. Need help setting your budget?" |
| Campaign Name | Unique | "A campaign with this name already exists. Try adding a date or version number." |
| Password | Strength | "Password must be at least 8 characters with 1 uppercase, 1 number, and 1 special character" |
| Date | Future date | "Start date must be today or later" |
| Credit Card | Valid format | "Please enter a valid credit card number" |

---

### 3.2 Form-Level Error Summary

**Component**: FormElement (array errors) - *Note: Needs sticky summary enhancement*

**When to Use in User Stories**:
- Multi-section forms
- Forms with >5 fields
- User attempts to submit form with multiple errors
- Errors span multiple sections/steps

**Usage Rules**:

```
Position: Top of form, sticky header
Links: Each error links to/focuses corresponding field
Count: Show count if >3 errors ("Please fix 7 errors before continuing")
Dismiss: Auto-remove errors as user fixes them
Scroll: Auto-scroll to first error when summary shown
Grouping: Group related errors by section
```

**Scoping Template**:
```markdown
**Form Submission with Errors**:
- Show error summary at top of form with:
  - Count: "Please fix [X] errors before continuing"
  - Grouped errors by section:
    - [Section Name]:
      - [Field name]: [Error message] (clickable, scrolls to field)
      - [Field name]: [Error message]
  - Auto-scroll to first error: Yes
  - Sticky positioning: Yes (remains visible on scroll)
  - Auto-dismiss: As user fixes each error
```

**Example**:
```markdown
On Campaign Creation Submit (with errors):
- Show error summary:
  - "Please fix 5 errors before launching your campaign"
  - Campaign Details:
    - Campaign Name: A campaign with this name already exists
    - Budget: Campaign budget must be at least $100
  - Audience:
    - Audience Selection: Please select at least one audience
  - Schedule:
    - Start Date: Start date must be today or later
    - End Date: End date must be after start date
```

---

### 3.3 Page-Level Error States

**Component**: `ErrorBoundary` (shrike, golden-goose)

**When to Use in User Stories**:
- Entire page/feature fails to load
- Critical system error prevents functionality
- Network errors
- Permission denied
- Resource not found (404)

**Usage Rules**:

```
Tone: Empathetic, apologetic, not technical
Avoid Error Codes: Unless support needs them (show in small text at bottom)
Action Options:
  - Primary: Most likely to resolve (Retry, Refresh, Go Back)
  - Secondary: Alternative path (Contact Support, Return Home)
Illustrations: Use friendly, calming imagery (not scary/broken icons)
Context Preservation: If user had unsaved work, offer recovery option
```

**Scoping Template**:
```markdown
**Error State**: [Error scenario name]
- Trigger: [What causes this error]
- Heading: "[User-friendly error heading]"
- Message: "[Plain English explanation] [Why it happened] [What user can do]"
- Primary CTA: "[Action]" -> [behavior]
- Secondary CTA: "[Action]" -> [behavior]
- Error code display: [Yes/No - only if support needs for debugging]
```

**Examples**:
| Scenario | Heading | Message | Primary CTA | Secondary CTA |
|----------|---------|---------|-------------|---------------|
| Network Error | "We couldn't load your dashboard" | "It looks like you're offline. Check your internet connection and try again." | "Retry" | "Contact Support" |
| Permission Error | "You don't have access to this campaign" | "This campaign belongs to a different team. Contact your administrator to request access." | "View My Campaigns" | "Contact Admin" |
| 404 Not Found | "This page doesn't exist" | "The link you followed may be outdated, or the item may have been deleted." | "Go to Dashboard" | "Search Campaigns" |
| API Error | "Something went wrong" | "We encountered an unexpected error. Our team has been notified. Please try again in a few moments." | "Refresh Page" | "Contact Support" |
| Integration Error | "We couldn't connect to Salesforce" | "Your Salesforce connection expired. Please reconnect to continue syncing contacts." | "Reconnect Now" | "View Sync Settings" |

---

### 3.4 Empty States

**Component**: Custom component - *Note: Needs standardization*

**When to Use in User Stories**:
- First-time empty state (no data exists yet)
- Filtered view returns no results
- Search returns no matches
- Feature requires prerequisite setup

**Usage Rules**:

```
Structure:
- Illustration (friendly, not error-focused)
- Headline (encouraging, future-focused)
- Explanation + benefit statement
- Primary CTA button (strong action verb)
- Optional: Help link or tutorial

First-Time Empty State:
  - Headline: Use "your" (possessive, personal)
  - Example: "Your first campaign starts here"
  - CTA: First-person if appropriate ("Create My First Campaign")
  - Include benefit: "Reach more supporters with targeted ads"

No Results from Filter/Search:
  - Headline: Acknowledge user's search
  - Example: "No campaigns match your filters"
  - CTA: "Clear Filters" or "Reset Search"
  - Suggestion: "Try adjusting your filters or search terms"

Prerequisite Required:
  - Headline: Explain what's needed
  - Example: "Connect your CRM to see contacts here"
  - CTA: Link to prerequisite setup
  - Benefit: Explain value after setup
```

**Scoping Template**:
```markdown
**Empty State**: [Context name]
- Type: [First-time / No results / Prerequisite required]
- Illustration: [Description or reference]
- Headline: "[Encouraging, future-focused message]"
- Explanation: "[What this feature does] [Why it's valuable]"
- Primary CTA: "[Action Verb] [Object]" -> navigates to [destination]
- Secondary action: [Optional: Help link, tutorial, example]
```

**Examples**:
| Context | Type | Headline | Explanation | CTA | Help Link |
|---------|------|----------|-------------|-----|-----------|
| No Campaigns | First-time | "Your first campaign starts here" | "Create targeted ad campaigns to reach more supporters and increase awareness for your cause." | "Create Your First Campaign" | "Watch Tutorial" |
| No Contacts | First-time | "Build your audience" | "Import contacts from your CRM or upload a CSV to start building targeted audiences." | "Import Contacts" | "Learn More" |
| No Search Results | No results | "No contacts match 'John Smith'" | "Try searching by email address or adjusting your search terms." | "Clear Search" | None |
| No Active Campaigns | Filtered | "No campaigns in 'Active' status" | "You don't have any active campaigns right now." | "Show All Campaigns" | None |
| No Contacts (CRM not connected) | Prerequisite | "Connect your CRM to see contacts" | "Sync contacts from Salesforce or RE NXT to start building audiences and tracking supporter engagement." | "Connect CRM" | "Learn More" |

---

## 4. Confirmation & Warnings

### 4.1 Destructive Action Confirmation

**Component**: `ConfirmModal` or `ArchiveModal` (shrike)

**When to Use in User Stories**:
- Deleting entities (campaigns, contacts, integrations)
- Actions that cannot be undone
- Actions with significant impact (financial, data loss)
- Removing team members
- Disconnecting integrations

**Usage Rules**:

```
Severity Levels:

LOW (Simple confirmation):
- Use for: Deleting drafts, removing tags, canceling drafts
- Confirmation: Simple modal with OK/Cancel
- No typing required

MEDIUM (Impact statement):
- Use for: Deleting active campaigns, archiving contacts, pausing syncs
- Confirmation: Modal with impact statement
- Explain what will be affected
- Show numbers/counts
- Example: "This will stop 2 active flights and permanently delete all performance data"

HIGH (Type to confirm):
- Use for: Deleting integrations, deleting accounts, bulk deletions
- Confirmation: Require typing entity name or "DELETE"
- Show comprehensive impact statement
- List all consequences
- Example: "Type 'DELETE' to confirm deletion of 1,247 contacts"

Button Styling:
- Destructive button: Red, aligned right
- Cancel button: Gray, aligned left (default focus)

Alternatives:
- Offer non-destructive alternative when possible
- "Archive instead" vs "Delete permanently"
- "Pause campaign" vs "Delete campaign"
```

**Scoping Template**:
```markdown
**Destructive Action**: [Action name]
- Severity: [Low / Medium / High]
- Trigger: User clicks "[Button name]" on [location]

**Confirmation Modal**:
- Heading: "[Action] [Entity]?"
- Impact statement: "[What will be deleted/affected] [What happens to dependent items] [Consequences]"
- Confirmation method: [Simple confirm / Type entity name / Type "DELETE"]
- Buttons:
  - Cancel (gray, left, default focus)
  - [Destructive Action] (red, right)

**Alternative Action** (if applicable):
- Offer: "[Less destructive alternative]"
- Example: "Archive Campaign" vs "Delete Campaign"

**Undo Grace Period** (if applicable):
- For medium-severity actions: 10-second undo window with toast notification
```

**Examples**:

| Action | Severity | Confirmation | Impact Statement | Alternative |
|--------|----------|--------------|------------------|-------------|
| Delete Draft Campaign | Low | Simple modal | "This campaign has never run. You can recreate it anytime." | None |
| Delete Active Campaign | Medium | Modal with impact | "This will stop 2 active flights and permanently delete all performance data. This cannot be undone." | "Pause Campaign" |
| Delete Integration | High | Type integration name | "This will disconnect Salesforce and delete all field mappings. You'll need to reconfigure the integration from scratch." | None |
| Delete Account | High | Type "DELETE" + email | "This will permanently delete your account, all campaigns, contacts, and data. This cannot be undone." | None |
| Remove Team Member | Medium | Modal with impact | "This will revoke Sarah's access to all campaigns and remove her from 3 shared audiences." | None |
| Bulk Delete Contacts | High | Type contact count | "Type '247' to confirm deletion of 247 contacts. This cannot be undone." | "Archive Contacts" |

---

### 4.2 Leaving Unsaved Changes Warning

**Component**: Custom implementation needed (hook + Modal)

**When to Use in User Stories**:
- User navigates away from form with unsaved changes
- Browser/tab closing with unsaved work
- Clicking different tab in multi-step form (if changes would be lost)

**Usage Rules**:

```
Detection:
- Track form dirty state (initial values vs current)
- Hook beforeunload event for browser navigation
- Intercept in-app navigation via routing

Better Alternative: Auto-save
- For complex forms (campaign builder, form builder)
- Auto-save every 30 seconds
- Show "Last saved 2 minutes ago" timestamp
- Eliminates need for warning modal

Don't Show If:
- User clicked "Save" (even if save failed - show error instead)
- No actual changes made (pristine form)
- Navigating between steps in multi-step form with progress saved

Button Focus:
- Default focus on "Stay on Page" (safer option)
- Require intentional click on "Leave Anyway"
```

**Scoping Template**:
```markdown
**Unsaved Changes Handling**:

**Preferred Approach: Auto-save**
- Auto-save interval: 30 seconds
- Show timestamp: "Last saved [time] ago"
- On navigation: Allow without warning

**Fallback: Warning Modal** (if auto-save not feasible)
- Trigger: User navigates away with unsaved changes
- Modal:
  - Heading: "You have unsaved changes"
  - Message: "If you leave now, your changes will be lost."
  - Buttons:
    - "Stay on Page" (gray, left, default focus)
    - "Leave Anyway" (red, right)

**Exceptions** (don't show warning):
- User clicked Save button
- Form is pristine (no changes made)
- Changes already saved via auto-save
```

**Examples**:
| Context | Approach | Implementation |
|---------|----------|----------------|
| Campaign Builder | Auto-save | Save draft every 30 seconds, show "Last saved" timestamp |
| Form Builder | Auto-save | Save configuration every 30 seconds |
| Settings Page | Warning modal | Show modal on navigate away if changes unsaved |
| Contact Edit | Warning modal | Show modal on browser close/navigate if changes unsaved |
| Multi-step wizard | Auto-save per step | Save step data on step change, no warning needed |

---

### 4.3 Limit/Quota Warnings

**Component**: `NotificationV2` - *Note: Needs threshold variant enhancement*

**When to Use in User Stories**:
- User approaching plan limit (80% threshold)
- User exceeded limit and action blocked
- Action would cause overage charges
- Growth Credits running low

**Usage Rules**:

```
Warning Thresholds:
- 80%: Inline banner, dismissible, only on relevant page
- 95%: Persistent banner, not dismissible, on relevant page
- 100%: Blocking modal, must take action

Message Format:
- Current usage with units (8,456 contacts, $2,450 ad spend)
- Plan limit (10,000 contacts, $3,000/month)
- What happens at limit
- How to resolve (upgrade, buy more, remove old items)

Placement:
- 80-95%: Top of relevant page only (contacts page shows contact limit)
- 100%: Modal when attempting blocked action

Growth Credits Specific:
- Show credit balance in campaign budget picker
- Warn if campaign budget exceeds remaining credits
- Offer option to purchase more or reduce budget
```

**Scoping Template**:
```markdown
**Limit Warning**: [Resource name]

**80% Threshold** (Warning):
- Trigger: User reaches 80% of [resource limit]
- Show: Inline banner at top of [page name]
- Dismissible: Yes
- Message: "You've used [X] of [Y] [resource] ([%]%). [What happens at limit]"
- CTA: "View Usage" / "Upgrade Plan"

**95% Threshold** (Urgent Warning):
- Trigger: User reaches 95% of [resource limit]
- Show: Persistent banner at top of [page name]
- Dismissible: No
- Message: "You've used [X] of [Y] [resource] ([%]%). [What happens at limit]"
- CTA: "Upgrade Now" / "Manage [Resource]"

**100% Threshold** (Blocking):
- Trigger: User attempts action that would exceed limit
- Show: Blocking modal
- Message: "You've reached your [resource] limit ([X]/[Y]). [What action is blocked]"
- Primary CTA: "[Upgrade Plan]" -> upgrade flow
- Secondary CTA: "[Manage Resource]" -> manage page
```

**Examples**:

| Resource | Threshold | Message | CTA |
|----------|-----------|---------|-----|
| Contacts (80%) | Warning | "You've used 8,456 of 10,000 contacts (85%). When you reach your limit, you won't be able to import new contacts." | "View Usage" / "Upgrade Plan" |
| Contacts (100%) | Blocking | "You've reached your contact limit (10,000/10,000). Remove contacts or upgrade your plan to import more." | "Upgrade Plan" / "Manage Contacts" |
| Growth Credits ($0) | Blocking | "You don't have any Growth Credits. Add credits or use a payment method to launch this campaign." | "Add Credits" / "Add Payment Method" |
| Growth Credits (Low) | Warning | "You have $50 in Growth Credits remaining. Your scheduled campaigns will pause when credits run out." | "Add Credits" |
| Team Members (100%) | Blocking | "You've reached your team member limit (5/5). Upgrade your plan to add more team members." | "Upgrade Plan" / "Remove Members" |
| Ad Spend (95%) | Urgent | "You've spent $2,850 of your $3,000 monthly budget (95%). Campaigns will pause when you reach your limit." | "Increase Budget" / "Pause Campaigns" |

---

## 5. Form Components

### 5.1 FormElement Wrapper

**Component**: `FormElement` (shrike)

**When to Use in User Stories**:
- Wrap ALL form inputs
- Provides consistent validation, help text, labels, and accessibility

**Usage Rules**:

```
Standard Structure:
<FormElement
  label="[Field Label]"
  helpText="[Optional: Explanatory text]"
  error={[validation error]}
  required={true/false}
>
  <Input ... />
</FormElement>

Label: Always required (for accessibility)
Help Text: Use for non-obvious fields, format requirements, or context
  - Placement: Below label (not placeholder)
  - Tone: Conversational, second-person
  - Length: 1-2 sentences max
  - Example: "We'll send campaign reports to this email. You can add more recipients in Settings."

Error Display: Automatically handled by FormElement
  - Red border on input
  - Warning icon
  - Error message below field
  - aria-describedby for screen readers

Required Indicator: Red asterisk automatically shown if required={true}

Prefix/Suffix: Support for icons or text before/after input
```

**Scoping Template**:
```markdown
**Form Fields**:

[Field Name]:
- Component: [Input type]
- Label: "[Field label]"
- Help text: "[Optional explanatory text]"
- Required: [Yes/No]
- Placeholder: "[Optional example]"
- Prefix/Suffix: [Optional icon or text]
- Validation: [Validation rules]
- Error messages: [Error message for each rule]

**Example**:
Campaign Budget:
- Component: NumberInput
- Label: "Daily Budget"
- Help text: "We'll spend up to this amount per day. You can adjust anytime."
- Required: Yes
- Prefix: "$"
- Validation:
  - Minimum $10: "Campaign budget must be at least $10"
  - Maximum $10,000: "Campaign budget cannot exceed $10,000 per day"
```

---

### 5.2 Common Form Components

**Available Components** (shrike):

| Component | Use Case | Special Features |
|-----------|----------|------------------|
| `Input` | Text input | Standard text field |
| `EmailInput` | Email addresses | Built-in format validation |
| `PasswordInput` | Passwords | Masked input, show/hide toggle |
| `NumberInput` | Numeric values | Format handling, min/max |
| `Textarea` | Multi-line text | Auto-resize option |
| `Checkbox` | Boolean toggle | Indeterminate state, layout variants |
| `Radios` | Single selection | Status tracking |
| `Select` | Dropdown selection | AsyncSelect, CreatableSelect, isMulti |
| `DatePicker` | Date selection | Calendar popup |
| `TimeRange` | Time selection | Start/end time picker |
| `ColorPicker` | Color selection | Color picker UI |
| `Slider` | Numeric range | Visual slider |
| `Toggle` | On/off switch | Alternative to checkbox |
| `FileUpload` | File selection | Filestack integration, drag-and-drop |
| `DualListbox` | Multi-select transfer | Move items between lists |

---

### 5.3 File Upload

**Component**: `FileUpload` (shrike)

**When to Use in User Stories**:
- Importing contacts (CSV)
- Uploading creative assets (images, videos)
- Attaching documents
- Logo/image uploads

**Usage Rules**:

```
Drag-and-Drop Zone:
- Show accepted formats
- Show max file size
- Allow click to browse

Accepted Formats:
- Always specify (CSV for contacts, PNG/JPG for images)
- Reject wrong formats immediately
- Link to format requirements or template

Size Limits:
- Show max file size
- Reject oversized files before upload starts
- Suggest compression if too large

Progress Indicator:
- Progress bar with %
- Show file size (uploaded / total)
- Allow cancellation mid-upload
- Success checkmark when complete

Validation:
- Validate format/content after upload
- Show validation errors in list
- Allow download of error report for large files
- Offer "Upload Anyway" for non-critical errors
```

**Scoping Template**:
```markdown
**File Upload**:
- Accepted formats: [CSV, XLS, PNG, JPG, etc.]
- Max file size: [e.g., 50 MB]
- Drag-and-drop: Yes
- Click to browse: Yes

**Upload Process**:
- Show progress: Yes (progress bar with %)
- Allow cancel: Yes
- Success indicator: Checkmark + file name

**Validation**:
- Validate: [Format / Content / Size / Dimensions]
- On error: [Show error list / Allow download error report / Offer retry]
- Critical errors: Reject upload
- Non-critical errors: Allow "Upload Anyway" option

**Help Resources**:
- Link to template: [Yes/No - URL]
- Link to format guide: [Yes/No - URL]
```

**Examples**:

| Use Case | Formats | Max Size | Validation | Help |
|----------|---------|----------|------------|------|
| Contact Import | CSV, XLS, XLSX | 50 MB | Email format, required fields (First Name, Last Name, Email) | "Download CSV Template" link |
| Ad Creative | PNG, JPG, GIF | 10 MB | Dimensions (1200x628), aspect ratio (1.91:1) | "View Ad Specs" link |
| Logo Upload | PNG, SVG | 2 MB | Transparent background recommended | "Logo Guidelines" link |
| Email Attachment | PDF, DOCX, PNG, JPG | 25 MB | Virus scan | None |

---

### 5.4 Date & Time Pickers

**Component**: `DatePicker`, `TimeRange` (shrike)

**When to Use in User Stories**:
- Scheduling campaigns/emails
- Setting date ranges for reports
- Filtering by date

**Usage Rules**:

```
Date Picker:
- Calendar dropdown (don't require typing)
- Allow manual typing with validation
- Format: MM/DD/YYYY (U.S. standard)
- Today highlighted in blue
- Disable past dates if inappropriate (campaign start date)

Date Range Shortcuts (for reports, filters):
- Last 7 days
- Last 30 days
- Last 3 months
- This year
- Custom range (opens calendar)

Time Picker (scheduling):
- Dropdown with 15-min increments
- Show timezone: "Campaign will start at 9:00 AM EST"
- Default to 9:00 AM (work hours)
- Warn if scheduling outside business hours

Smart Defaults:
- Campaign start: Tomorrow at 9:00 AM
- Campaign end: 30 days from start
- Report range: Last 30 days
- Never default to past dates for scheduling

Validation:
- End date must be after start date
- Warn if campaign duration unusually short/long
- Prevent scheduling in past (except recurring)
```

**Scoping Template**:
```markdown
**Date/Time Selection**:

[Field Name]:
- Component: [DatePicker / TimeRange / DateRangePicker]
- Default value: [Smart default]
- Allow past dates: [Yes/No]
- Timezone display: [Yes/No - show user's timezone]
- Time increments: [15 min / 30 min / 1 hour]

**Validation**:
- [Rule 1]: [Error message]
- [Rule 2]: [Error message]

**Shortcuts** (if date range):
- [Last 7 days / Last 30 days / Last 3 months / This year / Custom]

**Example**:
Campaign Start Date:
- Component: DatePicker + TimeRange
- Default value: Tomorrow at 9:00 AM
- Allow past dates: No
- Timezone display: Yes ("Campaign will start at 9:00 AM EST")
- Time increments: 15 minutes
- Validation:
  - Must be future date: "Start date must be today or later"
  - Business hours warning: "Campaigns started during business hours typically perform better"
```

---

## 6. Navigation

### 6.1 Breadcrumbs

**Component**: `Breadcrumbs` (shrike)

**When to Use in User Stories**:
- Hierarchical navigation (Campaigns > Campaign Name > Flights > Flight Details)
- Detail pages nested 2+ levels deep
- Users need to backtrack easily

**Usage Rules**:

```
Structure: Home > Level 1 > Level 2 > Current Page
Separator: > (consistent)
Links: All segments clickable except current page (plain text)
Levels: Show all parent levels, no truncation
Icons: Optional icon per segment
Mobile: Truncate to "< Back to [parent]" button
Position: Below page header, above main content
```

**Scoping Template**:
```markdown
**Breadcrumb Navigation**:
- Structure: [Level 1] > [Level 2] > [Level 3] > [Current Page]
- All levels clickable: Yes (except current page)
- Mobile behavior: Show "< Back to [parent]" button

**Example**:
Campaigns > Summer Fundraiser > Flights > Flight #1234
```

---

### 6.2 Tab Navigation

**Component**: `Tabs` + `Tab` (shrike)

**When to Use in User Stories**:
- Multiple views of same entity (Campaign Overview, Performance, Settings)
- Related sections within page
- 2-7 tabs (>7 tabs consider different pattern)

**Usage Rules**:

```
Tab Count: 2-7 ideal (>7 use different navigation)
Active State: Bold text + bottom border
Order: Most important/frequently used first
Persistence: Save active tab in URL (allow direct linking)
Counts/Badges: Show counts if relevant (Settings (3 pending))
Mobile: Convert to dropdown if >4 tabs
```

**Scoping Template**:
```markdown
**Tab Navigation**:
- Tabs:
  1. [Tab Name] - [Brief description of content]
  2. [Tab Name] - [Brief description of content]
  3. [Tab Name] - [Brief description of content]
- Default tab: [Tab name]
- URL persistence: Yes (tab parameter in URL)
- Counts/badges: [Yes/No - if yes, specify what's counted]
- Mobile behavior: [Tabs / Dropdown if >4]

**Example**:
Campaign Detail Page Tabs:
1. Overview - Campaign summary, status, key metrics
2. Performance - Charts, analytics, conversion data
3. Flights - List of ad flights in campaign
4. Settings - Configuration, budget, schedule
- Default tab: Overview
- URL persistence: Yes (?tab=overview)
- Mobile: Dropdown (4 tabs)
```

---

### 6.3 Contextual Menus

**Component**: `ContextMenu` or `Menu` (shrike)

**When to Use in User Stories**:
- Row actions in tables (edit, duplicate, delete)
- Card actions (archive, share, settings)
- Bulk actions dropdown

**Usage Rules**:

```
Trigger: Three-dot menu icon (...) or right-click
Actions: 3-6 actions max (more = consider reorganizing)
Order:
  1. Most common actions (Edit, View)
  2. Secondary actions (Duplicate, Share)
  3. Destructive actions (Archive, Delete) - separate with divider
Destructive styling: Red text for delete/archive
Icons: Include icons for each action
Keyboard: Accessible via keyboard navigation
```

**Scoping Template**:
```markdown
**Context Menu**: [Location - e.g., Campaign row]
- Trigger: Three-dot menu icon
- Actions:
  1. [Action Name] (icon: [icon name]) -> [behavior]
  2. [Action Name] (icon: [icon name]) -> [behavior]
  ---
  3. [Destructive Action] (icon: [icon name], red text) -> [requires confirmation]

**Example**:
Campaign Row Context Menu:
- Trigger: Three-dot icon in campaign row
- Actions:
  1. Edit Campaign (icon: pencil) -> Navigate to edit page
  2. Duplicate Campaign (icon: copy) -> Open duplicate modal
  3. View Performance (icon: chart) -> Navigate to performance tab
  ---
  4. Archive Campaign (icon: archive, red) -> Show archive confirmation modal
  5. Delete Campaign (icon: trash, red) -> Show delete confirmation modal
```

---

## 7. Onboarding & Guidance

### 7.1 Onboarding System

**Component**: `OnboardingPage`, `Milestones`, `MilestoneTasks` (shrike)

**Existing Implementation**:
Feathr has a comprehensive two-level onboarding system:
- **Milestones**: Top-level groupings (Initial Account Setup, Single Send Campaign, Omni Campaign)
- **Tasks**: Discrete objectives within each milestone

**Current Milestones**:
1. **Initial Account Setup** - Configure account basics
2. **Single Send Campaign** - Email campaign setup
3. **Omni Campaign** - Ad campaign setup

**Task States**:
- NotStarted (dashed circle, gray)
- InProgress (animated dashed circle, gray)
- Completed (checkmark, green)
- Skipped (checkmark, green)

**When to Add New Tasks in User Stories**:

```
Consider adding onboarding task if:
- Feature is critical for first-time setup
- Feature is commonly used by new users
- Feature is a prerequisite for other features
- Feature represents a key activation milestone

Don't add onboarding task if:
- Feature is advanced/rarely used
- Feature is self-explanatory
- Feature is optional/nice-to-have
```

**Usage Rules**:

```
Task Properties:
- Type: Unique enum identifier (EOnboardingTaskType)
- Title: Action-oriented (e.g., "Authenticate Domain", "Create First Project")
- Description: Brief explanation of what task accomplishes
- Minutes to complete: Time estimate (5-30 minutes typical)
- Optional: Whether task can be skipped
- Action URL: Where task is completed (can be modal instead)
- Prerequisites: Other tasks/features required first

Milestone Properties:
- Contains 3-7 tasks
- Completion criteria: All required tasks completed
- Progress bar: Shows time remaining
```

**Scoping Template**:
```markdown
**Onboarding Task Addition**:

**Milestone**: [InitialAccountSetup / SingleSendCampaign / OmniCampaign / New Milestone]

**Task Details**:
- Task name: "[Action-oriented task name]"
- Task type: `[TaskTypeEnum]` (needs to be added to `EOnboardingTaskType`)
- Description: "[Brief explanation of what this accomplishes]"
- Minutes to complete: [estimate]
- Optional: [Yes/No]
- Prerequisites: [List other tasks that must be completed first]
- Action type: [Navigate to URL / Open modal]
  - If URL: [URL path]
  - If modal: [Modal type/name]

**Completion Criteria**:
- Mark complete when: [Specific condition - e.g., "User publishes first form", "User completes CRM connection"]
- Backend check: [How system determines completion]

**Progressive Feature Unlock** (if applicable):
- Unlocks access to: [Feature/navigation item]
- Blocks access to: [Feature that requires this task]

**Example**:
**Milestone**: InitialAccountSetup

**Task Details**:
- Task name: "Connect Your CRM"
- Task type: `ConnectCRM`
- Description: "Sync contacts from Salesforce or RE NXT to build targeted audiences"
- Minutes to complete: 15
- Optional: Yes
- Prerequisites: None
- Action type: Navigate to URL
  - URL: /settings/integrations

**Completion Criteria**:
- Mark complete when: User successfully connects Salesforce or RE NXT and first sync completes
- Backend check: Check for active CRM integration with last_sync_at timestamp

**Progressive Feature Unlock**:
- Unlocks access to: Contact import, Audience builder
```

**Existing Task Types Reference**:
```
EOnboardingTaskType:
- AuthenticateDomain
- BuildFirstGroup (audience segment)
- CreateFirstProject
- InviteOtherUsers
- SetupBilling
- SetupSuperPixel (tracking pixel)
- CreateEmailTemplate
- ImportEmailData
- PublishFirstEmailCampaign
- PublishFirstAdCampaign
```

---

### 7.2 Contextual Tooltips

**Component**: `Tooltip` (shrike, Mantine v7)

**When to Use in User Stories**:
- Complex fields requiring explanation
- Unfamiliar terminology
- Format requirements
- Non-obvious features

**Usage Rules**:

```
Trigger: Hover or click on [?] icon (blue/gray, not warning colors)
Positioning:
  - Prefer right/below field
  - Never cover form controls
  - Responsive on mobile (adjust as needed)
Content Length: Max 2-3 sentences
Link to docs: Include "Learn more >" link if detailed docs exist
Timing:
  - Persist on hover (don't auto-dismiss)
  - Click-triggered tooltips dismiss on outside click
Avoid Overuse: Max 3 tooltips per form

Smart Multiline: Built-in - automatically wraps at 40+ characters
```

**Scoping Template**:
```markdown
**Tooltip**: [Field name]
- Trigger: [?] icon next to field label
- Content: "[Brief explanation 1-2 sentences]"
- Learn more link: [Yes/No - URL if yes]
- Placement: [Right / Below / Above / Left]

**Example**:
**Tooltip**: Growth Credits
- Trigger: [?] icon next to "Growth Credits" field
- Content: "Growth Credits are Feathr's marketing currency. Apply credits to reduce your campaign cost. Credits never expire."
- Learn more link: Yes - /help/growth-credits
- Placement: Right of field
```

**Common Tooltip Examples**:
| Field | Tooltip Content |
|-------|-----------------|
| Growth Credits | "Growth Credits are Feathr's marketing currency. Apply credits to your campaign budget to reduce your cost. Credits never expire." |
| Match Rate | "Match rate shows how many of your contacts we could identify for ad targeting. Higher match rates mean better campaign performance. [Learn more >]" |
| Lookalike Audience | "We'll find new supporters who share characteristics with your best donors. This helps you reach people most likely to support your mission." |
| Frequency Cap | "Limit how often the same person sees your ad. Recommended: 3-5 times per week to avoid ad fatigue." |
| CPM | "Cost per thousand impressions. This is what you pay each time your ad is shown 1,000 times." |

---

### 7.3 Inline Help Panels

**Component**: `Well` + `Section` (shrike) - *Note: Needs standardized help panel variant*

**When to Use in User Stories**:
- Complex pages with multiple sections
- First-time users on sophisticated features
- Pages with configuration options

**Usage Rules**:

```
Structure:
- Icon + "Need help getting started?"
- List of help resources:
  - Watch tutorial video
  - Read step-by-step guide
  - Contact support
- Dismissible with [x] close button
- Store dismissal in user_preferences.help_dismissed[]
- Include "Show help again" link in page footer

Placement:
- Top of complex pages (audience builder, campaign builder)
- Right sidebar for persistent reference (less intrusive)

Content:
- Link to video tutorial (2-3 min ideal)
- Link to documentation article
- Link to contact support

Contextual: Match help content to current page/feature
```

**Scoping Template**:
```markdown
**Inline Help Panel**: [Page name]
- Placement: [Top of page / Right sidebar]
- Dismissible: Yes (store in `user_preferences.help_dismissed[]` as `help_dismissed_[page_key]`)
- Heading: "Need help getting started?"
- Resources:
  1. [Watch [X]-minute tutorial] -> [Video URL]
  2. [Read step-by-step guide] -> [Docs URL]
  3. [Contact support] -> [Support URL]
- "Show help again" link: Yes (in page footer)

**Example**:
**Inline Help Panel**: Audience Builder
- Placement: Top of page
- Dismissible: Yes (help_dismissed_audience_builder)
- Heading: "Need help building your first audience?"
- Resources:
  1. Watch 3-minute tutorial -> /tutorials/audience-builder
  2. Read audience guide -> /docs/audiences
  3. Contact support -> /support
```

---

## 8. Data Display

### 8.1 Tables

**Component**: `Table` (shrike)

**When to Use in User Stories**:
- Lists with multiple columns of data
- Data that benefits from sorting
- Data requiring bulk actions
- Campaigns, contacts, flights lists

**Usage Rules**:

```
Structure:
- Column headers (sortable where appropriate)
- Row data
- Optional: Row actions (context menu)
- Optional: Checkbox column for bulk selection

Sorting:
- Sortable columns: Click header to sort
- Visual indicator: Arrow up/down in header
- Default sort: Most relevant (usually most recent or alphabetical)

Row Actions:
- Three-dot menu in each row
- Common actions: Edit, Duplicate, Delete
- See Context Menu section for detailed rules

Bulk Selection:
- Checkbox column (leftmost)
- "Select all" in header (current page only)
- Show selection count + ActionBar when >=1 selected
- See Bulk Actions section for detailed rules

Empty State: Show empty state when no data (see Empty States section)

Pagination: For >50 rows, use pagination
```

**Scoping Template**:
```markdown
**Table**: [Table name/context]

**Columns**:
1. [Column Name] - [Data type] - Sortable: [Yes/No] - Default sort: [Asc/Desc/None]
2. [Column Name] - [Data type] - Sortable: [Yes/No]
3. [Column Name] - [Data type] - Sortable: [Yes/No]
4. Actions - [Context menu with X actions]

**Bulk Selection**:
- Enabled: [Yes/No]
- Bulk actions: [List actions]

**Row Actions** (Context Menu):
- [Action 1] -> [behavior]
- [Action 2] -> [behavior]
- [Destructive Action] -> [confirmation modal]

**Sorting**:
- Default sort: [Column name] [Asc/Desc]
- Sortable columns: [List columns]

**Pagination**:
- Rows per page: [25/50/100]
- Show total count: Yes

**Empty State**:
- Type: [First-time / Filtered / Search]
- Message: "[Empty state message]"
- CTA: "[Action]"

**Example**:
**Table**: Campaign List

**Columns**:
1. Campaign Name - Text - Sortable: Yes - Default sort: Asc
2. Status - Badge - Sortable: Yes
3. Budget - Currency - Sortable: Yes
4. Start Date - Date - Sortable: Yes - Default sort: Desc
5. Performance - Metrics - Sortable: No
6. Actions - Context menu

**Bulk Selection**:
- Enabled: Yes
- Bulk actions: Archive, Delete, Change Status

**Row Actions**:
- Edit Campaign -> Navigate to edit page
- Duplicate Campaign -> Open duplicate modal
- View Performance -> Navigate to performance page
---
- Archive Campaign -> Show confirmation modal
- Delete Campaign -> Show delete confirmation (type campaign name)

**Sorting**:
- Default sort: Start Date (Desc) - newest first
- Sortable columns: Campaign Name, Status, Budget, Start Date

**Pagination**:
- Rows per page: 25
- Show total count: Yes
```

---

### 8.2 Cards

**Component**: `CardV2` (shrike)

**When to Use in User Stories**:
- Dashboard widgets
- Grid layouts (campaigns, forms, integrations)
- Summary views
- Entity previews

**Usage Rules**:

```
Structure:
- CardHeader: Title + optional actions (menu, button)
- CardContent: Main content area
- CardActions: Footer buttons/actions (optional)

Usage Contexts:
- Dashboard metrics: Metric cards with title, large number, change indicator
- Entity cards: Preview cards in grid layouts
- Collapsible cards: Use CollapsibleCard variant for long content

Actions:
- Header actions: Context menu (...) for card-level actions
- Footer actions: Primary/secondary buttons (View Details, Edit)

Grid Layout: Use Grid component to arrange cards
```

**Scoping Template**:
```markdown
**Card**: [Card name/purpose]

**Header**:
- Title: "[Card title]"
- Actions: [Context menu / Button / None]
  - [Action 1] -> [behavior]
  - [Action 2] -> [behavior]

**Content**:
- [Description of content layout]
- [Data fields shown]

**Footer Actions**:
- Primary: "[Button label]" -> [behavior]
- Secondary: "[Button label]" -> [behavior]

**Example**:
**Card**: Campaign Summary Card (Dashboard)

**Header**:
- Title: "[Campaign Name]"
- Actions: Context menu
  - View Campaign -> Navigate to campaign detail
  - Edit Settings -> Navigate to settings
  - Pause Campaign -> Show confirmation modal

**Content**:
- Status badge: [Active/Paused/Completed]
- Budget remaining: $[amount] of $[total]
- Performance metrics:
  - Impressions: [number]
  - Clicks: [number]
  - CTR: [percentage]

**Footer Actions**:
- Primary: "View Details" -> Navigate to campaign detail
- Secondary: "View Report" -> Navigate to performance tab
```

---

### 8.3 Badges & Pills

**Component**: `Badge`, `Pill` (shrike)

**When to Use in User Stories**:
- Status indicators
- Tags/labels
- Counts
- Categories

**Usage Rules**:

```
Badge:
- Use for: Status (Active, Paused, Completed)
- Colors: Semantic
  - Green: Success, Active, Completed
  - Yellow: Warning, Pending, In Progress
  - Red: Error, Failed, Expired
  - Gray: Inactive, Draft, Archived
  - Blue: Info, New

Pill:
- Use for: Tags, categories, removable filters
- Rounded appearance
- Optional: Close button (x) for removal

Placement:
- Status badges: Next to entity name
- Tags/pills: Below entity name or in dedicated section
- Count badges: Next to tab names or menu items
```

**Scoping Template**:
```markdown
**Status Badges**:
- [Status 1]: [Color] - [When shown]
- [Status 2]: [Color] - [When shown]
- [Status 3]: [Color] - [When shown]

**Tags/Pills**:
- Purpose: [What tags represent]
- Removable: [Yes/No]
- Max displayed: [Number before "Show more"]

**Example**:
**Status Badges**: Campaign Status
- Active: Green - Campaign is currently running
- Paused: Yellow - Campaign is paused by user
- Scheduled: Blue - Campaign scheduled to start
- Completed: Gray - Campaign finished running
- Failed: Red - Campaign failed to launch

**Tags/Pills**: Campaign Tags
- Purpose: User-defined tags for organization
- Removable: Yes (x button)
- Max displayed: 3 (then "+ X more")
```

---

## 9. Mobile Patterns

### 9.1 Responsive Behavior

**Components**: All components should be mobile-responsive

**General Mobile Rules**:

```
Breakpoints:
- Mobile: <768px
- Tablet: 768-1024px
- Desktop: >1024px

Touch Targets:
- Minimum: 44px x 44px
- Spacing: 8px between targets

Text:
- Respect user font size settings
- Minimum body text: 16px (prevents zoom on iOS)
- Line height: 1.5 minimum

Navigation:
- Hamburger menu for main nav on mobile
- Breadcrumbs -> "< Back to [parent]" button
- Tabs (>4) -> Dropdown selector

Forms:
- Stack fields vertically
- Full-width inputs
- Larger tap targets for buttons
- Native date/time pickers when possible

Tables:
- Horizontal scroll for wide tables
- OR convert to card layout
- Show most important columns only
```

**Scoping Template**:
```markdown
**Mobile Considerations**:

**Layout**:
- Mobile breakpoint: [Behavior at <768px]
- Tablet breakpoint: [Behavior at 768-1024px]
- Desktop: [Behavior at >1024px]

**Navigation**:
- Mobile nav pattern: [Hamburger / Bottom bar / Tabs]
- Breadcrumbs: Convert to "< Back" button

**Forms**:
- Field layout: Stack vertically
- Input width: Full width
- Button layout: [Stack / Side-by-side if 2]

**Tables**:
- Mobile strategy: [Horizontal scroll / Card layout / Hide columns]
- Visible columns: [Column names shown on mobile]

**Touch Targets**:
- All buttons: >=44px x 44px
- Spacing: >=8px between interactive elements
```

---

### 9.2 Collapsible Sections (Mobile)

**Component**: `Collapse`, `CollapsibleCard`, `Accordion` (shrike, golden-goose)

**When to Use in User Stories**:
- Long forms on mobile
- Settings pages
- FAQ sections
- Mobile-optimized content

**Usage Rules**:

```
Default State: Collapse all except first section (or most important)
Indicator: Chevron icon (> collapsed, v expanded)
Tap Target: Entire header row (not just icon)
Animation: Smooth expand/collapse (200ms)
Persistence: Remember expanded state during session
Nesting: Avoid more than 2 levels of nesting
```

**Scoping Template**:
```markdown
**Collapsible Sections**: [Page/form name]

**Sections**:
1. [Section Name] - [Content description] - Default: [Expanded/Collapsed]
2. [Section Name] - [Content description] - Default: [Expanded/Collapsed]
3. [Section Name] - [Content description] - Default: [Expanded/Collapsed]

**Behavior**:
- Default state: [First section expanded, rest collapsed]
- Multiple sections open: [Yes/No - accordion mode]
- Remember state: [Session / Permanent]

**Example**:
**Collapsible Sections**: Campaign Settings (Mobile)

**Sections**:
1. Basic Settings - Campaign name, status, budget - Default: Expanded
2. Audience - Target audience selection - Default: Collapsed
3. Schedule - Start/end dates, timezone - Default: Collapsed
4. Advanced - Frequency cap, bidding strategy - Default: Collapsed

**Behavior**:
- Default state: Basic Settings expanded
- Multiple sections open: Yes (not accordion)
- Remember state: Session only
```

---

## 10. Scoping Integration Guidelines

### 10.1 When Writing User Stories

**Always Consider These Questions**:

1. **What happens when the user completes this action?**
   -> Specify success feedback component (Modal/Banner/Toast)

2. **Does this workflow have multiple steps?**
   -> Use Steps component, specify step names and navigation rules

3. **Will this take >2 seconds to process?**
   -> Specify loading state (Spinner/Progress bar) with context message

4. **What if this action fails?**
   -> Specify error state and recovery path

5. **Is this action destructive or irreversible?**
   -> Specify confirmation modal with severity level

6. **Will the user need guidance?**
   -> Consider tooltips, help panels, or onboarding tasks

7. **Is there a state where no data exists?**
   -> Define empty state with appropriate CTA

8. **Does this involve form inputs?**
   -> Use FormElement wrapper, specify validation rules and error messages

9. **Are there limits/quotas involved?**
   -> Define warning thresholds and blocking behavior

10. **Is this a first-time user experience?**
    -> Consider adding to onboarding system or showing feature discovery modal

---

### 10.2 User Story Template with Components

```markdown
## User Story: [Story Title]

**As a** [persona]
**I want to** [action]
**So that** [outcome/benefit]

---

### Acceptance Criteria

**Workflow**:
1. User [action] -> [system response using component]
2. User [action] -> [system response using component]
3. User [action] -> [system response using component]

**[Multi-Step Flow]** (if applicable):
- Use Steps component with [X] steps:
  1. [Step Name] - [Description]
  2. [Step Name] - [Description]
  3. [Step Name] - [Description]

**Success State**:
- Component: [FullScreenModal / Banner / Toast]
- Headline: "[Success message]"
- Subheading: "[What happens next]"
- Primary CTA: "[Action]" -> [behavior]
- Secondary CTA: "[Action]" -> [behavior]

**Error Handling**:
- [Error scenario 1]:
  - Component: [Inline validation / Modal / Banner]
  - Message: "[Error message with recovery guidance]"
  - Recovery: [How user resolves]
- [Error scenario 2]:
  - Component: [Inline validation / Modal / Banner]
  - Message: "[Error message with recovery guidance]"
  - Recovery: [How user resolves]

**Loading State**:
- Expected duration: [time]
- Component: [Spinner / Progress bar]
- Context message: "[What system is doing]"
- Cancellable: [Yes/No]

**Empty State** (if applicable):
- Type: [First-time / No results / Prerequisite]
- Headline: "[Encouraging message]"
- Explanation: "[What this feature does]"
- CTA: "[Action]" -> [behavior]

**Validation**:
- [Field 1]:
  - Required: [Yes/No]
  - Rules: [Validation rules]
  - Errors: [Error messages]
- [Field 2]:
  - Required: [Yes/No]
  - Rules: [Validation rules]
  - Errors: [Error messages]

**Confirmation** (if destructive):
- Severity: [Low / Medium / High]
- Modal:
  - Heading: "[Action] [Entity]?"
  - Impact: "[What will be affected]"
  - Confirmation: [Simple / Type name / Type DELETE]

**Mobile Considerations**:
- Layout: [Specific mobile behavior]
- Navigation: [Mobile nav pattern]
- Touch targets: All >=44px x 44px

---

### Related Components
- [List specific components used in this story]

### Open Questions
- [Any unresolved questions about component usage]
```

---

### 10.3 PRD Section: User Experience Patterns

**When writing PRDs, include this section**:

```markdown
## User Experience Patterns

This section defines the specific UI components and interaction patterns for this feature, ensuring consistency with Feathr's usability standards.

### Success & Completion Feedback
[Specify which success feedback components are used and when]

### Progress Indication
[Specify if multi-step workflow, loading states, or progress tracking needed]

### Error Handling
[Define error states, validation rules, and recovery paths]

### Guidance & Help
[Specify tooltips, help panels, or onboarding tasks]

### Empty States
[Define empty states for first-time use, no results, or prerequisites]

### Confirmation & Warnings
[Specify confirmation modals for destructive actions or limit warnings]

### Mobile Behavior
[Define any mobile-specific patterns or responsive behavior]

### Component Reference
[List all components used with file paths for developer reference]
- Component 1: `/path/to/component`
- Component 2: `/path/to/component`
```

---

### 10.4 Example User Story with Full Component Integration

```markdown
## User Story: Delete Campaign

**As a** marketing coordinator
**I want to** delete a campaign I no longer need
**So that** I can keep my campaign list organized and avoid confusion

---

### Acceptance Criteria

**Workflow**:
1. User clicks three-dot menu (...) on campaign row in campaign list
2. Context menu appears with campaign actions
3. User clicks "Delete Campaign" (red text, trash icon)
4. Confirmation modal appears (HIGH severity - type campaign name)
5. User types campaign name to confirm
6. User clicks "Delete Campaign" button (red, right-aligned)
7. Modal closes, deletion processes (2-3 seconds)
8. Toast notification appears confirming deletion
9. Campaign removed from list

**Context Menu**:
- Component: `ContextMenu` (shrike)
- Trigger: Three-dot icon in campaign row
- Actions:
  1. Edit Campaign (icon: pencil) -> Navigate to edit page
  2. Duplicate Campaign (icon: copy) -> Open duplicate modal
  3. View Performance (icon: chart) -> Navigate to performance tab
  ---
  4. Archive Campaign (icon: archive, red) -> Show archive confirmation (MEDIUM severity)
  5. Delete Campaign (icon: trash, red) -> Show delete confirmation (HIGH severity)

**Confirmation Modal** (High Severity):
- Component: `ConfirmModal` (shrike)
- Heading: "Delete Campaign?"
- Impact statement:
  - "This will permanently delete '[Campaign Name]' and all associated data:"
  - "- 3 active flights will be stopped immediately"
  - "- All performance data and reports will be deleted"
  - "- This action cannot be undone"
- Confirmation method: Type campaign name to confirm
  - Input placeholder: "Type campaign name to confirm"
  - Delete button disabled until exact match
- Buttons:
  - "Cancel" (gray, left, default focus)
  - "Delete Campaign" (red, right, enabled when name matches)

**Alternative Action**:
- Show: "Consider archiving instead" with "Archive Campaign" link
- Archive preserves data but removes from active list

**Loading State**:
- Expected duration: 2-3 seconds
- Component: `Spinner` (shrike)
- Context message: "Deleting campaign..."
- Cancellable: No

**Success State**:
- Component: `Toast` (shrike)
- Type: Success (green)
- Message: "'[Campaign Name]' deleted successfully"
- Duration: 5 seconds
- Position: Bottom-left

**Error Handling**:
- API Error:
  - Component: `Toast` (error type)
  - Message: "Failed to delete campaign. Please try again or contact support."
  - Duration: Persist until dismissed
  - Action link: "Retry" -> retry deletion

**Validation**:
- Campaign name input:
  - Required: Yes
  - Rule: Exact match (case-insensitive)
  - Error (on delete click if no match): "Please type the campaign name exactly as shown"
  - Real-time feedback: Delete button disabled until match

**Mobile Considerations**:
- Context menu -> Bottom sheet (slide up from bottom)
- Confirmation modal -> Full-screen modal
- Touch targets: All buttons >=44px x 44px

---

### Related Components
- `ContextMenu` - `/shrike/packages/components/src/ContextMenu/`
- `ConfirmModal` - `/shrike/packages/components/src/Modal/ConfirmModal/`
- `Toast` - `/shrike/packages/components/src/Toast/`
- `Spinner` - `/shrike/packages/components/src/Spinner/`

### Open Questions
- Should we send email confirmation after campaign deletion?
- Should we allow bulk deletion with same confirmation pattern?
```

---

## Appendix A: Component File Paths

### Shrike Components
Base path: `/shrike/packages/components/src/`

| Component | Path |
|-----------|------|
| FullScreenModal | `/FullScreenModal/` |
| Toast | `/Toast/` |
| NotificationV2 | `/NotificationV2/` |
| Steps | `/Steps/` |
| StepSection | `/StepSection/` |
| ProgressBar | `/ProgressBar/` |
| DetailedProgressBar | `/DetailedProgressBar/` |
| Spinner | `/Spinner/` |
| Skeleton | `/Skeleton/` |
| FormElement | `/FormElement/` |
| ErrorBoundary | `/ErrorBoundary/` |
| Modal | `/Modal/` |
| ConfirmModal | `/Modal/ConfirmModal/` |
| ArchiveModal | `/Modal/ArchiveModal/` |
| Tooltip | `/Tooltip/` |
| Breadcrumbs | `/Breadcrumbs/` |
| Tabs | `/Tabs/` |
| Tab | `/Tab/` |
| Table | `/Table/` |
| CardV2 | `/CardV2/` |
| Badge | `/Badge/` |
| Pill | `/Pill/` |
| Collapse | `/Collapse/` |
| CollapsibleCard | `/CollapsibleCard/` |
| Drawer | `/Drawer/` |
| ContextMenu | `/ContextMenu/` |
| Menu | `/Menu/` |
| ActionBar | `/ActionBar/` |
| Input | `/Input/` |
| EmailInput | `/EmailInput/` |
| PasswordInput | `/PasswordInput/` |
| NumberInput | `/NumberInput/` |
| Textarea | `/Textarea/` |
| Checkbox | `/Checkbox/` |
| Radios | `/Radios/` |
| Select | `/Select/` |
| DatePicker | `/DatePicker/` |
| TimeRange | `/TimeRange/` |
| ColorPicker | `/ColorPicker/` |
| FileUpload | `/FileUpload/` |
| Button | `/Button/` |
| Confetti | `/Confetti/` |

### Golden Goose Components
Base path: `/golden-goose/packages/viewer/src/components/`

| Component | Path |
|-----------|------|
| SuccessView | `/SuccessView/` |
| ErrorAlert | `/ErrorAlert/` |
| FormSkeleton | `/FormSkeleton/` |
| Skeleton | `/Skeleton/` |
| Accordion | `/Accordion/` |
| RevealableDrawer | `/RevealableDrawer/` |

### Onboarding Components
Base path: `/shrike/packages/extender/src/App/OnboardingPage/`

| Component | Path |
|-----------|------|
| OnboardingPage | `/OnboardingPage.tsx` |
| Milestones | `/Milestones/Milestones.tsx` |
| Milestone | `/Milestones/Milestone.tsx` |
| MilestonePage | `/MilestonePage/MilestonePage.tsx` |
| MilestoneTasks | `/MilestonePage/MilestoneTasks/MilestoneTasks.tsx` |
| MilestoneTask | `/MilestonePage/MilestoneTask/MilestoneTask.tsx` |

---

## Appendix B: Quick Reference Chart

| If User Story Involves... | Use This Component | Section Reference |
|----------------------------|-------------------|-------------------|
| Completing a major workflow | FullScreenModal + Confetti | 1.1 |
| Saving settings | Inline Success Banner | 1.2 |
| Background process finishes | Toast Notification | 1.3 |
| 3-7 sequential steps | Steps + StepSection | 2.1 |
| Loading >2 seconds | Spinner + context message | 2.2 |
| Initial page load | Skeleton | 2.3 |
| Invalid form input | FormElement (inline validation) | 3.1 |
| Multiple form errors | Form-level error summary | 3.2 |
| Page fails to load | ErrorBoundary (page error) | 3.3 |
| No data exists yet | Empty State (first-time) | 3.4 |
| Deleting something | ConfirmModal (severity-based) | 4.1 |
| Unsaved changes | Unsaved changes modal/auto-save | 4.2 |
| Approaching plan limit | Limit warning banner | 4.3 |
| Any form input | FormElement wrapper | 5.1 |
| File upload | FileUpload | 5.3 |
| Date/time selection | DatePicker + TimeRange | 5.4 |
| Hierarchical navigation | Breadcrumbs | 6.1 |
| Multiple views of entity | Tabs | 6.2 |
| Row/card actions | ContextMenu | 6.3 |
| First-time setup task | Onboarding task | 7.1 |
| Complex field explanation | Tooltip | 7.2 |
| Page-level help | Inline help panel | 7.3 |
| List of data | Table | 8.1 |
| Summary/preview | CardV2 | 8.2 |
| Status indicator | Badge | 8.3 |
| Mobile collapsible content | Collapse/Accordion | 9.2 |

---

## Document Maintenance

**Review Frequency**: Quarterly or when major component changes occur

**Update Triggers**:
- New component added to library
- Component behavior significantly changed
- New usability pattern identified
- User feedback indicates pattern confusion

**Owner**: VP Product (Abhay Khurana)

**Contributors**: Product Design (Andy Weir), Product Management Team

---

**Last Updated**: 2026-01-21
**Version**: 1.0
**Next Review**: 2026-04-21
