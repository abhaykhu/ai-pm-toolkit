# PM Toolkit Onboarding Guide

**Welcome to the AI PM Toolkit!**

This guide provides a sequential path to mastering the AI-powered product management tools.

---

## What This Toolkit Does

The PM Toolkit integrates with Claude Code to help you:

- **Write PRDs faster** - Guided workflow with quality checks (30-60 min vs 3-4 hours)
- **Research competitors** - Automated competitive analysis with comparison matrices
- **Analyze feedback** - Synthesize customer feedback data in minutes
- **Validate quality** - Automated PRD review against quality standards
- **Create GitHub issues** - Template-based issue creation with proper formatting

**Key benefit:** Spend less time on documentation mechanics, more time on strategic thinking and stakeholder collaboration.

---

## Getting Started

### Task 1: Setup & Overview

**Time:** 30-45 minutes

**Objectives:**
- Verify toolkit is installed correctly
- Understand what tools are available
- Know where to find documentation

**Steps:**

1. **Verify Claude Code is running**
   ```bash
   # Open terminal in your project directory
   cd /path/to/your/project
   claude
   ```

   If Claude Code isn't installed, download from [claude.ai/download](https://claude.ai/download)

2. **Test skill availability**
   ```
   # Try typing slash commands to see autocomplete
   /prd
   /analyze-feedback
   /research-competitors
   /qa-prd
   ```

3. **Skim TOOLKIT-GUIDE.md** (15 min, don't memorize)
   - Focus on "Available Skills" section
   - Note the 4 main commands
   - Bookmark the reference docs section for later

4. **Quick scan reference docs** (10 min)
   - `docs/reference/prd-quality-guide.md` - Quality standards
   - `docs/reference/usability-components.md` - UI component specs for your design system
   - `docs/reference/team-directory.md` - Team members

**Outcome:** You know what tools exist and can navigate documentation.

---

### Task 2: Write a Practice PRD

**Time:** 60-90 minutes

**Objective:** Complete the full PRD workflow with a simple feature to understand the process.

**Choose a small feature for practice:**
- Something you already understand well
- Not mission-critical (this is practice)
- Ideally 1-2 user stories max
- Examples: "Add export button to dashboard", "Display last updated timestamp"

**Walkthrough:**

1. **Invoke the skill**
   ```
   /prd
   ```

2. **Phase 1: Discovery**
   - Describe your feature in 2-3 sentences
   - Choose template (probably "Feature")

3. **Phase 2: Research** (skip for first attempt)
   - You'll explore research tools in Task 4

4. **Phase 3: Cross-Feature Integration**
   - Claude prompts through integration areas
   - Answer what you know
   - It's OK to say "not sure" - Claude will help

5. **Phase 4: Drafting**
   - Claude generates the PRD
   - Review output structure

6. **Phase 5: Finalization**
   - Iterate if needed
   - Save to `docs/prds/your-feature-name.md`
   - Don't create GitHub issue yet (covered in Task 6)

**Expected challenges:**
- Cross-feature integration feels unfamiliar initially (normal!)
- First PRD takes 90+ min (gets much faster)

**Review with your manager:**
- Show your first PRD
- Discuss what felt awkward vs helpful

**Outcome:** You've completed the full PRD workflow and understand the phases.

---

### Task 3: Learn Quality Standards

**Time:** 45-60 minutes

**Objective:** Understand what makes a "good" PRD at your company.

**Steps:**

1. **Read prd-quality-guide.md in depth** (30 min)
   - Location: `docs/reference/prd-quality-guide.md`
   - Focus on:
     - 4 questions for problem statements
     - User story organization by workflow context
     - Cross-feature integration examples
     - Common antipatterns to avoid

2. **Try the QA agent on your practice PRD** (15 min)
   ```
   /qa-prd docs/prds/[your-practice-prd].md
   ```
   - Review the quality report
   - Note the scoring dimensions
   - Identify what your PRD did well/poorly

3. **Iterate on your practice PRD** (optional, 15 min)
   - Fix critical issues flagged by QA
   - Re-run QA to see score improve

**Outcome:** Clear understanding of quality standards and how QA scoring works.

---

### Task 4: Explore Research Tools

**Time:** 45-60 minutes

**Objective:** Learn to use competitive research and feedback analysis before writing PRDs.

**Part 1: Competitive Research** (25 min)

Pick a feature you're curious about:

1. **Invoke the skill**
   ```
   /research-competitors [feature name]
   ```

2. **Answer scope questions**
   - What aspects? (Try "UX patterns and pricing")
   - Which competitors? (Let Claude recommend 3-4)

3. **Review output**
   - Feature comparison matrix
   - UX patterns
   - Gaps and opportunities
   - Recommendations for your PRD

**Part 2: Feedback Analysis** (25 min, if configured)

If you have customer feedback tools configured (Canny, Zendesk, Gong):

1. **Invoke the skill**
   ```
   /analyze-feedback
   ```

2. **Specify parameters**
   - Time frame: Last 30 days (start small)
   - Data sources: Use what you configured during install
   - Product area: Pick one you're familiar with

3. **Review output**
   - How many requests?
   - Top themes and pain points
   - Quantified demand

**Outcome:** Comfortable using research tools to gather context before writing PRDs.

---

### Task 5: Write a Production PRD

**Time:** 90-120 minutes

**Objective:** Write a real PRD for an actual roadmap feature using the full workflow.

**Choose a feature from the roadmap:**
- Something you're assigned or planning to scope
- Medium complexity (not trivial, not an epic)

**Full workflow:**

1. **Research first** (30 min)
   - Run `/analyze-feedback` if applicable
   - Run `/research-competitors [your feature]`
   - Take notes on key findings

2. **Invoke PRD skill**
   ```
   /prd
   ```

3. **Use research in your PRD**
   - Reference customer demand in problem statement
   - Cite competitor approaches
   - Use findings to inform user stories

4. **Complete all phases thoughtfully**
   - Don't rush cross-feature integration
   - Ask clarifying questions if unsure

5. **Run QA before finalizing**
   ```
   /qa-prd
   ```
   - Review quality report
   - Fix critical and high-priority issues
   - Iterate until score ≥ 7.0

6. **Save PRD**
   - Save to `docs/prds/[feature-name].md`

**Review with your manager:**
- Present PRD for feedback
- Discuss problem statement quality
- Review integration depth

**Outcome:** A production-quality PRD ready for design handoff.

---

### Task 6: Create GitHub Issues

**Time:** 30-45 minutes

**Objective:** Learn to create properly formatted GitHub issues from PRDs.

**Steps:**

1. **Review issue templates** (15 min)
   - Location: `docs/templates/`
   - Read `epic.md`, `feature.md`, `task.md`
   - Understand when to use each

2. **Create a feature issue from your production PRD** (15 min)
   ```
   Create a feature issue from docs/prds/[your-prd-name].md
   ```

   Claude will:
   - Read your PRD
   - Use the feature.md template
   - Populate all sections
   - Create in your primary repo

3. **Review the created issue**
   - Click the GitHub URL Claude provides
   - Check formatting
   - Verify all sections populated
   - Note assignees and project placement

**Outcome:** Comfortable creating GitHub issues from PRDs.

---

## Building Proficiency

### Task 7-10: Repetition & Practice

**Time:** 2-3 hours per PRD initially, decreasing to 60-90 minutes

**Objective:** Build muscle memory and develop your personal workflow.

**For each additional PRD you write:**

1. **Full workflow every time**
   - Research → PRD → QA → Iterate → GitHub Issue
   - Don't skip steps yet (you're building habits)

2. **Track your progress**
   - Time to complete PRD
   - QA scores
   - Questions from design/engineering (should decrease)

3. **Experiment with variations**
   - Try different research approaches
   - Test different competitor sets
   - Practice different user story organizations

**Goal:** Complete 3-5 PRDs using the full workflow.

**Expected progress:**
- PRD #1: 90-120 min, score 6.0-7.0
- PRD #3: 75-90 min, score 7.0-7.5
- PRD #5: 60-75 min, score 7.5-8.0+

---

## Advanced Usage

### Task 11: Optimize Your Workflow

**Time:** Variable

**Objective:** Find shortcuts and customizations that work for you.

**Explore:**

1. **Skip research when appropriate**
   - Simple features may not need competitive research
   - Use judgment on when it adds value

2. **Reuse integration patterns**
   - Notice recurring integration needs
   - Build mental templates for common scenarios

3. **Customize your approach**
   - Some PMs prefer research-heavy upfront
   - Others iterate with design earlier
   - Find what works for your role

4. **Contribute back**
   - Found a useful pattern? Document it
   - Antipattern to avoid? Add to quality guide
   - New competitor? Add to competitive-research skill

---

## Success Milestones

**After Task 2:**
- ✅ Completed one practice PRD
- ✅ Understand the 5-phase workflow

**After Task 5:**
- ✅ Written a production PRD
- ✅ Understand quality standards
- ✅ Can use research tools

**After Task 6:**
- ✅ Can create GitHub issues from PRDs
- ✅ Understand issue templates

**After Task 10:**
- ✅ PRD completion time < 90 minutes
- ✅ QA scores consistently ≥ 7.5
- ✅ Fewer design/eng questions on your PRDs
- ✅ Full autonomy on PRD writing

---

## Common Questions

### "This feels slower than my current process"

**Response:** It will for the first 2-3 PRDs. The toolkit enforces quality standards that might feel like overhead initially, but:
- By PRD #5, you'll be faster
- Quality will be consistently higher
- Fewer design/engineering questions
- Better platform integration
- Time savings compound over the project lifecycle

### "I don't know answers to cross-feature integration questions"

**Response:** That's exactly why the prompts exist! When you don't know:
1. Say "I'm not sure" to Claude
2. Claude will help you think through it
3. Review with relevant stakeholder
4. Update PRD with findings

This process surfaces blind spots early, before design/development.

### "The QA agent is too harsh"

**Response:** The QA agent enforces your company's quality standards. If scoring low:
1. Read the specific issues flagged
2. Review the quality guide examples
3. Fix critical issues first
4. Iterate and re-run QA
5. Aim for ≥ 7.0 before design handoff

### "Should I use all four skills for every PRD?"

**Response:** Not always. Typical usage:
- `/prd` - Every PRD
- `/qa-prd` - Every PRD before design handoff
- `/research-competitors` - Complex features, new domains, inspiration
- `/analyze-feedback` - Features driven by customer requests, pain points

Use judgment on when research adds value.

---

## Getting Help

**Questions about toolkit:**
1. Check [TOOLKIT-GUIDE.md](TOOLKIT-GUIDE.md)
2. Review relevant reference doc in [reference/](reference/)
3. Ask your manager or toolkit admin

**Questions about your product:**
1. Check company-specific reference docs
2. Review example PRDs in `docs/prds/`
3. Ask relevant stakeholders

---

## Ready to Begin?

**Start with Task 1:** Verify setup and review documentation (30-45 min)

Open Claude Code and type `/prd` to explore!

---

*Last updated: $(date +%Y-%m-%d)*
