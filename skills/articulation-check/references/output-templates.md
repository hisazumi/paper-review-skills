# Output Templates

## Default Mode (Detection + Improvement)

```markdown
# Articulation Analysis: [Document Title]

## Executive Summary
- Total gaps identified: [N]
- Critical: [n] | Major: [n] | Minor: [n]
- Most affected aspect: [WHAT/WHY/HOW/WHEN/LIMITS]
- [1-2 sentences on overall articulation quality and main areas for improvement]

## Gap Details with Improvement Suggestions

### WHAT Gaps (Clarity of Action)

#### [W1] [Brief description]
- **Location**: Section X.Y, paragraph Z
- **Quote**: "[exact quote from document]"
- **Gap**: [What's unclear or missing]
- **Severity**: Critical/Major/Minor
- **Suggested addition**:
  > [Concrete text to add, ready to copy-paste.
  > Written in the document's voice and style.]
- **Rationale**: [Why this addition helps readers]

#### [W2] ...

### WHY Gaps (Justification of Choices)

#### [Y1] [Brief description]
- **Location**: ...
- **Quote**: "..."
- **Gap**: ...
- **Severity**: ...
- **Suggested addition**:
  > ...
- **Rationale**: ...

### HOW Gaps (Mechanism Explanation)

#### [H1] ...

### WHEN Gaps (Validity Conditions)

#### [N1] ...

### LIMITS Gaps (Boundaries & Tradeoffs)

#### [L1] ...

## Cross-Cutting Issues

[Any patterns that appear across multiple sections]

## Recommended Structure Changes

If the document would benefit from structural reorganization:

| Current | Suggested | Reason |
|---------|-----------|--------|
| [Current structure] | [New structure] | [Benefit] |

**Suggested new sections** (if applicable):
- [ ] [Section name]: [Purpose and suggested content outline]

## Priority Action List

**Must have (Critical)**
- [ ] [Action 1 with location reference]
- [ ] [Action 2]

**High priority (Major)**
- [ ] [Action 3]

**Medium priority (Minor)**
- [ ] [Action 4]

## Strengths to Preserve

Before revising, note these well-articulated elements:
- [Strength 1]: [Why it works well]
- [Strength 2]: [Why it works well]

## Statistics

| Aspect | Critical | Major | Minor | Total |
|--------|----------|-------|-------|-------|
| WHAT   |          |       |       |       |
| WHY    |          |       |       |       |
| HOW    |          |       |       |       |
| WHEN   |          |       |       |       |
| LIMITS |          |       |       |       |
| **Total** |       |       |       |       |

## Encouragement

[Constructive closing message acknowledging the document's potential
and encouraging the author to iterate]
```

## Check-Only Mode (`--check-only`)

When `--check-only` is specified, output gap detection without improvement suggestions:

```markdown
# Articulation Gap Analysis: [Document Title]

## Summary
- Total gaps identified: [N]
- Critical: [n] | Major: [n] | Minor: [n]
- Most affected aspect: [WHAT/WHY/HOW/WHEN/LIMITS]

## Gap Details

### WHAT Gaps (Clarity of Action)

#### [W1] [Brief description]
- **Location**: Section X.Y, paragraph Z
- **Quote**: "[exact quote from document]"
- **Gap**: [What's unclear or missing]
- **Severity**: Critical/Major/Minor
- **Suggested question to answer**: [Question the author should address]

#### [W2] ...

### WHY Gaps (Justification of Choices)
...

### HOW Gaps (Mechanism Explanation)
...

### WHEN Gaps (Validity Conditions)
...

### LIMITS Gaps (Boundaries & Tradeoffs)
...

## Cross-Cutting Issues
[Any patterns that appear across multiple sections]

## Priority Order
1. [Most critical gap - brief description]
2. [Second priority]
3. [Third priority]

## Statistics

| Aspect | Critical | Major | Minor | Total |
|--------|----------|-------|-------|-------|
| WHAT   |          |       |       |       |
| WHY    |          |       |       |       |
| HOW    |          |       |       |       |
| WHEN   |          |       |       |       |
| LIMITS |          |       |       |       |
| **Total** |       |       |       |       |
```
