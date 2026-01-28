---
name: review-paper
description: Complete paper review pipeline. Runs survey-literature and review-analyze in PARALLEL (Phase 1), then review-shepherd (Phase 2). Efficient parallel execution reduces total review time.
argument-hint: "<file path> [--quick] [--focus survey|logic|feedback]"
---

# Review Paper Skill (Meta-Skill)

You are orchestrating a comprehensive paper review using three specialized skills with **parallel execution** for efficiency.

## Input

$ARGUMENTS

Required: File path to the paper (tex, md, or pdf)

Options:
- `--quick`: Skip literature survey, do analysis + feedback only
- `--focus survey`: Emphasize literature survey
- `--focus logic`: Emphasize logical analysis
- `--focus feedback`: Emphasize constructive feedback

## Pipeline Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    PHASE 1 (PARALLEL)                   │
│  ┌──────────────────────┐  ┌──────────────────────┐    │
│  │  /survey-literature  │  │   /review-analyze    │    │
│  │  - Related work      │  │   - Structure/flow   │    │
│  │  - Citation gaps     │  │   - Logic gaps       │    │
│  │  - Research context  │  │   - Technical check  │    │
│  └──────────┬───────────┘  └──────────┬───────────┘    │
│             │                         │                 │
│             └───────────┬─────────────┘                 │
│                         ▼                               │
└─────────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────┐
│                    PHASE 2 (SEQUENTIAL)                 │
│           ┌───────────────────────────────┐             │
│           │     /review-shepherd          │             │
│           │  - Integrate Phase 1 results  │             │
│           │  - Transform to feedback      │             │
│           │  - Prioritize improvements    │             │
│           │  - Provide encouragement      │             │
│           └───────────────────────────────┘             │
└─────────────────────────────────────────────────────────┘
```

## Execution Instructions

### Phase 1: Parallel Analysis (Time Saving: ~50%)

**IMPORTANT**: Execute survey-literature and review-analyze IN PARALLEL. These skills analyze from independent perspectives and have no dependencies on each other.

#### Standard Mode (no --quick flag):
Run both skills simultaneously:

1. **survey-literature** (in parallel):
   - Identify the paper's research area
   - Find relevant related work
   - Check for citation gaps
   - Assess positioning in the field

2. **review-analyze** (in parallel):
   - Analyze structure and flow
   - Identify logic gaps (What/Why/How/When/Limits)
   - Check technical correctness
   - Assess research contribution

#### Quick Mode (--quick flag):
Skip survey-literature, run only review-analyze in Phase 1.

### Phase 2: Synthesis (Sequential)

After Phase 1 completes, execute review-shepherd:

3. **review-shepherd** (sequential, depends on Phase 1):
   - Integrate findings from both survey and analysis
   - Transform critical points into constructive feedback
   - Prioritize improvements (Must/Should/Nice)
   - Cross-reference: literature gaps affect novelty claims
   - End with encouragement

## Output Format

Produce a single comprehensive report:

```markdown
# Paper Review: [Title]

**Reviewed**: [Date]
**Review Type**: [Full / Quick / Focused on X]
**Execution**: Phase 1 (Parallel) + Phase 2 (Sequential)

---

## Executive Summary
[3-5 sentences: What the paper does, its main strength, and top 2-3 issues]

---

## Part 1: Literature Context
[Output from survey-literature phase]
[If --quick: "Skipped (quick mode)"]

---

## Part 2: Critical Analysis
[Output from review-analyze phase]

---

## Part 3: Recommendations
[Output from review-shepherd phase - integrating Part 1 & 2]

---

## Meta-Review

### Review Limitations
- [What perspectives might be missing]
- [What domain expertise would help]

### Confidence Assessment
- Literature survey: [High/Medium/Low] - [reason]
- Technical analysis: [High/Medium/Low] - [reason]
- Feedback quality: [High/Medium/Low] - [reason]

---

## Quick Reference: Action Items

| Priority | Action | Section | Effort |
|----------|--------|---------|--------|
| Must | [action] | X.Y | [H/M/L] |
| Should | [action] | X.Y | [H/M/L] |
| Nice | [action] | X.Y | [H/M/L] |
```

## Guidelines

- **Parallel Execution**: Always run survey-literature and review-analyze in parallel (unless --quick)
- Maintain consistency across all three phases
- Cross-reference findings (e.g., literature gaps affect novelty claims)
- Be thorough but not repetitive
- End on a constructive note
- Save the full review to a file (e.g., REVIEW.md) in the paper's directory

## Special Instructions

If the paper is incomplete (missing chapters):
- Note which sections are missing
- Review what exists
- Provide guidance for unwritten sections

If the paper is in a non-English language:
- Review in the paper's language
- Provide key terms in both languages where helpful

## Efficiency Notes

By running Phase 1 in parallel:
- **Full review**: ~50% time reduction compared to sequential execution
- **Quick review**: Already minimal (single-phase analysis)

This parallel architecture is possible because:
1. survey-literature focuses on **external context** (what others have done)
2. review-analyze focuses on **internal quality** (what this paper does)
3. Neither depends on the other's output
4. review-shepherd synthesizes both, requiring their completion first
