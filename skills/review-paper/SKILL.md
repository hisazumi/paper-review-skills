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

### Phase 1: Parallel Analysis (TRUE PARALLEL EXECUTION)

**CRITICAL**: You MUST execute survey-literature and review-analyze using **two Task tool calls in a SINGLE message**. This enables true parallel execution.

#### How to Achieve True Parallel Execution

Send ONE message containing TWO Task tool invocations:

1. First Task tool call:
   - description: "Survey literature"
   - prompt: "Run /survey-literature on [PAPER_PATH]. Save to survey_output.md in the paper directory."
   - subagent_type: "general-purpose"

2. Second Task tool call (in the SAME message):
   - description: "Analyze paper"
   - prompt: "Run /review-analyze on [PAPER_PATH]. Save to analyze_output.md in the paper directory."
   - subagent_type: "general-purpose"

**DO NOT** call them sequentially in separate messages - that defeats the purpose of parallel execution.

#### Intermediate Output Files

Phase 1 produces two intermediate files in the paper's directory:
- `survey_output.md` - Literature survey results
- `analyze_output.md` - Critical analysis results

#### Standard Mode (no --quick flag):
Run both skills simultaneously as described above.

#### Quick Mode (--quick flag):
Skip survey-literature, run only review-analyze in Phase 1.

### Phase 2: Synthesis (Sequential)

After Phase 1 completes (both Task tools return), execute review-shepherd:

3. **review-shepherd** (sequential, depends on Phase 1):
   - Read `survey_output.md` and `analyze_output.md` from paper directory
   - Integrate findings from both survey and analysis
   - Transform critical points into constructive feedback
   - Prioritize improvements (Must/Should/Nice)
   - Cross-reference: literature gaps affect novelty claims
   - Generate final `REVIEW.md`
   - Delete intermediate files (unless --keep-intermediate)

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

- **Parallel Execution**: Always run survey-literature and review-analyze using TWO Task tool calls in ONE message (unless --quick)
- **Intermediate Files**: Phase 1 outputs to `survey_output.md` and `analyze_output.md`
- **Final Output**: Phase 2 merges intermediate files into `REVIEW.md`
- **Cleanup**: Intermediate files are deleted after merge (use --keep-intermediate to retain)
- Maintain consistency across all three phases
- Cross-reference findings (e.g., literature gaps affect novelty claims)
- Be thorough but not repetitive
- End on a constructive note

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
