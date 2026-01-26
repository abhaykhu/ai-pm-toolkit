---
audience: Product managers writing PRDs
when_to_use: Designing user flows, referencing common UI patterns
related_docs: usability-components.md
last_updated: PLACEHOLDER_DATE
---

# UI Patterns Guide

Common UI patterns to reference in PRDs for consistent user experiences.

**Customize this document** to reflect your product's established patterns.

---

## Navigation Patterns

### Primary Navigation
**Usage:** Top-level app navigation

**Pattern:**
- Persistent sidebar/header with main sections
- Current section highlighted
- Common actions easily accessible

**PRD Reference:**
```
Add "Reports" to primary navigation between "Campaigns" and "Settings"
```

---

### Breadcrumbs
**Usage:** Show hierarchical location, allow quick navigation up

**Pattern:**
- Home > Section > Subsection > Current Page
- Each level clickable except current
- Display at top of page content

**PRD Reference:**
```
Display breadcrumb: Campaigns > [Campaign Name] > Settings
```

---

## Data Display Patterns

### Tables
**Usage:** Display lists of items with multiple attributes

**Pattern:**
- Sortable columns (click header)
- Filterable
- Row actions (hover reveals, or overflow menu)
- Pagination or infinite scroll

**PRD Reference:**
```
Display campaigns in table with columns: Name, Status, Start Date, Budget, Actions
- Sortable by all columns
- Filter by status
- Row actions: Edit, Duplicate, Archive
```

---

### Cards
**Usage:** Display discrete items with preview information

**Pattern:**
- Visual hierarchy (title, description, metadata)
- Click card to view details
- Actions on hover or always visible

**PRD Reference:**
```
Display templates as cards in grid:
- Template thumbnail
- Template name
- Last modified date
- "Use Template" button
```

---

## Form Patterns

### Multi-Step Forms
**Usage:** Complex data entry split into logical steps

**Pattern:**
- Progress indicator showing steps
- "Back" and "Continue" navigation
- Save draft functionality
- Validation at each step

**PRD Reference:**
```
Campaign creation flow:
- Step 1: Basic Info (name, goal)
- Step 2: Audience (targeting)
- Step 3: Creative (ad content)
- Step 4: Budget & Schedule
- Step 5: Review & Launch
```

---

### Inline Editing
**Usage:** Edit data without leaving current view

**Pattern:**
- Click to edit (show input field)
- Save on blur or Enter key
- Cancel on Escape
- Show loading state while saving

**PRD Reference:**
```
Campaign name inline editable:
- Click name to edit
- Auto-save on blur
- Show spinner while saving
```

---

## Feedback Patterns

### Empty States
**Usage:** First-time user experience, no data yet

**Pattern:**
- Illustration or icon
- Explanation of what will appear here
- Clear CTA to add first item
- Optional: Link to help docs

**PRD Reference:**
```
Empty state for campaigns list:
- Icon: Campaign illustration
- Heading: "No campaigns yet"
- Description: "Create your first campaign to start reaching supporters"
- CTA: "Create Campaign" button
- Help link: "Learn about campaigns"
```

---

### Loading States
**Usage:** Async operations, data fetching

**Pattern:**
- Skeleton loaders (preferred for content)
- Spinners (for actions)
- Maintain layout to prevent jumping
- Show within 100ms of action

**PRD Reference:**
```
While loading dashboard:
- Show skeleton cards in grid
- Maintain layout spacing
- Replace with actual content when loaded
```

---

## Action Patterns

### Bulk Actions
**Usage:** Perform action on multiple items

**Pattern:**
- Checkbox to select items
- "Select all" option
- Action bar appears when items selected
- Show count of selected items
- Confirmation for destructive actions

**PRD Reference:**
```
Bulk archive campaigns:
- Checkbox on each campaign row
- "Select All" checkbox in header
- When selected, show action bar with "Archive" button
- Confirm before archiving: "Archive 5 campaigns?"
```

---

### Undo/Redo
**Usage:** Allow reverting recent actions

**Pattern:**
- Toast with "Undo" link after destructive action
- 5-10 second window to undo
- Clear feedback about what can be undone

**PRD Reference:**
```
After archiving campaign:
- Show toast: "Campaign archived" with "Undo" link
- 10 second window to undo
- If undone, restore campaign and show "Campaign restored"
```

---

## Search & Filter Patterns

### Search
**Usage:** Find specific items quickly

**Pattern:**
- Persistent search box
- Search as you type (debounced)
- Clear search button (X)
- Show "No results" state

**PRD Reference:**
```
Search campaigns:
- Search box in page header
- Search by name, description
- Live results as user types (300ms debounce)
- Show "No campaigns match '[query]'" if empty
```

---

### Filters
**Usage:** Narrow down results by criteria

**Pattern:**
- Filter controls above/beside content
- Show active filters clearly
- "Clear all" to reset
- Combine filters (AND logic typical)

**PRD Reference:**
```
Filter campaigns:
- Status: Active, Paused, Completed (multi-select)
- Date range picker
- Created by: User dropdown
- Show active filters as chips
- "Clear filters" link
```

---

## Customization Notes

**TODO:** Add your product-specific patterns here
- What navigation pattern do you use?
- How do you handle bulk actions?
- What's your empty state style?
- Any unique patterns specific to your domain?

---

*Last updated: PLACEHOLDER_DATE*
