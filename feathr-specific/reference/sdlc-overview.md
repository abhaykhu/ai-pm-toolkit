---
audience: Product Managers, Product Designers, Engineering Leadership
when_to_use: Understanding feature delivery process, determining approval requirements, planning timelines
related_docs: prd-quality-guide.md, team-directory.md
last_updated: 2026-01-23
---

# Software Development Lifecycle (SDLC)

Feathr's SDLC guides product development from initial evaluation through ongoing maintenance. Each phase has specific Key Actors, deliverables, and approval requirements.

## Quick Reference

The SDLC has 14 phases spanning pre-development (scoping, design), development (building, testing), and post-development (deployment, monitoring). Product Managers are primarily involved in phases 1-5 (Evaluation through Ready for Development) and phases 11-12 (Release Planning and QA/IFV). The process is iterative—work can be kicked back to previous phases if deliverables are incomplete.

---

## Pre-Development Phases

### 1. Product Evaluation
- **Key Actors**: VP Product, Senior Director of Engineering
- **Purpose**: Assess feature value, customer need, and business impact
- **Deliverables**: Product Evaluation issue with problem/solution, customer research, business case, high-level feature scoping

### 2. User Scoping
- **Key Actors**: Product Managers
- **Purpose**: Break down features into detailed user stories with acceptance criteria (the "what" and "why" from user perspective)
- **Deliverables**: Design-ready feature issues with detailed epics, features, and user stories

### 3. Early Prototyping
- **Key Actors**: Product Designers, Product Managers, VP Product, Senior Director of Engineering
- **Purpose**: Validate concepts with low-fidelity prototypes before full design investment
- **Deliverables**: Low-fidelity prototypes/wireframes, documented feedback, refined requirements

### 4. Active Design
- **Key Actors**: Product Designers, Product Managers, VP Product, Senior Director of Engineering
- **Purpose**: Create high-fidelity Figma designs with detailed interactions
- **Deliverables**: High-fidelity Figma designs with interaction specs, design system components, implementation annotations

### 5. Ready for Development
- **Key Actors**: Product Designers, Product Managers, VP Product, Senior Director of Engineering
- **Purpose**: Final review and validation before development handoff
- **Deliverables**:
  - Final GitHub tickets with complete acceptance criteria and Figma links
  - Figma pages/sections marked "Ready for Dev" (unmarked sections should be ignored by developers)
  - Feature Promotion Issue (in-product visibility strategy)
  - Feature Measurement Issue (metrics/measurement requirements)

### 6. Technical Evaluation
- **Key Actors**: Senior Director of Engineering, Associate Director of Platform Engineering, Principal Engineers
- **Purpose**: Assess feasibility and identify technical limitations/constraints before costly development phases
- **Deliverables**: Technical evaluation notes, Data Protection Impact Assessment (if needed)

### 7. Discovery and Developer Scoping
- **Key Actors**: Principal Engineers, Senior Engineers, Product Managers, Product Designers
- **Purpose**: Break work into end-to-end feature increments completable in 1-2 sprints, with frontend and backend synchronized
- **Deliverables**:
  - End-to-end feature increments in logical sequence
  - Correlated frontend/backend tasks
  - QA testing plan and test scenarios for each increment
  - Technical research documentation (when applicable)

### 8. Sprint Planning
- **Key Actors**: VP Product, Senior Director of Engineering, Associate Directors (Platform, QA, Product Engineering), Product Managers, Software Engineers
- **Purpose**: Define exactly what work will be completed during the 2-week sprint
- **Deliverables**:
  - Sprint Plan with defined Sprint Goal
  - Success criteria for Sprint Goal
  - Selected end-to-end increments with individual assignments
  - Stretch goals (if primary work finishes early)

---

## Development Phases

### 9. Active Development
- **Key Actors**: Software Engineers
- **Purpose**: Write code to fulfill sprint plan requirements
- **Deliverables**: Completed work submitted as GitHub Pull Request

### 10. Test, Polish, Review
- **Key Actors**: Software Engineers, Associate Director of QA, Associate Director of Platform Engineering
- **Purpose**: Peer review for completeness and quality
- **Deliverables**: Pull Requests with at least 2 approvals

---

## Post-Development Phases

### 11. Test and Release Planning
- **Key Actors**: VP Product, Senior Director of Engineering, Associate Directors (Platform, QA, Product Engineering), Product Managers, Software Engineers
- **Purpose**: Review completed sprint work, merge to staging environment
- **Deliverables**: Completed sprint work merged and deployed to staging for QA testing

### 12. QA and Issue Fix Validation (IFV)
- **Key Actors**: VP Product, Product Managers, Associate Directors (QA, Product Engineering), Software Engineers
- **Purpose**: Test and categorize issues; resolve all blockers before production
- **Deliverables**:
  - QA issues documented in Testlio and GitHub
  - Issues categorized by priority
  - All release blockers resolved

### 13. Deployment
- **Key Actors**: VP Product, Senior Director of Engineering, Associate Directors (Platform, QA, Product Engineering), Product Managers, Software Engineers
- **Purpose**: Deploy tested staging code to production
- **Deliverables**:
  - Code deployed to production servers
  - Internal and external communications completed
  - Migration scripts run (if required)

### 14. Complete, In Monitoring
- **Key Actors**: Support Engineers, Support Representatives, Software Engineers
- **Purpose**: Ongoing monitoring and maintenance for product lifetime
- **Deliverables**: Bug remediation and maintenance for lifetime of feature

---

## Critical Processes

### Kickback and Iteration Process
- Key Actors at each phase review and approve deliverables before work advances
- Subsequent phase Key Actors have authority to reject incomplete/unclear work and kick back to previous phase
- SDLC is iterative—not all work advances on first attempt

### Mid-Sprint Issue Escalation Process
- Issues discovered mid-sprint (missed dependencies, blockers, scope clarifications) require expedited approval
- Escalate immediately to Sprint Planning Key Actors for assessment
- **Approved**: Added to active sprint with updated scope documentation
- **Deferred**: Documented and added to Discovery phase for next sprint

### Hotfix Process
- Unplanned code changes for critical production issues
- **Qualifies if**: Impacts production users (data loss, security vulnerability, complete feature failure), cannot wait for next sprint, narrow scope
- **Requirements**: Sprint Planning Key Actors approval, expedited Technical Evaluation, code review and testing
- All stakeholders notified upon deployment

---

## PM Role by Phase

| Phase | PM Involvement | Key Deliverables |
|-------|----------------|------------------|
| 1. Product Evaluation | Lead | Product Evaluation issue |
| 2. User Scoping | Lead | Epics, Features, User Stories |
| 3. Early Prototyping | Collaborate | Feedback, refinements |
| 4. Active Design | Review | Design feedback |
| 5. Ready for Development | Approve | Final sign-off |
| 6. Technical Evaluation | Consult | Answer questions |
| 7. Discovery & Dev Scoping | Collaborate | Clarify requirements |
| 8. Sprint Planning | Participate | Sprint goal alignment |
| 9-10. Development | Monitor | Available for questions |
| 11. Release Planning | Lead | Staging review |
| 12. QA/IFV | Lead | Issue triage |
| 13. Deployment | Approve | Launch communications |
| 14. Monitoring | Monitor | Bug prioritization |

---

## Version History

- **2026-01-23**: Extracted from main CLAUDE.md, added frontmatter
