# Configuration Reference

Quick reference for where configuration values are stored and how to update them.

---

## Configuration Files

### `CLAUDE.md` (Main Configuration)

**Location:** Root of your project

**Contains:**
- Company name, product name, target customers
- Platform capabilities list
- Product/pricing tiers
- Key terminology table
- Repository configuration
- Skill invocation rules
- GitHub integration settings
- PRD quality standards

**When to edit:**
- Add new features to platform capabilities
- Update pricing tiers
- Add company-specific terminology
- Change repository names

### `docs/reference/team-directory.md` (Team Members)

**Contains:**
- Team member names, roles, GitHub usernames
- Assignment guidelines

**When to edit:**
- Team member joins or leaves
- Update GitHub usernames
- Change assignment rules

### `docs/reference/` (Reference Documentation)

**Contains:**
- `prd-quality-guide.md` - Quality standards and examples
- `workflow-integration.md` - Platform integration patterns
- `sdlc-overview.md` - Development lifecycle
- `ui-patterns.md` - Common UI patterns

**When to edit:**
- Add company-specific examples
- Document new workflow patterns
- Update SDLC process

---

## Quick Updates

### Add a Platform Capability

**File:** `CLAUDE.md`
**Section:** "Platform Capabilities" (around line 40)

```markdown
**Platform Capabilities:**
- Email marketing
- Landing pages
- Analytics
- [Add your new feature here]
```

### Add a Pricing Tier

**File:** `CLAUDE.md`
**Section:** "Product Tiers" (around line 50)

```markdown
**Product Tiers:**
- Free
- Pro ($49/mo)
- Enterprise (custom)
- [Add your new tier here]
```

### Add Terminology

**File:** `CLAUDE.md`
**Section:** "Key Terminology" (around line 560)

```markdown
| Term | Definition |
|------|------------|
| Existing Term | Existing definition |
| New Term | Your new definition |
```

### Add a Team Member

**File:** `docs/reference/team-directory.md`
**Section:** "Team Members" (top of file)

```markdown
Alice Johnson | VP Product | alicejohnson
Bob Smith | Lead Designer | bobsmith
[Your Name | Your Role | yourusername]
```

### Update Company Name

**Files to update:**
1. `CLAUDE.md` - Company name section (line ~15)
2. All files in `docs/reference/` - Will have company name from installation

Use find/replace:
```bash
# From your project root
grep -rl "Old Company Name" . | xargs sed -i '' 's/Old Company Name/New Company Name/g'
```

---

## Configuration Checklist

Use this checklist to ensure your configuration is complete:

### Essential (Required for good PRD output)

- [ ] Company name populated in CLAUDE.md
- [ ] Product name populated in CLAUDE.md
- [ ] Target customers defined in CLAUDE.md
- [ ] Platform capabilities list (at least 3-5 items) in CLAUDE.md
- [ ] At least 2 team members in team-directory.md
- [ ] Repository names configured in CLAUDE.md

### Recommended (Improves context quality)

- [ ] Product tiers listed in CLAUDE.md
- [ ] Key terminology table populated (5-10 terms) in CLAUDE.md
- [ ] SDLC overview customized in docs/reference/sdlc-overview.md
- [ ] Assignment guidelines updated in team-directory.md

### Optional (Nice to have)

- [ ] Company-specific examples in prd-quality-guide.md
- [ ] UI patterns documented in ui-patterns.md
- [ ] GitHub issue templates customized in docs/templates/

---

## File Locations Summary

```
your-project/
├── CLAUDE.md                              ← Main configuration
├── docs/
│   ├── reference/
│   │   ├── team-directory.md             ← Team members
│   │   ├── prd-quality-guide.md          ← Quality standards
│   │   ├── workflow-integration.md       ← Integration patterns
│   │   ├── sdlc-overview.md              ← Dev process
│   │   └── ui-patterns.md                ← UI patterns
│   └── templates/                         ← GitHub issue templates
└── .claude/skills/                        ← AI skills (don't edit)
```

---

## Getting Help

**Question:** Where do I update [specific value]?

**Answer:** Check the "Quick Updates" section above, or:
1. Search in CLAUDE.md first (most config is here)
2. Check docs/reference/team-directory.md for team info
3. Check docs/reference/ for process/pattern documentation

**Question:** How do I know if my configuration is complete?

**Answer:** Use the "Configuration Checklist" above. All "Essential" items should be checked.

**Question:** Can I change values after installation?

**Answer:** Yes! All configuration files are plain markdown. Edit them directly.

---

*For detailed usage instructions, see [TOOLKIT-GUIDE.md](TOOLKIT-GUIDE.md)*
