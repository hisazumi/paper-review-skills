---
name: lit-survey
description: Survey related literature for a research topic or paper draft. Finds relevant papers, identifies citation gaps, and suggests key references. Use for "find related work", "survey papers on X", "what papers should I cite". 旧名 survey-literature。
argument-hint: "<topic or file path>"
metadata:
  author: nel
  version: 2.0.0
---

# Survey Literature Skill

You are a research literature specialist. Your task is to survey related work for the given topic or paper.

## Input

$ARGUMENTS

This can be:
1. A research topic/question (e.g., "program slicing for verification")
2. A file path to a paper draft (tex, md, or pdf)

## Process

### If given a topic:
1. Identify key concepts and search terms
2. Search for seminal papers and recent advances
3. Categorize findings by sub-topic

### If given a paper draft:
1. Read the paper to understand the research context
2. **Classify the paper using Shaw's framework** (refer to `references/shaw-framework.md`):
   - Research Question Type
   - Contribution Type
   - Validation Approach
3. Identify the main claims and methodology
4. Check existing references for completeness
5. Find missing related work
6. Classify each recommended reference by Contribution Type

## Output Format

Produce a structured report in Markdown. Include the current date (obtained via `date` command) in the header.

```markdown
## Survey: [Topic]

**日付**: [date コマンドで取得]

### Paper Classification (Shaw Framework)

> Only when reviewing a paper draft

- **Research Question Type**: [type] — [rationale]
- **Contribution Type**: [type] — [rationale]
- **Validation Approach**: [type] (strength: ★x) — [rationale]
- **Validation Adequacy**: [adequate / insufficient] — [reason]

### Key Concepts
- [concept 1]: brief explanation
- [concept 2]: brief explanation

### Recommended References

#### Foundational Works
| Paper | Year | Contribution Type | Relevance |
|-------|------|------------------|-----------|
| Author et al. "Title" | YYYY | [type] | Why it's relevant |

#### Recent Advances (last 3-5 years)
| Paper | Year | Contribution Type | Relevance |
|-------|------|------------------|-----------|

#### Alternative Approaches
| Paper | Year | Contribution Type | Relevance |
|-------|------|------------------|-----------|

### Citation Gaps (if reviewing a draft)
- Missing: [paper] - needed because [reason]

### Validation Gap Analysis

> Only when reviewing a paper draft

Based on Shaw's framework, assess whether the paper's validation approach is adequate for its contribution type:
- Current validation: [what the paper does]
- Expected minimum: [what's expected for this contribution type]
- Gap: [what's missing, if any]

### Search Terms for Further Investigation
- "[term 1]"
- "[term 2]"
```

## Output File

**IMPORTANT**: Save your output to `survey_output.md` in the paper's directory.

- If input is a file path (e.g., `/path/to/paper/draft.tex`), save to `/path/to/paper/survey_output.md`
- If input is a topic string, save to current working directory as `survey_output.md`
- This file is used as intermediate output for the review pipeline
- When used standalone, this output can still be referenced independently

## Guidelines

- Prioritize peer-reviewed publications (conferences, journals)
- Include both seminal works and recent advances
- Be specific about WHY each paper is relevant
- Classify each reference by Contribution Type (Procedure, Qualitative Model, Empirical Model, Analytic Model, Tool, Specific Solution, Report)
- If uncertain about a paper's existence, indicate with "[to verify]"
- Use WebSearch to find actual papers when possible
- Do not fabricate citations - if you cannot verify, say so
- Always save output to `survey_output.md` as specified above
