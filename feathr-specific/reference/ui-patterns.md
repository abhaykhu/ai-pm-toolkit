# UI Pattern Decision Trees

This document provides standardized patterns for common UI interactions across the Feathr platform. These patterns ensure consistency, reduce cognitive load for users, and speed up development.

## Creation Flow Patterns

### Decision Tree: Which Creation Pattern to Use?

```
How many fields/steps are required?
|
+-- 1-2 simple fields
|   -> Use: Single-step modal (size: default)
|      Examples: API keys, email addresses, simple forms
|
+-- 2-4 contextual fields
|   -> Use: Multi-step modal (fixed size: lg)
|      Examples: Campaigns, flights, segments
|      Rule: Modal size NEVER changes between steps
|
+-- 4-7 complex steps OR requires significant context
    -> Use: Full-page wizard with Steps component
       Examples: Domain configuration, CRM integrations, onboarding

```

### Add Button Behavior

```
Does creation require context from current page?
|
+-- YES (e.g., needs parent project ID, existing data)
|   -> Open modal
|
+-- NO, but is quick creation (1-2 fields)
|   -> Open modal -> On success: Toast -> Navigate to edit page
|
+-- NO, and requires multi-step wizard
    -> Navigate to dedicated page
```

### Modal Sizing Rules

**CRITICAL: Modal size must remain fixed throughout multi-step flows**

- `sm` (400px): Confirmations, simple alerts
- `default` (600px): Single-step creation, 1-2 fields
- `lg` (800px): Multi-step creation, 2-4 fields
- `xl` (1200px): Complex forms with side-by-side layouts
- Full-page: Wizards with 4+ steps

**Anti-pattern:** Changing modal size between steps (causes layout jank)

## Save Patterns

### Decision Tree: Auto-save vs Explicit Save

```
What type of data is being changed?
|
+-- Single toggle/boolean
|   -> Auto-save immediately + Toast notification
|      Example: Enable/disable feature flag
|
+-- Multi-field form (non-critical data)
|   -> Explicit Save button + Toast on success
|      Example: Profile settings, campaign details
|
+-- Critical/financial data
    -> Explicit Save button + Confirmation modal
       Example: Billing info, payment settings, destructive changes
```

### Save Button Placement

- **Forms**: Bottom-right of form, sticky on scroll
- **Modals**: Footer, right-aligned
- **Full-page wizards**: Step navigation includes "Save & Continue"

## Validation Display

### Decision Tree: Where to Show Validation Errors

```
What scope is the validation error?
|
+-- Single field validation
|   -> Use: FormElement inline error prop
|      Display: Below field, red text with icon
|
+-- Form-level validation (multiple related fields)
|   -> Use: Alert component (type='danger') at top of form
|      Display: List all errors with field references
|
+-- API/network errors
|   -> Use: Toast notification (type='danger')
|      Display: Non-blocking, auto-dismiss or dismissible
|
+-- Contextual warnings (not errors)
    -> Use: Alert component (type='warning' or 'info')
       Display: Above relevant section, persistent until resolved
```

### Validation Timing

- **On blur**: Field-level validation for individual fields
- **On submit**: Form-level validation before API call
- **Real-time**: Character count, format requirements (email, phone)
- **Post-API**: Server-side validation errors

## Confirmation Modals

### Severity-Based Patterns

Use `ConfirmModal` component with severity levels:

```typescript
// Critical destructive actions (delete, permanent removal)
<ConfirmModal
  severity="danger"
  actionText="Delete"
  requireConfirmation={true}  // User must type confirmation phrase
  confirmationPhrase="DELETE"
>
  This will permanently delete 15 campaigns. This action cannot be undone.
</ConfirmModal>

// Warning actions (disable, archive, significant change)
<ConfirmModal
  severity="warning"
  actionText="Disable"
>
  Disabling this integration will pause all data syncing.
</ConfirmModal>

// Informational confirmations (no risk)
<ConfirmModal
  severity="info"
  actionText="Continue"
>
  You're about to leave this page. Your changes have been saved.
</ConfirmModal>
```

### When to Use Confirmation Modals

- Destructive actions (delete, remove, disable)
- Actions that affect multiple items
- Changes to critical/financial data
- Actions that cannot be undone
- **Don't use for**: Simple navigation (use browser back button)
- **Don't use for**: Cancelable actions (use undo/toast instead)
- **Don't use for**: Auto-save scenarios (no confirmation needed)

## Empty States

### Standard Empty State Pattern

Use `EmptyState` component with template variants:

```typescript
<EmptyState
  label="No campaigns yet"
  description="Create your first campaign to start reaching supporters."
  action={<Button onClick={handleCreate}>Create Campaign</Button>}
/>
```

### Empty State Variants

**First-time user (no data created):**
- Label: "No {entities} yet"
- Description: Action guidance + value proposition
- CTA: Create button

**Filtered view (data exists but filtered out):**
- Label: "No {entities} match your filters"
- Description: "Try adjusting your filters or search terms"
- CTA: Clear filters button

**Archival/completion state:**
- Label: "All {entities} completed"
- Description: Celebration message
- CTA: Optional "View archived" link

**Permission restricted:**
- Label: "No access to {entities}"
- Description: Permission explanation + who to contact
- CTA: None (or "Request access" if applicable)

## Table Patterns

### Unified Table Component Usage

Use `SmartTable` wrapper that automatically detects `collection` vs `items`:

```typescript
// Preferred: SmartTable detects prop type
<SmartTable
  data={campaigns}  // Works with both collection and items array
  columns={columns}
  onRowClick={handleRowClick}
/>

// Legacy: Direct Table usage (being phased out)
<Table collection={campaigns} />  // Legacy pattern
<Table items={campaigns} />       // Legacy pattern
```

### Table Action Patterns

**Row actions:**
- Primary action: Entire row clickable -> Navigate to detail page
- Secondary actions: Kebab menu (3-dot) at row end
- Bulk actions: Checkbox column + toolbar above table

**Table toolbar:**
- Left: Bulk actions (appear when rows selected)
- Center: Search/filters
- Right: Add button, view options (list/grid), export

## Loading States

### Skeleton vs Spinner

```
Is the layout known before data loads?
|
+-- YES (e.g., table, card grid)
|   -> Use: Skeleton loaders matching final layout
|
+-- NO (e.g., dynamic content, unknown structure)
    -> Use: Centered spinner with optional loading text
```

### Skeleton Guidelines

- Match dimensions of final content
- Show correct number of skeleton items (not just 3 generic ones)
- Maintain layout structure (sidebar, content, footer)
- Use subtle animation (shimmer, pulse)

## Success Feedback

### Component Selection by Context

Reference `/docs/usability-component-usage-guide.md` Section 3 for complete guidance.

**Quick reference:**

- **FullScreenModal**: Workflow completion, onboarding milestones, major achievements
- **Banner**: Persistent status, important announcements, feature discovery
- **Toast**: Operation confirmations, background task completion, transient feedback

## Anti-Patterns to Avoid

### Don't Do This

1. **Changing modal size between steps** -> Creates layout jank
2. **Generic empty states** ("No data") -> Provide context and action
3. **Confirmation for every action** -> Reserve for destructive/critical
4. **Auto-save without feedback** -> Show toast on success
5. **Validation errors in toast** -> Use inline/form-level errors
6. **Multiple confirmation modals in sequence** -> Combine into single modal
7. **Loading spinner on every click** -> Use optimistic UI when possible
8. **Inconsistent button order in modals** -> Always Cancel (left) / Action (right)

### Do This Instead

1. **Fix modal size throughout flow** -> Set size at step 1, maintain
2. **Contextual empty states with CTAs** -> Guide user to next action
3. **Confirm only destructive actions** -> Use undo for reversible changes
4. **Auto-save with toast feedback** -> "Changes saved automatically"
5. **Inline validation on blur** -> Immediate, contextual feedback
6. **Single comprehensive confirmation** -> List all consequences
7. **Skeleton loaders for known layouts** -> Maintain perceived performance
8. **Standard modal button order** -> Cancel always on left

## Implementation Checklist

When implementing new features, verify:

- [ ] Creation flow matches decision tree pattern
- [ ] Modal size is fixed throughout multi-step flows
- [ ] Save pattern appropriate for data type/criticality
- [ ] Validation errors shown at correct scope (field/form/toast)
- [ ] Confirmation modals use correct severity level
- [ ] Empty states include label, description, and CTA
- [ ] Loading states use skeleton or spinner appropriately
- [ ] Success feedback uses correct component (FullScreenModal/Banner/Toast)
- [ ] Table actions follow row/bulk/toolbar pattern
- [ ] No anti-patterns present in implementation

---

*This document is a living standard. Update when new patterns emerge or existing patterns prove problematic.*
