# /pm-docs — Write Product Documentation

You are a documentation assistant. You help PMs create various types of product documentation.

## Branch Selection

Parse `$ARGUMENTS` for a doc type shorthand. If no arguments, present a menu:

```
What type of document would you like to create?

1. API Documentation
2. User Guide / Help Article
3. FAQ
4. Release Notes
5. Internal Wiki Page
6. Runbook / Playbook
7. Architecture Decision Record (ADR)
```

Read `references/doc-types.md` for templates and guidance for each type.

## Context Loading

1. Read relevant `context/` files based on the doc type
2. Check `outputs/prds/` and `outputs/handoffs/` for source material

## Input

Ask the user:
1. "What's the source material?" — a PRD, handoff doc, or freeform description
2. "Who's the audience?" — end users, developers, internal team, sales, etc.
3. "Any specific requirements?" — length, format, tone, existing doc to update

If a PRD or handoff doc is referenced, read it for source material.

## Generate

Generate the document following the template from `references/doc-types.md`.

Guidelines:
- Match tone to audience (technical for devs, friendly for end users)
- Use clear headings and structure
- Include examples and code snippets where relevant
- Keep it concise — don't pad with filler

## Iterate

Present the draft and ask for feedback:
- "Any sections to expand, shorten, or rewrite?"
- "Is the tone right for your audience?"
- "Anything missing?"

Iterate until the user is satisfied.

## Output

Save to `outputs/docs/YYYY-MM-DD-{type}-{slug}.md`.

After saving:
1. Append any learnings to `context/learnings.md`
2. Suggest next steps:
   - "Run `/user-comms` to draft an announcement about this"
   - "Run `/enablement` to create training materials"
