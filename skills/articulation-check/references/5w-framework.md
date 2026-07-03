# 5W Framework — 詳細定義

## 1. WHAT (Clarity of Action)
**Question**: Is it clear what is being done/proposed?

Check for:
- Input → Process → Output clarity
- Concrete transformation descriptions
- Specific vs. vague statements

**Gap indicators**:
- "We propose a method to..." without saying what the method does
- "The system handles..." without describing how
- Missing definitions of key terms

**Improvement template**:
```
[Component] takes [input] and produces [output] by [process].
```

## 2. WHY (Justification of Choices)
**Question**: Is the reasoning behind choices explained?

Check for:
- Alternative comparison (why X instead of Y?)
- Selection criteria
- Logical derivation of decisions

**Gap indicators**:
- "We use X" without explaining why not Y, Z
- Assertions without supporting logic
- Missing rationale for design decisions

**Improvement template**:
```
We chose [X] over [Y] because [criteria]. While [Y] offers [advantage],
[X] better suits our needs due to [specific reason].
```

## 3. HOW (Mechanism Explanation)
**Question**: Is the mechanism/proof adequately explained?

Check for:
- Proof or evidence for claims
- Step-by-step mechanism
- Citations for non-obvious claims

**Gap indicators**:
- Claims without proof or citation
- "It is known that..." without reference
- Complex logic without walkthrough

**Improvement template**:
```
This works by [mechanism]. Specifically, [step 1], then [step 2],
resulting in [outcome]. See [reference] for details.
```

## 4. WHEN (Validity Conditions)
**Question**: Are preconditions and applicability clear?

Check for:
- Stated assumptions
- Required conditions for validity
- Scope of applicability

**Gap indicators**:
- Universal claims without stated limits
- Missing "assuming that..."
- Unclear when the approach applies

**Improvement template**:
```
This approach is effective when [condition]. It assumes [prerequisite].
For cases where [exception], consider [alternative] instead.
```

## 5. LIMITS (Boundaries & Tradeoffs)
**Question**: Are limitations honestly acknowledged?

Check for:
- Known failure cases
- Performance tradeoffs
- Computational/resource costs

**Gap indicators**:
- No limitation section
- Overly optimistic claims
- Missing discussion of edge cases

**Improvement template**:
```
Current limitations include [limit 1] and [limit 2]. This approach
does not handle [edge case]. Future work should address [gap].
```
