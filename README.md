# Paper Review Skills for Claude Code

A collection of Claude Code skills for reviewing academic papers and theses.
Four user-facing skills cover every stage of writing, from outline to post-review.

論文レビュー用の Claude Code スキル集。
執筆の各段階に対応する 4 つのスキルで、アウトラインから修正対応まで一貫してカバーします。

---

## Which skill do I use? / どのスキルを使う？

Choose by **where you are in the writing process**:

執筆の**どの段階にいるか**で選んでください。

```
 Writing Stage                    Skill
 ─────────────────────────────────────────────────────

 1. Outline / Early Draft         /check-articulation
    (構成段階・初稿)                 Detect missing explanations
                                    with 5W analysis
                 │
                 ▼
 2. Draft Complete                /review
    (だいたい書けた)                 Full auto-review: detects
                                    thesis vs. paper, runs
                                    the right pipeline
                 │
                 ▼
 3. Before Submission             /format-check
    (提出直前)                       Format & style check
                                    (LaTeX / Word)
                 │
                 ▼
 4. After Review / Re-review      /review-tracker
    (修正後・再レビュー)             Merge multiple reviews,
                                    deduplicate, track status
```

---

## User-Facing Skills / ユーザー向けスキル

### 1. `/check-articulation` — Detect Missing Explanations / 説明不足の検出

**When**: Outline to early draft stage. You want to find logical gaps before polishing prose.

**What it does**: Applies a 5W framework (What, Why, How, When, Limits) to find places where the author knows something but hasn't written it down. Returns gap analysis with concrete, copy-paste-ready improvement text.

**いつ**: 構成段階〜初稿。論理の抜け漏れを文章推敲の前に見つけたいとき。

```bash
/check-articulation path/to/document.md
/check-articulation paper.tex --section "Chapter 3"
/check-articulation paper.tex --focus why
/check-articulation paper.tex --check-only        # Detection only, no suggestions
```

| Option | Description |
|--------|-------------|
| `--section <name>` | Focus on a specific section |
| `--focus <aspect>` | Prioritize one of: what, why, how, when, limits |
| `--check-only` | Gap detection only (skip improvement suggestions) |

Supports: `.tex`, `.docx`, `.md`, `.pdf`, `.txt`

---

### 2. `/review` — Full Auto-Review / 論文の全自動レビュー

**When**: Your draft is mostly complete and you want a comprehensive review.

**What it does**: Automatically detects whether the input is a **thesis** or a **research paper**, then runs the appropriate review pipeline with parallel execution.

**いつ**: 原稿がおおむね完成し、包括的なレビューが欲しいとき。

```bash
/review path/to/thesis.tex
/review paper.pdf --type paper                # Override auto-detection
/review thesis.docx --deadline tomorrow       # Format-priority mode
/review thesis.tex --feedback prev_review.md  # Avoid duplicate findings
/review paper.tex --quick                     # Abbreviated review
```

| Option | Description |
|--------|-------------|
| `--type thesis\|paper` | Override auto-detection |
| `--deadline tomorrow\|week\|none` | Adjust priority (thesis path only) |
| `--feedback <path>` | Existing feedback to avoid duplicates |
| `--quick` | Abbreviated mode |
| `--keep-intermediate` | Keep intermediate output files |

**Internal pipeline (thesis path)**:
```
Phase 1 (parallel):  /format-check + /thesis-review
Phase 2 (sequential): /review-tracker → review_tracking.md
```

**Internal pipeline (paper path)**:
```
Phase 1 (parallel):  /survey-literature + /review-analyze
Phase 2 (sequential): /review-shepherd → REVIEW.md
```

Supports: `.tex`, `.docx`, `.pdf`, `.md`

---

### 3. `/format-check` — Format & Style Check / 体裁チェック

**When**: Right before submission. You want to catch formatting issues, typos, and inconsistencies.

**What it does**: Checks formatting, punctuation consistency, figure/table numbering, cross-references, bibliography style, and more. Works with both LaTeX and Word.

**いつ**: 提出直前。体裁の不備や表記ゆれを網羅的に洗い出したいとき。

```bash
/format-check path/to/thesis.tex
/format-check thesis.docx
/format-check path/to/dir/                     # Check all tex/docx in directory
/format-check thesis.tex --terms terms.txt     # Custom terminology list
```

| Option | Description |
|--------|-------------|
| `--terms <file>` | Custom terminology list for consistency checking |

**Check items include**:
- Punctuation consistency, title style, figure/table numbering
- Cross-reference integrity (label/ref for LaTeX, manual refs for Word)
- Bibliography format, citation style
- Section numbering, heading levels
- Layout checks for Word (alignment, indentation, page breaks)

Supports: `.tex`, `.docx`

---

### 4. `/review-tracker` — Merge & Track Reviews / レビュー統合・追跡

**When**: After receiving reviews. You have multiple rounds of feedback and need a single, prioritized checklist.

**What it does**: Merges multiple review files, deduplicates findings, assigns priority, and checks resolution status against the current manuscript.

**いつ**: レビュー後の修正対応時。複数回のフィードバックを統合し、優先度順のチェックリストが欲しいとき。

```bash
/review-tracker review1.md review2.md --source thesis.tex
/review-tracker feedback_v1.md feedback_v2.md --output tracking.md
```

| Option | Description |
|--------|-------------|
| `--source <path>` | Current manuscript (enables auto status detection) |
| `--output <path>` | Output file path (default: `review_tracking.md`) |

Also works for code reviews, design reviews, and other document reviews.

---

## Advanced: Internal Skills / 内部スキル

These four skills are used internally by `/review`. They can also be invoked standalone.

以下の 4 スキルは `/review` が内部で使用する部品です。単体でも使用できます。

| Skill | Purpose | Used by |
|-------|---------|---------|
| `/review-analyze` | Strict critical analysis (reviewer mode) | `/review` (paper path, Phase 1) |
| `/review-shepherd` | Transform analysis into constructive feedback | `/review` (paper path, Phase 2) |
| `/survey-literature` | Find related papers, identify citation gaps | `/review` (paper path, Phase 1) |
| `/thesis-review` | Two-part thesis review (format + content) | `/review` (thesis path, Phase 1) |

### Standalone usage

```bash
/review-analyze path/to/paper.pdf
/review-shepherd paper.tex --analysis analysis.md --survey survey.md
/survey-literature "program slicing for verification"
/thesis-review thesis.tex --deadline tomorrow --feedback prev.md
```

---

## Installation

### Prerequisites

- [Claude Code](https://claude.ai/code) installed and configured

### Steps

```bash
git clone https://github.com/nel/paper-review-skills.git
cd paper-review-skills
./install.sh
```

The installer copies all skills to `~/.claude/skills/` and asks before overwriting existing ones.

---

## Supported Formats

| Format | /check-articulation | /review | /format-check | /review-tracker |
|--------|:---:|:---:|:---:|:---:|
| LaTeX (`.tex`) | Yes | Yes | Yes | Yes |
| Word (`.docx`) | Yes | Yes | Yes | Yes |
| PDF (`.pdf`) | Yes | Yes | -- | Yes |
| Markdown (`.md`) | Yes | Yes | -- | Yes |
| Plain text (`.txt`) | Yes | -- | -- | -- |

---

## License

MIT License - See [LICENSE](LICENSE) for details.

## Author

nel
