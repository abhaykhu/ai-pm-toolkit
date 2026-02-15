# Usability Guidelines Reference

UX best practices for PRD usability reviews. Referenced during Feature and Epic PRD scoping.

## Information Architecture
- Group related actions and information together
- Use clear, consistent labeling — match the user's mental model, not internal terminology
- Provide clear navigation and wayfinding — users should always know where they are
- Limit choices when possible — too many options cause decision paralysis
- Use progressive disclosure — show the essential first, details on demand

## Form Design
- Label every field clearly; use placeholder text for examples, not labels
- Group related fields logically; break long forms into steps
- Use appropriate input types (date pickers, dropdowns, toggles vs. checkboxes)
- Show inline validation as the user types, not only on submit
- Pre-fill fields with sensible defaults when possible
- Mark required fields; don't make optional fields look required

## Error Handling
- Write error messages that explain what went wrong AND how to fix it
- Show errors next to the field that caused them, not just at the top
- Don't clear the form on error — preserve the user's input
- Use warning states for recoverable issues, error states for blockers
- Provide a path forward: retry, contact support, try alternative

## Empty States
- Never show a blank screen — always explain what goes here and how to start
- First-time empty states should guide the user to their first action
- Include a clear call-to-action button in empty states
- Consider showing example data or templates to reduce blank-page anxiety

## Loading & Async States
- Show loading indicators for any operation over 300ms
- Use skeleton screens for content loading, spinners for actions
- Provide progress indicators for long operations (upload, export, processing)
- Allow cancellation of long-running operations when possible
- Show clear error states with retry options when operations fail

## Progressive Disclosure
- Start with the most common/important options visible
- Use "Advanced" sections, expandable panels, or modals for less-common options
- Don't hide critical information — only hide truly optional or advanced settings
- Provide contextual help (tooltips, info icons) for complex fields

## Accessibility Essentials
- All interactive elements must be keyboard-accessible (Tab, Enter, Escape)
- Provide visible focus indicators
- Use sufficient color contrast (WCAG AA minimum: 4.5:1 for text)
- Don't rely on color alone to convey information — add icons, text, or patterns
- Add meaningful alt text to images; use aria-labels for icon-only buttons
- Ensure screen readers can navigate the page logically
- Support text resizing up to 200% without breaking layout

## Mobile & Responsive Design
- Touch targets minimum 44x44px
- Avoid hover-dependent interactions on mobile
- Stack layouts vertically on small screens
- Consider thumb zones for primary actions (bottom of screen on mobile)
- Test with on-screen keyboard visible — don't let it cover form fields

## Common Anti-Patterns to Avoid
- **Mystery meat navigation**: icons without labels, unclear clickable areas
- **Confirmation fatigue**: "Are you sure?" for every action — reserve for destructive/irreversible actions only
- **Data loss on navigation**: losing unsaved work when the user navigates away without warning
- **Infinite scrolling without position awareness**: no way to know where you are or return to a position
- **Modal abuse**: using modals for content that should be a page, or stacking modals
- **Disabled buttons without explanation**: grayed-out actions with no indication of why or how to enable them
- **Silent failures**: operations that fail without any feedback to the user
